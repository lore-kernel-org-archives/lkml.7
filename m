Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B1EC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EB02077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbGSH8Kb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgAIMhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:37:22 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40541 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgAIMhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:37:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id u1so7051585ljk.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 04:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ILyj27kpbzRc1eaCPNmbbfVGQcieiuCYVBpFS2ugS84=;
        b=YbGSH8KbHiX2OnuZEHVZRN0D/f2cz6cr08KN9ftefepnm25MtW8sh4fSM3vtIhj13j
         V75f1YKs0HBf/hFdPXnetRIwFvcl6yE+2B3HjOx6J6SRIecx5zrRGwP5W8j77AowbWu5
         ELB0dZE+bFlVwug5Q74EjcfzSE7rWn3sHkJFW0c8JWQ4UMA05SA8Fc2ZSpAHYuM7ZKc6
         +MgLw0ZRPYkqcAXtbrIYkcWyh9hePY/FdUJK/EDHphOqPAzlNZDHtgH+SAdQ7HH64iDF
         iq53mUM62W4F7aPhSNPdbTOlQM1jjFmc0dlX+TPMlXWA97pbqTjF3scFqgMvEfMEN2bv
         K3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ILyj27kpbzRc1eaCPNmbbfVGQcieiuCYVBpFS2ugS84=;
        b=H2TisYObDS4nRglJNtCzUcTB4BBkJIQ564vn+LiKLBV9olO9NdU/p3mky54F9mSCnM
         q0zQuCcYZfY0/TwGtkdoe5gGRCPbrGorbgJmtP0wmKQj9iXgn0u5pqtxshTPVYBc8LTx
         o99p+ViE1054We7wCqUt8/54cr0soyoJEyeNtllf/K78ofNiaeMq3Bv6H6kNnGY/rPR4
         ENCtLta+afmQrZZJaDRSnWISFXY5ao5MjuYH4XVtomRYjzh2YXx4UnMPCbOIQApLkbt9
         Mi8VsANIR21OMUiSSiUO/g97Vwog5DAbdQ3x1A+omON6rAVCjh/2DvSkzVLR9jpWNIVz
         ELOw==
X-Gm-Message-State: APjAAAXae0D7QGpxdHbea/ssWmQw2VQz9GJ/hTeGeD8Y1c8eAKp8KqJX
        W81HCPayz/Eh6gUw5u0RjBzL+A==
X-Google-Smtp-Source: APXvYqwx9xv6MStqamHpaTUpKqBnkX2vMeFat8S2TiF7Ssa5I8APY9jOqVTJDiRRNVRm/n40ROdG3g==
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr6374813ljg.154.1578573439996;
        Thu, 09 Jan 2020 04:37:19 -0800 (PST)
Received: from jax.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id u16sm2887724ljo.22.2020.01.09.04.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 04:37:18 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 0/5] tee: shared memory cleanup
Date:   Thu,  9 Jan 2020 13:36:46 +0100
Message-Id: <20200109123651.18520-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a group of patches to the tee subsystem with cleanups and not so
urgent fixes related to tee shared memory.

- Unused parts of the shared memory object (struct tee_shm) are removed.
- Shared memory ids usable from user space are not assigned to driver
  private shared memory objects
- The TEE_SHM_USER_MAPPED is used instead of TEE_SHM_REGISTER to accurately
  tell if a shared memory object originates from another user space mapping.

Only unused "features" should be removed with this patch set, there should
be no change in behaviour or breakage with other code.

Thanks,
Jens

Jens Wiklander (5):
  tee: remove linked list of struct tee_shm
  tee: remove unused tee_shm_priv_alloc()
  tee: don't assign shm id for private shms
  tee: remove redundant teedev in struct tee_shm
  tee: tee_shm_op_mmap(): use TEE_SHM_USER_MAPPED

 drivers/tee/tee_core.c    |  1 -
 drivers/tee/tee_private.h |  3 +-
 drivers/tee/tee_shm.c     | 85 +++++++++++----------------------------
 include/linux/tee_drv.h   | 19 +--------
 4 files changed, 27 insertions(+), 81 deletions(-)

-- 
2.17.1

