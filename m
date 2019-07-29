Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C81C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289AC214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo/5Z10v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbfG2Ltn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:49:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47094 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387482AbfG2Ltn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:49:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id c3so4772434pfa.13;
        Mon, 29 Jul 2019 04:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t4LrUjq6T4dirnuW+FmcNbvRfUA+DI+0HKJt+m2bWqc=;
        b=eo/5Z10vJWswbhZ9Liy5f3E/5hKOoioHrjunY9OWkIDNBuYO9CPUY4Hep3kZuuOR92
         /ncIb+PR8zLWvRXC8k6awPKhRgY4Qa+qQBpLG3vER8qVzic5LUM7Pi7kneKywt8AKkS3
         terYnDeO56bO1rs86xancM02QDKUuh9dLzQDiTFzxTCslCHTvUPVpzAOkBtjzfgaBhtn
         iYLV4kE6GZzDTXXi7pKoe28TApuM4Bsd7xHbkzgqhfIWdpW44cgdqoHPVX3hBG0jz37c
         3ATMEIXYebV6LRFQq77V2j+24/US12CJWXpKpvi5XbjuriwQuUZFlIw9f3vh6GakZF3i
         qk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t4LrUjq6T4dirnuW+FmcNbvRfUA+DI+0HKJt+m2bWqc=;
        b=sWV5TtZr9iA/wM95iXdsZ53WFk1DbBAQzzgaV5d0twepgDoFkTUtgLaGvkTHnWIXaR
         bf8zyA148370qfHNhsLImV2/oNSYYdwe8Y/nJCyP1f6oLrEbt64p1+AVmh2eWvvqKNOn
         HapHRnifphf9DPReSvU6kQ4S8rSMekzWkdFSxsOU19e3EOo4WPzGHK/5WIenI138qXbe
         puYfUIf14TXoYiK2eHQtVwjRoYmgoVef+UO3aBSVWw1zz45xGFsgAQ8nTIE0f2YvPH88
         KPsBYkfq6CQbujfezVEISi6YarL9wv4EDcBnbR9qVIB3mjl5qUA1Ei6iAcmZZkvKUUgc
         cJvA==
X-Gm-Message-State: APjAAAXHyOonSisXabpqnSHydIRrU1tPKSaxy97dL9iQ5Elej5Rlzc1L
        jIhdYrUD/FHRXcjdJekBLQE=
X-Google-Smtp-Source: APXvYqy33Qp2byQh79yNYIetAkyhvaxtnAn6cxcHG55JXV0s6XNNCvNvnKJUszQYhHI+enW0sLmk/A==
X-Received: by 2002:a63:2252:: with SMTP id t18mr104148160pgm.5.1564400982701;
        Mon, 29 Jul 2019 04:49:42 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id x1sm50673215pjo.4.2019.07.29.04.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 04:49:42 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] usb: storage: sddr55: Fix a possible null-pointer dereference in sddr55_transport()
Date:   Mon, 29 Jul 2019 19:49:36 +0800
Message-Id: <20190729114936.6103-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sddr55_transport(), there is an if statement on line 836 to check
whether info->lba_to_pba is NULL:
    if (info->lba_to_pba == NULL || ...)

When info->lba_to_pba is NULL, it is used on line 948:
    pba = info->lba_to_pba[lba];

Thus, a possible null-pointer dereference may occur.

To fix this bug, info->lba_to_pba is checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Avoid uninitialized access of pba.
  Thank Oliver for helpful advice.

---
 drivers/usb/storage/sddr55.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index b8527c55335b..d23aff16091e 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -945,7 +945,7 @@ static int sddr55_transport(struct scsi_cmnd *srb, struct us_data *us)
 			return USB_STOR_TRANSPORT_FAILED;
 		}
 
-		pba = info->lba_to_pba[lba];
+		pba = info->lba_to_pba ? info->lba_to_pba[lba] : 0;
 
 		if (srb->cmnd[0] == WRITE_10) {
 			usb_stor_dbg(us, "WRITE_10: write block %04X (LBA %04X) page %01X pages %d\n",
-- 
2.17.0

