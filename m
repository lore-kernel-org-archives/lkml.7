Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5C3C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733C92190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfGVROZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:14:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37344 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfGVROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:14:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id y26so39234617qto.4;
        Mon, 22 Jul 2019 10:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfk0LREwSHM5wSy0FvxzAAZdvoHS9YoQ4zJn+jGB5QI=;
        b=o5SU8O672TsEZE62lg0ZmefOc/rNu50/QcE+ieV6JQ6AwIB2sCn6/H2uwjdooQjacq
         uHpi3jcJx9UM7Ar6q76SMUdTqwpXM7CVvLxH1AgBqshN80G2wdcTCLdqei14JBXG0fQY
         X5UC5xyYhyXRAi6mYvWUfT73wkfWmtoOtAjEDlQJ5ZLsA0imedWZt/20i+bahDQn9XBn
         SbA/obHsnD18667iRNj4Garle+G6V54H21dEOU4PlRY00psNuiijWP626dlpjZ+Gknx4
         VHnZTlq+nwRIkHVVoIOzMOE8zd538ffG4huRBS0/a6EzQnrbJgLEoZ6ixeZPDLHgCMTK
         P7WA==
X-Gm-Message-State: APjAAAWOe4icYERn6+tiEY6W1NYeuVbMocDQFfNZDtAmp9HrVQGJGf/c
        NxYNK92S2xjNpzLasDMnvTT1nR9B2rB1bq+ATBE=
X-Google-Smtp-Source: APXvYqyhILUiQb5GQw7tyNfL9ym7mi8SPpiUwPjMq1DJ27km1kDkQNz1pUPr6Ion1kLEHzzVhMSIkBvbaU58bdzUO+k=
X-Received: by 2002:a0c:dd86:: with SMTP id v6mr51774122qvk.176.1563815661679;
 Mon, 22 Jul 2019 10:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190722114134.3123901-1-arnd@arndb.de> <CAG_fn=UxowACw5w+erKaAPRr4SWk3WbLTfAgJj=cOL4HgZHK=Q@mail.gmail.com>
 <CAK8P3a28c5V5VnsFrttgtCC5+i87yuAT-G5xx50KOsKUJ6-VKg@mail.gmail.com> <CAG_fn=U60gv-zWiVZS5Z++1fMcLwDmOgoF8gpJY3c+4dGHBhvw@mail.gmail.com>
In-Reply-To: <CAG_fn=U60gv-zWiVZS5Z++1fMcLwDmOgoF8gpJY3c+4dGHBhvw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jul 2019 19:14:04 +0200
Message-ID: <CAK8P3a2LOkeSD9uMEzg0VEr_yEEO+pS=g6FRq0Cn3hPMwSsLVA@mail.gmail.com>
Subject: Re: [PATCH] [RESEND v2] structleak: disable STRUCTLEAK_BYREF in
 combination with KASAN_STACK
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitriy Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 5:23 PM Alexander Potapenko <glider@google.com> wrote:
> On Mon, Jul 22, 2019 at 4:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jul 22, 2019 at 3:43 PM Alexander Potapenko <glider@google.com> wrote:
> > > On Mon, Jul 22, 2019 at 1:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > Doesn't that just limit the usefulness of KASAN, as you no longer catch
> > actual accesses to unintialized variables that KASAN is designed to find?
> KASAN (unlike KMSAN) doesn't detect accesses to uninitialized variables.
> It can of course detect bugs induced by e.g. treating an uninitialized
> variable as a pointer or an array index.
> Depending on the pattern used to initialize those variables, this can
> indeed mask some bugs, but OTOH others will become more reproducible.
>
> I'm not really sure KASAN+CONFIG_INIT_STACK_ALL is a problem right
> now, will need to take a look.

See below for the slightly trimmed warning output of a 32-bit ARM
allmodconfig build with KASAN_STACK enabled. In the default
allmodconfig build (no KASAN_STACK, with CONFIG_INIT_STACK_ALL)
I see no warnings.
With KASAN_STACK, some really bad ones start to appear, such as

drivers/gpu/drm/panel/panel-sitronix-st7789v.c:197:12: 14944 bytes
'st7789v_prepare'
drivers/usb/misc/sisusbvga/sisusb.c:1878:12: 12480 bytes 'sisusb_init_gfxcore'.
drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c:108:12:
7904 bytes 'lb035q02_connect'
drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c:163:13: 9600
bytes 'td028ttec1_panel_enable'
drivers/media/dvb-frontends/stv0367.c:995:12: 7488 bytes 'stv0367ter_algo'
drivers/media/i2c/mt9t112.c:670:12: 7584 bytes 'mt9t112_init_camera'
drivers/usb/misc/sisusbvga/sisusb.c:1750:13: 8096 bytes
'sisusb_set_default_mode'

In most functions, the frame sizes stay the same or go up 32 bytes.

In a few files, the warnings change drastically, and but it goes both ways,
smaller or larger with init_stack_all added in, presumably as clang makes
different inlining decisions, the worst ones are now

drivers/gpu/drm/panel/panel-sitronix-st7789v.c:197:12: 14944 bytes
'st7789v_prepare'
drivers/media/i2c/mt9t112.c:670:12: 10080 bytes 'mt9t112_init_camera'
drivers/usb/misc/sisusbvga/sisusb.c:1878:12: 11072 bytes 'sisusb_init_gfxcore'
drivers/firmware/broadcom/bcm47xx_sprom.c:187:13: 9152 bytes
'bcm47xx_sprom_fill_auto'
drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c:163:13: 9600
bytes 'td028ttec1_panel_enable'
drivers/usb/misc/sisusbvga/sisusb.c:1750:13: 8096 bytes
'sisusb_set_default_mode'

