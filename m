Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7424EC468BC
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D48216C4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560047406;
	bh=42JmPFBxGl/xHTtItIqN8EUdcVNPZ4YqgT+IcciN77U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L4mDsfwThYxjDg2n5A4ZltijbNZ1BnAQL7rDhE7jVXOuKIxYfAc4NXURJGccxx6Ov
	 9uOj4onyL1VTAql+6/FJqZpEZaqxuBchSrMuQMxmkQ52HNn0MNKYCCHuixttDyBgKo
	 LGsQCkT9RTkpk4Hb2GkaYwYsePRVyAofFAFFDuzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfFICaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 22:30:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfFIC1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fEBloR9OTG75rzYbqefBDPurRQQ+p3d4DZRq71jBjVA=; b=esHtpAk2AP4LlWwunzUZPdVeHT
        REf7Nl/3C00r1GGOL4KIueSV6HeO8/M6ii3akuV6OOBrs7ONZv2cHZgF5zX2f9LotHCz2c8R0qv47
        kfONZsXu5KF08lEzDvhHbUGD9/YZGz2hDCY56Z25jsOLAiEVxtfDNlON8Pd+ALpWQYZCGlY2CartX
        2WqrN/C6aaKeWa5Mq3/oBrlZTtV2rDosTSKp3Z5scxk8JQbkZ0rb5EpjUIFfV2K4tBy+GqIEi407X
        EXN+ALY7CX/pSsqPG2GsslDBGNRKyIC87XWuDNwlz3OIytEXw99vh6QqcBltf/fAsraa/9NyuR4eI
        J1kgEEoQ==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZnYO-0001mm-1f; Sun, 09 Jun 2019 02:27:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZnYL-0000Ig-0l; Sat, 08 Jun 2019 23:27:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 09/33] docs: fault-injection: convert docs to ReST and rename to *.rst
Date:   Sat,  8 Jun 2019 23:26:59 -0300
Message-Id: <5bbdd14f23a8fa66164ac38d84662091b90adddc.1560045490.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion is actually:
  - add blank lines and identation in order to identify paragraphs;
  - fix tables markups;
  - add some lists markups;
  - mark literal blocks;
  - adjust title markups.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 ...ault-injection.txt => fault-injection.rst} | 265 +++++++++---------
 Documentation/fault-injection/index.rst       |  20 ++
 ...r-inject.txt => notifier-error-inject.rst} |  18 +-
 ...injection.txt => nvme-fault-injection.rst} | 174 ++++++------
 ...rovoke-crashes.txt => provoke-crashes.rst} |  40 ++-
 Documentation/process/4.Coding.rst            |   2 +-
 .../translations/it_IT/process/4.Coding.rst   |   2 +-
 .../translations/zh_CN/process/4.Coding.rst   |   2 +-
 drivers/misc/lkdtm/core.c                     |   2 +-
 include/linux/fault-inject.h                  |   2 +-
 lib/Kconfig.debug                             |   2 +-
 tools/testing/fault-injection/failcmd.sh      |   2 +-
 12 files changed, 290 insertions(+), 241 deletions(-)
 rename Documentation/fault-injection/{fault-injection.txt => fault-injection.rst} (68%)
 create mode 100644 Documentation/fault-injection/index.rst
 rename Documentation/fault-injection/{notifier-error-inject.txt => notifier-error-inject.rst} (83%)
 rename Documentation/fault-injection/{nvme-fault-injection.txt => nvme-fault-injection.rst} (19%)
 rename Documentation/fault-injection/{provoke-crashes.txt => provoke-crashes.rst} (45%)

diff --git a/Documentation/fault-injection/fault-injection.txt b/Documentation/fault-injection/fault-injection.rst
similarity index 68%
rename from Documentation/fault-injection/fault-injection.txt
rename to Documentation/fault-injection/fault-injection.rst
index a17517a083c3..f51bb21d20e4 100644
--- a/Documentation/fault-injection/fault-injection.txt
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -1,3 +1,4 @@
+===========================================
 Fault injection capabilities infrastructure
 ===========================================
 
@@ -7,36 +8,36 @@ See also drivers/md/md-faulty.c and "every_nth" module option for scsi_debug.
 Available fault injection capabilities
 --------------------------------------
 
-o failslab
+- failslab
 
   injects slab allocation failures. (kmalloc(), kmem_cache_alloc(), ...)
 
-o fail_page_alloc
+- fail_page_alloc
 
   injects page allocation failures. (alloc_pages(), get_free_pages(), ...)
 
-o fail_futex
+- fail_futex
 
   injects futex deadlock and uaddr fault errors.
 
-o fail_make_request
+- fail_make_request
 
   injects disk IO errors on devices permitted by setting
   /sys/block/<device>/make-it-fail or
   /sys/block/<device>/<partition>/make-it-fail. (generic_make_request())
 
-o fail_mmc_request
+- fail_mmc_request
 
   injects MMC data errors on devices permitted by setting
   debugfs entries under /sys/kernel/debug/mmc0/fail_mmc_request
 
-o fail_function
+- fail_function
 
   injects error return on specific functions, which are marked by
   ALLOW_ERROR_INJECTION() macro, by setting debugfs entries
   under /sys/kernel/debug/fail_function. No boot option supported.
 
-o NVMe fault injection
+- NVMe fault injection
 
   inject NVMe status code and retry flag on devices permitted by setting
   debugfs entries under /sys/kernel/debug/nvme*/fault_inject. The default
