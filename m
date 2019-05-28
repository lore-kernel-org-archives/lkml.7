Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FB7C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E56420B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfE1XkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:40:11 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:49715 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbfE1XkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:40:11 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 06BE01802F4BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 23:40:10 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 29600837F24C;
        Tue, 28 May 2019 23:40:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wind74_7597841c10f1a
X-Filterd-Recvd-Size: 1440
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 May 2019 23:40:07 +0000 (UTC)
Message-ID: <7cf0e30a7309008a81cc65e692511a1e8e6b544f.camel@perches.com>
Subject: Re: [PATCH] lib: test_overflow: Avoid taining the kernel and fix
 wrap size
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 May 2019 16:40:06 -0700
In-Reply-To: <201905281550.4E3CB258F@keescook>
References: <201905281550.4E3CB258F@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-28 at 15:51 -0700, Kees Cook wrote:
> This adds __GFP_NOWARN to the kmalloc()-portions of the overflow test to
> avoid tainting the kernel. Additionally fixes up the math on wrap size
> to be architecture and page size agnostic.
[]
> diff --git a/lib/test_overflow.c b/lib/test_overflow.c
[]
> @@ -486,16 +486,17 @@ static int __init test_overflow_shift(void)
[]
> +#define alloc_GFP		 (GFP_KERNEL | __GFP_NOWARN)
[]
> +#define alloc110(alloc, arg, sz) alloc(arg, sz, alloc_GFP | __GFP_NOWARN)

seems redundant.


