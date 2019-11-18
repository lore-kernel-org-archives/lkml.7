Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A40C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E00820855
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUon7z8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfKRLkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:40:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43357 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfKRLkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:40:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id 3so10260942pfb.10;
        Mon, 18 Nov 2019 03:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOFXnfI9UttC1Z7LgzJhWVz0WN42wZ1bKElBDU+oA30=;
        b=MUon7z8m+rrEHd6ZJe6iq2qqsNMgde+Pj1KVj2bsrn1AW9FhfzkGMDlcWrOegiJErG
         p0dNnt9plNpwsa/INN+GjrLDEcE4lCp4wgOnNmt6rOF0PobFgypLNg1j6itnAtgpieLq
         N24FGb0LVg8jFWgv4AwQkVq838T4n1yc3BwUe+tuaZQ0agFcET5yMH59B2ehJCmN1AGN
         J8QZuVNNaUqVhi8R5X+aPvp9CMDVKQ1AI0YN75YpbQ4TseIG8IHsSWC8A/PuZohx2Bny
         yOpylfc7X7Owr5ihGU+IsydlT7zB23mSq6Gn/koHESz8dADFGMbOXVsj+ivI/eKtV62W
         EfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOFXnfI9UttC1Z7LgzJhWVz0WN42wZ1bKElBDU+oA30=;
        b=tbjA3pw5IUlRAGOvUHN5JIEUxfG56+sME0eY9hAXUYdHGZkME8aaRHwwqJ2eDtdPWt
         WU/E18dmLb+pPpXlcno2Ve9EwCo7Lr9bcuOD6lLS7lzNlLkjCmUf2og3cIKZ9i2DaNIh
         YKzeIVenM3hrley3Jz5W+OPzK2xZtl4l+i2eiaNlG3blKbP6CUGJwc68JpyRhTuno73b
         oD/AppFD6WJDHrYifdqbzDFGKjT4IzvYPb2COO/ugVeXdVSSKUOAT83caViycAEkaCKF
         IOXmHhTngLo2r3rbdQ5mY/IwK752PTDC0sEhOUpqIDaOx6X3p4GoYOw7o7Nr5TkDba/m
         tjng==
X-Gm-Message-State: APjAAAVgi2GRytnpEgzi5OrWZ/KNCsTwDJnv1mFb0vtZEY5exxTab0Xq
        8Bv5E7BVIjUtMUN/7Au9g54=
X-Google-Smtp-Source: APXvYqw6UUuagUZ9iHverzII0rXzZ6M9070k6d0OSiDaPA4hCGV3KPPkYzx1HquTeHrKjlwZ7otGKQ==
X-Received: by 2002:a62:7dd2:: with SMTP id y201mr34379756pfc.90.1574077251007;
        Mon, 18 Nov 2019 03:40:51 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id x203sm19975752pgx.61.2019.11.18.03.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:40:50 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] media: usb: go7007: s2250-board: add missed i2c_unregister_device
Date:   Mon, 18 Nov 2019 19:40:41 +0800
Message-Id: <20191118114041.25491-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call i2c_unregister_device in remove like what is
done in probe failure.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/media/usb/go7007/s2250-board.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/go7007/s2250-board.c b/drivers/media/usb/go7007/s2250-board.c
index 49e75a1a1f3f..b9e45124673b 100644
--- a/drivers/media/usb/go7007/s2250-board.c
+++ b/drivers/media/usb/go7007/s2250-board.c
@@ -607,6 +607,7 @@ static int s2250_remove(struct i2c_client *client)
 {
 	struct s2250 *state = to_state(i2c_get_clientdata(client));
 
+	i2c_unregister_device(state->audio);
 	v4l2_device_unregister_subdev(&state->sd);
 	v4l2_ctrl_handler_free(&state->hdl);
 	kfree(state);
-- 
2.24.0

