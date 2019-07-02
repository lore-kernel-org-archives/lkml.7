Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B49C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A1320659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLcJ/Jnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfGBIAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:00:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45174 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGBIAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:00:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so7840787pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xwG3zbOxSkFKwJHrQDWkyED7nmHqX361uKJrejE5+fs=;
        b=vLcJ/JnpXqGfI3xgk5czUjy1glUD9+DQc4KFVJNSlIlj5EkUhdTlxHjYN88ydzXKlv
         /QSFytQ8RZiuqJ9GFScCTf9QvP/GEoct7rKnqmKQPMseCmDLV13b7HbVadBNNCbWh3Le
         ZbS3HnK9tpaRJ1GsNDTKqwd5sjCCH/U64tkIcJV944kCqJoiSJ1ginaPNpxhtDqLTZbC
         xsIXYD54BUAmvWNYLMM2a5r1+mAyVe8rRbqzk/5erVMlXOAWvVcScSd3aNeodkTGmE66
         Jexd+SDlbjjYW+hhDfcARzI8VU0GDKpTp/V9yQcHVWIk8mf9nS7F8woxIIsdCynaWIQF
         IZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xwG3zbOxSkFKwJHrQDWkyED7nmHqX361uKJrejE5+fs=;
        b=X+uVk8qHfQCgcdevrGmCPsuMWTf3laBePpvQgPlIBn2pd5/tWyHbHWzqET0PMoFh8w
         MjlTCfO5DVtEcc+zDybGymM4KugcItqrCH4Ay42Q2rJd6RLq9zaxOB0Dvan79UytnDp+
         F1cfpkX6u7ZTp+k+qb41c1YJMoA6RqQNIkqD9u7F2HwK4ZrR6tBVvu3fRbJv1lnuovi2
         p8ub0l9gXNIaWeBovAxhIYt/AUNSR2n+MB3lGce4a6MgrB39vrAjUABtd3z9aFxVVrcy
         5MxO8rnn8gFfQA/TqFEdWkxbPPFWGY6yAXvR+dsRGRIKZG26Wf3KhTMom+J+FZTzjdUl
         eWoA==
X-Gm-Message-State: APjAAAUkE97wptx1WQVycrtdvuy0CIWS4tdFT2ofwiwYNv4oloSL10FG
        7hbHMGUencyOMwIbzRnrDzSUaFB0h6c=
X-Google-Smtp-Source: APXvYqwxnM+GhdoWDX6nobPfGUeg+sdquW6+tE65QEcggyFm77ieZxdj5q+zdkatdDvvEi7O5KGJFw==
X-Received: by 2002:a65:4808:: with SMTP id h8mr6643469pgs.22.1562054406099;
        Tue, 02 Jul 2019 01:00:06 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id v12sm1448966pjk.13.2019.07.02.01.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 01:00:05 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 25/27] kernel: power: use kzalloc rather than kmalloc followed with memset
Date:   Tue,  2 Jul 2019 15:59:56 +0800
Message-Id: <20190702075956.24678-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use zeroing allocator instead of using allocator
followed with memset with 0

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Resend

 kernel/power/swap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index e1912ad13bdc..ca0fcb5ced71 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -974,12 +974,11 @@ static int get_swap_reader(struct swap_map_handle *handle,
 	last = handle->maps = NULL;
 	offset = swsusp_header->image;
 	while (offset) {
-		tmp = kmalloc(sizeof(*handle->maps), GFP_KERNEL);
+		tmp = kzalloc(sizeof(*handle->maps), GFP_KERNEL);
 		if (!tmp) {
 			release_swap_reader(handle);
 			return -ENOMEM;
 		}
-		memset(tmp, 0, sizeof(*tmp));
 		if (!handle->maps)
 			handle->maps = tmp;
 		if (last)
-- 
2.11.0

