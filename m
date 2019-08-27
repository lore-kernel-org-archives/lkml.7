Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48125C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1609D22CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nfs95Czr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfH0TwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:52:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40494 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731301AbfH0TwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xf4+OnF0wEa3ROO3titPCeOK1d6/+p+RUwuYzek+rsg=; b=Nfs95CzrSNKLbpyaH9nidLS1x
        aPUAHB8kGKxA20XV1A09rh2KQvMyv/oaXiEBZdHJk1IR7TIuWlupaweBIVkAu0Qje3RupVXOcsYUt
        YQ0z4TTV//eA2++qK05evJKx0opwKFT9Q3GnV4oXXNCGd0KdUcJZ9EqlN+noyAQFT69qFtnaTiiSP
        z2RiGVLmtQbFrv1dY9qe3ia+4meaIS8T+h8/GNKWMY6LJUAAyKB8UJcvDiljfnCkVsXESHPQvI7fr
        4kmXdXzlfyu1Vudl88dKPuSdr1N6BTUDeDko+hc8fnYrZrmBXzsxELiV2gjLa5c0uVjOitLu9FDml
        RVM0k0NKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2hVS-0007JM-GG; Tue, 27 Aug 2019 19:51:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31BDB30768B;
        Tue, 27 Aug 2019 21:51:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DFAAD20188D30; Tue, 27 Aug 2019 21:51:50 +0200 (CEST)
Message-Id: <20190827194820.378516765@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 27 Aug 2019 21:48:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -v2 0/5] Further sanitize INTEL_FAM6 naming
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of variation has crepts in; time to collapse the lot again.

I'm reposting because the version Ingo applied and partially fixed up still
generates build bot failure.


