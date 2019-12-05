Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ABCC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE0F224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL0aI/7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfLEN7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:59:37 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45222 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfLEN7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:59:36 -0500
Received: by mail-vk1-f193.google.com with SMTP id g7so1113411vkl.12;
        Thu, 05 Dec 2019 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P1Wu/yddM5H2OFvQ6y1xNQEsAdufOs232AZlmWT/ayE=;
        b=NL0aI/7NAZOFzno3lL9IRDpqn1xMeZMTwHuCqoRczJJ8kGyrzbjEFfUXcHq2dNtisQ
         K5qdTjHFC3KjirMvEoLYveZZOFQxAwViJvb73Y6d7vk42qYtzUPbxULiyMjlalr7l2Iv
         zaea4TsELL8+4lC8dNTWjZNFRoe2lyf+LkO1Dt6paBYDgTP3LLCt8skgo9SXm3tZI7wu
         46ffXdd0T+C5Cu8i798EA5JH06FuHWuTpeQB6vNu00agLI8Vwx4zCrXJJFjNMHk59lyX
         p0i4A6/tWKMrbpy5QbLcOqipjRSG2mo3NMQw8wlRqdi1flKAZaLp42/7AYpN+tWKAt+d
         NmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P1Wu/yddM5H2OFvQ6y1xNQEsAdufOs232AZlmWT/ayE=;
        b=BEUEU/7H4is+m7Fag6BxP5aOQvs/b7M5xIygHI6pd9gIsPRSOgCkbWsFifV1oCFxC8
         /hJW4IHm7WHpLuv+ByB/sUkihI5imY3k1KKC7we+6WF290OH/lBM0u7HTKBO90p+0XwB
         xWLKVHrJG2m8pU/r/ZiEYbeF+rr5CP6nJCdLVHaLigkls1B4zSDES+lPCPwZzR6QI6I5
         hCNAcGIlVAQvYV8dXMMI2Ndv12lSW7FfolVNT/LkqGmJyDjUhuKP05xIrnytd1CgFGl5
         gUhyniDYVnTspZSVYJvvLG8vrz5tmrEvVqZAU5fvwU5j+oIJ2p0F13XRqXgxMjU5r93v
         kWTQ==
X-Gm-Message-State: APjAAAUDjkg4byW+TQ7XprWWggS9r2IIbZQP4iTGzSMCV/rXLLksA2v8
        O4I79YQDvDyjv0u3zjwkvucr9bZtlxE=
X-Google-Smtp-Source: APXvYqw0iPY8pQz1uY/PE9t5tILQQ2t/PGlqNQ6Qcm14oKF2EFfJ27amjQBBOqc8Z0SRF3acvxzCWQ==
X-Received: by 2002:a1f:5e13:: with SMTP id s19mr6446724vkb.12.1575554375018;
        Thu, 05 Dec 2019 05:59:35 -0800 (PST)
Received: from sca.local ([177.38.102.90])
        by smtp.gmail.com with ESMTPSA id w7sm2256408vsi.28.2019.12.05.05.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 05:59:34 -0800 (PST)
From:   Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
To:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     alencar.fmce@imbel.gov.br,
        Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: [PATCH] video: fbdev: added driver for sharp memory lcd displays
Date:   Thu,  5 Dec 2019 11:58:55 -0200
Message-Id: <1575554335-27197-1-git-send-email-alencar.fmce@imbel.gov.br>
X-Mailer: git-send-email 1.9.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supported displays are ls027b7dh01 (tested), ls044q7dh01,
ls013b7dh05, ls013b7dh03

Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
---
 .../devicetree/bindings/display/smemlcdfb.txt |  46 ++
 drivers/video/fbdev/Kconfig                   |  14 +
 drivers/video/fbdev/Makefile                  |   1 +
 drivers/video/fbdev/smemlcdfb.c               | 503 ++++++++++++++++++
 4 files changed, 564 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/smemlcdfb.txt
 create mode 100644 drivers/video/fbdev/smemlcdfb.c

