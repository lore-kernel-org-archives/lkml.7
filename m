Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBDFC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1512925D5D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfE3QIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 12:08:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfE3QId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:08:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5044307CB5F;
        Thu, 30 May 2019 16:08:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 71FC9104B4EA;
        Thu, 30 May 2019 16:08:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 30 May 2019 18:08:32 +0200 (CEST)
Date:   Thu, 30 May 2019 18:08:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, dbueso@suse.de, axboe@kernel.dk, dave@stgolabs.net,
        e@80x24.org, jbaron@akamai.com, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, omar.kilani@gmail.com, tglx@linutronix.de,
        stable@vger.kernel.org
Subject: Re: pselect/etc semantics
Message-ID: <20190530160823.GI22536@redhat.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com>
 <87woi8rt96.fsf@xmission.com>
 <871s0grlzo.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s0grlzo.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 30 May 2019 16:08:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30, Eric W. Biederman wrote:
>
> ebiederm@xmission.com (Eric W. Biederman) writes:
>
> > Which means I believe we have a semantically valid change in behavior
> > that is causing a regression.
>
> I haven't made a survey of all of the functions yet but
> fucntions return -ENORESTARTNOHAND will never return -EINTR and are
> immune from this problem.

Hmm. handle_signal:

		case -ERESTARTNOHAND:
			regs->ax = -EINTR;
			break;

but I am not sure I understand which problem do you mean..

Oleg.

