Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE83AC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EE1205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm8y6I5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfF0Rk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:40:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34875 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfF0Rk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:40:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so1590795pfd.2;
        Thu, 27 Jun 2019 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N8TVQBF/QL49yVSkOnME0X2To16k6lZYQYirwSFcr9Q=;
        b=Vm8y6I5jmFwkXeu+AGRjbb3mc4CG3NUc6vBd3BASRntsR22encI0RsW2uIeqsqIbbL
         XVauSexa8ZceR1MDT1zObfT2xOn/6qrz0/AH3tQV8Owlx/aI5lFQgN7QCzYSTdQq2kKv
         ez7QvwCByNaO7oCPx1vtcbzzx52HyslhSmox1nufBNkP/TTTX0BGtSXyeAaAJviVLDln
         NunmUVq2lXV4vpNPNojdUMGUpO57LMAvOxrq/cLhNCW7zfwl77NLm4XA7OejFH45MbI4
         MHX0PbOsyt2ACFeyw9iBlqtwATLieGSizKtk6/lZIr1HanKwnGvNacyexvvl0EvGfCV1
         +BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N8TVQBF/QL49yVSkOnME0X2To16k6lZYQYirwSFcr9Q=;
        b=nVPgXzlkajUnOmR4GMBX+7d9IrKjx8WdpsEqYQ+toQtlfnuuwJMDH4O0wlATlU89Wa
         LI9DlNEQHHx9Z5nT/AHiiKqKXcU7/bfX7AopudGRKIsAf7A4tTzGDGyRTSXiDKV2RqR1
         GZR+rn9ohpkcoQ8VVaIENdmrNfggXWO2byPsKMtEohFXqQ8CGWHYzLaOghVokuYdUCHt
         IIqg5GXbbX4qUvPcSAvnNrWUNvjAtDPRHorezBFeesfca48knBLDXrp2akFT49B2eFl2
         MtyCietnKKxLpEcUwEp+Yoq48+dph7IdhJwp7SigZJB9jH8j+hMKG1F/L3v90nUk1HW6
         +TOg==
X-Gm-Message-State: APjAAAXM3bbjvGsc2J8+3ymXDUZPXmNFl9h0PrKAQcBr6iuW3FSEpqVn
        hU1YObdBsKXPbO6bf/PARjk=
X-Google-Smtp-Source: APXvYqw0wFZH+YiQV9sQUIvZXQhs1dICN+a0S6DSKIamrRGVk3ZXrYkx3q85RXcRo5MhSv0JXK/SbQ==
X-Received: by 2002:a63:90c8:: with SMTP id a191mr5163457pge.112.1561657256382;
        Thu, 27 Jun 2019 10:40:56 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id a18sm6211260pjq.0.2019.06.27.10.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:40:56 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 43/87] kernel: power: replace kmalloc and memset with kzalloc
Date:   Fri, 28 Jun 2019 01:40:48 +0800
Message-Id: <20190627174048.4234-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc + memset(0) -> kzalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
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

