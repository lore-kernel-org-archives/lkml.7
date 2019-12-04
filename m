Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D99C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACD7206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgb13NeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfLDQAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:00:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42435 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfLDQAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:00:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id a10so333900qko.9;
        Wed, 04 Dec 2019 08:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RNz52JVd2PldFAmDCRZ+28AiJhexA3viR29eVizBV9k=;
        b=Mgb13NeUGIn+5JewsQnVhmo5hptOuzgWsDb5OmdcmwcXr7RnRiZQOa15taSqy27rM3
         2TXYzCSyCrfNHSffFxtb9HIW9H7SA06YBkaJZiJeXiRUIhdcacL1EEWSy45kfRBTXyO/
         p4eIUZ3yApFafRFkj8ksvSns438ZeInVgKmGEseci8lqcyhyA1VUqQoaJ3hBMK4XQ6qO
         rmEVQE5Wz17LNSo8O2P26BcWTYaj4L5+QKibQWp1Rf0OtkkAT2oFliw308oEpL7rFZKP
         HB0Ojwv7QYXW6D1K8cfNFi+xUBGP93GROmV9uQ3V6AnXPdiq7vaCP9e2V3GjBBTvQK5s
         kjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RNz52JVd2PldFAmDCRZ+28AiJhexA3viR29eVizBV9k=;
        b=GfbC6AlZ5/+2Q50ppjIMlbqy/1WN5owGlTBiCPGZpdlR0ylVXlrzednYugtsLW4OUq
         WvctuNOV+d0muBspMNelQIR0xeCwihKv+z/RjT16P0HPYtNqSJQLOnX/ziIb0/zDpapW
         j16mvBhcZNa16FZhnrc9Bc881/nUiEeTdjKXnZDGzunkeOsN+/Je5rPG+Cm147llJMrP
         MZHrIH0oNJqkJJnTi4NxQJe0jlT9OAO7kJ7OJD9zbuVe0zZqVqZSo9QxLBO086vufW61
         /mNx6hF5OD6if/OW6gkrknbbmzQReK0iJnobAQoO49byv+An2KEVHLdFznStZSsNdle3
         ZrFA==
X-Gm-Message-State: APjAAAXjoOYOvI4LmDSD4c0ysHu3r3TcILGq69NB1q4Elm+1U/0E8QVH
        xOtoDGEAMlt6YxO0UUSgFuA=
X-Google-Smtp-Source: APXvYqwcvpVzypBVrEg3Qi5GxTRsTH+k0FxqIrYNNFNtTZmLtXzoFthBD00Mh8z9uaWR7gLRZx0C1Q==
X-Received: by 2002:a37:c244:: with SMTP id j4mr3538920qkm.433.1575475210703;
        Wed, 04 Dec 2019 08:00:10 -0800 (PST)
Received: from smtp.gmail.com (gwcrusp.semfio.usp.br. [143.107.150.86])
        by smtp.gmail.com with ESMTPSA id x57sm4083387qtk.58.2019.12.04.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:00:10 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:00:05 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org, robh@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 2/2] dt-bindings: iio: adc: ad7292: Update SPDX identifier
Message-ID: <20191204160000.7x4isja36kn24ovw@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update SPDX identifier to the preferred dual GPL-2.0 OR BSD-2-Clause
licensing.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
index 18f1032b86f3..e1f6d64bdccd 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/iio/adc/adi,ad7292.yaml#
-- 
2.23.0