@@ -47,7 +48,8 @@ o NVMe fault injection
 Configure fault-injection capabilities behavior
 -----------------------------------------------
 
-o debugfs entries
+debugfs entries
+^^^^^^^^^^^^^^^
 
 fault-inject-debugfs kernel module provides some debugfs entries for runtime
 configuration of fault-injection capabilities.
@@ -55,6 +57,7 @@ configuration of fault-injection capabilities.
 - /sys/kernel/debug/fail*/probability:
 
 	likelihood of failure injection, in percent.
+
 	Format: <percent>
 
 	Note that one-failure-per-hundred is a very high error rate
@@ -83,6 +86,7 @@ configuration of fault-injection capabilities.
 - /sys/kernel/debug/fail*/verbose
 
 	Format: { 0 | 1 | 2 }
+
 	specifies the verbosity of the messages when failure is
 	injected.  '0' means no messages; '1' will print only a single
 	log line per failure; '2' will print a call trace too -- useful
@@ -91,14 +95,15 @@ configuration of fault-injection capabilities.
 - /sys/kernel/debug/fail*/task-filter:
 
 	Format: { 'Y' | 'N' }
+
 	A value of 'N' disables filtering by process (default).
 	Any positive value limits failures to only processes indicated by
 	/proc/<pid>/make-it-fail==1.
 
-- /sys/kernel/debug/fail*/require-start:
-- /sys/kernel/debug/fail*/require-end:
-- /sys/kernel/debug/fail*/reject-start:
-- /sys/kernel/debug/fail*/reject-end:
+- /sys/kernel/debug/fail*/require-start,
+  /sys/kernel/debug/fail*/require-end,
+  /sys/kernel/debug/fail*/reject-start,
+  /sys/kernel/debug/fail*/reject-end:
 
 	specifies the range of virtual addresses tested during
 	stacktrace walking.  Failure is injected only if some caller
@@ -116,6 +121,7 @@ configuration of fault-injection capabilities.
 - /sys/kernel/debug/fail_page_alloc/ignore-gfp-highmem:
 
 	Format: { 'Y' | 'N' }
+
 	default is 'N', setting it to 'Y' won't inject failures into
 	highmem/user allocations.
 
@@ -123,6 +129,7 @@ configuration of fault-injection capabilities.
 - /sys/kernel/debug/fail_page_alloc/ignore-gfp-wait:
 
 	Format: { 'Y' | 'N' }
+
 	default is 'N', setting it to 'Y' will inject failures
 	only into non-sleep allocations (GFP_ATOMIC allocations).
 
@@ -134,12 +141,14 @@ configuration of fault-injection capabilities.
 - /sys/kernel/debug/fail_futex/ignore-private:
 
 	Format: { 'Y' | 'N' }
+
 	default is 'N', setting it to 'Y' will disable failure injections
 	when dealing with private (address space) futexes.
 
 - /sys/kernel/debug/fail_function/inject:
 
 	Format: { 'function-name' | '!function-name' | '' }
+
 	specifies the target function of error injection by name.
 	If the function name leads '!' prefix, given function is
 	removed from injection list. If nothing specified ('')
@@ -160,10 +169,11 @@ configuration of fault-injection capabilities.
 	function for given function. This will be created when
 	user specifies new injection entry.
 
-o Boot option
+Boot option
+^^^^^^^^^^^
 
 In order to inject faults while debugfs is not available (early boot time),
-use the boot option:
+use the boot option::
 
 	failslab=
 	fail_page_alloc=
@@ -171,10 +181,11 @@ use the boot option:
 	fail_futex=
 	mmc_core.fail_request=<interval>,<probability>,<space>,<times>
 
-o proc entries
+proc entries
+^^^^^^^^^^^^
 
-- /proc/<pid>/fail-nth:
-- /proc/self/task/<tid>/fail-nth:
+- /proc/<pid>/fail-nth,
+  /proc/self/task/<tid>/fail-nth:
 
 	Write to this file of integer N makes N-th call in the task fail.
 	Read from this file returns a integer value. A value of '0' indicates
@@ -191,16 +202,16 @@ o proc entries
 How to add new fault injection capability
 -----------------------------------------
 
-o #include <linux/fault-inject.h>
+- #include <linux/fault-inject.h>
 
-o define the fault attributes
+- define the fault attributes
 
   DECLARE_FAULT_ATTR(name);
 
   Please see the definition of struct fault_attr in fault-inject.h
   for details.
 
-o provide a way to configure fault attributes
+- provide a way to configure fault attributes
 
 - boot option
 
@@ -222,126 +233,126 @@ o provide a way to configure fault attributes
   single kernel module, it is better to provide module parameters to
   configure the fault attributes.
 
-o add a hook to insert failures
+- add a hook to insert failures
 
-  Upon should_fail() returning true, client code should inject a failure.
+  Upon should_fail() returning true, client code should inject a failure:
 
 	should_fail(attr, size);
 
 Application Examples
 --------------------
 
-o Inject slab allocation failures into module init/exit code
+- Inject slab allocation failures into module init/exit code::
 
-#!/bin/bash
+    #!/bin/bash
 
