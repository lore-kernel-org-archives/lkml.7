Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF37AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872662067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfKHANx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:13:53 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:42517 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfKHANx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:13:53 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id xA80DOxs031459
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Nov 2019 09:13:24 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id xA80DOoY004514;
        Fri, 8 Nov 2019 09:13:24 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id xA80CqkT012936;
        Fri, 8 Nov 2019 09:13:24 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-10172961; Fri, 8 Nov 2019 09:08:04 +0900
Received: from BPXM20GP.gisp.nec.co.jp ([10.38.151.212]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Fri, 8
 Nov 2019 09:08:03 +0900
From:   Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: [PATCH 0/3] make pfn walker support ZONE_DEVICE
Thread-Topic: [PATCH 0/3] make pfn walker support ZONE_DEVICE
Thread-Index: AQHVlciWlfuQn46br0aHiPqwVpeT6w==
Date:   Fri, 8 Nov 2019 00:08:03 +0000
Message-ID: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.135]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set tries to make pfn walker support ZONE_DEVICE.
This idea is from the TODO in below patch:

  commit aad5f69bc161af489dbb5934868bd347282f0764
  Author: David Hildenbrand <david@redhat.com>
  Date:   Fri Oct 18 20:19:20 2019 -0700

	fs/proc/page.c: don't access uninitialized memmaps in fs/proc/page.c

pfn walker's ZONE_DEVICE support requires capability to identify
that a memmap has been initialized. The uninitialized cases are 
as follows:

	a) pages reserved for ZONE_DEVICE driver
	b) pages currently initializing

This patch set solves both of them.

Toshiki Fukasawa (3):
  procfs: refactor kpage_*_read() in fs/proc/page.c
  mm: Introduce subsection_dev_map
  mm: make pfn walker support ZONE_DEVICE

 fs/proc/page.c           | 155 ++++++++++++++++++++---------------------------
 include/linux/memremap.h |   6 ++
 include/linux/mmzone.h   |  19 ++++++
 mm/memremap.c            |  31 ++++++++++
 mm/sparse.c              |  32 ++++++++++
 5 files changed, 154 insertions(+), 89 deletions(-)

-- 
1.8.3.1

