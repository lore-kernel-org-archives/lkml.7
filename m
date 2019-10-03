Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0124AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D82215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="se77SjyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfJCTNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:13:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32925 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfJCTNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:13:08 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so8248446ior.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 12:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kR8Zy1YrMRxTBtPohNQSd/AqP79mcgM2qqBmsukmkyI=;
        b=se77SjyVATxLFOZM67qjxeZ6JxrN0Fjp0aVCUA1pBKktbIzqSWVh1TFERJq6YKaGJC
         xg4VQFzjWMXBt84K4G4NL9GZ6Uujcw25j8eMYP5o/fOr8qR3VuSODEFu8IOndrfU0fUE
         JVl5yWlUmf10315yQLrSdtz7/3QtJLK8YNfoVIZvzNj4XckX8jqaVVHFbA0qIAy2k+s2
         Cp7BhycojGSNLdD8YwHpQL+R2UBF/HZ+MIM1Lk0fbeEeLCZc4K9XA008b/HIYOXUudtM
         LWfLEXL6b0UiR0bvuAjW1fDQjdE7hPpktN9fneHWgfI4lMORqVroCz/RuDmgNQavEHtq
         wFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kR8Zy1YrMRxTBtPohNQSd/AqP79mcgM2qqBmsukmkyI=;
        b=U4g+UBVBU49/lu2gKTjQBOlo7AUlefNCyaem/v/pnemZ131w96r4uiJ4SPBNUjmOOB
         zD0b6P8YgDol8RgXJI8SsTuVL3+1Tl3fE+Rp21uOqBbtoKi8C7M00GFDTxJEowvFziXU
         LF+aeEJsZLgpY5655XsoV+a++cmSHl+IrdK0asY+7r1kRbw0/qlcDgAWWelJh1ttWqNy
         ofsd0oWC0vp9RWp+vWis0JOVTb5PhJzkC7z/MoVbNyHrF2MS9J1YEHKo2UUwE2TZ/yxZ
         wDEyKlDqaFvC4zNS3Fw1gNh3ExcwVr2t+bf8pUWfjgFAi6TtAy6GGDohDqW1D9FdbP1p
         MJCQ==
X-Gm-Message-State: APjAAAX3iLZmccO7K/lC+bH/8bfPt2mDmuA+2ejzYH0pTMec+VslF4x3
        ASKotWrnlOi6o8rW/gkk2ttOg0RajAboZw==
X-Google-Smtp-Source: APXvYqz6nPLd4RajPw+ZYmFpKrfqpnW6/OhBMwg45uYZm6lUpOatNTvPjK3Q4wBFqI1YNDjnz6MfJg==
X-Received: by 2002:a02:2a46:: with SMTP id w67mr11216914jaw.17.1570129987782;
        Thu, 03 Oct 2019 12:13:07 -0700 (PDT)
Received: from Serenity ([104.129.159.212])
        by smtp.gmail.com with ESMTPSA id z10sm1203162iog.41.2019.10.03.12.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 12:13:07 -0700 (PDT)
Date:   Thu, 3 Oct 2019 15:13:54 -0400
From:   Tyler Ramer <tyaramer@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: Shutdown when removing dead controller
Message-ID: <20191003191354.GA4481@Serenity>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always shutdown the controller when nvme_remove_dead_controller is
reached.

It's possible for nvme_remove_dead_controller to be called as part of a
failed reset, when there is a bad NVME_CSTS. The controller won't
be comming back online, so we should shut it down rather than just
disabling.

Signed-off-by: Tyler Ramer <tyaramer@gmail.com>
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

