Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F209DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A39218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWxBmQPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfGCQ3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:29:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34654 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGCQ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:29:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so1533269plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4vkamgkuNEJ7lFH9BkYtAYDf6iohWhVIL8l34Dz6df0=;
        b=aWxBmQPh9r1u+33C34XTcgpv9TlOL27ETdEeHRmq137xTTqgp6OMNBvFWN+OmzMTJL
         Mlb1fZ3mPdAwmUDzuK7JivDbIAYEXZ4hkkAek+Pm3RQbKK6kCzhArq1IByahv8znST7W
         6YJqBV+8QaqLCNKv1W3AvG0oT7ht0ZKTfLX/saxRvwSEhGekXj5hR45MEQgexCY7IRqG
         7JbrojKCjJ51pU5MIkTM7JFV6mfSKvPBy5OHAcMkzS+e8/EADy1EgcB7Fppqo1+HadUy
         wYgOSGdcL30M8nc04Ks7aDS/RbHxaDiE5yqpLVPKiMCA6U1k/PJESm5OZpbJSFPYaUW6
         uF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4vkamgkuNEJ7lFH9BkYtAYDf6iohWhVIL8l34Dz6df0=;
        b=fMinAv3liWki95h+G2X3sf2AQ+fBg9iuGcxvZmBnU82owEafFpbDyfAi2KTNBH2MsG
         rqzWIncpli8a6M9CYLthBLO8WII9njilIBCkxfTL2WzZYD5HgpXtt0UMK70vLJVKW2+J
         8eKwnDXwcbU+hgU4sJHYZYCIN13BgZHV1StCyqVVCvdxlutTNJpEfqY8QdGmq+x6ynys
         55KEqdocU3km3e7jihOa8DGoqmJcMeBfNYOfu9bQxwSy9082DngKk9CEnYmizEom8Qvw
         EniMnyXTLWrFflfRFvpHZLh4IBW56WImXGRKHQ6ogOha5mjCz1UXWncYHyxFEmEKlLgb
         pZ6A==
X-Gm-Message-State: APjAAAUS5O0YPZYDlGw/DuCZvMS73FcTJHOXdb7Y0e6yHiIA3LOIO/F0
        8cIcOY1uluS3jjPsHrqHlN0JDU5PeYE=
X-Google-Smtp-Source: APXvYqztlOodDLZoKy+0zOyDry+38yLWxJUs3qIFjXVeL+Aa8ke6SMCwc5rtH7GpTupHFrdHo/xnTg==
X-Received: by 2002:a17:902:aa0a:: with SMTP id be10mr43900098plb.27.1562171389631;
        Wed, 03 Jul 2019 09:29:49 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u5sm2612875pgp.19.2019.07.03.09.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:29:49 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 19/35] pcmcia: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:29:43 +0800
Message-Id: <20190703162943.32691-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 drivers/pcmcia/cistpl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index abd029945cc8..eff91726f121 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -414,14 +414,13 @@ int pcmcia_replace_cis(struct pcmcia_socket *s,
 	}
 	mutex_lock(&s->ops_mutex);
 	kfree(s->fake_cis);
-	s->fake_cis = kmalloc(len, GFP_KERNEL);
+	s->fake_cis = kmemdup(data, len, GFP_KERNEL);
 	if (s->fake_cis == NULL) {
 		dev_warn(&s->dev, "no memory to replace CIS\n");
 		mutex_unlock(&s->ops_mutex);
 		return -ENOMEM;
 	}
 	s->fake_cis_len = len;
-	memcpy(s->fake_cis, data, len);
 	dev_info(&s->dev, "Using replacement CIS\n");
 	mutex_unlock(&s->ops_mutex);
 	return 0;
-- 
2.11.0

