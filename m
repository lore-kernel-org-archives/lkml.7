Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBF9C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB42120833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDNsJSEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfFQKA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:00:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35256 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfFQKA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:00:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so9260888wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 03:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=kgNrzQ82w525RSgH0vUvYbpvSwP6OY398m1IW4hr0QQ=;
        b=kDNsJSEGyKe0mDOgYYB07hzWUlQE/myjjIQlUsLLhJZZ+Q+Z6irrLvT2Jgzu2Gra8F
         WWUamNroRFCRJdDW4X31dTfYtZyPn+2Pq/7c7B4GTSZKAVog88U+ZUBSO2c9EdYNg04m
         IjElE/kV+rdjtZKfaQqQYxdJRpJjQtO5z6rN4J0tfGqiltxuGGsrflUSPimO0zrtWnLW
         UYUsu8P4JtXberzsyLPow1dLRLn1kbXaytGv50Xcp2clGvDuPPXvHUw0QKJ0o3bGghbe
         +sRW+IP6Wuhl6nKComv/ks8N35oS52QybG8u/ourrmZkoB/W1Ouy3xYZtyRP2jPBFVq/
         bkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=kgNrzQ82w525RSgH0vUvYbpvSwP6OY398m1IW4hr0QQ=;
        b=LxRGSvUfiayL5yed1B6opvMVpdG9laslMmhFgHGrAfR3P1fqaNoWRS3sCvJkOVSeX7
         cWd5NYBEK1aekAAuteCfnmlftcKtOpnfZ9Uh7YURxpkTx9PmUzXVf7mHzTN4BbyL9SiI
         pqilQkgNCDr14sdYtRoi8hwdUNTospk7mbYMjegzdpK1lFWtjiyVZvg3N2AfmgN4Qe0a
         0QWRCfPKR0l4CW/98PCBwDKpscJk1bhTsn6hiSMneewxhBh1nerozGGDs0Kq/ZQv8huB
         RZCvS4Q53ANrjyn8xoeydyuELAW5CyoJA1HZhY5uHhn8ecHkvJJV3oA4iqyRCdPF3fNE
         +L4g==
X-Gm-Message-State: APjAAAX+gUCTdTWNDYy0b1yd8GofxyVxeupisJ6apCBIkF2c5IfYo22j
        UGx/HRU7Pnh5oOUMFeZC0bWBefLFLlM=
X-Google-Smtp-Source: APXvYqxww1/+GwtMMKqiKbloUKGySFC1ygJ9W8+49/FJiAgHheDh/5t+CKqw2A9W39Q/CZcXv/GB8w==
X-Received: by 2002:adf:e843:: with SMTP id d3mr31753919wrn.249.1560765656441;
        Mon, 17 Jun 2019 03:00:56 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id 72sm3290275wrk.22.2019.06.17.03.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 03:00:55 -0700 (PDT)
Date:   Mon, 17 Jun 2019 11:00:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD fixes for v5.2
Message-ID: <20190617100054.GE16364@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Enjoy!

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.2

for you to fetch changes up to cd49b84d61b2dfc0360c76d9e6be49f5116ba1a5:

  mfd: stmfx: Uninitialized variable in stmfx_irq_handler() (2019-06-17 10:51:15 +0100)

----------------------------------------------------------------
 - Bug Fixes
   - Resize variable to avoid uninitialised (MSB) data

----------------------------------------------------------------
Dan Carpenter (1):
      mfd: stmfx: Uninitialized variable in stmfx_irq_handler()

 drivers/mfd/stmfx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
