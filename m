Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13482C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D538F206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="johpd9ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfG1TVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 15:21:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33276 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfG1TVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:21:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so26864881pfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=35XJDkHPYmquro7AkIzxAIcNUJ/SNzjAcDiR5unJFak=;
        b=johpd9ftrxX+u6Pn2wj2wYYVakvR3STA1Qwc3whpHMN3hoVcKfulgTXR5jk/ZIHgDr
         ImDKEPWDMntscichEolh9CKcYW129DosM3YYbWm7Sqo0WjPqTgVW2t4U8v/lTv4Ye/ae
         QwpKqh/wdLedAr585b+36SmgxdMOfgIsXegjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=35XJDkHPYmquro7AkIzxAIcNUJ/SNzjAcDiR5unJFak=;
        b=eFZ7AmK3xLQUGKog+kLgvZw3Ny4woy2Q8aQxzkqmohqu6/Kv4xLjCND1XKCMgvievz
         Sfp+XGZG4CRLaY5hED5SE4viaz+h8qIdRzvxJRzFOtva3YsjyDyAX3hsGqgchwRl36vG
         9t0w7zjxClm0MuB9TfdeJdszQ7DYF/DmEMD6Z59K7AKSI9kKlNgERGbAV7UamltA+qo0
         IrJEd1GlTd7sxAowa4ndxI0Rccs2METPblS27YolmgBd7Wt4AIIk4pLpOEuwU+sHVRNf
         wZ4C0MycGdFaaBQRV/+4EEdGZmStsRTxBOCDW04KbrABqISPEDOXzZJYGCPKjaL24GPR
         kI/g==
X-Gm-Message-State: APjAAAXojFCp1wvk4n+95YMYJP9oRPYyRvacHiVfTOu2FACdp72WZ0PS
        wgKvLQKi41HFQraxN3CSzGBuEA==
X-Google-Smtp-Source: APXvYqzp08Z3gCBgCO2/owZpK3i9761UDMkopQWteUw75xoajm2I8TA2O0ECxegA7LfEFjSTv8jAsA==
X-Received: by 2002:aa7:9a01:: with SMTP id w1mr31842775pfj.262.1564341696545;
        Sun, 28 Jul 2019 12:21:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o128sm64766247pfb.42.2019.07.28.12.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Jul 2019 12:21:35 -0700 (PDT)
Date:   Sun, 28 Jul 2019 12:21:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] meminit fix for v5.3-rc2
Message-ID: <201907281218.F6D2C2DD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this meminit fix for v5.3-rc2. This is late in the -rc2
window because I got confused about whether I or akpm was taking this
patch. I noticed it still wasn't in -mm, so here it is. It's a small
Kconfig change that fixes a bunch of build warnings under KASAN and the
gcc-plugin-based stack auto-initialization features (which are arguably
redundant, so better to let KASAN control this).

Thanks!

-Kees

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/meminit-v5.3-rc2

for you to fetch changes up to 173e6ee21e2b3f477f07548a79c43b8d9cfbb37d:

  structleak: disable STRUCTLEAK_BYREF in combination with KASAN_STACK (2019-07-25 16:16:12 -0700)

----------------------------------------------------------------
meminit fix

- Disable gcc-based stack variable auto-init under KASAN (Arnd Bergmann)

----------------------------------------------------------------
Arnd Bergmann (1):
      structleak: disable STRUCTLEAK_BYREF in combination with KASAN_STACK

 security/Kconfig.hardening | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
Kees Cook
