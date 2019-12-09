Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6093C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87ED2068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u91aLh+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLIOuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:50:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38376 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIOuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:50:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so16526642wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7g3wSCUkuYWHZsY797oGKzqOQQtMHGZXYj3iutCpVxs=;
        b=u91aLh+YeBCHC44kayet3YM2AUntkYXMMX1pB/CSCzoAIFP+uLAcMwnJdsc7rbnQ+U
         En/u38xmp/ZaSrMelXHGaVP52bkx1ZHf6fa0G31V+GUhQS0AaFSn7ys+h8RO1NV7WwV8
         ymTsoKVUUeJQKGShJcXhRTy2EGqLJh6aGXWYBXpnjQEUtLbQuGVBa6A2YqkH5uprWm/d
         vExxTU69ZDydrFyUChrYMXLctHuRAFns98Wcf6gFerjB0lv8isbF6NZZB1yfy5BvtY8n
         PFFHY7dkbo8v2ddCOwEwVVHdCIfhIVbhWl9DBEzdztx/PK8tsG39arQVINGlMjwc9u28
         QbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7g3wSCUkuYWHZsY797oGKzqOQQtMHGZXYj3iutCpVxs=;
        b=KqlIfgBInH5gRWN587lvqAu6V8j4DWetWXZ9cuMEqn13rFmjTxsLP+4S0PdyegM/WA
         4TKfk8nn5HQ74nrNLvY5pWiFoM1Z4EpT+KsCtZ+NMol5ik/GpE3SQlB7Ex+g9nzEiwTJ
         LZ0wI5hYiw6CljcHAZ2e/FrwmyJgR/UJ81tc2G6s+lwYe3aKs9CqHyouTxldUATbmYlq
         /edKoCsH06uyl8ZErkLAUPmQonIVlwyHq5kxKpzpiYGahZ3VSfEkNJGUk909h6U83vHv
         pLd8Wwdziw01IT+mrQYgUj40F+6zgF+5eSJeEE7AloLbRsrOQ//f+hFyzXL89qUxxHoW
         o+Yg==
X-Gm-Message-State: APjAAAWh1csfAVSaCqbuBipurZuP3MEthH3ii/oWt68K080TlLfudg5H
        Ua0Mh5+LhO0XCl/58YvkVtc=
X-Google-Smtp-Source: APXvYqwgHRCIfDFUwn/zmwWNRl9/DgRU5Wwz5H2iHGf8TX85hbSYzSKuX7Aal6o+CbkISCPQgbBhvQ==
X-Received: by 2002:adf:e984:: with SMTP id h4mr2512872wrm.275.1575903009994;
        Mon, 09 Dec 2019 06:50:09 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id s82sm13863411wms.28.2019.12.09.06.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:50:08 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] iommu: Implement iommu_put_resv_regions_simple()
Date:   Mon,  9 Dec 2019 15:50:02 +0100
Message-Id: <20191209145007.2433144-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Most IOMMU drivers only need to free the memory allocated for each
reserved region. Instead of open-coding the loop to do this in each
driver, extract the code into a common function that can be used by
all these drivers.

Changes in v2:
- change subject prefix to "iommu: virtio: " for virtio-iommu.c driver

Thierry

Thierry Reding (5):
  iommu: Implement iommu_put_resv_regions_simple()
  iommu: arm: Use iommu_put_resv_regions_simple()
  iommu: amd: Use iommu_put_resv_regions_simple()
  iommu: intel: Use iommu_put_resv_regions_simple()
  iommu: virtio: Use iommu_put_resv_regions_simple()

 drivers/iommu/amd_iommu.c    | 11 +----------
 drivers/iommu/arm-smmu-v3.c  | 11 +----------
 drivers/iommu/arm-smmu.c     | 11 +----------
 drivers/iommu/intel-iommu.c  | 11 +----------
 drivers/iommu/iommu.c        | 19 +++++++++++++++++++
 drivers/iommu/virtio-iommu.c | 14 +++-----------
 include/linux/iommu.h        |  2 ++
 7 files changed, 28 insertions(+), 51 deletions(-)

-- 
2.23.0

