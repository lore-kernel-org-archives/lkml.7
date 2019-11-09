Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D107C17441
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6755E2084D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfKIAm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 19:42:58 -0500
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:33698 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726394AbfKIAmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 19:42:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id AB635180AA507;
        Sat,  9 Nov 2019 00:42:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: frog72_1876ec24ece58
X-Filterd-Recvd-Size: 10549
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat,  9 Nov 2019 00:42:47 +0000 (UTC)
Message-ID: <14f8e1441396d19bdec30f0db6f995145c132672.camel@perches.com>
Subject: Re: [PATCH] drm/rockchip: use DRM_DEV_ERROR for log output
From:   Joe Perches <joe@perches.com>
To:     Sean Paul <sean@poorly.run>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>, hjc@rock-chips.com,
        heiko@sntech.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Nov 2019 16:42:33 -0800
In-Reply-To: <20191107133851.GF63329@art_vandelay>
References: <20191107092945.15513-1-wambui.karugax@gmail.com>
         <4c74db2614cefe23f888d0643c2d7c356086745a.camel@perches.com>
         <20191107133851.GF63329@art_vandelay>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-07 at 08:38 -0500, Sean Paul wrote:
> On Thu, Nov 07, 2019 at 01:54:22AM -0800, Joe Perches wrote:
> > On Thu, 2019-11-07 at 12:29 +0300, Wambui Karuga wrote:
> > > Replace the use of the dev_err macro with the DRM_DEV_ERROR
> > > DRM helper macro.
> > 
> > The commit message should show the reason _why_ you are doing
> > this instead of just stating that you are doing this.
> > 
> > It's not that dev_err is uncommon in drivers/gpu/drm.
> > 
> 
> It is uncommon (this is the sole instance) in rockchip, however. So it makes
> sense to convert the dev_* prints in rockchip to DRM_DEV for consistency.
> 
> Wambui, could you also please convert the dev_warn instance as well?
> 
> I'll apply this to drm-misc-next and expand on the commit message a bit.

Here's a patch that reduces the size of a defconfig arm build
for drivers/gpu/drm by about 4k by removing the separate
KERN_<LEVEL> argument from drm_dev_printk and change the macros
to prefix the KERN_<LEVEL> to the format.

It also trivially reduces an x86 defconfig.

Here are the arm object size changes: (only files with size deltas)

     old      new  savings filename

    4521     4505       16 drivers/gpu/drm/panel/panel-raydium-rm68200.o
   14003    13983       20 drivers/gpu/drm/drm_fb_helper.o
    2946     3122     -176 drivers/gpu/drm/drm_print.o
   29656    29644       12 drivers/gpu/drm/panfrost/panfrost.o
    1012     1000       12 drivers/gpu/drm/panfrost/panfrost_devfreq.o
    3184     3144       40 drivers/gpu/drm/rockchip/analogix_dp-rockchip.o
   11780    11772        8 drivers/gpu/drm/rockchip/rockchip_vop_reg.o
    3860     3836       24 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.o
    6832     6748       84 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.o
   19247    19167       80 drivers/gpu/drm/rockchip/rockchip_drm_vop.o
    3449     3433       16 drivers/gpu/drm/rockchip/rockchip_drm_drv.o
   57144    56824      320 drivers/gpu/drm/rockchip/rockchipdrm.o
     820      800       20 drivers/gpu/drm/rockchip/rockchip_drm_fb.o
    1032     1012       20 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.o
    4248     4220       28 drivers/gpu/drm/rockchip/inno_hdmi.o
    3088     3076       12 drivers/gpu/drm/vc4/vc4_hvs.o
  113808   113796       12 drivers/gpu/drm/vc4/vc4.o
    2506     2478       28 drivers/gpu/drm/drm_client.o
   19059    19027       32 drivers/gpu/drm/bridge/analogix/analogix_dp.o
   11387    11355       32 drivers/gpu/drm/bridge/analogix/analogix_dp_core.o
    3060     3020       40 drivers/gpu/drm/exynos/exynos_drm_gem.o
   17928    17864       64 drivers/gpu/drm/exynos/exynos_hdmi.o
     536      528        8 drivers/gpu/drm/exynos/exynos_drm_dma.o
     981      957       24 drivers/gpu/drm/exynos/exynos_drm_fb.o
    1556     1524       32 drivers/gpu/drm/exynos/exynos_drm_fbdev.o
    8932     8888       44 drivers/gpu/drm/exynos/exynos_drm_fimd.o
    2021     1997       24 drivers/gpu/drm/exynos/exynos_dp.o
    1172     1148       24 drivers/gpu/drm/exynos/exynos_drm_dpi.o
   66538    66214      324 drivers/gpu/drm/exynos/exynosdrm.o
   11982    11950       32 drivers/gpu/drm/exynos/exynos_mixer.o
    1528     1512       16 drivers/gpu/drm/exynos/exynos_drm_plane.o
   11534    11518       16 drivers/gpu/drm/exynos/exynos_drm_dsi.o
    1263     1255        8 drivers/gpu/drm/drm_gem_framebuffer_helper.o
    8085     8057       28 drivers/gpu/drm/msm/adreno/adreno_gpu.o
    1656     1640       16 drivers/gpu/drm/msm/adreno/a5xx_preempt.o
   10581    10481      100 drivers/gpu/drm/msm/adreno/a6xx_gmu.o
   14722    14694       28 drivers/gpu/drm/msm/adreno/a5xx_gpu.o
    4608     4592       16 drivers/gpu/drm/msm/adreno/adreno_device.o
    2486     2466       20 drivers/gpu/drm/msm/adreno/a6xx_hfi.o
    5190     5182        8 drivers/gpu/drm/msm/adreno/a3xx_gpu.o
    5942     5934        8 drivers/gpu/drm/msm/adreno/a4xx_gpu.o
    8900     8860       40 drivers/gpu/drm/msm/adreno/a6xx_gpu.o
    1432     1420       12 drivers/gpu/drm/msm/adreno/a5xx_debugfs.o
  558494   556918     1576 drivers/gpu/drm/msm/msm.o
    8461     8389       72 drivers/gpu/drm/msm/msm_gpu.o
    1616     1596       20 drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.o
   12377    12353       24 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.o
   16950    16930       20 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.o
    1768     1760        8 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.o
    1320     1308       12 drivers/gpu/drm/msm/disp/mdp5/mdp5_irq.o
    8228     8212       16 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.o
    8307     8271       36 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.o
    8252     8152      100 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.o
    2883     2855       28 drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.o
    4538     4518       20 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.o
    4916     4852       64 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.o
    2896     2856       40 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.o
    1844     1820       24 drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.o
     836      824       12 drivers/gpu/drm/msm/disp/mdp4/mdp4_irq.o
    6529     6525        4 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.o
    2616     2600       16 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.o
    1896     1872       24 drivers/gpu/drm/msm/msm_fb.o
    1748     1732       16 drivers/gpu/drm/msm/edp/edp.o
    1724     1708       16 drivers/gpu/drm/msm/msm_debugfs.o
    8390     8334       56 drivers/gpu/drm/msm/msm_gem.o
    5316     5304       12 drivers/gpu/drm/msm/dsi/dsi_manager.o
    2212     2188       24 drivers/gpu/drm/msm/dsi/dsi.o
    5240     5224       16 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.o
     968      960        8 drivers/gpu/drm/msm/dsi/pll/dsi_pll.o
    2768     2740       28 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.o
    6276     6244       32 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.o
    4908     4864       44 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.o
   16704    16672       32 drivers/gpu/drm/msm/dsi/dsi_host.o
    1392     1380       12 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.o
    1264     1252       12 drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.o
    2208     2188       20 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.o
   10536    10456       80 drivers/gpu/drm/msm/dsi/phy/dsi_phy.o
    1520     1500       20 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.o
    2100     2088       12 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.o
   11032    10984       48 drivers/gpu/drm/msm/msm_drv.o
    1328     1308       20 drivers/gpu/drm/msm/msm_fbdev.o
    2892     2848       44 drivers/gpu/drm/msm/hdmi/hdmi_phy.o
    6448     6436       12 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.o
    3872     3860       12 drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.o
    7052     6932      120 drivers/gpu/drm/msm/hdmi/hdmi.o
    2216     2164       52 drivers/gpu/drm/msm/hdmi/hdmi_bridge.o
    1652     1640       12 drivers/gpu/drm/msm/hdmi/hdmi_i2c.o
 6236178  6231730     4448 (TOTALS)
