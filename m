Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD79C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB6C20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJiEIlsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfDYXV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:21:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36309 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDYXV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:21:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id l6so1193211ljb.3;
        Thu, 25 Apr 2019 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7rrY47Uj8WYnLCNUcJpVq4cZmGavzxLDvKXvAM8PhaM=;
        b=XJiEIlsSpoz3qh2w29WozJhKDvewSKGx7OULpphv8wxzEk4U+t8X6ynXTU17YaddJ/
         7Py5ES0RGf8PrweBdG/Eh/rJ92gcctLvwPLX3N/hbcyS7dBqUj+h+BjA5fRTdKeK4POa
         rSCVwrXV7vW0C21gphl7fLqkIydYwEnFO47sBNAPxZa0pH/PBxBDIoqJHeazsk0dVjHo
         a94II5+aKd020HT7Fwm6CcHtE94pIF8t5FyMNr0bAS/B8PNCSmWXIGWvjCZiELKEXQN4
         bVJ/2YpIuvbgE5eMrpc+a7l5vxDq6P8e4+DR+IoZfJea/adRttCbmWppMgYTGaJoBz0P
         j8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7rrY47Uj8WYnLCNUcJpVq4cZmGavzxLDvKXvAM8PhaM=;
        b=IiHiTghHugLVcqYRRf+JZccvWnjLe49JfyTVQuvCn/0VXemh2oSzaryJe3IBAoVyRm
         GXsASWmDHxAqe/mYAdsG08Gf6g4uuzKscFfKvUelZwy0QpxaCpdehK7pKy3MheYBRsUr
         K6JoD9QI2pBA2QTp/Da42jwCg0GXErqj/kRN7Rz5hLQq35IYceelhqhsLWW7oAiUrSCF
         pMHQk9hf1LaKICptZ0jXEfvyjcwiCMtyARmTOIe6KbwNcfa9W6pHoEZcAe61EHCd4Btj
         GjIcSwxAWogXuv2V0UmNI/GrpWxE1XeinNR68i2fhlbY3J5hi4p8Xv04cgKpH0flTViO
         nwTA==
X-Gm-Message-State: APjAAAWT+uZqg3kcQ5GZuO+EdaKGQU74PjQzlo+Kg5Gy2zBywloFQnD3
        acz2/ZqSGingFodVMKbqt/tVPwKR
X-Google-Smtp-Source: APXvYqyQfinepkKfme+meUbUUB+P5l115Mty9h5NDGuo/Yqtcbv1hRA+46hKYFgK98GeVXU1bY2cZQ==
X-Received: by 2002:a2e:8446:: with SMTP id u6mr3137697ljh.71.1556234484382;
        Thu, 25 Apr 2019 16:21:24 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id j9sm4919609lja.92.2019.04.25.16.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 16:21:23 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] i2c-mux-gpio: Split plat- and dt-specific code up
Date:   Fri, 26 Apr 2019 02:20:25 +0300
Message-Id: <20190425232028.9333-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main idea of this patchset was to add the full dt GPIOs specifier
support in i2c-mux-gpio driver. In particular we needed to have the
full GPIOs specifier being handled including the flags like GPIO_ACTIVE_HIGH,
GPIO_ACTIVE_LOW, GPIO_PUSH_PULL, GPIO_OPEN_DRAIN or GPIO_OPEN_SOURCE.
Due to using a legacy GPIO interface the former driver implementation
didn't provide this ability.

On the way of adding the full dt-GPIO flags support a small set of
refactorings has been done in order to keep the platform_data-based
systems support, make the code more readable and the alterations - clearer.
In general the whole changes might be considered as the plat- and dt-
specific code split up. In the first patch we unpinned the platform-specific
method of GPIO-chip probing. The second patch introduces a new initial_state
value field into the "gpiomux" structure. The third one is responsible for
GPIO request loop isoltaing into a dedicated function. At this stage common
it is a common function for both dt- and plat- code paths. Finally last
patch introduces a full dt-based GPIOs request method, which uses
gpiod_get_from_of_node() method in order to parse the corresponding dt GPIO
specifiers with their falgs. The last patch does what we inteded this patchset
for in the first place - adds the full dt-GPIO specifiers support.

Changelog v2
- Remove fallback pattern when selecting the dt- or plat-based code paths.
  (Cause the patch "i2c-mux-gpio: Return an error if no onfig data found"
   removal.)
- Use a dedicated initial_state variable to keep the initial channels selector
  state. (Causes the patch "i2c-mux-gpio: Save initial channel number to the
  idle" removal.)
- Mention open-drain, open-source flags in the patchset descriptions.


Serge Semin (3):
  i2c-mux-gpio: Unpin a platform-based device initialization
  i2c-mux-gpio: Unpin the platform-specific GPIOs request code
  i2c-mux-gpio: Create of-based GPIOs request method

 drivers/i2c/muxes/i2c-mux-gpio.c | 226 ++++++++++++++++++++-----------
 1 file changed, 146 insertions(+), 80 deletions(-)

-- 
2.21.0

