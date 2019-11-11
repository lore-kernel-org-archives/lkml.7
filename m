Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703A7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50758204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfKKTXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:23:48 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34355 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKKTXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:23:47 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MTi9N-1iK6p22quT-00Tzhu; Mon, 11 Nov 2019 20:23:05 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: atyfb: only use ioremap_uc() on i386 and ia64
Date:   Mon, 11 Nov 2019 20:22:50 +0100
Message-Id: <20191111192258.2234502-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G7fVZrN2su3CbpdSj/kq71EeeeKTYZoe6x6zvxOtFZEbiSWv0zR
 Xw+By6rp1RvmAwdIceDuVMJG6W49a4GYU5M7TsOb4PVcuFbmtc4zDHnbboKsEbR9a/vwmVG
 gMfZ9mqmc9EZcj6sVDak1e2jRHvgU1GfZC4GJJZ+6geK8zKloktS54pQoixLcw3apObAvgo
 37ky04f59Xwy19jvSnR4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gTxDTasTuXo=:DtDj9YCkmH7bphqvBqN2kc
 y2HCCFlcKtkkxIT1zvuffgBD/NjjOrR4LAaUWC38J7zAv3ccLY7YoCKr7esjNGTPU4Bm7vfNW
 3+Sj80/UK2nG5u3ic8f7jrj5w+4S1r9X4YsEQ+46xyqiQsao7J6xBlOrqgR1IrpM3fwT9OBuB
 oqdwG3t6hG3AqDJxC09ls/SRfvVndfBmyO3ruCNtKApuxM5M2kjSBPYq1ZCt18nmkxnwNm5h9
 48Ra3ulZBQxlDoJJ4ceP+De+h+EU0nZknsRvpNuVJLPZw8nqgksAWCComGiuatMGtr3RsPXrO
 NxMgDA0DFe2/FUx21eVhAt2TD39hUOHS2W4/RPBFZ1nrffYh6we0SK+AWn75lOjkzTiz5jdBt
 sFKRUSl2edXQXlZStoDBByKUF7qMwQBvn6ZKt8Q0+Is0FyaGCUyCxVA8QzH5cH87e8eHdKQB/
 pXGZpoJGuNGDlhIg7LO38RnKy0xfTlWMsZcFT0CcHuD14fzrXfQ4EJfQi3VlONjX2pMKmTYoy
 uYRBC9HrfTpInyi+GMPZOE3NoNWZ15CzZC7vEsPxb63kNjQyglrGrjnLHq/z39MNcVvaIY/9G
 T17lcEpSTAVBSOo85r2PPWOI6B8f9PKLpVlW4lvn8MGWYqz3UMX8v2Y6hMYvCfpjCMMInNxF1
 B408DQyNh/c7kt24ojj+STA80/0IuB8tVTbT6BCwyDzwBq615+5FIHAe37/brRYdCA5WJHYhJ
 aboiguFX21swpruRbFolY595RugViK+R8oN9ovjz9pLuBYx0eF7TMmxkMk9A3LUZTTOK9pRSh
 KgVlttJjfHZ2lQelvU3AwaGH06fVl23G9NaclTxJ8k1DV1iUcl4W6Y2Cy2WrPO32aqWaY3ZqG
 QuRPIIlhHo3Yt4D6gr9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap_uc() is only meaningful on old x86-32 systems with the PAT
extension, and on ia64 with its slightly unconventional ioremap()
behavior, everywhere else this is the same as ioremap() anyway.

Change the only driver that still references ioremap_uc() to only do so
on x86-32/ia64 in order to allow removing that interface at some
point in the future for the other architectures.

On some architectures, ioremap_uc() just returns NULL, changing
the driver to call ioremap() means that they now have a chance
of working correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/aty/atyfb_base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 79d548746efd..bdbaca7200b2 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3420,11 +3420,15 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	}
 
 	info->fix.mmio_start = raddr;
+#if defined(__i386__) || defined(__ia64__)
 	/*
 	 * By using strong UC we force the MTRR to never have an
 	 * effect on the MMIO region on both non-PAT and PAT systems.
 	 */
 	par->ati_regbase = ioremap_uc(info->fix.mmio_start, 0x1000);
+#else
+	par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
+#endif
 	if (par->ati_regbase == NULL)
 		return -ENOMEM;
 
-- 
2.20.0

