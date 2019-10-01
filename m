Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA26C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7AD2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569960945;
	bh=ipnD/w+qGDTvpXCIRx63LcFtZnxlfINFxIFNuE5t218=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=i5FEXMfZS5uDXQKHWvIL6P4DDf2U6BNo5blEzNRvymLB5C0xIDIF4R+M7rVhiB4wd
	 cJ4lp89nUqQVdzQQyINhbxbAnW1Cj3yK+MwQPVzZqEj+J++bsXlCNo+t/yHv8mu4Fk
	 J0W5Te0S2h+c5jChadL2NQ8ZPoi/AZTE4wbo8KE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfJAUPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 16:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfJAUPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 16:15:44 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834412133F;
        Tue,  1 Oct 2019 20:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569960943;
        bh=ipnD/w+qGDTvpXCIRx63LcFtZnxlfINFxIFNuE5t218=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fnxwgqTwiAvbeUyEc5Uswn5shYTOpZ5SZ1Z3FezB/T005tYVtbJAJyG1PHVGEtmXF
         O3x06S51eEQ/DqORuN5xdSOyj6Rh8MW6eAyFmnMHnusuJrKdm7t5gJqezYk4MBSIwA
         UJqf8zD9vCaPDkkuqmFQmRlJ7knwR56wkTKQsHPA=
Date:   Tue, 1 Oct 2019 22:15:15 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-s390@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.4-rc1 BUILD FIX] s390: mark __cpacf_query() as
 __always_inline
In-Reply-To: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1910012214080.13160@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019, Jiri Kosina wrote:

> arch/s390/kvm/kvm-s390.c calls on several places __cpacf_query() directly, 
> which makes it impossible to meet the "i" constraint for the asm operands 
> (opcode in this case).
> 
> As we are now force-enabling CONFIG_OPTIMIZE_INLINING on all 
> architectures, this causes a build failure on s390:
> 
>    In file included from arch/s390/kvm/kvm-s390.c:44:
>    ./arch/s390/include/asm/cpacf.h: In function '__cpacf_query':
>    ./arch/s390/include/asm/cpacf.h:179:2: warning: asm operand 3 probably doesn't match constraints
>      179 |  asm volatile(
>          |  ^~~
>    ./arch/s390/include/asm/cpacf.h:179:2: error: impossible constraint in 'asm'
> 
> Mark __cpacf_query() as __always_inline in order to fix that, analogically 
> how we fixes __cpacf_check_opcode(), cpacf_query_func() and scpacf_query() 
> already.
> 
> Reported-and-tested-by: Michal Kubecek <mkubecek@suse.cz>
> Fixes: d83623c5eab2 ("s390: mark __cpacf_check_opcode() and cpacf_query_func() as __always_inline")
> Fixes: e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
> Fixes: ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Gah, due to bug in my script the sigoff doesn't match the From:, so 
whoever is potentially applying it, please ammend it with

	From: Jiri Kosina <jkosina@suse.cz>

Sorry for the noise.

-- 
Jiri Kosina
SUSE Labs