See below for the full list.

Overall, I'd say there is probably no harm in allowing CONFIG_INIT_STACK_ALL
in combination with KASAN_STACK when building with clang, as KASAN_STACK
by itself is the actual problem. With gcc, CONFIG_INIT_STACK_ALL+KASAN_STACK
is dangerous, while KASAN_STACK by itself is not a problem any more on
recent gcc versions.

       Arnd

--- allmodconfig-arm+kasan-stack 2019-07-22 18:57:29.970466686 +0200
+++ allmodconfig-arm+kasan_stack+init_stack_all 2019-07-22
18:57:31.434493204 +0200
@@ -1,262 +1,260 @@
 crypto/asymmetric_keys/asym_tpm.c:720:12: 1376 bytes 'tpm_key_eds_op'
 crypto/crypto_user_stat.c:298:5: 1920 bytes 'crypto_reportstat'
-drivers/block/drbd/drbd_receiver.c:921:12: 1632 bytes 'conn_connect'
+drivers/block/drbd/drbd_receiver.c:921:12: 1664 bytes 'conn_connect'
 drivers/block/loop.c:1569:12: 1824 bytes 'lo_ioctl'
 drivers/cdrom/cdrom.c:1149:5: 1600 bytes 'cdrom_open'
 drivers/crypto/ccree/cc_cipher.c:383:12: 1536 bytes 'cc_cipher_setkey'
-drivers/firmware/broadcom/bcm47xx_sprom.c:187:13: 3424 bytes
'bcm47xx_sprom_fill_auto'
+drivers/firmware/broadcom/bcm47xx_sprom.c:187:13: 9152 bytes
'bcm47xx_sprom_fill_auto'
+drivers/firmware/broadcom/bcm47xx_sprom.c:408:13: 1536 bytes
'bcm47xx_fill_sprom_path_r4589'
 drivers/fpga/machxo2-spi.c:186:12: 1952 bytes 'machxo2_write_init'
 drivers/fpga/machxo2-spi.c:286:12: 1856 bytes 'machxo2_write_complete'
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c:291:6: 1376 bytes
'amdgpu_atombios_get_connector_info_from_object_table'
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2993:6:
1312 bytes 'bw_calcs'
+drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:1361:17: 1312
bytes 'link_create'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:1328:23:
1568 bytes 'dce112_create_resource_pool'
 drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c:1553:6:
2112 bytes 'mod_color_calculate_regamma_params'
 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_hwmgr.c:2932:12:
1504 bytes 'vega10_enable_dpm_tasks'
-drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1923:12:
1504 bytes 'vegam_init_smc_table'
+drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1923:12:
1536 bytes 'vegam_init_smc_table'
 drivers/gpu/drm/bridge/parade-ps8622.c:352:13: 1632 bytes 'ps8622_pre_enable'
-drivers/gpu/drm/i2c/tda998x_drv.c:1419:13: 1376 bytes 'tda998x_bridge_mode_set'
-drivers/gpu/drm/i2c/tda998x_drv.c:2058:1: 1312 bytes 'tda998x_probe'
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c:567:1: 3456 bytes
'gf100_ram_new_'
-drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c:1521:1: 5472 bytes
'gk104_ram_new_'
+drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c:1521:1: 5504 bytes
'gk104_ram_new_'
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c:940:1: 2592 bytes
'gt215_ram_new'
-drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c:108:12:
7904 bytes 'lb035q02_connect'
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c:163:13: 9600
bytes 'td028ttec1_panel_enable'
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c:197:12: 14944 bytes
'st7789v_prepare'
 drivers/gpu/drm/radeon/ci_dpm.c:5165:5: 1408 bytes 'ci_dpm_enable'
 drivers/gpu/drm/radeon/radeon_atombios.c:521:6: 1440 bytes
'radeon_get_atom_connector_info_from_object_table'
 drivers/gpu/ipu-v3/ipu-di.c:557:5: 1472 bytes 'ipu_di_init_sync_panel'
-drivers/hid/hid-logitech-hidpp.c:3327:13: 2336 bytes 'hidpp_connect_event'
+drivers/hid/hid-logitech-hidpp.c:3327:13: 1664 bytes 'hidpp_connect_event'
 drivers/iio/accel/sca3000.c:1106:12: 1312 bytes 'sca3000_read_event_config'
 drivers/iio/accel/sca3000.c:1244:12: 3712 bytes 'sca3000_write_event_config'
 drivers/iio/accel/sca3000.c:1453:12: 4480 bytes 'sca3000_probe'
 drivers/iio/accel/sca3000.c:709:12: 1600 bytes 'sca3000_read_raw'
 drivers/iio/accel/sca3000.c:776:12: 2336 bytes 'sca3000_write_raw'
 drivers/iio/adc/ti-ads124s08.c:268:20: 1376 bytes 'ads124s_trigger_handler'
 drivers/iio/dac/ad5758.c:840:12: 4864 bytes 'ad5758_probe'
 drivers/iio/frequency/ad9523.c:509:16: 1440 bytes 'ad9523_store'
 drivers/iio/frequency/ad9523.c:972:12: 2720 bytes 'ad9523_probe'
 drivers/iio/proximity/as3935.c:320:12: 1408 bytes 'as3935_resume'
 drivers/infiniband/hw/cxgb3/iwch_cm.c:1428:12: 1312 bytes 'peer_close'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:4176:13: 2848 bytes
