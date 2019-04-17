Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6857C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B75206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxkubjw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbfDQQBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:01:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37622 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:01:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id o19so14954163lfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hV4gYALEF0iTp4qrF1j9F03PPlYax/Rhkzv57HrHB44=;
        b=sxkubjw+f6sY0kuS/XnsqVkiTpOQnauUQZsA8EzB21uI7vliUviRe3W0drn2LJA4z0
         RXF6zqcxpndrF9WLW6mIf4ucopFCKYPFcdM+2inimVn9v+msb/ziLN0M7E55XyTJoeg4
         LFvrhPOUqiz6tphyMb01AYiseygCmVa/MY1SbaEvyiw2tIayc8ND7dAQh7C5+FUkDmXY
         vIX+4FPWaCnpTPrtRvZV7w39zbqf/OBnZI4VO1yApNlKjJAEVSF1jPsTFiv36XX58pCA
         2woz7GPvdHc6T1LNsXgjuWUNInX5otDu5NzyyUp/vihB7TBbVb/MTp36wjGDOSA62QcQ
         8MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hV4gYALEF0iTp4qrF1j9F03PPlYax/Rhkzv57HrHB44=;
        b=jcWoyUuJFYLjZVAynfThysz7TWgooZG2wExmVusIsocG7JxU9L/EU513vB6+DcAqGc
         xj1GjhHgz0DloB85rIYVW33nnTotfpnibG7bqOx0TViJ4ik+LA0aDPPTBY7qckd9ggmF
         EY/ckNxX5jCaMWPusdPXWpV3tabLXBmlHOtxJns1479qU67qWWWlA311UZPJMPK70SUT
         PlFwyQhNxqOoOZdf6iTEi2zZZfbH3pxN4bbpciDII2v6aZvGf64Jo2rH4yZnGfNOepka
         GqF1bzboSe2dbjJWS2SDZFdy7kZBk3MmPtkTufMwvJLLcI/oIxpLCTEfmraMS8zzPuCb
         VPkQ==
X-Gm-Message-State: APjAAAXbHNO6+OoE0N0Y8ZdgYyuSH0Zivrau4viuE78XRJ09f2xIWt43
        ERulAUrfEroX95q9M3OSJDpEVigoAWs=
X-Google-Smtp-Source: APXvYqzdLBoPcDXQYv8WFq6Pa7sdglQ7EhRngWv517ESQ+G4ROLdExYaaKmyV59PksQZX4LAyMquZA==
X-Received: by 2002:a19:cc52:: with SMTP id c79mr21942202lfg.30.1555516882917;
        Wed, 17 Apr 2019 09:01:22 -0700 (PDT)
Received: from jax.urgonet (h-84-105.A175.priv.bahnhof.se. [79.136.84.105])
        by smtp.gmail.com with ESMTPSA id s26sm11095552ljj.52.2019.04.17.09.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 09:01:22 -0700 (PDT)
Date:   Wed, 17 Apr 2019 18:01:20 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm-soc <arm@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] tee subsys for v5.2
Message-ID: <20190417160120.GA19526@jax.urgonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this OP-TEE driver patch. It allows the OP-TEE driver to work
without a static carved out shared memory area.

Thanks,
Jens

The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the Git repository at:

  http://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-optee-for-5.2

for you to fetch changes up to 9733b072a12a422e2bf17bc7ba8b39769853d4a2:

  optee: allow to work without static shared memory (2019-04-17 17:26:33 +0200)

----------------------------------------------------------------
Allow OP-TEE driver to work without static shared memory

----------------------------------------------------------------
Volodymyr Babchuk (1):
      optee: allow to work without static shared memory

 drivers/tee/optee/core.c | 80 +++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 31 deletions(-)
