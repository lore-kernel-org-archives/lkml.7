Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFD6C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2F24659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lmb41Ng+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfLELvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:51:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36518 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfLELvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:51:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so3205525wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 03:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBXS2fVZ51DQVa/R/v6e9OHUCcKwg3r/u7e0pbJqCG4=;
        b=Lmb41Ng+FZjPZov+1K9BDofF+dPoH9qDZfS64nj6cUMrgssH9Qyyw0iQEIurntOYTv
         tnDyqVe8fgdzI7KZQk+W8zr7o8oOKN6HP6w/ppvT5HD19mAPAbkO006BM106DO2U8uRG
         3BZNamFFbvBSpaf2KgK9M+OaEeNreuNFyPUr9zibtbR6Qk6m7eioczi1YArFYhKbsYl2
         esf/8b+DZ8pd3V5DQNYMNhjKFEWrLFhSvlRUuXQ5/6Gn4JQFNcRRw5S0jqP74JFS4h9l
         i/DA25L9pzx0lJs7M/4j/Z251+x8Ld+adxL8rNru0gfGHOAhyYV+awk/z7JsZG7vYlht
         9anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBXS2fVZ51DQVa/R/v6e9OHUCcKwg3r/u7e0pbJqCG4=;
        b=NRLkVdTnJUy7Ykq+E++oiMbCh66rgrhwa1RUwU6P3HEzAwFXlSpcotY0UqbVFzmZp6
         MTmhZnlK6nMPFfSR8p/C5fACYuRXm6XsHv3/CLyE5luSjR2YFla3ouN88D8Ha03WSQ5v
         cXaHuHP1flFHRuJgtrwCyJSYU/s7IoCVidrTja0IEmSOwMuy3WDorDSBued+Cjt2L8mz
         at6NTwiCLFMuBJ8p4cM/Auc7gk3Ar5lXz1rSzKm65Ff8p5riWWO1tjuU8btPfiVSOVy/
         E8bfB+EFczKC4oUENN4MsO+zfG5RzZwd8+kgm1J4Ld1Hr1tGH77GVnut/XGRH0EYM3KY
         C2WQ==
X-Gm-Message-State: APjAAAW8yiXeTIN3klDy4iAp1YJ77jBWOX2vgiTyyIGW2NmCp5/NQ0tG
        IIBoi9xms+/djJVdIiurjUIvBpci
X-Google-Smtp-Source: APXvYqzMZma6LQLIGy1PJFb3tPrjDLx9xdsidQXIwWaKJltAVdHyMZxBuYPk3nyJg609bA5bVjyNjA==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr4583819wru.318.1575546697748;
        Thu, 05 Dec 2019 03:51:37 -0800 (PST)
Received: from kali.univpm.it (copelandia.univpm.it. [193.205.128.7])
        by smtp.gmail.com with ESMTPSA id z18sm9964453wmf.21.2019.12.05.03.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 03:51:37 -0800 (PST)
From:   Andrea Fiorani <andrea.fiorani.open@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Fiorani <andrea.fiorani.open@gmail.com>
Subject: [PATCH] treewide: fix funciton/function typos
Date:   Thu,  5 Dec 2019 06:50:58 -0500
Message-Id: <20191205115058.7858-1-andrea.fiorani.open@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also add correct spellings to spelling.txt so checkpatch.pl will check
for typos.

Signed-off-by: Andrea Fiorani <andrea.fiorani.open@gmail.com>
---
 arch/powerpc/kernel/prom_init_check.sh              | 2 +-
 drivers/bluetooth/btmtksdio.c                       | 2 +-
 drivers/bluetooth/btmtkuart.c                       | 2 +-
 drivers/bluetooth/btusb.c                           | 2 +-
 drivers/extcon/extcon.c                             | 2 +-
 drivers/mmc/host/sdhci-pci-o2micro.c                | 2 +-
 drivers/net/ethernet/qlogic/qed/qed_int.h           | 2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h | 2 +-
 drivers/net/usb/lg-vl600.c                          | 2 +-
 drivers/scsi/3w-9xxx.c                              | 2 +-
 drivers/scsi/3w-sas.c                               | 2 +-
 drivers/scsi/3w-xxxx.c                              | 2 +-
 drivers/scsi/lpfc/lpfc_els.c                        | 2 +-
 drivers/scsi/snic/snic_fwint.h                      | 4 ++--
 drivers/scsi/snic/snic_scsi.c                       | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 include/net/caif/caif_layer.h                       | 2 +-
 kernel/bpf/btf.c                                    | 2 +-
 net/core/dev_addr_lists.c                           | 2 +-
 scripts/spelling.txt                                | 2 ++
 sound/pci/hda/patch_ca0132.c                        | 2 +-
 sound/soc/codecs/nau8825.c                          | 4 ++--
 tools/perf/util/dwarf-aux.h                         | 2 +-
 23 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index b183ab9c5107..0f1c50c3af51 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -67,7 +67,7 @@ do
 		fi
 	done
 
