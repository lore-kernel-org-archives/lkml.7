Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C7EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EDC20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfDPU2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:28:03 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50973 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbfDPU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:28:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MkYkC-1gZ8ve122o-00m2o6; Tue, 16 Apr 2019 22:28:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 19/26] compat_ioctl: remove HIDIO translation
Date:   Tue, 16 Apr 2019 22:25:40 +0200
Message-Id: <20190416202701.127745-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202701.127745-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202701.127745-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KP7RKETAsyx1APxTJqu/gm7fo6tZif0m6uboxx+s+cPmL9wanUb
 S619M5SKRKQGDQl4qv0HnlPUr1P67hw2/PVpv0GmAh8gA8e+irQ40DSZp3zR7XEuOVPHDsy
 8Qrs66dUIM6SYpmAiQ4rmcReOSASVL+6Jnn00dJrczwDYB5g1l5nzuzMcKn5XZs8v0w7xOG
 V7p2Zez00hdB6XitMjLJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3JBGYWVv5yo=:g0C7zlD+xxC7rMaf3Y0NJR
 ke9CdDZbs88w/ISCupK8ycvI2Yv1fPVnAuWXlhvKr53VTsjzXUPd1xUKHhJkanKQiYkwTd5TJ
 prB7Ke9Np5/azrBQI4v7e9JQ/WneqEqKgK7eNkH0TpOPVTibzGj4O/1ZblRYtX4PBYrUoY0Mn
 +raOtGYGwKtU+TLsFMotDwzMHYSCay/3yMLSNffQL0vAHH5bF5zMnGPF6vsvqus2P6J+x9FPe
 VvCL/WrhUXS+Cs45MZLlZmEQt2nl5Lo8tx309FJL0WzMUNlHpjgITCdGH1jHYdbfUzioiQTUY
 ia+dE6H5D2TDQxMvQNS0cBCnxQwgg6Xc9whFjuKQzqd+ckJcEWnMVirxWbe5/pIUgbNJ2bGPg
 kcjelONy36+r8jXS+7lXWxk4UgKIX/x+dJUbW/06TVuWzsPJBenxoi2jvWLNH6ulLmlccRhTB
 /wUPmmhldoUkP9ca1KVyWGNJWBFPVSCD0z3MvnZhEi0QEkbXcgJgGBmyl7IZS0bnWtBPoMKdf
 jFRFZQtGQRjUQx5qRag7m2K6wndP+s+ecexnsk5FnNQh14SwgJuRBiqFfs+Xa62tNybqQ8SHy
 lQ+xByfSXmU+WauPtoUwrWuTTZi20x2N2JaJBfz63ycuDBTRoSrB0xeRR+qQ9hsrNf8cI283B
 OIRWC13g9akOyYaJVCRPuPKF3ion4rXTF77EjypiAvEwMiz3inJN8hV7QOl23zmtapCaSoAZP
 BEMXtVQf7pvpVH+TDXcCuxc0f7z9ZtOCJlia5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two drivers implementing these both gained proper compat_ioctl()
handlers a long time ago with commits bb6c8d8fa9b5 ("HID: hiddev:
Add 32bit ioctl compatibilty") and ae5e49c79c05 ("HID: hidraw: add
compatibility ioctl() for 32-bit applications."), so the lists in
fs/compat_ioctl.c are no longer used.

It appears that the lists were also incomplete, so the translation
didn't actually work correctly when it was still in use.

Remove them as cleanup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 9e96b8b63578..5d13336e9eaa 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -581,23 +581,6 @@ COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
 COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
-/* hiddev */
-COMPATIBLE_IOCTL(HIDIOCGVERSION)
-COMPATIBLE_IOCTL(HIDIOCAPPLICATION)
-COMPATIBLE_IOCTL(HIDIOCGDEVINFO)
-COMPATIBLE_IOCTL(HIDIOCGSTRING)
-COMPATIBLE_IOCTL(HIDIOCINITREPORT)
-COMPATIBLE_IOCTL(HIDIOCGREPORT)
-COMPATIBLE_IOCTL(HIDIOCSREPORT)
-COMPATIBLE_IOCTL(HIDIOCGREPORTINFO)
-COMPATIBLE_IOCTL(HIDIOCGFIELDINFO)
-COMPATIBLE_IOCTL(HIDIOCGUSAGE)
-COMPATIBLE_IOCTL(HIDIOCSUSAGE)
-COMPATIBLE_IOCTL(HIDIOCGUCODE)
-COMPATIBLE_IOCTL(HIDIOCGFLAG)
-COMPATIBLE_IOCTL(HIDIOCSFLAG)
-COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINDEX)
-COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINFO)
 /* joystick */
 COMPATIBLE_IOCTL(JSIOCGVERSION)
 COMPATIBLE_IOCTL(JSIOCGAXES)
-- 
2.20.0

