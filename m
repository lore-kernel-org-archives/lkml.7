Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD07C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B552083B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2mAm1/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbfGYKRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:17:24 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:53689 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389964AbfGYKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:17:24 -0400
Received: by mail-qt1-f202.google.com with SMTP id h47so44084539qtc.20
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rXX11AjyQuD935u7SKRoBuP7afkJ+xWzYBIlfHye+X8=;
        b=b2mAm1/hRFViu1qAaAEr/is+f/ZvFExXE1GC8GPFxXM5Oh3xQjlD+bDi8P4DYJDIMH
         1vCbJG3/ha9+WnyKjVvqkX4CRYI8hXsooTFW9JMRMkHZbt06bcaLV1UdlZ6WirW6Lrly
         +lBEV0//qHx1iEW5x8Z1Xc/fmBOQp7ZxpGKH1JErRqEQrqEul4hMwSgldff37XrljF3s
         QjKhnmtZvneDu4f831lT9fY06YbJe6KvxnmluQr2XvGOOUn0vZVsZcgpWkOW/Qrif/Nb
         FXW4ToMoPhIX1OaMWTlFi/Sh/2hrwVK1MWV0uLePijkEJDJW4Pj3yidJj7WZLYZX4ICL
         J75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rXX11AjyQuD935u7SKRoBuP7afkJ+xWzYBIlfHye+X8=;
        b=MCgv7KTNMZAn8nPgQmeF0ejQMeYFxwhKpl1sg/TSRq++jDcHnMSbuiqbzZHX8yMPoi
         2bSbTxNcul8whVtX3iYo00GyrHrqeJTBX5AYic2hsqrT4x+j7NHjbieiZnYEoC3KFKEu
         qDEWIaZe/ig5Zx44FlX0HKbc3x01W9pCYlwKF6J2Fzwz8PDniHDed5JoTrtOFWsyw4vP
         zEtjMeiViq2q6FQ8OGVUEYKEw2868FwZN9YL6Ew7SN8pABm1vUhMLLA7aBauH5FVzBUJ
         bhqueherzb1th+eWiZDM80uwm6WyixPtvYzKngWAi4NNNwNXCizhw/gxvbr16EenVBnJ
         lMRA==
X-Gm-Message-State: APjAAAXlkZG5UBmHfba1x3Cyq/3Cws+H3OCs5jQDW1M1zqYuAKL8PFUS
        3jFHzGs+Ri7Cgt2hp97GC/9OTwDl5FwP9AhoDi6vpWzNrqtxaGM55t6D6aCUBf5P/o2KyyxqZaR
        +8CX87+A7y2vgFELg6tRA8f44xDLv1caIGcVSp9VPOToAJsmXwgTWBX5YvScynzTVEzidk0jQ/n
        Y=
X-Google-Smtp-Source: APXvYqxBkUx3OB9AnodCJLYXKAqemprxCeJzpAG2HhDupTNgGvR5sdJbJe0flZps2HFHPb8qf3AnWARdOAwZCA==
X-Received: by 2002:a05:6214:1c5:: with SMTP id c5mr36521290qvt.97.1564049843229;
 Thu, 25 Jul 2019 03:17:23 -0700 (PDT)
Date:   Thu, 25 Jul 2019 11:17:04 +0100
Message-Id: <20190725101705.179924-1-maennich@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH] coccinelle: api/atomic_as_refcounter: add SPDX License Identifier
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Matthias Maennich <maennich@google.com>,
        linux-spdx@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing GPLv2 SPDX license identifier.

It appears this single file was missing from 7f904d7e1f3e ("treewide:
Replace GPLv2 boilerplate/reference with SPDX - rule 505"), which
addressed all other files in scripts/coccinelle. Hence I added
GPL-2.0-only consitently with the mentioned patch.

Cc: linux-spdx@vger.kernel.org
Cc: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 988120e0fd67..0f78d94abc35 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 // Check if refcount_t type and API should be used
 // instead of atomic_t type when dealing with refcounters
 //
-- 
2.22.0.657.g960e92d24f-goog

