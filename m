Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3A0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CD320663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfDPU2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:28:53 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36437 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbfDPU2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:28:46 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MbS0X-1gjttl2T0b-00bwNW; Tue, 16 Apr 2019 22:28:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 21/26] compat_ioctl: remove IGNORE_IOCTL()
Date:   Tue, 16 Apr 2019 22:28:06 +0200
Message-Id: <20190416202839.248216-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202839.248216-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202839.248216-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ay0NXVdQsnX0Bpy9xNzkDl1OuTukLuJANGE9LgdpW2dQl548Idd
 RiZgHAbL7b3fzwshDONkpSBnBpuL5RIKilaHHL4O0JjTgOmZ+HdLQOThg3PNC9YYLaTer+i
 Ewp8GF9/H2nSpqNUUSEUkNdGE30ol6bQ4oqQLI17TAkZMUruVklX8cPvrhxF2jEnuKOdz6X
 DsHPDKkPONW3aQSYnALFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1wRWGtouAwU=:zDreuz6/FTI1MfqgU9FSYj
 xDmnIM5T620SrIJ1gBtgbIkfV9fGZbyway6ROu0BFUYZjmql+ET3o7Gf27f2PFk3YtTbXUICF
 cYWI3aaRS1/CkTGATRWj9hWkvIfv8CSsb/HMaBH0vT/rHSxAFuGi59mCFOTf4zVzLD++NMjO8
 lZG8krpPOUriembTz/6N0ltkmq210j/KPflJ0VMPb7/xjdLMzymGqxVXwzhzdn2JExHZgTJd0
 s8QKKuThb/wWaGJ/XanVNMEo5DYF2Bn/E3cZcVrD4aF8q8hSpdOM49fp5GGEvNX3YrkMG0vHh
 MBAIrjaJdDSaokno98PWYPF5OgY3QQm4BF8t4U2akJwrXfKgPNuBLAEzGd/U+pkdOnPqrmUmZ
 vocabSwA7uEryL5thhXritcAGRJgTAUEjF2q4A1V6F9moM/5RSumVU5j0+scbi/iddptwOlbh
 ch6HN1EQdTgGHWPgEooDIG/6BIMKCFFphx2rHvQNQTk2H+h1VgdvrbpZjbY4WoZ5xUzNdgoKg
 VdeUkFDjNtUFkOmUr6Usecd63Mb64EJDNbNTWWQmnVaj4aPlXais7gEnvW/pa/dRBGIMurFs6
 L9egrMQpYVGvXu+p9ZoyvYA9P2TPChEUXszyw2cYEptiCxGiP+/gke6gef16gBgUybHdTvuBq
 JpYA7EX6Yd/efU/imbHCcvxBIy6O/5QJeb+0ZBATORV+lsDTnTB+rG+5BRrB7TG3aE0Mj0YRt
 JEKIzSgyIN2EhsgG3Yp8NqlFmHgTH3fyN3saDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 07d106d0a33d ("vfs: fix up ENOIOCTLCMD error handling"),
we don't warn about unhandled compat-ioctl command code any more, but
just return the same error that a native file descriptor returns when
there is no handler.

This means the IGNORE_IOCTL() annotations are completely useless and
can all be removed. TIOCSTART/TIOCSTOP and KDGHWCLK/KDSHWCLK fall into
the same category, but for some reason were listed as COMPATIBLE_IOCTL().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 56 -----------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 625536aa6b03..bae7b38a881f 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -56,11 +56,6 @@
 
 #include <linux/sort.h>
 
-#ifdef CONFIG_SPARC
-#include <linux/fb.h>
-#include <asm/fbio.h>
-#endif
-
 #define convert_in_user(srcptr, dstptr)			\
 ({							\
 	typeof(*srcptr) val;				\
@@ -313,17 +308,7 @@ static int compat_ioctl_preallocate(struct file *file,
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
 
 #define COMPATIBLE_IOCTL(cmd) XFORM((u32)cmd),
-/* ioctl should not be warned about even if it's not implemented.
-   Valid reasons to use this:
-   - It is implemented with ->compat_ioctl on some device, but programs
-   call it on others too.
-   - The ioctl is not implemented in the native kernel, but programs
-   call it commonly anyways.
-   Most other reasons are not valid. */
-#define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
-
 static unsigned int ioctl_pointer[] = {
-/* compatible ioctls first */
 /* Little t */
 COMPATIBLE_IOCTL(TIOCOUTQ)
 /* Little f */
@@ -351,25 +336,9 @@ COMPATIBLE_IOCTL(SCSI_IOCTL_SEND_COMMAND)
 COMPATIBLE_IOCTL(SCSI_IOCTL_PROBE_HOST)
 COMPATIBLE_IOCTL(SCSI_IOCTL_GET_PCI)
 #endif
-/* Big V (don't complain on serial console) */
-IGNORE_IOCTL(VT_OPENQRY)
-IGNORE_IOCTL(VT_GETMODE)
-/*
- * These two are only for the sbus rtc driver, but
- * hwclock tries them on every rtc device first when
- * running on sparc.  On other architectures the entries
- * are useless but harmless.
- */
-COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
-COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
 /* Socket level stuff */
 COMPATIBLE_IOCTL(FIOQSIZE)
 #ifdef CONFIG_BLOCK
-/* md calls this on random blockdevs */
-IGNORE_IOCTL(RAID_VERSION)
-/* qemu/qemu-img might call these two on plain files for probing */
-IGNORE_IOCTL(CDROM_DRIVE_STATUS)
-IGNORE_IOCTL(FDGETPRM32)
 /* SG stuff */
 COMPATIBLE_IOCTL(SG_SET_TIMEOUT)
 COMPATIBLE_IOCTL(SG_GET_TIMEOUT)
@@ -428,31 +397,6 @@ COMPATIBLE_IOCTL(JSIOCGVERSION)
 COMPATIBLE_IOCTL(JSIOCGAXES)
 COMPATIBLE_IOCTL(JSIOCGBUTTONS)
 COMPATIBLE_IOCTL(JSIOCGNAME(0))
-
-/* fat 'r' ioctls. These are handled by fat with ->compat_ioctl,
-   but we don't want warnings on other file systems. So declare
-   them as compatible here. */
-#define VFAT_IOCTL_READDIR_BOTH32       _IOR('r', 1, struct compat_dirent[2])
-#define VFAT_IOCTL_READDIR_SHORT32      _IOR('r', 2, struct compat_dirent[2])
-
-IGNORE_IOCTL(VFAT_IOCTL_READDIR_BOTH32)
-IGNORE_IOCTL(VFAT_IOCTL_READDIR_SHORT32)
-
-#ifdef CONFIG_SPARC
-/* Sparc framebuffers, handled in sbusfb_compat_ioctl() */
-IGNORE_IOCTL(FBIOGTYPE)
-IGNORE_IOCTL(FBIOSATTR)
-IGNORE_IOCTL(FBIOGATTR)
-IGNORE_IOCTL(FBIOSVIDEO)
-IGNORE_IOCTL(FBIOGVIDEO)
-IGNORE_IOCTL(FBIOSCURPOS)
-IGNORE_IOCTL(FBIOGCURPOS)
-IGNORE_IOCTL(FBIOGCURMAX)
-IGNORE_IOCTL(FBIOPUTCMAP32)
-IGNORE_IOCTL(FBIOGETCMAP32)
-IGNORE_IOCTL(FBIOSCURSOR32)
-IGNORE_IOCTL(FBIOGCURSOR32)
-#endif
 };
 
 /*
-- 
2.20.0

