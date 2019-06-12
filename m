Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34174C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E322F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fErnmr3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfFLNGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:06:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfFLNGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vz71fAv9Dgsi5w8SWFWAKFrTsfzkrQd2BAWGvR/wWuI=; b=fErnmr3AWG76KtAlXl/YU8PcH
        TunZZicwX9oi7ZawY41vyXVmfR5Lsrdam4Nt5CesogYlNN+9bAAyLvoBe87Iv4BSAUSZs48pp8lPw
        YRadvSKrf2MpcW17rAP6mbqKeVAf+gmWrtNDb08tCFvZdQHhydJ/7ezrvMEF0+EedtOvwx1/HlNPI
        p7eAEKvubGtQgWXHLoaa2lCEtyO0tR9rPwhmLu7e8h+HFwCddEahLEpZHNW3LGknuER4plSS9imiN
        OBHEf86p9woXaqAyyCdj96h1Vjb80lIzCNprL9JpN8Dt4DEr55DhlPjlVm4v7aLXygmMW8zqUk9KT
        +2OKIaRaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb2xP-0004XY-0m; Wed, 12 Jun 2019 13:06:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89BD620259522; Wed, 12 Jun 2019 13:48:36 +0200 (CEST)
Date:   Wed, 12 Jun 2019 13:48:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/xen: disable nosmt in Xen guests
Message-ID: <20190612114836.GI3436@hirez.programming.kicks-ass.net>
References: <20190612101228.23898-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612101228.23898-1-jgross@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:12:28PM +0200, Juergen Gross wrote:
> When running as a Xen guest selecting "nosmt" either via command line
> or implicitly via default settings makes no sense, as the guest has no
> clue about the real system topology it is running on. With Xen it is
> the hypervisor's job to ensure the proper bug mitigations are active
> regarding smt settings.
> 
> So when running as a Xen guest set cpu_smt_control to "not supported"
> in order to avoid disabling random vcpus.

If it doesn't make sense; then the topology should not expose SMT
threads and the knob will not have any effect.

If you expose SMT topology info to the guest, then you get what you ask
for.
