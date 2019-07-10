Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C51C73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E02B20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NYgWnJLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfGJBQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:16:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34456 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGJBQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:16:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id t8so664813qkt.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 18:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqeszyHnpa09JchLWcVjDqXY/gdBDHevYPDmL0qjCG8=;
        b=NYgWnJLbG4IKERgDp8Mh8rchqpvIRzQaOzF4bWc2NXG+eqFvzv5WLLXJh22Y51w5Vz
         o5hkqppdjfxAY+lffbn7o8xckUMuJcFpHvgEMfSqFSqpBj4swXlJYkJp+Qx1BZsFy3zx
         NxitqsOKFA568E0jamBAdwfoc2KarmcCjYBRmq7tpXPZYM9UWel6pBB9e0RdCbN1G7lM
         6k84/FODP8iMFFaxMzdhUE2L/A725PpjkSamO8doAbClan8mRDNB97MBDEik0/8ocSNz
         d+gQ2ptWEdcPoMakj2qwdSXqlVfZuL8x4wgGqvURqZy3xb4pceimmbiVvvVeNxBXFfps
         bTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqeszyHnpa09JchLWcVjDqXY/gdBDHevYPDmL0qjCG8=;
        b=LaLex+LgukX5NJA42IwyXr7ijQ5uiwW6Iv4C+7TNkFu8PN47msqTgdmsd0t5vB5cLy
         pOEW03XEBcTiZQ9zoqqoFAxULmw/K2nWwN5rBCC5M4H+ly+9bQmFfWkCr6zonYZFHdBv
         hrui8py2PgvH2fB/9PZrRLlE9Hp7VxcvUKnTuAXJ5VdxT1EAKK6clgO765daxUc+sekf
         UsqLcBKTuYI+flzMglxCzaCCBEFV8KyMANAHqLy/um3ngM3rsK5MyGP1EYoD0KkDOcyR
         Lf3lnH4BS7kRS1oLrCYrmM8yvMgeksgjbU617ODi+uW+DtZJGzS3bY3pS1XDIHqpAC0l
         Njiw==
X-Gm-Message-State: APjAAAXpAqSwIy+txEvMRszskmDmn7NB5joGkq21cW2dJ3eQp5S3HSh/
        w+Le2mYJuJgLCn6T+9CrLO9yGg==
X-Google-Smtp-Source: APXvYqzHJ58xkPz/UnFmZw8DxydXmBaaklCvE3hDIpuyBcyWl2zdGdbL4YcSPkWWV6dS4LNlSnmtaw==
X-Received: by 2002:a37:9481:: with SMTP id w123mr20792761qkd.319.1562721409590;
        Tue, 09 Jul 2019 18:16:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm260057qta.82.2019.07.09.18.16.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 18:16:48 -0700 (PDT)
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
Subject: [v7 0/3] "Hotremove" persistent memory
Date:   Tue,  9 Jul 2019 21:16:44 -0400
Message-Id: <20190710011647.10944-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v7
- Added Dan Williams Reviewed-by to the last patch, and small change to
  dev_err() otput format as was suggested by Dan.

v6
- A few minor changes and added reviewed-by's.
- Spent time studying lock ordering issue that was reported by Vishal
  Verma, but that issue already exists in Linux, and can be reproduced
  with exactly the same steps with ACPI memory hotplugging.

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
 drivers/dax/kmem.c             | 46 +++++++++++++++++++++---
 include/linux/memory_hotplug.h |  8 +++--
 mm/memory_hotplug.c            | 64 +++++++++++++++++++++++-----------
 4 files changed, 92 insertions(+), 28 deletions(-)

-- 
2.22.0

