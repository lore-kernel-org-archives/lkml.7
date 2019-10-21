Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17B9CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3EE20684
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfJUIFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:05:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45117 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfJUIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:05:37 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9L85OCW016301, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (rsn1.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9L85OCW016301
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 21 Oct 2019 16:05:24 +0800
Received: from localhost (172.29.40.150) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 16:05:23 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH] misc: rtsx: Add support for RTS5261
Date:   Mon, 21 Oct 2019 16:05:05 +0800
Message-ID: <1571645105-5028-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

Add support for new chip rts5261.
In order to support rts5261, the definitions of some internal registers
and workflow have to be modified and are different from its predecessors.
So we need this patch to ensure RTS5261 can work.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/Makefile   |   2 +-
 drivers/misc/cardreader/rts5261.c  | 792 +++++++++++++++++++++++++++++++++++++
 drivers/misc/cardreader/rts5261.h  | 233 +++++++++++
 drivers/misc/cardreader/rtsx_pcr.c |  43 +-
 drivers/misc/cardreader/rtsx_pcr.h |   1 +
 include/linux/rtsx_pci.h           |   1 +
 6 files changed, 1064 insertions(+), 8 deletions(-)
 create mode 100644 drivers/misc/cardreader/rts5261.c
 create mode 100644 drivers/misc/cardreader/rts5261.h

diff --git a/drivers/misc/cardreader/Makefile b/drivers/misc/cardreader/Makefile
index d9bff5a..1f56267 100644
--- a/drivers/misc/cardreader/Makefile
+++ b/drivers/misc/cardreader/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_MISC_ALCOR_PCI)	+= alcor_pci.o
 obj-$(CONFIG_MISC_RTSX_PCI)	+= rtsx_pci.o
