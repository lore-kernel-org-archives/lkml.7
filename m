Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E23C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 03:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C287206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 03:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUmHZvTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfEDDh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 23:37:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45064 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfEDDh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 23:37:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so3642986pgi.12;
        Fri, 03 May 2019 20:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zlQ6dBfiL4jG+H+7ODXfiGEF1Mx9HAA5I1OkQsfcDT4=;
        b=pUmHZvTdj/NE1RyG31wjZdqVvlWAeWUNdpPrp5odUQvY0nX1fcBlYkZeq3FjE3SjTU
         p8QDNxF1GMQycaDsZ9zpKLxNvjObLuV4vQgyLHpFH6RVggBhgEFRu/9xpS5ISBV9IhA4
         O3T/I+Sf0Mmk2Q2gi8iDO0Fy9nNPx3OX2y4JMIqbIka8ahxLtlqt8eC72BFfwLkketqV
         dDIT6vlSoqM/CFXQwtTclQY9gSDKFzPSIZyHBKPAMEfo6fS+OmZAtwbpCSZqyJBScLag
         lU/Nmbi5172OnH1fTDhFm6EitYCVh7ymV9ll1YGJ/l8DnmJyRCstayUNECEwoyj55vKj
         EFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zlQ6dBfiL4jG+H+7ODXfiGEF1Mx9HAA5I1OkQsfcDT4=;
        b=mqZ4fUA/z6co2obkBonK6ivc9QR3Wny0yROe3EKPtzINq4SBE97/g23Ig/VmSjAHWr
         kyOsrtt6N7YmBBoilOg7/YQgrMIk4L/S/JnNFYPg3KJb0bmAXNnXrJcwN4mVy9PTFHS7
         +3MKQIWyHaDythtpm6C/h7jXiYhH8ZHZf39QPpDwvvLqf+Iry7K7iCmfdeR5kLu/+Qn3
         AK5O69sJX+9707Stzpo9BTVX2oCQ/7/8hMlsHKT12y8HpNWdZD2ZqLREqRy5Iirw8s2g
         7RbnkJ1pNv4h2N7ho90BXR4bf/9JkvLvs8wVxr+ZSn48ROr1lYpP9LVZEic9rpAp+tV3
         4Tlw==
X-Gm-Message-State: APjAAAVOzEcX+tFkR7kuidVGa2Vniz3nMiC5MCW7lPTgL0OPqerKkDrf
        3wfkHb9PZBWcnInjCxb8+Tw=
X-Google-Smtp-Source: APXvYqwFs9WCfX5Zns1dn/waQc5SAS6QITJ6vgSKTUyyWuGBEXbL9xHN98CCy4vtFPl/cPoSYfICzQ==
X-Received: by 2002:a63:fd06:: with SMTP id d6mr15467012pgh.183.1556941076981;
        Fri, 03 May 2019 20:37:56 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id f71sm6768795pfc.109.2019.05.03.20.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 20:37:56 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: host: xhci_debugfs: Fix a null pointer dereference in xhci_debugfs_create_endpoint()
Date:   Sat,  4 May 2019 11:37:48 +0800
Message-Id: <20190504033748.17964-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In xhci_debugfs_create_slot(), kzalloc() can fail and
dev->debugfs_private will be NULL.
In xhci_debugfs_create_endpoint(), dev->debugfs_private is used without
any null-pointer check, and can cause a null pointer dereference.

To fix this bug, a null-pointer check is added in
xhci_debugfs_create_endpoint().

This bug is found by a runtime fuzzing tool named FIZZER written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/host/xhci-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index cadc01336bf8..7ba6afc7ef23 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -440,6 +440,9 @@ void xhci_debugfs_create_endpoint(struct xhci_hcd *xhci,
 	struct xhci_ep_priv	*epriv;
 	struct xhci_slot_priv	*spriv = dev->debugfs_private;
 
+	if (!spriv)
+		return;
+
 	if (spriv->eps[ep_index])
 		return;
 
-- 
2.17.0

