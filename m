Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A6BCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C602087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bPqUjDxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389382AbfJ2OgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:36:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389354AbfJ2OgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q0gVh9X/7nYxxKWmI/KCgIs9TYYtfnzLB+dvCDbXPUw=; b=bPqUjDxmApPtuXn5WBKGWnY2z
        8VDEy5tDV4FprdIQYjVVTOCM1qM8TZiL4MKhSR7MJa9ZGTJA0B/BLvTinqpkyeidxSvCXdnnDJQU5
        25BY5CurPvc4hEdLjiNq1F06P+l2ezkqmMzCZfWja6eyHyo2+tfTMW1aE5AkJzNDpYgP9VyaBYwo5
        U+1utmtJaEPXAlky3yIFPQfN7n92acCn7lKmwYXF6gs8Zliv7etCKJvd/MUQIvZrenQC5wRPRFs74
        O+YO93K94JvhkJCo2gDIM8CCrIgGBXSL4/bjqh/X+Qg2N6PAf3Pg/91Ud2jRwY6wOgQLTsfknsUXg
        MD6gDw24A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPSb7-0003zn-Tt; Tue, 29 Oct 2019 14:35:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95DB5306091;
        Tue, 29 Oct 2019 15:34:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 568BB2B437E86; Tue, 29 Oct 2019 15:35:47 +0100 (CET)
Date:   Tue, 29 Oct 2019 15:35:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smpboot: reuse timer calibration
Message-ID: <20191029143547.GO4114@hirez.programming.kicks-ass.net>
References: <ebb16cf3-128d-2515-a98a-a58db0c1f963@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb16cf3-128d-2515-a98a-a58db0c1f963@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 03:19:57PM +0100, Paul Menzel wrote:
> From: Arjan van de Ven <arjan@linux.intel.com>
> Date: Wed, 11 Feb 2015 17:28:14 -0600
> 
> NO point recalibrating for known-constant tsc ...
> saves 200ms+ of boot time.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> 
> Arjan, can your Signed-off-by line be added? On what device, did you test
> this?

This patch makes no sense what so ever given the current function, also
it hard codes 0 as being the BSP.

All of this for platforms (!constant_tsc) that barely exist anymore.
