Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC140CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 00:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD582053B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 00:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWSSILGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392833AbfJXAXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 20:23:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33189 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392822AbfJXAXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 20:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571876598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ee2rAGX/yThhkG+QnD43az++6uLSAgXql93AY4AiqEY=;
        b=DWSSILGGLbf0brsKbpBRQg4XEH6qRJa0Rm5W0ToF3EfQLVC8t7m1qPrCJJojIgAdul7cjN
        fAW1cRE2LOmtEKaJVFPor0xNqDjHeAH5Fq2p5/G8yU1tmt+BMqjcEr5MAp6+2zxST8/aDx
        R3ZxRssYZXMlgKX9nLfno18sZwHKFhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-SPInESGLN6KujPeXClH5tQ-1; Wed, 23 Oct 2019 20:23:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01DE81005500;
        Thu, 24 Oct 2019 00:23:13 +0000 (UTC)
Received: from mail (ovpn-123-192.rdu2.redhat.com [10.10.123.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C04835D9DC;
        Thu, 24 Oct 2019 00:23:12 +0000 (UTC)
Date:   Wed, 23 Oct 2019 20:23:12 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
Message-ID: <20191024002312.GB433@redhat.com>
References: <20191012191602.45649-1-dancol@google.com>
 <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com>
 <20191023190959.GA9902@redhat.com>
 <CAKOZuetKkM=PK2QA8LdXwM8cM8qJvFu4u5bjePWai3XRnHe-pA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKOZuetKkM=PK2QA8LdXwM8cM8qJvFu4u5bjePWai3XRnHe-pA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: SPInESGLN6KujPeXClH5tQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 01:05:47PM -0700, Daniel Colascione wrote:
> This is a debate that won't get resolved here. A ton of work has gone
> into namespaces, migration, various cgroup things, and so on, and I
> don't see that work getting torn out.

This is precisely why I thought it was a good idea to support the
non-cooperative use case too even though we had no immediate use for
it.

> Sure they can. Can't we stick processes in a memcg and set a
> memory.high threshold beyond which threads in that cgroup will enter
> direct reclaim on page allocations? I'd call that throttling.

The uffd-wp solution during the throttling can resolve a wrprotect
fault in the parent for every 4k page that has been written to disk
and it'll prioritize writing to disk those userfaults that are
currently blocked. I don't see how you could reach an equivalent
optimal runtime without uffd-wp and just with memcg because the
snapshot process won't have a clue which pages are been duped by the
COWs. The uffd-wp by avoding fork will also avoid more expensive MM
switches during the snapshot.

> This issue *has* to get fixed one way or another.

Sure.

