Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC14C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B6120848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCSfP/QG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfDOU1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:27:10 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37930 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDOU1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:27:09 -0400
Received: by mail-ot1-f45.google.com with SMTP id e80so15648450ote.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=68rBrRFrnFYMNb4JSSik7DangiOaiRyMRFnUV5GZTBY=;
        b=HCSfP/QGBX6xClzxpiaZsAdHfuYPBXV3LWc/opuxEJzF8z1Yhk8KQxrjOUzI42yKxX
         HVLEMhwaP5grRS9I9BqLtrZhtO8cnFX9SC1YGrNu2FCK/ykkn+Kx5WbsPSQKcl8GPe3j
         sVaLmiy+K3elUAZb4VaH2opi3/0Bv7lHprxs8YRhgwms8bvs5RBjAmyOsaZBNJZrGQGM
         sUMC59L1I3czdZiiENW2OJIWGP418x3By+l6x69Y+XaygwKx+FeK8ZOg8MeplyqiS2ul
         jSbC05IKYkJZ+ghelFbQC8TOnUYts+p+rRc6kyNrSocqbAKJCSEHGa6n3OSocr24MWkb
         h9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=68rBrRFrnFYMNb4JSSik7DangiOaiRyMRFnUV5GZTBY=;
        b=hk6t328v8wL5H5XucB6TvVhY6J67RrM/1Pom923K32polvo6L+ebQRK84qJs3Cxv3a
         fs46fcvzuhTijUI6U6ethC85Nc+23XWNbhpy4k4Ff8kk7v/ftMchdTH7KizWn7QfhvLr
         Jjy87AL5DeNu02bSXLUEKcj0GhizMBC9dB/eEVMEpi2pgKVyg5aWpPNLdOkTlacGNpii
         ZvDd4wBQG1tpyrmQqcnkzm1JutgDvazDmgJLDQwRvHCQvWBiJcewwkRl3fOlGd69vxBJ
         93bO1SmvMhUr9HQBB6uIApGGoFOOCRQCYUEHq70ym3Y3sdiT0TieY4SjLnFtGfwMTYWZ
         gx1Q==
X-Gm-Message-State: APjAAAW5ctltN1OelB2sfjz0bKxJ8hyNN3/yXzwl2qBpfEu+31PdYQkU
        tD1iHul+RjOMhka/5d0Lefs=
X-Google-Smtp-Source: APXvYqzpL2Dl7HKbs+V6GbdYT+j5qfMV0qdD99gc5jPIDLSAUFFMoA0fJ4w+PFbHdqXFW1YbVbKNpw==
X-Received: by 2002:a9d:27e3:: with SMTP id c90mr48759294otb.214.1555360029085;
        Mon, 15 Apr 2019 13:27:09 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:95f5:9dbc:648:48d7])
        by smtp.gmail.com with ESMTPSA id s31sm22038201otb.35.2019.04.15.13.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 13:27:08 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH 0/3] Cleanups in rtl8723bs
Date:   Mon, 15 Apr 2019 15:27:01 -0500
Message-Id: <cover.1555358247.git.madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 and 2 remove typedef in structures. Patch 3 remove unused
structure.

Madhumitha Prabakaran (3):
  Staging: rtl8723bs: Remove typedef in struct ieee_param_ex
  Staging: rtl8723bs: Remove typedef in struct ieee_param
  Staging: rtl8723bs: Remove an unused struct tx_pending_t

 drivers/staging/rtl8723bs/include/ieee80211.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

-- 
2.17.1

