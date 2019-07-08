Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43455C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1745B2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dkzm6Eb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405332AbfGHV5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:57:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44788 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfGHV5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:57:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so5859193plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Y8CJuOKko9oJgtG5ahZnBbPtRn/eAy/zK84EmYdDcE=;
        b=Dkzm6Eb5DfT4NvKzpfAkELMDAMLcQEZY/Cb31xOomSzhah3o7N86ZvR3KGEHNtLhM1
         p5H0b7SNVaY771X3Dag1dXFnRBntxiVTVARHO7XFmCRfJ9cmoRfwXBsyBMy9rdvYOukQ
         ZEOirWuMSxvoO/AmXosAfGxTZL7rDf0y2zx5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Y8CJuOKko9oJgtG5ahZnBbPtRn/eAy/zK84EmYdDcE=;
        b=hLsYVu4Pm3HFTryO3uBhN2ma+EqqB+4Vd2uO7dJdKR0tA+iaDNe72AdEzPXWjN/8mC
         J9aR8tqPRGawai5p6gTpWilX+LM5Z28WkaGoCnsrHDVEgS0J0VwnN8z3Z84FUs0Q00db
         sDJPjvIduCXQ4zuPlHZLyXaeEco3IZjAu5Kbodl/pRJNogXWnHSmRGo4etCOHM14aPZd
         eXwxJRmBloypLyGrJM5uE9Jn9OVB62yEgxQqDFigu3l9XMo4Cf6iH/eGRK7exl/pd7eG
         SBJriPnoQ2RwEpJbeoQ8RLzIn4Sr3HW5qO4OQbaUksQIN900cPZ4szk4SH9cyBkQLgiq
         ffzA==
X-Gm-Message-State: APjAAAWzSu7GjY3zGacJJ002jc/ZqtuCTlzVkv4aq7bNzvoT3hMgMcTD
        hA7uBZR/awITqP3dQBQxQNl8Jw==
X-Google-Smtp-Source: APXvYqz1RDTx2QZBIo03gi0j/sbato5+lRn1n8CYyAe7jH63gLyN2lk8xM97zMB27z3dD1H4XUUI+w==
X-Received: by 2002:a17:902:28c9:: with SMTP id f67mr27995481plb.19.1562623067211;
        Mon, 08 Jul 2019 14:57:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o14sm40059368pfh.153.2019.07.08.14.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 14:57:46 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] Bluetooth: btqca: Use correct byte format for opcode of injected command
Date:   Mon,  8 Jul 2019 14:57:42 -0700
Message-Id: <20190708215742.65960-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opcode of the command injected by commit 32646db8cc28 ("Bluetooth:
btqca: inject command complete event during fw download") uses the CPU
byte format, however it should always be little endian. In practice it
shouldn't really matter, since all we need is an opcode != 0, but still
let's do things correctly and keep sparse happy.

Fixes: 32646db8cc28 ("Bluetooth: btqca: inject command complete event during fw download")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btqca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 8b33128dccee..243a95c27dcd 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -268,7 +268,7 @@ static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
 
 	evt = skb_put(skb, sizeof(*evt));
 	evt->ncmd = 1;
-	evt->opcode = QCA_HCI_CC_OPCODE;
+	evt->opcode = cpu_to_le16(QCA_HCI_CC_OPCODE);
 
 	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
 
-- 
2.22.0.410.gd8fdbe21b5-goog

