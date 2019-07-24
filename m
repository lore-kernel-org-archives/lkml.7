Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47300C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B63E22CB8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ6yebjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfGXMXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:23:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37935 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfGXMXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:23:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so20883291pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 05:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kkTN4o8gPv18UXfrNrZcVCeVXmsSsSWboY29+wX+V8=;
        b=JJ6yebjmJokjhDI20Vieo630GcwLCU7ZRiF3g5jF9s4ZR9/ul1OA+3LjBpMkbKxKTA
         IUZXR7Fsfwi6Sur49qmnNX5WYaT9SYpn7Bv5kZuLA3aNqmCAEABgICibEpbaAjDreFVQ
         U8Ij6eaieHbBgliqa6zPYOB0ii+1Yk6VXDLgxZekciUg0wD/TyGLxpmmVCjp5lIbOu3P
         oIB8exxyNWqxJo+tM9eAxbmD4TBVxuyirNjPpV+h6Uh5V8mWefsS3HpsE/G5+HAETgXi
         G9bU97WjVOz1tSQLD9/eiA8AbSwLXFCjXckqTvQZjxC9mA/0bt3tRQgJ91UImD2wraKl
         yf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kkTN4o8gPv18UXfrNrZcVCeVXmsSsSWboY29+wX+V8=;
        b=mxx9IhV/u08IA6cIlE3C9TS0OQuZy9P5takcMlsB6oXDjdgyj6O9usIl7i38vym6R8
         AOaP3NtVmSf2AiMAH1Cd0rLT5RNogUJxARZWlQZOAHelO2uRQvpduf4Pk97kt5/P4zRe
         G/VYEX9O45KD5queQ/N885wbtkiMs3cPP3Ui9v+b+7b3JzMAQ6gqQVbpbLXPav58tYY2
         JpiSJRkVXMGG94qU7+wH4gJUDc3N0z5tTSmxF1+mPVWMtE53ViKj104Uxdqml4GTgP95
         DsBZ98SfH4g6VqEuYy7a5tnQF+ostjDQwhjmQJY/JO9eypgZKE2JTDwLsG34Sci4knO7
         z/yg==
X-Gm-Message-State: APjAAAU5Mda6OH56IdPHJgirgBylKFnaZRxx/tMJbBkT8+FY0riMS3IO
        dXIZAyorkzmsw+cE1Bxis+w=
X-Google-Smtp-Source: APXvYqxMqZaOG/pySVUM3gd/fjnbC6CYhSWK84/LgZ9HLKYTrAsyX8XGY1QoDwTDmSlQEUn1D4l6Fg==
X-Received: by 2002:a65:6284:: with SMTP id f4mr23444983pgv.416.1563970993410;
        Wed, 24 Jul 2019 05:23:13 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id br18sm38834953pjb.20.2019.07.24.05.23.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 05:23:12 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] pcmcia: Use dev_get_drvdata where possible
Date:   Wed, 24 Jul 2019 20:23:08 +0800
Message-Id: <20190724122308.21747-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/pcmcia/yenta_socket.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 810761ab8e9d..49b1c6a1bdbe 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -173,8 +173,7 @@ static void exca_writew(struct yenta_socket *socket, unsigned reg, u16 val)
 
 static ssize_t show_yenta_registers(struct device *yentadev, struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *dev = to_pci_dev(yentadev);
-	struct yenta_socket *socket = pci_get_drvdata(dev);
+	struct yenta_socket *socket = dev_get_drvdata(yentadev);
 	int offset = 0, i;
 
 	offset = snprintf(buf, PAGE_SIZE, "CB registers:");
-- 
2.20.1

