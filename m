Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F746C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DCD2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbfHFHRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:17:25 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:54472 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbfHFHRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:17:25 -0400
Received: from ramsan ([84.194.98.4])
        by andre.telenet-ops.be with bizsmtp
        id ljHB2000F05gfCL01jHB5D; Tue, 06 Aug 2019 09:17:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hutiZ-00022N-56
        for linux-kernel@vger.kernel.org; Tue, 06 Aug 2019 09:17:11 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hutiZ-0003D2-3c
        for linux-kernel@vger.kernel.org; Tue, 06 Aug 2019 09:17:11 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.3-rc3
Date:   Tue,  6 Aug 2019 09:17:11 +0200
Message-Id: <20190806071711.12294-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.3-rc3[1] compared to v5.2[2].

Summarized:
  - build errors: +9/-1
  - build warnings: +133/-170

JFYI, when comparing v5.3-rc3[1] to v5.3-rc2[3], the summaries are:
  - build errors: +0/-1
  - build warnings: +59/-99

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e21a712a9685488f5ce80495b37b9fdbe96c230d/ (all 242 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0ecfebd2b52404ae0c54a878c872bb93363ada36/ (all 242 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/609488bc979f99f805f34e9a32c1e3b71179d10b/ (241 out of 242 configs)


*** ERRORS ***

9 error regressions:
  + /kisskb/src/drivers/misc/lkdtm/bugs.c: error: 'X86_CR4_SMEP' undeclared (first use in this function):  => 281:13
  + /kisskb/src/drivers/misc/lkdtm/bugs.c: error: implicit declaration of function 'native_read_cr4' [-Werror=implicit-function-declaration]:  => 279:8
  + /kisskb/src/drivers/misc/lkdtm/bugs.c: error: implicit declaration of function 'native_write_cr4' [-Werror=implicit-function-declaration]:  => 288:2
  + /kisskb/src/drivers/net/wireless/intel/iwlwifi/fw/dbg.c: error: call to '__compiletime_assert_2446' declared with attribute error: BUILD_BUG_ON failed: err_str[sizeof(err_str) - 2] != '\n':  => 2445:3
  + /kisskb/src/drivers/net/wireless/intel/iwlwifi/fw/dbg.c: error: call to '__compiletime_assert_2452' declared with attribute error: BUILD_BUG_ON failed: err_str[sizeof(err_str) - 2] != '\n':  => 2451:3
  + /kisskb/src/drivers/net/wireless/intel/iwlwifi/fw/dbg.c: error: call to '__compiletime_assert_2790' declared with attribute error: BUILD_BUG_ON failed: invalid_ap_str[sizeof(invalid_ap_str) - 2] != '\n':  => 2789:5
  + /kisskb/src/drivers/net/wireless/intel/iwlwifi/fw/dbg.c: error: call to '__compiletime_assert_2801' declared with attribute error: BUILD_BUG_ON failed: invalid_ap_str[sizeof(invalid_ap_str) - 2] != '\n':  => 2800:5
  + /kisskb/src/mm/hmm.c: error: implicit declaration of function 'pud_pfn' [-Werror=implicit-function-declaration]:  => 753:9, 753:3
  + /kisskb/src/mm/hmm.c: error: implicit declaration of function 'pud_pfn'; did you mean 'pte_pfn'? [-Werror=implicit-function-declaration]:  => 753:9

1 error improvements:
  - error: arch/sh/kernel/cpu/sh2/clock-sh7619.o: undefined reference to `followparent_recalc': .data+0x70) => 


*** WARNINGS ***

133 warning regressions:
  + /kisskb/src/arch/arm64/include/asm/kvm_hyp.h: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 31:3
  + /kisskb/src/arch/arm64/include/asm/sysreg.h: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 837:2
  + /kisskb/src/arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 363:24, 353:24, 396:3, 386:3, 351:24, 384:3, 361:24, 394:3
  + /kisskb/src/arch/arm64/kvm/hyp/debug-sr.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 26:18, 34:18, 29:18, 25:19, 23:19, 33:18, 32:18, 27:18, 21:19, 20:19, 22:19, 24:19, 28:18, 31:18, 30:18
  + /kisskb/src/arch/mips/oprofile/op_model_mipsxx.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 299:3, 201:3, 199:3, 177:3, 221:3, 197:3, 219:3, 174:3, 302:3, 217:3, 242:6, 305:3, 180:3
  + /kisskb/src/arch/nds32/kernel/signal.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 362:20, 315:7
  + /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.28' uses dynamic stack allocation [enabled by default]:  => 403:1
  + /kisskb/src/drivers/crypto/talitos.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 3142:4
  + /kisskb/src/drivers/dma-buf/dma-buf.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]:  => 402:26
  + /kisskb/src/drivers/dma/fsldma.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1165:26
  + /kisskb/src/drivers/dma/imx-dma.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 542:6
  + /kisskb/src/drivers/dma/tegra210-adma.c: warning: 'tegra_adma_runtime_resume' defined but not used [-Wunused-function]:  => 747:12
  + /kisskb/src/drivers/dma/tegra210-adma.c: warning: 'tegra_adma_runtime_suspend' defined but not used [-Wunused-function]:  => 715:12
  + /kisskb/src/drivers/gpu/drm/arm/malidp_hw.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1311:4, 387:8
  + /kisskb/src/drivers/gpu/drm/sun4i/sun4i_tcon.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 316:7
  + /kisskb/src/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 992:6
  + /kisskb/src/drivers/iommu/arm-smmu-v3.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1189:7
  + /kisskb/src/drivers/md/raid10.c: warning: 'best_pending_slot' may be used uninitialized in this function [-Wuninitialized]:  => 840:22
  + /kisskb/src/drivers/mfd/rk808.c: warning: 'rk8xx_resume' defined but not used [-Wunused-function]:  => 752:12
  + /kisskb/src/drivers/mfd/rk808.c: warning: 'rk8xx_suspend' defined but not used [-Wunused-function]:  => 732:12
  + /kisskb/src/drivers/net/arcnet/arc-rimi.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 369:7, 367:8
  + /kisskb/src/drivers/net/arcnet/com90io.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 367:7
  + /kisskb/src/drivers/net/arcnet/com90xx.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 697:9, 699:7
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1288 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 127:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 127:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1312 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 127:1
  + /kisskb/src/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 1015:12
  + /kisskb/src/drivers/net/ethernet/toshiba/spider_net.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 783:7
  + /kisskb/src/drivers/net/hamradio/baycom_epp.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 491:7
  + /kisskb/src/drivers/net/wan/sdla.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 414:7
  + /kisskb/src/drivers/pinctrl/pinctrl-rockchip.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 2783:3
  + /kisskb/src/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 815:20, 820:20
  + /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 280:15
  + /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg.clk_ps' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 82:20
  + /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg.mod_period' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 84:24, 278:3
  + /kisskb/src/drivers/s390/net/ctcm_fsms.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1703:6
  + /kisskb/src/drivers/s390/net/ctcm_mpc.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 358:6, 1469:6, 2087:6
  + /kisskb/src/drivers/s390/net/qeth_l2_main.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 328:7
  + /kisskb/src/drivers/scsi/cxlflash/main.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 757:3, 3018:6, 975:3, 754:6, 759:3, 978:3, 2347:6, 983:3, 980:3
  + /kisskb/src/drivers/scsi/ibmvscsi/ibmvfc.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 4022:3, 1830:11, 1838:11
  + /kisskb/src/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1582:6, 2496:16, 2494:16
  + /kisskb/src/drivers/scsi/ncr53c8xx.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 3908:7, 3917:18, 3914:7, 6713:6
  + /kisskb/src/drivers/scsi/wd33c93.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1856:11
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.34' uses dynamic stack allocation [enabled by default]:  => 498:1
  + /kisskb/src/drivers/usb/core/devio.c: warning: 'errno' may be used uninitialized in this function [-Wuninitialized]:  => 613:23
  + /kisskb/src/drivers/video/fbdev/sh_mobile_lcdcfb.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 2086:22, 1596:22
  + /kisskb/src/drivers/watchdog/ar7_wdt.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 237:3
  + /kisskb/src/drivers/watchdog/pcwd.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 653:3
  + /kisskb/src/drivers/watchdog/sb_wdog.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 204:3
  + /kisskb/src/drivers/watchdog/wdt.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 391:3
  + /kisskb/src/fs/ubifs/debug.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'ino_t' {aka 'unsigned int'} [-Wformat=]:  => 158:11
  + /kisskb/src/fs/ubifs/orphan.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'ino_t' [-Wformat]:  => 133:3, 142:3
  + /kisskb/src/include/asm-generic/bitops/non-atomic.h: warning: 'cpu' may be used uninitialized in this function [-Wuninitialized]:  => 106:21
  + /kisskb/src/include/linux/device.h: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1501:2
  + /kisskb/src/include/linux/printk.h: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 311:2, 309:2, 304:2
  + /kisskb/src/include/linux/regmap.h: warning: 'periodcfg.clk_ps' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 75:2
  + /kisskb/src/include/linux/via-core.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 192:2, 206:2, 198:2
  + /kisskb/src/include/math-emu/op-common.h: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 310:11, 417:11, 320:11, 430:11
  + /kisskb/src/include/math-emu/soft-fp.h: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 124:8
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1640>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U28c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U36e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3960>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4140>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34, 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U53c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U60a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6640>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U68c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U75a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U78c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U85a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U88c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9140>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9500>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U98c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua140>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uab40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uac80>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub280>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubbe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucaa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucd20>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udbe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uef00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf000>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf280>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34, 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufa00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/sched/core.c: warning: 'cpu' may be used uninitialized in this function [-Wuninitialized]:  => 2529:12
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.52' uses dynamic stack allocation [enabled by default]:  => 2193:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.54' uses dynamic stack allocation [enabled by default]:  => 1900:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.53' uses dynamic stack allocation [enabled by default]:  => 2261:1
  + /kisskb/src/net/iucv/af_iucv.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 2246:6, 519:6, 537:3, 510:6
  + /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1512 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 2905:1
  + /kisskb/src/sound/aoa/codecs/onyx.c: warning: 'c' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 377:37
  + <stdin>: warning: #warning syscall clone3 not implemented [-Wcpp]:  => 1511:2
  + warning: unmet direct dependencies detected for MTD_COMPLEX_MAPPINGS:  => N/A
  + warning: vmlinux.o(.text+0x2e0c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x2fd0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x31f4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x31fc): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3204): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x33d0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x3794): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x39d0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A

170 warning improvements:
  - /kisskb/src/arch/arm/mm/init.c: warning: unused variable 'dtcm_end' [-Wunused-variable]: 452:13 => 
  - /kisskb/src/arch/arm/mm/init.c: warning: unused variable 'itcm_end' [-Wunused-variable]: 453:13 => 
  - /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation [enabled by default]: 182:1 => 
  - /kisskb/src/arch/s390/kernel/machine_kexec.c: warning: 'do_start_kdump' defined but not used [-Wunused-function]: 146:22 => 
  - /kisskb/src/arch/sh/kernel/cpu/clock.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 22:6 => 
  - /kisskb/src/arch/xtensa/kernel/pci.c: warning: 'pci_ctrl_tail' defined but not used [-Wunused-variable]: 40:32 => 
  - /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.27' uses dynamic stack allocation [enabled by default]: 403:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 685:6 => 
  - /kisskb/src/drivers/hwtracing/intel_th/msu.c: warning: unused variable 'i' [-Wunused-variable]: 863:6, 783:21 => 
  - /kisskb/src/drivers/lightnvm/core.c: warning: 't' may be used uninitialized in this function [-Wuninitialized]: 496:5 => 
  - /kisskb/src/drivers/mfd/htc-pasic3.c: warning: unused variable 'asic' [-Wunused-variable]: 186:22 => 
  - /kisskb/src/drivers/net/arcnet/arc-rimi.c: warning: unused variable 'lp' [-Wunused-variable]: 346:23 => 
  - /kisskb/src/drivers/net/can/cc770/cc770_platform.c: warning: unused variable 'priv' [-Wunused-variable]: 236:21 => 
  - /kisskb/src/drivers/net/ethernet/8390/ax88796.c: warning: unused variable 'ei_local' [-Wunused-variable]: 808:20 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq" redefined [enabled by default]: 1670:0 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq" redefined: 1670, 1670:0 => 1679
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq_relaxed" redefined [enabled by default]: 1678:0 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq_relaxed" redefined: 1678, 1678:0 => 1687
  - /kisskb/src/drivers/net/ethernet/freescale/fsl_pq_mdio.c: warning: unused variable 'priv' [-Wunused-variable]: 518:27 => 
  - /kisskb/src/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 1041:16 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc911x.c: warning: unused variable 'lp' [-Wunused-variable]: 2116:24 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc91c92_cs.c: warning: unused variable 'smc' [-Wunused-variable]: 958:23 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation [enabled by default]: 315:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation [enabled by default]: 329:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_dev_init' uses dynamic stack allocation [enabled by default]: 491:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation [enabled by default]: 214:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation [enabled by default]: 280:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation [enabled by default]: 357:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation [enabled by default]: 301:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation [enabled by default]: 83:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'register_ieq' uses dynamic stack allocation [enabled by default]: 139:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'register_sba' uses dynamic stack allocation [enabled by default]: 110:1 => 
  - /kisskb/src/drivers/s390/scsi/zfcp_erp.c: warning: 'erp_action' may be used uninitialized in this function [-Wuninitialized]: 262:2 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc2000/core.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat=]: 149:36 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc2000/core.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat]: 149:9 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 75:1 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 75:1 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 75:1 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t {aka unsigned int}' [-Wformat=]: 58:35 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t' [-Wformat]: 58:2 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]: 58:35 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.32' uses dynamic stack allocation [enabled by default]: 498:1 => 
  - /kisskb/src/drivers/thermal/broadcom/ns-thermal.c: warning: unused variable 'ns_thermal' [-Wunused-variable]: 78:21 => 
  - /kisskb/src/fs/btrfs/props.c: warning: 'num_bytes' may be used uninitialized in this function [-Wmaybe-uninitialized]: 389:4 => 
  - /kisskb/src/kernel/locking/lockdep.c: warning: 'print_lock_trace' defined but not used [-Wunused-function]: 2821:13 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U   0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 640>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 8c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U13c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1aa0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2320>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U30a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U45a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U48c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5320>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5f00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6000>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6500>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U65a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7280>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U81e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U83c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9000>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U90a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9320>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U96e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9e60>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua0a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua1e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uae60>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaf00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub1e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub5a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 121:34
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubaa0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubc80>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubf00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc0a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc3c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucbe0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uce60>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud140>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue140>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue280>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue5a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufe60>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rseq.c: warning: 'rseq_ip_fixup' uses dynamic stack allocation [enabled by default]: 249:1 => 
  - /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation [enabled by default]: 300:1 => 
  - /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation [enabled by default]: 308:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_all' uses dynamic stack allocation [enabled by default]: 269:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_partial.isra.29' uses dynamic stack allocation [enabled by default]: 268:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_none.isra.63' uses dynamic stack allocation [enabled by default]: 275:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_all.isra.49' uses dynamic stack allocation [enabled by default]: 272:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_partial.isra.41' uses dynamic stack allocation [enabled by default]: 271:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_all' uses dynamic stack allocation [enabled by default]: 266:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_partial.isra.17' uses dynamic stack allocation [enabled by default]: 265:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_zero.isra.9' uses dynamic stack allocation [enabled by default]: 263:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_all' uses dynamic stack allocation [enabled by default]: 269:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_partial' uses dynamic stack allocation [enabled by default]: 268:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_none' uses dynamic stack allocation [enabled by default]: 275:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_all' uses dynamic stack allocation [enabled by default]: 272:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_partial' uses dynamic stack allocation [enabled by default]: 271:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_all' uses dynamic stack allocation [enabled by default]: 266:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_partial' uses dynamic stack allocation [enabled by default]: 265:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_zero' uses dynamic stack allocation [enabled by default]: 263:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.47' uses dynamic stack allocation [enabled by default]: 2177:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.49' uses dynamic stack allocation [enabled by default]: 1884:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.48' uses dynamic stack allocation [enabled by default]: 2245:1 => 
  - /kisskb/src/net/bridge/br_device.c: warning: 'br_get_stats64' uses dynamic stack allocation [enabled by default]: 228:1 => 
  - /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation [enabled by default]: 1846:1 => 
  - /kisskb/src/net/core/devlink.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 4321:6, 4390:6 => 4443:6
  - /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1504 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 2905:1 => 
  - /kisskb/src/net/sunrpc/stats.c: warning: 'rpc_clnt_show_stats' uses dynamic stack allocation [enabled by default]: 269:1 => 
  - warning: "copy_page" [fs/nfs/nfs.ko] has no CRC!: N/A => 
  - warning: 140 bad relocations: N/A => 
  - warning: 141 bad relocations: N/A => 
  - warning: You need at least binutils >= 2.19 to build a CONFIG_RELOCATABLE kernel: N/A => 
  - warning: arch/powerpc/oprofile/oprofile.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.: N/A => 
  - warning: vmlinux.o(.text+0x2f2a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x2f3c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x302a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x30ba): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3128): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x312a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3164): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x322a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3263c): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x340c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3474): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3484): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x352a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3628): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x362a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3664): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x3734): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3770): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x377e4): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x3a14): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3c34): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3c70): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x3dc6): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x40e): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x42c6): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x51a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x5f878): Section mismatch in reference from the function .fsl_add_bridge() to the function .init.text:.setup_pci_cmd(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x24c04): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x36cc): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x36e4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x38cc): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3914): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3928): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3b58): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0xe724): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
