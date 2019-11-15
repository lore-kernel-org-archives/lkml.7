Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5FAC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9EA2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTo8ybxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKOEu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 23:50:58 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:34659 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKOEu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 23:50:58 -0500
Received: by mail-pl1-f202.google.com with SMTP id u9so5527752plq.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 20:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w71CA9nI41QLngUUjO4kaDNCWv8Is/cxYLfXviB89PM=;
        b=NTo8ybxoixlCH0ZM1hpm8k1kL45i3+Eh5sJUx6aF70GQFnFicUSLH/iVN4V7v5nxez
         aSeLn+YhSHtNCWALSPcXKt1kt9rXZTysNWTysx9jJCcdsfzPAZHfZ3lVgIJDVQOh/kk8
         U6L8AqrRcEQR/8bltVArD3ZU0+dZmE4FYWigJYdNlpP3DSOGwSn1zsz2krBosITPAmTs
         DJitrC4FkVwD/IOkaerJR5ymcO2HxxN9VZZ0CH7/ALoVmiIlZr+IV0BPY5WaPBS6c/Da
         Pojk/sakGMiZms6D9fYDH8aveluLe5NxC43OLQeYNe0ds5yXHzA3H1OTuiFV2I05mNtL
         Q3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w71CA9nI41QLngUUjO4kaDNCWv8Is/cxYLfXviB89PM=;
        b=KiOqaZB6wqsFnF7RvwK9iAZkKoEz4yYwkjXG2/WqgDQu8WGRTQZ3oKzD6O3Nj5EzlK
         e+32oZw871L/Xb7KNo6iH363DVQ/TPHwcPpj2zzCXE77mYF5vKwEYq1E/NIijidN3B+8
         KUVm/JQCYQ9m3dLGrg07sQ3CdqPq3WVkdtPfJ5x80MOZBf1IgqH1d6F6O3JaLAbA/Xmk
         u6TkiBjgBMxJNgBaxis8ZCZOSzkhRtpn6ZIrvmGsZnrxhmnbpwY/oMiFY+3wq/hXcXSn
         fu4mmaZJvhb+c2LaauY81fov+gRNrjPeis+pyvvSWisUCPDPlefCupJV39Hs648O7W/F
         rWug==
X-Gm-Message-State: APjAAAXHz+v9iqFJ9M1mNgrUICcXtB7Mtfqmgqc0I5N8Yi/fL43DM755
        jYFaI1TYzXuf9SA4dTFmOVfoUunFroJLQfI=
X-Google-Smtp-Source: APXvYqwoR0UhMLan4e4IUMAvPvgf+9vxmaOtBTzeVFpTKGkCGgYwDAz522FkrjiFpB745lMdX6ZtroWuXToyQIM=
X-Received: by 2002:a63:ee44:: with SMTP id n4mr1499531pgk.137.1573793455780;
 Thu, 14 Nov 2019 20:50:55 -0800 (PST)
Date:   Thu, 14 Nov 2019 20:50:48 -0800
Message-Id: <20191115045049.261104-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v1] i2c: of: Populate fwnode in of_i2c_get_board_info()
From:   Saravana Kannan <saravanak@google.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the of_devlink feature to work across i2c devices too. This
avoid unnecessary probe deferrals of i2c devices, defers consumers of
i2c devices till the i2c devices probe, and allows i2c drivers to
implement sync_state() callbacks.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
The of_devlink feature is present in driver-core-next branch. It started
off with [1] but it has been improving since then.

[1] -- https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/

 drivers/i2c/i2c-core-of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 6f632d543fcc..4e913c890a7b 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -50,6 +50,7 @@ int of_i2c_get_board_info(struct device *dev, struct device_node *node,
 
 	info->addr = addr;
 	info->of_node = node;
+	info->fwnode = of_fwnode_handle(node);
 
 	if (of_property_read_bool(node, "host-notify"))
 		info->flags |= I2C_CLIENT_HOST_NOTIFY;
-- 
2.24.0.432.g9d3f5f5b63-goog

