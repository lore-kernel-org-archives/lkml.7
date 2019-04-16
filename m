Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0D5C10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2724520656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383502;
	bh=LPGVM9mu6uxUkS3urwAHky2GMxZS533l8sQqEKgY0yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=piPkBhXH5bP0yVR5BQrhcVu9lOhAg/+lLXL0xpO8J8lrQXnR7a2GGPg7JGrZx02IH
	 pJITa/WGnzCzvJ9NNawmFg4ETETh2XCPLC4TZNUFa54Ty5RwLeUpfEHNPmyWyn9s5H
	 owTuHQ3cNM+Kac2tZoEx/sovbnbm9dKRXU/ayVUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfDPC6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:58:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDPC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SW5GoGsIIJqHKXTusZYVkDgW3/QR4sovcxJovbnoW7U=; b=la7lqYVy4YypSv3RXXRSxW8cEp
        S7y4t3NWK9TUXKZcSSoeF4Ec8vYloaQNPC/qhu3tOyXVFp6FlKSRNkN8tQW6qOyDpZdvu2pE43az8
        NoJKBpudSdtrW2NjNJ54DLEGwehE2xQXvOAOL5Njt5xycpDChL+maKrwP6t6Qrs/85+YiH5xWfFca
        Vn4we1zNbe83TS6OwxmC3TDKLNzn/ZPQW19sA2yMri5nFuvx9sJJyNHsXsWT53GQvmg3E22pe3Z09
        xZkiuiKAjL40x2LmRpirZR5i2dmdT2DBuhwt6U6CwO88oT86w6sfwJX8WpBXmg2ljbVxdNV/FovPo
        vPKdXC7Q==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007ab-JI; Tue, 16 Apr 2019 02:56:33 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001mh-Cw; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH 19/57] docs: kdump: convert it to ReST
Date:   Mon, 15 Apr 2019 23:55:44 -0300
Message-Id: <01d5bff1774b8352e2a50bb13b9debbc236f6767.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kdump documentation to ReST and add it to the
user faced manual, as the documents are mainly focused on
sysadmins that would be enabling kdump.

Note: the vmcoreinfo.rst has one very long title for
sub-sections. I opted to break this one, in order to make it
easier to display in html.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/kdump/kdump.txt      | 131 +++++++++++++++++------------
 Documentation/kdump/vmcoreinfo.txt |  59 ++++++-------
 2 files changed, 104 insertions(+), 86 deletions(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 51814450a7f8..1da2d7b765f6 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -71,9 +71,8 @@ This is a symlink to the latest version.
 
 The latest kexec-tools git tree is available at:
 
-git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
-and
-http://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
+- git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
+- http://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
 
 There is also a gitweb interface available at
 http://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
@@ -81,25 +80,25 @@ http://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
 More information about kexec-tools can be found at
 http://horms.net/projects/kexec/
 
-3) Unpack the tarball with the tar command, as follows:
+3) Unpack the tarball with the tar command, as follows::
 
-   tar xvpzf kexec-tools.tar.gz
+	tar xvpzf kexec-tools.tar.gz
 
-4) Change to the kexec-tools directory, as follows:
+4) Change to the kexec-tools directory, as follows::
 
-   cd kexec-tools-VERSION
+	cd kexec-tools-VERSION
 
-5) Configure the package, as follows:
+5) Configure the package, as follows::
 
-   ./configure
+	./configure
 
-6) Compile the package, as follows:
+6) Compile the package, as follows::
 
-   make
+	make
 
-7) Install the package, as follows:
+7) Install the package, as follows::
 
-   make install
+	make install
 
 
 Build the system and dump-capture kernels
@@ -126,25 +125,25 @@ dump-capture kernels for enabling kdump support.
 System kernel config options
 ----------------------------
 
-1) Enable "kexec system call" in "Processor type and features."
+1) Enable "kexec system call" in "Processor type and features."::
 
-   CONFIG_KEXEC=y
+	CONFIG_KEXEC=y
 
 2) Enable "sysfs file system support" in "Filesystem" -> "Pseudo
-   filesystems." This is usually enabled by default.
+   filesystems." This is usually enabled by default::
 
-   CONFIG_SYSFS=y
+	CONFIG_SYSFS=y
 
    Note that "sysfs file system support" might not appear in the "Pseudo
    filesystems" menu if "Configure standard kernel features (for small
    systems)" is not enabled in "General Setup." In this case, check the
-   .config file itself to ensure that sysfs is turned on, as follows:
+   .config file itself to ensure that sysfs is turned on, as follows::
 