-rtsx_pci-objs := rtsx_pcr.o rts5209.o rts5229.o rtl8411.o rts5227.o rts5249.o rts5260.o
+rtsx_pci-objs := rtsx_pcr.o rts5209.o rts5229.o rtl8411.o rts5227.o rts5249.o rts5260.o rts5261.o
 obj-$(CONFIG_MISC_RTSX_USB)	+= rtsx_usb.o
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
new file mode 100644
index 00000000..32dcec2
--- /dev/null
+++ b/drivers/misc/cardreader/rts5261.c
@@ -0,0 +1,792 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Driver for Realtek PCI-Express card reader
+ *
+ * Copyright(c) 2018-2019 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * Author:
+ *   Rui FENG <rui_feng@realsil.com.cn>
+ *   Wei WANG <wei_wang@realsil.com.cn>
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/rtsx_pci.h>
+
+#include "rts5261.h"
+#include "rtsx_pcr.h"
+
+static u8 rts5261_get_ic_version(struct rtsx_pcr *pcr)
+{
+	u8 val;
+
+	rtsx_pci_read_register(pcr, DUMMY_REG_RESET_0, &val);
+	return val & IC_VERSION_MASK;
+}
+
+static void rts5261_fill_driving(struct rtsx_pcr *pcr, u8 voltage)
+{
+	u8 driving_3v3[4][3] = {
+		{0x13, 0x13, 0x13},
+		{0x96, 0x96, 0x96},
+		{0x7F, 0x7F, 0x7F},
+		{0x96, 0x96, 0x96},
+	};
+	u8 driving_1v8[4][3] = {
+		{0x99, 0x99, 0x99},
+		{0x3A, 0x3A, 0x3A},
+		{0xE6, 0xE6, 0xE6},
+		{0xB3, 0xB3, 0xB3},
+	};
+	u8 (*driving)[3], drive_sel;
+
+	if (voltage == OUTPUT_3V3) {
+		driving = driving_3v3;
+		drive_sel = pcr->sd30_drive_sel_3v3;
+	} else {
+		driving = driving_1v8;
+		drive_sel = pcr->sd30_drive_sel_1v8;
+	}
+
+	rtsx_pci_write_register(pcr, SD30_CLK_DRIVE_SEL,
+			 0xFF, driving[drive_sel][0]);
+
+	rtsx_pci_write_register(pcr, SD30_CMD_DRIVE_SEL,
+			 0xFF, driving[drive_sel][1]);
+
+	rtsx_pci_write_register(pcr, SD30_DAT_DRIVE_SEL,
+			 0xFF, driving[drive_sel][2]);
+}
+
+static void rtsx5261_fetch_vendor_settings(struct rtsx_pcr *pcr)
+{
+	u32 reg;
+	/* 0x814~0x817 */
+	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG2, &reg);
+	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
+
+	if (!rts5261_vendor_setting_valid(reg)) {
+		pcr_dbg(pcr, "skip fetch vendor setting\n");
+		return;
+	}
+
+	pcr->card_drive_sel &= 0x3F;
+	pcr->card_drive_sel |= rts5261_reg_to_card_drive_sel(reg);
+
+	if (rts5261_reg_check_reverse_socket(reg))
+		pcr->flags |= PCR_REVERSE_SOCKET;
+
+	/* 0x724~0x727 */
+	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg);
+	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg);
+
+	pcr->aspm_en = rts5261_reg_to_aspm(reg);
+	pcr->sd30_drive_sel_1v8 = rts5261_reg_to_sd30_drive_sel_1v8(reg);
+	pcr->sd30_drive_sel_3v3 = rts5261_reg_to_sd30_drive_sel_3v3(reg);
+}
+
+static void rts5261_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
+{
+	/* Set relink_time to 0 */
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, MASK_8_BIT_DEF, 0);
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
+				RELINK_TIME_MASK, 0);
+
+	if (pm_state == HOST_ENTER_S3)
+		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
+					D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
+
+	rtsx_pci_write_register(pcr, RTS5261_REG_FPDCTL,
+		SSC_POWER_DOWN, SSC_POWER_DOWN);
+}
+
+static int rts5261_enable_auto_blink(struct rtsx_pcr *pcr)
+{
+	return rtsx_pci_write_register(pcr, OLT_LED_CTL,
+		LED_SHINE_MASK, LED_SHINE_EN);
+}
+
+static int rts5261_disable_auto_blink(struct rtsx_pcr *pcr)
+{
+	return rtsx_pci_write_register(pcr, OLT_LED_CTL,
+		LED_SHINE_MASK, LED_SHINE_DISABLE);
+}
+
+static int rts5261_turn_on_led(struct rtsx_pcr *pcr)
+{
+	return rtsx_pci_write_register(pcr, GPIO_CTL,
+		0x02, 0x02);
+}
+
+static int rts5261_turn_off_led(struct rtsx_pcr *pcr)
+{
+	return rtsx_pci_write_register(pcr, GPIO_CTL,
+		0x02, 0x00);
+}
+
+/* SD Pull Control Enable:
+ *     SD_DAT[3:0] ==> pull up
+ *     SD_CD       ==> pull up
+ *     SD_WP       ==> pull up
+ *     SD_CMD      ==> pull up
+ *     SD_CLK      ==> pull down
+ */
+static const u32 rts5261_sd_pull_ctl_enable_tbl[] = {
+	RTSX_REG_PAIR(CARD_PULL_CTL2, 0xAA),
+	RTSX_REG_PAIR(CARD_PULL_CTL3, 0xE9),
+	0,
+};
+
+/* SD Pull Control Disable:
+ *     SD_DAT[3:0] ==> pull down
+ *     SD_CD       ==> pull up
+ *     SD_WP       ==> pull down
+ *     SD_CMD      ==> pull down
+ *     SD_CLK      ==> pull down
+ */
+static const u32 rts5261_sd_pull_ctl_disable_tbl[] = {
+	RTSX_REG_PAIR(CARD_PULL_CTL2, 0x55),
+	RTSX_REG_PAIR(CARD_PULL_CTL3, 0xD5),
+	0,
+};
+
+static int rts5261_sd_set_sample_push_timing_sd30(struct rtsx_pcr *pcr)
+{
+	rtsx_pci_write_register(pcr, SD_CFG1, SD_MODE_SELECT_MASK
+		| SD_ASYNC_FIFO_NOT_RST, SD_30_MODE | SD_ASYNC_FIFO_NOT_RST);
+	rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, CLK_LOW_FREQ);
+	rtsx_pci_write_register(pcr, CARD_CLK_SOURCE, 0xFF,
+			CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
+	rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, 0);
+
+	return 0;
+}
+
+static int rts5261_card_power_on(struct rtsx_pcr *pcr, int card)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+
+	if (option->ocp_en)
+		rtsx_pci_enable_ocp(pcr);
+
+
+	rtsx_pci_write_register(pcr, RTS5261_LDO1_CFG1,
+			RTS5261_LDO1_TUNE_MASK, RTS5261_LDO1_33);
+	rtsx_pci_write_register(pcr, RTS5261_LDO1233318_POW_CTL,
+			RTS5261_LDO1_POWERON, RTS5261_LDO1_POWERON);
+
+	rtsx_pci_write_register(pcr, RTS5261_LDO1233318_POW_CTL,
+			RTS5261_LDO3318_POWERON, RTS5261_LDO3318_POWERON);
+
+	msleep(20);
+
+	rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, SD_OUTPUT_EN);
+
+	/* Initialize SD_CFG1 register */
+	rtsx_pci_write_register(pcr, SD_CFG1, 0xFF,
+			SD_CLK_DIVIDE_128 | SD_20_MODE | SD_BUS_WIDTH_1BIT);
+
+	rtsx_pci_write_register(pcr, SD_SAMPLE_POINT_CTL,
+			0xFF, SD20_RX_POS_EDGE);
+	rtsx_pci_write_register(pcr, SD_PUSH_POINT_CTL, 0xFF, 0);
+	rtsx_pci_write_register(pcr, CARD_STOP, SD_STOP | SD_CLR_ERR,
+			SD_STOP | SD_CLR_ERR);
+
+	/* Reset SD_CFG3 register */
+	rtsx_pci_write_register(pcr, SD_CFG3, SD30_CLK_END_EN, 0);
+	rtsx_pci_write_register(pcr, REG_SD_STOP_SDCLK_CFG,
+			SD30_CLK_STOP_CFG_EN | SD30_CLK_STOP_CFG1 |
+			SD30_CLK_STOP_CFG0, 0);
+
+	if (pcr->extra_caps & EXTRA_CAPS_SD_SDR50 ||
+	    pcr->extra_caps & EXTRA_CAPS_SD_SDR104)
+		rts5261_sd_set_sample_push_timing_sd30(pcr);
+
+	return 0;
+}
+
+static int rts5261_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
+{
+	int err;
+	u16 val = 0;
+
+	rtsx_pci_write_register(pcr, RTS5261_CARD_PWR_CTL,
+			RTS5261_PUPDC, RTS5261_PUPDC);
+
+	switch (voltage) {
+	case OUTPUT_3V3:
+		rtsx_pci_read_phy_register(pcr, PHY_TUNE, &val);
+		val |= PHY_TUNE_SDBUS_33;
+		err = rtsx_pci_write_phy_register(pcr, PHY_TUNE, val);
+		if (err < 0)
+			return err;
+
+		rtsx_pci_write_register(pcr, RTS5261_DV3318_CFG,
+				RTS5261_DV3318_TUNE_MASK, RTS5261_DV3318_33);
+		rtsx_pci_write_register(pcr, SD_PAD_CTL,
+				SD_IO_USING_1V8, 0);
+		break;
+	case OUTPUT_1V8:
+		rtsx_pci_read_phy_register(pcr, PHY_TUNE, &val);
+		val &= ~PHY_TUNE_SDBUS_33;
+		err = rtsx_pci_write_phy_register(pcr, PHY_TUNE, val);
+		if (err < 0)
+			return err;
+
+		rtsx_pci_write_register(pcr, RTS5261_DV3318_CFG,
+				RTS5261_DV3318_TUNE_MASK, RTS5261_DV3318_18);
+		rtsx_pci_write_register(pcr, SD_PAD_CTL,
+				SD_IO_USING_1V8, SD_IO_USING_1V8);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* set pad drive */
+	rts5261_fill_driving(pcr, voltage);
+
+	return 0;
+}
+
+static void rts5261_stop_cmd(struct rtsx_pcr *pcr)
+{
+	rtsx_pci_writel(pcr, RTSX_HCBCTLR, STOP_CMD);
+	rtsx_pci_writel(pcr, RTSX_HDBCTLR, STOP_DMA);
+	rtsx_pci_write_register(pcr, RTS5260_DMA_RST_CTL_0,
+				RTS5260_DMA_RST | RTS5260_ADMA3_RST,
+				RTS5260_DMA_RST | RTS5260_ADMA3_RST);
+	rtsx_pci_write_register(pcr, RBCTL, RB_FLUSH, RB_FLUSH);
+}
+
+static void rts5261_card_before_power_off(struct rtsx_pcr *pcr)
+{
+	rts5261_stop_cmd(pcr);
+	rts5261_switch_output_voltage(pcr, OUTPUT_3V3);
+
+}
+
+static void rts5261_enable_ocp(struct rtsx_pcr *pcr)
+{
+	u8 val = 0;
+
+	val = SD_OCP_INT_EN | SD_DETECT_EN;
+	rtsx_pci_write_register(pcr, REG_OCPCTL, 0xFF, val);
+
+}
+
+static void rts5261_disable_ocp(struct rtsx_pcr *pcr)
+{
+	u8 mask = 0;
+
+	mask = SD_OCP_INT_EN | SD_DETECT_EN;
+	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, 0);
+	rtsx_pci_write_register(pcr, RTS5261_LDO1_CFG0,
+			RTS5261_LDO1_OCP_EN | RTS5261_LDO1_OCP_LMT_EN, 0);
+
+}
+
+static int rts5261_card_power_off(struct rtsx_pcr *pcr, int card)
+{
+	int err = 0;
+
+	rts5261_card_before_power_off(pcr);
+	err = rtsx_pci_write_register(pcr, RTS5261_LDO1233318_POW_CTL,
+				RTS5261_LDO_POWERON_MASK, 0);
+
+	if (pcr->option.ocp_en)
+		rtsx_pci_disable_ocp(pcr);
+
+	return err;
+}
+
+static void rts5261_init_ocp(struct rtsx_pcr *pcr)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+
+	if (option->ocp_en) {
+		u8 mask, val;
+
+		rtsx_pci_write_register(pcr, RTS5261_LDO1_CFG0,
+			RTS5261_LDO1_OCP_EN | RTS5261_LDO1_OCP_LMT_EN,
+			RTS5261_LDO1_OCP_EN | RTS5261_LDO1_OCP_LMT_EN);
+
+		rtsx_pci_write_register(pcr, RTS5261_LDO1_CFG0,
+			RTS5261_LDO1_OCP_THD_MASK, option->sd_800mA_ocp_thd);
+
+		rtsx_pci_write_register(pcr, RTS5261_LDO1_CFG0,
+			RTS5261_LDO1_OCP_LMT_THD_MASK,
+			RTS5261_LDO1_LMT_THD_2000);
+
+		mask = SD_OCP_GLITCH_MASK;
+		val = pcr->hw_param.ocp_glitch;
+		rtsx_pci_write_register(pcr, REG_OCPGLITCH, mask, val);
+
+		rts5261_enable_ocp(pcr);
+	} else {
+		rtsx_pci_write_register(pcr, RTS5261_LDO1_CFG0,
+			RTS5261_LDO1_OCP_EN | RTS5261_LDO1_OCP_LMT_EN, 0);
+	}
+}
+
+static void rts5261_clear_ocpstat(struct rtsx_pcr *pcr)
+{
+	u8 mask = 0;
+	u8 val = 0;
+
+	mask = SD_OCP_INT_CLR | SD_OC_CLR;
+	val = SD_OCP_INT_CLR | SD_OC_CLR;
+
+	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, val);
+
+	udelay(10);
+	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, 0);
+
+}
+
+static void rts5261_process_ocp(struct rtsx_pcr *pcr)
+{
+	if (!pcr->option.ocp_en)
+		return;
+
+	rtsx_pci_get_ocpstat(pcr, &pcr->ocp_stat);
+
+	if (pcr->ocp_stat & (SD_OC_NOW | SD_OC_EVER)) {
+		rts5261_card_power_off(pcr, RTSX_SD_CARD);
+		rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, 0);
+		rts5261_clear_ocpstat(pcr);
+		pcr->ocp_stat = 0;
+	}
+
+}
+
+static int rts5261_init_from_hw(struct rtsx_pcr *pcr)
+{
+	int retval;
+	u32 lval, i;
+	u8 valid, efuse_valid, tmp;
+
+	rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
+		REG_EFUSE_POR | REG_EFUSE_POWER_MASK,
+		REG_EFUSE_POR | REG_EFUSE_POWERON);
+	udelay(1);
+	rtsx_pci_write_register(pcr, RTS5261_EFUSE_ADDR,
+		RTS5261_EFUSE_ADDR_MASK, 0x00);
+	rtsx_pci_write_register(pcr, RTS5261_EFUSE_CTL,
+		RTS5261_EFUSE_ENABLE | RTS5261_EFUSE_MODE_MASK,
+		RTS5261_EFUSE_ENABLE);
+
+	/* Wait transfer end */
+	for (i = 0; i < MAX_RW_REG_CNT; i++) {
+		rtsx_pci_read_register(pcr, RTS5261_EFUSE_CTL, &tmp);
+		if ((tmp & 0x80) == 0)
+			break;
+	}
+	rtsx_pci_read_register(pcr, RTS5261_EFUSE_READ_DATA, &tmp);
+	efuse_valid = ((tmp & 0x0C) >> 2);
+	pcr_dbg(pcr, "Load efuse valid: 0x%x\n", efuse_valid);
+
+	if (efuse_valid == 0) {
+		retval = rtsx_pci_read_config_dword(pcr,
+			PCR_SETTING_REG2, &lval);
+		if (retval != 0)
+			pcr_dbg(pcr, "read 0x814 DW fail\n");
+		pcr_dbg(pcr, "DW from 0x814: 0x%x\n", lval);
+		/* 0x816 */
+		valid = (u8)((lval >> 16) & 0x03);
+		pcr_dbg(pcr, "0x816: %d\n", valid);
+	}
+	rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
+		REG_EFUSE_POR, 0);
+	pcr_dbg(pcr, "Disable efuse por!\n");
+
+	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG2, &lval);
+	lval = lval & 0x00FFFFFF;
+	retval = rtsx_pci_write_config_dword(pcr, PCR_SETTING_REG2, lval);
+	if (retval != 0)
+		pcr_dbg(pcr, "write config fail\n");
+
+	return retval;
+}
+
+static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
+{
+	u32 lval;
+	struct rtsx_cr_option *option = &pcr->option;
+
+	rtsx_pci_read_config_dword(pcr, PCR_ASPM_SETTING_REG1, &lval);
+
+	if (lval & ASPM_L1_1_EN_MASK)
+		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
+	else
+		rtsx_clear_dev_flag(pcr, ASPM_L1_1_EN);
+
+	if (lval & ASPM_L1_2_EN_MASK)
+		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
+	else
+		rtsx_clear_dev_flag(pcr, ASPM_L1_2_EN);
+
+	if (lval & PM_L1_1_EN_MASK)
+		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
+	else
+		rtsx_clear_dev_flag(pcr, PM_L1_1_EN);
+
+	if (lval & PM_L1_2_EN_MASK)
+		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
+	else
+		rtsx_clear_dev_flag(pcr, PM_L1_2_EN);
+
+	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0xFF, 0);
+	if (option->ltr_en) {
+		u16 val;
+
+		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
+		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
+			option->ltr_enabled = true;
+			option->ltr_active = true;
+			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
+		} else {
+			option->ltr_enabled = false;
+		}
+	}
+
+	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
+		option->force_clkreq_0 = false;
+	else
+		option->force_clkreq_0 = true;
+}
+
+static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+
+	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG1,
+			CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
+
+	rts5261_init_from_cfg(pcr);
+	rts5261_init_from_hw(pcr);
+
+	/* power off efuse */
+	rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
+			REG_EFUSE_POWER_MASK, REG_EFUSE_POWEROFF);
+	rtsx_pci_write_register(pcr, L1SUB_CONFIG1,
+			AUX_CLK_ACTIVE_SEL_MASK, MAC_CKSW_DONE);
+	rtsx_pci_write_register(pcr, L1SUB_CONFIG3, 0xFF, 0);
+
+	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG4,
+			RTS5261_AUX_CLK_16M_EN, 0);
+
+	/* Release PRSNT# */
+	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG4,
+			RTS5261_FORCE_PRSNT_LOW, 0);
+	rtsx_pci_write_register(pcr, FUNC_FORCE_CTL,
+			FUNC_FORCE_UPME_XMT_DBG, FUNC_FORCE_UPME_XMT_DBG);
+
+	rtsx_pci_write_register(pcr, PCLK_CTL,
+			PCLK_MODE_SEL, PCLK_MODE_SEL);
+
+	rtsx_pci_write_register(pcr, PM_EVENT_DEBUG, PME_DEBUG_0, PME_DEBUG_0);
+	rtsx_pci_write_register(pcr, PM_CLK_FORCE_CTL, CLK_PM_EN, CLK_PM_EN);
+
+	/* LED shine disabled, set initial shine cycle period */
+	rtsx_pci_write_register(pcr, OLT_LED_CTL, 0x0F, 0x02);
+
+	/* Configure driving */
+	rts5261_fill_driving(pcr, OUTPUT_3V3);
+
+	/*
+	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
+	 * to drive low, and we forcibly request clock.
+	 */
+	if (option->force_clkreq_0)
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
+	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
+	rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
+			FORCE_PM_CONTROL | FORCE_PM_VALUE, FORCE_PM_CONTROL);
+
+	/* Clear Enter RTD3_cold Information*/
+	rtsx_pci_write_register(pcr, RTS5261_FW_CTL,
+		RTS5261_INFORM_RTD3_COLD, 0);
+
+	return 0;
+}
+
+static void rts5261_enable_aspm(struct rtsx_pcr *pcr, bool enable)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+	u8 val = 0;
+
+	if (pcr->aspm_enabled == enable)
+		return;
+
+	if (option->dev_aspm_mode == DEV_ASPM_DYNAMIC) {
+		val = pcr->aspm_en;
+		rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
+					 ASPM_MASK_NEG, val);
+	} else if (option->dev_aspm_mode == DEV_ASPM_BACKDOOR) {
+		u8 mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0;
+
+		val = FORCE_ASPM_CTL0;
+		val |= (pcr->aspm_en & 0x02);
+		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
+		val = pcr->aspm_en;
+		rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
+					 ASPM_MASK_NEG, val);
+	}
+	pcr->aspm_enabled = enable;
+
+}
+
+static void rts5261_disable_aspm(struct rtsx_pcr *pcr, bool enable)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+	u8 val = 0;
+
+	if (pcr->aspm_enabled == enable)
+		return;
+
+	if (option->dev_aspm_mode == DEV_ASPM_DYNAMIC) {
+		val = 0;
+		rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
+					 ASPM_MASK_NEG, val);
+	} else if (option->dev_aspm_mode == DEV_ASPM_BACKDOOR) {
+		u8 mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0;
+
+		val = 0;
+		rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
+					 ASPM_MASK_NEG, val);
+		val = FORCE_ASPM_CTL0;
+		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
+	}
+	rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
+	udelay(10);
+	pcr->aspm_enabled = enable;
+}
+
+static void rts5261_set_aspm(struct rtsx_pcr *pcr, bool enable)
+{
+	if (enable)
+		rts5261_enable_aspm(pcr, true);
+	else
+		rts5261_disable_aspm(pcr, false);
+}
+
+static void rts5261_set_l1off_cfg_sub_d0(struct rtsx_pcr *pcr, int active)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+	int aspm_L1_1, aspm_L1_2;
+	u8 val = 0;
+
+	aspm_L1_1 = rtsx_check_dev_flag(pcr, ASPM_L1_1_EN);
+	aspm_L1_2 = rtsx_check_dev_flag(pcr, ASPM_L1_2_EN);
+
+	if (active) {
+		/* run, latency: 60us */
+		if (aspm_L1_1)
+			val = option->ltr_l1off_snooze_sspwrgate;
+	} else {
+		/* l1off, latency: 300us */
+		if (aspm_L1_2)
+			val = option->ltr_l1off_sspwrgate;
+	}
+
+	rtsx_set_l1off_sub(pcr, val);
+}
+
+static const struct pcr_ops rts5261_pcr_ops = {
+	.fetch_vendor_settings = rtsx5261_fetch_vendor_settings,
+	.turn_on_led = rts5261_turn_on_led,
+	.turn_off_led = rts5261_turn_off_led,
+	.extra_init_hw = rts5261_extra_init_hw,
+	.enable_auto_blink = rts5261_enable_auto_blink,
+	.disable_auto_blink = rts5261_disable_auto_blink,
+	.card_power_on = rts5261_card_power_on,
+	.card_power_off = rts5261_card_power_off,
+	.switch_output_voltage = rts5261_switch_output_voltage,
+	.force_power_down = rts5261_force_power_down,
+	.stop_cmd = rts5261_stop_cmd,
+	.set_aspm = rts5261_set_aspm,
+	.set_l1off_cfg_sub_d0 = rts5261_set_l1off_cfg_sub_d0,
+	.enable_ocp = rts5261_enable_ocp,
+	.disable_ocp = rts5261_disable_ocp,
+	.init_ocp = rts5261_init_ocp,
+	.process_ocp = rts5261_process_ocp,
+	.clear_ocpstat = rts5261_clear_ocpstat,
+};
+
+static inline u8 double_ssc_depth(u8 depth)
+{
+	return ((depth > 1) ? (depth - 1) : depth);
+}
+
+int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
+		u8 ssc_depth, bool initial_mode, bool double_clk, bool vpclk)
+{
+	int err, clk;
+	u8 n, clk_divider, mcu_cnt, div;
+	static const u8 depth[] = {
+		[RTSX_SSC_DEPTH_4M] = RTS5261_SSC_DEPTH_4M,
+		[RTSX_SSC_DEPTH_2M] = RTS5261_SSC_DEPTH_2M,
+		[RTSX_SSC_DEPTH_1M] = RTS5261_SSC_DEPTH_1M,
+		[RTSX_SSC_DEPTH_500K] = RTS5261_SSC_DEPTH_512K,
+	};
+
+	if (initial_mode) {
+		/* We use 250k(around) here, in initial stage */
+		clk_divider = SD_CLK_DIVIDE_128;
+		card_clock = 30000000;
+	} else {
+		clk_divider = SD_CLK_DIVIDE_0;
+	}
+	err = rtsx_pci_write_register(pcr, SD_CFG1,
+			SD_CLK_DIVIDE_MASK, clk_divider);
+	if (err < 0)
+		return err;
+
+	card_clock /= 1000000;
+	pcr_dbg(pcr, "Switch card clock to %dMHz\n", card_clock);
+
+	clk = card_clock;
+	if (!initial_mode && double_clk)
+		clk = card_clock * 2;
+	pcr_dbg(pcr, "Internal SSC clock: %dMHz (cur_clock = %d)\n",
+		clk, pcr->cur_clock);
+
+	if (clk == pcr->cur_clock)
+		return 0;
+
+	if (pcr->ops->conv_clk_and_div_n)
+		n = (u8)pcr->ops->conv_clk_and_div_n(clk, CLK_TO_DIV_N);
+	else
+		n = (u8)(clk - 4);
+	if ((clk <= 4) || (n > 396))
+		return -EINVAL;
+
+	mcu_cnt = (u8)(125/clk + 3);
+	if (mcu_cnt > 15)
+		mcu_cnt = 15;
+
+	div = CLK_DIV_1;
+	while ((n < MIN_DIV_N_PCR - 4) && (div < CLK_DIV_8)) {
+		if (pcr->ops->conv_clk_and_div_n) {
+			int dbl_clk = pcr->ops->conv_clk_and_div_n(n,
+					DIV_N_TO_CLK) * 2;
+			n = (u8)pcr->ops->conv_clk_and_div_n(dbl_clk,
+					CLK_TO_DIV_N);
+		} else {
+			n = (n + 4) * 2 - 4;
+		}
+		div++;
+	}
+
+	n = (n / 2);
+	pcr_dbg(pcr, "n = %d, div = %d\n", n, div);
+
+	ssc_depth = depth[ssc_depth];
+	if (double_clk)
+		ssc_depth = double_ssc_depth(ssc_depth);
+
+	if (ssc_depth) {
+		if (div == CLK_DIV_2) {
+			if (ssc_depth > 1)
+				ssc_depth -= 1;
+			else
+				ssc_depth = RTS5261_SSC_DEPTH_8M;
+		} else if (div == CLK_DIV_4) {
+			if (ssc_depth > 2)
+				ssc_depth -= 2;
+			else
+				ssc_depth = RTS5261_SSC_DEPTH_8M;
+		} else if (div == CLK_DIV_8) {
+			if (ssc_depth > 3)
+				ssc_depth -= 3;
+			else
+				ssc_depth = RTS5261_SSC_DEPTH_8M;
+		}
+	} else {
+		ssc_depth = 0;
+	}
+	pcr_dbg(pcr, "ssc_depth = %d\n", ssc_depth);
+
+	rtsx_pci_init_cmd(pcr);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CLK_CTL,
+				CLK_LOW_FREQ, CLK_LOW_FREQ);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CLK_DIV,
+			0xFF, (div << 4) | mcu_cnt);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL1, SSC_RSTB, 0);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2,
+			SSC_DEPTH_MASK, ssc_depth);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_DIV_N_0, 0xFF, n);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL1, SSC_RSTB, SSC_RSTB);
+	if (vpclk) {
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_VPCLK0_CTL,
+				PHASE_NOT_RESET, 0);
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_VPCLK1_CTL,
+				PHASE_NOT_RESET, 0);
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_VPCLK0_CTL,
+				PHASE_NOT_RESET, PHASE_NOT_RESET);
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_VPCLK1_CTL,
+				PHASE_NOT_RESET, PHASE_NOT_RESET);
+	}
+
+	err = rtsx_pci_send_cmd(pcr, 2000);
+	if (err < 0)
+		return err;
+
+	/* Wait SSC clock stable */
+	udelay(SSC_CLOCK_STABLE_WAIT);
+	err = rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, 0);
+	if (err < 0)
+		return err;
+
+	pcr->cur_clock = clk;
+	return 0;
+
+}
+
+void rts5261_init_params(struct rtsx_pcr *pcr)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+	struct rtsx_hw_param *hw_param = &pcr->hw_param;
+
+	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
+	pcr->num_slots = 1;
+	pcr->ops = &rts5261_pcr_ops;
+
+	pcr->flags = 0;
+	pcr->card_drive_sel = RTSX_CARD_DRIVE_DEFAULT;
+	pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
+	pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
+	pcr->aspm_en = ASPM_L1_EN;
+	pcr->tx_initial_phase = SET_CLOCK_PHASE(20, 27, 16);
+	pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
+
+	pcr->ic_version = rts5261_get_ic_version(pcr);
+	pcr->sd_pull_ctl_enable_tbl = rts5261_sd_pull_ctl_enable_tbl;
+	pcr->sd_pull_ctl_disable_tbl = rts5261_sd_pull_ctl_disable_tbl;
+
+	pcr->reg_pm_ctrl3 = RTS5261_AUTOLOAD_CFG3;
+
+	option->dev_flags = (LTR_L1SS_PWR_GATE_CHECK_CARD_EN
+				| LTR_L1SS_PWR_GATE_EN);
+	option->ltr_en = true;
+
+	/* init latency of active, idle, L1OFF to 60us, 300us, 3ms */
+	option->ltr_active_latency = LTR_ACTIVE_LATENCY_DEF;
+	option->ltr_idle_latency = LTR_IDLE_LATENCY_DEF;
+	option->ltr_l1off_latency = LTR_L1OFF_LATENCY_DEF;
+	option->l1_snooze_delay = L1_SNOOZE_DELAY_DEF;
+	option->ltr_l1off_sspwrgate = 0x7F;
+	option->ltr_l1off_snooze_sspwrgate = 0x78;
+	option->dev_aspm_mode = DEV_ASPM_DYNAMIC;
+
+	option->ocp_en = 1;
+	hw_param->interrupt_en |= SD_OC_INT_EN;
+	hw_param->ocp_glitch =  SD_OCP_GLITCH_800U;
+	option->sd_800mA_ocp_thd =  RTS5261_LDO1_OCP_THD_1040;
+}
diff --git a/drivers/misc/cardreader/rts5261.h b/drivers/misc/cardreader/rts5261.h
new file mode 100644
index 00000000..ebfdd23
--- /dev/null
+++ b/drivers/misc/cardreader/rts5261.h
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Driver for Realtek PCI-Express card reader
+ *
+ * Copyright(c) 2018-2019 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * Author:
+ *   Rui FENG <rui_feng@realsil.com.cn>
+ *   Wei WANG <wei_wang@realsil.com.cn>
+ */
+#ifndef RTS5261_H
+#define RTS5261_H
+
+/*New add*/
+#define rts5261_vendor_setting_valid(reg)	((reg) & 0x010000)
+#define rts5261_reg_to_aspm(reg)		(((reg) >> 28) ^ 0x03)
+#define rts5261_reg_check_reverse_socket(reg)	((reg) & 0x04)
+#define rts5261_reg_to_card_drive_sel(reg)	((((reg) >> 6) & 0x01) << 6)
+#define rts5261_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 22) ^ 0x03)
+#define rts5261_reg_to_sd30_drive_sel_3v3(reg)	(((reg) >> 16) ^ 0x03)
+
+
+#define RTS5261_AUTOLOAD_CFG0		0xFF7B
+#define RTS5261_AUTOLOAD_CFG1		0xFF7C
+#define RTS5261_AUTOLOAD_CFG2		0xFF7D
+#define RTS5261_AUTOLOAD_CFG3		0xFF7E
+#define RTS5261_AUTOLOAD_CFG4		0xFF7F
+#define RTS5261_FORCE_PRSNT_LOW		(1 << 6)
+#define RTS5261_AUX_CLK_16M_EN		(1 << 5)
+
+#define RTS5261_REG_VREF		0xFE97
+#define RTS5261_PWD_SUSPND_EN		(1 << 4)
+
+#define RTS5261_PAD_H3L1		0xFF79
+#define PAD_GPIO_H3L1			(1 << 3)
+
+/* SSC_CTL2 0xFC12 */
+#define RTS5261_SSC_DEPTH_MASK		0x07
+#define RTS5261_SSC_DEPTH_DISALBE	0x00
+#define RTS5261_SSC_DEPTH_8M		0x01
+#define RTS5261_SSC_DEPTH_4M		0x02
+#define RTS5261_SSC_DEPTH_2M		0x03
+#define RTS5261_SSC_DEPTH_1M		0x04
+#define RTS5261_SSC_DEPTH_512K		0x05
+#define RTS5261_SSC_DEPTH_256K		0x06
+#define RTS5261_SSC_DEPTH_128K		0x07
+
+/* efuse control register*/
+#define RTS5261_EFUSE_CTL		0xFC30
+#define RTS5261_EFUSE_ENABLE		0x80
+/* EFUSE_MODE: 0=READ 1=PROGRAM */
+#define RTS5261_EFUSE_MODE_MASK		0x40
+#define RTS5261_EFUSE_PROGRAM		0x40
+
+#define RTS5261_EFUSE_ADDR		0xFC31
+#define	RTS5261_EFUSE_ADDR_MASK		0x3F
+
+#define RTS5261_EFUSE_WRITE_DATA	0xFC32
+#define RTS5261_EFUSE_READ_DATA		0xFC34
+
+/* DMACTL 0xFE2C */
+#define RTS5261_DMA_PACK_SIZE_MASK	0xF0
+
+/* FW config info register */
+#define RTS5261_FW_CFG_INFO0		0xFF50
+#define RTS5261_FW_EXPRESS_TEST_MASK	(0x01<<0)
+#define RTS5261_FW_EA_MODE_MASK		(0x01<<5)
+
+/* FW config register */
+#define RTS5261_FW_CFG0			0xFF54
+#define RTS5261_FW_ENTER_EXPRESS	(0x01<<0)
+
+#define RTS5261_FW_CFG1			0xFF55
+#define RTS5261_SYS_CLK_SEL_MCU_CLK	(0x01<<7)
+#define RTS5261_CRC_CLK_SEL_MCU_CLK	(0x01<<6)
+#define RTS5261_FAKE_MCU_CLOCK_GATING	(0x01<<5)
+/*MCU_bus_mode_sel: 0=real 8051 1=fake mcu*/
+#define RTS5261_MCU_BUS_SEL_MASK	(0x01<<4)
+/*MCU_clock_sel:VerA 00=aux16M 01=aux400K 1x=REFCLK100M*/
+/*MCU_clock_sel:VerB 00=aux400K 01=aux16M 10=REFCLK100M*/
+#define RTS5261_MCU_CLOCK_SEL_MASK	(0x03<<2)
+#define RTS5261_MCU_CLOCK_SEL_16M	(0x01<<2)
+#define RTS5261_MCU_CLOCK_GATING	(0x01<<1)
+#define RTS5261_DRIVER_ENABLE_FW	(0x01<<0)
+
+/* FW status register */
+#define RTS5261_FW_STATUS		0xFF56
+#define RTS5261_EXPRESS_LINK_FAIL_MASK	(0x01<<7)
+
+/* FW control register */
+#define RTS5261_FW_CTL			0xFF5F
+#define RTS5261_INFORM_RTD3_COLD	(0x01<<5)
+
+#define RTS5261_REG_FPDCTL		0xFF60
+
+#define RTS5261_REG_LDO12_CFG		0xFF6E
+#define RTS5261_LDO12_VO_TUNE_MASK	(0x07<<1)
+#define RTS5261_LDO12_115		(0x03<<1)
+#define RTS5261_LDO12_120		(0x04<<1)
+#define RTS5261_LDO12_125		(0x05<<1)
+#define RTS5261_LDO12_130		(0x06<<1)
+#define RTS5261_LDO12_135		(0x07<<1)
+
+/* LDO control register */
+#define RTS5261_CARD_PWR_CTL		0xFD50
+#define RTS5261_SD_CLK_ISO		(0x01<<7)
+#define RTS5261_PAD_SD_DAT_FW_CTRL	(0x01<<6)
+#define RTS5261_PUPDC			(0x01<<5)
+#define RTS5261_SD_CMD_ISO		(0x01<<4)
+#define RTS5261_SD_DAT_ISO_MASK		(0x0F<<0)
+
+#define RTS5261_LDO1233318_POW_CTL	0xFF70
+#define RTS5261_LDO3318_POWERON		(0x01<<3)
+#define RTS5261_LDO3_POWERON		(0x01<<2)
+#define RTS5261_LDO2_POWERON		(0x01<<1)
+#define RTS5261_LDO1_POWERON		(0x01<<0)
+#define RTS5261_LDO_POWERON_MASK	(0x0F<<0)
+
+#define RTS5261_DV3318_CFG		0xFF71
+#define RTS5261_DV3318_TUNE_MASK	(0x07<<4)
+#define RTS5261_DV3318_18		(0x02<<4)
+#define RTS5261_DV3318_19		(0x04<<4)
+#define RTS5261_DV3318_33		(0x07<<4)
+
+#define RTS5261_LDO1_CFG0		0xFF72
+#define RTS5261_LDO1_OCP_THD_MASK	(0x07<<5)
+#define RTS5261_LDO1_OCP_EN		(0x01<<4)
+#define RTS5261_LDO1_OCP_LMT_THD_MASK	(0x03<<2)
+#define RTS5261_LDO1_OCP_LMT_EN		(0x01<<1)
+
+/* CRD6603-433 190319 request changed */
+#define RTS5261_LDO1_OCP_THD_740	(0x00<<5)
+#define RTS5261_LDO1_OCP_THD_800	(0x01<<5)
+#define RTS5261_LDO1_OCP_THD_860	(0x02<<5)
+#define RTS5261_LDO1_OCP_THD_920	(0x03<<5)
+#define RTS5261_LDO1_OCP_THD_980	(0x04<<5)
+#define RTS5261_LDO1_OCP_THD_1040	(0x05<<5)
+#define RTS5261_LDO1_OCP_THD_1100	(0x06<<5)
+#define RTS5261_LDO1_OCP_THD_1160	(0x07<<5)
+
+#define RTS5261_LDO1_LMT_THD_450	(0x00<<2)
+#define RTS5261_LDO1_LMT_THD_1000	(0x01<<2)
+#define RTS5261_LDO1_LMT_THD_1500	(0x02<<2)
+#define RTS5261_LDO1_LMT_THD_2000	(0x03<<2)
+
+#define RTS5261_LDO1_CFG1		0xFF73
+#define RTS5261_LDO1_TUNE_MASK		(0x07<<1)
+#define RTS5261_LDO1_18			(0x05<<1)
+#define RTS5261_LDO1_33			(0x07<<1)
+#define RTS5261_LDO1_PWD_MASK		(0x01<<0)
+
+#define RTS5261_LDO2_CFG0		0xFF74
+#define RTS5261_LDO2_OCP_THD_MASK	(0x07<<5)
+#define RTS5261_LDO2_OCP_EN		(0x01<<4)
+#define RTS5261_LDO2_OCP_LMT_THD_MASK	(0x03<<2)
+#define RTS5261_LDO2_OCP_LMT_EN		(0x01<<1)
+
+#define RTS5261_LDO2_OCP_THD_620	(0x00<<5)
+#define RTS5261_LDO2_OCP_THD_650	(0x01<<5)
+#define RTS5261_LDO2_OCP_THD_680	(0x02<<5)
+#define RTS5261_LDO2_OCP_THD_720	(0x03<<5)
+#define RTS5261_LDO2_OCP_THD_750	(0x04<<5)
+#define RTS5261_LDO2_OCP_THD_780	(0x05<<5)
+#define RTS5261_LDO2_OCP_THD_810	(0x06<<5)
+#define RTS5261_LDO2_OCP_THD_840	(0x07<<5)
+
+#define RTS5261_LDO2_CFG1		0xFF75
+#define RTS5261_LDO2_TUNE_MASK		(0x07<<1)
+#define RTS5261_LDO2_18			(0x05<<1)
+#define RTS5261_LDO2_33			(0x07<<1)
+#define RTS5261_LDO2_PWD_MASK		(0x01<<0)
+
+#define RTS5261_LDO3_CFG0		0xFF76
+#define RTS5261_LDO3_OCP_THD_MASK	(0x07<<5)
+#define RTS5261_LDO3_OCP_EN		(0x01<<4)
+#define RTS5261_LDO3_OCP_LMT_THD_MASK	(0x03<<2)
+#define RTS5261_LDO3_OCP_LMT_EN		(0x01<<1)
+
+#define RTS5261_LDO3_OCP_THD_620	(0x00<<5)
+#define RTS5261_LDO3_OCP_THD_650	(0x01<<5)
+#define RTS5261_LDO3_OCP_THD_680	(0x02<<5)
+#define RTS5261_LDO3_OCP_THD_720	(0x03<<5)
+#define RTS5261_LDO3_OCP_THD_750	(0x04<<5)
+#define RTS5261_LDO3_OCP_THD_780	(0x05<<5)
+#define RTS5261_LDO3_OCP_THD_810	(0x06<<5)
+#define RTS5261_LDO3_OCP_THD_840	(0x07<<5)
+
+#define RTS5261_LDO3_CFG1		0xFF77
+#define RTS5261_LDO3_TUNE_MASK		(0x07<<1)
+#define RTS5261_LDO3_18			(0x05<<1)
+#define RTS5261_LDO3_33			(0x07<<1)
+#define RTS5261_LDO3_PWD_MASK		(0x01<<0)
+
+#define RTS5261_REG_PME_FORCE_CTL	0xFF78
+#define FORCE_PM_CONTROL		0x20
+#define FORCE_PM_VALUE			0x10
+#define REG_EFUSE_BYPASS		0x08
+#define REG_EFUSE_POR			0x04
+#define REG_EFUSE_POWER_MASK		0x03
+#define REG_EFUSE_POWERON		0x03
+#define REG_EFUSE_POWEROFF		0x00
+
+
+/* Single LUN, support SD/SD EXPRESS */
+#define DEFAULT_SINGLE		0
+#define SD_LUN			1
+#define SD_EXPRESS_LUN		2
+
+/* For Change_FPGA_SSCClock Function */
+#define MULTIPLY_BY_1    0x00
+#define MULTIPLY_BY_2    0x01
+#define MULTIPLY_BY_3    0x02
+#define MULTIPLY_BY_4    0x03
+#define MULTIPLY_BY_5    0x04
+#define MULTIPLY_BY_6    0x05
+#define MULTIPLY_BY_7    0x06
+#define MULTIPLY_BY_8    0x07
+#define MULTIPLY_BY_9    0x08
+#define MULTIPLY_BY_10   0x09
+
+#define DIVIDE_BY_2      0x01
+#define DIVIDE_BY_3      0x02
+#define DIVIDE_BY_4      0x03
+#define DIVIDE_BY_5      0x04
+#define DIVIDE_BY_6      0x05
+#define DIVIDE_BY_7      0x06
+#define DIVIDE_BY_8      0x07
+#define DIVIDE_BY_9      0x08
+#define DIVIDE_BY_10     0x09
+
+int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
+		u8 ssc_depth, bool initial_mode, bool double_clk, bool vpclk);
+
+#endif /* RTS5261_H */
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index b4a66b6..fd7b216 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -22,6 +22,7 @@
 #include <asm/unaligned.h>
 
 #include "rtsx_pcr.h"
