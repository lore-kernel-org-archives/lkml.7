Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99C7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951E42133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDTWDWPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfFXOeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:34:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37682 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbfFXOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:34:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so14183825wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d9D2kEXCsPIkGCquDsjWyHOfnVyVeC30BSwHW6sKb08=;
        b=hDTWDWPjrGB/UveU0A3qxdYyZksn4UsDLpKxijj9mG6X1s/RlMhjOrL3KYSrBb/0Hi
         Ce70U+N/TeRlZ0PdnrQWJS6TGv5JPntOVeeYCZA8hw3WqtmwcHMUfHU0Ym3yjb9Ey0JG
         W7v4waDSLd/z7imZ7xf5fq26Lf3SEb9OdfcSsuobwcLlOdjzOPBNJ1hvgqcgKnvmgJHk
         sbmMAkkg+i7vj7/sxqEiIX4whYt/uN8skjCq5iudjTPOXf1GJjgZge32RrpJ/nmxp/H7
         09/REKqecoYWySDkpY8+RaawBN9kZOwJyBVB77fPMWNWxHxLZX2cN+kZ8KZBOD9/FRHR
         N0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d9D2kEXCsPIkGCquDsjWyHOfnVyVeC30BSwHW6sKb08=;
        b=iXKvbAo90sJ3+GEtLnc/GUFVqVLSrLnYnSYqP7znpfJxjyRKUChxocvTEZQjrJ291s
         kyN5zPtV51HKjkwG9cgsjuaMusYNU1AUeP8vtX9KHo47lk2bG/il3FVDHDODpOf1hLoV
         lDLVqmYHGigQwuq1K6a7ggiY0BIclXKa2m83+1Yvm2QuwbjxJWGcxZosFffh8H2fbQVR
         +ZnKg5JDNdag6AUHPDwL3hP51s5s6Tp5+UpBdl0AcnfbIX3i3n8hvbqya49Hp00i3/5N
         pYuDjuLdA9my4yaJmbh3t/6s4KZ9Gb1fLiknx1Lc5/IYuoW2v3OHgMSX+XgvgCMPAlC3
         lhAA==
X-Gm-Message-State: APjAAAUftZr68gUmBDiei/0v8hCkrPP0EW3JQU2RlWqnQBq7MqwfYiwC
        agZ1kMORUgbTpLPX2bfDnEgZBQwW0N8=
X-Google-Smtp-Source: APXvYqyf6M5jRi32zH996X1MpIXcWx8o4+oS1/kwbXY4rYnLxrnr8e9xEvTrzmSTdJWiNp3wQiMyNA==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr18164230wrs.77.1561386853355;
        Mon, 24 Jun 2019 07:34:13 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id r12sm12131545wrt.95.2019.06.24.07.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 07:34:12 -0700 (PDT)
Date:   Mon, 24 Jun 2019 15:34:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL v2] MFD fixes for v5.2
Message-ID: <20190624143411.GI4699@dell>
References: <20190617100054.GE16364@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190617100054.GE16364@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Hopefully this is more to your liking.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-5.2-1

for you to fetch changes up to 63b2de12b7eeacfb2edbe005f5c3cff17a2a02e2:

  mfd: stmfx: Fix an endian bug in stmfx_irq_handler() (2019-06-24 15:19:31 +0100)

----------------------------------------------------------------
 - Bug Fixes
   - Resize variable to avoid uninitialised (MSB) data; stmfx
   - Fixe endian bug; stmfx

----------------------------------------------------------------
Dan Carpenter (2):
      mfd: stmfx: Uninitialized variable in stmfx_irq_handler()
      mfd: stmfx: Fix an endian bug in stmfx_irq_handler()

 drivers/mfd/stmfx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
