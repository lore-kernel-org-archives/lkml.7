Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A71C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732E921849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="pHLK0RdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfGSNbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:31:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43447 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbfGSNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:31:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so14472720pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=MVr0XIO31Bkuy2FDATI2mwycXO2udY8JgwdYSo9e+8w=;
        b=pHLK0RdTzIiVUlo4jNpM+6x8mkmhdSmNWjyd1KwT2Bp7UBpFR8mTwiLUCZhjwwCN6X
         zrTcQmun3ZX/td2Vxb/qXFKA9qPC0XbhwnEbFoui6Bgh9+mQz2nSFbnFyCX/IzYidMGU
         ECLsEjIgbbahw5lcOzQCuUaVid/sOxTAFzVg2djQ7TQb9c9woArMBsXwnAoLzGQ+smWi
         3iDHfEkJEIGFOhf3ZWDyKj8unfJf5rIle2647cJDwOIfTFYE3jCZn0k/W3lX76mqjqBD
         HE9FaX0zr0SnsIxYp6qeNeDo2GxvNI14+FdsS9FVmUeYyvMWuazxYj6NLR/4/9joy+X7
         v9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MVr0XIO31Bkuy2FDATI2mwycXO2udY8JgwdYSo9e+8w=;
        b=Z5xJKvjiGHTTH7kDsaBxqRph+qjb9ZMuH4tZ7A7Rpqtlvkcox6OFaz1Cb6hpLFbPp5
         wD192/Xu8SXs1VyLGLyPvcpNUVwQtoIa6do7K3s4wjSkcnhC2fdILyKukyF7K20ooAC+
         7nOXpV2OA8pYRnW547LDh65V80k3URWHkwtkedvBWCfSkJNmbXjgayIQElHfyyq4I6ii
         FZ9M6eGsss2hRRxR4ybxldnz+YGRpLFDBoa25Z3ohKvcBDEzXRRhpHxL3dwSilhBO3X6
         MG2Od8pMNJodahdr1jNwcK2bK6Ps163UwveJXVa3uN42noT51Wko7kwxwCIAEAR8gBuw
         TSPQ==
X-Gm-Message-State: APjAAAVomABBfp0hj0e+0ZsDXav7NySvjYLZKPQm5/KcQWUnmvrCSQIV
        sWaYJdUXpfS080qlhnIF7A3V6jdzzz2PPA==
X-Google-Smtp-Source: APXvYqyr0/brVyGxhb4PbxwxryDlUtxweTQv+DfpIhIHoLlaxUEBwoAR5YXbBh7iCb3AxDIrPXfxIQ==
X-Received: by 2002:a65:4786:: with SMTP id e6mr52906473pgs.448.1563543103118;
        Fri, 19 Jul 2019 06:31:43 -0700 (PDT)
Received: from bogon.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id x9sm37875954pfn.177.2019.07.19.06.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 06:31:42 -0700 (PDT)
From:   Fei Li <lifei.shirley@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, Pawel Moll <pawel.moll@arm.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fam Zheng <zhengfeiran@bytedance.com>,
        Fei Li <lifei.shirley@bytedance.com>
Subject: [PATCH v1 0/2] virtio-mmio: support multiple interrupt vectors
Date:   Fri, 19 Jul 2019 21:31:33 +0800
Message-Id: <20190719133135.32418-1-lifei.shirley@bytedance.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series implements multiple interrupt vectors support for
virtio-mmio device. This is especially useful for multiqueue vhost-net
device when using firecracker micro-vms as the guest.

Test result:
With 8 vcpus & 8 net queues set, one vhost-net device with 8 irqs can
receive 9 times more pps comparing with only one irq:
- 564830.38 rxpck/s for 8 irqs on
- 67665.06 rxpck/s for 1 irq on

Please help to review, thanks!

Have a nice day
Fei


Fam Zheng (1):
  virtio-mmio: Process vrings more proactively

Fei Li (1):
  virtio-mmio: support multiple interrupt vectors

 drivers/virtio/virtio_mmio.c | 238 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 196 insertions(+), 42 deletions(-)

-- 
2.11.0

