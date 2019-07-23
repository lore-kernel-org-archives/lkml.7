Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EED6C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C56218A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeafSVZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbfGWLvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:51:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35171 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387759AbfGWLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:51:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so19045058pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YvPnEK3SdKCAjuBX9biBCB7NVxnEYLiW7bXQBnDMmug=;
        b=aeafSVZv6bp61rtpugTLNYFumeoxNXomiqF7jkupIYTNhO2Ot76Zu4sYtmhAq8TWX0
         Ye5Krtmc0lE3NeSUmpQPVcZIg6dyY4DTMDrvDQ2UNj9Bp+7Tiy6i73GaA8HjZwx37sl/
         cEZaWMzbOF4UEGrFr49gTyvtW+DjAFaV/DgwHviIoEOXnVhMnacbaDiBMpPguGFdzV9n
         Ape3asxJIyVEhqBnWEzbj4kqV+bGdBW/Cm6yevmNf88qnPDcrFRRfOkDKllRpuUKxjyc
         nIU6QebT8IrprUcP4UKsZVJXqJ3iyhQxQLxToGJBYqAPLT6TTb6gAV9sg9ZEguIxDVBR
         m6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YvPnEK3SdKCAjuBX9biBCB7NVxnEYLiW7bXQBnDMmug=;
        b=PTNFdW4HJhcTg8ki5YDSwBeXraJgN2o4rnDH7++PitIGybkUNpNF+YzknO0vqLZsml
         FfI3THM7dym6gv0Vpz8vpcNA3IYW2Q5LuPd3litHF7BWY9vDPbBKNegNj8qAwhtoX0fh
         qk7cnhMROId2o7Y9HE2nfxuF5bYZ4GVeE6iM1bFjxM0WKZswUuzcd3pq43tBIAAbjvCu
         2vm0/2Am3DRoFOqfaDbfMeojzNRuGCpBgN6QdbW0pY7izQpYnNhe4+fwl4eJQ+IeIIik
         Ix6QC1DiNb1nkMPa5VPIV4W6o05qfYoGh0vhOmv0vnw3BAfqFCPtkbUsdrbF6vUIVsS9
         dOyQ==
X-Gm-Message-State: APjAAAU2FiIZkP9KsldHMEo0xGc9tCGh3X3RgP2J8S5VlKN266V8kGNa
        NJCIs4ajfF4yj5UkysbVq+8=
X-Google-Smtp-Source: APXvYqz0vZcxpn5l3V7J6D7+6xEYMUmp1v4COLoSJ7UOlRZZeHJuXIixNHxSUKeEcBVG4R2I9QrNng==
X-Received: by 2002:aa7:8c52:: with SMTP id e18mr5592458pfd.233.1563882668054;
        Tue, 23 Jul 2019 04:51:08 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id z20sm67878647pfk.72.2019.07.23.04.51.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 04:51:07 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mfd: timberdale: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 19:51:03 +0800
Message-Id: <20190723115103.18647-1-hslester96@gmail.com>
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
 drivers/mfd/timberdale.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index 60c122e9b39f..faecbca6dba3 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -626,8 +626,7 @@ static const struct mfd_cell timberdale_cells_bar2[] = {
 static ssize_t show_fw_ver(struct device *dev, struct device_attribute *attr,
 	char *buf)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct timberdale_device *priv = pci_get_drvdata(pdev);
+	struct timberdale_device *priv = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d.%d.%d\n", priv->fw.major, priv->fw.minor,
 		priv->fw.config);
-- 
2.20.1