-	# ignore register save/restore funcitons
+	# ignore register save/restore functions
 	case $UNDEF in
 	_restgpr_*|_restgpr0_*|_rest32gpr_*)
 		OK=1
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 519788c442ca..1d98a26615ad 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -739,7 +739,7 @@ static int mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	wmt_params.data = NULL;
 	wmt_params.status = NULL;
 
-	/* Activate funciton the firmware providing to */
+	/* Activate function the firmware providing to */
 	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index e11169ad8247..debd6a639adb 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -297,7 +297,7 @@ static int mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	wmt_params.data = NULL;
 	wmt_params.status = NULL;
 
-	/* Activate funciton the firmware providing to */
+	/* Activate function the firmware providing to */
 	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 70e385987d41..55a1305bb760 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2863,7 +2863,7 @@ static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	wmt_params.data = NULL;
 	wmt_params.status = NULL;
 
-	/* Activate funciton the firmware providing to */
+	/* Activate function the firmware providing to */
 	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e055893fd5c3..9bfb6eaf27c1 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1073,7 +1073,7 @@ EXPORT_SYMBOL_GPL(extcon_dev_free);
  * do not set the values of "internal data", which are initialized by
  * this function.
  *
- * Note that before calling this funciton, have to allocate the memory
+ * Note that before calling this function, have to allocate the memory
  * of an extcon device by using the extcon_dev_allocate(). And the extcon
  * dev should include the supported_cable information.
  *
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index fa8105087d68..342f19b10c91 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -711,7 +711,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		pci_write_config_dword(chip->pdev,
 				       O2_SD_PLL_SETTING, scratch_32);
 
-		/* Disable UHS1 funciton */
+		/* Disable UHS1 function */
 		ret = pci_read_config_dword(chip->pdev,
 					    O2_SD_CAP_REG2, &scratch_32);
 		if (ret)
diff --git a/drivers/net/ethernet/qlogic/qed/qed_int.h b/drivers/net/ethernet/qlogic/qed/qed_int.h
index 9ad568d93ae6..8f48f82a8f6d 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_int.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_int.h
@@ -170,7 +170,7 @@ void qed_int_sp_dpc(unsigned long hwfn_cookie);
 
 /**
  * @brief qed_int_get_num_sbs - get the number of status
- *        blocks configured for this funciton in the igu.
+ *        blocks configured for this function in the igu.
  *
  * @param p_hwfn
  * @param p_sb_cnt_info
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
index 73fe2f64491d..a5b8ac6a0a0b 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
@@ -533,7 +533,7 @@ enum qlc_83xx_ext_regs {
 #define QLC_83XX_MULTI_TENANCY_INFO	BIT_29
 #define QLC_INIT_FW_RESOURCES		BIT_31
 
-/* 83xx funcitons */
+/* 83xx functions */
 int qlcnic_83xx_get_fw_version(struct qlcnic_adapter *);
 int qlcnic_83xx_issue_cmd(struct qlcnic_adapter *, struct qlcnic_cmd_args *);
 int qlcnic_83xx_setup_intr(struct qlcnic_adapter *);
diff --git a/drivers/net/usb/lg-vl600.c b/drivers/net/usb/lg-vl600.c
index 217a2d8fa47b..d3ae95fafdff 100644
--- a/drivers/net/usb/lg-vl600.c
+++ b/drivers/net/usb/lg-vl600.c
@@ -31,7 +31,7 @@
  * Windows/Mac drivers do send a couple of such frames to the device
  * during initialisation, with protocol set to 0x0906 or 0x0b06 and (what
  * seems to be) a flag in the .dummy_flags.  This doesn't seem necessary
