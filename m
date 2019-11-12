Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACD8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A413E2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573599280;
	bh=6JP0GOFxXqz7uPi1zfAbz6zNkUOAnyg5Tm8bHnXJUNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R44dcYq/3n+jVrNfw9EkMqkXxyDlM3jfZaDpPg9xSvQVi8CL+YtFASmTHnTpGnaIp
	 gY0qlyqL6M8BeADOAr9UO8C7HSf4YHyLOW26V791Vy9Pk9qxFtE5f7S5t870FteCri
	 PJZNJCC0XSp6sMsinYNPSxUwkuIf/UI/dms3w4Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKLWyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:54:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKLWyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:54:39 -0500
Received: from localhost (unknown [8.46.76.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF66F21925;
        Tue, 12 Nov 2019 22:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573599278;
        bh=6JP0GOFxXqz7uPi1zfAbz6zNkUOAnyg5Tm8bHnXJUNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZ3b0wvEkm+nOC8NXFdRzToZmE2dq9r0zUsUI6Jei7b8C/0acFa9LkaFNn8F8sidU
         Y2JcsEHYazghknsDDPWlpUE89PhqGBTIDyqg6+FZht7Daz7X7EkXgTuwQ8QGpB1KcB
         GBzucF3QA4pqmlV2+MC2tnvICriZfOgCuJMKzMXI=
Date:   Tue, 12 Nov 2019 23:54:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, devel@linuxdriverproject.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vboxsf: move out of staging to fs/
Message-ID: <20191112225427.GA1873491@kroah.com>
References: <20191110154303.GA2867499@kroah.com>
 <20191112063440.GA15951@infradead.org>
 <20191112065629.GA1242198@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112065629.GA1242198@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Christoph said this code was "good enough to go in now" I thought
he ment to put it in drivers/staging/ for now, when in fact he ment to
put it into the "real" part of the kernel instead.

So move the code to the "real" part of the kernel as it's good enough.

Reported-by: Christoph Hellwig <hch@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Christoph, this is what you mean, right?  If so, I'll send this to Linus
later this week, or he can grab it right from this patch :)

thanks,

greg k-h

 MAINTAINERS                                      | 2 +-
 drivers/staging/Kconfig                          | 2 --
 drivers/staging/Makefile                         | 1 -
 fs/Kconfig                                       | 1 +
 fs/Makefile                                      | 1 +
 {drivers/staging => fs}/vboxsf/Kconfig           | 0
 {drivers/staging => fs}/vboxsf/Makefile          | 0
 {drivers/staging => fs}/vboxsf/TODO              | 0
 {drivers/staging => fs}/vboxsf/dir.c             | 0
 {drivers/staging => fs}/vboxsf/file.c            | 0
 {drivers/staging => fs}/vboxsf/shfl_hostintf.h   | 0
 {drivers/staging => fs}/vboxsf/super.c           | 0
 {drivers/staging => fs}/vboxsf/utils.c           | 0
 {drivers/staging => fs}/vboxsf/vboxsf_wrappers.c | 0
 {drivers/staging => fs}/vboxsf/vfsmod.h          | 0
 15 files changed, 3 insertions(+), 4 deletions(-)
 rename {drivers/staging => fs}/vboxsf/Kconfig (100%)
 rename {drivers/staging => fs}/vboxsf/Makefile (100%)
 rename {drivers/staging => fs}/vboxsf/TODO (100%)
 rename {drivers/staging => fs}/vboxsf/dir.c (100%)
 rename {drivers/staging => fs}/vboxsf/file.c (100%)
 rename {drivers/staging => fs}/vboxsf/shfl_hostintf.h (100%)
 rename {drivers/staging => fs}/vboxsf/super.c (100%)
 rename {drivers/staging => fs}/vboxsf/utils.c (100%)
 rename {drivers/staging => fs}/vboxsf/vboxsf_wrappers.c (100%)
 rename {drivers/staging => fs}/vboxsf/vfsmod.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb19fad370d7..069dc018073d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17342,7 +17342,7 @@ VIRTUAL BOX SHARED FOLDER VFS DRIVER:
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-F:	drivers/staging/vboxsf/*
+F:	fs/vboxsf/*
 
 VIRTUAL SERIO DEVICE DRIVER
 M:	Stephen Chandler Paul <thatslyude@gmail.com>
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 927d29eb92c6..6f1fa4c849a1 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -125,6 +125,4 @@ source "drivers/staging/exfat/Kconfig"
 
 source "drivers/staging/qlge/Kconfig"
 
-source "drivers/staging/vboxsf/Kconfig"
-
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index f01f04199073..a90f9b308c8d 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -53,4 +53,3 @@ obj-$(CONFIG_UWB)		+= uwb/
 obj-$(CONFIG_USB_WUSB)		+= wusbcore/
 obj-$(CONFIG_EXFAT_FS)		+= exfat/
 obj-$(CONFIG_QLGE)		+= qlge/
-obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
diff --git a/fs/Kconfig b/fs/Kconfig
index 2501e6f1f965..a6b57d790100 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -321,5 +321,6 @@ endif # NETWORK_FILESYSTEMS
 source "fs/nls/Kconfig"
 source "fs/dlm/Kconfig"
 source "fs/unicode/Kconfig"
+source "fs/vboxsf/Kconfig"
 
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 14231b4cf383..aecbb088be47 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -132,3 +132,4 @@ obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
+obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
diff --git a/drivers/staging/vboxsf/Kconfig b/fs/vboxsf/Kconfig
similarity index 100%
rename from drivers/staging/vboxsf/Kconfig
rename to fs/vboxsf/Kconfig
diff --git a/drivers/staging/vboxsf/Makefile b/fs/vboxsf/Makefile
similarity index 100%
rename from drivers/staging/vboxsf/Makefile
rename to fs/vboxsf/Makefile
diff --git a/drivers/staging/vboxsf/TODO b/fs/vboxsf/TODO
similarity index 100%
rename from drivers/staging/vboxsf/TODO
rename to fs/vboxsf/TODO
diff --git a/drivers/staging/vboxsf/dir.c b/fs/vboxsf/dir.c
similarity index 100%
rename from drivers/staging/vboxsf/dir.c
rename to fs/vboxsf/dir.c
diff --git a/drivers/staging/vboxsf/file.c b/fs/vboxsf/file.c
similarity index 100%
rename from drivers/staging/vboxsf/file.c
rename to fs/vboxsf/file.c
diff --git a/drivers/staging/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
similarity index 100%
rename from drivers/staging/vboxsf/shfl_hostintf.h
rename to fs/vboxsf/shfl_hostintf.h
diff --git a/drivers/staging/vboxsf/super.c b/fs/vboxsf/super.c
similarity index 100%
rename from drivers/staging/vboxsf/super.c
rename to fs/vboxsf/super.c
diff --git a/drivers/staging/vboxsf/utils.c b/fs/vboxsf/utils.c
similarity index 100%
rename from drivers/staging/vboxsf/utils.c
rename to fs/vboxsf/utils.c
diff --git a/drivers/staging/vboxsf/vboxsf_wrappers.c b/fs/vboxsf/vboxsf_wrappers.c
similarity index 100%
rename from drivers/staging/vboxsf/vboxsf_wrappers.c
rename to fs/vboxsf/vboxsf_wrappers.c
diff --git a/drivers/staging/vboxsf/vfsmod.h b/fs/vboxsf/vfsmod.h
similarity index 100%
rename from drivers/staging/vboxsf/vfsmod.h
rename to fs/vboxsf/vfsmod.h
-- 
2.24.0

