Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6780CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719D02087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Clox7xbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfJ3Qry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:47:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53138 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfJ3Qry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zygts5mueFdRJmMbOPGfShgTrgo9xozW9Q5Ph5M0FH4=; b=Clox7xbMY9ZXoruc4Xyerj/A+
        vl+aW6bq4YUfUu800KGtoEObSRfZQDiia+oEA/RRDZeSLQSkeKmMaGfpcbx0UzcK87bTHuynid8ZA
        3h3E08cORTMljc0qF9vqMlsll7iADMV1xOeRH4Q183oMryIDo28z3HAj+QE7BU/7FV1m7Y2qxqwcN
        GtH/b0uyByAo4Lcov4blEQan/GTyLyrqO1D/tugp7JRmPEOwsfukPZ/ZcEndyiVgr3lkuvCaudsO9
        xHOfp7az5/JkO8LoRPfHJ+c6MjUbCublnaGHP0pDIfoOSQQone1UyRYnT27O9KmvVI+WM7uhdiV2R
        3Vt06qXcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPr8M-0002xK-7o; Wed, 30 Oct 2019 16:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A25AE3060AD;
        Wed, 30 Oct 2019 17:46:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDFDE2B444DB8; Wed, 30 Oct 2019 17:47:43 +0100 (CET)
Date:   Wed, 30 Oct 2019 17:47:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20191030164743.GU4114@hirez.programming.kicks-ass.net>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190807144305.v55fohssujsqtegb@willie-the-truck>
 <20191029190624.GB3079@worktop.programming.kicks-ass.net>
 <20191030155720.GA20713@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030155720.GA20713@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 04:57:20PM +0100, Oleg Nesterov wrote:
> On 10/29, Peter Zijlstra wrote:
> >
> > That said, I think cgroups use a variant of percpu-rwsem that wreck rss
> > on purpose and always take the slowpaths.
> 
> I forgot (never understodd) why does Android need this.
> 
> I am wondering if it makes any sense to add a config/boot or even runtime
> knob for cgroup_threadgroup_rwsem.

It isn't just Android, but Android in specific likes to move tasks
between cgroups a lot.

And moving tasks between cgroups is what requires the write-side of the
cgroup percpu-rwsem to be taken. Adding an RCU-GP to every task movement
wasn't making them happy (which I can understand).

