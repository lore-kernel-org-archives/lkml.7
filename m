Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC534C282E2
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 01:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12AD20833
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 01:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bOYUDjSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfDUBod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 21:44:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39783 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDUBod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 21:44:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id f13so8598812qto.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 18:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUzJcCEPNzxrNRebVTHnadob9f3kjrf4lY7mTXNycVs=;
        b=bOYUDjSwgmBCuOhOjvyCWmoDmaFqDR+hSTrbz3hZ5hEnHqcNcOESI6IDbjkMh53cxB
         G2x/gsrquZNFLSsxAj32qOqLpwi+fd3+7zvGuUT/KEdN8aYwoHOWBkQGVACwskgHLMqt
         3RPy+WduBUFt9ayw0hAttali1QHy8GoqBFz6WeuUUXLS0Cu7c1TkBjkjM6le/CDgWmDe
         xZWWQ851RPT7HzOEll57WaTFXsioXRv0XRhdEK5/qfxedQm63uqu26QBJLWmkYWWQ/Qm
         G+bddWTl2F+QpFsIAaDPs/kg0hNvLPx0miCR3utDHzsXmF+aBLXnELNjg0Jn811ftFkW
         c3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUzJcCEPNzxrNRebVTHnadob9f3kjrf4lY7mTXNycVs=;
        b=kmZ19OJkw0Cl/V4yB7pDuHU1nMMVF6U2bI5jLbkUjSxMC/IuZaGk1+qigbthpH11R5
         0r+Hfaq3FdLgNKEwy3mWPVMRnVam45IAQ7UsmLMz4/FLx3s237WjpSRl/KaoSexTopXf
         l+I6Klv0ftCPqskdctCU6k/zl6SjQf43Qn0jN4vavsXUMlQVVM4K1CZBPV8lYQPzRwyb
         ghuzt7JawbHVJCMv7YkF6AjeUf5ihiyutGpWQ4bd4OvXJDB0npSPVjCmtOAb8jlp2D4G
         /DB/aaqKjFq0DvzsQBIHjthYKWhQnKAdf6XiQXr360H+iDJccgm6GFPb1E6J79m/9qdr
         gG/A==
X-Gm-Message-State: APjAAAXHfKhpK8dX69S5At+P4fO3OplNB8AFQLbMmib9dthAhCoIr7+q
        D2Kbjv6icj0oFcp5yRLZL8HwPw==
X-Google-Smtp-Source: APXvYqwGryHsI9e6T0GUZeIzujdwEDcVrbulda/4xor60EE28+izuI26XjYyBBq3siOOME8A8xbffQ==
X-Received: by 2002:a0c:b7a5:: with SMTP id l37mr9708401qve.94.1555811072426;
        Sat, 20 Apr 2019 18:44:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u1sm1385218qtj.50.2019.04.20.18.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 18:44:31 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, akpm@linux-foundation.org,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com
Subject: [v2 0/2] "Hotremove" persistent memory
Date:   Sat, 20 Apr 2019 21:44:27 -0400
Message-Id: <20190421014429.31206-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
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
 drivers/dax/kmem.c        | 96 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 93 insertions(+), 5 deletions(-)

-- 
2.21.0

