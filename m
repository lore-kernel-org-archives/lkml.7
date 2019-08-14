Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2C5C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595D02083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfHNVbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:31:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47101 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHNVbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:31:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so414347wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tYm0oLJfCUJDLfaw8xlKVmKmh5gb1gg5bZ8BsqpbG2w=;
        b=J06A/8LFy3GG1A4CdbqPEuaOnvX1kkqqKjBCRejJLnqvzo+TB1bIMfap+L0oZKPgMV
         aW033o17mBN/maZYs0d/RZoSX+TsWRxiw44oAb+LXrGBQFzR7zFT/N0r76Vfo1adHknw
         jCZgMFInwKFGsBft4NyYbheqNCLIg4oZX5h2X0ap4SkkMbTNU6ElJ+P672YoDInJhiU6
         sSoBxOq8/uDzU1G/aksTI3uH9A5a+YH/mlzoLwcqIW+kmwn4IwuRHob1IvUYoKbFOC5u
         DcX/yKjFVZnJxFVw2ziITwj17BgT/X20mg5j4LDbNLTmMS9ZmNZcCnN0J12ZpgmEjNqB
         cuUw==
X-Gm-Message-State: APjAAAVd++5l4HhTUGsSjiGtMte08ON06GoJmiIOhVXmLUx5vPqxIs+V
        DfT1dJIupBjrMzizsf+N9CPQc2xWw54=
X-Google-Smtp-Source: APXvYqw8lLuTxZ6hfwdZzJNnfdFn5XmLS+VVLFtxxRVv3rAphO1bdipm2Vg6J5p9FbEQHc8AEmYICA==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr1683889wrs.131.1565818282025;
        Wed, 14 Aug 2019 14:31:22 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:21 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 0/7] Adding a proper workaround for fixing RTD3 issues with Nouveau
Date:   Wed, 14 Aug 2019 23:31:11 +0200
Message-Id: <20190814213118.28473-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First three patches are removing ACPI workarounds which should have never
landed.

The last four are adding a workaround to nouveau which seem to help quite
a lot with the RTD3 issues with Nouveau, so let's discuss and get wider
testing of those and see if there is any fallout or laptops where the
issues don't get fixed.

Karol Herbst (7):
  Revert "ACPI / OSI: Add OEM _OSI string to enable dGPU direct output"
  Revert "ACPI / OSI: Add OEM _OSI string to enable NVidia HDMI audio"
  Revert "ACPI / OSI: Add OEM _OSI strings to disable NVidia RTD3"
  drm/nouveau/pci: enable pcie link changes for pascal
  drm/nouveau/pci: add nvkm_pcie_get_speed
  drm/nouveau/pci: save the boot pcie link speed and restore it on fini
  drm/nouveau: abort runtime suspend if we hit an error

 drivers/acpi/osi.c                            | 24 ----------
 .../drm/nouveau/include/nvkm/core/device.h    |  2 +
 .../gpu/drm/nouveau/include/nvkm/subdev/pci.h |  9 ++--
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  6 +++
 .../gpu/drm/nouveau/nvkm/subdev/clk/base.c    |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/pci/base.c    |  9 +++-
 .../gpu/drm/nouveau/nvkm/subdev/pci/gk104.c   |  8 ++--
 .../gpu/drm/nouveau/nvkm/subdev/pci/gp100.c   | 10 ++++
 .../gpu/drm/nouveau/nvkm/subdev/pci/pcie.c    | 46 +++++++++++++++++--
 .../gpu/drm/nouveau/nvkm/subdev/pci/priv.h    |  7 +++
 10 files changed, 84 insertions(+), 39 deletions(-)

-- 
2.21.0

