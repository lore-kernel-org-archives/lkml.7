Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E63DC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DF9205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayNTRWaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfF0RiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:38:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44517 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfF0RiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:38:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so1570365pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3w6fpt9SMN3c36dCdkRgHrjfqJfJ1NBvhxfXSqy7Z50=;
        b=ayNTRWaEXxzJHMLpcTQt8Pg/0YkjdOV0OoyD5m9RGml3Zvp9zQt9e5oiDwYS5CvUNM
         8VMqW6jVvo3rrsRQP4A+Dyzq974KRXgQSX+R4NmoTukpkjTcLY2i7Djq2uNKkg7QSwME
         l2SdNb4i9a/KNL2c4gMtzFQ/NIARAUSMQ4SAsFk/b2lBG2Sz3tkfoh/P7WobOfZ9dm8J
         fswAmafaH/bQib3yEV7Afppbk2VXHx1KR7M7y8WHoPAXP3NcjT3xolKleqL2UozB4FrY
         ivRynImi10MUEJuyrZ4Fc89+YcIhTMJeUg8G2tv2JhJeD2xn8RedMrwJyiUGTyNBGo5r
         T3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3w6fpt9SMN3c36dCdkRgHrjfqJfJ1NBvhxfXSqy7Z50=;
        b=lWuBBmU7dc6HQC3OwReaXO7wzBXsBXm6HCc9mHFB8U0o7Wo5Raci5m8j58r9LXR9U6
         L0oWhSO6mHCz7fhBd2ThgldSxbU5EDqYD6BEMq+IYdMwenjj03BnVM7PJj8m7YcqyDy2
         xCuvE8iFIp2zMD3UryrHiuXc9dfntxfJXejgdGBvvOmbmL54rsuac47Wor+wpQmyULj0
         PI6E2Wicic0mSYNpXLcgKuLP0E6ITI/CO9b3HzTXIBTWegwvTHJW71O0wx3m+hqQEEXI
         eMEVzGGRYJVFAkl7X4wRkBAN7FSPcc52oc/i62IZtVeES9fg6cKbYdYKQZP4DmOR7/JR
         T1Fw==
X-Gm-Message-State: APjAAAUwVera9lYciYa6voYJ01Ax35u3vvNu+4rRn4NrgVQIvjFY5lTj
        7Gh3qO9cM+QuXvHjXnWfQas=
X-Google-Smtp-Source: APXvYqw0WFyPD5V3vbs0Ry11+99txLKtHkHLhH2U/ftYK0dQkvTouuL06MGOmDqS2ghvB7LAi65s3w==
X-Received: by 2002:a63:2323:: with SMTP id j35mr4859345pgj.166.1561657101161;
        Thu, 27 Jun 2019 10:38:21 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u3sm3865861pjn.5.2019.06.27.10.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:38:20 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 29/87] md: dm-integrity: replace kmalloc and memset with kzalloc
Date:   Fri, 28 Jun 2019 01:38:14 +0800
Message-Id: <20190627173814.3361-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc + memset(0) -> kzalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/md/dm-integrity.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 44e76cda087a..f5db89b28757 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3358,7 +3358,7 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
 				goto bad;
 			}
 
-			crypt_iv = kmalloc(ivsize, GFP_KERNEL);
+			crypt_iv = kzalloc(ivsize, GFP_KERNEL);
 			if (!crypt_iv) {
 				*error = "Could not allocate iv";
 				r = -ENOMEM;
@@ -3387,7 +3387,6 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
 				sg_set_buf(&sg[i], va, PAGE_SIZE);
 			}
 			sg_set_buf(&sg[i], &ic->commit_ids, sizeof ic->commit_ids);
-			memset(crypt_iv, 0x00, ivsize);
 
 			skcipher_request_set_crypt(req, sg, sg,
 						   PAGE_SIZE * ic->journal_pages + sizeof ic->commit_ids, crypt_iv);
-- 
2.11.0

