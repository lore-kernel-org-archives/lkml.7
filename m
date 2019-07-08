Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6BBC606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1906F21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbfGHRVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:21:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39603 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfGHRVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:21:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so18019998wrt.6;
        Mon, 08 Jul 2019 10:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uXyuo2g4akO/rflhBob2HGNH9vo/urZZU/7rwD/7OQk=;
        b=SFhiMTpZDU5MapzrF800zAG91bIxCaShuCHUo5YPw1Fn10yJad/dqiYxoiGBtnvV/7
         gn3sqq8TbO7AWD7cZBaiBucMzM6npxoRaK2Rk0JzlWtbEHd2Ea8OlK516xVHkzzeQ7gj
         NXygAxN7FUbVGNyxcZZKKuVLAmnjPZ0RaUHfDqACPMU887FDHhspYy43DH9C4R6gA7zh
         ebLRd9pNfWxToDKq9qzS+Q2T+tQf9KB/ChJZ7n5EaKnuP5Yypv1/gNUCqwNrMVk+sFW9
         qXLX/zAlaPi655wYIyDZwSDvWOAfykF/QVGtT4gUvUG4BEjnxlXtqEquBWFNBjeoFCbE
         bQWQ==
X-Gm-Message-State: APjAAAWVNye8KPMuAgf5ONG5EsrknmK5PI38bNTQgW0Ew59cs5AAWb48
        nazSUDtT2H97NXdZe5shuzM=
X-Google-Smtp-Source: APXvYqzLOITvxGq9hmemZ5mYsiA6citBYgRcyrb+hXyrIxCX+rk6D4G4JFHs99QgjjzlFcbExJ03Cg==
X-Received: by 2002:adf:aa93:: with SMTP id h19mr19563580wrc.3.1562606506301;
        Mon, 08 Jul 2019 10:21:46 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id h11sm16376853wro.73.2019.07.08.10.21.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:21:45 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Andrew Duggan <aduggan@synaptics.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: synaptics-rmi4 - remove the exporting of rmi_2d_sensor_set_input_params
Date:   Mon,  8 Jul 2019 20:21:38 +0300
Message-Id: <20190708172138.31009-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rmi_2d_sensor_set_input_params is declared static and marked
EXPORT_SYMBOL_GPL, which is at best an odd combination. Because the
function is not used outside of the drivers/input/rmi4/rmi_2d_sensor.c
file it is defined in, this commit removes the EXPORT_SYMBOL_GPL() marking.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/input/rmi4/rmi_2d_sensor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index ea549efe4bc4..b7fe6eb35a4e 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -204,7 +204,6 @@ static void rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *sensor)
 	if (sensor->topbuttonpad)
 		set_bit(INPUT_PROP_TOPBUTTONPAD, input->propbit);
 }
-EXPORT_SYMBOL_GPL(rmi_2d_sensor_set_input_params);
 
 int rmi_2d_sensor_configure_input(struct rmi_function *fn,
 					struct rmi_2d_sensor *sensor)
-- 
2.21.0