+#include "rts5261.h"
 
 static bool msi_en = true;
 module_param(msi_en, bool, S_IRUGO | S_IWUSR);
@@ -34,9 +35,6 @@
 	[RTSX_SD_CARD] = {
 		.name = DRV_NAME_RTSX_PCI_SDMMC,
 	},
-	[RTSX_MS_CARD] = {
-		.name = DRV_NAME_RTSX_PCI_MS,
-	},
 };
 
 static const struct pci_device_id rtsx_pci_ids[] = {
@@ -51,6 +49,7 @@
 	{ PCI_DEVICE(0x10EC, 0x524A), PCI_CLASS_OTHERS << 16, 0xFF0000 },
 	{ PCI_DEVICE(0x10EC, 0x525A), PCI_CLASS_OTHERS << 16, 0xFF0000 },
 	{ PCI_DEVICE(0x10EC, 0x5260), PCI_CLASS_OTHERS << 16, 0xFF0000 },
+	{ PCI_DEVICE(0x10EC, 0x5261), PCI_CLASS_OTHERS << 16, 0xFF0000 },
 	{ 0, }
 };
 
@@ -438,8 +437,16 @@ static void rtsx_pci_add_sg_tbl(struct rtsx_pcr *pcr,
 
 	if (end)
 		option |= RTSX_SG_END;
-	val = ((u64)addr << 32) | ((u64)len << 12) | option;
 
+	if (PCI_PID(pcr) == PID_5261) {
+		if (len > 0xFFFF)
+			val = ((u64)addr << 32) | (((u64)len & 0xFFFF) << 16)
+				| (((u64)len >> 16) << 6) | option;
+		else
+			val = ((u64)addr << 32) | ((u64)len << 16) | option;
+	} else {
+		val = ((u64)addr << 32) | ((u64)len << 12) | option;
+	}
 	put_unaligned_le64(val, ptr);
 	pcr->sgi++;
 }