diff --git a/Documentation/devicetree/bindings/display/smemlcdfb.txt b/Documentation/devicetree/bindings/display/smemlcdfb.txt
new file mode 100644
index 000000000000..e33025dd3374
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/smemlcdfb.txt
@@ -0,0 +1,46 @@
+Sharp Memory LCD Linux Framebuffer Driver
+
+Required properties:
+  - compatible: It should be "sharp,<model-no>". The supported displays are 
+         ls027b7dh01, ls044q7dh01, ls013b7dh05, ls013b7dh03. Maybe other 
+         monochromatic models can be supported with the current code.
+  - reg: SPI chip select number for the device.
+  - spi-max-frequency: Max SPI frequency to use. One must verify the datasheet.
+  - spi-cs-high: Sharp Memory LCD needs chipselect high.
+
+Optional properties:
+  - sharp,frames-per-sec: It should contain the desired frames per second.
+         It does not represent the actual frame rate. Default: 10
+  - sharp,extmode-high: External COM Input signal is expected in EXTCOMIN port.
+         This is recommended to reduce CPU and SPI Load.
+  - pwm: If property "sharp,extmode-high" is specified, this is recommended.
+         It should contain the pwm to use, according to
+         Documentation/devicetree/bindings/pwm/pwm.txt
+         Verify the display datasheet for the EXTCOMIN signal period
+  - disp-gpios: The GPIO used to enable the display, if available. See
+                 Documentation/devicetree/bindings/gpio/gpio.txt for details.
+
+Examples:
+
+ls027b7dh01: smemlcd@0 {
+        compatible = "sharp,ls027b7dh01";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        spi-cs-high;
+        disp-gpios = <&gpio0 7>;
+        disp-active-high;
+        sharp,extmode-high;
+        pwms = <&pwm 0 100000000>;
+};
+
+ls013b7dh05: smemlcd@3 {
+        compatible = "sharp,ls013b7dh05";
+        reg = <3>;
+        spi-max-frequency = <1000000>;
+        spi-cs-high;
+        disp-gpios = <&gpio0 13>;
+        disp-active-high;
+        sharp,extmode-high;
+        pwms = <&pwm 0 50000000>;
+        sharp,frames-per-sec = <20>;
+};
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index aa9541bf964b..626a572edc4e 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2264,6 +2264,20 @@ config FB_SM712
 	  called sm712fb. If you want to compile it as a module, say M
 	  here and read <file:Documentation/kbuild/modules.rst>.
 
+config FB_SMEMLCD
+	tristate "Sharp Memory LCD framebuffer support"
+	depends on FB && SPI
+	depends on OF
+	depends on GPIOLIB || COMPILE_TEST
+	select FB_SYS_FOPS
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_DEFERRED_IO
+	select PWM
+	help
+	  This driver implements support for the Sharp Memory LCD
+
 source "drivers/video/fbdev/omap/Kconfig"
 source "drivers/video/fbdev/omap2/Kconfig"
 source "drivers/video/fbdev/mmp/Kconfig"
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index aa6352798cf4..3c0e060e9069 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -120,6 +120,7 @@ obj-$(CONFIG_FB_PUV3_UNIGFX)      += fb-puv3.o
 obj-$(CONFIG_FB_HYPERV)		  += hyperv_fb.o
 obj-$(CONFIG_FB_OPENCORES)	  += ocfb.o
 obj-$(CONFIG_FB_SM712)		  += sm712fb.o
