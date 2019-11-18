Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA451C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B558B2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iacygdwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfKRIJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:09:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42765 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfKRIJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:09:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id j12so9334988plt.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MYW+ZNL3WPWeIoavfRSuSGQY9pH147ma5F+7b7hehc=;
        b=iacygdwHg/uKz5/Vh/3RDG0SQV3EHLpvpt/FfIJFNDlw6b3emc2tvkpQ5WfDNq9J+I
         Ylxx72u4YEABMLWff6n9JoqpehU3kFF82Q9p0YNk/LSAAIxOxQWGKhzpA1oN5jpRI5l6
         yT6lIWYG0lC+1XPoAHl8AdQdhhYfnFccvt51qFPB0eaIvaiRy1W8z7C02NZ51KG8sFWg
         zNe/wr8VVD+SqYGSO/PFqoNt7V8K2Xl5MAAsgpp7EfDyePDBZBytipxQ9DBNNjT5gIKg
         91De1GJLkNqdBc4QagR3CvDk9OpUWfsdrLLX1QtMZC5HF/0haZmMYkgQ0rWLQ0Lhx7Po
         pncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MYW+ZNL3WPWeIoavfRSuSGQY9pH147ma5F+7b7hehc=;
        b=XMiDyDRZxudZuIYhp9QsgaxAWPfKdT0plq0lG2t4zmGUkQbDmatzHihvV49E3V3AFD
         pLgXapX/AqVhs22M/IAycFLtgcGqt3L7pVe8rtgb6hdSLmKhrqSZQqMg/0EFAvfQHeuc
         u35f5sEek7ouzhiaIhtBMuF8o/6dFavRqM+Ic9sBRNTHafgGPBP9Av5piHLr+LPbH3Bv
         g5C1kIR6AJMAjDgQ+Jz0U76rFGEuFJOCMnuSLLg/2o7+Jh5KeGY+JOxFVEelSVyZRETl
         jt6OSj0dVJw0nOOCajXVXyflBaYhxO85xrLGFdO/uxDgZT/qGuxHj40+00ShFbbKBIsI
         LaaA==
X-Gm-Message-State: APjAAAVcbZIdfwQUQCNPgTLLDJPUflP6dFXyEGxdIW7/iygJufRyDSpY
        Hj/lz/fi3lEnUUIFUusiwLk=
X-Google-Smtp-Source: APXvYqyrRDcG/+i3KwxIJ+ALUDsjUrLAwkr0XvH7Tr8reqO8ijRG9vPbHuemyg21mOoK3L99lemwAw==
X-Received: by 2002:a17:902:8bc8:: with SMTP id r8mr28792728plo.189.1574064581033;
        Mon, 18 Nov 2019 00:09:41 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id i22sm16875330pjx.1.2019.11.18.00.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 00:09:40 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] misc: isl29020: add missed pm_runtime_disable
Date:   Mon, 18 Nov 2019 16:09:31 +0800
Message-Id: <20191118080931.30749-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call pm_runtime_disable in remove.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/misc/isl29020.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/isl29020.c b/drivers/misc/isl29020.c
index b6125620eb8f..fc5ff2805b94 100644
--- a/drivers/misc/isl29020.c
+++ b/drivers/misc/isl29020.c
@@ -173,6 +173,7 @@ static int  isl29020_probe(struct i2c_client *client,
 
 static int isl29020_remove(struct i2c_client *client)
 {
+	pm_runtime_disable(&client->dev);
 	sysfs_remove_group(&client->dev.kobj, &m_als_gr);
 	return 0;
 }
-- 
2.24.0

