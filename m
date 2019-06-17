Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD7DC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E76A2182B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/VQwMJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfFQMvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:51:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38671 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfFQMvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:51:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so8978517wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yh8KWN22mWMhTl8rcvEzBYBWJNOHxR/ZVbPRRDE/D+g=;
        b=q/VQwMJ7CaCCS2TpiY40tB9SR/0BGYUD9cg5QmvyZlgN0oSe9DGo/a+8W3tFnih/es
         f/TGbxw2+NhrkghexAa4OElVuqj6adr3zChACFmOr55PBTOD/M1NIEdtp5/IEy9qU/kC
         fX2Qrs7PhDGqUidNClIWZ04Lwg4RW4iXSfsUN/mQ3Fz6ReP9i0AdV914a9optyVwxJ9W
         Xy6Y1mSeoVn1NeqGDQGLUT+gzK0PwP6QYlI5aEiS1G795pxPRN55vGKPX1Kr7l+p8xwx
         9xxVx3Oo0mrnM/HpISh/Sd3kMq4WHV1BoTnn1nr+LgaU5NktIDT5p1PPAhig5lYx1wqZ
         dRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yh8KWN22mWMhTl8rcvEzBYBWJNOHxR/ZVbPRRDE/D+g=;
        b=tFRt4z3cu9g+V4A3Eu6ORVuWjzQn7x9nEVeJCoIOzhxRB7NjKqor2GZ75KDb06dJ27
         iqVqCydBQi64yu+ewkErAdahsZW38YFOu4ApRWyDv4d5aqMXyWep/a4h6FQkahHkaQO6
         0WnIIQDbqO5WlJIHgoSWpZBJqcfJARIBD5TjqJExdTbf/ga9mTrkK5pQj2HPP8AfF1JW
         5+vftI2jIsOiLj3UB0SUcwQ20wrz4KYvMdYWan34tjZDqZun9OFK6GsOj0EB+6oA3ld/
         SwTk3oPdhlIt4LY7LrTRK1Ew0xOW3IHP7tsvLmWmXRLWw5LfQMZgRDKOFd6gJRx0BZV5
         l4Fw==
X-Gm-Message-State: APjAAAVCSTpss/pWRcx0pXTa2Zs1mNeRuTI0/mFn+LjOGYJYT4Le48uB
        fVq6L12L1u7LFhMb+kBnzCsoxw==
X-Google-Smtp-Source: APXvYqyQ7uC0yXE6+rCbtoO1nXI3vuubKGuLiHCQLeIEVsa7DW/HvoU6icIxjcUwUpeyeJFFHJ6L2g==
X-Received: by 2002:a1c:63c4:: with SMTP id x187mr17953607wmb.4.1560775872645;
        Mon, 17 Jun 2019 05:51:12 -0700 (PDT)
Received: from dell.watershed.co.uk ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id o11sm10477852wmh.37.2019.06.17.05.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 05:51:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org,
        jlhugo@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, felipe.balbi@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [RESEND v4 4/4] usb: dwc3: qcom: Improve error handling
Date:   Mon, 17 Jun 2019 13:51:05 +0100
Message-Id: <20190617125105.6186-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617125105.6186-1-lee.jones@linaro.org>
References: <20190617125105.6186-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dwc3_qcom_clk_init() is called with of_count_phandle_with_args() as an
argument.  If of_count_phandle_with_args() returns an error, the number
of clocks will be a negative value and will lead to undefined behaviour.

Ensure we check for an error before attempting to blindly use the value.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 2d050303d564..c59e9d8e8609 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -409,6 +409,9 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
 	if (!np || !count)
 		return 0;
 
+	if (count < 0)
+		return count;
+
 	qcom->num_clocks = count;
 
 	qcom->clks = devm_kcalloc(dev, qcom->num_clocks,
-- 
2.17.1

