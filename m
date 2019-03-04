Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B074C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA53B2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Zl61JgpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfCDPm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:42:28 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:33795 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfCDPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:42:27 -0500
Received: by mail-ed1-f48.google.com with SMTP id a16so4626454edn.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 07:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=cTpst5kVvUdZjoJkYQJ7992kem8Jmfns4yqmk+1S46Q=;
        b=Zl61JgpU+AousbiOUZb5Ny7tKL6QYCteB6HN5VQJ3jhuXlGaGTXfUdZcYnOQczdnsp
         MzMspN3AdCi/FX0r5OyMx92jL72xL0F3KWRA9BY4VRI2ocvgHV73XFGO1po/4qnXIc8A
         7mpXAU4e72++WhD4prqTwWwfaw7Sm17PifkQHP4iINdLrPt9tw/jVQtqVNcEGRyT1Y7B
         3YW2TWKkKJPml/kDinPsk04ypEZy1nV8JqjeK+WqRQXf8Nod/BjLkGrLMDfMGx45LUfh
         DUbkEND9cyyKz4yRniy5Pgc+OpEGtCXY0E9ObHDa+90/5RfLeaz8m7sXwGZoXspiSJsL
         BMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=cTpst5kVvUdZjoJkYQJ7992kem8Jmfns4yqmk+1S46Q=;
        b=nerViNWZnqXlThrqIZfcUvnvmelerBiSiwVaqfMJ7LjM+1ByH6WRaDscn8WHVbhFcK
         57Hzop8BbKZm5QvJwwyH4VaY4SmbSW41UpC+x9Q81KQf4EEN5urK9OfJlLCsJWi78qh9
         3p5PBXE4gDwzdEA8Xo8OzGM/ZMQSYgvx+N5BSFKPhS0oV0Xqo1P3A65wCy4DjzyqYESH
         cbTTsR+hbfjtQAlFr5P+N8ss+6O8UPGClD/fLz61U2ydldbyuwUw01S/8Aqu2FnM3QSP
         M4D3uN4i2i7bswYOX3CUjy8D8eNZHeYADI4+qShCoHcalZlr+ySCoZf+fPeg7L+Jz8Dg
         7pxg==
X-Gm-Message-State: APjAAAW170WkaVegtH2W//fkR51xbK0AScDSoyamZ8hcH3ic06IO06WQ
        FcPEgyYXoQ6CiUKLPRrlMEyTxg==
X-Google-Smtp-Source: APXvYqzkjq4W/AiNnCdz5q91hA8mUoWGwUsmcDGb8wHNjfpyBGIErkgrzLwgzEhN4IP+FPY2eKbV5Q==
X-Received: by 2002:a17:906:1c4e:: with SMTP id l14mr13476437ejg.38.1551714145753;
        Mon, 04 Mar 2019 07:42:25 -0800 (PST)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f5sm1246176ejf.25.2019.03.04.07.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:42:24 -0800 (PST)
From:   James Sewart <jamessewart@arista.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH 0/4] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
Message-Id: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Date:   Mon, 4 Mar 2019 15:41:26 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This patchset moves IOMMU_DOMAIN_DMA iommu domain management to iommu.c.=20=

This avoids the use of find_or_alloc_domain whose domain assignment is=20=

inconsistent with the iommu grouping as determined by pci_device_group.

Patch 3 permits domain type IOMMU_DOMAIN_DMA to be allocated via the=20
iommu_ops api, allowing the default_domain of an iommu group to be set =
in=20
iommu.c. This domain will be attached to every device that is brought up=20=

with an iommu group, and the devices reserved regions will be mapped =
using=20
regions returned by get_resv_regions.

In intel_iommu_domain_alloc we don=E2=80=99t know the IOMMU this domain =
will be=20
associated with so we defer full initialisation until=20
intel_iommu_attach_device. Currently iommu.c:iommu_group_add_device will=20=

try to map a devices reserved regions before attaching the domain which=20=

would cause issue if the domain is not fully initialised. This is=20
addressed in patch 1 by moving the mapping to after attaching.

Patch 2 implements function apply_resv_region, used in=20
iommu_group_create_direct_mappings to mark the reserved regions as non=20=

mappable for the dma_map_ops api.

Patch 4 removes the domain lazy allocation logic. Before this patch the=20=

lazy allocation logic would not be used as any domain allocated using=20
these paths would be replaced when attaching the group default domain.=20=

Default domain allocation has been tested with and without this patch on=20=

4.19.

Cheers,
James.

James Sewart (4):
  iommu: Move iommu_group_create_direct_mappings to after device_attach
  iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
  iommu/vt-d: Allow IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_IDENTITY to be =
allocated
  iommu/vt-d: Remove lazy allocation of domains

 drivers/iommu/intel-iommu.c | 329 ++++++++++++------------------------
 drivers/iommu/iommu.c       |   4 +-
 2 files changed, 108 insertions(+), 225 deletions(-)

--=20
2.17.1

