Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB004C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB50206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alatDqhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfJKO2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:28:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45889 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfJKO2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:28:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so4705863pgj.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=257hMeqCamzbbh3bCGJdrEkZVk68CgIbMh75UBs1WyM=;
        b=alatDqhFt5qYMWtu8p2HtA42LJCNzzpxv+F/8p7DGB7P+OF7GEboQbehZZYCqJ70v5
         tl16WGHI5sbslcJkJhQqhl2H+7XMJ+JwdtWSznA2FqRCz+hYpE4w2acQ+fgg8X45YNfy
         6IxEyHA8sNZ/T11he5b68yEoGoMa2mjIAcX+2pabcUizZzOHrdcPSq1iex8mx1z6qJic
         biMeHYJhqfW4EUbVnmKNPkuqpsPw79VKlkPTQhN0NQBAXDbplv6VXY4Q0jEeXSAlZ7uD
         n9zM5iJ5KbVx99eRqZtqUm23cbjkhSA1/wCXbTikXLC5QXrH1fEjA051Ob265f/VeBq9
         alAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=257hMeqCamzbbh3bCGJdrEkZVk68CgIbMh75UBs1WyM=;
        b=FZq+Y2mwdy5/lWAlpUfuqArqixOSDpFTkM849ISbJjayOU8OIcf2wTapACD68sKLrY
         fXTYEGbkXXeDIt7MuarUkA0OFbxJCSGTrfCHOIyXZ6SoirBtySjCz1GQEz5qmMQxp+iJ
         a9bcoGPfsi79z/aDFoyCw+nTAZzRK4Ka8Hn/Sw06RSgzZYW28TjzpYvdmFNnx+sB+RzR
         kaWl6mp7tw4g8frf5vcaxbhSHoenegIQP3ZcbStBhhJFIgF+2RIk+eyozjzVxAEbeByK
         I7U1NmOCR+VLW4tICgFIPXJrHW4NX4W0vfKFesZktmOYHY3rac6i0DQVSxJCHEZ3GGO2
         y/Rw==
X-Gm-Message-State: APjAAAVfje0qwCwq/rZgtQfq3ibK13qGMx0b2aG0r8Osn5IRLFtLXP2E
        6BqlgQpfK3p0zsh2xPD2n/U=
X-Google-Smtp-Source: APXvYqxhBdYLOfZiYIY8V8b7fwKAGkGMDgypTdHaUxh8KxomikAXdnZL/iKs1pMk1PXnomV2S9dUZw==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id h1mr17776852pjs.96.1570804081983;
        Fri, 11 Oct 2019 07:28:01 -0700 (PDT)
Received: from Serenity.amer.dsc.local (cpe-2606-A000-1125-4300-3224-32FF-FE82-DC91.dyn6.twc.com. [2606:a000:1125:4300:3224:32ff:fe82:dc91])
        by smtp.gmail.com with ESMTPSA id m22sm3752460pgd.45.2019.10.11.07.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:28:01 -0700 (PDT)
From:   Tyler Ramer <tyaramer@gmail.com>
Cc:     tyaramer@gmail.com, Balbir Singh <sblbir@amazon.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Always shutdown the controller when nvme_remove_dead_ctrl is reached.
Date:   Fri, 11 Oct 2019 10:28:26 -0400
Message-Id: <20191011142826.8497-1-tyaramer@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <7042458bf65523747514c98db36ceaa5fa390679.camel@amazon.com>
References: <7042458bf65523747514c98db36ceaa5fa390679.camel@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme_timeout() will go through nvme_should_reset() path which won't
shutdown a device during nvme_dev_disable(). If the reset fails, then
the controller is bad and won't be coming back online, so it makes sense
to explicitly call a full shutdown during nvme_remove_dead_ctrl().

Signed-off-by: Tyler Ramer <tyaramer@gmail.com>
Reviewed-by: Balbir Singh <sblbir@amazon.com>

---
Changes since v2:
  * Clean up commit message with comment from Balbir
  * Still call nvme_kill_queues()
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c0808f9eb8ab..c3f5ba22c625 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2509,7 +2509,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 {
 	nvme_get_ctrl(&dev->ctrl);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, true);
 	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
-- 
2.23.0

