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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D98DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA4B26197
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGzM1Wd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfE3U6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:58:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34482 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfE3U6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:58:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so2715802pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrn+OjD0NH0CBGOOqEW6q+WwOM9u3GkanTSs5LtKkI4=;
        b=tGzM1Wd/daunUqXAddDeCwk6f2c2gFHWrAOy6ckX0aqqryO04RDdyaqZzmaVUaOu/g
         iK1uMYUXCEX1fP5kIyFBmNWPxI7F5MjOg25MS1gmAza9oH3+5ZHmghwuA/azJasU6U73
         gUIMTaK2LuOlF0lciL/oHXDuZC4kGh0SOS9/zCA17DCgjMgAoq+b+MI+31bK+j+IMAu2
         iye/EmdnWizux3TnJFJXkTpMXK3R70z0I75d9MALrtSgPm7HwWSed/RBuqkqq36HcuPB
         coJBNutnvqm+VH//GWlXouTW3yELFJWTz8+g1GTvctUNj+hpVvgQt6/82V74FfkR6Ovo
         Sy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrn+OjD0NH0CBGOOqEW6q+WwOM9u3GkanTSs5LtKkI4=;
        b=iNr5B0q8CnWCKuMDEtLcC7RMsnsGH0XKJsop7ek/cqIcP7o1YUo49cjUtWHCkMjgOl
         qw0jpoXWVt/kgVWAQzEr+wbDKByjSZWltwHwVc9uoRvl4pT0NIl7coWB061rl75M2efK
         VpoovnTPOpvk2IfwpnvXtSbwHKfPqBlq+MYE/pIpORpGJ/EjeLAbViL0vDRdlKIFKB2z
         CC66VdoaSO2toFA+Xx+I+lrs6z6DfoAMDoYq3LZZdOZwGEnkZD7pi/2G8yGEzb8nfxSx
         5l4/uxBWt1fojxE+T2CZQs8THVEToEC7t731vSuiZhdFqTzdOnt3Ix0hzp2i6wBnYP9k
         RrVQ==
X-Gm-Message-State: APjAAAUCQLglPOmmtDfdhIINAB8fBuqjhRLeG+dm6+SPl7E6rrxfmf8r
        6Z8FTqxfgbBh1Ba47uErQt6TRZB1
X-Google-Smtp-Source: APXvYqxdQMyVgDWXr+3LNuqCQNbWTAZv/boMwZTiB6sgyZEgxvni0BdYohBaSWGvQ5HfiF2RjvvCiA==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr5702732pfu.206.1559249892319;
        Thu, 30 May 2019 13:58:12 -0700 (PDT)
Received: from localhost.localdomain ([47.15.209.13])
        by smtp.gmail.com with ESMTPSA id s5sm3194982pgj.60.2019.05.30.13.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 13:58:11 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, himadri18.07@gmail.com,
        colin.king@canonical.com, straube.linux@gmail.com,
        yangx92@hotmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: Replace function r8712_free_network_queue
Date:   Fri, 31 May 2019 02:27:55 +0530
Message-Id: <20190530205755.30096-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function r8712_free_network_queue as it does nothing except call
_free_network_queue.
Rename _free_network_queue to r8712_free_network_queue (and change its
type to static) for continued use of the original functionality.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 57d8e7dceef7..f6ba3e865a30 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -151,7 +151,7 @@ static struct wlan_network *_r8712_find_network(struct  __queue *scanned_queue,
 	return pnetwork;
 }
 
-static void _free_network_queue(struct _adapter *padapter)
+void r8712_free_network_queue(struct _adapter *padapter)
 {
 	unsigned long irqL;
 	struct list_head *phead, *plist;
@@ -215,11 +215,6 @@ static struct	wlan_network *alloc_network(struct mlme_priv *pmlmepriv)
 	return _r8712_alloc_network(pmlmepriv);
 }
 
-void r8712_free_network_queue(struct _adapter *dev)
-{
-	_free_network_queue(dev);
-}
-
 /*
  * return the wlan_network with the matching addr
  * Shall be called under atomic context...
-- 
2.19.1