-FAILTYPE=failslab
-echo Y > /sys/kernel/debug/$FAILTYPE/task-filter
-echo 10 > /sys/kernel/debug/$FAILTYPE/probability
-echo 100 > /sys/kernel/debug/$FAILTYPE/interval
-echo -1 > /sys/kernel/debug/$FAILTYPE/times
-echo 0 > /sys/kernel/debug/$FAILTYPE/space
-echo 2 > /sys/kernel/debug/$FAILTYPE/verbose
-echo 1 > /sys/kernel/debug/$FAILTYPE/ignore-gfp-wait
+    FAILTYPE=failslab
+    echo Y > /sys/kernel/debug/$FAILTYPE/task-filter
+    echo 10 > /sys/kernel/debug/$FAILTYPE/probability
+    echo 100 > /sys/kernel/debug/$FAILTYPE/interval
+    echo -1 > /sys/kernel/debug/$FAILTYPE/times
+    echo 0 > /sys/kernel/debug/$FAILTYPE/space
+    echo 2 > /sys/kernel/debug/$FAILTYPE/verbose
+    echo 1 > /sys/kernel/debug/$FAILTYPE/ignore-gfp-wait
 
-faulty_system()
-{
+    faulty_system()
+    {
 	bash -c "echo 1 > /proc/self/make-it-fail && exec $*"
-}
+    }
 
