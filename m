Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDFEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3C821916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553202328;
	bh=RgZr3Tz67FmrQep7B6R37uvD9ntKHOrWFq6WiHfC1MY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=us370tnHkdqqGGsq66/cZnGiE7CsbrOwQs6XZyNbXoFWIRw/3vaB/dt8LpJYxVGhm
	 AsbI+xTncMo23toQjKJALbUUVIgrZYQTBAh1uGOxdt9ySy2ywF9R0QfhryLCvDlBbk
	 4uk44mgrT9m+MmRAYcyHOM5FaA4/Y6AKx+6eEOag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfCUVF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:05:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52108 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCUVF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:05:27 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0C79CED1;
        Thu, 21 Mar 2019 21:05:26 +0000 (UTC)
Date:   Thu, 21 Mar 2019 14:05:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     clang-built-linux@googlegroups.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] lib/string.c: implement a basic bcmp
Message-Id: <20190321140524.2888cc3c3e0726c4fdfc1b21@linux-foundation.org>
In-Reply-To: <CAKwvOdn84HNEB3u4XO-V_+c=txmDd1061G_7K0zZVS4MfF--Lg@mail.gmail.com>
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
        <20190313211335.165605-1-ndesaulniers@google.com>
        <20190320191135.e49e976a8258c8ac0bb428c9@linux-foundation.org>
        <CAKwvOdn84HNEB3u4XO-V_+c=txmDd1061G_7K0zZVS4MfF--Lg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 10:02:37 -0700 Nick Desaulniers <ndesaulniers@google.com> wrote:

> Shall I send you a cleanup removing the undefs for bcmp, memcmp,
> strcat, strcpy, and strcmp?  Of those, I only see memcmp being
> `#defined` in arch/m68k/include/asm/string.h, arch/x86/boot/string.h,
> and arch/x86/include/asm/string_32.h.
> 
> Further, I can drop some of the __GNUC__ < 4 code in
> arch/x86/include/asm/string_32.h. (grepping for __GNUC__, looks like
> there's a fair amount of code that can be cleaned up).  We should
> probably check it since Clang lies about being GCC 4.2 compatible,
> which will surely break in horrific ways at some point.\

All sounds good.  Some time, when convenient, thanks.
