Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC4FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874F42075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FJISljxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfEBSnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:43:41 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:38875 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBSnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:43:41 -0400
Received: by mail-qt1-f170.google.com with SMTP id d13so3804538qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoemE8OPi9tqBHaKmVDMP6fqzg3JRjWrdojq7V/9jr4=;
        b=FJISljxNrMpf4BKlSGlFeUIV8YCdFaNtpEv6AsymPhEDpG/AYIOG564YnNgyiSZWYs
         er3AMBJemBc5rus9Wxn9a3q92pMjyIY35YjJBnrjKns6nNaTIL3+Kv7qqcHlJw75OsYD
         zPDMcCNUOhEBpj14TxzAHyzuYb/L0bCZe37EIL49iHNzw/vfuyUmJHW9EOpqOPC5nnS+
         tfWu9kNx5xZbaPzjIk5/kJO7U65ZWbAy3mcTyDUBHmXgAxsW8gu6gSS7xABffa88s0Rf
         5V9s4F2DpoSRTPMKZSEB51TgBtnUSFEFXIVol4hVNm8XpV5s8aQBbDGBGq5AbPhUbIvu
         FIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoemE8OPi9tqBHaKmVDMP6fqzg3JRjWrdojq7V/9jr4=;
        b=fWnEBhRqP5BAmxroTdFu0ZgmzU5CmJzOphcq2FR0DmW/5mJ5I7Tr1AUXKoXOEMctUJ
         GZXdohItEGfGHkKNHic/fs4Oh43j/4SmzQEHalRQuF+Hj/c9ifDd7LwoZG+sj8dppUc4
         BrXNc94aoh1R2dKZqx5a00lEl5PLBiipnazyqREwRPSz531jgvYLOZrPh4VUNBvKMCgi
         /L4emkX8OK8uwTIHOx7+qexlSiThP3FHwU2kGvAUvEFaHdT73LgEaxfbUVHkRQd24htG
         9q85JmPSVvX52lEQgVQMDUu81s+RH6Ue6HnrBO4YrXbweya+5m96t8s0ERwF/RwNw9kl
         vu7Q==
X-Gm-Message-State: APjAAAV/qvkOCnOjw3SW35+4JqfaxtMKFrEtG92IEgekpF1xOz9UJs5A
        W4dwkbrcc7WqEQCTZmW2cEavAA==
X-Google-Smtp-Source: APXvYqydvQA3tm1YLVyZkJR+Xcl7phv6H18jB1wWNP5r4MBakwaedC5LCXAOSAq7RroNt91CriKhcg==
X-Received: by 2002:aed:3512:: with SMTP id a18mr4319879qte.181.1556822619826;
        Thu, 02 May 2019 11:43:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 8sm25355751qtr.32.2019.05.02.11.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 11:43:39 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, akpm@linux-foundation.org,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
        david@redhat.com
Subject: [v5 0/3] "Hotremove" persistent memory
Date:   Thu,  2 May 2019 14:43:34 -0400
Message-Id: <20190502184337.20538-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v5
- Addressed comments from Dan Williams: made remove_memory() to return
  an error code, and use this function from dax.

v4
- Addressed comments from Dave Hansen

v3
- Addressed comments from David Hildenbrand. Don't release
  lock_device_hotplug after checking memory status, and rename
  memblock_offlined_cb() to check_memblock_offlined_cb()

v2
- Dan Williams mentioned that drv->remove() return is ignored
  by unbind. Unbind always succeeds. Because we cannot guarantee
  that memory can be offlined from the driver, don't even
  attempt to do so. Simply check that every section is offlined
  beforehand and only then proceed with removing dax memory.

---

Recently, adding a persistent memory to be used like a regular RAM was
added to Linux. This work extends this functionality to also allow hot
removing persistent memory.

We (Microsoft) have an important use case for this functionality.

The requirement is for physical machines with small amount of RAM (~8G)
to be able to reboot in a very short period of time (<1s). Yet, there is
a userland state that is expensive to recreate (~2G).

The solution is to boot machines with 2G preserved for persistent
memory.

Copy the state, and hotadd the persistent memory so machine still has
all 8G available for runtime. Before reboot, offline and hotremove
device-dax 2G, copy the memory that is needed to be preserved to pmem0
device, and reboot.

The series of operations look like this:

1. After boot restore /dev/pmem0 to ramdisk to be consumed by apps.
   and free ramdisk.
2. Convert raw pmem0 to devdax
   ndctl create-namespace --mode devdax --map mem -e namespace0.0 -f
3. Hotadd to System RAM
   echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
   echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
   echo online_movable > /sys/devices/system/memoryXXX/state
4. Before reboot hotremove device-dax memory from System RAM
   echo offline > /sys/devices/system/memoryXXX/state
   echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
5. Create raw pmem0 device
   ndctl create-namespace --mode raw  -e namespace0.0 -f
6. Copy the state that was stored by apps to ramdisk to pmem device
7. Do kexec reboot or reboot through firmware if firmware does not
   zero memory in pmem0 region (These machines have only regular
   volatile memory). So to have pmem0 device either memmap kernel
   parameter is used, or devices nodes in dtb are specified.

Pavel Tatashin (3):
  device-dax: fix memory and resource leak if hotplug fails
  mm/hotplug: make remove_memory() interface useable
  device-dax: "Hotremove" persistent memory that is used like normal RAM

 drivers/dax/dax-private.h      |  2 ++
 drivers/dax/kmem.c             | 46 ++++++++++++++++++++++---
 include/linux/memory_hotplug.h |  8 +++--
 mm/memory_hotplug.c            | 61 ++++++++++++++++++++++------------
 4 files changed, 89 insertions(+), 28 deletions(-)

-- 
2.21.0

