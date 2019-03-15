Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B0CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47B22184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozLNfJmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfCOJX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:23:58 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46582 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:23:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id a132so4898580lfa.13;
        Fri, 15 Mar 2019 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQdZ5gMTmgRW87sui8cTVUjQfnuSBZPL/HI2lxsWwHc=;
        b=ozLNfJmDpEH0Dou4wey1btd4QCwR/4QLznqqOpNqaRzvpT6iicgiZhCoEXIbtgcCrR
         j4mYYV85HXZU4EHsTo/GBdxZhkLpXDVjTRNS8F2/i7QK+9SWWC+ucbP4rogFyR5deeYw
         sPRmJA8W9mv9xrnkH1et27C16pBSTCRXjSWdHQM7/TAytObRYJ+EVLPF8DrVElZHr/sI
         CCe+hOns9g7q573Hzp8HFUzLpHsfq7I7CPlWOXUI/8X3RhCnwMFRwzAtkYGtKAMVYsdc
         vv7mpAdno46XzjE8fE5THO6/UZHeWLxaWFHmjjr16DGXUK4tXRr0LLkq/mc4UER+5I+i
         Ak4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQdZ5gMTmgRW87sui8cTVUjQfnuSBZPL/HI2lxsWwHc=;
        b=e/AHefI74hpHAOTx5XxkRpodFh2BV4Nqwm5U0xNtQK9ne826mDW0N1QVu9reKVaCCo
         OK4OxA0mBm3sf8UkaVTPOKVYrjNVEgKiS5ChjbJrQyh4M969A8/rsNFHPyuBW3x5DP91
         39hXkbG1o44Bqllqz3JWvzVzmYS8sXGRqAoaAXRZ50Ujp6Y50XDjjP1NJ81yg9IgbCgq
         LpM4ETh6Ku8kZdfwv+a04yYxuk48ytfRlwIScULoBpk2+Qd+WSuJlFm4girj4E2OiEvo
         tUXnX7hNUNabBnP5rTaYQxCIYCBx0zNuIjaJdliYoKVIawchGoDiG/m0fwt2lB9Fd+3P
         +MrQ==
X-Gm-Message-State: APjAAAUTKYNV2a7yTOqNTCyZHuefiMlVBe3T/Fwut39PNZpgHo1PJKCL
        btJp6ko/edq1TqS+p0Q6b8o=
X-Google-Smtp-Source: APXvYqx5hBQdph2XB6OjPKixqCQNjW4CQhDkGxrXH3jVhUPXw55vEMJaLXcq+gpUpPoEu+4/q3PzhA==
X-Received: by 2002:a19:f51a:: with SMTP id j26mr1512860lfb.5.1552641835147;
        Fri, 15 Mar 2019 02:23:55 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id j1sm327493lfk.26.2019.03.15.02.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 02:23:54 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     andr2000@gmail.com, Volodymyr_Babchuk@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [Xen-devel][PATCH] Input: xen-kbdfront - signal the backend that we disconnect
Date:   Fri, 15 Mar 2019 11:23:48 +0200
Message-Id: <20190315092348.32613-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

While disconnecting from the backend we clean up shared resources
(event channel, ring buffer), but never let the backend know about
that. This may lead to inconsistent backend state and/or shared
resources use.
Fix this by explicitly letting the backend know that frontend has
destroyed shared resources by changing its Xen bus state accordingly.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/input/misc/xen-kbdfront.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 24bc5c5d876f..ecb6e719e0e2 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -488,6 +488,8 @@ static int xenkbd_connect_backend(struct xenbus_device *dev,
 
 static void xenkbd_disconnect_backend(struct xenkbd_info *info)
 {
+	xenbus_switch_state(info->xbdev, XenbusStateClosing);
+
 	if (info->irq >= 0)
 		unbind_from_irqhandler(info->irq, info);
 	info->irq = -1;
-- 
2.21.0

