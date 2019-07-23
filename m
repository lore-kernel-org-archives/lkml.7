Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2770C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC9D2238C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIcCj7zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbfGWWfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:35:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38300 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbfGWWfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:35:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so19847382pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XiSb/xm4DCwF5YKTrgrsnR/pgd/JHfF4jO/yKlf55Xw=;
        b=UIcCj7zGKNeQd38ejX8qLsDggMutycfth0tbzNIdR6CHdwx00EJrTxiUeVBNbX16TX
         Gtd4Na72AzruzwW2DidqG3ah8MqqRAvy3n/+/gHWgoQpHBSPNKTf6YS8yEpBNkK5+T5D
         TIA/DRnhgixXmDWF7S4c/yoicBW386TtzL8oyVNKKN1+fZVhYXrjW6fi6bexHHxoTOdH
         Y5cYjYETesyRZ3PEWthJTe6fxiNlfl6yDbacb2y7Tamt8ZIErwA/gUzxyuSyAwKG389o
         xcVSv5MjMgEBXzJP3WGpuMInzRCli9mrrsz3lNTS00n6q16G6WZQTs/PZf5fZuxAJk28
         pBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XiSb/xm4DCwF5YKTrgrsnR/pgd/JHfF4jO/yKlf55Xw=;
        b=scMc5lv86AKSw9x1CocXpARWXAvrW9132nFAWxmED1GqRxDnrVTS93gYuMD/Y+ACgs
         Qu0Syb+MSu5Pf6M+rFAZAK7BofyIIAfXvomgfrEoU+VafQWOzDjJW5E6l9FmoawmaCZj
         OWJBq5g6vDjPkMcUiHiEAM+G0+TIW5VuhjzaGic7XMqeNUZX/xcFtCfGBWY+8Dq9kFv2
         sSwP1hiCcJAAdIkaUJeFKqcCflwCgf6k1UWWGSMuPfs3D7NjHw6T3OL+G1t1LbJXJ4pM
         KONdWV2fT/Fvhq9yMoJZ0InkalWuSxdT1P1cITLpr74dA0OqXjHDUwjbYno+VkPG8dy6
         vTMw==
X-Gm-Message-State: APjAAAUaT0T1zS5Q24HEwUtmhWki7l030iO8Ykzjb+fYwdeW+cHqNTQ8
        XZ93+e+69OyvYN3uk39Vd7rAUw==
X-Google-Smtp-Source: APXvYqyLeXcfRNmfx416Y7McKDVBY/Rv0VoH/idk7vgEtG9OCSyJsCPhaSkeBGb6P87G88Zj2JwiIA==
X-Received: by 2002:a63:774c:: with SMTP id s73mr78620059pgc.238.1563921329404;
        Tue, 23 Jul 2019 15:35:29 -0700 (PDT)
Received: from localhost.localdomain ([115.99.187.56])
        by smtp.gmail.com with ESMTPSA id h16sm49036917pfo.34.2019.07.23.15.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 15:35:29 -0700 (PDT)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     agross@kernel.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v6 2/5] base: soc: Export soc_device_register/unregister APIs
Date:   Wed, 24 Jul 2019 04:05:12 +0530
Message-Id: <20190723223515.27839-3-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723223515.27839-1-vaishali.thakkar@linaro.org>
References: <20190723223515.27839-1-vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Qcom Socinfo driver can be built as a module, so
export these two APIs.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v5:
        - No code changes, fix diff.context setting for formatting
          patches. Version 5 was adding context at the bottom of
          the file with 'git am'.
Changes since v4:
	- Add Bjorn and Stephen's Reviewed-by
Changes since v3:
        - Add Greg's Reviewed-by
Changes since v2:
        - None
Changes since v1:
        - Make comment more clear for the case when serial
          number is not available
---
 drivers/base/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index b0933b9fe67f..7c0c5ca5953d 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -164,6 +164,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 out1:
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(soc_device_register);
 
 /* Ensure soc_dev->attr is freed prior to calling soc_device_unregister. */
 void soc_device_unregister(struct soc_device *soc_dev)
@@ -173,6 +174,7 @@ void soc_device_unregister(struct soc_device *soc_dev)
 	device_unregister(&soc_dev->dev);
 	early_soc_dev_attr = NULL;
 }
+EXPORT_SYMBOL_GPL(soc_device_unregister);
 
 static int __init soc_bus_register(void)
 {
-- 
2.17.1