-   grep 'CONFIG_SYSFS' .config
+	grep 'CONFIG_SYSFS' .config
 
-3) Enable "Compile the kernel with debug info" in "Kernel hacking."
+3) Enable "Compile the kernel with debug info" in "Kernel hacking."::
 
-   CONFIG_DEBUG_INFO=Y
+	CONFIG_DEBUG_INFO=Y
 
    This causes the kernel to be built with debug symbols. The dump
    analysis tools require a vmlinux with debug symbols in order to read
@@ -154,29 +153,32 @@ Dump-capture kernel config options (Arch Independent)
 -----------------------------------------------------
 
 1) Enable "kernel crash dumps" support under "Processor type and
-   features":
+   features"::
 
-   CONFIG_CRASH_DUMP=y
+	CONFIG_CRASH_DUMP=y
 
-2) Enable "/proc/vmcore support" under "Filesystems" -> "Pseudo filesystems".
+2) Enable "/proc/vmcore support" under "Filesystems" -> "Pseudo filesystems"::
+
+	CONFIG_PROC_VMCORE=y
 
-   CONFIG_PROC_VMCORE=y
    (CONFIG_PROC_VMCORE is set by default when CONFIG_CRASH_DUMP is selected.)
 
 Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
 --------------------------------------------------------------------
 
 1) On i386, enable high memory support under "Processor type and
-   features":
+   features"::
 
-   CONFIG_HIGHMEM64G=y
-   or
-   CONFIG_HIGHMEM4G
+	CONFIG_HIGHMEM64G=y
+
+   or::
+
+	CONFIG_HIGHMEM4G
 
 2) On i386 and x86_64, disable symmetric multi-processing support
-   under "Processor type and features":
+   under "Processor type and features"::
 
-   CONFIG_SMP=n
+	CONFIG_SMP=n
 
    (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
    when loading the dump-capture kernel, see section "Load the Dump-capture
@@ -184,9 +186,9 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
 
 3) If one wants to build and use a relocatable kernel,
    Enable "Build a relocatable kernel" support under "Processor type and
-   features"
+   features"::
 
-   CONFIG_RELOCATABLE=y
+	CONFIG_RELOCATABLE=y
 
 4) Use a suitable value for "Physical address where the kernel is
    loaded" (under "Processor type and features"). This only appears when
@@ -211,13 +213,13 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
 Dump-capture kernel config options (Arch Dependent, ppc64)
 ----------------------------------------------------------
 
-1) Enable "Build a kdump crash kernel" support under "Kernel" options:
+1) Enable "Build a kdump crash kernel" support under "Kernel" options::
 
-   CONFIG_CRASH_DUMP=y
+	CONFIG_CRASH_DUMP=y
 
-2)   Enable "Build a relocatable kernel" support
+2)   Enable "Build a relocatable kernel" support::
 
-   CONFIG_RELOCATABLE=y
+	CONFIG_RELOCATABLE=y
 
    Make and install the kernel and its modules.
 
@@ -231,11 +233,13 @@ Dump-capture kernel config options (Arch Dependent, ia64)
 
   The crashkernel region can be automatically placed by the system
   kernel at run time. This is done by specifying the base address as 0,
-  or omitting it all together.
+  or omitting it all together::
 
-  crashkernel=256M@0
-  or
-  crashkernel=256M
+	crashkernel=256M@0
+
+  or::
+
+	crashkernel=256M
 
   If the start address is specified, note that the start address of the
   kernel will be aligned to 64Mb, so if the start address is not then
@@ -245,9 +249,9 @@ Dump-capture kernel config options (Arch Dependent, arm)
 ----------------------------------------------------------
 
 -   To use a relocatable kernel,
-    Enable "AUTO_ZRELADDR" support under "Boot" options:
+    Enable "AUTO_ZRELADDR" support under "Boot" options::
 
-    AUTO_ZRELADDR=y
+	AUTO_ZRELADDR=y
 
 Dump-capture kernel config options (Arch Dependent, arm64)
 ----------------------------------------------------------
@@ -265,12 +269,12 @@ on the value of System RAM -- that's mostly for distributors that pre-setup
 the kernel command line to avoid a unbootable system after some memory has
 been removed from the machine.
 
-The syntax is:
+The syntax is::
 
     crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
     range=start-[end]
 
-For example:
+For example::
 
     crashkernel=512M-2G:64M,2G-:128M
 
@@ -326,35 +330,46 @@ can choose to load the uncompressed vmlinux or compressed bzImage/vmlinuz
 of dump-capture kernel. Following is the summary.
 
 For i386 and x86_64:
