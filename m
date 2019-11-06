Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BCFC5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3DE2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1j49xEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfKFQMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:12:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44447 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKFQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:12:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id f19so8348556pgk.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJ9kbl/E6rlvUIPxuAB9V+d5cZikxgieCYSeyDlft7A=;
        b=Y1j49xEq8BzBvYe+bpny/I6F+TAYuqk0/NOt73IqlZ/z5ByVHYKYHM4nZRMmzYVnqd
         TtF42QXxn6QN/mOgPNOENp2IyhUmLzhK3jqZKbs0TG5ThUlfQiOfK47wA5/oVfKDUxWm
         P40P+A0Hk3yMINZhgtzyZOjIYD5XDNUFWfTlkTNTYpsnsC4XDuwh3N/ZcrTCn5ql0dJk
         ugI/6D8O9IGtp0KNK2T1PaFztM4UsYwWiKq7Ug6hL+cqUGcognP8YixOlENspL5C/NVg
         9eF+ZP6XcZIrNtzGL04sJRfHom/X5LdJHrO7USXmTtn+xD+rm6y1labsmFbxwXaRcGpm
         eN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJ9kbl/E6rlvUIPxuAB9V+d5cZikxgieCYSeyDlft7A=;
        b=nUO5gxF5nb2Sw9rXcgJzhRXOAYspp2QSkWAVBCdJ+VLeGOA/nExoYq/HYb2eAXYW7v
         qgIxAVTduS167KEbDWfAHzAc0U5cmvNgq3jNUBiBUHOyF3qFkpuH8KBcJC3MdweBC+Pi
         xT+MRYMD4eBtdSFYRHS5z5dedtlHVBKk3G14MrTkQ+86Ah4WPHbL8aCNJyZNEYzahiJL
         LN6NY1M8HCDEAgLCw2yP2JuMh3SUwu8wILxxYI9hSvHCO1tbKgHCk93qPMv3plv6nhCf
         4EW/b3uzVnfRQngRWDmhJ6Ja3dcLIhc0tLy2Cviy+WpVLA6a9vcekLk4+WcbZf0jVtfo
         948g==
X-Gm-Message-State: APjAAAXeK8jNgjb0w40rKJuOBHr84bgNWa2DukpA0ZCYaujP2rNtg+/T
        bl1X9f4AG2UlxWTaj/SGVusBRSpb
X-Google-Smtp-Source: APXvYqzMPsi5bFFRTFVzRcB0v27CmYqmDwI26R92/mP5PAEyepaHh88LrQyjQNX2H0v4ee6EBwHoQA==
X-Received: by 2002:a63:1242:: with SMTP id 2mr3704815pgs.288.1573056770984;
        Wed, 06 Nov 2019 08:12:50 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id m14sm2013245pgn.41.2019.11.06.08.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 08:12:50 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] regulator: fan53555: add chip id for Silergy SYR83X
Date:   Wed,  6 Nov 2019 08:12:11 -0800
Message-Id: <20191106161211.1700663-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SYR83X is used in Rockpro64 and it has die ID == 9. All other
registers are the same as in SYR82X

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/regulator/fan53555.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index dbe477da4e55..00c83492f774 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -83,6 +83,7 @@ enum {
 
 enum {
 	SILERGY_SYR82X = 8,
+	SILERGY_SYR83X = 9,
 };
 
 struct fan53555_device_info {
@@ -302,6 +303,7 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 	/* Init voltage range and step */
 	switch (di->chip_id) {
 	case SILERGY_SYR82X:
+	case SILERGY_SYR83X:
 		di->vsel_min = 712500;
 		di->vsel_step = 12500;
 		break;
-- 
2.23.0

