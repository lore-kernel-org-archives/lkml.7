Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2E3C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 18:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7539B20665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 18:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfFVSBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 14:01:23 -0400
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:43104 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726286AbfFVSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 14:01:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 26E81100E86C2;
        Sat, 22 Jun 2019 18:01:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: patch81_45b8c85498e5e
X-Filterd-Recvd-Size: 2250
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Jun 2019 18:01:19 +0000 (UTC)
Message-ID: <7ec724a310a710e6415320ff530daba0e1d30505.camel@perches.com>
Subject: Re: [tip:x86/cpu] x86/cpu: Create Zhaoxin processors architecture
 support file
From:   Joe Perches <joe@perches.com>
To:     HerryYang@zhaoxin.com, CooperYan@zhaoxin.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, lenb@kernel.org,
        gregkh@linuxfoundation.org, QiyuanWang@zhaoxin.com,
        mingo@kernel.org, DavidWang@zhaoxin.com, tglx@linutronix.de,
        rjw@rjwysocki.net, TonyWWang-oc@zhaoxin.com,
        linux-tip-commits@vger.kernel.org
Date:   Sat, 22 Jun 2019 11:01:17 -0700
In-Reply-To: <tip-761fdd5e3327db6c646a09bab5ad48cd42680cd2@git.kernel.org>
References: <01042674b2f741b2aed1f797359bdffb@zhaoxin.com>
         <tip-761fdd5e3327db6c646a09bab5ad48cd42680cd2@git.kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-06-22 at 03:16 -0700, tip-bot for Tony W Wang-oc wrote:
> Commit-ID:  761fdd5e3327db6c646a09bab5ad48cd42680cd2
> Gitweb:     https://git.kernel.org/tip/761fdd5e3327db6c646a09bab5ad48cd42680cd2
> Author:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> AuthorDate: Tue, 18 Jun 2019 08:37:05 +0000
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Sat, 22 Jun 2019 11:45:57 +0200
> 
> x86/cpu: Create Zhaoxin processors architecture support file
> 
[]
> diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
[]
> +static void init_zhaoxin_cap(struct cpuinfo_x86 *c)
> +{
> +	u32  lo, hi;
> +
> +	/* Test for Extended Feature Flags presence */
> +	if (cpuid_eax(0xC0000000) >= 0xC0000001) {
> +		u32 tmp = cpuid_edx(0xC0000001);
> +
> +		/* Enable ACE unit, if present and disabled */
> +		if ((tmp & (ACE_PRESENT | ACE_ENABLED)) == ACE_PRESENT) {

trivia:

Perhaps this is more intelligible for humans to read
and it deduplicates the comment as:

		if ((tmp & ACE_PRESENT) && !(tmp & ACE_ENABLED))

The compiler produces the same object code.