'i40iw_cm_event_handler'
 drivers/infiniband/hw/mlx4/mcg.c:642:13: 2016 bytes 'mlx4_ib_mcg_work_handler'
-drivers/infiniband/hw/mthca/mthca_main.c:897:12: 1440 bytes '__mthca_init_one'
+drivers/infiniband/hw/mthca/mthca_main.c:897:12: 1472 bytes '__mthca_init_one'
 drivers/infiniband/sw/rxe/rxe_req.c:583:5: 1536 bytes 'rxe_requester'
 drivers/input/touchscreen/hideep.c:616:12: 1632 bytes 'hideep_update_firmware'
-drivers/md/dm-integrity.c:2141:13: 1344 bytes 'do_journal_write'
+drivers/md/dm-integrity.c:2141:13: 1312 bytes 'do_journal_write'
 drivers/media/common/cx2341x.c:1574:5: 1888 bytes 'cx2341x_handler_init'
 drivers/media/dvb-frontends/cx24110.c:522:12: 1344 bytes 'cx24110_set_frontend'
-drivers/media/dvb-frontends/cx24120.c:1266:12: 1920 bytes 'cx24120_init'
-drivers/media/dvb-frontends/cx24123.c:900:12: 1600 bytes 'cx24123_set_frontend'
+drivers/media/dvb-frontends/cx24120.c:1266:12: 1984 bytes 'cx24120_init'
+drivers/media/dvb-frontends/cx24123.c:900:12: 1632 bytes 'cx24123_set_frontend'
 drivers/media/dvb-frontends/dib3000mc.c:323:12: 1920 bytes 'dib3000mc_init'
-drivers/media/dvb-frontends/drxd_hard.c:1897:12: 4544 bytes 'DRX_Start'
+drivers/media/dvb-frontends/drxd_hard.c:1897:12: 4608 bytes 'DRX_Start'
 drivers/media/dvb-frontends/drxd_hard.c:2801:12: 2272 bytes 'drxd_init'
 drivers/media/dvb-frontends/ds3000.c:883:12: 1440 bytes 'ds3000_set_frontend'
-drivers/media/dvb-frontends/itd1000.c:251:12: 2112 bytes
'itd1000_set_parameters'
-drivers/media/dvb-frontends/lgs8gl5.c:302:1: 1536 bytes 'lgs8gl5_set_frontend'
+drivers/media/dvb-frontends/itd1000.c:251:12: 2144 bytes
'itd1000_set_parameters'
+drivers/media/dvb-frontends/lgs8gl5.c:302:1: 1568 bytes 'lgs8gl5_set_frontend'
 drivers/media/dvb-frontends/m88rs2000.c:596:12: 1312 bytes
'm88rs2000_set_frontend'
 drivers/media/dvb-frontends/mb86a16.c:997:12: 2912 bytes 'mb86a16_set_fe'
 drivers/media/dvb-frontends/mxl5xx.c:1837:22: 2368 bytes 'mxl5xx_attach'
+drivers/media/dvb-frontends/nxt200x.c:525:12: 1440 bytes
'nxt200x_setup_frontend_parameters'
 drivers/media/dvb-frontends/nxt200x.c:930:12: 1408 bytes 'nxt2004_init'
 drivers/media/dvb-frontends/s5h1420.c:628:12: 1376 bytes 's5h1420_set_frontend'
-drivers/media/dvb-frontends/s5h1432.c:168:12: 1376 bytes 's5h1432_set_frontend'
-drivers/media/dvb-frontends/sp887x.c:520:12: 1472 bytes 'sp887x_init'
-drivers/media/dvb-frontends/stv0297.c:398:12: 2240 bytes 'stv0297_set_frontend'
-drivers/media/dvb-frontends/stv0367.c:2274:12: 1440 bytes 'stv0367cab_init'
-drivers/media/dvb-frontends/stv0367.c:2540:12: 3360 bytes
'stv0367cab_set_frontend'
-drivers/media/dvb-frontends/stv0367.c:995:12: 7488 bytes 'stv0367ter_algo'
-drivers/media/dvb-frontends/stv0900_core.c:1331:30: 3072 bytes
'stv0900_init_internal'
-drivers/media/dvb-frontends/stv0900_core.c:956:6: 1344 bytes
'stv0900_start_search'
+drivers/media/dvb-frontends/sp8870.c:451:12: 1472 bytes 'sp8870_set_frontend'
+drivers/media/dvb-frontends/sp887x.c:520:12: 1952 bytes 'sp887x_init'
+drivers/media/dvb-frontends/stv0297.c:398:12: 2688 bytes 'stv0297_set_frontend'
+drivers/media/dvb-frontends/stv0900_core.c:1331:30: 2944 bytes
'stv0900_init_internal'
+drivers/media/dvb-frontends/stv0900_core.c:956:6: 1376 bytes
'stv0900_start_search'
 drivers/media/dvb-frontends/stv0910.c:1019:12: 3680 bytes 'start'
 drivers/media/dvb-frontends/stv0910.c:1379:12: 1664 bytes 'read_status'
 drivers/media/dvb-frontends/stv0910.c:1776:22: 1920 bytes 'stv0910_attach'
 drivers/media/dvb-frontends/tda10086.c:93:12: 1536 bytes 'tda10086_init'
