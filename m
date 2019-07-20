Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D381C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B317F2082A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KqK59Wdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfGTGSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 02:18:09 -0400
Received: from m12-16.163.com ([220.181.12.16]:46455 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfGTGSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 02:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=qfrh/qNDQzOKN+bqco
        zbOiHMi58D2XB+uMUBNViNjCA=; b=KqK59WdhgG+CG1hqHP2HeSD2TloalNirEa
        tBn1dSGykJqUpZ7EfmhAQQ4x6C/4TY+0xvRe8Msl9cnW0oee/fnckswNOxQ8paRF
        5YbGPm0k1AeTgOWpDFOEyizCy3WrXn6f7wnbV1hhkGNOd2E8r00BwgQfA/IAcCZy
        co8ICpB6w=
Received: from localhost.localdomain (unknown [115.238.52.186])
        by smtp12 (Coremail) with SMTP id EMCowABnHPkKsjJd4ubyBw--.57414S3;
        Sat, 20 Jul 2019 14:17:48 +0800 (CST)
From:   lsh <linsheng_111@163.com>
To:     tglx@linutronix.de
Cc:     sboyd@kernel.org, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, lsh <410860423@qq.com>
Subject: [alsa-devel][PATCH] Signed-off-by: lsh <410860423@qq.com>
Date:   Sat, 20 Jul 2019 14:17:45 +0800
Message-Id: <94b6bb5f3ba41fe87bf5207e08f75e8dfe17ef18.1563599043.git.410860423@qq.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowABnHPkKsjJd4ubyBw--.57414S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF15KF4DAw1ktFyrWr4rKrg_yoW3GrgEg3
        47XF4v9F4DAr92kr4UAws5ZFyktrWUtF18Z347KFZFyr1UtFyrJ3s7AFs8XrnxZ3y8WrWv
        yFs5JrZ0yr1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn4mh5UUUUU==
X-Originating-IP: [115.238.52.186]
X-CM-SenderInfo: polq2x5hqjsiirr6il2tof0z/1tbiORv3OlXlnaUacwAAsO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lsh <410860423@qq.com>

Modification of leap seconds from 58 59 59 00 to 58 59 00 00
---
 kernel/time/ntp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 65eb796..7edae41 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -425,7 +425,6 @@ int second_overflow(time64_t secs)
 			ntp_next_leap_sec = TIME64_MAX;
 			time_state = TIME_OK;
 		} else if (secs == ntp_next_leap_sec) {
-			leap = -1;
 			time_state = TIME_OOP;
 			printk(KERN_NOTICE
 				"Clock: inserting leap second 23:59:60 UTC\n");
@@ -444,6 +443,7 @@ int second_overflow(time64_t secs)
 		}
 		break;
 	case TIME_OOP:
+		leap = -1;
 		ntp_next_leap_sec = TIME64_MAX;
 		time_state = TIME_WAIT;
 		break;
-- 
2.7.4


