Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E410C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2777B206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnD1MrCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfDVJee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:34:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33624 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDVJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:34:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id h5so5463609pfo.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uyd2xviN2IvXkdq2AdoL+zoAvgNajflM6YruKctg5AY=;
        b=fnD1MrCusBq9asUNdB0n028WwQODeb3jovYP+lzBG/grzxKOwr1OZqeP9/LznKbASU
         aFZDAKyJm4cTfaShXhpZXW+HH0bZRH5xFgNVyUnpTKjTB7i0Pjxrkr56UrF2T9fWVOuR
         U3hSGHfXVrF82E0hIlKZt2UuLdJh4IRj5wgVnOPjJwPl3VtnLLarqOV4OI+JFi3Cyv68
         iBXXbV5ZAZCoSvioa3aWYCzhP0TgWxZZ631WpM2b8OWSHaKWUB7Cv6U2gQPEgKZz0V9m
         BB6mdZCFIdW9mUHiD2fWwiKGeNLnaBT79l2WXX/iJ88JgO11ocYsvFQqWWt5a/KpeuWn
         p76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uyd2xviN2IvXkdq2AdoL+zoAvgNajflM6YruKctg5AY=;
        b=F2dLZ44eeKbPnBL/FP1ys8U2Dd9x5DVY63vAN80wRIAlbRaOt7C8mx12KElmcGFBpC
         O/4mcXNr19kLR6dpqO/oapMxzPTZf9R+QN3HxsIh1N7NVLi3DEdAFSp6VLT9XoB7wmlU
         5si6I/xTeh3gK8rl5h4GYcsi7KzAaP49vr9DNB5qbzaszWjlzCfOcWqgVM/kL+wQx8hq
         GfO3Y5NcPOMMpAqrtEkyfzS/2jn2p9L5Iinur5O2al6ZDxBuoSRQ8xkT7aKh+D8TjLhZ
         VT3In98oidKE1IicuMfuVifkaMtkmTH/pKvysYYQVuSVTjxTULXqJbQSG7SzF1NF/suM
         RMpw==
X-Gm-Message-State: APjAAAW0KgPdzrkpvFcdZEHkVBkdOa/B9XqhywwRYacDZXlKErn92UYO
        AEfa10C0zGTCbXX8MZQ9O2nZ7zWCeiuAFQ==
X-Google-Smtp-Source: APXvYqyBpmXPHrW9M7yQVFzl4tTIoktehAC1rdtZ+v+LWlRSStmIM0VxDOwtPHxQleOUNeKNRyzw7Q==
X-Received: by 2002:a62:6086:: with SMTP id u128mr19852822pfb.148.1555925673117;
        Mon, 22 Apr 2019 02:34:33 -0700 (PDT)
Received: from localhost.localdomain (ch.ptr162.ptrcloud.net. [153.122.97.60])
        by smtp.gmail.com with ESMTPSA id x8sm14609477pgp.48.2019.04.22.02.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 02:34:31 -0700 (PDT)
From:   Weikang shi <swkhack@gmail.com>
To:     john.stultz@linaro.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        swkhack@qq.com, swkhack <swkhack@gmail.com>
Subject: [PATCH] time: fix a assignment error in ntp module
Date:   Mon, 22 Apr 2019 17:34:21 +0800
Message-Id: <20190422093421.47896-1-swkhack@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: swkhack <swkhack@gmail.com>

It is meanless to check a 64bit(txc->constant) value is postive 
when the value has to be assigned to a 32 bit variable(*time_tai).
So I make a temp type conversion before the compare.

Signed-off-by: swkhack <swkhack@gmail.com>
---
 kernel/time/ntp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 92a90014a..6b454eafc 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -690,7 +690,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		time_constant = max(time_constant, 0l);
 	}
 
-	if (txc->modes & ADJ_TAI && txc->constant > 0)
+	if (txc->modes & ADJ_TAI && (int)txc->constant > 0)
 		*time_tai = txc->constant;
 
 	if (txc->modes & ADJ_OFFSET)
-- 
2.17.1

