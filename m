Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D041C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C3F206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WDeUlTq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfLOTBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 14:01:35 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:56952 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfLOTBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:01:34 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 47bYfP60TJz9vKb9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 19:01:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N_FDTDTTWRAg for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 13:01:33 -0600 (CST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 47bYfP4mj2z9vKZq
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 13:01:33 -0600 (CST)
Received: by mail-yb1-f197.google.com with SMTP id c6so4902270ybq.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qz7hLv3TGqOg26p7ukuVbPc1PJuaHmmS15JJ7SJDcyg=;
        b=WDeUlTq0RckidAgYO+X9nuaqk8amj5C8qSBi+Bs+62XAkYuTXYBcxgJAV+VCIY3LNs
         0Qm8E9YIXNNhn/DSgXScWghVmMWjcIHWNRRwc05ezVNjCWM3Uu5+9rjqgF/mqn9SDgC9
         dSmBX7q6cLSD5LNkShwtklXC/JeVIS+hKSpooT1Qat6uAcWIj2YCvpW6Bdgd1Vrus1G2
         yvm2GwxdHFE5quzCM0aenozhY75fuuqazgtdWIbx08jNLBHz98XuCb9jRm9ZKytFHgK5
         3bbjzxm24evQ22vf6Q9xKey05WSxW15DS+lWx0/5MDsUsIF7vNeig4wYergwmtZV7oqn
         PVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qz7hLv3TGqOg26p7ukuVbPc1PJuaHmmS15JJ7SJDcyg=;
        b=Atu9XUPJ4D0Px4Jl+QXeMIOK2sRemkPBD/bxU2i8IAnlnVZsmI+EKH0wFgWKcpfBly
         Kk1HxpIzUmlcNNiPRU/+ZlWfVjDM6z4dACXQ0yuWWAKgL0LuRDxoUoD/gIgkAK9soBaH
         dDkTRRV221KpXzBXuN3LAX2E+dTY1BZ/90kTM6IRiEDqaxsU8PGQpmscNh+fm6TJX4yK
         QHpooXjMXI8WOYGhodyNKG9cgmPNzngKttugqX5uTsGH1hRXAcR18olZkG1sO3SNKeBc
         gW6WEMp3u8788v4vLMNqaFTfY5xUqmiGGIxpPUhXe4nIiksmgvRSmagMZNgI5sBZMmGF
         2WFQ==
X-Gm-Message-State: APjAAAXLbhfFpQXYdP68cPmlW5//3GUp8Cyjmy+zsihBMe1vPTIfFsCR
        Q7r+DR1dwF0LAizIMXhNGzKuxJ7SpBh/yZ5ldN9juk+TI7mk/JpnNFxyzw6WZSnChBG4PRWqmfI
        zQKoEtS61HhDy8gx/zYiyy0Gyg35K
X-Received: by 2002:a0d:e253:: with SMTP id l80mr9334262ywe.144.1576436493176;
        Sun, 15 Dec 2019 11:01:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3YZdwihU43qkPnbxJKmlB06NwItzwFqufpU0Q7+Fs8bphzIW5aEm6q8m735lWJ3DWuSQ7fw==
X-Received: by 2002:a0d:e253:: with SMTP id l80mr9334241ywe.144.1576436492917;
        Sun, 15 Dec 2019 11:01:32 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id l20sm4937468ywa.108.2019.12.15.11.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 11:01:32 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Robert Baldyga <r.baldyga@samsung.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: s3fwrn5: replace the assertion with a WARN_ON
Date:   Sun, 15 Dec 2019 13:01:29 -0600
Message-Id: <20191215190129.1587-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In s3fwrn5_fw_recv_frame, if fw_info->rsp is not empty, the
current code causes a crash via BUG_ON. However, s3fwrn5_fw_send_msg
does not crash in such a scenario. The patch replaces the BUG_ON
by returning the error to the callers.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/nfc/s3fwrn5/firmware.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index be110d9cef02..cdc7d45237d2 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -507,7 +507,8 @@ int s3fwrn5_fw_recv_frame(struct nci_dev *ndev, struct sk_buff *skb)
 	struct s3fwrn5_info *info = nci_get_drvdata(ndev);
 	struct s3fwrn5_fw_info *fw_info = &info->fw_info;
 
-	BUG_ON(fw_info->rsp);
+	if (WARN_ON(fw_info->rsp))
+		return -EINVAL;
 
 	fw_info->rsp = skb;
 
-- 
2.20.1