@@ -684,7 +691,6 @@ int rtsx_pci_card_pull_ctl_disable(struct rtsx_pcr *pcr, int card)
 	else
 		return -EINVAL;
 
-
 	return rtsx_pci_set_pull_ctl(pcr, tbl);
 }
 EXPORT_SYMBOL_GPL(rtsx_pci_card_pull_ctl_disable);
@@ -735,6 +741,10 @@ int rtsx_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 		[RTSX_SSC_DEPTH_250K] = SSC_DEPTH_250K,
 	};
 
+	if (PCI_PID(pcr) == PID_5261)
+		return rts5261_pci_switch_clock(pcr, card_clock,
+				ssc_depth, initial_mode, double_clk, vpclk);
+
 	if (initial_mode) {
 		/* We use 250k(around) here, in initial stage */
 		clk_divider = SD_CLK_DIVIDE_128;
@@ -1253,7 +1263,15 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	rtsx_pci_enable_bus_int(pcr);
 
 	/* Power on SSC */
-	err = rtsx_pci_write_register(pcr, FPDCTL, SSC_POWER_DOWN, 0);
+	if (PCI_PID(pcr) == PID_5261) {
+		/* Gating real mcu clock */
+		err = rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
+			RTS5261_MCU_CLOCK_GATING, 0);
+		err = rtsx_pci_write_register(pcr, RTS5261_REG_FPDCTL,
+			SSC_POWER_DOWN, 0);
+	} else {
+		err = rtsx_pci_write_register(pcr, FPDCTL, SSC_POWER_DOWN, 0);
+	}
 	if (err < 0)
 		return err;
 
