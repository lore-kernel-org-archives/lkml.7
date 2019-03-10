Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D9EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C46205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 19:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SnRvf29k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfCJTyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 15:54:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39058 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJTyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 15:54:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id e15so2165175otk.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 12:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FlUXFEns5UtJwRic4qH/JXwTb0drcGEOPbRmIE5r6vY=;
        b=SnRvf29kXXovTvKK/X3pnvWp1mej2HF1z7WjLwENt/nkJizzzEW1WIot6dv48Feyja
         xpH1rmQbhzL94vZMprrYweqOBiY93RDXXvkSKvzoHc8jzZ88kL5HZV4U3e1vb0ZTPmCX
         0ZYjEfZBeiMyuN4rS4QKekhR22FqgVaOiZ2/OtukiCAZs1IiVt3D9balwM0TK1gwg79o
         8eo32jbYAJzmo+tbcFvt1fwX1ck93GEzZlNUjVqLsRGKbUfdXe9VSsySjO9kiUkp0DLn
         kGo13SQOeKUorzodN8+PGn/nS7KY0VsycPK2QY+zN89NZE+juuHPEj3dyMRc6kC7jwc6
         dciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FlUXFEns5UtJwRic4qH/JXwTb0drcGEOPbRmIE5r6vY=;
        b=HsKM14ihlofOY3FShCanQNbi3EV3M/Cuf5aEUtpqK2Qt2PLqFr97KGR+yEmTB0+7uZ
         Sx5G9u0Aau8wGz+aWnxtdT+TOMtm+kD4yNiuVnM+SF95q2g9pmJF+JW8+M4130S3Rrto
         N0NG0Gdr+Yk+OlzXihv3ecINNCixeQLXIOqWJ9rW10K0Ihj6TBbx61KHUS0+PbKUH0C0
         g6JoyLBVNrNhPlnf3n8CtuUSKIrmGIyOd6bPCklMQEpkIRjk47NAYevqRKi0/qOpTZ9h
         +mdlMyG3+1AQkBb/fAZu70mC+tKR81qEtvC0MEqNfxs527mTkfF9Bq6b7yKvut2YgYzm
         BQEQ==
X-Gm-Message-State: APjAAAWqFMiEOTjDqFJRcD9Y1y3ZTIXkvN4vEy091W7Aklwyu8eNkytS
        PCUaXHqkryPWnEpbV4r2PsY3rZTu1opdTwN9W8qIQg==
X-Google-Smtp-Source: APXvYqzpMq+w+S3vTSGCvE8igAd0nxHnEpWSZ87yTQo1MeS/03fV3Uk5EpQsak5+CzSvbi39K6DnTeAmr268o31ZdTQ=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr5709060ota.214.1552247653800;
 Sun, 10 Mar 2019 12:54:13 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 10 Mar 2019 12:54:01 -0700
Message-ID: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
Subject: [GIT PULL] device-dax for 5.1: PMEM as RAM
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/devdax-for-5.1

...to receive new device-dax infrastructure to allow persistent memory
and other "reserved" / performance differentiated memories, to be
assigned to the core-mm as "System RAM".

While it has soaked in -next with only a simple conflict reported, and
Michal looked at this and said "overall design of this feature makes a
lot of sense to me" [1], it's lacking non-Intel review/ack tags. For
that reason, here's some more commentary on the motivation and
implications:

[1]: https://lore.kernel.org/lkml/20190123170518.GC4087@dhcp22.suse.cz/

Some users want to use persistent memory as additional volatile
memory. They are willing to cope with potential performance
differences, for example between DRAM and 3D Xpoint, and want to use
typical Linux memory management apis rather than a userspace memory
allocator layered over an mmap() of a dax file. The administration
model is to decide how much Persistent Memory (pmem) to use as System
RAM, create a device-dax-mode namespace of that size, and then assign
it to the core-mm. The rationale for device-dax is that it is a
generic memory-mapping driver that can be layered over any "special
purpose" memory, not just pmem. On subsequent boots udev rules can be
used to restore the memory assignment.

One implication of using pmem as RAM is that mlock() no longer keeps
data off persistent media. For this reason it is recommended to enable
NVDIMM Security (previously merged for 5.0) to encrypt pmem contents
at rest. We considered making this recommendation an actively enforced
requirement, but in the end decided to leave it as a distribution /
administrator policy to allow for emulation and test environments that
lack security capable NVDIMMs.

Here is the resolution for the aforementioned conflict:

diff --cc mm/memory_hotplug.c
index a9d5787044e1,b37f3a5c4833..c4f59ac21014
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@@ -102,28 -99,21 +102,24 @@@ u64 max_mem_size = U64_MAX
  /* add this memory to iomem resource */
  static struct resource *register_memory_resource(u64 start, u64 size)
  {
-       struct resource *res, *conflict;
+       struct resource *res;
+       unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+       char *resource_name = "System RAM";

 +      if (start + size > max_mem_size)
 +              return ERR_PTR(-E2BIG);
 +
-       res = kzalloc(sizeof(struct resource), GFP_KERNEL);
-       if (!res)
-               return ERR_PTR(-ENOMEM);
-
-       res->name = "System RAM";
-       res->start = start;
-       res->end = start + size - 1;
-       res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-       conflict =  request_resource_conflict(&iomem_resource, res);
-       if (conflict) {
-               if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
-                       pr_debug("Device unaddressable memory block "
-                                "memory hotplug at %#010llx !\n",
-                                (unsigned long long)start);
-               }
-               pr_debug("System RAM resource %pR cannot be added\n", res);
-               kfree(res);
+       /*
+        * Request ownership of the new memory range.  This might be
+        * a child of an existing resource that was present but
+        * not marked as busy.
+        */
+       res = __request_region(&iomem_resource, start, size,
+                              resource_name, flags);
+
+       if (!res) {
+               pr_debug("Unable to reserve System RAM region:
%016llx->%016llx\n",
+                               start, start + size);
                return ERR_PTR(-EEXIST);
        }
        return res;


* Note, I'm sending this with Gmail rather than Evolution (which goes
through my local Exchange server) as the latter mangles the message
into something the pr-tracker-bot decides to ignore. As a result,
please forgive white-space damage.

---

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/devdax-for-5.1

for you to fetch changes up to c221c0b0308fd01d9fb33a16f64d2fd95f8830a4:

  device-dax: "Hotplug" persistent memory for use like normal RAM
(2019-02-28 10:41:23 -0800)

----------------------------------------------------------------
device-dax for 5.1
* Replace the /sys/class/dax device model with /sys/bus/dax, and include
  a compat driver so distributions can opt-in to the new ABI.

* Allow for an alternative driver for the device-dax address-range

* Introduce the 'kmem' driver to hotplug / assign a device-dax
  address-range to the core-mm.

* Arrange for the device-dax target-node to be onlined so that the newly
  added memory range can be uniquely referenced by numa apis.

----------------------------------------------------------------
Dan Williams (11):
      device-dax: Kill dax_region ida
      device-dax: Kill dax_region base
      device-dax: Remove multi-resource infrastructure
      device-dax: Start defining a dax bus model
      device-dax: Introduce bus + driver model
      device-dax: Move resource pinning+mapping into the common driver
      device-dax: Add support for a dax override driver
      device-dax: Add /sys/class/dax backwards compatibility
      acpi/nfit, device-dax: Identify differentiated memory with a
unique numa-node
      device-dax: Auto-bind device after successful new_id
      device-dax: Add a 'target_node' attribute

Dave Hansen (5):
      mm/resource: Return real error codes from walk failures
      mm/resource: Move HMM pr_debug() deeper into resource code
      mm/memory-hotplug: Allow memory resources to be children
      mm/resource: Let walk_system_ram_range() search child resources
      device-dax: "Hotplug" persistent memory for use like normal RAM

Vishal Verma (1):
      device-dax: Add a 'modalias' attribute to DAX 'bus' devices

 Documentation/ABI/obsolete/sysfs-class-dax |  22 ++
 arch/powerpc/platforms/pseries/papr_scm.c  |   1 +
 drivers/acpi/nfit/core.c                   |   8 +-
 drivers/acpi/numa.c                        |   1 +
 drivers/base/memory.c                      |   1 +
 drivers/dax/Kconfig                        |  28 +-
 drivers/dax/Makefile                       |   6 +-
 drivers/dax/bus.c                          | 503 +++++++++++++++++++++++++++++
 drivers/dax/bus.h                          |  61 ++++
 drivers/dax/dax-private.h                  |  34 +-
 drivers/dax/dax.h                          |  18 --
 drivers/dax/device-dax.h                   |  25 --
 drivers/dax/device.c                       | 363 +++++----------------
 drivers/dax/kmem.c                         | 108 +++++++
 drivers/dax/pmem.c                         | 153 ---------
 drivers/dax/pmem/Makefile                  |   7 +
 drivers/dax/pmem/compat.c                  |  73 +++++
 drivers/dax/pmem/core.c                    |  71 ++++
 drivers/dax/pmem/pmem.c                    |  40 +++
 drivers/dax/super.c                        |  41 ++-
 drivers/nvdimm/e820.c                      |   1 +
 drivers/nvdimm/nd.h                        |   2 +-
 drivers/nvdimm/of_pmem.c                   |   1 +
 drivers/nvdimm/region_devs.c               |   1 +
 include/linux/acpi.h                       |   5 +
 include/linux/libnvdimm.h                  |   1 +
 kernel/resource.c                          |  18 +-
 mm/memory_hotplug.c                        |  33 +-
 tools/testing/nvdimm/Kbuild                |   7 +-
 tools/testing/nvdimm/dax-dev.c             |  16 +-
 30 files changed, 1112 insertions(+), 537 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-class-dax
 create mode 100644 drivers/dax/bus.c
 create mode 100644 drivers/dax/bus.h
 delete mode 100644 drivers/dax/dax.h
 delete mode 100644 drivers/dax/device-dax.h
 create mode 100644 drivers/dax/kmem.c
 delete mode 100644 drivers/dax/pmem.c
 create mode 100644 drivers/dax/pmem/Makefile
 create mode 100644 drivers/dax/pmem/compat.c
 create mode 100644 drivers/dax/pmem/core.c
 create mode 100644 drivers/dax/pmem/pmem.c
