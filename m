Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1509DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C4620818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGsacBF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfDOQLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:11:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35751 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOQLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:11:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so8802161plp.2;
        Mon, 15 Apr 2019 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQ8H7Nhhsa18x4UZUWx42/gvziYn/UG3Ch12n2tKxG0=;
        b=WGsacBF1wdCB5D92cf/Vaa4BqbPhPlkJTP73aNTEMoT1nYXi3hWmXXoXmroXI3qDiz
         3P/RUidInyHur02lsn+MihDH/C0lJrQZyAc6LRJ7+wdekepzBCrqA2kauZykILODq7Ut
         v2e0mJfZLrq6f2FJZEuQQkF1TZEyVSvQ36mXtHKCPrfZ7sBcfaakZF0FeatTgPvYrbr5
         zZlC1NYVW7OoSrF0qjDFmKr+5ehwp2ifbvOwnw1PiVdqo9MFYyFe2OhvzynyYjzrMXL6
         wqwnQrKf7l52QF/LdswVb2hqP/srSrqltTIjUjwx7Xere121j+/gBkcr3yrwdJ1b/H40
         7Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DQ8H7Nhhsa18x4UZUWx42/gvziYn/UG3Ch12n2tKxG0=;
        b=oq9b6I8ZaM9U8BK8LXZoC1qVZf5/5tb/NSPcUTfvUceoDEpjFn13AWELf8lu/KclFp
         FesH6+bNt8altlEr2XDplL8q5RE/t3LXa6yGWFQqIn9LKyrAzUo3K3qSi6jHo68mq1mo
         kn+Tccnv9ZU2qVi3LUZS0fnh/0tUvzg2x0bxT5XrVCsmrTAXFgc2BQrDf87+Od5reiOw
         xVT85xQk5zCmRX+P5mh8JZ2RmyXwQYY887bAvFCsTX81aGfteH7ev4IiKfPdS4ygtjwM
         QRj6rgYYQpAhA708eqG7xs3/xqCpR8TQ+4zWbOblEAG3yNRbPqSrBZUPhtDX18ljxxXZ
         Cxbg==
X-Gm-Message-State: APjAAAVlcOJ83g0pzKEPbXc37m7wnPjDnpNYu9aNfh/rf0C5m1011PKu
        qNFWIu0KJhw+Yd7NcvhvFa8=
X-Google-Smtp-Source: APXvYqwnhJHcgGMYYOaRxUu66dyzoT5hXcMSDiZ2t1c4VG2WfddCVt+tjSzoVGjbuchp9jWhq4DlBw==
X-Received: by 2002:a17:902:4643:: with SMTP id o61mr65742800pld.249.1555344659824;
        Mon, 15 Apr 2019 09:10:59 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id b72sm92794489pga.86.2019.04.15.09.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 09:10:59 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com
Cc:     lee.jones@linaro.org, bjorn.andersson@linaro.org,
        dmitry.torokhov@gmail.com, agross@kernel.org,
        david.brown@linaro.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: input: add Elan 400 combo keyboard/touchpad over i2c
Date:   Mon, 15 Apr 2019 09:10:55 -0700
Message-Id: <20190415161055.16372-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Elan 400 combo keyboard/touchpad over i2c device is a distinct device
from the Elan 400 standalone touchpad device.  The combo device has been
found in the Lenovo Miix 630 and HP Envy x2 laptops.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 .../devicetree/bindings/input/elan,combo400-i2c.txt   | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/elan,combo400-i2c.txt

diff --git a/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt b/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
new file mode 100644
index 000000000000..fb700a29148d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
@@ -0,0 +1,11 @@
+Elantech 0400 I2C combination Keyboard/Touchpad
+
+This binding describes an Elan device with pid 0x0400, that is a combination
+keyboard + touchpad device.  This binding does not cover an Elan device with
+pid 0x0400 that is solely a standalone touchpad device.
+
+Required properties:
+- compatible: should be "elan,combo400-i2c"
+
+This binding is compatible with the HID over I2C binding, which is specified
+in hid-over-i2c.txt in this directory.
-- 
2.17.1

