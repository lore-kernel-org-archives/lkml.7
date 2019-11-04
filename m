Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911FDCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6266920848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IySF53AO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfKDVh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:37:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44862 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDVh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:37:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id g3so13216087ljl.11;
        Mon, 04 Nov 2019 13:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aM/NqY9X7bejgM2hiDB5HuQIJW6HNTiHKqYAR0ieXv4=;
        b=IySF53AOlpYLdgqECSOvm/SqmP6X9mL7yed/9oMaXDkjR5s33TJdJ+MSp92G4ScdCR
         GgX+6U7AdpDEsLnF2cSwNbOlPDEah4BMhrDKRgj//oFLqKI5pA5P+lKuIsweFet7JDw3
         1XnESNP4COm7X6smhD/1yMzWSpDRoAfwkMld0ENd9iGSA0Kh/Cy+gcrldtA6msmcGVTh
         KUOPR0pI5wVmoiG5wIodkQHSm7FJjRx5JnkzUe8sCIPK6cXxCQstLPT6mmDjvdYGWKg3
         IMLLoJNcGudGgpMzULjwA9iEiEIz5MTPsSyZSUBpZdE3MMvV624O3bXyhY48D+y4ulcs
         hUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aM/NqY9X7bejgM2hiDB5HuQIJW6HNTiHKqYAR0ieXv4=;
        b=PE+cL9oodzyCJL25xqvLik6AL9XtZ0S00KaHTPF7NMd/YhM4xXXeO0MRhSgkJKR3Zk
         CDTLvNMdaoeUpAVUECGJg0vkVPBcpXfuomtLb2M3q7V/Iky9ryyMYVKRDfa+OHK1rlXw
         RlkLJ79NKhmwfKfidVtZ+slIOZ4LkflZAUt0Bk7A8vrirbE5EoNx6Q4dcS6sOEalHW5Y
         vMRI1BmLUOIn3SABJv9pDIrPlLCNDAKPW56WuMGhujkPUqueh2EBxHou6TEjYru+stIv
         lIuw9/o62BuO275TMtgKTKrySREHEU1Zcp+p7Ruu0n6SGiDf2NOmTDZFL7bk9IkGIm8q
         NC5Q==
X-Gm-Message-State: APjAAAV4L31ltpq/lTvZUTAn9f17ZHM9xiTW/xAP4J4S/ZkBnDo+bZDm
        6amtb9S6DL+Px2zcO0Xw/GXQQAYWQVs=
X-Google-Smtp-Source: APXvYqweBtEACZoySgQRDylgmupur12Ksn/LyXpt5c/NUN1boQKhzk0ZLsWyYraI07kiv4MxojGhLw==
X-Received: by 2002:a2e:9417:: with SMTP id i23mr8216022ljh.152.1572903444210;
        Mon, 04 Nov 2019 13:37:24 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id i18sm9162243lfc.82.2019.11.04.13.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 13:37:23 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v2 1/3] platform/x86: asus_wmi: Fix return value of fan_boost_mode_store
Date:   Mon,  4 Nov 2019 23:37:07 +0200
Message-Id: <20191104213707.18170-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104213417.18036-1-leonmaxx@gmail.com>
References: <20191104213417.18036-1-leonmaxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function fan_boost_mode_store should return number of bytes written
but instead it returns return value of kstrtou8 which is 0 if
conversion is succefull. This leads to infinite loop after any
write to it's SysFS entry.

Fixes: b096f626a682 ("platform/x86: asus-wmi: Switch fan boost mode")
Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e..723aa4d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1718,7 +1718,7 @@ static ssize_t fan_boost_mode_store(struct device *dev,
 	asus->fan_boost_mode = new_mode;
 	fan_boost_mode_write(asus);
 
-	return result;
+	return count;
 }
 
 // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
-- 
1.8.3.1