-drivers/media/i2c/mt9t112.c:670:12: 7584 bytes 'mt9t112_init_camera'
-drivers/media/i2c/mt9v111.c:410:12: 1312 bytes '__mt9v111_sw_reset'
-drivers/media/i2c/mt9v111.c:534:12: 2400 bytes 'mt9v111_hw_config'
-drivers/media/i2c/mt9v111.c:996:12: 1888 bytes 'mt9v111_s_ctrl'
-drivers/media/i2c/ov5640.c:1791:12: 3200 bytes 'ov5640_set_mode'
-drivers/media/i2c/ov5640.c:2588:12: 1536 bytes 'ov5640_s_ctrl'
+drivers/media/i2c/mt9t112.c:670:12: 10080 bytes 'mt9t112_init_camera'
+drivers/media/i2c/mt9v111.c:534:12: 2176 bytes 'mt9v111_hw_config'
+drivers/media/i2c/mt9v111.c:996:12: 1632 bytes 'mt9v111_s_ctrl'
+drivers/media/i2c/ov5640.c:1791:12: 3552 bytes 'ov5640_set_mode'
+drivers/media/i2c/ov5640.c:2588:12: 1504 bytes 'ov5640_s_ctrl'
 drivers/media/i2c/ov7670.c:1577:12: 1408 bytes 'ov7670_s_ctrl'
-drivers/media/i2c/s5k4ecgx.c:742:12: 1632 bytes '__s5k4ecgx_s_params'
-drivers/media/pci/cx23885/cx23885-dvb.c:1187:12: 2016 bytes 'dvb_register'
-drivers/media/pci/ddbridge/ddbridge-core.c:2365:6: 1664 bytes 'ddb_ports_init'
+drivers/media/i2c/s5k4ecgx.c:742:12: 1728 bytes '__s5k4ecgx_s_params'
+drivers/media/i2c/tvp5150.c:121:12: 1312 bytes 'tvp5150_log_status'
+drivers/media/pci/cx23885/cx23885-dvb.c:1187:12: 2080 bytes 'dvb_register'
+drivers/media/pci/ddbridge/ddbridge-core.c:2365:6: 1536 bytes 'ddb_ports_init'
 drivers/media/pci/ngene/ngene-core.c:1664:5: 1408 bytes 'ngene_probe'
-drivers/media/pci/ttpci/av7110_v4l.c:693:5: 1376 bytes
'av7110_init_analog_module'
-drivers/media/tuners/fc0011.c:163:12: 1824 bytes 'fc0011_set_params'
+drivers/media/pci/ttpci/av7110_v4l.c:693:5: 1344 bytes
'av7110_init_analog_module'
+drivers/media/tuners/fc0011.c:163:12: 2240 bytes 'fc0011_set_params'
 drivers/media/tuners/fc0013.c:209:12: 1440 bytes 'fc0013_set_params'
 drivers/media/tuners/msi001.c:83:12: 1504 bytes 'msi001_set_tuner'
 drivers/media/usb/cpia2/cpia2_core.c:615:5: 3552 bytes 'cpia2_reset_camera'
-drivers/media/usb/dvb-usb-v2/af9035.c:1200:12: 1632 bytes
'it930x_frontend_attach'
-drivers/media/usb/dvb-usb-v2/af9035.c:1340:12: 2592 bytes 'af9035_tuner_attach'
-drivers/media/usb/dvb-usb-v2/af9035.c:719:12: 1344 bytes
'af9035_download_firmware'
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c:350:12: 1920 bytes
'rtl2832u_read_config'
 drivers/media/usb/em28xx/em28xx-dvb.c:1407:12: 2176 bytes 'em28xx_dvb_init'
 drivers/media/usb/go7007/go7007-fw.c:1494:31: 1376 bytes 'do_special'
 drivers/media/usb/gspca/sn9c2028.c:802:12: 3168 bytes 'sd_start'
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:4585:12: 1376 bytes
'state_eval_pipeline_config'
-drivers/message/fusion/mptctl.c:621:1: 1472 bytes '__mptctl_ioctl'
+drivers/message/fusion/mptctl.c:621:1: 1504 bytes '__mptctl_ioctl'
 drivers/mfd/ezx-pcap.c:173:13: 1600 bytes 'pcap_isr_work'
 drivers/mtd/chips/cfi_cmdset_0001.c:1868:12: 2336 bytes 'cfi_intelext_writev'
-drivers/mtd/chips/cfi_cmdset_0020.c:421:12: 1600 bytes 'do_write_buffer'
-drivers/mtd/chips/cfi_cmdset_0020.c:734:19: 1664 bytes 'do_erase_oneblock'
+drivers/mtd/chips/cfi_cmdset_0020.c:248:19: 1312 bytes 'do_read_onechip'
+drivers/mtd/chips/cfi_cmdset_0020.c:421:12: 1664 bytes 'do_write_buffer'
+drivers/mtd/chips/cfi_cmdset_0020.c:734:19: 1696 bytes 'do_erase_oneblock'
 drivers/mtd/mtdchar.c:634:12: 1472 bytes 'mtdchar_ioctl'
-drivers/mtd/nftlcore.c:231:12: 1472 bytes 'NFTL_foldchain'
+drivers/mtd/nftlcore.c:231:12: 1504 bytes 'NFTL_foldchain'
 drivers/mtd/spi-nor/spi-nor.c:4104:5: 1312 bytes 'spi_nor_scan'
 drivers/net/can/janz-ican3.c:1882:12: 2208 bytes 'ican3_probe'
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:5662:13: 1440 bytes
'bnx2x_sp_task'
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c:1587:5: 1376 bytes
'bnxt_tc_setup_flower'
 drivers/net/ethernet/broadcom/cnic.c:2792:12: 1344 bytes
