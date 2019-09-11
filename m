Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46C6C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C152085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OTq660Rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfIKW2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:28:47 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5890 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfIKW2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:28:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d7975230000>; Wed, 11 Sep 2019 15:28:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Sep 2019 15:28:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Sep 2019 15:28:46 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Sep
 2019 22:28:43 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Sep 2019 22:28:43 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d79751a0003>; Wed, 11 Sep 2019 15:28:42 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 0/4] HMM tests and minor fixes
Date:   Wed, 11 Sep 2019 15:28:25 -0700
Message-ID: <20190911222829.28874-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1568240931; bh=Dh8YksJO7otMqlUqvnlcy89p09JxR+sFwxCtiGvsYNU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=OTq660RjB6dzpe60fOzoY+lzAEtGvMCTtmZoIVWmV8sMmeiCyqSIkhLfThszuvYzb
         Ha0CoERgf0L/6cb34YwFmnwIJZEjBTERV3ek1H/GBmMBbY4vlY71RzAZYn7aqaf2qV
         kPH8Wdz/cA/lZBTpiO1DK+kfQb8eq3uoVSBW2P/Q+8fNaiT6POn7oxnFh0GpJOAcR3
         NvejJ2Bw/bSaL44yDphjMPYhLgDhLt7wqqxU5n+bGJ5Id7ueYMWoUKMmfyQ/mhJQDt
         k6+ohnisBrTSSEzHZq0olTXV+Hc1p/35HLmSUfBpwcQRpHOZQwniQdCNWncl7t+pgb
         cpAhUMgiRHdww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes are based on Jason's latest hmm branch.
Patch 1 was previously posted here [1] but was dropped from the orginal
series. Hopefully, the tests will reduce concerns about edge conditions.
I'm sure more tests could be usefully added but I thought this was a good
starting point.

[1] https://lore.kernel.org/linux-mm/20190726005650.2566-6-rcampbell@nvidia=
.com/

Ralph Campbell (4):
  mm/hmm: make full use of walk_page_range()
  mm/hmm: allow snapshot of the special zero page
  mm/hmm: allow hmm_range_fault() of mmap(PROT_NONE)
  mm/hmm/test: add self tests for HMM

 MAINTAINERS                            |    3 +
 drivers/char/Kconfig                   |   11 +
 drivers/char/Makefile                  |    1 +
 drivers/char/hmm_dmirror.c             | 1504 ++++++++++++++++++++++++
 include/Kbuild                         |    1 +
 include/uapi/linux/hmm_dmirror.h       |   74 ++
 mm/hmm.c                               |  117 +-
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    3 +
 tools/testing/selftests/vm/hmm-tests.c | 1304 ++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |  105 ++
 13 files changed, 3079 insertions(+), 64 deletions(-)
 create mode 100644 drivers/char/hmm_dmirror.c
 create mode 100644 include/uapi/linux/hmm_dmirror.h
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

--=20
2.20.1

