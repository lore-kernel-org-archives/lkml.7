Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90505C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0FF20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="gTn/jdtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfCGKeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:34:21 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39632 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:34:21 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so12995813edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nxn/6GjKzJiMcRUTaaJC39yYvCCkOP+Ey4ySxCWrj+Q=;
        b=gTn/jdtR0GIwXMQrtD/8yot5RUp8T+aIcSjlM0ukgB0HbHCoH2wG3cD8gaXVTjgwwF
         8u2+zT7Xy/fYVQd8xRpJRlCXbfkQGLUSLtaQl4kRd7jJGbSH6r+LVv46UoQf7H5Bt6iW
         2qtIk0bxDAeSHDdq7FTeSS1lUUWh2OzMTPzbKXghZuH7lVmnHQEYZL9A4SIOJtIpF+Id
         2U+zcXGOCKl7vZqYavp7lKK5thQjpuUT6ER5FeJXi/Qu7Jz5W942tBChs7BSSyeAACLW
         R7tDxMh1W2JGcNOkaV3/35bdDm5pnS3gx0RKJgiSRmoiPh9grnhxXUlgOG7hrqXaf0l9
         Gi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nxn/6GjKzJiMcRUTaaJC39yYvCCkOP+Ey4ySxCWrj+Q=;
        b=Sh08ntEcWPnMyT8ysOSznDvEQSemxO0CwvrO0exx8ygqcmyzQBW8HS7dbH8+gr2BEc
         C80au6LvQzpMJW40uElHjs8Zsd1+jtOlRk82ESRT/bbg1mBtJVVC7/tSwRhH4ja/1AEW
         vWDJ+IzrcsYh8XvwQEQT3Tb3q5GJb/XSE/I/RnJqsbMX2rM5DiHOGyQtTm5NqpNSq+yO
         TXBhknPteYwHv2ZI5ms+L/XSPDxf32I2/4vgRuoj8Oi/ukuiM6AjjtcVf4YRsXMptDfN
         Z80VixcITWApD4CAEyCrFmMyBsGpPvMKrbIPiydwiJRt9OdBh23eIXD51exSC2fMhcoY
         I+IQ==
X-Gm-Message-State: APjAAAXkRWkZ+8/kgeN2yruFzkpqK+NgniVzgnayj5ihMnrZz9gQntm6
        KeFCFSWG4ipJCLEzabJfiq20Ew==
X-Google-Smtp-Source: APXvYqxX+S6M2yMqFmfdBIvhdMCoJ5LPsHNEn2w+VR7HvMlMx62zH9X4xxd0dF/I1P3A0FipRAmWuA==
X-Received: by 2002:aa7:d58e:: with SMTP id r14mr26483112edq.39.1551954859292;
        Thu, 07 Mar 2019 02:34:19 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id h8sm1250998edb.36.2019.03.07.02.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 02:34:18 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v6 1/4] dt-bindings: iio/temperature: Add thermocouple types
Date:   Thu,  7 Mar 2019 11:34:06 +0100
Message-Id: <20190307103409.24174-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces common thermocouple types used by various
temperature sensors.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
Changes v6
 - Add this file
---
 .../dt-bindings/iio/temperature/thermocouple.h   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 include/dt-bindings/iio/temperature/thermocouple.h

diff --git a/include/dt-bindings/iio/temperature/thermocouple.h b/include/dt-bindings/iio/temperature/thermocouple.h
new file mode 100644
index 000000000000..ce037f5238ac
--- /dev/null
+++ b/include/dt-bindings/iio/temperature/thermocouple.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_TEMPERATURE_THERMOCOUPLE_H
+#define _DT_BINDINGS_TEMPERATURE_THERMOCOUPLE_H
+
+
+#define THERMOCOUPLE_TYPE_B	0x00
+#define THERMOCOUPLE_TYPE_E	0x01
+#define THERMOCOUPLE_TYPE_J	0x02
+#define THERMOCOUPLE_TYPE_K	0x03
+#define THERMOCOUPLE_TYPE_N	0x04
+#define THERMOCOUPLE_TYPE_R	0x05
+#define THERMOCOUPLE_TYPE_S	0x06
+#define THERMOCOUPLE_TYPE_T	0x07
+
+#endif /* _DT_BINDINGS_TEMPERATURE_THERMOCOUPLE_H */
-- 
2.19.1

