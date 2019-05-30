Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64CFC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805C023F03
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni/WNUHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfE3Uvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:51:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44770 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3Uvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:51:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id c9so1443726pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4p2pASPNTAfiZ2UGXZOOvTXaN4TIzU1kzFvlDzWyh4w=;
        b=Ni/WNUHTuyqczU++5ixUXILm5THuCZ0EU475OoqawLzRURm2VKfLiGV+pFUl8Ntrgs
         blCgw/LresMWuR97rTJ1HS8RCIy6c//cbOAPyd256w6XNodlQnc5hsxLxscadQ/Youo0
         TGMGSMRCWai2bCsS/iak91jtqyV6sGg2Fvjtrb2tSRqayjNKRzDZpS7DmZg7o60MriLZ
         xfoHQWgk0OJga2kACCQHlOLyl2mMus3xz7/EFHg0hdjWSPM2Pifo+TCIOSJaAdOsxkNW
         DNwptNA7+YgW8aSu5mx0aVgBhjc8k7SORjyfEfFZnS4fouDmkbYU0K6S/VcVDm/tTSwe
         iP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4p2pASPNTAfiZ2UGXZOOvTXaN4TIzU1kzFvlDzWyh4w=;
        b=gkNCrTKJS9c72qUTh7mHV4iNQSt2WdQUVWGBY8p/BH6bb0FmUoRmu3D6Fqms2NOPl7
         fk9ZLnO8goMOaWON1d59aPUt+E/TLE6yqxLAw0qz8PLt63n4tlC8884Xnz/LjOulFh5s
         Zq8O0wnllzRABAg+7joUB1i0h2E+Sv4RTuU+nsAwZol6C64dX6G0qu9H3ignjHjQS9Qp
         WBo1xoZBg0ydvIrMoFSV2B216Ag/wp/3OnsLtcfBybvJYUDlZx/vt6lfqnNkQi7ebfhn
         bEdh7GiCAJS31EsHEheFe4TgaN73rEFKcgUmV8UEMboPK3Rjs/1E2iDoUvm/zQQ9OjEd
         A5kQ==
X-Gm-Message-State: APjAAAUFgYc7wdUJGw37JU3mSyZDxKTw38Yb/peuSGjvhZGl0QzNKz3B
        tTtcbofPYc/rKIl1i43Gkck=
X-Google-Smtp-Source: APXvYqwWAiW85Itx+C8XPGlGH9S7NoFM53EicUlr+Frqg8EveM78IKun3DInNU0MYlp3eKgj2OpJcA==
X-Received: by 2002:a63:d504:: with SMTP id c4mr5381328pgg.20.1559249506701;
        Thu, 30 May 2019 13:51:46 -0700 (PDT)
Received: from localhost.localdomain ([47.15.209.13])
        by smtp.gmail.com with ESMTPSA id r185sm3995248pfc.167.2019.05.30.13.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 13:51:46 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, olsonse@umich.edu, jkhasdev@gmail.com,
        giulio.benetti@micronovasrl.com, nishadkamdar@gmail.com,
        kas.sandesh@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: comedi: Remove variable runflags
Date:   Fri, 31 May 2019 02:21:31 +0530
Message-Id: <20190530205131.29955-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable runflags and use its value directly. Issue found with
checkpatch.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/comedi/comedi_fops.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index f6d1287c7b83..b84ee9293903 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -676,16 +676,12 @@ EXPORT_SYMBOL_GPL(comedi_is_subdevice_running);
 
 static bool __comedi_is_subdevice_running(struct comedi_subdevice *s)
 {
-	unsigned int runflags = __comedi_get_subdevice_runflags(s);
-
-	return comedi_is_runflags_running(runflags);
+	return comedi_is_runflags_running(__comedi_get_subdevice_runflags(s));
 }
 
 bool comedi_can_auto_free_spriv(struct comedi_subdevice *s)
 {
-	unsigned int runflags = __comedi_get_subdevice_runflags(s);
-
-	return runflags & COMEDI_SRF_FREE_SPRIV;
+	return __comedi_get_subdevice_runflags(s) & COMEDI_SRF_FREE_SPRIV;
 }
 
 /**
-- 
2.19.1

