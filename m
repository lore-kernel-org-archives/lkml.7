Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0F7C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07E722CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTBHYoMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfIDIWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:22:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39224 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfIDIWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:22:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id bd8so2914376plb.6;
        Wed, 04 Sep 2019 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=R+MTq1VS0iR1Cmy3+6Y5RTbLGGusOaeHEDjli8lEEug=;
        b=RTBHYoMusuZZ5AhgQVW4Ifku1G8VvN4Ll0zy023Lbai0cViQEH2bR6Iui/by5YW1Ap
         Q6aYgQSGI9o/EGk+Sn2VF2wxSMZqyDRoqmknxzQNcPNtlmHeghzyeCGm/q0giQ5NFWNI
         C1HvKXxbYbV0VHTuxz6/Ip6QnSNpNZ7ZMUOImib8g8ItRoRcH8mTzwGOHTTTOy2waQ94
         nO0BsM7b0Rma+caRCrzA2ZsNaEfBYIhVnamBuZcaQOilnxF5VtbynTkCur6tN8LvjwEh
         /KdfPBtSwEEHmECBR3CasdP57gyGVdxJVcyyG2tk4EHazua53hS5K8I6uuUcqLLB9kyZ
         BY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=R+MTq1VS0iR1Cmy3+6Y5RTbLGGusOaeHEDjli8lEEug=;
        b=ohAXDD56uu8I8EfU79WHFA9dmRPW895StVjl0hOi/F4tjwvPkHV4CTodvCywqJWgvT
         INYRHEn1QbhYhb0YxwZRnlNBEw0wMMQwtJceOAzuWdLS6PkbSu2UnQd1yErzEEi6ClhO
         tlGsY1sPjUjnErdMvAsKi2kMOXRZniNgN8JqJZ6SGntpXp5f09padNgGnrB95wGqgtrj
         AguG25o8ZqWj2vL0ON+zn9jjCGuP8H+CvN6VBZ6X9FmnbbhbgXNOXyPfB/xSQQXs4epa
         /PxIOB2IA6r+j7tQHUmH4BqfEHJcX4fOqe34BQuvYFj3F6NgUHzdaVI4ZK3TrkDgVylQ
         DA5g==
X-Gm-Message-State: APjAAAWK+LdtN1ZIKgy9JlWK6obtWyOCUN94SvCDbhCpMMr6NQhv29DL
        LYBTuabRLXjfn5bTwAE0y34=
X-Google-Smtp-Source: APXvYqx1Bf1AOmUEnA9r1G5j3AiZRcryCIH6SYuoyG7V3crQWL4xyMzhyRlY+1SwI2QFZ3T3XLdMbA==
X-Received: by 2002:a17:902:8345:: with SMTP id z5mr41132525pln.29.1567585358436;
        Wed, 04 Sep 2019 01:22:38 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id y8sm22025894pfe.146.2019.09.04.01.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 01:22:37 -0700 (PDT)
Date:   Wed, 4 Sep 2019 17:22:32 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     mchehab@kernel.org, khilman@baylibre.com
Cc:     mjourdan@baylibre.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: meson: Add NULL check after the call to kmalloc()
Message-ID: <20190904082232.GA171180@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kmalloc() return NULL, the NULL pointer dereference will occur.
	new_ts->ts = ts;

Add exception check after the call to kmalloc() is made.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec_helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index f16948b..e7e56d5 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -206,6 +206,10 @@ void amvdec_add_ts_reorder(struct amvdec_session *sess, u64 ts, u32 offset)
 	unsigned long flags;
 
 	new_ts = kmalloc(sizeof(*new_ts), GFP_KERNEL);
+	if (!new_ts) {
+		dev_err(sess->core->dev, "Failed to kmalloc()\n");
+		return;
+	}
 	new_ts->ts = ts;
 	new_ts->offset = offset;
 
-- 
2.6.2