'cnic_submit_bnx2x_kwqes'
 drivers/net/ethernet/broadcom/cnic.c:4705:12: 2592 bytes 'cnic_start_bnx2_hw'
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c:1079:12: 1824 bytes
'cudbg_collect_mem_region'
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:5654:12: 1472 bytes 'init_one'
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:1068:5:
1696 bytes 'hclge_dbg_run_cmd'
-drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c:555:6: 1568
bytes 'hclge_mbx_handler'
+drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c:555:6: 1632
bytes 'hclge_mbx_handler'
 drivers/net/ethernet/intel/i40e/i40e_ddp.c:264:5: 1312 bytes 'i40e_ddp_load'
-drivers/net/ethernet/intel/i40e/i40e_main.c:14691:12: 1312 bytes 'i40e_probe'
-drivers/net/ethernet/netronome/nfp/bpf/jit.c:2843:1: 1504 bytes 'mem_ldx'
+drivers/net/ethernet/intel/i40e/i40e_main.c:14691:12: 1344 bytes 'i40e_probe'
+drivers/net/ethernet/microchip/enc28j60.c:649:12: 1312 bytes 'enc28j60_hw_init'
 drivers/net/ethernet/netronome/nfp/bpf/jit.c:3353:12: 1312 bytes 'call'
 drivers/net/ethernet/netronome/nfp/bpf/jit.c:4452:5: 1344 bytes 'nfp_bpf_jit'
 drivers/net/ethernet/qlogic/qede/qede_filter.c:1266:6: 2496 bytes
'qede_config_rx_mode'
 drivers/net/ethernet/qlogic/qed/qed_int.c:1213:6: 1696 bytes 'qed_int_sp_dpc'
 drivers/net/ethernet/qlogic/qed/qed_sriov.c:3861:13: 1856 bytes
'qed_iov_process_mbx_req'
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c:504:12: 1408
bytes 'qlcnic_sriov_pf_init'
 drivers/net/ieee802154/ca8210.c:2128:12: 1440 bytes 'ca8210_set_hw_addr_filt'
 drivers/net/ieee802154/ca8210.c:2286:12: 1440 bytes 'ca8210_set_csma_params'
-drivers/net/ieee802154/ca8210.c:2485:16: 2528 bytes
'ca8210_test_int_user_write'
+drivers/net/ieee802154/ca8210.c:2485:16: 2560 bytes
'ca8210_test_int_user_write'
 drivers/net/ieee802154/ca8210.c:3108:12: 5600 bytes 'ca8210_probe'
-drivers/net/usb/r8152.c:3303:13: 1408 bytes 'r8153_hw_phy_cfg'
-drivers/net/usb/r8152.c:3376:13: 1504 bytes 'r8153b_hw_phy_cfg'
+drivers/net/usb/r8152.c:3376:13: 1344 bytes 'r8153b_hw_phy_cfg'
+drivers/net/usb/smsc75xx.c:818:12: 1408 bytes 'smsc75xx_phy_initialize'
 drivers/net/wan/slic_ds26522.c:205:12: 6944 bytes 'slic_ds26522_probe'
 drivers/net/wimax/i2400m/fw.c:1480:5: 1568 bytes 'i2400m_fw_bootstrap'
 drivers/net/wimax/i2400m/rx.c:1244:5: 1792 bytes 'i2400m_rx'
 drivers/net/wimax/i2400m/usb-rx.c:328:5: 1344 bytes 'i2400mu_rxd'
 drivers/net/wireless/ath/ar5523/ar5523.c:1574:12: 1536 bytes 'ar5523_probe'
 drivers/net/wireless/ath/ar5523/ar5523.c:987:12: 1344 bytes 'ar5523_start'
-drivers/net/wireless/atmel/atmel.c:1156:20: 2240 bytes 'service_interrupt'
-drivers/net/wireless/atmel/atmel.c:1307:5: 1568 bytes 'atmel_open'
+drivers/net/wireless/atmel/atmel.c:1156:20: 1664 bytes 'service_interrupt'
+drivers/net/wireless/atmel/atmel.c:1307:5: 1440 bytes 'atmel_open'
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:2621:1:
1440 bytes 'wlc_lcnphy_tx_iqlo_cal'
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:4814:6:
1952 bytes 'wlc_phy_init_lcnphy'
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:15430:13:
2304 bytes 'wlc_phy_workarounds_nphy_gainctrl'
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:17019:13:
6560 bytes 'wlc_phy_workarounds_nphy'
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:19205:6:
1888 bytes 'wlc_phy_init_nphy'
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:25662:1:
2848 bytes 'wlc_phy_cal_txiqlo_nphy'
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:27723:1:
1312 bytes 'wlc_phy_cal_rxiq_nphy'
-drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:28334:1:
2080 bytes 'wlc_phy_txpwr_index_nphy'
+drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:28334:1:
2112 bytes 'wlc_phy_txpwr_index_nphy'
 drivers/net/wireless/cisco/airo.c:3050:12: 3968 bytes 'airo_thread'
 drivers/net/wireless/cisco/airo.c:3793:12: 1568 bytes 'setup_card'
 drivers/net/wireless/intel/ipw2x00/ipw2100.c:1710:12: 3616 bytes 'ipw2100_up'
 drivers/net/wireless/intel/ipw2x00/ipw2100.c:5473:12: 2656 bytes
