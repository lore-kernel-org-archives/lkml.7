Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EEDC282E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA9A217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="TepqwyGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390930AbfEXLIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:08:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33517 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390899AbfEXLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:08:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so8330034ljw.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAvZ7xj95SMRrKYxH9qEvr9i1qrJFj725G1wpBk6k3k=;
        b=TepqwyGsrr6ZmIQQ5JbjX8UOlMPfueXgawl7wIuu67ovdxoh8nlQWkvWxwhS13Fzm5
         YNpi4AU4flnplF2AQZXBYC8FE3AsBhgC6mEhC/udXImAPKbLV7KXHevPZtV4SbHP3L/+
         Td4tBY5ljWNOYXmh2oKbnAAlV5stOcSwex5zko0vZpYAyYrS6NYg7j06yJH4aLPdEvw1
         jRmb5r0UFEG7jwhbBGfa+Z0rKjPTAeKdvUHzRl311t39paEQ4un2CPQFoQhxO/WsIZtg
         zz8U8kHyaUS+A1XV1a8V43OUp/gP30gGMa8QAoX62fXsRuvKkdI/qVSTfV9LJSzjPe3/
         1S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAvZ7xj95SMRrKYxH9qEvr9i1qrJFj725G1wpBk6k3k=;
        b=VeIbTLGQ51Vq0MekPZD8x2t0xSX1xhTjfet2Xh5yjKuSOUsGyXWx0ZHyDj+Iam5Mq3
         HJCmE+rJkUbUDqtWxfS+w6+AvWA7X7659pEkYZByCW/NYONlcR+ETU+OMJ9jA52NQJSR
         LK+Ha9v63x3BLseQyXS9/+N0rxEyV3rFGLS1jdRyJdh7XTeWRGt7bL2yGOCZsSvNcR2w
         djOWLE/7Hk83mbzsSNkWUnFKbKfEGidhmdmg/4hMf5L/Okefw+VrvZbYMB/uKQ02Yt9G
         67Ga5IbCM4thZQUYB+ZnJ8bbockRwqYJ9VfapardZFz+VVN5g/+2vvhvls04dElEQhtu
         oSSw==
X-Gm-Message-State: APjAAAVC60SyrYvBp/DFYOyJqWaS5bQQr6vLd8vYRIhvm7g761ur23wj
        aoLByh1c5wRZVuDSfZMq5V83jw==
X-Google-Smtp-Source: APXvYqxuHN4jHLGtTMz3O5gVPczqJGqhlNeokkeU7WVtizNaTt6GKvt2dtBQcBE+pjVbEgc5gVuVfw==
X-Received: by 2002:a2e:9142:: with SMTP id q2mr1385520ljg.18.1558696092844;
        Fri, 24 May 2019 04:08:12 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x21sm446234ljj.43.2019.05.24.04.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:08:12 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: kpc2000: remove extra spaces in core.c
Date:   Fri, 24 May 2019 13:08:02 +0200
Message-Id: <20190524110802.2953-5-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524110802.2953-1-simon@nikanor.nu>
References: <20190524110802.2953-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl error "foo __init  bar" should be "foo __init bar"
and "foo __exit  bar" should be "foo __exit bar".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index bb3b427a72b1..3b240eff62b7 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -655,7 +655,7 @@ static struct pci_driver kp2000_driver_inst = {
 	.remove =	kp2000_pcie_remove,
 };
 
-static int __init  kp2000_pcie_init(void)
+static int __init kp2000_pcie_init(void)
 {
 	kpc_uio_class = class_create(THIS_MODULE, "kpc_uio");
 	if (IS_ERR(kpc_uio_class))
@@ -666,7 +666,7 @@ static int __init  kp2000_pcie_init(void)
 }
 module_init(kp2000_pcie_init);
 
-static void __exit  kp2000_pcie_exit(void)
+static void __exit kp2000_pcie_exit(void)
 {
 	pci_unregister_driver(&kp2000_driver_inst);
 	class_destroy(kpc_uio_class);
-- 
2.20.1

