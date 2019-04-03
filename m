Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E62C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0F02084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtjXMuhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDCBmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:42:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40710 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDCBmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:42:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id w20so9186891qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=x//xwF3eq1+vJLLdiGcTLpKeTtTlNARo3WPhtlIjHCI=;
        b=EtjXMuhMbxy2U52JQ6PvgeBTcEXP3iz2xq3lkE0SG0KZD44hd2fvx+AzI2ZPTIPxfq
         CXcCsGFccBu859ahJtklVZ7XsBCBWvg/zdMawlpnfYaECDunrJR3QtKOiVNhRPnyAbXv
         VEkKAkFYUFxM3+X+dlDN3OFmIl6Eozk+UCN3nnEF9xzK7LQmUJ7kAd2H3rtRU6kTLXD+
         pdDP7ELnpoAmM/1f0r+rJILBlWKnLT7iZzw/QWneiy6kJkGn4emLOX2T4pBAOZ085uNY
         iM6qruij7+vgvkpKWPNSG6J/lg4nXNpRSgBL/2YxKg/z0UTXUzbvaZ/7PrhoBUkrST4p
         B8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=x//xwF3eq1+vJLLdiGcTLpKeTtTlNARo3WPhtlIjHCI=;
        b=UQ8apwjJPUB4kL66kNdmzoFCEzJy+dme/RlOdotFLgF8rlycL7fh2hd+KW2rxXaK/E
         kpYJnt2HtcVXfJyVWrISz0fzyb5n6cuKEwL1c6XEcvtzHZIuo/jYEII6FGIWRimM1z+5
         c1kMR4vhLtyLp/Y+x/9dArueaRAF4F11XVWGmRNz4iaA0by9cjf+b3CmiSWY0RR6HW6U
         pZHq3L/NRMJqXGzvsoi73oFFH9spseEBLbUq9UJlDcilkG2j3Qw7i8PLjGFw5y/u4++I
         WRu4ox10S0/wC7itevjuniMKXPbgbXXoffC8bDAFSrsGyqNfwj5HL4MpMvENTvHmegRB
         rT5Q==
X-Gm-Message-State: APjAAAXkfHCfftOvfYT1GbKpHl85leVT0FaY5OVXgTshCJk/NWaxp/SS
        3Ly7CNkLhjqNuz9YOVYYlPA=
X-Google-Smtp-Source: APXvYqxzwU67lBDuZFQBCO0Y5VsmvkdX6iS63NNABeAn+1Rd9gn5Q9VyfrdQIQtz+lHvcWeRXOKNkg==
X-Received: by 2002:ae9:ebcf:: with SMTP id b198mr41489149qkg.129.1554255721955;
        Tue, 02 Apr 2019 18:42:01 -0700 (PDT)
Received: from bear.ic.unicamp.br (wifi-177-220-85-4.wifi.ic.unicamp.br. [177.220.85.4])
        by smtp.gmail.com with ESMTPSA id z8sm9532497qth.62.2019.04.02.18.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Apr 2019 18:42:01 -0700 (PDT)
From:   Cristiano Borges Cardoso <cristianoborgescardoso@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, cristianoborgescardoso@gmail.com
Subject: [PATCH] staging: zoran: fix brace in the wrong line
Date:   Tue,  2 Apr 2019 21:40:10 -0400
Message-Id: <1554255610-31746-1-git-send-email-cristianoborgescardoso@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following error from checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: Cristiano Borges Cardoso <cristianoborgescardoso@gmail.com>
---
 drivers/staging/media/zoran/zoran_card.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index a6b9ebd..ab3e39d 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -1148,8 +1148,7 @@ static struct videocodec_master *zoran_setup_videocodec(struct zoran *zr,
 	strlcpy(m->name, ZR_DEVNAME(zr), sizeof(m->name));
 	m->data = zr;
 
-	switch (type)
-	{
+	switch (type) {
 	case CODEC_TYPE_ZR36060:
 		m->readreg = zr36060_read;
 		m->writereg = zr36060_write;
-- 
2.7.4