+
 	- Use vmlinux if kernel is not relocatable.
 	- Use bzImage/vmlinuz if kernel is relocatable.
+
 For ppc64:
+
 	- Use vmlinux
+
 For ia64:
+
 	- Use vmlinux or vmlinuz.gz
+
 For s390x:
+
 	- Use image or bzImage
+
 For arm:
+
 	- Use zImage
+
 For arm64:
+
 	- Use vmlinux or Image
 
 If you are using an uncompressed vmlinux image then use following command
-to load dump-capture kernel.
+to load dump-capture kernel::
 
    kexec -p <dump-capture-kernel-vmlinux-image> \
    --initrd=<initrd-for-dump-capture-kernel> --args-linux \
    --append="root=<root-dev> <arch-specific-options>"
 
 If you are using a compressed bzImage/vmlinuz, then use following command
-to load dump-capture kernel.
+to load dump-capture kernel::
 
    kexec -p <dump-capture-kernel-bzImage> \
    --initrd=<initrd-for-dump-capture-kernel> \
    --append="root=<root-dev> <arch-specific-options>"
 
 If you are using a compressed zImage, then use following command
-to load dump-capture kernel.
+to load dump-capture kernel::
 
    kexec --type zImage -p <dump-capture-kernel-bzImage> \
    --initrd=<initrd-for-dump-capture-kernel> \
@@ -362,7 +377,7 @@ to load dump-capture kernel.
    --append="root=<root-dev> <arch-specific-options>"
 
 If you are using an uncompressed Image, then use following command
-to load dump-capture kernel.
+to load dump-capture kernel::
 
    kexec -p <dump-capture-kernel-Image> \
    --initrd=<initrd-for-dump-capture-kernel> \
@@ -376,18 +391,23 @@ Following are the arch specific command line options to be used while
 loading dump-capture kernel.
 
 For i386, x86_64 and ia64:
+
 	"1 irqpoll maxcpus=1 reset_devices"
 
 For ppc64:
+
 	"1 maxcpus=1 noirqdistrib reset_devices"
 
 For s390x:
+
 	"1 maxcpus=1 cgroup_disable=memory"
 
 For arm:
+
 	"1 maxcpus=1 reset_devices"
 
 For arm64:
+
 	"1 maxcpus=1 reset_devices"
 
 Notes on loading the dump-capture kernel:
@@ -464,7 +484,7 @@ Write Out the Dump File
 =======================
 
 After the dump-capture kernel is booted, write out the dump file with
-the following command:
+the following command::
 
    cp /proc/vmcore <dump-file>
 
@@ -476,7 +496,7 @@ Before analyzing the dump image, you should reboot into a stable kernel.
 
 You can do limited analysis using GDB on the dump file copied out of
 /proc/vmcore. Use the debug vmlinux built with -g and run the following
-command:
+command::
 
    gdb vmlinux <dump-file>
 
@@ -504,6 +524,11 @@ to achieve the same behaviour.
 Contact
 =======
 
-Vivek Goyal (vgoyal@redhat.com)
-Maneesh Soni (maneesh@in.ibm.com)
+- Vivek Goyal (vgoyal@redhat.com)
+- Maneesh Soni (maneesh@in.ibm.com)
 
+GDB macros
+==========
+
+.. include:: gdbmacros.txt
+   :literal:
diff --git a/Documentation/kdump/vmcoreinfo.txt b/Documentation/kdump/vmcoreinfo.txt
index bb94a4bd597a..007a6b86e0ee 100644
--- a/Documentation/kdump/vmcoreinfo.txt
+++ b/Documentation/kdump/vmcoreinfo.txt
@@ -1,8 +1,7 @@
-================================================================
-			VMCOREINFO
-================================================================
+==========
+VMCOREINFO
+==========
 
-===========
 What is it?
 ===========
 
@@ -12,7 +11,6 @@ values, field offsets, etc. These data are packed into an ELF note
 section and used by user-space tools like crash and makedumpfile to
 analyze a kernel's memory layout.
 
-================
 Common variables
 ================
 
@@ -49,7 +47,7 @@ in a system, one bit position per node number. Used to keep track of
 which nodes are in the system and online.
 
 swapper_pg_dir
--------------
+--------------
 
 The global page directory pointer of the kernel. Used to translate
 virtual to physical addresses.
@@ -132,16 +130,14 @@ nodemask_t
 The size of a nodemask_t type. Used to compute the number of online
 nodes.
 