'ipw2100_configure_security'
 drivers/net/wireless/intel/ipw2x00/ipw2100.c:7332:12: 2016 bytes
'ipw2100_wx_set_retry'
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c:1168:12: 1504 bytes
'iwl_mvm_mac_ctx_send'
-drivers/net/wireless/intersil/p54/p54spi.c:134:12: 1888 bytes
'p54spi_spi_write_dma'
-drivers/net/wireless/intersil/p54/p54spi.c:326:12: 2592 bytes 'p54spi_rx'
-drivers/net/wireless/intersil/p54/p54spi.c:478:13: 3456 bytes 'p54spi_work'
-drivers/net/wireless/intersil/p54/p54spi.c:517:12: 2304 bytes 'p54spi_op_start'
+drivers/net/wireless/intersil/p54/p54spi.c:478:13: 1440 bytes 'p54spi_work'
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c:908:5: 1760 bytes
'mt76x0_phy_set_channel'
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3349:13: 2048 bytes
'rt2800_config_channel_rf55xx'
-drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4011:13: 3360 bytes
'rt2800_config_channel'
-drivers/net/wireless/ralink/rt2x00/rt2800lib.c:6918:13: 4640 bytes
'rt2800_init_bbp_6352'
+drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4011:13: 3392 bytes
'rt2800_config_channel'
+drivers/net/wireless/ralink/rt2x00/rt2800lib.c:6918:13: 4672 bytes
'rt2800_init_bbp_6352'
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c:7122:13: 4832 bytes
'rt2800_init_bbp'
-drivers/net/wireless/ralink/rt2x00/rt2800lib.c:8033:13: 1440 bytes
'rt2800_init_rfcsr_3883'
+drivers/net/wireless/ralink/rt2x00/rt2800lib.c:8033:13: 1472 bytes
'rt2800_init_rfcsr_3883'
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c:8723:13: 6816 bytes
'rt2800_init_rfcsr_6352'
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c:8991:13: 4832 bytes
'rt2800_init_rfcsr'
-drivers/net/wireless/ralink/rt2x00/rt73usb.c:1407:12: 1920 bytes
'rt73usb_set_device_state'
+drivers/net/wireless/ralink/rt2x00/rt73usb.c:1407:12: 1888 bytes
'rt73usb_set_device_state'
 drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8225se.c:299:6: 1312
bytes 'rtl8225se_rf_init'
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3345:13:
2016 bytes 'btc8723b2ant_run_coexist_mechanism'
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3380:13:
2048 bytes 'btc8821a2ant_run_coexist_mechanism'
+drivers/power/supply/bq2415x_charger.c:301:12: 2496 bytes
'bq2415x_exec_command'
 drivers/rtc/rtc-mcp795.c:160:12: 1824 bytes 'mcp795_update_alarm'
 drivers/rtc/rtc-mcp795.c:183:12: 2880 bytes 'mcp795_set_time'
 drivers/rtc/rtc-mcp795.c:381:12: 1856 bytes 'mcp795_probe'
 drivers/rtc/rtc-r9701.c:95:12: 1600 bytes 'r9701_set_datetime'
-drivers/scsi/bfa/bfad_bsg.c:3551:1: 1760 bytes 'bfad_im_bsg_request'
-drivers/scsi/gdth.c:4020:13: 2560 bytes 'gdth_unlocked_ioctl'
+drivers/scsi/gdth.c:4020:13: 2624 bytes 'gdth_unlocked_ioctl'
 drivers/scsi/mpt3sas/mpt3sas_ctl.c:2255:1: 1600 bytes '_ctl_ioctl_main'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:9266:1: 2336 bytes '_mpt3sas_fw_work'
-drivers/scsi/pm8001/pm8001_hwi.c:4005:13: 1408 bytes 'process_one_iomb'
-drivers/scsi/pm8001/pm80xx_hwi.c:3556:13: 2688 bytes 'process_one_iomb'
-drivers/scsi/qla2xxx/qla_bsg.c:2434:1: 1408 bytes
'qla2x00_process_vendor_specific'
+drivers/scsi/pm8001/pm8001_hwi.c:4005:13: 1344 bytes 'process_one_iomb'
+drivers/scsi/pm8001/pm80xx_hwi.c:3556:13: 2624 bytes 'process_one_iomb'
+drivers/scsi/qla2xxx/qla_bsg.c:2434:1: 1472 bytes
'qla2x00_process_vendor_specific'
+drivers/scsi/qla4xxx/ql4_nx.c:3242:6: 1536 bytes 'qla4_8xxx_get_minidump'
 drivers/staging/fbtft/fbtft-core.c:989:5: 1376 bytes 'fbtft_init_display'
 drivers/staging/iio/adc/ad7280a.c:914:12: 1856 bytes 'ad7280_probe'
