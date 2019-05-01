Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DF7C04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0381A2085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="f+VLFHlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfEATSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:18:50 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:36596 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfEATSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:18:50 -0400
Received: by mail-qt1-f169.google.com with SMTP id c35so21107475qtk.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAQ69X4DsUUmu2uoyueJmu5Yn4QG8MsXOg4ekEMYq7c=;
        b=f+VLFHlWekiPkTa0WJsOHu6qXrPme8uyI7C6FYdAM/ZJbXyW9yGBW+ehN7l854M2a1
         sD2ZcHq6fLNkAp7BSjgRXdCLPLNlfcSG+MsXJ9E6phebMZbuQXGwq1Gdvzv0ww7/HxBX
         6ai2BDJVLAi55EM5q5NZOv+Kmapu5KQ7y0W6G0YKVRoQdNZENRE26wj03jtLhrW0JbnC
         fdCsOv1XGOc1JcYJe7/cvrndachOYHniG0PtUXaJ0kLDvAM+69bi5jFbmjTGwHY8D3mb
         GB1SkcRRPWSjp7ncevM/tGHZtRLdSZz5m/FSvx41CzXWldx50mAHFat1UDjm20hf5Ovo
         BUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAQ69X4DsUUmu2uoyueJmu5Yn4QG8MsXOg4ekEMYq7c=;
        b=E9foAymmOOhKwOv6bYQHeWDwJcbFDYeaunK6wuXISiqJividpKCZUs21zIRqi52Tf+
         O+rs0FvbprrYUR52FFn+etgfvpYH+V/UYGhM5UBtCgRm8icq6xDx+4V+7l2eXTZabzDp
         lW6WHHmzUZ554I2o/9RUOyuUrqkLCR78LdjeiBLaqYrI24Q/7cE6oxBICQ+Rjj45PgXQ
         7lLS/+Sk6wCk+CuuXPumFG/+i6MpfvboVNjTJu0XS5loGCN93AruNysxastW7JmNMkj4
         vFr59dzXFfGA6Tg+n3jllz58EuF6w0o6jsDtPJu9YfDfZbQZ9yHMsTa6tRuiVyJKPsqZ
         0YSg==
X-Gm-Message-State: APjAAAVibwy8QIHnV6EGF75H2pLJeq9H2wLlBzjqkWpM6rOFZHjem1Je
        Ebp2DZzRwMEK57lZZeA2bJkMAA==
X-Google-Smtp-Source: APXvYqzCyZTLdMErMvymnUr9OdlM5mz0rF37cxcBelrdS0nhZsEoaskJaHaEp/ddHKjZfP6CgNs73w==
X-Received: by 2002:aed:2124:: with SMTP id 33mr6517015qtc.35.1556738328959;
        Wed, 01 May 2019 12:18:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x47sm12610946qth.68.2019.05.01.12.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:18:48 -0700 (PDT)
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
Subject: [v4 0/2] "Hotremove" persistent memory
Date:   Wed,  1 May 2019 15:18:44 -0400
Message-Id: <20190501191846.12634-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
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

Pavel Tatashin (2):
  device-dax: fix memory and resource leak if hotplug fails
  device-dax: "Hotremove" persistent memory that is used like normal RAM

 drivers/dax/dax-private.h |   2 +
 drivers/dax/kmem.c        | 104 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 5 deletions(-)

-- 
2.21.0