- * for modem operation but can possibly be used for GPS or other funcitons.
+ * for modem operation but can possibly be used for GPS or other functions.
  */
 
 struct vl600_frame_hdr {
diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 3337b1e80412..fd0dff92a2df 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1694,7 +1694,7 @@ static int twa_reset_sequence(TW_Device_Extension *tw_dev, int soft_reset)
 	return retval;
 } /* End twa_reset_sequence() */
 
-/* This funciton returns unit geometry in cylinders/heads/sectors */
+/* This function returns unit geometry in cylinders/heads/sectors */
 static int twa_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev, sector_t capacity, int geom[])
 {
 	int heads, sectors, cylinders;
diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index dda6fa857709..4b3909bcd3be 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1404,7 +1404,7 @@ static int twl_reset_device_extension(TW_Device_Extension *tw_dev, int ioctl_res
 	return retval;
 } /* End twl_reset_device_extension() */
 
-/* This funciton returns unit geometry in cylinders/heads/sectors */
+/* This function returns unit geometry in cylinders/heads/sectors */
 static int twl_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev, sector_t capacity, int geom[])
 {
 	int heads, sectors;
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index fb6444d0409c..c8e07aeb2055 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1337,7 +1337,7 @@ static int tw_reset_device_extension(TW_Device_Extension *tw_dev)
 	return 0;
 } /* End tw_reset_device_extension() */
 
-/* This funciton returns unit geometry in cylinders/heads/sectors */
+/* This function returns unit geometry in cylinders/heads/sectors */
 static int tw_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 		sector_t capacity, int geom[]) 
 {
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 42a2bf38eaea..17523bba7315 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -7854,7 +7854,7 @@ lpfc_els_rcv_fan(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 }
 
 /**
- * lpfc_els_timeout - Handler funciton to the els timer
+ * lpfc_els_timeout - Handler function to the els timer
  * @ptr: holder for the timer function associated data.
  *
  * This routine is invoked by the ELS timer after timeout. It posts the ELS
diff --git a/drivers/scsi/snic/snic_fwint.h b/drivers/scsi/snic/snic_fwint.h
index 2a045a57e365..5e6520837720 100644
--- a/drivers/scsi/snic/snic_fwint.h
+++ b/drivers/scsi/snic/snic_fwint.h
@@ -109,7 +109,7 @@ struct snic_io_hdr {
 	u16	resvd;
 };
 
-/* auxillary funciton for encoding the snic_io_hdr */
+/* auxillary function for encoding the snic_io_hdr */
 static inline void
 snic_io_hdr_enc(struct snic_io_hdr *hdr, u8 typ, u8 status, u32 id, u32 hid,
 		u16 sg_cnt, ulong ctx)
@@ -124,7 +124,7 @@ snic_io_hdr_enc(struct snic_io_hdr *hdr, u8 typ, u8 status, u32 id, u32 hid,
 	hdr->flags = 0;
 }
 
-/* auxillary funciton for decoding the snic_io_hdr */
+/* auxillary function for decoding the snic_io_hdr */
 static inline void
 snic_io_hdr_dec(struct snic_io_hdr *hdr, u8 *typ, u8 *stat, u32 *cmnd_id,
 		u32 *hid, ulong *ctx)
diff --git a/drivers/scsi/snic/snic_scsi.c b/drivers/scsi/snic/snic_scsi.c
index b3650c989ed4..174ebb9e5ba7 100644
--- a/drivers/scsi/snic/snic_scsi.c
+++ b/drivers/scsi/snic/snic_scsi.c
@@ -2098,7 +2098,7 @@ snic_send_dr_and_wait(struct snic *snic, struct scsi_cmnd *sc)
 }
 
 /*
- * auxillary funciton to check lun reset op is supported or not
+ * auxillary function to check lun reset op is supported or not
  * Not supported if returns 0
  */
 static int
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index dba3f2db9f48..fb09392b1d6d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -1016,7 +1016,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
  *                                  *  (1) MPInitialization Phase
  *                                  *  (2) Receiving of Deauthentication from AP
  */
