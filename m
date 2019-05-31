Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC448C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E9D26C26
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="f/GyB5Aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfEaQaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:30:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45129 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:30:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id t1so1537642qtc.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Q5G8+82ntOUP6LsPY/2FoFYtaIUU0yVJDral6+z2qOM=;
        b=f/GyB5AjpKNQpbIgXn1dL/HsR1xUokrKYkDcpzYtXRAlsDBOGwokCPAaMLbb8OnyNe
         MmXj1kMMS/VOy41vMPmph5ei+NB6KGqNIPKz/8CpysWcD6Uw8JY6UOFwLuy3/R+QJt/a
         CP7lMVo5defF9kNZhZUx134A8NolLuVAHub3M51cg6MMtyVyEF0tH38vOoGdZA84SbwG
         r+RvULz1qN+CUNW/pkVA8+YRy+bIsnl/eVz19dlVqFHFoiodl0MrGcmENHdizvbomriG
         bBJ8PzXbqczvWrUalngcVbk00UaMX+XBHoO8GgxE17t5lZgR2V/6FBe20ya6yybIiZtr
         M40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q5G8+82ntOUP6LsPY/2FoFYtaIUU0yVJDral6+z2qOM=;
        b=Di6kjKKNIs0lzl6MZFLybOjkVIk7y1s5XKfNTdlHDQDoV+6NxGuxcqVxdqkI17Qr3Y
         bnw7rhtmMe2r5UpFWN2sl8wWNuNO49I00Lf7tavNzfMUb4jFgi1RAUCQMSd9hGKt4Mc5
         35Ev8I0CvO+mBNVfPZ4i9beA7NhY4qdFVaNPpZ7igDshli5czH1OBScM2tpWGFeXpTCL
         P+IDmJ+7tkAdhTOeTJ/sRjB/VVMS8dhOt7p5c30VP8MKF9LeNIYFJe3cZTKyVp60OPW2
         5X3TK82Ogq9SorlQaGImE1Z4RliDqBzkxbTWF5QiTF7Nr85z4JQ48jrE8skhuj1LaYrf
         0dww==
X-Gm-Message-State: APjAAAVk6cQ/sCeIxqVrLxRFZUEq3GIjV2VnKQedRHclw9ZDoxCIXMRf
        NO1DAuMxu9nUzRiVehpAkKVsae9bV6c=
X-Google-Smtp-Source: APXvYqwh0MZsXG7rMTmxjY1aYZor4YQ3T8qzjntqPH4bM9WwE22dEwE5LPtml1s2IhWnws4mwHunBg==
X-Received: by 2002:aed:237b:: with SMTP id i56mr9727574qtc.370.1559320228181;
        Fri, 31 May 2019 09:30:28 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f33sm4533179qtf.64.2019.05.31.09.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:30:27 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] drivers/base/memory: fix a compilation warning
Date:   Fri, 31 May 2019 12:29:46 -0400
Message-Id: <1559320186-28337-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit 8553938ba3bd ("drivers/base/memory: pass a
block_id to init_memory_block()") left an unused variable,

drivers/base/memory.c: In function 'add_memory_block':
drivers/base/memory.c:697:33: warning: variable 'section_nr' set but not
used [-Wunused-but-set-variable]

Also, rework the code logic a bit.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/base/memory.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f28efb0bf5c7..826dd76f662e 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -694,17 +694,13 @@ static int init_memory_block(struct memory_block **memory, int block_id,
 static int add_memory_block(int base_section_nr)
 {
 	struct memory_block *mem;
-	int i, ret, section_count = 0, section_nr;
+	int i, ret, section_count = 0;
 
 	for (i = base_section_nr;
 	     i < base_section_nr + sections_per_block;
-	     i++) {
-		if (!present_section_nr(i))
-			continue;
-		if (section_count == 0)
-			section_nr = i;
-		section_count++;
-	}
+	     i++)
+		if (present_section_nr(i))
+			section_count++;
 
 	if (section_count == 0)
 		return 0;
-- 
1.8.3.1