@@ -1283,7 +1301,12 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	/* Enable SSC Clock */
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL1,
 			0xFF, SSC_8X_EN | SSC_SEL_4M);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2, 0xFF, 0x12);
+	if (PCI_PID(pcr) == PID_5261)
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2, 0xFF,
+			RTS5261_SSC_DEPTH_2M);
+	else
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2, 0xFF, 0x12);
+
 	/* Disable cd_pwr_save */
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CHANGE_LINK_STATE, 0x16, 0x10);
 	/* Clear Link Ready Interrupt */
@@ -1314,6 +1337,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	case PID_524A:
 	case PID_525A:
 	case PID_5260:
+	case PID_5261:
 		rtsx_pci_write_register(pcr, PM_CLK_FORCE_CTL, 1, 1);
 		break;
 	default:
@@ -1393,9 +1417,14 @@ static int rtsx_pci_init_chip(struct rtsx_pcr *pcr)
 	case 0x5286:
 		rtl8402_init_params(pcr);
 		break;
+
 	case 0x5260:
 		rts5260_init_params(pcr);
 		break;
+
+	case 0x5261:
+		rts5261_init_params(pcr);
+		break;
 	}
 
 	pcr_dbg(pcr, "PID: 0x%04x, IC version: 0x%02x\n",
diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
index 98f7292..ed391df 100644
--- a/drivers/misc/cardreader/rtsx_pcr.h
+++ b/drivers/misc/cardreader/rtsx_pcr.h
@@ -53,6 +53,7 @@
 void rts525a_init_params(struct rtsx_pcr *pcr);
 void rtl8411b_init_params(struct rtsx_pcr *pcr);
 void rts5260_init_params(struct rtsx_pcr *pcr);
+void rts5261_init_params(struct rtsx_pcr *pcr);
 
 static inline u8 map_sd_drive(int idx)
 {
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index f87da30..65b8142 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1262,6 +1262,7 @@ struct rtsx_pcr {
 #define PID_5250	0x5250
 #define PID_525A	0x525A
 #define PID_5260	0x5260
+#define PID_5261	0x5261
 
 #define CHK_PCI_PID(pcr, pid)		((pcr)->pci->device == (pid))
 #define PCI_VID(pcr)			((pcr)->pci->vendor)
-- 
1.9.1