---
 drivers/gpu/drm/drm_print.c | 19 +++++++++++++++----
 include/drm/drm_print.h     |  9 ++++-----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 9a25d7..fd6a3a9 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -235,14 +235,25 @@ void drm_print_bits(struct drm_printer *p, unsigned long value,
 }
 EXPORT_SYMBOL(drm_print_bits);
 
-void drm_dev_printk(const struct device *dev, const char *level,
-		    const char *format, ...)
+void drm_dev_printk(const struct device *dev, const char *fmt, ...)
 {
+	char level[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = {0};
+	int kern_level;
 	struct va_format vaf;
 	va_list args;
 
-	va_start(args, format);
-	vaf.fmt = format;
+	va_start(args, fmt);
+
+	kern_level = printk_get_level(fmt);
+	if (kern_level >= '0' && kern_level <= '7') {
+		size_t size = printk_skip_level(fmt) - fmt;
+
+		memcpy(level, fmt, size);
+		level[size] = '\0';
+		fmt += size;
+	}
+
+	vaf.fmt = fmt;
 	vaf.va = &args;
 
 	if (dev)
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 5b8049..fa0c12 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -298,9 +298,8 @@ static inline bool drm_debug_enabled(unsigned int category)
 	return unlikely(drm_debug & category);
 }
 
-__printf(3, 4)
-void drm_dev_printk(const struct device *dev, const char *level,
-		    const char *format, ...);
+__printf(2, 3)
+void drm_dev_printk(const struct device *dev, const char *fmt, ...);
 __printf(3, 4)
 void drm_dev_dbg(const struct device *dev, unsigned int category,
 		 const char *format, ...);
@@ -336,7 +335,7 @@ void drm_err(const char *format, ...);
  * @fmt: printf() like format string.
  */
 #define DRM_DEV_ERROR(dev, fmt, ...)					\
-	drm_dev_printk(dev, KERN_ERR, "*ERROR* " fmt, ##__VA_ARGS__)
+	drm_dev_printk(dev, KERN_ERR "*ERROR* " fmt, ##__VA_ARGS__)
 #define DRM_ERROR(fmt, ...)						\
 	drm_err(fmt, ##__VA_ARGS__)
 
@@ -359,7 +358,7 @@ void drm_err(const char *format, ...);
 	DRM_DEV_ERROR_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
 
 #define DRM_DEV_INFO(dev, fmt, ...)					\
-	drm_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
+	drm_dev_printk(dev, KERN_INFO fmt, ##__VA_ARGS__)
 
 #define DRM_DEV_INFO_ONCE(dev, fmt, ...)				\
 ({									\

