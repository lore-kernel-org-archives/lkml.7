Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E8FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B294B204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="X4KumO0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfCZLS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:18:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42924 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZLS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:18:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id x61so4719178edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 04:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UPeXZ4AAarS9G3G4HeyW+y4EGQai6OsoJ0Zh24Hq7BU=;
        b=X4KumO0FhuZnqz+UjV7ZkLxXo2ABbK+SzEKUQEv9TwvjKA4fxLZ0JXGd2O3WB4YXC4
         u4qkRnuIvBhWvmKR8Hq3hr8S0/aQ0E+Juh0AR5pDD0rxYRqku2Q4ZwO9T6pdkkOKk5H4
         X803SKfUjOvwofv+JLsJMhqEvzB4hdL5TjZDMM49CyUw6/+Y4gQ+qJl8yB8RHPfL57+o
         4hhFEueGAniJK53ywzw6Xsh+9geNUwbpCNRm8spOzbd8ARFNIz/Sp2ET0Exwr6cqZ0H6
         J5EnEzP7LCLxFAptMUO9uIecDDiQM457ywkNQ/KdKkX9o+y+5tZ+4URC+M9ZEeQ+Nuwf
         pkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UPeXZ4AAarS9G3G4HeyW+y4EGQai6OsoJ0Zh24Hq7BU=;
        b=B2pkZDxTOgvYrsj6ESpQcF667PLcix3PO0iedNYtxh2pL3SLxF2quyG9gCqKOmKviZ
         91DJ4rXVsMM/+b0nR+p+8CBYA+hFjLudC9caaGY1rzoTRyKSOeUjXyRykJ0VI8A/meRH
         /f6m7I0d9S3LHo81y1+GGZ+syYbVf9+CezLd0ETgkNZgbiRA7AZlaNSHQcCEf8G5C6iE
         TdE3CWXBj9oc7JZ1EIy2qm8Y54NUVU83EkbcazYngkQ5ysH+fhxIZFUkUHgy9W6ctn3I
         baiLAC0DCeKz8siEr0mkmikCN8ymK5cBCDAqNuwg3uRBBURwJh7i/A/Jm31+dDjJvckd
         lAdQ==
X-Gm-Message-State: APjAAAW5KNEbf0cT8P34GHLfKVWnkE28IgWOZTAoe4JCwzVuVwk41OfG
        x3LT+kKUf9m2R+S9tFIRp2neVA==
X-Google-Smtp-Source: APXvYqwUy/wnpdzjGcFAw9dxWJVgKcN0+6t2Sb7AXHDZ0vAu3k7zmpiCUuSpBvOPgqrSG1lE4ypDPg==
X-Received: by 2002:a50:e844:: with SMTP id k4mr5026287edn.249.1553599135872;
        Tue, 26 Mar 2019 04:18:55 -0700 (PDT)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id i3sm3842464ejj.46.2019.03.26.04.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 04:18:54 -0700 (PDT)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v7 1/3] dt-bindings: iio/temperature: Add thermocouple types (and doc)
Date:   Tue, 26 Mar 2019 12:18:40 +0100
Message-Id: <20190326111842.12399-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces common thermocouple types used by various
temperature sensors. Also a brief documentation explaining this
"thermocouple-type" property.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
Changes v7
 - Merge header and doc in same patch
 - Doc:add it's a single cell entry
 - Doc:removed non complete example

Changes v6
 - Add this file
---
 .../iio/temperature/temperature-bindings.txt     |  7 +++++++
 .../dt-bindings/iio/temperature/thermocouple.h   | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
 create mode 100644 include/dt-bindings/iio/temperature/thermocouple.h

diff --git a/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt b/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
new file mode 100644
index 000000000000..8f339cab74ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
@@ -0,0 +1,7 @@
+If the temperature sensor device can be configured to use some specific
+thermocouple type, you can use the defined types provided in the file
+"include/dt-bindings/iio/temperature/thermocouple.h".
+
+Property:
+thermocouple-type:	A single cell representing the type of the thermocouple
+			used by the device.
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