+drivers/staging/isdn/avm/b1.c:490:13: 1408 bytes 'b1_interrupt'
+drivers/staging/isdn/avm/b1dma.c:291:5: 1696 bytes 't1pci_detect'
 drivers/staging/pi433/rf69.c:171:5: 1824 bytes 'rf69_set_modulation_shaping'
 drivers/staging/pi433/rf69.c:703:5: 1824 bytes 'rf69_set_sync_values'
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c:91:23: 1376 bytes
'translate_scan'
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c:2667:13: 1472 bytes
'halbtc8723b2ant_RunCoexistMechanism'
-drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c:1700:5:
1344 bytes 'vchiq_mmal_component_finalise'
+drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c:1700:5:
1376 bytes 'vchiq_mmal_component_finalise'
 drivers/staging/wlan-ng/cfg80211.c:272:12: 1376 bytes 'prism2_scan'
 drivers/staging/wlan-ng/cfg80211.c:433:12: 3808 bytes 'prism2_connect'
 drivers/tty/rocket.c:1275:12: 1472 bytes 'rp_ioctl'
 drivers/tty/serial/8250/serial_cs.c:610:12: 4384 bytes 'serial_config'
 drivers/usb/core/devio.c:2392:13: 1408 bytes 'usbdev_do_ioctl'
 drivers/usb/host/max3421-hcd.c:1395:1: 5280 bytes 'max3421_spi_thread'
 drivers/usb/host/max3421-hcd.c:604:1: 1600 bytes 'max3421_next_transfer'
 drivers/usb/misc/sisusbvga/sisusb.c:1750:13: 8096 bytes
'sisusb_set_default_mode'
-drivers/usb/misc/sisusbvga/sisusb.c:1878:12: 12480 bytes 'sisusb_init_gfxcore'
-drivers/usb/misc/sisusbvga/sisusb.c:2203:12: 1376 bytes 'sisusb_init_gfxdevice'
-drivers/usb/typec/tcpm/tcpm.c:2838:13: 1408 bytes 'run_state_machine'
-drivers/vhost/vhost.c:3033:6: 1344 bytes 'vhost_enable_notify'
+drivers/usb/misc/sisusbvga/sisusb.c:1878:12: 11072 bytes 'sisusb_init_gfxcore'
+drivers/usb/misc/sisusbvga/sisusb.c:2203:12: 1408 bytes 'sisusb_init_gfxdevice'
+drivers/usb/typec/tcpm/tcpm.c:2838:13: 1472 bytes 'run_state_machine'
+drivers/usb/wusbcore/crypto.c:242:9: 1408 bytes 'wusb_prf'
+drivers/vhost/vhost.c:3033:6: 1376 bytes 'vhost_enable_notify'
 drivers/video/backlight/ams369fg06.c:209:12: 1664 bytes '_ams369fg06_gamma_ctl'
 drivers/video/backlight/lms501kf03.c:221:12: 5856 bytes 'lms501kf03_power_on'
-drivers/video/fbdev/aty/aty128fb.c:2072:12: 1408 bytes 'aty128_probe'
+drivers/video/fbdev/aty/aty128fb.c:2072:12: 1440 bytes 'aty128_probe'
 fs/btrfs/check-integrity.c:943:31: 1408 bytes 'btrfsic_process_metablock'
 fs/btrfs/disk-io.c:2616:5: 1664 bytes 'open_ctree'
 fs/btrfs/ioctl.c:5550:6: 1760 bytes 'btrfs_ioctl'
 fs/btrfs/tree-log.c:5079:12: 1504 bytes 'btrfs_log_inode'
-fs/crypto/keyinfo.c:502:5: 1536 bytes 'fscrypt_get_encryption_info'
+fs/crypto/keyinfo.c:502:5: 1664 bytes 'fscrypt_get_encryption_info'
 fs/ext4/extents.c:1948:5: 1664 bytes 'ext4_ext_insert_extent'
 fs/ext4/inode.c:53:14: 2560 bytes 'ext4_inode_csum'
 fs/ext4/namei.c:102:28: 1408 bytes '__ext4_read_dirblock'
-fs/ext4/namei.c:3977:12: 1664 bytes 'ext4_rename2'
 fs/ext4/namei.c:483:13: 1408 bytes 'ext4_dx_csum_set'
 fs/ext4/super.c:2380:15: 1920 bytes 'ext4_group_desc_csum'
 fs/ext4/super.c:3604:12: 1664 bytes 'ext4_fill_super'
 fs/ext4/xattr.c:128:15: 1920 bytes 'ext4_xattr_block_csum'
+fs/f2fs/checkpoint.c:1549:5: 1408 bytes 'f2fs_write_checkpoint'
 fs/f2fs/inode.c:158:6: 2304 bytes 'f2fs_inode_chksum_verify'
 fs/f2fs/inode.c:185:6: 2304 bytes 'f2fs_inode_chksum_set'
 fs/f2fs/super.c:3048:12: 1536 bytes 'f2fs_fill_super'
-fs/gfs2/ops_fstype.c:1235:23: 1376 bytes 'gfs2_mount'
 fs/jbd2/commit.c:355:6: 1792 bytes 'jbd2_journal_commit_transaction'
 fs/jbd2/recovery.c:416:12: 2432 bytes 'do_one_pass'
 fs/ocfs2/alloc.c:4239:12: 1504 bytes 'ocfs2_do_insert_extent'
-fs/ocfs2/aops.c:1658:5: 1728 bytes 'ocfs2_write_begin_nolock'
-fs/ocfs2/cluster/heartbeat.c:1201:12: 1696 bytes 'o2hb_thread'
+fs/ocfs2/aops.c:1658:5: 1760 bytes 'ocfs2_write_begin_nolock'
+fs/ocfs2/cluster/heartbeat.c:1201:12: 1728 bytes 'o2hb_thread'
 fs/ocfs2/cluster/tcp.c:1424:13: 1312 bytes 'o2net_rx_until_empty'