-// TODO: Should this funciton be called when receiving of Disassociation?
+// TODO: Should this function be called when receiving of Disassociation?
 void HTInitializeHTInfo(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT pHTInfo = ieee->pHTInfo;
diff --git a/include/net/caif/caif_layer.h b/include/net/caif/caif_layer.h
index 064094101cb5..c59a457655de 100644
--- a/include/net/caif/caif_layer.h
+++ b/include/net/caif/caif_layer.h
@@ -118,7 +118,7 @@ enum caif_direction {
  * @dn:		Pointer down to the layer below.
  * @node:	List node used when layer participate in a list.
  * @receive:	Packet receive function.
- * @transmit:	Packet transmit funciton.
+ * @transmit:	Packet transmit function.
  * @ctrlcmd:	Used for control signalling upwards in the stack.
  * @modemcmd:	Used for control signaling downwards in the stack.
  * @id:		The identity of this layer
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 40efde5eedcb..ecfe66e02a5f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2600,7 +2600,7 @@ static struct btf_kind_operations func_proto_ops = {
 	 * BTF_KIND_FUNC_PROTO cannot be directly referred by
 	 * a struct's member.
 	 *
-	 * It should be a funciton pointer instead.
+	 * It should be a function pointer instead.
 	 * (i.e. struct's member -> BTF_KIND_PTR -> BTF_KIND_FUNC_PROTO)
 	 *
 	 * Hence, there is no btf_func_check_member().
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 2f949b5a1eb9..46c62d08791c 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -228,7 +228,7 @@ EXPORT_SYMBOL(__hw_addr_unsync);
  *  @sync: function to call if address should be added
  *  @unsync: function to call if address should be removed
  *
- *  This funciton is intended to be called from the ndo_set_rx_mode
+ *  This function is intended to be called from the ndo_set_rx_mode
  *  function of devices that require explicit address add/remove
  *  notifications.  The unsync function may be NULL in which case
  *  the addresses requiring removal will simply be removed without
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 672b5931bc8d..6263fd00d259 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -621,6 +621,8 @@ fuctions||functions
 fullill||fulfill
 funcation||function
 funcion||function
+funciton||function
+funcitons||functions
 functionallity||functionality
 functionaly||functionally
 functionnality||functionality
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index b7a1abb3e231..4798a5330a58 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4287,7 +4287,7 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 }
 
 /*
- * This function behaves similarly to the ca0132_select_out funciton above,
+ * This function behaves similarly to the ca0132_select_out function above,
  * except with a few differences. It adds the ability to select the current
  * output with an enumerated control "output source" if the auto detect
  * mute switch is set to off. If the auto detect mute switch is enabled, it
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 9f5aee7de686..d793c0bc234b 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1968,7 +1968,7 @@ static void nau8825_component_remove(struct snd_soc_component *component)
 {
 	struct nau8825 *nau8825 = snd_soc_component_get_drvdata(component);
 
-	/* Cancel and reset cross tak suppresstion detection funciton */
+	/* Cancel and reset cross tak suppresstion detection function */
 	nau8825_xtalk_cancel(nau8825);
 }
 
@@ -2366,7 +2366,7 @@ static int nau8825_set_bias_level(struct snd_soc_component *component,
 		/* ground HPL/HPR, MICGRND1/2 */
 		regmap_update_bits(nau8825->regmap,
 			NAU8825_REG_HSD_CTRL, 0xf, 0xf);
-		/* Cancel and reset cross talk detection funciton */
+		/* Cancel and reset cross talk detection function */
 		nau8825_xtalk_cancel(nau8825);
 		/* Turn off all interruptions before system shutdown. Keep the
 		 * interruption quiet before resume setup completes.
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 506006e0cf66..cb99646843a9 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -22,7 +22,7 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die);
 int cu_find_lineinfo(Dwarf_Die *cudie, unsigned long addr,
 		     const char **fname, int *lineno);
 
-/* Walk on funcitons at given address */
+/* Walk on functions at given address */
 int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
 			 int (*callback)(Dwarf_Die *, void *), void *data);
 
-- 
2.24.0

