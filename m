Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0054C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 19:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56B1205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 19:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RXHwLzeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfGLTGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 15:06:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36680 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfGLTGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 15:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UqgOWolirnCBEsyXVWQ2fOdoQVQ8hvpvnXJbQKMux3o=; b=RXHwLzeNIqmDjrorcLSQiAkd/
        MUyTNzpAtlmP3XOZPMG/9cuvZT3fk71qTAQkMBMu8DBb1GOL8ivodXsj9Pt8IiM/kZ96KvDpTZjwz
        17r4zad9PKi2F9zqIK6ucOLmVegd/xcPRvcqF20wupKYw+jZXH1ZmOIXT8XEVkMMIaJ9aYLBm8DHd
        tM4G+AW5wJjB9MjVM9GB3ZJ7WHHq0ew69CWEi8qFGPNUYHfBb7crHR1YOovT0vXC2Tn+lFUpMKhTF
        P6ee4Qt7cVbAz+2p3WYU2GNhlt9XGIdlP2tdn7gLJH2PcRy4OrhWuAKvM3WgUGF/AZPd0bcmRI52p
        pvWDraWCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hm0sB-0000J7-4g; Fri, 12 Jul 2019 19:06:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D164201D16FC; Fri, 12 Jul 2019 21:06:20 +0200 (CEST)
Date:   Fri, 12 Jul 2019 21:06:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, kvm@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        liran.alon@oracle.com, jwadams@google.com, graf@amazon.de,
        rppt@linux.vnet.ibm.com, Paul Turner <pjt@google.com>
Subject: Re: [RFC v2 00/27] Kernel Address Space Isolation
Message-ID: <20190712190620.GX3419@hirez.programming.kicks-ass.net>
References: <1562855138-19507-1-git-send-email-alexandre.chartre@oracle.com>
 <5cab2a0e-1034-8748-fcbe-a17cf4fa2cd4@intel.com>
 <alpine.DEB.2.21.1907120911160.11639@nanos.tec.linutronix.de>
 <61d5851e-a8bf-e25c-e673-b71c8b83042c@oracle.com>
 <20190712125059.GP3419@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907121459180.1788@nanos.tec.linutronix.de>
 <3ca70237-bf8e-57d9-bed5-bc2329d17177@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca70237-bf8e-57d9-bed5-bc2329d17177@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 06:37:47PM +0200, Alexandre Chartre wrote:
> On 7/12/19 5:16 PM, Thomas Gleixner wrote:

> > Right. If we decide to expose more parts of the kernel mappings then that's
> > just adding more stuff to the existing user (PTI) map mechanics.
> 
> If we expose more parts of the kernel mapping by adding them to the existing
> user (PTI) map, then we only control the mapping of kernel sensitive data but
> we don't control user mapping (with ASI, we exclude all user mappings).
> 
> How would you control the mapping of userland sensitive data and exclude them
> from the user map? Would you have the application explicitly identify sensitive
> data (like Andy suggested with a /dev/xpfo device)?

To what purpose do you want to exclude userspace from the kernel
mapping; that is, what are you mitigating against with that?