-fs/ocfs2/dir.c:3148:12: 1792 bytes 'ocfs2_extend_dir'
-fs/ocfs2/dir.c:4236:5: 1952 bytes 'ocfs2_prepare_dir_for_insert'
+fs/ocfs2/dir.c:3148:12: 1728 bytes 'ocfs2_extend_dir'
+fs/ocfs2/dir.c:4236:5: 1856 bytes 'ocfs2_prepare_dir_for_insert'
 fs/ocfs2/dlm/dlmdomain.c:2106:19: 2784 bytes 'dlm_register_domain'
-fs/ocfs2/dlm/dlmmaster.c:703:28: 2048 bytes 'dlm_get_lock_resource'
-fs/ocfs2/dlm/dlmrecovery.c:286:12: 3424 bytes 'dlm_recovery_thread'
+fs/ocfs2/dlm/dlmmaster.c:2766:5: 1312 bytes 'dlm_empty_lockres'
+fs/ocfs2/dlm/dlmmaster.c:703:28: 2080 bytes 'dlm_get_lock_resource'
+fs/ocfs2/dlm/dlmrecovery.c:286:12: 3488 bytes 'dlm_recovery_thread'
 fs/ocfs2/inode.c:1214:6: 1728 bytes 'ocfs2_evict_inode'
 fs/ocfs2/ioctl.c:836:6: 2016 bytes 'ocfs2_ioctl'
 fs/ocfs2/move_extents.c:985:5: 1856 bytes 'ocfs2_ioctl_move_extents'
 fs/ocfs2/namei.c:1192:12: 1696 bytes 'ocfs2_rename'
 fs/ocfs2/namei.c:1781:12: 1472 bytes 'ocfs2_symlink'
-fs/ocfs2/refcounttree.c:4418:5: 1952 bytes 'ocfs2_reflink_ioctl'
+fs/ocfs2/refcounttree.c:4418:5: 1984 bytes 'ocfs2_reflink_ioctl'
 fs/ocfs2/super.c:972:12: 3168 bytes 'ocfs2_fill_super'
 fs/ocfs2/xattr.c:2952:12: 1472 bytes 'ocfs2_xattr_block_set'
+fs/ocfs2/xattr.c:3527:5: 1344 bytes 'ocfs2_xattr_set'
 fs/ocfs2/xattr.c:7133:5: 1312 bytes 'ocfs2_reflink_xattrs'
 fs/quota/quota.c:823:5: 3360 bytes 'kernel_quotactl'
 fs/reiserfs/namei.c:1304:12: 1696 bytes 'reiserfs_rename'
 fs/select.c:621:5: 1312 bytes 'core_sys_select'
 fs/ubifs/auth.c:78:5: 1920 bytes 'ubifs_prepare_auth_node'
 fs/ubifs/master.c:332:5: 1408 bytes 'ubifs_read_master'
-include/linux/module.h:76:12: 2400 bytes 'init_module'
+include/linux/module.h:76:12: 2368 bytes 'init_module'
 kernel/bpf/verifier.c:7459:12: 2496 bytes 'do_check'
-kernel/locking/lockdep.c:3737:12: 2112 bytes '__lock_acquire'
-net/caif/cfctrl.c:350:12: 1600 bytes 'cfctrl_recv'
+net/caif/cfctrl.c:350:12: 1632 bytes 'cfctrl_recv'
 net/core/ethtool.c:2553:5: 2976 bytes 'dev_ethtool'
 net/dcb/dcbnl.c:1031:12: 1504 bytes 'dcbnl_ieee_fill'
 net/mac80211/mlme.c:4047:6: 2336 bytes 'ieee80211_sta_rx_queued_mgmt'
 net/netfilter/ipvs/ip_vs_nfct.c:140:13: 1440 bytes 'ip_vs_nfct_expect_callback'
 net/sctp/socket.c:4605:12: 1664 bytes 'sctp_setsockopt'
 net/sctp/socket.c:7765:12: 2272 bytes 'sctp_getsockopt'
 net/sunrpc/auth_gss/svcauth_gss.c:1437:1: 1664 bytes 'svcauth_gss_accept'
 net/wireless/nl80211.c:1826:12: 2016 bytes 'nl80211_send_wiphy'
 security/integrity/ima/ima_crypto.c:401:5: 1408 bytes 'ima_calc_file_hash'
 security/integrity/ima/ima_crypto.c:504:5: 1408 bytes
'ima_calc_field_array_hash'
 security/keys/encrypted-keys/encrypted.c:793:12: 1536 bytes
'encrypted_instantiate'
 security/keys/encrypted-keys/encrypted.c:912:13: 1408 bytes 'encrypted_read'
-sound/pci/ac97/ac97_codec.c:1998:5: 2464 bytes 'snd_ac97_mixer'
+sound/pci/ac97/ac97_codec.c:1998:5: 2496 bytes 'snd_ac97_mixer'
 sound/pci/emu10k1/emumixer.c:1775:5: 1472 bytes 'snd_emu10k1_mixer'
 sound/pci/hda/patch_ca0132.c:6363:12: 1632 bytes 'ca0132_build_controls'
+sound/pci/hda/patch_ca0132.c:6950:13: 2144 bytes 'sbz_chipio_startup_data'
+sound/pci/hda/patch_ca0132.c:8269:12: 1312 bytes 'ca0132_init'
 sound/spi/at73c213.c:1012:12: 2656 bytes 'snd_at73c213_remove'
 sound/spi/at73c213.c:882:12: 3424 bytes 'snd_at73c213_dev_init'
