Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B94CC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76FF20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GOK7BWKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgABVsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:48:04 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:39394 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgABVsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:48:04 -0500
Received: by mail-ot1-f44.google.com with SMTP id 77so58696372oty.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 13:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=I73AIrMg80Cx/kJxoswwBbkRTxmX9oVAH3Ck2asCG5g=;
        b=GOK7BWKwldv2kWmSG/xIPxeTtoQq1B1QyidhMnU/DL6oKYXUAVyiDAXMRq4YlZSfU6
         tlJcDOVXWr/aR2kYMvbvwKB4XbQwgLdxF17x4E+1ehAh8q6jPEcwQ9yqPfRxNvr1itOE
         wHZs4XoMMpVjTUmicH4ncH2DdlNIExLwj0jhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=I73AIrMg80Cx/kJxoswwBbkRTxmX9oVAH3Ck2asCG5g=;
        b=ApCKuG9NArJ79iZugi7s0MpJjBP1GNfcxzPatJpunK5W3CDF40RpjdyrrukQP255Ls
         /JrTi6fwcbPvMdwTlP0YFqsXRpOHkFVXDa2hhV+eu15wZ0ttTI++QCTZSCiyaYlWQdsn
         Ub4Tf+eIY8oAg73EDtMSCFxDZHV9t6UyTmrTEqwFNExRbb73dDQ6GvjdtCUT88YPQkdW
         V08CIbQ9vpjBJwEiMZGhHJSFR/EjA+u09hgOhT2Cg0jYWvokdOHSzqaY8z5LlPNifUVV
         rLzRAbWSXLU4DmpqIcs2QkLPqPAL8igaeAgsU3hlhegN9+mIz1Vq3yEEMFEkLuOMaw7G
         kKag==
X-Gm-Message-State: APjAAAXN80oUagXszC9bN7eE/AgIM+EC0uAJjMx7h41ZFttBDqpFSiXK
        vASZjA5Z+Q8fWwKTqcFseggQkUr35JU=
X-Google-Smtp-Source: APXvYqw1YbOCkmGGmIH7dgujxq5ZXD0EbZGJj1xzJunBZ6BAia5wHGZv2QR6beO91gWsho7vxR8Bqg==
X-Received: by 2002:a9d:4b05:: with SMTP id q5mr78845598otf.174.1578001683553;
        Thu, 02 Jan 2020 13:48:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w72sm17509906oie.49.2020.01.02.13.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 13:48:02 -0800 (PST)
Date:   Thu, 2 Jan 2020 13:48:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] FIELD_SIZEOF() removal for v5.5-rc5
Message-ID: <202001021346.11B0D2B5F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this last change for the sizeof_field() conversion for
v5.5-rc5. With all FIELD_SIZEOF() users now gone from both your tree and
linux-next, we can remove it and the conversion is done! :)

Thanks!

-Kees

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/sizeof_field-v5.5-rc5

for you to fetch changes up to 1f07dcc459d5f2c639f185f6e94829a0c79f2b4c:

  kernel.h: Remove unused FIELD_SIZEOF() (2019-12-30 12:01:56 -0800)

----------------------------------------------------------------
sizeof_field conversion

- Remove now unused FIELD_SIZEOF() macro (Kees Cook)

----------------------------------------------------------------
Kees Cook (1):
      kernel.h: Remove unused FIELD_SIZEOF()

 include/linux/kernel.h | 9 ---------
 1 file changed, 9 deletions(-)

-- 
Kees Cook
