Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAAAC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E9C206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ak4fyqQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfDYRyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:54:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43217 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfDYRyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:54:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so1061697qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNp2ygAC3i6FKmzuLjHlJU1UqV45srtBI635+kYEZ+4=;
        b=Ak4fyqQhM8BxKff8fJEXf161Q1Q+odtuMhpTnuQUaVgZUmLE5+U2QcMZCNIxNsWpvr
         qxp/fnxisE1eVMxMg2cO54YQTaynDm09tw7mDW3edY33edar3pSTA/AbaTOZf5EmRzo0
         0e/ALVbFhIcBTc110AA1mRfkafLVwM6EMHHHXgIdUFtP1TR+BlePj6R4lsVx+dDuREhg
         zn2OAnyf6W73zJ490JzMZEY+fP3dVE+pmATmY7Fc42tbURkvCNhWTKISdRowzAiVVUQk
         aE/eMAcZYyHLGrML4/luEEL04zutva8eybz6doAmBmVNKUwEf2ooj/7ZlFTdgw+VoeRB
         a9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNp2ygAC3i6FKmzuLjHlJU1UqV45srtBI635+kYEZ+4=;
        b=XDE+R5zmJmG1X8EuS5Vmwv4G6HHxD0N8OsbyPXWcesPAr0zcPRk1v5IyUleOJ9HuC4
         HVV87f1h+1NKol/2oYBouH6O4sHQt6FHUutIkRpWRmKab4bSptJasCSMKRqVvFLUmH/B
         C9enIZfJ0Jlg0RPxLHODUCuvPeiBg37nqiEvou9vjzCVdgc6azxwZZf1okdPVVJOmYfW
         OERzAj7FoZHn644I0MP/ec6E4Dr+CeLRpG7gbIjMBJZ0VR7V6SgJgcfnrEt2BB/dvHex
         TI2c10R8vffD8HIEU0sg+Au2r8QZKm907krz9TqUqzKjYbuUO2+3ESGT8KrDk9Mz0OJ5
         XNrw==
X-Gm-Message-State: APjAAAUFZZ3D+5V+l4xgoicp0BfA/yQBdIvvuGbkXApJfjz78raa0QyG
        NSQlTH5udENLmo9tNiuj4X7LMQ==
X-Google-Smtp-Source: APXvYqyr9cp5oN/zmGj2t+i+id0VkfzdkKjneABv6Aqo2hHim6ED7PoKXjQJFBxK7dbJDJzvggzXyQ==
X-Received: by 2002:ac8:18ea:: with SMTP id o39mr11398232qtk.290.1556214883289;
        Thu, 25 Apr 2019 10:54:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 7sm5950641qtx.20.2019.04.25.10.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 10:54:42 -0700 (PDT)
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
Subject: [v3 0/2] "Hotremove" persistent memory
Date:   Thu, 25 Apr 2019 13:54:38 -0400
Message-Id: <20190425175440.9354-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
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

 drivers/dax/dax-private.h |  2 +
 drivers/dax/kmem.c        | 99 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 96 insertions(+), 5 deletions(-)

-- 
2.21.0

