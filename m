Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A353CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E930C2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7SsVN9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfJ3P5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:57:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44064 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729108AbfJ3P5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572451057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxmCKrD+1huL0UnafF7o9Ji5BC44afhsjiSZaqIxSAE=;
        b=I7SsVN9Gl7zM5T0qSgOQHhhljbktufEt814fDDed815BzIq6XFqKvxlnP5npYgwa1yd5aq
        OUHBcoZKdVcASaKTt36N/+0Ndr4oyxTS4VFW9+tqU2G81QYGlKOJnkyuxUKFHmffEaYelY
        KMy/8bSV0KIfbdUPv2TPkKlc1AP1roM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-37-W3smINPiQ0aJcgrG5ag-1; Wed, 30 Oct 2019 11:57:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92F3A800EB3;
        Wed, 30 Oct 2019 15:57:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.206.16])
        by smtp.corp.redhat.com (Postfix) with SMTP id 52D85808B;
        Wed, 30 Oct 2019 15:57:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 30 Oct 2019 16:57:34 +0100 (CET)
Date:   Wed, 30 Oct 2019 16:57:20 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20191030155720.GA20713@redhat.com>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190807144305.v55fohssujsqtegb@willie-the-truck>
 <20191029190624.GB3079@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20191029190624.GB3079@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 37-W3smINPiQ0aJcgrG5ag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29, Peter Zijlstra wrote:
>
> That said, I think cgroups use a variant of percpu-rwsem that wreck rss
> on purpose and always take the slowpaths.

I forgot (never understodd) why does Android need this.

I am wondering if it makes any sense to add a config/boot or even runtime
knob for cgroup_threadgroup_rwsem.

Oleg.

