Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AB1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07EC214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552352478;
	bh=fkAWn9ei/vs9jGg++3SyWGaJkziScSJ+sQKSzrBQIjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=J9CF2uvmzA/c6bVoppgPTQbEHR06sW9LEFdaurVPlXsMXNHSs2kCiN8jklCrBP5Ub
	 ZIIrNuXl2TiNw84q0TvppBxT8dHpZ5E0ZMu7w/EIIAq0AOK7aTvC1I5wIzQOmne7jH
	 WsV3gbMH6XEaxaeXz0pddPEVXBhiM6G7o7tqYEkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfCLBBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:01:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfCLBBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:01:16 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC52BC2A;
        Tue, 12 Mar 2019 01:01:14 +0000 (UTC)
Date:   Mon, 11 Mar 2019 18:01:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
Message-Id: <20190311180113.c283fdbcba3df10db2c815aa@linux-foundation.org>
In-Reply-To: <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
        <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
        <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019 09:31:00 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Mar 3, 2019 at 8:47 AM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> 
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.
> >
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
> Andrew: would you be OK with this being merged in v5.1?

Yup.  We have quite a few users there.  I assume this will go via the
gpio tree?

Feel free to add Acked-by: Andrew Morton <akpm@linux-foundation.org>,
although it probably isn't worth churning the git tree to do so at this
late stage - your cvall.