+obj-$(CONFIG_FB_SMEMLCD)	  += smemlcdfb.o
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
diff --git a/drivers/video/fbdev/smemlcdfb.c b/drivers/video/fbdev/smemlcdfb.c
new file mode 100644
index 000000000000..635f8e27d632
--- /dev/null
+++ b/drivers/video/fbdev/smemlcdfb.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 IMBEL http://www.imbel.gov.br 
+ *	Rodrigo Alencar <alencar.fmce@imbel.gov.br>
+ */
+
+#include <linux/fb.h>
+#include <linux/bitrev.h>
+#include <linux/gpio/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/pwm.h>
+
+#define SMEMLCD_DATA_UPDATE		0x80
+#define SMEMLCD_FRAME_INVERSION		0x40
+#define SMEMLCD_ALL_CLEAR		0x20
+#define SMEMLCD_DUMMY_DATA		0x00
+
+struct smemlcd_info {
+	u32 width;
+	u32 height;
+};
+
+struct smemlcd_par {
+	struct spi_device *spi;
+	struct fb_info *info;
+	struct pwm_device *extcomin_pwm;
+	struct gpio_desc *disp;
+	struct delayed_work d_work;
+	struct mutex update_lock;
+
+	u8 *spi_buf;
+
+	bool extmode;
+	u32 spi_width;
+	u32 vmem_width;
+
+	u8 vcom;
+	u32 start;
+	u32 height;
+};
+
+static struct fb_fix_screeninfo smemlcd_fix = {
+	.id = "Sharp Memory LCD",
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_MONO10,
+	.xpanstep = 0,
+	.ypanstep = 0,
+	.ywrapstep = 0,
+	.accel = FB_ACCEL_NONE,
+};
+
+static struct fb_var_screeninfo smemlcd_var = {
+	.bits_per_pixel = 1,
+	.red = {0, 1, 0},
+	.green = {0, 1, 0},
+	.blue = {0, 1, 0},
+	.transp = {0, 0, 0},
+	.left_margin = 0,
+	.right_margin = 0,
+	.upper_margin = 0,
+	.lower_margin = 0,
+	.vmode = FB_VMODE_NONINTERLACED,
+};
+
+static void smemlcd_update(struct smemlcd_par *par)
+{
+	struct spi_device *spi = par->spi;
+	u8 *vmem = par->info->screen_base;
+	u8 *buf_ptr = par->spi_buf;
+	int ret;
+	u32 i,j;
+
+	if (par->start + par->height > par->info->var.yres) {
+		par->start = 0;
+		par->height = 0;
+	}
+	/* go to start line */
+	vmem += par->start * par->vmem_width;
+	/* update vcom */
+	par->vcom ^= SMEMLCD_FRAME_INVERSION;
+	/* mode selection */
+	*(buf_ptr++) = (par->height)? (SMEMLCD_DATA_UPDATE | par->vcom) : par->vcom;
+
+	/* not all SPI masters have LSB-first mode, bitrev8 is used */
+	for (i = par->start + 1; i < par->start + par->height + 1; i++) {
+		/* gate line address */
+		*(buf_ptr++) = bitrev8(i);
+		/* data writing */
+		for (j = 0; j < par->spi_width; j++)
+			*(buf_ptr++) = bitrev8(*(vmem++));
+		/* dummy data */
+		*(buf_ptr++) = SMEMLCD_DUMMY_DATA;
+		/* video memory alignment */
+		for (; j < par->vmem_width; j++)
+			vmem++;
+	}
+	/* dummy data */
+	*(buf_ptr++) = SMEMLCD_DUMMY_DATA;
+
+	ret = spi_write(spi, &(par->spi_buf[0]), par->height * (par->spi_width + 2) + 2);
+	if (ret < 0)
+		dev_err(&spi->dev, "Couldn't send SPI command.\n");
+
+	par->start = U32_MAX;
+	par->height = 0;
+}
+
+static void smemlcd_frame(struct smemlcd_par *par, u32 req_start, u32 req_height)
+{
+	u32 end = par->start + par->height;
+	u32 req_end = req_start + req_height;
+	if (req_end > par->info->var.yres)
+		req_end = par->info->var.yres;
+	if (par->start > req_start)
+		par->start = req_start;
+	if (end < req_end || end > par->info->var.yres)
+		end = req_end;
+	par->height = end - par->start;
+}
+
+static void smemlcd_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+{
+	struct smemlcd_par *par = info->par;
+	sys_fillrect(info, rect);
+
+	mutex_lock(&par->update_lock);
+	smemlcd_frame(par, rect->dy, rect->height);
+	if(par->extmode)
+		smemlcd_update(par);
+	mutex_unlock(&par->update_lock);
+}
+
+static void smemlcd_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+	struct smemlcd_par *par = info->par;
+	sys_imageblit(info, image);
+
+	mutex_lock(&par->update_lock);
+	smemlcd_frame(par, image->dy, image->height);
+	if(par->extmode)
+		smemlcd_update(par);
+	mutex_unlock(&par->update_lock);
+}
+
+static void smemlcd_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+{
+	struct smemlcd_par *par = info->par;
+	sys_copyarea(info, area);
+
+	mutex_lock(&par->update_lock);
+	smemlcd_frame(par, area->dy, area->height);
+	if(par->extmode)
+		smemlcd_update(par);
+	mutex_unlock(&par->update_lock);
+}
+
+static ssize_t smemlcd_write(struct fb_info *info, const char __user * buf, size_t count, loff_t * ppos)
+{
+	ssize_t ret;
+	struct smemlcd_par *par = info->par;
+	u32 req_start, req_height;
+	u32 offset = (u32) * ppos;
+
+	ret = fb_sys_write(info, buf, count, ppos);
+	if (ret > 0) {
+		mutex_lock(&par->update_lock);
+		req_start = max((int)(offset / par->vmem_width), 0);
+		req_height = ret / par->vmem_width + 1;
+		smemlcd_frame(par, req_start, req_height);
+		if(par->extmode)
+			smemlcd_update(par);
+		mutex_unlock(&par->update_lock);
+	}
+
+	return ret;
+}
+
+static int smemlcd_blank(int blank_mode, struct fb_info *info)
+{
+	struct smemlcd_par *par = info->par;
+
+	if (par->disp) {
+		if (blank_mode != FB_BLANK_UNBLANK)
+			gpiod_set_value_cansleep(par->disp, 0);
+		else
+			gpiod_set_value_cansleep(par->disp, 1);
+	}
+
+	return 0;
+}
+
+static void smemlcd_deferred_io(struct fb_info *info, struct list_head *pagelist)
+{
+	struct smemlcd_par *par = info->par;
+
+	mutex_lock(&par->update_lock);
+
+	if (!list_empty(pagelist)) {
+		struct page *cur;
+		u32 req_start;
+		u32 req_height = (PAGE_SIZE / par->vmem_width) + 1;
+
+		list_for_each_entry(cur, pagelist, lru) {
+			req_start = (cur->index << PAGE_SHIFT) / par->vmem_width;
+			smemlcd_frame(par, req_start, req_height);
+		}
+	}
+
+	if(par->extmode)
+		smemlcd_update(par);
+	mutex_unlock(&par->update_lock);
+}
+
+static void smemlcd_update_work(struct work_struct *work)
+{
+	struct smemlcd_par *par = container_of(work, struct smemlcd_par, d_work.work);
+	struct fb_info *info = par->info;
+
+	mutex_lock(&par->update_lock);
+	smemlcd_update(par);
+	mutex_unlock(&par->update_lock);
+
+	if (!par->extmode)
+		schedule_delayed_work(&par->d_work, info->fbdefio->delay);
+}
+
+static struct fb_ops smemlcd_ops = {
+	.owner = THIS_MODULE,
+	.fb_read = fb_sys_read,
+	.fb_write = smemlcd_write,
+	.fb_fillrect = smemlcd_fillrect,
+	.fb_copyarea = smemlcd_copyarea,
+	.fb_imageblit = smemlcd_imageblit,
+	.fb_blank = smemlcd_blank,
+};
+
+static struct smemlcd_info ls027b7dh01_info = {
+	.width = 400,
+	.height = 240,
+};
+
+static struct smemlcd_info ls044q7dh01_info = {
+	.width = 320,
+	.height = 240,
+};
+
+static struct smemlcd_info ls013b7dh05_info = {
+	.width = 144,
+	.height = 168,
+};
+
+static struct smemlcd_info ls013b7dh03_info = {
+	.width = 128,
+	.height = 128,
+};
+
+static const struct of_device_id smemlcd_of_match[] = {
+	{
+	 .compatible = "sharp,ls027b7dh01",
+	 .data = (void *)&ls027b7dh01_info,
+	 },
+	{
+	 .compatible = "sharp,ls044q7dh01",
+	 .data = (void *)&ls044q7dh01_info,
+	 },
+	{
+	 .compatible = "sharp,ls013b7dh05",
+	 .data = (void *)&ls013b7dh05_info,
+	 },
+	{
+	 .compatible = "sharp,ls013b7dh03",
+	 .data = (void *)&ls013b7dh03_info,
+	 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, smemlcd_of_match);
+
+static int smemlcd_probe(struct spi_device *spi)
+{
+	struct fb_info *info;
+	struct smemlcd_par *par;
+	const struct smemlcd_info *devinfo;
+	struct fb_deferred_io *smemlcd_defio;
+	struct device_node *node = spi->dev.of_node;
+	struct pwm_state state;
+	u32 vmem_size, fps;
+	u8 *vmem;
+	u8 *buf_ptr;
+	int ret;
+
+	info = framebuffer_alloc(sizeof(struct smemlcd_par), &spi->dev);
+	if (!info) {
+		dev_err(&spi->dev, "Failed to allocate framebuffer.\n");
+		return -ENOMEM;
+	}
+
+	par = info->par;
+	par->info = info;
+	par->spi = spi;
+
+	devinfo = of_device_get_match_data(&spi->dev);
+
+	par->disp = devm_gpiod_get_optional(&spi->dev, "disp", GPIOD_OUT_LOW);
+	if (IS_ERR(par->disp)) {
+		ret = PTR_ERR(par->disp);
+		dev_err(&spi->dev, "Failed to get DISP gpio: %d\n", ret);
+		goto free_fb;
+	}
+
+	mutex_init(&par->update_lock);
+	INIT_DELAYED_WORK(&par->d_work, smemlcd_update_work);
+	par->spi_width = devinfo->width / 8;
+	par->vmem_width = ((devinfo->width + 31) & ~31) >> 3;
+	par->vcom = 0;
+	par->start = 0;
+	par->height = 0;
+
+	par->spi_buf = kzalloc(devinfo->height * (par->spi_width + 2) + 2, GFP_KERNEL);
+	if (!par->spi_buf) {
+		ret = -ENOMEM;
+		dev_err(&spi->dev, "Failed to allocate data for spi transfers.\n");
+		goto free_fb;
+	}
+
+	vmem_size = par->vmem_width * devinfo->height;
+
+	vmem = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, get_order(vmem_size));
+	if (!vmem) {
+		ret = -ENOMEM;
+		dev_err(&spi->dev, "Failed to allocate video memory.\n");
+		goto free_spi_buf;
+	}
+
+	par->extmode = of_property_read_bool(node, "sharp,extmode-high");
+
+	if (of_property_read_u32(node, "sharp,frames-per-sec", &fps))
+		fps = 10;
+
+	smemlcd_defio = devm_kzalloc(&spi->dev, sizeof(struct fb_deferred_io), GFP_KERNEL);
+	if (!smemlcd_defio) {
+		dev_err(&spi->dev, "Couldn't allocate deferred io.\n");
+		ret = -ENOMEM;
+		goto free_vmem;
+	}
+
+	smemlcd_defio->delay = HZ / fps;
+	smemlcd_defio->deferred_io = &smemlcd_deferred_io;
+
+	info->var = smemlcd_var;
+	info->var.xres = devinfo->width;
+	info->var.xres_virtual = devinfo->width;
+	info->var.yres = devinfo->height;
+	info->var.yres_virtual = devinfo->height;
+
+	info->screen_base = (u8 __force __iomem *) vmem;
+	info->screen_size = vmem_size;
+
+	info->fbops = &smemlcd_ops;
+	info->fix = smemlcd_fix;
+	info->fix.line_length = par->vmem_width;
+	info->fix.smem_start = __pa(vmem);
+	info->fix.smem_len = vmem_size;
+
+	info->fbdefio = smemlcd_defio;
+
+	fb_deferred_io_init(info);
+
+	spi_set_drvdata(spi, par);
+
+	if (par->extmode) {
+		par->extcomin_pwm = pwm_get(&spi->dev, NULL);
+		if (IS_ERR(par->extcomin_pwm)) {
+			ret = PTR_ERR(par->extcomin_pwm);
+			dev_warn(&spi->dev, "Failed to get EXTCOMIN pwm: %d\n", ret);
+			par->extcomin_pwm = NULL;
+		} else {
+
+			pwm_init_state(par->extcomin_pwm, &state);
+
+			if (!state.period)
+				state.period = NSEC_PER_SEC/fps;
+
+			/* The duty cycle is not really important */
+			state.enabled = true;
+			state.duty_cycle = state.period/2;
+
+			ret = pwm_apply_state(par->extcomin_pwm, &state);
+			if (ret)
+				dev_warn(&spi->dev, "failed to apply EXTCOMIN pwm state: %d\n", ret);
+		}
+	} else {
+		par->extcomin_pwm = NULL;
+	}
+
+	if (par->disp)
+		gpiod_set_value_cansleep(par->disp, 1);
+
+	ret = register_framebuffer(info);
+	if (ret < 0) {
+		dev_err(&spi->dev, "Failed to register framebuffer.\n");
+		goto disable_hw;
+	}
+
+	/* spi test by clearing the display */
+	par->spi_buf[0] = SMEMLCD_ALL_CLEAR;
+	par->spi_buf[1] = SMEMLCD_DUMMY_DATA;
+	ret = spi_write(spi, &(par->spi_buf[0]), 2);
+	if (ret < 0){
+		dev_err(&spi->dev, "Couldn't send SPI command.\n");
+		goto disable_hw;
+	}
+
+	dev_info(&spi->dev, "fb%d: %s framebuffer device registered, using %d bytes of video memory\n", info->node, info->fix.id, vmem_size);
+
+	if (!par->extmode)
+		schedule_delayed_work(&par->d_work, smemlcd_defio->delay);
+
+	return 0;
+
+disable_hw:
+	if (par->disp)
+		gpiod_set_value_cansleep(par->disp, 0);
+	if (par->extcomin_pwm) {
+		state.enabled = false;
+		state.duty_cycle = 0;
+		pwm_apply_state(par->extcomin_pwm, &state);
+		pwm_put(par->extcomin_pwm);
+	}
+	kfree(smemlcd_defio);
+free_vmem:
+	kfree((void *)vmem);
+free_spi_buf:
+	kfree(par->spi_buf);
+free_fb:
+	cancel_delayed_work_sync(&par->d_work);
+	mutex_destroy(&par->update_lock);
+	framebuffer_release(info);
+
+	return ret;
+}
+
+static int smemlcd_remove(struct spi_device *spi)
+{
+	struct smemlcd_par *par = dev_get_drvdata(&spi->dev);
+	struct fb_info *info = par->info;
+	struct pwm_state state;
+
+	par->extmode = true;
+	cancel_delayed_work_sync(&par->d_work);
+
+	fb_deferred_io_cleanup(info);
+
+	unregister_framebuffer(info);
+
+	if (par->disp)
+		gpiod_set_value_cansleep(par->disp, 0);
+
+	if (par->extcomin_pwm) {
+		pwm_get_state(par->extcomin_pwm, &state);
+		state.enabled = false;
+		state.duty_cycle = 0;
+		pwm_apply_state(par->extcomin_pwm, &state);
+		pwm_put(par->extcomin_pwm);
+	}
+
+	fb_deferred_io_cleanup(info);
+	__free_pages(__va(info->fix.smem_start), get_order(info->fix.smem_len));
+
+	kfree(par->spi_buf);
+
+	mutex_destroy(&par->update_lock);
+
+	framebuffer_release(info);
+
+	return 0;
+}
+
+static const struct spi_device_id smemlcd_spi_id[] = {
+	{"ls027b7dh01", 0},
+	{"ls044q7dh01", 0},
+	{"ls013b7dh05", 0},
+	{"ls013b7dh03", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, smemlcd_spi_id);
+
+static struct spi_driver smemlcd_driver = {
+	.probe = smemlcd_probe,
+	.remove = smemlcd_remove,
+	.id_table = smemlcd_spi_id,
+	.driver = {
+		   .name = "smemlcdfb",
+		   .of_match_table = smemlcd_of_match,
+		   },
+};
+module_spi_driver(smemlcd_driver);
+
+MODULE_AUTHOR("Rodrigo Alencar <455.rodrigo.alencar@gmail.com>");
+MODULE_DESCRIPTION("Sharp Memory LCD Linux Framebuffer Driver");
+MODULE_LICENSE("GPL");
-- 
2.23.0.rc1

