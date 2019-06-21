Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59055C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FA920673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="id7mnY2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfFUWGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 18:06:31 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48414 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUWGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 18:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jX9XlpcTLLOOIrMr4SyDt6yC0e/OgEsRb2brF8hf3hk=; b=id7mnY2l5MCrhfuOEXnhVqh/+
        VZtNehzcxnvRAOPZAUTzyqQcxnRv/zWcYALtmRNtG3mtBgCl5NNFPIv9hCsM8GEwDjuhVCiX0Wqk0
        5+vzWGeHEsV7mvM8fu+kj4clE5AKsckT6mKo1TfsNLa70YyFco5qGIXgmoMpI57NJ827LycG6mtRY
        aRBDiEpfClhglCL/ziJF6G5q0fGYAc1yB74LneNbL/es+miZeMU6dAtoEF23QKfgzypyGOR8jxTXn
        Rh2DG4bUgaHgdiJNqAu2ME27pDqaoO0lrH0eZNPu9b8H3aUhHKSsdyibbIVIOhIv52ibgWeP5aaBm
        g95VXBzFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59870)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1heRfs-0007zn-QA; Fri, 21 Jun 2019 23:06:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1heRfo-0003b6-Um; Fri, 21 Jun 2019 23:06:20 +0100
Date:   Fri, 21 Jun 2019 23:06:20 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v1 1/2] drm/i2c: tda998x: access chip registers via a
 regmap
Message-ID: <20190621220620.symr2y4ebbbpkl54@shell.armlinux.org.uk>
References: <20190527191552.10413-1-TheSven73@gmail.com>
 <20190621151500.cv57g3al5sadpcum@shell.armlinux.org.uk>
 <CAGngYiU_drPPXAzY3W3duxxTcUXUASeuCu_wj8zmxvrasEDq8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiU_drPPXAzY3W3duxxTcUXUASeuCu_wj8zmxvrasEDq8Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:13:33PM -0400, Sven Van Asbroeck wrote:
> On Fri, Jun 21, 2019 at 11:15 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > Another con is the need to keep the functions that detail the register
> > properties up to date, which if they're wrong may result in unexpected
> > behaviour.
> >
> > I subscribe to the "keep it simple" approach, and regmap, although
> > useful, seems like a giant sledgehammer for this.
> >
> 
> Thank you for the review !
> 
> I added this back when I was debugging audio artifacts related to this
> chip. The regmap's debugfs binding was extremely useful. So I
> dressed it up a bit in the hope that it would have some general use.
> 
> But if the cons outweigh the pros, then this is as far as this patch
> will go...

I won't disagree that debugfs access to the registers is useful,
especially as I keep this patch locally for that exact purpose:

8<===
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] drm/i2c: tda998x: debugfs register access

Add support for dumping the register contents via debugfs, with a
mechanism to write to the TDA998x registers to allow experimentation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 114 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 5312fde8b624..6ad1fd1d28a5 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -16,10 +16,13 @@
  */
 
 #include <linux/component.h>
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/hdmi.h>
 #include <linux/module.h>
 #include <linux/platform_data/tda9950.h>
+#include <linux/seq_file.h>
 #include <linux/irq.h>
 #include <sound/asoundef.h>
 #include <sound/hdmi-codec.h>
@@ -1239,6 +1242,116 @@ static int tda998x_audio_codec_init(struct tda998x_priv *priv,
 }
 
 /* DRM connector functions */
+static u8 tda998x_debugfs_pages[] = {
+	0x00, 0x01, 0x02, 0x09, 0x10, 0x11, 0x12, 0x13
+};
+
+static void *tda998x_regs_start(struct seq_file *s, loff_t *pos)
+{
+	return *pos < ARRAY_SIZE(tda998x_debugfs_pages) ? pos : NULL;
+}
+
+static void *tda998x_regs_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	(*pos)++;
+	return *pos < ARRAY_SIZE(tda998x_debugfs_pages) ? pos : NULL;
+}
+
+static void tda998x_regs_stop(struct seq_file *s, void *v)
+{
+}
+
+static int tda998x_regs_show(struct seq_file *s, void *v)
+{
+	struct tda998x_priv *priv = s->private;
+	u8 page = tda998x_debugfs_pages[*(loff_t *)v];
+	unsigned int i, j;
+	u8 buf[16];
+
+	seq_printf(s, "==================== page %02x ======================\n", page);
+	seq_printf(s, "     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f\n");
+	for (i = 0; i < 256; i += sizeof(buf)) {
+		reg_read_range(priv, REG(page, i), buf, sizeof(buf));
+
+		seq_printf(s, "%02x:", i);
+		for (j = 0; j < sizeof(buf); j++)
+			seq_printf(s, " %02x", buf[j]);
+		seq_printf(s, " : ");
+		for (j = 0; j < sizeof(buf); j++)
+			seq_printf(s, "%c",
+				   isascii(buf[j]) && isprint(buf[j]) ?
+				   buf[j] : '.');
+		seq_putc(s, '\n');
+	}
+	return 0;
+}
+
+static const struct seq_operations tda998x_regs_sops = {
+	.start	= tda998x_regs_start,
+	.next	= tda998x_regs_next,
+	.stop	= tda998x_regs_stop,
+	.show	= tda998x_regs_show,
+};
+
+static int tda998x_regs_open(struct inode *inode, struct file *file)
+{
+	int ret = seq_open(file, &tda998x_regs_sops);
+	if (ret < 0)
+		return ret;
+
+	((struct seq_file *)file->private_data)->private = inode->i_private;
+
+	return 0;
+}
+
+static ssize_t tda998x_regs_write(struct file *file, const char __user *buf,
+				  size_t count, loff_t *offset)
+{
+	struct tda998x_priv *priv =
+		((struct seq_file *)file->private_data)->private;
+	unsigned int page, addr, mask, val;
+	unsigned char rval;
+	char buffer[16];
+
+	memset(buffer, 0, sizeof(buffer));
+	if (count > sizeof(buffer) - 1)
+		count = sizeof(buffer) - 1;
+	if (copy_from_user(buffer, buf, count))
+		return -EFAULT;
+
+	if (sscanf(buffer, "%x %x %x %x", &page, &addr, &mask, &val) != 4)
+		return -EINVAL;
+	if (page > 0xff || addr > 0xff || mask > 0xff || val > 0xff)
+		return -ERANGE;
+
+	rval = reg_read(priv, REG(page, addr));
+	rval &= ~mask;
+	rval |= val & mask;
+	reg_write(priv, REG(page, addr), rval);
+
+	printk("i2c write %02x @ page:%02x address:%02x\n", rval, page, addr);
+
+	return count;
+}
+
+static const struct file_operations tda998x_regs_fops = {
+	.owner = THIS_MODULE,
+	.open = tda998x_regs_open,
+	.read = seq_read,
+	.write = tda998x_regs_write,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int tda998x_late_register(struct drm_connector *connector)
+{
+	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
+
+	debugfs_create_file("tda998x-regs", 0600, connector->debugfs_entry,
+			    priv, &tda998x_regs_fops);
+
+	return 0;
+}
 
 static enum drm_connector_status
 tda998x_connector_detect(struct drm_connector *connector, bool force)
@@ -1259,6 +1372,7 @@ static const struct drm_connector_funcs tda998x_connector_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = tda998x_connector_detect,
+	.late_register = tda998x_late_register,
 	.destroy = tda998x_connector_destroy,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-- 
2.7.4


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
