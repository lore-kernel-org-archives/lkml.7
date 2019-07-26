Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77785C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEF621994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZhAyKvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGZTdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:33:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39943 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfGZTdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:33:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so25065845pla.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7tkH22Ffe0DvxT70J0560IP/vxuVnKp0sgsAZ7ct/kU=;
        b=sZhAyKvQ0pJENnvl74GI+1vSNcqkR7Zxt27F7+yk8XwPzP5vyrblpmuDnWM8eA7j4u
         VQAKprvKigJ+ytQQcWxx7oQUnaXYmgdZQEORKjvLR4HwbP/U0j3btuSHOCRH4wvw4ASL
         lxgEpkfzoCwStLlspH78nOXbYqjs7qEVDbCe+a7t1+cxH0xyRm9aaRANiP1UBsnGsvX4
         svCSscP6id4Vk1p0+Ra0pHr335yFW/iRoU/3gY4uEMpNs+NBpDGq9zAskyH5m+OOsvEX
         +f+NWJi0hVJXVqzQ5991FwCpjBNAa+iLTeI9VHHm5pJvwgcSuqtg/cHqc6SjLm3ntMw9
         KBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7tkH22Ffe0DvxT70J0560IP/vxuVnKp0sgsAZ7ct/kU=;
        b=LFtFbYQOFt98xF5JGe5oc3mkA6WRJmkoxxV/axSVoj1VkrxSFZpe6zsciqJiwxEIW+
         mrzakREk4ZANMKwhQgi+8mkMnaD/TZU8lBFhyIs5ZyVRJodekDN1hw3MRuSEeLRpfKL0
         Y6yJ+/vOHnd4tFglRJj7y6O+ZzGlMzr3a1LtzMkWIhxhJQ/CY582G38gzQanIMqS2oHF
         LE+Yxj+cqeNPNqgBhK+lRZSUxaiFAyGYjxtnvPbbpul3IZAZGR0dpuDz+DsVoVzlQyrD
         8JBUJNEC0MQOS/Y8kllFhjJoQIIudFdwDUJ97Lokolk8fHeFviqXWAx9aiRl5UH9KSM+
         a4AQ==
X-Gm-Message-State: APjAAAXtYZG12DVzucUlU1fjgkFZi3PjpWxZCjav6uPcbALkTfbiyibm
        VTesh/0TzxxGRFfbVT9UFQY=
X-Google-Smtp-Source: APXvYqx7SUpoM/Zcr020mWM3NZGJfkkvDWZ4q/gV2rr6L837Ox7xNkubltz0joMFZej0ufvDUqwtvA==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr93425919plb.316.1564169630686;
        Fri, 26 Jul 2019 12:33:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e189sm31824212pgc.15.2019.07.26.12.33.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:33:50 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     dafna.hirschfeld@collabora.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] dma-contiguous: two bug fixes for dma_{alloc,free}_contiguous()
Date:   Fri, 26 Jul 2019 12:34:31 -0700
Message-Id: <20190726193433.12000-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two obvious bugs in these two functions. So having
two patches to fix them.

Changlog
v1->v2:
 * PATCH-1: Confine cma_align inside the if-condition.
 * PATCH-1: Updated commit message to be precise for the corner case.
 * PATCH-2: Added Reviewed-by from Christoph.

Nicolin Chen (2):
  dma-contiguous: do not overwrite align in dma_alloc_contiguous()
  dma-contiguous: page-align the size in dma_free_contiguous()

 kernel/dma/contiguous.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.17.1