-if [ $# -eq 0 ]
-then
+    if [ $# -eq 0 ]
+    then
 	echo "Usage: $0 modulename [ modulename ... ]"
 	exit 1
-fi
+    fi
 
-for m in $*
-do
+    for m in $*
+    do
 	echo inserting $m...
 	faulty_system modprobe $m
 
 	echo removing $m...
 	faulty_system modprobe -r $m
-done
+    done
 
 ------------------------------------------------------------------------------
 
-o Inject page allocation failures only for a specific module
+- Inject page allocation failures only for a specific module::
 
-#!/bin/bash
+    #!/bin/bash
 
-FAILTYPE=fail_page_alloc
-module=$1
+    FAILTYPE=fail_page_alloc
+    module=$1
 
-if [ -z $module ]
-then
+    if [ -z $module ]
+    then
 	echo "Usage: $0 <modulename>"
 	exit 1
-fi
+    fi
 
-modprobe $module
+    modprobe $module
 
-if [ ! -d /sys/module/$module/sections ]
-then
+    if [ ! -d /sys/module/$module/sections ]
+    then
 	echo Module $module is not loaded
 	exit 1
-fi
+    fi
 
-cat /sys/module/$module/sections/.text > /sys/kernel/debug/$FAILTYPE/require-start
-cat /sys/module/$module/sections/.data > /sys/kernel/debug/$FAILTYPE/require-end
+    cat /sys/module/$module/sections/.text > /sys/kernel/debug/$FAILTYPE/require-start
+    cat /sys/module/$module/sections/.data > /sys/kernel/debug/$FAILTYPE/require-end
 
-echo N > /sys/kernel/debug/$FAILTYPE/task-filter
-echo 10 > /sys/kernel/debug/$FAILTYPE/probability
-echo 100 > /sys/kernel/debug/$FAILTYPE/interval
-echo -1 > /sys/kernel/debug/$FAILTYPE/times
-echo 0 > /sys/kernel/debug/$FAILTYPE/space
-echo 2 > /sys/kernel/debug/$FAILTYPE/verbose
-echo 1 > /sys/kernel/debug/$FAILTYPE/ignore-gfp-wait
-echo 1 > /sys/kernel/debug/$FAILTYPE/ignore-gfp-highmem
-echo 10 > /sys/kernel/debug/$FAILTYPE/stacktrace-depth
+    echo N > /sys/kernel/debug/$FAILTYPE/task-filter
+    echo 10 > /sys/kernel/debug/$FAILTYPE/probability
+    echo 100 > /sys/kernel/debug/$FAILTYPE/interval
+    echo -1 > /sys/kernel/debug/$FAILTYPE/times
+    echo 0 > /sys/kernel/debug/$FAILTYPE/space
+    echo 2 > /sys/kernel/debug/$FAILTYPE/verbose
+    echo 1 > /sys/kernel/debug/$FAILTYPE/ignore-gfp-wait
+    echo 1 > /sys/kernel/debug/$FAILTYPE/ignore-gfp-highmem
+    echo 10 > /sys/kernel/debug/$FAILTYPE/stacktrace-depth
 
-trap "echo 0 > /sys/kernel/debug/$FAILTYPE/probability" SIGINT SIGTERM EXIT
+    trap "echo 0 > /sys/kernel/debug/$FAILTYPE/probability" SIGINT SIGTERM EXIT
 
-echo "Injecting errors into the module $module... (interrupt to stop)"
-sleep 1000000
+    echo "Injecting errors into the module $module... (interrupt to stop)"
+    sleep 1000000
 
 ------------------------------------------------------------------------------
 
-o Inject open_ctree error while btrfs mount
+- Inject open_ctree error while btrfs mount::
 
-#!/bin/bash
+    #!/bin/bash
 
-rm -f testfile.img
-dd if=/dev/zero of=testfile.img bs=1M seek=1000 count=1
-DEVICE=$(losetup --show -f testfile.img)
-mkfs.btrfs -f $DEVICE
-mkdir -p tmpmnt
+    rm -f testfile.img
+    dd if=/dev/zero of=testfile.img bs=1M seek=1000 count=1
+    DEVICE=$(losetup --show -f testfile.img)
+    mkfs.btrfs -f $DEVICE
+    mkdir -p tmpmnt
 
-FAILTYPE=fail_function
-FAILFUNC=open_ctree
-echo $FAILFUNC > /sys/kernel/debug/$FAILTYPE/inject
-echo -12 > /sys/kernel/debug/$FAILTYPE/$FAILFUNC/retval
-echo N > /sys/kernel/debug/$FAILTYPE/task-filter
-echo 100 > /sys/kernel/debug/$FAILTYPE/probability
-echo 0 > /sys/kernel/debug/$FAILTYPE/interval
-echo -1 > /sys/kernel/debug/$FAILTYPE/times
-echo 0 > /sys/kernel/debug/$FAILTYPE/space
-echo 1 > /sys/kernel/debug/$FAILTYPE/verbose
+    FAILTYPE=fail_function
+    FAILFUNC=open_ctree
+    echo $FAILFUNC > /sys/kernel/debug/$FAILTYPE/inject
+    echo -12 > /sys/kernel/debug/$FAILTYPE/$FAILFUNC/retval
+    echo N > /sys/kernel/debug/$FAILTYPE/task-filter
+    echo 100 > /sys/kernel/debug/$FAILTYPE/probability
+    echo 0 > /sys/kernel/debug/$FAILTYPE/interval
+    echo -1 > /sys/kernel/debug/$FAILTYPE/times
+    echo 0 > /sys/kernel/debug/$FAILTYPE/space
+    echo 1 > /sys/kernel/debug/$FAILTYPE/verbose
 
-mount -t btrfs $DEVICE tmpmnt
-if [ $? -ne 0 ]
-then
+    mount -t btrfs $DEVICE tmpmnt
+    if [ $? -ne 0 ]
+    then
 	echo "SUCCESS!"
-else
+    else
 	echo "FAILED!"
 	umount tmpmnt
-fi
+    fi
 
-echo > /sys/kernel/debug/$FAILTYPE/inject
+    echo > /sys/kernel/debug/$FAILTYPE/inject
 
-rmdir tmpmnt
-losetup -d $DEVICE
-rm testfile.img
+    rmdir tmpmnt
+    losetup -d $DEVICE
+    rm testfile.img
 
 
 Tool to run command with failslab or fail_page_alloc
@@ -354,43 +365,43 @@ see the following examples.
 Examples:
 
 Run a command "make -C tools/testing/selftests/ run_tests" with injecting slab
-allocation failure.
+allocation failure::
 
 	# ./tools/testing/fault-injection/failcmd.sh \
 		-- make -C tools/testing/selftests/ run_tests
 
 Same as above except to specify 100 times failures at most instead of one time
-at most by default.
+at most by default::
 
 	# ./tools/testing/fault-injection/failcmd.sh --times=100 \
 		-- make -C tools/testing/selftests/ run_tests
 
 Same as above except to inject page allocation failure instead of slab
-allocation failure.
+allocation failure::
 
 	# env FAILCMD_TYPE=fail_page_alloc \
 		./tools/testing/fault-injection/failcmd.sh --times=100 \
-                -- make -C tools/testing/selftests/ run_tests
+		-- make -C tools/testing/selftests/ run_tests
 
 Systematic faults using fail-nth
 ---------------------------------
 
 The following code systematically faults 0-th, 1-st, 2-nd and so on
-capabilities in the socketpair() system call.
+capabilities in the socketpair() system call::
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/socket.h>
-#include <sys/syscall.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <string.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <errno.h>
+  #include <sys/types.h>
+  #include <sys/stat.h>
+  #include <sys/socket.h>
+  #include <sys/syscall.h>
+  #include <fcntl.h>
+  #include <unistd.h>
+  #include <string.h>
+  #include <stdlib.h>
+  #include <stdio.h>
+  #include <errno.h>
 
-int main()
-{
+  int main()
+  {
 	int i, err, res, fail_nth, fds[2];
 	char buf[128];
 
@@ -413,23 +424,23 @@ int main()
 			break;
 	}
 	return 0;
-}
+  }
 
-An example output:
+An example output::
 
-1-th fault Y: res=-1/23
-2-th fault Y: res=-1/23
-3-th fault Y: res=-1/12
-4-th fault Y: res=-1/12
-5-th fault Y: res=-1/23
-6-th fault Y: res=-1/23
-7-th fault Y: res=-1/23
-8-th fault Y: res=-1/12
-9-th fault Y: res=-1/12
-10-th fault Y: res=-1/12
-11-th fault Y: res=-1/12
-12-th fault Y: res=-1/12
-13-th fault Y: res=-1/12
-14-th fault Y: res=-1/12
-15-th fault Y: res=-1/12
-16-th fault N: res=0/12
+	1-th fault Y: res=-1/23
+	2-th fault Y: res=-1/23
+	3-th fault Y: res=-1/12
+	4-th fault Y: res=-1/12
+	5-th fault Y: res=-1/23
+	6-th fault Y: res=-1/23
+	7-th fault Y: res=-1/23
+	8-th fault Y: res=-1/12
+	9-th fault Y: res=-1/12
+	10-th fault Y: res=-1/12
+	11-th fault Y: res=-1/12
+	12-th fault Y: res=-1/12
+	13-th fault Y: res=-1/12
+	14-th fault Y: res=-1/12
+	15-th fault Y: res=-1/12
+	16-th fault N: res=0/12
diff --git a/Documentation/fault-injection/index.rst b/Documentation/fault-injection/index.rst
new file mode 100644
index 000000000000..92b5639ed07a
--- /dev/null
+++ b/Documentation/fault-injection/index.rst
@@ -0,0 +1,20 @@
+:orphan:
+
+===============
+fault-injection
+===============
+
+.. toctree::
+    :maxdepth: 1
+
+    fault-injection
+    notifier-error-inject
+    nvme-fault-injection
+    provoke-crashes
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/fault-injection/notifier-error-inject.txt b/Documentation/fault-injection/notifier-error-inject.rst
similarity index 83%
rename from Documentation/fault-injection/notifier-error-inject.txt
rename to Documentation/fault-injection/notifier-error-inject.rst
index e861d761de24..1668b6e48d3a 100644
--- a/Documentation/fault-injection/notifier-error-inject.txt
+++ b/Documentation/fault-injection/notifier-error-inject.rst
@@ -14,7 +14,8 @@ modules that can be used to test the following notifiers.
 PM notifier error injection module
 ----------------------------------
 This feature is controlled through debugfs interface
-/sys/kernel/debug/notifier-error-inject/pm/actions/<notifier event>/error
+
+  /sys/kernel/debug/notifier-error-inject/pm/actions/<notifier event>/error
 
 Possible PM notifier events to be failed are:
 
@@ -22,7 +23,7 @@ Possible PM notifier events to be failed are:
  * PM_SUSPEND_PREPARE
  * PM_RESTORE_PREPARE
 
-Example: Inject PM suspend error (-12 = -ENOMEM)
+Example: Inject PM suspend error (-12 = -ENOMEM)::
 
 	# cd /sys/kernel/debug/notifier-error-inject/pm/
 	# echo -12 > actions/PM_SUSPEND_PREPARE/error
@@ -32,14 +33,15 @@ Example: Inject PM suspend error (-12 = -ENOMEM)
 Memory hotplug notifier error injection module
 ----------------------------------------------
 This feature is controlled through debugfs interface
-/sys/kernel/debug/notifier-error-inject/memory/actions/<notifier event>/error
+
+  /sys/kernel/debug/notifier-error-inject/memory/actions/<notifier event>/error
 
 Possible memory notifier events to be failed are:
 
  * MEM_GOING_ONLINE
  * MEM_GOING_OFFLINE
 
-Example: Inject memory hotplug offline error (-12 == -ENOMEM)
+Example: Inject memory hotplug offline error (-12 == -ENOMEM)::
 
 	# cd /sys/kernel/debug/notifier-error-inject/memory
 	# echo -12 > actions/MEM_GOING_OFFLINE/error
@@ -49,7 +51,8 @@ Example: Inject memory hotplug offline error (-12 == -ENOMEM)
 powerpc pSeries reconfig notifier error injection module
 --------------------------------------------------------
 This feature is controlled through debugfs interface
-/sys/kernel/debug/notifier-error-inject/pSeries-reconfig/actions/<notifier event>/error
+
+  /sys/kernel/debug/notifier-error-inject/pSeries-reconfig/actions/<notifier event>/error
 
 Possible pSeries reconfig notifier events to be failed are:
 
@@ -61,7 +64,8 @@ Possible pSeries reconfig notifier events to be failed are:
 Netdevice notifier error injection module
 ----------------------------------------------
 This feature is controlled through debugfs interface
-/sys/kernel/debug/notifier-error-inject/netdev/actions/<notifier event>/error
+
+  /sys/kernel/debug/notifier-error-inject/netdev/actions/<notifier event>/error
 
 Netdevice notifier events which can be failed are:
 
@@ -75,7 +79,7 @@ Netdevice notifier events which can be failed are:
  * NETDEV_PRECHANGEUPPER
  * NETDEV_CHANGEUPPER
 
-Example: Inject netdevice mtu change error (-22 == -EINVAL)
+Example: Inject netdevice mtu change error (-22 == -EINVAL)::
 
 	# cd /sys/kernel/debug/notifier-error-inject/netdev
 	# echo -22 > actions/NETDEV_CHANGEMTU/error
diff --git a/Documentation/fault-injection/nvme-fault-injection.txt b/Documentation/fault-injection/nvme-fault-injection.rst
similarity index 19%
rename from Documentation/fault-injection/nvme-fault-injection.txt
rename to Documentation/fault-injection/nvme-fault-injection.rst
index 8fbf3bf60b62..bbb1bf3e8650 100644
--- a/Documentation/fault-injection/nvme-fault-injection.txt
+++ b/Documentation/fault-injection/nvme-fault-injection.rst
@@ -16,101 +16,105 @@ following.
 Example 1: Inject default status code with no retry
 ---------------------------------------------------
 
-mount /dev/nvme0n1 /mnt
-echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/times
-echo 100 > /sys/kernel/debug/nvme0n1/fault_inject/probability
-cp a.file /mnt
+::
 
-Expected Result:
+  mount /dev/nvme0n1 /mnt
+  echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/times
+  echo 100 > /sys/kernel/debug/nvme0n1/fault_inject/probability
+  cp a.file /mnt
 
-cp: cannot stat ‘/mnt/a.file’: Input/output error
+Expected Result::
 
-Message from dmesg:
+  cp: cannot stat ‘/mnt/a.file’: Input/output error
 
-FAULT_INJECTION: forcing a failure.
-name fault_inject, interval 1, probability 100, space 0, times 1
-CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc8+ #2
-Hardware name: innotek GmbH VirtualBox/VirtualBox,
-BIOS VirtualBox 12/01/2006
-Call Trace:
-  <IRQ>
-  dump_stack+0x5c/0x7d
-  should_fail+0x148/0x170
-  nvme_should_fail+0x2f/0x50 [nvme_core]
-  nvme_process_cq+0xe7/0x1d0 [nvme]
-  nvme_irq+0x1e/0x40 [nvme]
-  __handle_irq_event_percpu+0x3a/0x190
-  handle_irq_event_percpu+0x30/0x70
-  handle_irq_event+0x36/0x60
-  handle_fasteoi_irq+0x78/0x120
-  handle_irq+0xa7/0x130
-  ? tick_irq_enter+0xa8/0xc0
-  do_IRQ+0x43/0xc0
-  common_interrupt+0xa2/0xa2
-  </IRQ>
-RIP: 0010:native_safe_halt+0x2/0x10
-RSP: 0018:ffffffff82003e90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdd
-RAX: ffffffff817a10c0 RBX: ffffffff82012480 RCX: 0000000000000000
-RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
-RBP: 0000000000000000 R08: 000000008e38ce64 R09: 0000000000000000
-R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82012480
-R13: ffffffff82012480 R14: 0000000000000000 R15: 0000000000000000
-  ? __sched_text_end+0x4/0x4
-  default_idle+0x18/0xf0
-  do_idle+0x150/0x1d0
-  cpu_startup_entry+0x6f/0x80
-  start_kernel+0x4c4/0x4e4
-  ? set_init_arg+0x55/0x55
-  secondary_startup_64+0xa5/0xb0
-  print_req_error: I/O error, dev nvme0n1, sector 9240
-EXT4-fs error (device nvme0n1): ext4_find_entry:1436:
-inode #2: comm cp: reading directory lblock 0
+Message from dmesg::
+
+  FAULT_INJECTION: forcing a failure.
+  name fault_inject, interval 1, probability 100, space 0, times 1
+  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc8+ #2
+  Hardware name: innotek GmbH VirtualBox/VirtualBox,
+  BIOS VirtualBox 12/01/2006
+  Call Trace:
+    <IRQ>
+    dump_stack+0x5c/0x7d
+    should_fail+0x148/0x170
+    nvme_should_fail+0x2f/0x50 [nvme_core]
+    nvme_process_cq+0xe7/0x1d0 [nvme]
+    nvme_irq+0x1e/0x40 [nvme]
+    __handle_irq_event_percpu+0x3a/0x190
+    handle_irq_event_percpu+0x30/0x70
+    handle_irq_event+0x36/0x60
+    handle_fasteoi_irq+0x78/0x120
+    handle_irq+0xa7/0x130
+    ? tick_irq_enter+0xa8/0xc0
+    do_IRQ+0x43/0xc0
+    common_interrupt+0xa2/0xa2
+    </IRQ>
+  RIP: 0010:native_safe_halt+0x2/0x10
+  RSP: 0018:ffffffff82003e90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdd
+  RAX: ffffffff817a10c0 RBX: ffffffff82012480 RCX: 0000000000000000
+  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
+  RBP: 0000000000000000 R08: 000000008e38ce64 R09: 0000000000000000
+  R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82012480
+  R13: ffffffff82012480 R14: 0000000000000000 R15: 0000000000000000
+    ? __sched_text_end+0x4/0x4
+    default_idle+0x18/0xf0
+    do_idle+0x150/0x1d0
+    cpu_startup_entry+0x6f/0x80
+    start_kernel+0x4c4/0x4e4
+    ? set_init_arg+0x55/0x55
+    secondary_startup_64+0xa5/0xb0
+    print_req_error: I/O error, dev nvme0n1, sector 9240
+  EXT4-fs error (device nvme0n1): ext4_find_entry:1436:
+  inode #2: comm cp: reading directory lblock 0
 
 Example 2: Inject default status code with retry
 ------------------------------------------------
 
-mount /dev/nvme0n1 /mnt
-echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/times
-echo 100 > /sys/kernel/debug/nvme0n1/fault_inject/probability
-echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/status
-echo 0 > /sys/kernel/debug/nvme0n1/fault_inject/dont_retry
+::
 
-cp a.file /mnt
+  mount /dev/nvme0n1 /mnt
+  echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/times
+  echo 100 > /sys/kernel/debug/nvme0n1/fault_inject/probability
+  echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/status
+  echo 0 > /sys/kernel/debug/nvme0n1/fault_inject/dont_retry
 
-Expected Result:
+  cp a.file /mnt
 
-command success without error
+Expected Result::
 
-Message from dmesg:
+  command success without error
 
-FAULT_INJECTION: forcing a failure.
-name fault_inject, interval 1, probability 100, space 0, times 1
-CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.15.0-rc8+ #4
-Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
-Call Trace:
-  <IRQ>
-  dump_stack+0x5c/0x7d
-  should_fail+0x148/0x170
-  nvme_should_fail+0x30/0x60 [nvme_core]
-  nvme_loop_queue_response+0x84/0x110 [nvme_loop]
-  nvmet_req_complete+0x11/0x40 [nvmet]
-  nvmet_bio_done+0x28/0x40 [nvmet]
-  blk_update_request+0xb0/0x310
-  blk_mq_end_request+0x18/0x60
-  flush_smp_call_function_queue+0x3d/0xf0
-  smp_call_function_single_interrupt+0x2c/0xc0
-  call_function_single_interrupt+0xa2/0xb0
-  </IRQ>
-RIP: 0010:native_safe_halt+0x2/0x10
-RSP: 0018:ffffc9000068bec0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff04
-RAX: ffffffff817a10c0 RBX: ffff88011a3c9680 RCX: 0000000000000000
-RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
-RBP: 0000000000000001 R08: 000000008e38c131 R09: 0000000000000000
-R10: 0000000000000000 R11: 0000000000000000 R12: ffff88011a3c9680
-R13: ffff88011a3c9680 R14: 0000000000000000 R15: 0000000000000000
-  ? __sched_text_end+0x4/0x4
-  default_idle+0x18/0xf0
-  do_idle+0x150/0x1d0
-  cpu_startup_entry+0x6f/0x80
-  start_secondary+0x187/0x1e0
-  secondary_startup_64+0xa5/0xb0
+Message from dmesg::
+
+  FAULT_INJECTION: forcing a failure.
+  name fault_inject, interval 1, probability 100, space 0, times 1
+  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.15.0-rc8+ #4
+  Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
+  Call Trace:
+    <IRQ>
+    dump_stack+0x5c/0x7d
+    should_fail+0x148/0x170
+    nvme_should_fail+0x30/0x60 [nvme_core]
+    nvme_loop_queue_response+0x84/0x110 [nvme_loop]
+    nvmet_req_complete+0x11/0x40 [nvmet]
+    nvmet_bio_done+0x28/0x40 [nvmet]
+    blk_update_request+0xb0/0x310
+    blk_mq_end_request+0x18/0x60
+    flush_smp_call_function_queue+0x3d/0xf0
+    smp_call_function_single_interrupt+0x2c/0xc0
+    call_function_single_interrupt+0xa2/0xb0
+    </IRQ>
+  RIP: 0010:native_safe_halt+0x2/0x10
+  RSP: 0018:ffffc9000068bec0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff04
+  RAX: ffffffff817a10c0 RBX: ffff88011a3c9680 RCX: 0000000000000000
+  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
+  RBP: 0000000000000001 R08: 000000008e38c131 R09: 0000000000000000
+  R10: 0000000000000000 R11: 0000000000000000 R12: ffff88011a3c9680
+  R13: ffff88011a3c9680 R14: 0000000000000000 R15: 0000000000000000
+    ? __sched_text_end+0x4/0x4
+    default_idle+0x18/0xf0
+    do_idle+0x150/0x1d0
+    cpu_startup_entry+0x6f/0x80
+    start_secondary+0x187/0x1e0
+    secondary_startup_64+0xa5/0xb0
diff --git a/Documentation/fault-injection/provoke-crashes.txt b/Documentation/fault-injection/provoke-crashes.rst
similarity index 45%
rename from Documentation/fault-injection/provoke-crashes.txt
rename to Documentation/fault-injection/provoke-crashes.rst
index 7a9d3d81525b..9279a3e12278 100644
--- a/Documentation/fault-injection/provoke-crashes.txt
+++ b/Documentation/fault-injection/provoke-crashes.rst
@@ -1,3 +1,7 @@
+===============
+Provoke crashes
+===============
+
 The lkdtm module provides an interface to crash or injure the kernel at
 predefined crashpoints to evaluate the reliability of crash dumps obtained
 using different dumping solutions. The module uses KPROBEs to instrument
@@ -8,31 +12,37 @@ support.
 You can provide the way either through module arguments when inserting
 the module, or through a debugfs interface.
 
-Usage: insmod lkdtm.ko [recur_count={>0}] cpoint_name=<> cpoint_type=<>
-				[cpoint_count={>0}]
+Usage::
 
-  recur_count : Recursion level for the stack overflow test. Default is 10.
+	insmod lkdtm.ko [recur_count={>0}] cpoint_name=<> cpoint_type=<>
+			[cpoint_count={>0}]
 
-  cpoint_name : Crash point where the kernel is to be crashed. It can be
-	 one of INT_HARDWARE_ENTRY, INT_HW_IRQ_EN, INT_TASKLET_ENTRY,
-	 FS_DEVRW, MEM_SWAPOUT, TIMERADD, SCSI_DISPATCH_CMD,
-	 IDE_CORE_CP, DIRECT
+recur_count
+	Recursion level for the stack overflow test. Default is 10.
 
-  cpoint_type : Indicates the action to be taken on hitting the crash point.
-     It can be one of PANIC, BUG, EXCEPTION, LOOP, OVERFLOW,
-     CORRUPT_STACK, UNALIGNED_LOAD_STORE_WRITE, OVERWRITE_ALLOCATION,
-     WRITE_AFTER_FREE,
+cpoint_name
+	Crash point where the kernel is to be crashed. It can be
+	one of INT_HARDWARE_ENTRY, INT_HW_IRQ_EN, INT_TASKLET_ENTRY,
+	FS_DEVRW, MEM_SWAPOUT, TIMERADD, SCSI_DISPATCH_CMD,
+	IDE_CORE_CP, DIRECT
 
-  cpoint_count : Indicates the number of times the crash point is to be hit
-    to trigger an action. The default is 10.
+cpoint_type
+	Indicates the action to be taken on hitting the crash point.
+	It can be one of PANIC, BUG, EXCEPTION, LOOP, OVERFLOW,
+	CORRUPT_STACK, UNALIGNED_LOAD_STORE_WRITE, OVERWRITE_ALLOCATION,
+	WRITE_AFTER_FREE,
+
+cpoint_count
+	Indicates the number of times the crash point is to be hit
+	to trigger an action. The default is 10.
 
 You can also induce failures by mounting debugfs and writing the type to
-<mountpoint>/provoke-crash/<crashpoint>. E.g.,
+<mountpoint>/provoke-crash/<crashpoint>. E.g.::
 
   mount -t debugfs debugfs /mnt
   echo EXCEPTION > /mnt/provoke-crash/INT_HARDWARE_ENTRY
 
 
-A special file is `DIRECT' which will induce the crash directly without
+A special file is `DIRECT` which will induce the crash directly without
 KPROBE instrumentation. This mode is the only one available when the module
 is built on a kernel without KPROBEs support.
diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index 4b7a5ab3cec1..13dd893c9f88 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -298,7 +298,7 @@ enabled, a configurable percentage of memory allocations will be made to
 fail; these failures can be restricted to a specific range of code.
 Running with fault injection enabled allows the programmer to see how the
 code responds when things go badly.  See
-Documentation/fault-injection/fault-injection.txt for more information on
+Documentation/fault-injection/fault-injection.rst for more information on
 how to use this facility.
 
 Other kinds of errors can be found with the "sparse" static analysis tool.
diff --git a/Documentation/translations/it_IT/process/4.Coding.rst b/Documentation/translations/it_IT/process/4.Coding.rst
index c05b89e616dd..a5e36aa60448 100644
--- a/Documentation/translations/it_IT/process/4.Coding.rst
+++ b/Documentation/translations/it_IT/process/4.Coding.rst
@@ -314,7 +314,7 @@ di allocazione di memoria sarà destinata al fallimento; questi fallimenti
 possono essere ridotti ad uno specifico pezzo di codice.  Procedere con
 l'inserimento dei fallimenti attivo permette al programmatore di verificare
 come il codice risponde quando le cose vanno male.  Consultate:
-Documentation/fault-injection/fault-injection.txt per avere maggiori
+Documentation/fault-injection/fault-injection.rst per avere maggiori
 informazioni su come utilizzare questo strumento.
 
 Altre tipologie di errori possono essere riscontrati con lo strumento di
diff --git a/Documentation/translations/zh_CN/process/4.Coding.rst b/Documentation/translations/zh_CN/process/4.Coding.rst
index 8bb777941394..b82b1dde3122 100644
--- a/Documentation/translations/zh_CN/process/4.Coding.rst
+++ b/Documentation/translations/zh_CN/process/4.Coding.rst
@@ -205,7 +205,7 @@ Linus对这个问题给出了最佳答案:
 启用故障注入后，内存分配的可配置百分比将失败；这些失败可以限制在特定的代码
 范围内。在启用了故障注入的情况下运行，程序员可以看到当情况恶化时代码如何响
 应。有关如何使用此工具的详细信息，请参阅
-Documentation/fault-injection/fault-injection.txt。
+Documentation/fault-injection/fault-injection.rst。
 
 使用“sparse”静态分析工具可以发现其他类型的错误。对于sparse，可以警告程序员
 用户空间和内核空间地址之间的混淆、big endian和small endian数量的混合、在需
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index df9429e3fd3a..c7a507482051 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -15,7 +15,7 @@
  *
  * Debugfs support added by Simon Kagstrom <simon.kagstrom@netinsight.net>
  *
- * See Documentation/fault-injection/provoke-crashes.txt for instructions
+ * See Documentation/fault-injection/provoke-crashes.rst for instructions
  */
 #include "lkdtm.h"
 #include <linux/fs.h>
diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 7e6c77740413..e525f6957c49 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -11,7 +11,7 @@
 
 /*
  * For explanation of the elements of this struct, see
- * Documentation/fault-injection/fault-injection.txt
+ * Documentation/fault-injection/fault-injection.rst
  */
 struct fault_attr {
 	unsigned long probability;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d08f5848958e..3a3554e8ca0f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1701,7 +1701,7 @@ config LKDTM
 	called lkdtm.
 
 	Documentation on how to use the module can be found in
-	Documentation/fault-injection/provoke-crashes.txt
+	Documentation/fault-injection/provoke-crashes.rst
 
 config TEST_LIST_SORT
 	tristate "Linked list sorting test"
diff --git a/tools/testing/fault-injection/failcmd.sh b/tools/testing/fault-injection/failcmd.sh
index 29a6c63c5a15..78dac34264be 100644
--- a/tools/testing/fault-injection/failcmd.sh
+++ b/tools/testing/fault-injection/failcmd.sh
@@ -42,7 +42,7 @@ OPTIONS
 	--interval=value, --space=value, --verbose=value, --task-filter=value,
 	--stacktrace-depth=value, --require-start=value, --require-end=value,
 	--reject-start=value, --reject-end=value, --ignore-gfp-wait=value
-		See Documentation/fault-injection/fault-injection.txt for more
+		See Documentation/fault-injection/fault-injection.rst for more
 		information
 
 	failslab options:
-- 
2.21.0