-(page, flags|_refcount|mapping|lru|_mapcount|private|compound_dtor|
-       compound_order|compound_head)
--------------------------------------------------------------------
+(page, flags|_refcount|mapping|lru|_mapcount|private|compound_dtor|compound_order|compound_head)
+-------------------------------------------------------------------------------------------------
 
 User-space tools compute their values based on the offset of these
 variables. The variables are used when excluding unnecessary pages.
 
-(pglist_data, node_zones|nr_zones|node_mem_map|node_start_pfn|node_
-              spanned_pages|node_id)
--------------------------------------------------------------------
+(pglist_data, node_zones|nr_zones|node_mem_map|node_start_pfn|node_spanned_pages|node_id)
+-----------------------------------------------------------------------------------------
 
 On NUMA machines, each NUMA node has a pg_data_t to describe its memory
 layout. On UMA machines there is a single pglist_data which describes the
@@ -245,21 +241,25 @@ NR_FREE_PAGES
 On linux-2.6.21 or later, the number of free pages is in
 vm_stat[NR_FREE_PAGES]. Used to get the number of free pages.
 
-PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|PG_hwpoision
-|PG_head_mask|PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)
-|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
------------------------------------------------------------------
+PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|PG_hwpoision|PG_head_mask
+------------------------------------------------------------------------------
 
 Page attributes. These flags are used to filter various unnecessary for
 dumping pages.
 
+PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
+-----------------------------------------------------------------------------
+
+More page attributes. These flags are used to filter various unnecessary for
+dumping pages.
+
+
 HUGETLB_PAGE_DTOR
 -----------------
 
 The HUGETLB_PAGE_DTOR flag denotes hugetlbfs pages. Makedumpfile
 excludes these pages.
 
-======
 x86_64
 ======
 
@@ -318,12 +318,12 @@ address.
 Currently, sme_mask stores the value of the C-bit position. If needed,
 additional SME-relevant info can be placed in that variable.
 
-For example:
-[ misc	        ][ enc bit  ][ other misc SME info       ]
-0000_0000_0000_0000_1000_0000_0000_0000_0000_0000_..._0000
-63   59   55   51   47   43   39   35   31   27   ... 3
+For example::
+
+  [ misc	        ][ enc bit  ][ other misc SME info       ]
+  0000_0000_0000_0000_1000_0000_0000_0000_0000_0000_..._0000
+  63   59   55   51   47   43   39   35   31   27   ... 3
 
-======
 x86_32
 ======
 
@@ -335,7 +335,6 @@ of a higher page table lookup overhead, and also consumes more page
 table space per process. Used to check whether PAE was enabled in the
 crash kernel when converting virtual addresses to physical addresses.
 
-====
 ia64
 ====
 
@@ -366,7 +365,6 @@ PGTABLE_3|PGTABLE_4
 User-space tools need to know whether the crash kernel was in 3-level or
 4-level paging mode. Used to distinguish the page table.
 
-=====
 ARM64
 =====
 
@@ -395,9 +393,8 @@ KERNELOFFSET
 The kernel randomization offset. Used to compute the page offset. If
 KASLR is disabled, this value is zero.
 
-====
 arm
-====
+===
 
 ARM_LPAE
 --------
@@ -405,12 +402,11 @@ ARM_LPAE
 It indicates whether the crash kernel supports large physical address
 extensions. Used to translate virtual to physical addresses.
 
-====
 s390
 ====
 
 lowcore_ptr
-----------
+-----------
 
 An array with a pointer to the lowcore of every CPU. Used to print the
 psw and all registers information.
@@ -425,7 +421,6 @@ Used to get the vmalloc_start address from the high_memory symbol.
 
 The maximum number of CPUs.
 
-=======
 powerpc
 =======
 
@@ -460,9 +455,8 @@ Page size definitions, i.e. 4k, 64k, or 16M.
 
 Used to make vtop translations.
 
-vmemmap_backing|(vmemmap_backing, list)|(vmemmap_backing, phys)|
-(vmemmap_backing, virt_addr)
-----------------------------------------------------------------
+vmemmap_backing|(vmemmap_backing, list)|(vmemmap_backing, phys)|(vmemmap_backing, virt_addr)
+--------------------------------------------------------------------------------------------
 
 The vmemmap virtual address space management does not have a traditional
 page table to track which virtual struct pages are backed by a physical
@@ -480,7 +474,6 @@ member.
 
 Used in vtop translations.
 
-==
 sh
 ==
 
-- 
2.20.1

