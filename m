Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF95C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D22E20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfDPU26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:28:58 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43345 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbfDPU2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:28:53 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mbzhv-1giFg71QTf-00dao0; Tue, 16 Apr 2019 22:28:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v3 22/26] compat_ioctl: remove /dev/random commands
Date:   Tue, 16 Apr 2019 22:28:07 +0200
Message-Id: <20190416202839.248216-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202839.248216-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202839.248216-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jA89eqKnRPmlOtnlgpKIzUdW+gr3sTm2sk1VYxigi/oVU0N+G51
 0yLOK85iHW8gxA8PYZiCGw8y/mYMEGZXPu0hhwB/nJ7lk40rQeu99bZ+GnYqZROIRSDnj5G
 DuFwuOB+9o2MaekeHCiHSGB462Rhu0iMTrViAbpxpib4GwudUebC6fEEeM6OPZ+MaDFcUt4
 wPXTUJTIzS5je+gbuQyzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CHYFpmqHt7I=:IW5eUkhGK4i+y9MkToJnzi
 wbKi29WpRLt+kIO9iXBAUUBx1iJ1WywiCib18wfeMU4W9cjY4ZQpfjmFs3y8fRjTw4ZvEJktT
 fWVJ9BUklJJ6sO4uCCo7b33pEAeOTJ17ZeJjADc+a6n3lw10DutWFVJkNTiHglIW9tkV8IrMT
 p9wL/CHrYlFN1K9pJwiZKPOGyaSdsbKCIBElAXjNIQ/JuCJRF5p7pf5u4KSszUAqV1jThifSm
 YshwVhwVTj7ZtK0p7bVsjQ3DARc2CQD5Aklu9x4/4EOKmbAQuRSMzITpRrg391Ar3CGCJUr1x
 xVFLE1SdoUaegHSb2ics8kqh83q3GSsAZhThmyqUa2NU4qzmHL82z0I4E7NCSqc3tNcW12225
 ydkTLOAdh6fIBhBvesE225gMv+2QFtlryTKzYBrKc2/U1WEMLfMp8gXKrRNXvxk6Xr99fjmY8
 TkETFcV3362QHhVMy45weAKDImPujFkFnShbvhGbRK2WIndhNhBvreSUi6KbpmpTv8Wy4YI0t
 VeGtW6TuG/QI2+2nPn8TRAcnWXGPtuydquHDBcWIgs43hsALWLhlsEcjO+DelsRZ6pyPC1PDG
 /pTqjFOx4gvWo0KAJqQ/psJ7T7yWABp/IYfNmnB4igb5uCvO7PHU0gXqkBmVK0TZ2wavgO4eJ
 1OrLkVhwKSZog+g5rP+8GTmR8+AjndhIeNq3Jk+YBdiSD6CPG7oeRAxv5ty9kK0FGiUp0LIjt
 nXw+upVecaRMNlkqVuUZbrkKaCjs+DoBv0IhNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are all handled by the random driver, so instead of listing
each ioctl, we can just use the same function to deal with both
native and compat commands.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/random.c | 1 +
 fs/compat_ioctl.c     | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38c6d1af6d1c..4f397c70d89b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2025,6 +2025,7 @@ const struct file_operations random_fops = {
 	.write = random_write,
 	.poll  = random_poll,
 	.unlocked_ioctl = random_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
 };
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index bae7b38a881f..78144a599f36 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -380,13 +380,6 @@ COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_SETPRETIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETPRETIMEOUT)
-/* Big R */
-COMPATIBLE_IOCTL(RNDGETENTCNT)
-COMPATIBLE_IOCTL(RNDADDTOENTCNT)
-COMPATIBLE_IOCTL(RNDGETPOOL)
-COMPATIBLE_IOCTL(RNDADDENTROPY)
-COMPATIBLE_IOCTL(RNDZAPENTCNT)
-COMPATIBLE_IOCTL(RNDCLEARPOOL)
 /* Misc. */
 COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
-- 
2.20.0

