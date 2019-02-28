Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C6BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF63218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJU1fydQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbfB1UAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:00:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39226 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfB1UAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:00:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id p27so18055272edc.6;
        Thu, 28 Feb 2019 12:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P5d0IpC9+OQBZ06GUKeAyQaVv2n5VwfxrOk9sixHGqU=;
        b=sJU1fydQkoQZM04SXg/BtMFnBqkRmYRczKTqJ2EGbtlUv3NIcA3eiI7IKjs2rznhOu
         kWAVaZSM3924lCvXIAQLHsIGVrGR04MpQ0F98pDeOWKYvOzZvoozMEa1y35hFwrPMY+n
         RVkn2LTL8NH7AC9fiQ5XdTJRwOWw89onTuqod0VsRZxgStRaCKejt1JA2aalCgwhS+gq
         7qQkNLCYsrLKK7SA86/2hVKjf2WD1V0nAZVX+iacIUMR8vPtyoaYyeXFg73VaO0zhnnn
         V1sXuR00sY6CW1ClXdvdKH7qcWi0fjXFY/CznnMZ/pzwWZqLjN819vowq1ZhuDYuqLKl
         vUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P5d0IpC9+OQBZ06GUKeAyQaVv2n5VwfxrOk9sixHGqU=;
        b=ISi0rmffyh4JMLMYbXpcnD3hVKcrCslgRKfAq18+JKGPT5ScizzGDLESNa25N+cyt3
         TW5hX1udiMtmxITXP2QJimQvXnfoL7Bk2QuV/HA0F94UjoOvpJwu8d4VP9Vltn9XfmGF
         ZsRGskx08sq4JbYu9P0xAsT7ND0jnvkGvJ8FihgwoNVsV8/Ry1afWsmp/m3+NXXm+nau
         9xdzEnMviYp8up1c/kyrVml8SjxEL+K3DBKY6BzCTK7fdEp9lrYeOuFpfkDYkyma+Io1
         3KfJp+yuJyw4+9IoooieE+eMn7mQJORJxjvUyI/WuIVsjKYC6pO0eJOn9qlf4XG02D7U
         1IlQ==
X-Gm-Message-State: APjAAAUaTV0AxlvaBgnvYy83SltDvMyoSEZseSB4rFgFiopnu14Yj3+R
        +4kDfKxmetk0BZKJ+AX9DBI=
X-Google-Smtp-Source: APXvYqzknvkeUltcg0gERi7w7C7/3SB/m8QZdIrEvcp2GXO6OIJeFBO5Y1cy5mETwhXYTLi+gFF5HA==
X-Received: by 2002:a17:906:2643:: with SMTP id i3mr379149ejc.157.1551384007112;
        Thu, 28 Feb 2019 12:00:07 -0800 (PST)
Received: from localhost.localdomain (xd520f248.cust.hiper.dk. [213.32.242.72])
        by smtp.gmail.com with ESMTPSA id r1sm1353743eds.39.2019.02.28.12.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 12:00:06 -0800 (PST)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] net/bluetooth: Fix bound check in event handling
Date:   Thu, 28 Feb 2019 20:59:39 +0100
Message-Id: <20190228195939.30685-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hci_inquiry_result_with_rssi_evt() can perform out of bound reads
on skb->data as a bound check is missing.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com
Reported-by: syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com
---
Syzkaler reports:
https://syzkaller.appspot.com/bug?id=d708485af9edc3af35f3b4d554e827c6c8bf6b0f
https://syzkaller.appspot.com/bug?id=3acd1155d48a5acc5d76711568b04926945a6885

 net/bluetooth/hci_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ac2826ce162b..aa953d23bb72 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3983,6 +3983,10 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 		for (; num_rsp; num_rsp--, info++) {
 			u32 flags;
 
+			if ((void *)(info + sizeof(info)) >
+			   (void *)(skb->data + skb->len))
+				break;
+
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
-- 
2.11.0

