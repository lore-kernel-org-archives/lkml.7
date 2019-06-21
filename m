Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D64C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C13B2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561120337;
	bh=ceJSyZ4xXPXjRGdh2LY7OT3GIXQtHUIt5yvLpag1WOs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2sG1UeX5vvWses3UJqmgUYSpMzSq0lOiumC7Bz9umGmuVPuVG0oWfRa5j59hCHtTU
	 oyhB7IJ0DR0rc+SlbFZb1S5synNfDQnNPOespQ9w4OE6ao+sGKsE/fAjrMBpTyEsRM
	 pQISL6JhaPak8x3wC1buYlN0X4zCoTeDCWcGLvqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfFUMcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:32:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFUMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H7esy4WXhR34Md7xPhNZhnWZixLXjQvlqAMicwbXWL4=; b=FgR2/6Mghp/2ffnEsCuuiQipo
        3IzstlyAszI1Ib8+yudcbJhJLHjkRwElsVvqCYojHbtlzytEEVzX0QciIYJ6tMVFPXbxEYRjn2egp
        YeAQT9kwk59+V/KNi75nZKTaTNlJDArEErr0vp5hI5WEl+BTCWmQvJWfZ/NqHY8oB6VLixqgrow+o
        Y3nBj7INcQyVGOheODhUB/WcrpqIDuhkICiaHkQ/PzM7Tqj9kCETOxSxaVaRFh0zRrsj1fe+XMqsh
        LcMvTBoIFNocICEQ8aNi0T+vt0bnyYBSCvUYb3gipZFUxagYicsK+YBHuTsFKejOr0fid5nCXK7n0
        rs0cm7eqw==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heIiA-0003xJ-2Q; Fri, 21 Jun 2019 12:32:10 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1heIi7-0001Es-Pf; Fri, 21 Jun 2019 09:32:07 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RFC 0/6] Produce ABI guide without escaping ReST source files
Date:   Fri, 21 Jun 2019 09:32:00 -0300
Message-Id: <cover.1561118631.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As you proposed to give it a try on removing the escape code from the
script which parses the ReST file, I changed a few things there,
adding the capability of selectively enabling to output an ABI sub-dir
without escaping things that would crash Sphinx.

PS.: As for now this is just a RFC, I'm not getting the ABI file
maintainers, copying just LKML, linux-doc ML, plus you and Jon.

I also manually fixed the contents of ABI/stable, in order for it to
pass without causing troubles.

I added all patches from ABI and features at this branch:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v4.1

The html output is at https://www.infradead.org/~mchehab/rst_features/,
and you can see the resulting ABI guide on:

	https://www.infradead.org/~mchehab/rst_features/admin-guide/abi.html

No Sphinx crashes/warnings happen when building it.

That's my personal notes about such work:

1) Documentation/ABI/stable/sysfs-class-infiniband

It had some title captions inside it, like:

	Errors info:
                -----------

For one of the "What:"

Sphinx is really pick with title markups. As the entire Documentation/stable is
parsed as if it were a single document, there should be a coherency on what
character is used to markup a level-one title. I mean, if one document uses:

foo
----

For the first level, all other documents should use "---...-" as well.

The alternative would be to have one entry for every single file at
Documentation/admin-guide/abi-*.rst, with, IMHO, it would be a lot
harder to maintain.

So, the best seems to let clear at ABI/README about how titles/subtitles
should be used inside files, if any.

2) Some documents there use a "Values:" tag, with is not defined as a
valid one at ABI/README. The script handles it as part of the description,
so no harm done;

3) Among the 47 files under ABI/stable, 14 of them names the file
contents, using a valid ReST markup for the document title. That is shown
at the index at:

	https://www.infradead.org/~mchehab/rst_features/admin-guide/abi.html


- ABI stable symbols

  -  sysfs interface for Mellanox ConnectX HCA IB driver (mlx4)
  -  sysfs interface for Intel IB driver qib
  -  sysfs interface for Intel(R) X722 iWARP i40iw driver
  -  sysfs interface for QLogic qedr NIC Driver
  -  sysfs interface for NetEffect RNIC Low-Level iWARP driver (nes)
  -  sysfs interface for Cisco VIC (usNIC) Verbs Driver
  -  sysfs interface for Chelsio T3 RDMA Driver (cxgb3)
  -  sysfs interface for Chelsio T4/T5 RDMA driver (cxgb4)
  -  sysfs interface for Intel Omni-Path driver (HFI1)
  -  sysfs interface for VMware Paravirtual RDMA driver
  -  sysfs interface for Mellanox Connect-IB HCA driver mlx5
  -  sysfs interface for Emulex RoCE HCA Driver
  -  sysfs interface for Broadcom NetXtreme-E RoCE driver
  -  sysfs interface for Mellanox IB HCA low-level driver (mthca)

I liked that, but ideally all ABI files should either use it or not.

4) I was expecting to have troubles with asterisk characters inside the
ABI files. That was not the case: I had to escape just one occurrence on
a single file of the 47 ones inside ABI/stable. 

-

My conclusion from this experiment is that it is worth cleaning the ABI
files for them to be parsed without needing to escape non-ReST compliant
parts of the ABI file.

Perhaps we could keep rst-compliant the stable, obsolete and removed
directories only, and gradually moving stuff from ABI/testing to ABI/stable,
while fixing them to be rst-compliant.


Mauro Carvalho Chehab (6):
  get_abi.pl: fix parsing on ReST mode
  ABI: sysfs-driver-mlxreg-io: fix the what fields
  ABI: README: specify that files should be ReST compatible
  ABI: stable: make files ReST compatible
  docs: ABI: make it parse ABI/stable as ReST-compatible files
  docs: abi: create a 2-depth index for ABI

 Documentation/ABI/README                      | 10 +-
 Documentation/ABI/stable/firewire-cdev        |  4 +
 Documentation/ABI/stable/sysfs-acpi-pmprofile | 22 +++--
 Documentation/ABI/stable/sysfs-bus-firewire   |  3 +
 Documentation/ABI/stable/sysfs-bus-nvmem      | 19 ++--
 Documentation/ABI/stable/sysfs-bus-usb        |  6 +-
 .../ABI/stable/sysfs-class-backlight          |  1 +
 .../ABI/stable/sysfs-class-infiniband         | 97 +++++++++++++------
 Documentation/ABI/stable/sysfs-class-rfkill   | 13 ++-
 Documentation/ABI/stable/sysfs-class-tpm      | 90 ++++++++---------
 Documentation/ABI/stable/sysfs-devices        |  5 +-
 Documentation/ABI/stable/sysfs-driver-ib_srp  |  1 +
 .../ABI/stable/sysfs-driver-mlxreg-io         | 45 ++++-----
 .../ABI/stable/sysfs-firmware-efi-vars        |  4 +
 .../ABI/stable/sysfs-firmware-opal-dump       |  5 +
 .../ABI/stable/sysfs-firmware-opal-elog       |  2 +
 Documentation/ABI/stable/sysfs-hypervisor-xen |  3 +
 Documentation/ABI/stable/vdso                 |  5 +-
 Documentation/admin-guide/abi-stable.rst      |  1 +
 Documentation/admin-guide/abi.rst             |  2 +-
 Documentation/sphinx/kernel_abi.py            |  9 +-
 scripts/get_abi.pl                            | 30 +++---
 22 files changed, 231 insertions(+), 146 deletions(-)

-- 
2.21.0


