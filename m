Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D779DC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9DA20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylu32Xyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfEWPB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:01:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40069 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbfEWPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:01:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id g69so2871015plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9HPbB+/1XsdXIOfekp8uwS00PlsQpqBLPqA5cNuO+gA=;
        b=ylu32XyvB6DWk0CsJb509nElZsZmOoFdPwMEL7u9OSkrpMlho3jb6QCQxy/15T3wMp
         BkhEPVUE6VEjBnuopij1rHk8QYCaghvYH8nfxns4iMxmCIThEKBsFr7NIzJeo60nFE+u
         j6xCj8u/NAAWkIaUwYdcd9Kt6fLrmLFbXPzLInYfEWgAd9vYUSbaXz6Y21iIppxWCiEw
         fhyvwnbHOdYDua1hNZPpaKxj+en82dkzN3OBIe3f3ehQmxjE/wF1eI+jGQcTWy4jWIaI
         A/hn1rjsz8tLHDQY/Lwgn4XetVvulMZwBrTFYJ920MSzUw7+NoxvcOic0caAQyyoHKGo
         JetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9HPbB+/1XsdXIOfekp8uwS00PlsQpqBLPqA5cNuO+gA=;
        b=g8nBqubIeukcYIqO5WmsMeqqDeKHsFOWpEKe0paZoC3C6txIws/GnmKsTvQrQbKh1Y
         /C1v/B3Qtu9Lk+E0M+gIToTFYDuNHQsDFcmBRr+pd48/5+1IsftCqon1tO6JPPErOnPP
         bEyW4/koJyGOaExbrPLgo7kLO5ivSzPRY4N7me5qvu2Hbj5pp40peq5qEeNspmz5EokH
         xfPubFos+nrvA3rHB0ZBiRievfQhOGL+jsmL6SHjYACkLQugzuXvBGvosFn9UmzKYNBZ
         6uxk3BUc19mNG4ThJW98OOEzxSpji+Wgb0euGCWvP96oWPGfheqncXD4aArZ9N57ppIX
         bJcw==
X-Gm-Message-State: APjAAAVQ6bqmWZu4PJcfqO4W5JpUUV5M4NRBJAFyFN9Qp773hZZl5+Ow
        A7mA8mXrvua2GR2/nxYXsU8olQ==
X-Google-Smtp-Source: APXvYqzIj2BwrvMPQRJHJSSCOwmfUvkSruAz2K1zWiJscGPLw6+nznE6Ym2LMHGMG9AawDFEugtI+g==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91mr82211589plb.300.1558623717040;
        Thu, 23 May 2019 08:01:57 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t2sm25418248pfh.166.2019.05.23.08.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:01:56 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc: qcom: apr: Don't use reg for domain id
Date:   Thu, 23 May 2019 08:01:53 -0700
Message-Id: <20190523150153.13136-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reg property represents the address and size on the bus that a
device lives, but for APR the parent is a rpmsg bus, which does not have
numerical addresses. Simply defining #address/#size-cells to 1 and 0,
respectively, to silence the compiler is not an appropriate solution.

Replace the use of "reg" with an APR specific property.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Fixed example to match change

 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt | 6 +++---
 drivers/soc/qcom/apr.c                                  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
index bcc612cc7423..db501269f47b 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
@@ -9,7 +9,7 @@ used for audio/voice services on the QDSP.
 	Value type: <stringlist>
 	Definition: must be "qcom,apr-v<VERSION-NUMBER>", example "qcom,apr-v2"
 
-- reg
+- qcom,apr-domain
 	Usage: required
 	Value type: <u32>
 	Definition: Destination processor ID.
@@ -49,9 +49,9 @@ by the individual bindings for the specific service
 The following example represents a QDSP based sound card on a MSM8996 device
 which uses apr as communication between Apps and QDSP.
 
-	apr@4 {
+	apr {
 		compatible = "qcom,apr-v2";
-		reg = <APR_DOMAIN_ADSP>;
+		qcom,apr-domain = <APR_DOMAIN_ADSP>;
 
 		q6core@3 {
 			compatible = "qcom,q6core";
diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 74f8b9607daa..b83d71b2e0a4 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -276,7 +276,7 @@ static int apr_probe(struct rpmsg_device *rpdev)
 	if (!apr)
 		return -ENOMEM;
 
-	ret = of_property_read_u32(dev->of_node, "reg", &apr->dest_domain_id);
+	ret = of_property_read_u32(dev->of_node, "qcom,apr-domain", &apr->dest_domain_id);
 	if (ret) {
 		dev_err(dev, "APR Domain ID not specified in DT\n");
 		return ret;
-- 
2.18.0

