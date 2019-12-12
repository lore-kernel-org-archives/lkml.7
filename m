Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4ADC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323ED2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XOSrWBeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfLLVVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:21:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35985 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731078AbfLLVVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:21:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so215842pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3MllguTlm4RWEMVtAXxk8WCZHqQzGllKbJkD1LpkZo=;
        b=XOSrWBeBMymaJn4z1PR8VDb2JrXgYLfUBwv5WuGOHadZF8aLKPGK7s3i80NML9ei5o
         Wz+pX+KdMmyRfIOuG5pMCh3ms1vGqADyMXJweI9dlCYaufAZ4i3qR6Iy3JnnJ8bgvEGd
         TueSwhM5i2JoLKcIA8OmAjTC7bOIrDgKDzJB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3MllguTlm4RWEMVtAXxk8WCZHqQzGllKbJkD1LpkZo=;
        b=q+60Mq6smAXkbl0nfHVIFsO+fvXT1otvzc05TyuVhU9j4haHuxvkKmSqRq9Qz2U/9U
         51eMUZ+nbqYTXYqlWZ04eo568XCLhhCsNckgnz17SrGHUYxBc4hYjPF6zkgjp1vEKRlj
         fqLHLIS6Qd8zAL/Qo9qv098k3bFiJbfMy5eYCq3QYzecHzQvHPUbObiRxpIRcyewEWG1
         NAYNt/5Dk/EjoHYY3ekuBslJk/3H1UGLnVQG3TsmDwBG2seO+wGJbuTAsNsBMzoQDI4N
         JU6f+vFTH4nGZXWN7eoWAeHmyHtFWANdBhBwVCs2CiO3/eIY/VANr9s9iTTvdq2qIuCa
         RUlg==
X-Gm-Message-State: APjAAAXWdQcz57vgaB7H2S5bd8IDYCS31vtzBIshunrQjFLOAwUmAYZd
        0AcCJgovlcWIQTulwzXBXcvNzQ==
X-Google-Smtp-Source: APXvYqxCXvvMmFnm700MmbQmtWurHwBNW8hqqwHFReXZcDmV8WyGaUc29LSksY5z4mtikc0J/wRD1g==
X-Received: by 2002:a63:504f:: with SMTP id q15mr12761862pgl.8.1576185712148;
        Thu, 12 Dec 2019 13:21:52 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y62sm8969595pfg.45.2019.12.12.13.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:21:51 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: dwc3: qcom: Remove useless compatible strings from the match table
Date:   Thu, 12 Dec 2019 13:21:25 -0800
Message-Id: <20191212132122.1.I85a23bdcff04dbce48cc46ddb8f1ffe7a51015eb@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of match table in dwc3-qcom.c had an entry per Qualcomm SoC known
to have dwc3.  That's not needed.  Here's why:

1. The bindings specify that the compatible string in the device tree
   should contain the SoC-specific compatible string followed by the
   string "qcom,dwc3".

2. All known Qualcomm SoC dts files (confirmed via git grep in
   mainline Linux) using dwc3 follow the rules and do, in fact,
   contain the SoC-specific compatible string followed by the string
   "qcom,dwc3".

3. The source code does nothing special with the per-SoC strings--they
   are only used to match the node.

Let's remove the extra strings from the table.  Doing so will avoid
the need to land future useless patches [1] that do nothing more than
add yet more strings to the table.

NOTE: if later we _do_ find some SoC-specific quirk we need to handle
in the code we can add back a subset of these strings.  At the time we
will probably also add some data in the match table to make it easier
to generalize this hypothetical quirk across all the SoCs it affects.

[1] https://lore.kernel.org/r/1574940787-1004-2-git-send-email-sanm@codeaurora.org

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/usb/dwc3/dwc3-qcom.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 261af9e38ddd..72e867e02a1c 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -751,9 +751,6 @@ static const struct dev_pm_ops dwc3_qcom_dev_pm_ops = {
 
 static const struct of_device_id dwc3_qcom_of_match[] = {
 	{ .compatible = "qcom,dwc3" },
-	{ .compatible = "qcom,msm8996-dwc3" },
-	{ .compatible = "qcom,msm8998-dwc3" },
-	{ .compatible = "qcom,sdm845-dwc3" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, dwc3_qcom_of_match);
-- 
2.24.1.735.g03f4e72817-goog

