Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E2CC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 08:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E502720679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 08:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfFWICr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 04:02:47 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:56710 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfFWICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 04:02:46 -0400
X-IronPort-AV: E=Sophos;i="5.63,407,1557180000"; 
   d="scan'208";a="388663971"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2019 10:02:17 +0200
Date:   Sun, 23 Jun 2019 10:02:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Kirill Smelkov <kirr@nexedi.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/2] coccinelle: api/stream_open: treat all wait_.*()
 calls as blocking
In-Reply-To: <20190623075909.GA2888@deco.navytux.spb.ru>
Message-ID: <alpine.DEB.2.21.1906231002020.4961@hadrien>
References: <20190623072838.31234-1-kirr@nexedi.com> <alpine.DEB.2.21.1906230934080.4961@hadrien> <20190623075909.GA2888@deco.navytux.spb.ru>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Jun 2019, Kirill Smelkov wrote:

> On Sun, Jun 23, 2019 at 09:35:17AM +0200, Julia Lawall wrote:
> >
> >
> > On Sun, 23 Jun 2019, Kirill Smelkov wrote:
> >
> > > Previously steam_open.cocci was treating only wait_event_.* - e.g.
> > > wait_event_interruptible - as a blocking operation. However e.g.
> > > wait_for_completion_interruptible is also blocking, and so from this
> > > point of view it would be more logical to treat all wait_.* as a
> > > blocking point.
> > >
> > > The logic of this change actually came up for real when
> > > drivers/pci/switch/switchtec.c changed from using
> > > wait_event_interruptible to wait_for_completion_interruptible:
> > >
> > > 	https://lore.kernel.org/linux-pci/20190413170056.GA11293@deco.navytux.spb.ru/
> > > 	https://lore.kernel.org/linux-pci/20190415145456.GA15280@deco.navytux.spb.ru/
> > > 	https://lore.kernel.org/linux-pci/20190415154102.GB17661@deco.navytux.spb.ru/
> > >
> > > For a driver that uses nonseekable_open with read/write having stream
> > > semantic and read also calling e.g. wait_for_completion_interruptible,
> > > running stream_open.cocci before this patch would produce:
> > >
> > > 	WARNING: <driver>_fops: .read() and .write() have stream semantic; safe to change nonseekable_open -> stream_open.
> > >
> > > while after this patch it will report:
> > >
> > > 	ERROR: <driver>_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.
> >
> > Are you really sure that every word that starts with wait_ in the Linux
> > kernel has the property you want?  How many of them are there?  Would it
> > be reasonable to put the names in the semantic patch explicitly?
>
> We are talking about function calls or macros here only. I think that
> by default every "wait.*()" has blocking semantic, and if there are
> something that does not block, it should be instead white-listed with
> the default still being treated as "all wait.*() blocks".
>
> Here are the list of wait functions & macros (if I read tags format
> correctly). They were generated with `grep -w d tags |grep '^wait'` and
> `grep -w f tags |grep '^wait'`. Offhand they all seem to be of blocking
> kind to me.

OK, thanks for the list.

julia

>
> Kirill
>
> Macros (64)
> -----------
>
> wait_ack_clear  drivers/gpu/drm/i915/intel_uncore.c     /^wait_ack_clear(const struct drm_i915_private *i915,$/;"       f       signature:(const struct drm_i915_private *i915, const struct intel_uncore_forcewake_domain *d, const u32 ack)
> wait_ack_set    drivers/gpu/drm/i915/intel_uncore.c     /^wait_ack_set(const struct drm_i915_private *i915,$/;" f       signature:(const struct drm_i915_private *i915, const struct intel_uncore_forcewake_domain *d, const u32 ack)
> wait_capture_start      sound/core/pcm_lib.c    2117;"  d       file:
> wait_capture_start      sound/core/pcm_lib.c    2119;"  d       file:
> wait_event      include/linux/wait.h    286;"   d
> wait_event_cmd  include/linux/wait.h    416;"   d
> wait_event_exclusive_cmd        include/linux/wait.h    391;"   d
> wait_event_freezable    include/linux/wait.h    325;"   d
> wait_event_freezable_exclusive  include/linux/wait.h    593;"   d
> wait_event_freezable_timeout    include/linux/wait.h    376;"   d
> wait_event_freezekillable_unsafe        include/linux/freezer.h 251;"   d
> wait_event_freezekillable_unsafe        include/linux/freezer.h 297;"   d
> wait_event_hrtimeout    include/linux/wait.h    526;"   d
> wait_event_idle include/linux/wait.h    615;"   d
> wait_event_idle_exclusive       include/linux/wait.h    639;"   d
> wait_event_idle_exclusive_timeout       include/linux/wait.h    707;"   d
> wait_event_idle_timeout include/linux/wait.h    670;"   d
> wait_event_interruptible        include/linux/wait.h    442;"   d
> wait_event_interruptible_exclusive      include/linux/wait.h    566;"   d
> wait_event_interruptible_exclusive_locked       include/linux/wait.h    817;"   d
> wait_event_interruptible_exclusive_locked_irq   include/linux/wait.h    848;"   d
> wait_event_interruptible_hrtimeout      include/linux/wait.h    552;"   d
> wait_event_interruptible_lock_irq       include/linux/wait.h    1046;"  d
> wait_event_interruptible_lock_irq_cmd   include/linux/wait.h    1015;"  d
> wait_event_interruptible_lock_irq_timeout       include/linux/wait.h    1086;"  d
> wait_event_interruptible_locked include/linux/wait.h    759;"   d
> wait_event_interruptible_locked_irq     include/linux/wait.h    786;"   d
> wait_event_interruptible_timeout        include/linux/wait.h    476;"   d
> wait_event_killable     include/linux/wait.h    871;"   d
> wait_event_killable_exclusive   include/linux/wait.h    579;"   d
> wait_event_killable_timeout     include/linux/wait.h    907;"   d
> wait_event_lock_irq     include/linux/wait.h    975;"   d
> wait_event_lock_irq_cmd include/linux/wait.h    948;"   d
> wait_event_lock_irq_timeout     include/linux/wait.h    1097;"  d
> wait_event_timeout      include/linux/wait.h    358;"   d
> wait_for        drivers/gpu/drm/gma500/cdv_intel_display.c      136;"   d       file:
> wait_for        drivers/gpu/drm/gma500/cdv_intel_dp.c   248;"   d       file:
> wait_for        drivers/gpu/drm/gma500/intel_gmbus.c    51;"    d       file:
> wait_for        drivers/gpu/drm/i915/intel_drv.h        79;"    d
> wait_for        drivers/gpu/drm/v3d/v3d_drv.h   248;"   d
> wait_for        drivers/gpu/drm/vc4/vc4_drv.h   659;"   d
> wait_for_atomic drivers/gpu/drm/gma500/intel_gmbus.c    52;"    d       file:
> wait_for_atomic drivers/gpu/drm/i915/intel_drv.h        143;"   d
> wait_for_atomic_us      drivers/gpu/drm/i915/intel_drv.h        136;"   d
> wait_for_kprobe_optimizer       kernel/kprobes.c        951;"   d       file:
> wait_for_pll_disable    drivers/clk/qcom/clk-alpha-pll.c        169;"   d       file:
> wait_for_pll_enable_active      drivers/clk/qcom/clk-alpha-pll.c        163;"   d       file:
> wait_for_pll_enable_lock        drivers/clk/qcom/clk-alpha-pll.c        166;"   d       file:
> wait_for_pll_offline    drivers/clk/qcom/clk-alpha-pll.c        172;"   d       file:
> wait_for_pll_update     drivers/clk/qcom/clk-alpha-pll.c        175;"   d       file:
> wait_for_pll_update_ack_clear   drivers/clk/qcom/clk-alpha-pll.c        181;"   d       file:
> wait_for_pll_update_ack_set     drivers/clk/qcom/clk-alpha-pll.c        178;"   d       file:
> wait_for_us     drivers/gpu/drm/i915/intel_drv.h        125;"   d
> wait_on_command drivers/char/sonypi.c   505;"   d       file:
> wait_on_command drivers/platform/x86/sony-laptop.c      3613;"  d       file:
> wait_on_ibf     arch/x86/platform/olpc/olpc.c   69;"    d       file:
> wait_on_obf     arch/x86/platform/olpc/olpc.c   89;"    d       file:
> wait_rcu_gp     include/linux/rcupdate_wait.h   32;"    d
> wait_timeout    drivers/staging/rts5208/rtsx.h  66;"    d
> wait_timeout_x  drivers/staging/rts5208/rtsx.h  61;"    d
> wait_var_event  include/linux/wait_bit.h        273;"   d
> wait_var_event_killable include/linux/wait_bit.h        285;"   d
> wait_var_event_timeout  include/linux/wait_bit.h        299;"   d
> waiting include/linux/parport.h /^      unsigned long waiting;           \/* long req'd for set_bit --RR *\/$/;"        m       struct:pardevice        access:public
>
>
> Functions (382)
> ---------------
>
> wait	drivers/char/tpm/tpm_infineon.c	/^static int wait(struct tpm_chip *chip, int wait_for_bit)$/;"	f	signature:(struct tpm_chip *chip, int wait_for_bit)
> wait	drivers/net/ethernet/hp/hp100.c	/^static void wait(void)$/;"	f	signature:(void)
> wait4buf	drivers/ata/pata_arasan_cf.c	/^static inline int wait4buf(struct arasan_cf_dev *acdev)$/;"	f	signature:(struct arasan_cf_dev *acdev)
> wait_HDO_off	drivers/scsi/a100u2w.c	/^static u8 wait_HDO_off(struct orc_host * host)$/;"	f	signature:(struct orc_host * host)
> wait_TBE	drivers/input/serio/gscps2.c	/^static int wait_TBE(char __iomem *addr)$/;"	f	signature:(char __iomem *addr)
> wait_ack	drivers/gpu/drm/ast/ast_dp501.c	/^static bool wait_ack(struct ast_private *ast)$/;"	f	signature:(struct ast_private *ast)
> wait_ack	drivers/i2c/busses/i2c-au1550.c	/^static int wait_ack(struct i2c_au1550_data *adap)$/;"	f	signature:(struct i2c_au1550_data *adap)
> wait_ack_clear	drivers/gpu/drm/i915/intel_uncore.c	/^wait_ack_clear(const struct drm_i915_private *i915,$/;"	f	signature:(const struct drm_i915_private *i915, const struct intel_uncore_forcewake_domain *d, const u32 ack)
> wait_ack_set	drivers/gpu/drm/i915/intel_uncore.c	/^wait_ack_set(const struct drm_i915_private *i915,$/;"	f	signature:(const struct drm_i915_private *i915, const struct intel_uncore_forcewake_domain *d, const u32 ack)
> wait_and_add_new_range	drivers/md/dm-integrity.c	/^static void wait_and_add_new_range(struct dm_integrity_c *ic, struct dm_integrity_range *new_range)$/;"	f	signature:(struct dm_integrity_c *ic, struct dm_integrity_range *new_range)
> wait_and_poll	drivers/scsi/megaraid/megaraid_sas_fusion.c	/^wait_and_poll(struct megasas_instance *instance, struct megasas_cmd *cmd,$/;"	f	signature:(struct megasas_instance *instance, struct megasas_cmd *cmd, int seconds)
> wait_and_send	drivers/char/tpm/tpm_infineon.c	/^static void wait_and_send(struct tpm_chip *chip, u8 sendbyte)$/;"	f	signature:(struct tpm_chip *chip, u8 sendbyte)
> wait_backlight_on	drivers/gpu/drm/i915/intel_dp.c	/^static void wait_backlight_on(struct intel_dp *intel_dp)$/;"	f	signature:(struct intel_dp *intel_dp)
> wait_barrier	drivers/md/raid1.c	/^static void wait_barrier(struct r1conf *conf, sector_t sector_nr)$/;"	f	signature:(struct r1conf *conf, sector_t sector_nr)
> wait_barrier	drivers/md/raid10.c	/^static void wait_barrier(struct r10conf *conf)$/;"	f	signature:(struct r10conf *conf)
> wait_bit_init	kernel/sched/wait_bit.c	/^void __init wait_bit_init(void)$/;"	f	signature:(void)
> wait_block_group_cache_done	fs/btrfs/extent-tree.c	/^wait_block_group_cache_done(struct btrfs_block_group_cache *cache)$/;"	f	signature:(struct btrfs_block_group_cache *cache)
> wait_block_group_cache_progress	fs/btrfs/extent-tree.c	/^wait_block_group_cache_progress(struct btrfs_block_group_cache *cache,$/;"	f	signature:(struct btrfs_block_group_cache *cache, u64 num_bytes)
> wait_busy	drivers/isdn/hisax/hfc4s8s_l1.c	/^wait_busy(hfc4s8s_hw *a)$/;"	f	signature:(hfc4s8s_hw *a)
> wait_caps_flush	fs/ceph/mds_client.c	/^static void wait_caps_flush(struct ceph_mds_client *mdsc,$/;"	f	signature:(struct ceph_mds_client *mdsc, u64 want_flush_tid)
> wait_cfg	drivers/net/ethernet/i825xx/82596.c	/^static inline int wait_cfg(struct net_device *dev, struct i596_cmd *cmd, int delcnt, char *str)$/;"	f	signature:(struct net_device *dev, struct i596_cmd *cmd, int delcnt, char *str)
> wait_chip_ready	drivers/scsi/a100u2w.c	/^static u8 wait_chip_ready(struct orc_host * host)$/;"	f	signature:(struct orc_host * host)
> wait_ci_ready	drivers/media/pci/ddbridge/ddbridge-ci.c	/^static int wait_ci_ready(struct ddb_ci *ci)$/;"	f	signature:(struct ddb_ci *ci)
> wait_clean_list_grace	net/rds/ib_rdma.c	/^static inline void wait_clean_list_grace(void)$/;"	f	signature:(void)
> wait_clear_underrun_bit	sound/x86/intel_hdmi_audio.c	/^static void wait_clear_underrun_bit(struct snd_intelhad *intelhaddata)$/;"	f	signature:(struct snd_intelhad *intelhaddata)
> wait_clear_urbs	sound/usb/endpoint.c	/^static int wait_clear_urbs(struct snd_usb_endpoint *ep)$/;"	f	signature:(struct snd_usb_endpoint *ep)
> wait_cmd	drivers/net/ethernet/i825xx/82596.c	/^static inline int wait_cmd(struct net_device *dev, struct i596_private *lp, int delcnt, char *str)$/;"	f	signature:(struct net_device *dev, struct i596_private *lp, int delcnt, char *str)
> wait_cmd	drivers/net/ethernet/i825xx/lib82596.c	/^static inline int wait_cmd(struct net_device *dev, struct i596_dma *dma, int delcnt, char *str)$/;"	f	signature:(struct net_device *dev, struct i596_dma *dma, int delcnt, char *str)
> wait_cmds_complete_timeout_v2_hw	drivers/scsi/hisi_sas/hisi_sas_v2_hw.c	/^static void wait_cmds_complete_timeout_v2_hw(struct hisi_hba *hisi_hba,$/;"	f	signature:(struct hisi_hba *hisi_hba, int delay_ms, int timeout_ms)
> wait_cmds_complete_timeout_v3_hw	drivers/scsi/hisi_sas/hisi_sas_v3_hw.c	/^static void wait_cmds_complete_timeout_v3_hw(struct hisi_hba *hisi_hba,$/;"	f	signature:(struct hisi_hba *hisi_hba, int delay_ms, int timeout_ms)
> wait_cmv_ack	drivers/usb/atm/ueagle-atm.c	/^static inline int wait_cmv_ack(struct uea_softc *sc)$/;"	f	signature:(struct uea_softc *sc)
> wait_command_complete	drivers/char/pcmcia/synclink_cs.c	/^static bool wait_command_complete(MGSLPC_INFO *info, unsigned char channel)$/;"	f	signature:(MGSLPC_INFO *info, unsigned char channel)
> wait_completion	drivers/mtd/nand/raw/sh_flctl.c	/^static void wait_completion(struct sh_flctl *flctl)$/;"	f	signature:(struct sh_flctl *flctl)
> wait_consider_task	kernel/exit.c	/^static int wait_consider_task(struct wait_opts *wo, int ptrace,$/;"	f	signature:(struct wait_opts *wo, int ptrace, struct task_struct *p)
> wait_controller_finished	drivers/mtd/nand/raw/hisi504_nand.c	/^static void wait_controller_finished(struct hinfc_host *host)$/;"	f	signature:(struct hinfc_host *host)
> wait_conversion_complete_gpio	drivers/iio/magnetometer/ak8975.c	/^static int wait_conversion_complete_gpio(struct ak8975_data *data)$/;"	f	signature:(struct ak8975_data *data)
> wait_conversion_complete_interrupt	drivers/iio/magnetometer/ak8975.c	/^static int wait_conversion_complete_interrupt(struct ak8975_data *data)$/;"	f	signature:(struct ak8975_data *data)
> wait_conversion_complete_irq	drivers/iio/light/gp2ap020a00f.c	/^static int wait_conversion_complete_irq(struct gp2ap020a00f_data *data)$/;"	f	signature:(struct gp2ap020a00f_data *data)
> wait_conversion_complete_polled	drivers/iio/magnetometer/ak8975.c	/^static int wait_conversion_complete_polled(struct ak8975_data *data)$/;"	f	signature:(struct ak8975_data *data)
> wait_current_trans	fs/btrfs/transaction.c	/^static void wait_current_trans(struct btrfs_fs_info *fs_info)$/;"	f	signature:(struct btrfs_fs_info *fs_info)
> wait_current_trans_commit_start	fs/btrfs/transaction.c	/^static void wait_current_trans_commit_start(struct btrfs_fs_info *fs_info,$/;"	f	signature:(struct btrfs_fs_info *fs_info, struct btrfs_transaction *trans)
> wait_current_trans_commit_start_and_unblock	fs/btrfs/transaction.c	/^static void wait_current_trans_commit_start_and_unblock($/;"	f	signature:( struct btrfs_fs_info *fs_info, struct btrfs_transaction *trans)
> wait_data_buf_ready	drivers/staging/rts5208/sd.c	/^static int wait_data_buf_ready(struct rtsx_chip *chip)$/;"	f	signature:(struct rtsx_chip *chip)
> wait_dev_flush	fs/btrfs/disk-io.c	/^static blk_status_t wait_dev_flush(struct btrfs_device *device)$/;"	f	signature:(struct btrfs_device *device)
> wait_dev_supers	fs/btrfs/disk-io.c	/^static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)$/;"	f	signature:(struct btrfs_device *device, int max_mirrors)
> wait_dis	drivers/media/dvb-frontends/stv0910.c	/^static int wait_dis(struct stv *state, u8 flag, u8 val)$/;"	f	signature:(struct stv *state, u8 flag, u8 val)
> wait_drive_not_busy	drivers/ide/ide-taskfile.c	/^static u8 wait_drive_not_busy(ide_drive_t *drive)$/;"	f	signature:(ide_drive_t *drive)
> wait_dsp_ack	sound/pci/asihpi/hpi6205.c	/^static int wait_dsp_ack(struct hpi_hw_obj *phw, int state, int timeout_us)$/;"	f	signature:(struct hpi_hw_obj *phw, int state, int timeout_us)
> wait_eeprom_cmd_done	drivers/staging/rtl8712/rtl871x_eeprom.c	/^static u16 wait_eeprom_cmd_done(struct _adapter *padapter)$/;"	f	signature:(struct _adapter *padapter)
> wait_eeprom_cmd_done	drivers/staging/rtl8723bs/core/rtw_eeprom.c	/^u16 wait_eeprom_cmd_done(_adapter *padapter)$/;"	f	signature:(_adapter *padapter)
> wait_eeprom_ready	drivers/net/ethernet/cirrus/cs89x0.c	/^wait_eeprom_ready(struct net_device *dev)$/;"	f	signature:(struct net_device *dev)
> wait_end_of_write	drivers/video/fbdev/omap/sossi.c	/^static void wait_end_of_write(void)$/;"	f	signature:(void)
> wait_entry_unlocked	fs/dax.c	/^static void wait_entry_unlocked(struct xa_state *xas, void *entry)$/;"	f	signature:(struct xa_state *xas, void *entry)
> wait_err	drivers/mtd/nand/onenand/omap2.c	/^static void wait_err(char *msg, int state, unsigned int ctrl, unsigned int intr)$/;"	f	signature:(char *msg, int state, unsigned int ctrl, unsigned int intr)
> wait_events	drivers/char/pcmcia/synclink_cs.c	/^static int wait_events(MGSLPC_INFO * info, int __user *mask_ptr)$/;"	f	signature:(MGSLPC_INFO * info, int __user *mask_ptr)
> wait_extent_bit	fs/btrfs/extent_io.c	/^static void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,$/;"	f	signature:(struct extent_io_tree *tree, u64 start, u64 end, unsigned long bits)
> wait_firmware_ready	drivers/scsi/a100u2w.c	/^static u8 wait_firmware_ready(struct orc_host * host)$/;"	f	signature:(struct orc_host * host)
> wait_fm_ready	drivers/infiniband/hw/hfi1/firmware.c	/^int wait_fm_ready(struct hfi1_devdata *dd, u32 mstimeout)$/;"	f	signature:(struct hfi1_devdata *dd, u32 mstimeout)
> wait_for_53c80_access	drivers/scsi/g_NCR5380.c	/^static void wait_for_53c80_access(struct NCR5380_hostdata *hostdata)$/;"	f	signature:(struct NCR5380_hostdata *hostdata)
> wait_for_HP	drivers/usb/host/uhci-hub.c	/^static void wait_for_HP(struct uhci_hcd *uhci, unsigned long port_addr)$/;"	f	signature:(struct uhci_hcd *uhci, unsigned long port_addr)
> wait_for_ack	drivers/macintosh/via-pmu.c	/^wait_for_ack(void)$/;"	f	signature:(void)
> wait_for_all_fifos_empty	drivers/gpu/drm/gma500/mdfld_dsi_pkg_sender.c	/^static int wait_for_all_fifos_empty(struct mdfld_dsi_pkg_sender *sender)$/;"	f	signature:(struct mdfld_dsi_pkg_sender *sender)
> wait_for_and_update_peer_seq	drivers/block/drbd/drbd_receiver.c	/^static int wait_for_and_update_peer_seq(struct drbd_peer_device *peer_device, const u32 peer_seq)$/;"	f	signature:(struct drbd_peer_device *peer_device, const u32 peer_seq)
> wait_for_ap_thread	kernel/cpu.c	/^static inline void wait_for_ap_thread(struct cpuhp_cpu_state *st, bool bringup)$/;"	f	signature:(struct cpuhp_cpu_state *st, bool bringup)
> wait_for_api_cmd_completion	drivers/net/ethernet/huawei/hinic/hinic_hw_api_cmd.c	/^static int wait_for_api_cmd_completion(struct hinic_api_cmd_chain *chain)$/;"	f	signature:(struct hinic_api_cmd_chain *chain)
> wait_for_async_commands	drivers/infiniband/hw/mlx5/mr.c	/^static void wait_for_async_commands(struct mlx5_ib_dev *dev)$/;"	f	signature:(struct mlx5_ib_dev *dev)
> wait_for_avail	sound/core/pcm_lib.c	/^static int wait_for_avail(struct snd_pcm_substream *substream,$/;"	f	signature:(struct snd_pcm_substream *substream, snd_pcm_uframes_t *availp)
> wait_for_bb	drivers/i2c/algos/i2c-algo-pcf.c	/^static int wait_for_bb(struct i2c_algo_pcf_data *adap)$/;"	f	signature:(struct i2c_algo_pcf_data *adap)
> wait_for_bit_change	drivers/gpu/drm/omapdrm/dss/dsi.c	/^static inline bool wait_for_bit_change(struct dsi_data *dsi,$/;"	f	signature:(struct dsi_data *dsi, const struct dsi_reg idx, int bitnum, int value)
> wait_for_bit_change	drivers/gpu/drm/omapdrm/dss/pll.c	/^static int wait_for_bit_change(void __iomem *reg, int bitnum, int value)$/;"	f	signature:(void __iomem *reg, int bitnum, int value)
> wait_for_bit_change	drivers/video/fbdev/omap2/omapfb/dss/dsi.c	/^static inline int wait_for_bit_change(struct platform_device *dsidev,$/;"	f	signature:(struct platform_device *dsidev, const struct dsi_reg idx, int bitnum, int value)
> wait_for_bit_change	drivers/video/fbdev/omap2/omapfb/dss/pll.c	/^static int wait_for_bit_change(void __iomem *reg, int bitnum, int value)$/;"	f	signature:(void __iomem *reg, int bitnum, int value)
> wait_for_bulk_in_ready	drivers/char/pcmcia/cm4040_cs.c	/^static int wait_for_bulk_in_ready(struct reader_dev *dev)$/;"	f	signature:(struct reader_dev *dev)
> wait_for_bulk_out_ready	drivers/char/pcmcia/cm4040_cs.c	/^static int wait_for_bulk_out_ready(struct reader_dev *dev)$/;"	f	signature:(struct reader_dev *dev)
> wait_for_call_done	drivers/media/dvb-frontends/stv6111.c	/^static int wait_for_call_done(struct stv *state, u8 mask)$/;"	f	signature:(struct stv *state, u8 mask)
> wait_for_card_driver	samples/mic/mpssd/mpssd.c	/^wait_for_card_driver(struct mic_info *mic, int fd, int type)$/;"	f	signature:(struct mic_info *mic, int fd, int type)
> wait_for_clients	drivers/infiniband/hw/hfi1/init.c	/^static void wait_for_clients(struct hfi1_devdata *dd)$/;"	f	signature:(struct hfi1_devdata *dd)
> wait_for_cmd_complete	drivers/net/ethernet/neterion/s2io.c	/^static int wait_for_cmd_complete(void __iomem *addr, u64 busy_bit,$/;"	f	signature:(void __iomem *addr, u64 busy_bit, int bit_state)
> wait_for_cmds_dispatched_to_panel	drivers/gpu/drm/i915/icl_dsi.c	/^static void wait_for_cmds_dispatched_to_panel(struct intel_encoder *encoder)$/;"	f	signature:(struct intel_encoder *encoder)
> wait_for_codec	sound/pci/fm801.c	/^static int wait_for_codec(struct fm801 *chip, unsigned int codec_id,$/;"	f	signature:(struct fm801 *chip, unsigned int codec_id, unsigned short reg, unsigned long waits)
> wait_for_commit	fs/btrfs/transaction.c	/^static noinline void wait_for_commit(struct btrfs_transaction *commit)$/;"	f	signature:(struct btrfs_transaction *commit)
> wait_for_commit	fs/ubifs/commit.c	/^static int wait_for_commit(struct ubifs_info *c)$/;"	f	signature:(struct ubifs_info *c)
> wait_for_common	kernel/sched/completion.c	/^wait_for_common(struct completion *x, long timeout, int state)$/;"	f	signature:(struct completion *x, long timeout, int state)
> wait_for_common_io	kernel/sched/completion.c	/^wait_for_common_io(struct completion *x, long timeout, int state)$/;"	f	signature:(struct completion *x, long timeout, int state)
> wait_for_complete	drivers/staging/greybus/tools/loopback_test.c	/^static int wait_for_complete(struct loopback_test *t)$/;"	f	signature:(struct loopback_test *t)
> wait_for_completion	kernel/sched/completion.c	/^void __sched wait_for_completion(struct completion *x)$/;"	f	signature:(struct completion *x)
> wait_for_completion_interruptible	kernel/sched/completion.c	/^int __sched wait_for_completion_interruptible(struct completion *x)$/;"	f	signature:(struct completion *x)
> wait_for_completion_interruptible_timeout	kernel/sched/completion.c	/^wait_for_completion_interruptible_timeout(struct completion *x,$/;"	f	signature:(struct completion *x, unsigned long timeout)
> wait_for_completion_io	kernel/sched/completion.c	/^void __sched wait_for_completion_io(struct completion *x)$/;"	f	signature:(struct completion *x)
> wait_for_completion_io_timeout	kernel/sched/completion.c	/^wait_for_completion_io_timeout(struct completion *x, unsigned long timeout)$/;"	f	signature:(struct completion *x, unsigned long timeout)
> wait_for_completion_killable	kernel/sched/completion.c	/^int __sched wait_for_completion_killable(struct completion *x)$/;"	f	signature:(struct completion *x)
> wait_for_completion_killable_timeout	kernel/sched/completion.c	/^wait_for_completion_killable_timeout(struct completion *x,$/;"	f	signature:(struct completion *x, unsigned long timeout)
> wait_for_completion_timeout	kernel/sched/completion.c	/^wait_for_completion_timeout(struct completion *x, unsigned long timeout)$/;"	f	signature:(struct completion *x, unsigned long timeout)
> wait_for_concurrent_writes	fs/nfsd/vfs.c	/^static int wait_for_concurrent_writes(struct file *file)$/;"	f	signature:(struct file *file)
> wait_for_connected	drivers/usb/core/hub.c	/^static int wait_for_connected(struct usb_device *udev,$/;"	f	signature:(struct usb_device *udev, struct usb_hub *hub, int *port1, u16 *portchange, u16 *portstatus)
> wait_for_csb	drivers/crypto/nx/nx-842-powernv.c	/^static int wait_for_csb(struct nx842_workmem *wmem,$/;"	f	signature:(struct nx842_workmem *wmem, struct coprocessor_status_block *csb)
> wait_for_ct_request_update	drivers/gpu/drm/i915/intel_guc_ct.c	/^static int wait_for_ct_request_update(struct ct_request *req, u32 *status)$/;"	f	signature:(struct ct_request *req, u32 *status)
> wait_for_ctb_desc_update	drivers/gpu/drm/i915/intel_guc_ct.c	/^static int wait_for_ctb_desc_update(struct guc_ct_buffer_desc *desc,$/;"	f	signature:(struct guc_ct_buffer_desc *desc, u32 fence, u32 *status)
> wait_for_ctrl_irq	drivers/pci/hotplug/cpqphp.h	/^static inline int wait_for_ctrl_irq(struct controller *ctrl)$/;"	f	signature:(struct controller *ctrl)
> wait_for_db_state	drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c	/^static int wait_for_db_state(struct hinic_hwdev *hwdev)$/;"	f	signature:(struct hinic_hwdev *hwdev)
> wait_for_dc_servo	sound/soc/codecs/wm8996.c	/^static void wait_for_dc_servo(struct snd_soc_component *component, u16 mask)$/;"	f	signature:(struct snd_soc_component *component, u16 mask)
> wait_for_dc_servo	sound/soc/codecs/wm9090.c	/^static void wait_for_dc_servo(struct snd_soc_component *component)$/;"	f	signature:(struct snd_soc_component *component)
> wait_for_dc_servo	sound/soc/codecs/wm_hubs.c	/^static void wait_for_dc_servo(struct snd_soc_component *component, unsigned int op)$/;"	f	signature:(struct snd_soc_component *component, unsigned int op)
> wait_for_dest_dir_move	fs/btrfs/send.c	/^static int wait_for_dest_dir_move(struct send_ctx *sctx,$/;"	f	signature:(struct send_ctx *sctx, struct recorded_ref *parent_ref, const bool is_orphan)
> wait_for_device_probe	drivers/base/dd.c	/^void wait_for_device_probe(void)$/;"	f	signature:(void)
> wait_for_device_start	drivers/scsi/isci/host.h	/^static inline void wait_for_device_start(struct isci_host *ihost, struct isci_remote_device *idev)$/;"	f	signature:(struct isci_host *ihost, struct isci_remote_device *idev)
> wait_for_device_stop	drivers/scsi/isci/host.h	/^static inline void wait_for_device_stop(struct isci_host *ihost, struct isci_remote_device *idev)$/;"	f	signature:(struct isci_host *ihost, struct isci_remote_device *idev)
> wait_for_device_to_become_ready	drivers/scsi/hpsa.c	/^static int wait_for_device_to_become_ready(struct ctlr_info *h,$/;"	f	signature:(struct ctlr_info *h, unsigned char lunaddr[], int reply_queue)
> wait_for_devices	drivers/xen/xenbus/xenbus_probe_frontend.c	/^static void wait_for_devices(struct xenbus_driver *xendrv)$/;"	f	signature:(struct xenbus_driver *xendrv)
> wait_for_devices	net/ipv4/ipconfig.c	/^static int __init wait_for_devices(void)$/;"	f	signature:(void)
> wait_for_direct_io	fs/orangefs/file.c	/^static ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,$/;"	f	signature:(enum ORANGEFS_io_type type, struct inode *inode, loff_t *offset, struct iov_iter *iter, size_t total_size, loff_t readahead_size)
> wait_for_doorbell	drivers/isdn/hardware/avm/c4.c	/^static inline int wait_for_doorbell(avmcard *card, unsigned long t)$/;"	f	signature:(avmcard *card, unsigned long t)
> wait_for_dump_helpers	fs/coredump.c	/^static void wait_for_dump_helpers(struct file *file)$/;"	f	signature:(struct file *file)
> wait_for_engine_idle	drivers/video/fbdev/i810/i810_accel.c	/^static inline int wait_for_engine_idle(struct fb_info *info)$/;"	f	signature:(struct fb_info *info)
> wait_for_engines	drivers/gpu/drm/i915/i915_gem.c	/^static int wait_for_engines(struct drm_i915_private *i915)$/;"	f	signature:(struct drm_i915_private *i915)
> wait_for_fbc_state_changed	drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c	/^static void wait_for_fbc_state_changed($/;"	f	signature:( struct dce110_compressor *cp110, bool enabled)
> wait_for_fbc_state_changed	drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c	/^static void wait_for_fbc_state_changed($/;"	f	signature:( struct dce112_compressor *cp110, bool enabled)
> wait_for_fifo	drivers/video/fbdev/aty/aty128fb.c	/^static void wait_for_fifo(u16 entries, struct aty128fb_par *par)$/;"	f	signature:(u16 entries, struct aty128fb_par *par)
> wait_for_fifo	drivers/video/fbdev/aty/atyfb.h	/^static inline void wait_for_fifo(u16 entries, struct atyfb_par *par)$/;"	f	signature:(u16 entries, struct atyfb_par *par)
> wait_for_free	fs/orangefs/orangefs-bufmap.c	/^static int wait_for_free(struct slot_map *m)$/;"	f	signature:(struct slot_map *m)
> wait_for_free_credits	fs/cifs/transport.c	/^wait_for_free_credits(struct TCP_Server_Info *server, const int timeout,$/;"	f	signature:(struct TCP_Server_Info *server, const int timeout, int *credits)
> wait_for_free_request	fs/cifs/transport.c	/^wait_for_free_request(struct TCP_Server_Info *server, const int timeout,$/;"	f	signature:(struct TCP_Server_Info *server, const int timeout, const int optype)
> wait_for_freeze_status	drivers/infiniband/hw/hfi1/chip.c	/^static void wait_for_freeze_status(struct hfi1_devdata *dd, int freeze)$/;"	f	signature:(struct hfi1_devdata *dd, int freeze)
> wait_for_gen_fifo_empty	drivers/gpu/drm/gma500/mdfld_dsi_pkg_sender.c	/^static inline int wait_for_gen_fifo_empty(struct mdfld_dsi_pkg_sender *sender,$/;"	f	signature:(struct mdfld_dsi_pkg_sender *sender, u32 mask)
> wait_for_guc_preempt_report	drivers/gpu/drm/i915/intel_guc_submission.c	/^static void wait_for_guc_preempt_report(struct intel_engine_cs *engine)$/;"	f	signature:(struct intel_engine_cs *engine)
> wait_for_header_credits	drivers/gpu/drm/i915/icl_dsi.c	/^static void wait_for_header_credits(struct drm_i915_private *dev_priv,$/;"	f	signature:(struct drm_i915_private *dev_priv, enum transcoder dsi_trans)
> wait_for_host_ready	drivers/ata/pata_samsung_cf.c	/^static int wait_for_host_ready(struct s3c_ide_info *info)$/;"	f	signature:(struct s3c_ide_info *info)
> wait_for_host_signal	drivers/platform/goldfish/goldfish_pipe.c	/^static int wait_for_host_signal(struct goldfish_pipe *pipe, int is_write)$/;"	f	signature:(struct goldfish_pipe *pipe, int is_write)
> wait_for_hs_fifos_empty	drivers/gpu/drm/gma500/mdfld_dsi_pkg_sender.c	/^static int wait_for_hs_fifos_empty(struct mdfld_dsi_pkg_sender *sender)$/;"	f	signature:(struct mdfld_dsi_pkg_sender *sender)
> wait_for_idle	drivers/gpu/drm/i915/selftests/intel_hangcheck.c	/^static bool wait_for_idle(struct intel_engine_cs *engine)$/;"	f	signature:(struct intel_engine_cs *engine)
> wait_for_idle	drivers/net/ethernet/ti/davinci_mdio.c	/^static inline int wait_for_idle(struct davinci_mdio_data *data)$/;"	f	signature:(struct davinci_mdio_data *data)
> wait_for_idle	drivers/spi/spi-rockchip.c	/^static inline void wait_for_idle(struct rockchip_spi *rs)$/;"	f	signature:(struct rockchip_spi *rs)
> wait_for_idle	drivers/video/fbdev/aty/aty128fb.c	/^static void wait_for_idle(struct aty128fb_par *par)$/;"	f	signature:(struct aty128fb_par *par)
> wait_for_idle	drivers/video/fbdev/aty/atyfb.h	/^static inline void wait_for_idle(struct atyfb_par *par)$/;"	f	signature:(struct atyfb_par *par)
> wait_for_idle	drivers/video/fbdev/riva/fbdev.c	/^static inline void wait_for_idle(struct riva_par *par)$/;"	f	signature:(struct riva_par *par)
> wait_for_io_cmd	drivers/gpu/drm/qxl/qxl_cmd.c	/^static void wait_for_io_cmd(struct qxl_device *qdev, uint8_t val, long port)$/;"	f	signature:(struct qxl_device *qdev, uint8_t val, long port)
> wait_for_io_cmd_user	drivers/gpu/drm/qxl/qxl_cmd.c	/^static int wait_for_io_cmd_user(struct qxl_device *qdev, uint8_t val, long port, bool intr)$/;"	f	signature:(struct qxl_device *qdev, uint8_t val, long port, bool intr)
> wait_for_io_stopped	drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c	/^static int wait_for_io_stopped(struct hinic_hwdev *hwdev)$/;"	f	signature:(struct hinic_hwdev *hwdev)
> wait_for_key_construction	security/keys/request_key.c	/^int wait_for_key_construction(struct key *key, bool intr)$/;"	f	signature:(struct key *key, bool intr)
> wait_for_kprobe_optimizer	include/linux/kprobes.h	/^static inline void wait_for_kprobe_optimizer(void) { }$/;"	f	signature:(void)
> wait_for_kprobe_optimizer	kernel/kprobes.c	/^void wait_for_kprobe_optimizer(void)$/;"	f	signature:(void)
> wait_for_kthread_stop	drivers/md/bcache/bcache.h	/^static inline void wait_for_kthread_stop(void)$/;"	f	signature:(void)
> wait_for_latest_osdmap	drivers/block/rbd.c	/^static int wait_for_latest_osdmap(struct ceph_client *client)$/;"	f	signature:(struct ceph_client *client)
> wait_for_link	drivers/net/ethernet/dec/tulip/de4x5.c	/^wait_for_link(struct net_device *dev)$/;"	f	signature:(struct net_device *dev)
> wait_for_lp_fifos_empty	drivers/gpu/drm/gma500/mdfld_dsi_pkg_sender.c	/^static int wait_for_lp_fifos_empty(struct mdfld_dsi_pkg_sender *sender)$/;"	f	signature:(struct mdfld_dsi_pkg_sender *sender)
> wait_for_lps	drivers/video/fbdev/sh7760fb.c	/^static int wait_for_lps(struct sh7760fb_par *par, int val)$/;"	f	signature:(struct sh7760fb_par *par, int val)
> wait_for_master_cpu	arch/x86/kernel/cpu/common.c	/^static void wait_for_master_cpu(int cpu)$/;"	f	signature:(int cpu)
> wait_for_matching_downcall	fs/orangefs/waitqueue.c	/^static int wait_for_matching_downcall(struct orangefs_kernel_op_s *op,$/;"	f	signature:(struct orangefs_kernel_op_s *op, long timeout, bool interruptible)
> wait_for_mci_complete	drivers/media/usb/cx231xx/cx231xx-417.c	/^static int wait_for_mci_complete(struct cx231xx *dev)$/;"	f	signature:(struct cx231xx *dev)
> wait_for_mdio	drivers/net/ethernet/aeroflex/greth.c	/^static inline int wait_for_mdio(struct greth_private *greth)$/;"	f	signature:(struct greth_private *greth)
> wait_for_msg_done	drivers/char/ipmi/ipmi_si_intf.c	/^static int wait_for_msg_done(struct smi_info *smi_info)$/;"	f	signature:(struct smi_info *smi_info)
> wait_for_msix_trans	drivers/net/ethernet/neterion/s2io.c	/^static int wait_for_msix_trans(struct s2io_nic *nic, int i)$/;"	f	signature:(struct s2io_nic *nic, int i)
> wait_for_others	drivers/gpu/drm/i915/selftests/intel_hangcheck.c	/^static int wait_for_others(struct drm_i915_private *i915,$/;"	f	signature:(struct drm_i915_private *i915, struct intel_engine_cs *exclude)
> wait_for_outbound_state	drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c	/^static int wait_for_outbound_state(struct hinic_hwdev *hwdev)$/;"	f	signature:(struct hinic_hwdev *hwdev)
> wait_for_panic	arch/x86/kernel/cpu/mce/core.c	/^static void wait_for_panic(void)$/;"	f	signature:(void)
> wait_for_parent_move	fs/btrfs/send.c	/^static int wait_for_parent_move(struct send_ctx *sctx,$/;"	f	signature:(struct send_ctx *sctx, struct recorded_ref *parent_ref, const bool is_orphan)
> wait_for_partner	fs/pipe.c	/^static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cnt)$/;"	f	signature:(struct pipe_inode_info *pipe, unsigned int *cnt)
> wait_for_payload_credits	drivers/gpu/drm/i915/icl_dsi.c	/^static void wait_for_payload_credits(struct drm_i915_private *dev_priv,$/;"	f	signature:(struct drm_i915_private *dev_priv, enum transcoder dsi_trans)
> wait_for_pending_requests	drivers/net/ethernet/cavium/liquidio/octeon_network.h	/^static inline int wait_for_pending_requests(struct octeon_device *oct)$/;"	f	signature:(struct octeon_device *oct)
> wait_for_pin	drivers/i2c/algos/i2c-algo-pcf.c	/^static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status)$/;"	f	signature:(struct i2c_algo_pcf_data *adap, int *status)
> wait_for_pin	drivers/sbus/char/bbc_i2c.c	/^static int wait_for_pin(struct bbc_i2c_bus *bp, u8 *status)$/;"	f	signature:(struct bbc_i2c_bus *bp, u8 *status)
> wait_for_pipe_scanline_moving	drivers/gpu/drm/i915/intel_display.c	/^static void wait_for_pipe_scanline_moving(struct intel_crtc *crtc, bool state)$/;"	f	signature:(struct intel_crtc *crtc, bool state)
> wait_for_pll	drivers/clk/qcom/clk-alpha-pll.c	/^static int wait_for_pll(struct clk_alpha_pll *pll, u32 mask, bool inverse,$/;"	f	signature:(struct clk_alpha_pll *pll, u32 mask, bool inverse, const char *action)
> wait_for_pll	drivers/clk/qcom/clk-pll.c	/^static int wait_for_pll(struct clk_pll *pll)$/;"	f	signature:(struct clk_pll *pll)
> wait_for_qsfp_init	drivers/infiniband/hw/hfi1/chip.c	/^static void wait_for_qsfp_init(struct hfi1_pportdata *ppd)$/;"	f	signature:(struct hfi1_pportdata *ppd)
> wait_for_random_bytes	drivers/char/random.c	/^int wait_for_random_bytes(void)$/;"	f	signature:(void)
> wait_for_ready	drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c	/^static bool wait_for_ready(struct igt_wakeup *w)$/;"	f	signature:(struct igt_wakeup *w)
> wait_for_ready	drivers/mtd/lpddr/lpddr_cmds.c	/^static int wait_for_ready(struct map_info *map, struct flchip *chip,$/;"	f	signature:(struct map_info *map, struct flchip *chip, unsigned int chip_op_time)
> wait_for_reconnect	drivers/block/nbd.c	/^static int wait_for_reconnect(struct nbd_device *nbd)$/;"	f	signature:(struct nbd_device *nbd)
> wait_for_reg	drivers/phy/marvell/phy-pxa-28nm-hsic.c	/^static bool wait_for_reg(void __iomem *reg, u32 mask, unsigned long timeout)$/;"	f	signature:(void __iomem *reg, u32 mask, unsigned long timeout)
> wait_for_reg	drivers/phy/marvell/phy-pxa-28nm-usb2.c	/^static bool wait_for_reg(void __iomem *reg, u32 mask, unsigned long timeout)$/;"	f	signature:(void __iomem *reg, u32 mask, unsigned long timeout)
> wait_for_reg_status	drivers/phy/samsung/phy-exynos5250-sata.c	/^static int wait_for_reg_status(void __iomem *base, u32 reg, u32 checkbit,$/;"	f	signature:(void __iomem *base, u32 reg, u32 checkbit, u32 status)
> wait_for_reset	drivers/net/ethernet/ibm/ibmvnic.c	/^static int wait_for_reset(struct ibmvnic_adapter *adapter)$/;"	f	signature:(struct ibmvnic_adapter *adapter)
> wait_for_reset_state	drivers/net/ethernet/amazon/ena/ena_com.c	/^static int wait_for_reset_state(struct ena_com_dev *ena_dev, u32 timeout,$/;"	f	signature:(struct ena_com_dev *ena_dev, u32 timeout, u16 exp_state)
> wait_for_reset_trigger_to_occur	drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c	/^static bool wait_for_reset_trigger_to_occur($/;"	f	signature:( struct dc_context *dc_ctx, struct timing_generator *tg)
> wait_for_reset_trigger_to_occur	drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c	/^static bool wait_for_reset_trigger_to_occur($/;"	f	signature:( struct dc_context *dc_ctx, struct timing_generator *tg)
> wait_for_response	drivers/infiniband/core/mad.c	/^static void wait_for_response(struct ib_mad_send_wr_private *mad_send_wr)$/;"	f	signature:(struct ib_mad_send_wr_private *mad_send_wr)
> wait_for_response	drivers/pci/controller/pci-hyperv.c	/^static int wait_for_response(struct hv_device *hdev,$/;"	f	signature:(struct hv_device *hdev, struct completion *comp)
> wait_for_response	fs/cifs/transport.c	/^wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)$/;"	f	signature:(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
> wait_for_rx_byte	drivers/i2c/busses/i2c-au1550.c	/^static int wait_for_rx_byte(struct i2c_au1550_data *adap, unsigned char *out)$/;"	f	signature:(struct i2c_au1550_data *adap, unsigned char *out)
> wait_for_sc_completion_timeout	drivers/net/ethernet/cavium/liquidio/octeon_main.h	/^wait_for_sc_completion_timeout(struct octeon_device *oct_dev,$/;"	f	signature:(struct octeon_device *oct_dev, struct octeon_soft_command *sc, unsigned long timeout)
> wait_for_scl_high	drivers/gpu/drm/amd/display/dc/i2caux/i2c_sw_engine.c	/^static bool wait_for_scl_high($/;"	f	signature:( struct dc_context *ctx, struct ddc *ddc, uint16_t clock_delay_div_4)
> wait_for_scl_high_sw	drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c	/^static bool wait_for_scl_high_sw($/;"	f	signature:( struct dc_context *ctx, struct ddc *ddc, uint16_t clock_delay_div_4)
> wait_for_space	drivers/gpu/drm/i915/intel_ringbuffer.c	/^static noinline int wait_for_space(struct intel_ring *ring, unsigned int bytes)$/;"	f	signature:(struct intel_ring *ring, unsigned int bytes)
> wait_for_space	drivers/video/fbdev/i810/i810_accel.c	/^static inline int wait_for_space(struct fb_info *info, u32 space)$/;"	f	signature:(struct fb_info *info, u32 space)
> wait_for_space	fs/splice.c	/^static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)$/;"	f	signature:(struct pipe_inode_info *pipe, unsigned flags)
> wait_for_srst_clear	sound/pci/lola/lola_pcm.c	/^static void wait_for_srst_clear(struct lola *chip, struct lola_stream *str)$/;"	f	signature:(struct lola *chip, struct lola_stream *str)
> wait_for_stable_page	mm/page-writeback.c	/^void wait_for_stable_page(struct page *page)$/;"	f	signature:(struct page *page)
> wait_for_start	drivers/scsi/isci/host.h	/^static inline void wait_for_start(struct isci_host *ihost)$/;"	f	signature:(struct isci_host *ihost)
> wait_for_stat	drivers/char/tpm/st33zp24/st33zp24.c	/^static int wait_for_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,$/;"	f	signature:(struct tpm_chip *chip, u8 mask, unsigned long timeout, wait_queue_head_t *queue, bool check_cancel)
> wait_for_stat	drivers/char/tpm/tpm_i2c_infineon.c	/^static int wait_for_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,$/;"	f	signature:(struct tpm_chip *chip, u8 mask, unsigned long timeout, int *status)
> wait_for_stat	drivers/char/tpm/tpm_nsc.c	/^static int wait_for_stat(struct tpm_chip *chip, u8 mask, u8 val, u8 * data)$/;"	f	signature:(struct tpm_chip *chip, u8 mask, u8 val, u8 * data)
> wait_for_state	drivers/tty/hvc/hvsi.c	/^static int wait_for_state(struct hvsi_struct *hp, int state)$/;"	f	signature:(struct hvsi_struct *hp, int state)
> wait_for_states	drivers/crypto/chelsio/chtls/chtls_cm.c	/^static int wait_for_states(struct sock *sk, unsigned int states)$/;"	f	signature:(struct sock *sk, unsigned int states)
> wait_for_status_poll	drivers/net/ethernet/huawei/hinic/hinic_hw_api_cmd.c	/^static int wait_for_status_poll(struct hinic_api_cmd_chain *chain)$/;"	f	signature:(struct hinic_api_cmd_chain *chain)
> wait_for_stop	drivers/scsi/isci/host.h	/^static inline void wait_for_stop(struct isci_host *ihost)$/;"	f	signature:(struct isci_host *ihost)
> wait_for_tail	drivers/crypto/n2_core.c	/^static unsigned long wait_for_tail(struct spu_queue *qp)$/;"	f	signature:(struct spu_queue *qp)
> wait_for_timeline	drivers/gpu/drm/i915/i915_gem.c	/^static long wait_for_timeline(struct i915_timeline *tl,$/;"	f	signature:(struct i915_timeline *tl, unsigned int flags, long timeout)
> wait_for_tpm_stat	drivers/char/tpm/tpm_tis_core.c	/^static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,$/;"	f	signature:(struct tpm_chip *chip, u8 mask, unsigned long timeout, wait_queue_head_t *queue, bool check_cancel)
> wait_for_tpm_stat	drivers/char/tpm/xen-tpmfront.c	/^static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,$/;"	f	signature:(struct tpm_chip *chip, u8 mask, unsigned long timeout, wait_queue_head_t *queue, bool check_cancel)
> wait_for_tpm_stat_cond	drivers/char/tpm/st33zp24/st33zp24.c	/^static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,$/;"	f	signature:(struct tpm_chip *chip, u8 mask, bool check_cancel, bool *canceled)
> wait_for_tpm_stat_cond	drivers/char/tpm/tpm_tis_core.c	/^static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,$/;"	f	signature:(struct tpm_chip *chip, u8 mask, bool check_cancel, bool *canceled)
> wait_for_tpm_stat_cond	drivers/char/tpm/xen-tpmfront.c	/^static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,$/;"	f	signature:(struct tpm_chip *chip, u8 mask, bool check_cancel, bool *canceled)
> wait_for_training_aux_rd_interval	drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c	/^static void wait_for_training_aux_rd_interval($/;"	f	signature:( struct dc_link *link, uint32_t default_wait_in_micro_secs)
> wait_for_unix_gc	net/unix/garbage.c	/^void wait_for_unix_gc(void)$/;"	f	signature:(void)
> wait_for_user_access	drivers/net/ethernet/ti/davinci_mdio.c	/^static inline int wait_for_user_access(struct davinci_mdio_data *data)$/;"	f	signature:(struct davinci_mdio_data *data)
> wait_for_vfork_done	kernel/fork.c	/^static int wait_for_vfork_done(struct task_struct *child,$/;"	f	signature:(struct task_struct *child, struct completion *vfork)
> wait_for_vl_status_clear	drivers/infiniband/hw/hfi1/chip.c	/^static void wait_for_vl_status_clear(struct hfi1_devdata *dd, u64 mask,$/;"	f	signature:(struct hfi1_devdata *dd, u64 mask, const char *which)
> wait_for_work	drivers/block/drbd/drbd_worker.c	/^static void wait_for_work(struct drbd_connection *connection, struct list_head *work_list)$/;"	f	signature:(struct drbd_connection *connection, struct list_head *work_list)
> wait_for_writer	fs/btrfs/tree-log.c	/^static void wait_for_writer(struct btrfs_root *root)$/;"	f	signature:(struct btrfs_root *root)
> wait_for_xmit_empty	drivers/tty/serial/lpc32xx_hs.c	/^static void wait_for_xmit_empty(struct uart_port *port)$/;"	f	signature:(struct uart_port *port)
> wait_for_xmit_ready	drivers/tty/serial/lpc32xx_hs.c	/^static void wait_for_xmit_ready(struct uart_port *port)$/;"	f	signature:(struct uart_port *port)
> wait_for_xmitr	drivers/tty/serial/8250/8250_port.c	/^static void wait_for_xmitr(struct uart_8250_port *up, int bits)$/;"	f	signature:(struct uart_8250_port *up, int bits)
> wait_for_xmitr	drivers/tty/serial/bcm63xx_uart.c	/^static void wait_for_xmitr(struct uart_port *port)$/;"	f	signature:(struct uart_port *port)
> wait_for_xmitr	drivers/tty/serial/mvebu-uart.c	/^static void wait_for_xmitr(struct uart_port *port)$/;"	f	signature:(struct uart_port *port)
> wait_for_xmitr	drivers/tty/serial/omap-serial.c	/^static void __maybe_unused wait_for_xmitr(struct uart_omap_port *up)$/;"	f	signature:(struct uart_omap_port *up)
> wait_for_xmitr	drivers/tty/serial/pch_uart.c	/^static void wait_for_xmitr(struct eg20t_port *up, int bits)$/;"	f	signature:(struct eg20t_port *up, int bits)
> wait_for_xmitr	drivers/tty/serial/pxa.c	/^static void wait_for_xmitr(struct uart_pxa_port *up)$/;"	f	signature:(struct uart_pxa_port *up)
> wait_for_xmitr	drivers/tty/serial/serial_txx9.c	/^static void wait_for_xmitr(struct uart_txx9_port *up)$/;"	f	signature:(struct uart_txx9_port *up)
> wait_for_xmitr	drivers/tty/serial/sprd_serial.c	/^static void wait_for_xmitr(struct uart_port *port)$/;"	f	signature:(struct uart_port *port)
> wait_for_xmitr	drivers/tty/serial/sunsu.c	/^static void wait_for_xmitr(struct uart_sunsu_port *up)$/;"	f	signature:(struct uart_sunsu_port *up)
> wait_for_xmitr	drivers/tty/serial/vr41xx_siu.c	/^static void wait_for_xmitr(struct uart_port *port)$/;"	f	signature:(struct uart_port *port)
> wait_for_xmitr	drivers/tty/serial/vt8500_serial.c	/^static void wait_for_xmitr(struct uart_port *port)$/;"	f	signature:(struct uart_port *port)
> wait_func	drivers/net/ethernet/mellanox/mlx5/core/cmd.c	/^static int wait_func(struct mlx5_core_dev *dev, struct mlx5_cmd_work_ent *ent)$/;"	f	signature:(struct mlx5_core_dev *dev, struct mlx5_cmd_work_ent *ent)
> wait_fw_init	drivers/net/ethernet/mellanox/mlx5/core/main.c	/^static int wait_fw_init(struct mlx5_core_dev *dev, u32 max_wait_mili)$/;"	f	signature:(struct mlx5_core_dev *dev, u32 max_wait_mili)
> wait_generic_request	net/ceph/mon_client.c	/^static int wait_generic_request(struct ceph_mon_generic_request *req)$/;"	f	signature:(struct ceph_mon_generic_request *req)
> wait_gpio	drivers/tty/synclink_gt.c	/^static int wait_gpio(struct slgt_info *info, struct gpio_desc __user *user_gpio)$/;"	f	signature:(struct slgt_info *info, struct gpio_desc __user *user_gpio)
> wait_grab_pending	drivers/staging/media/zoran/zoran_device.c	/^wait_grab_pending (struct zoran *zr)$/;"	f	signature:(struct zoran *zr)
> wait_halmac_event	drivers/staging/rtlwifi/halmac/rtl_halmac.c	/^static int wait_halmac_event(struct rtl_priv *rtlpriv,$/;"	f	signature:(struct rtl_priv *rtlpriv, enum halmac_feature_id id)
> wait_handshake	sound/pci/echoaudio/echoaudio_dsp.c	/^static int wait_handshake(struct echoaudio *chip)$/;"	f	signature:(struct echoaudio *chip)
> wait_hdi_set	drivers/scsi/a100u2w.c	/^static u8 wait_hdi_set(struct orc_host * host, u8 * data)$/;"	f	signature:(struct orc_host * host, u8 * data)
> wait_i2c_busy	sound/pci/ice1712/ice1724.c	/^static void wait_i2c_busy(struct snd_ice1712 *ice)$/;"	f	signature:(struct snd_ice1712 *ice)
> wait_i2c_reg	drivers/media/pci/dt3155/dt3155.c	/^static int wait_i2c_reg(void __iomem *addr)$/;"	f	signature:(void __iomem *addr)
> wait_i2c_result	drivers/media/pci/pt3/pt3_i2c.c	/^static int wait_i2c_result(struct pt3_board *pt3, u32 *result, int max_wait)$/;"	f	signature:(struct pt3_board *pt3, u32 *result, int max_wait)
> wait_iff_congested	mm/backing-dev.c	/^long wait_iff_congested(int sync, long timeout)$/;"	f	signature:(int sync, long timeout)
> wait_instruction_complete	drivers/misc/sgi-gru/gruhandles.c	/^static int wait_instruction_complete(void *h, enum mcs_op opc)$/;"	f	signature:(void *h, enum mcs_op opc)
> wait_io_done_v2_hw	drivers/scsi/hisi_sas/hisi_sas_v2_hw.c	/^static bool wait_io_done_v2_hw(struct hisi_hba *hisi_hba, int phy_no)$/;"	f	signature:(struct hisi_hba *hisi_hba, int phy_no)
> wait_irq	drivers/gpu/drm/msm/disp/mdp_kms.c	/^static void wait_irq(struct mdp_irq *irq, uint32_t irqstatus)$/;"	f	signature:(struct mdp_irq *irq, uint32_t irqstatus)
> wait_isoch_resource_delay_after_bus_reset	sound/firewire/iso-resources.c	/^static int wait_isoch_resource_delay_after_bus_reset(struct fw_card *card)$/;"	f	signature:(struct fw_card *card)
> wait_istat	drivers/net/ethernet/i825xx/82596.c	/^static inline int wait_istat(struct net_device *dev, struct i596_private *lp, int delcnt, char *str)$/;"	f	signature:(struct net_device *dev, struct i596_private *lp, int delcnt, char *str)
> wait_istat	drivers/net/ethernet/i825xx/lib82596.c	/^static inline int wait_istat(struct net_device *dev, struct i596_dma *dma, int delcnt, char *str)$/;"	f	signature:(struct net_device *dev, struct i596_dma *dma, int delcnt, char *str)
> wait_key_set	fs/select.c	/^static inline void wait_key_set(poll_table *wait, unsigned long in,$/;"	f	signature:(poll_table *wait, unsigned long in, unsigned long out, unsigned long bit, __poll_t ll_flag)
> wait_kmem	drivers/infiniband/hw/hfi1/verbs.c	/^static int wait_kmem(struct hfi1_ibdev *dev,$/;"	f	signature:(struct hfi1_ibdev *dev, struct rvt_qp *qp, struct hfi1_pkt_state *ps)
> wait_kmem	drivers/infiniband/hw/qib/qib_verbs.c	/^static int wait_kmem(struct qib_ibdev *dev, struct rvt_qp *qp)$/;"	f	signature:(struct qib_ibdev *dev, struct rvt_qp *qp)
> wait_lapic_expire	arch/x86/kvm/lapic.c	/^void wait_lapic_expire(struct kvm_vcpu *vcpu)$/;"	f	signature:(struct kvm_vcpu *vcpu)
> wait_link_transfer_active	drivers/infiniband/hw/hfi1/chip.c	/^static int wait_link_transfer_active(struct hfi1_devdata *dd, int wait_ms)$/;"	f	signature:(struct hfi1_devdata *dd, int wait_ms)
> wait_log_commit	fs/btrfs/tree-log.c	/^static void wait_log_commit(struct btrfs_root *root, int transid)$/;"	f	signature:(struct btrfs_root *root, int transid)
> wait_logical_linkstate	drivers/infiniband/hw/hfi1/chip.c	/^static int wait_logical_linkstate(struct hfi1_pportdata *ppd, u32 state,$/;"	f	signature:(struct hfi1_pportdata *ppd, u32 state, int msecs)
> wait_loop	drivers/xen/xenbus/xenbus_probe_frontend.c	/^static bool wait_loop(unsigned long start, unsigned int max_delay,$/;"	f	signature:(unsigned long start, unsigned int max_delay, unsigned int *seconds_waited)
> wait_lpc_idle	drivers/bus/hisi_lpc.c	/^static int wait_lpc_idle(unsigned char *mbase, unsigned int waitcnt)$/;"	f	signature:(unsigned char *mbase, unsigned int waitcnt)
> wait_mask	drivers/scsi/aha1542.c	/^static inline bool wait_mask(u16 port, u8 mask, u8 allof, u8 noneof, int timeout)$/;"	f	signature:(u16 port, u8 mask, u8 allof, u8 noneof, int timeout)
> wait_master_done	drivers/i2c/busses/i2c-au1550.c	/^static int wait_master_done(struct i2c_au1550_data *adap)$/;"	f	signature:(struct i2c_au1550_data *adap)
> wait_mgsl_event	drivers/tty/synclink_gt.c	/^static int wait_mgsl_event(struct slgt_info *info, int __user *mask_ptr)$/;"	f	signature:(struct slgt_info *info, int __user *mask_ptr)
> wait_mgsl_event	drivers/tty/synclinkmp.c	/^static int wait_mgsl_event(SLMP_INFO * info, int __user *mask_ptr)$/;"	f	signature:(SLMP_INFO * info, int __user *mask_ptr)
> wait_msr_change	drivers/staging/fwserial/fwserial.c	/^static int wait_msr_change(struct fwtty_port *port, unsigned long mask)$/;"	f	signature:(struct fwtty_port *port, unsigned long mask)
> wait_nack	drivers/gpu/drm/ast/ast_dp501.c	/^static bool wait_nack(struct ast_private *ast)$/;"	f	signature:(struct ast_private *ast)
> wait_nvdimm_bus_probe_idle	drivers/nvdimm/bus.c	/^void wait_nvdimm_bus_probe_idle(struct device *dev)$/;"	f	signature:(struct device *dev)
> wait_obj_created	fs/exofs/exofs.h	/^static inline int wait_obj_created(struct exofs_i_info *oi)$/;"	f	signature:(struct exofs_i_info *oi)
> wait_on_bit	include/linux/wait_bit.h	/^wait_on_bit(unsigned long *word, int bit, unsigned mode)$/;"	f	signature:(unsigned long *word, int bit, unsigned mode)
> wait_on_bit_action	include/linux/wait_bit.h	/^wait_on_bit_action(unsigned long *word, int bit, wait_bit_action_f *action,$/;"	f	signature:(unsigned long *word, int bit, wait_bit_action_f *action, unsigned mode)
> wait_on_bit_io	include/linux/wait_bit.h	/^wait_on_bit_io(unsigned long *word, int bit, unsigned mode)$/;"	f	signature:(unsigned long *word, int bit, unsigned mode)
> wait_on_bit_lock	include/linux/wait_bit.h	/^wait_on_bit_lock(unsigned long *word, int bit, unsigned mode)$/;"	f	signature:(unsigned long *word, int bit, unsigned mode)
> wait_on_bit_lock_action	include/linux/wait_bit.h	/^wait_on_bit_lock_action(unsigned long *word, int bit, wait_bit_action_f *action,$/;"	f	signature:(unsigned long *word, int bit, wait_bit_action_f *action, unsigned mode)
> wait_on_bit_lock_io	include/linux/wait_bit.h	/^wait_on_bit_lock_io(unsigned long *word, int bit, unsigned mode)$/;"	f	signature:(unsigned long *word, int bit, unsigned mode)
> wait_on_bit_timeout	include/linux/wait_bit.h	/^wait_on_bit_timeout(unsigned long *word, int bit, unsigned mode,$/;"	f	signature:(unsigned long *word, int bit, unsigned mode, unsigned long timeout)
> wait_on_buffer	include/linux/buffer_head.h	/^static inline void wait_on_buffer(struct buffer_head *bh)$/;"	f	signature:(struct buffer_head *bh)
> wait_on_commit	fs/nfs/write.c	/^static int wait_on_commit(struct nfs_mds_commit_info *cinfo)$/;"	f	signature:(struct nfs_mds_commit_info *cinfo)
> wait_on_ctr_state	drivers/isdn/capi/kcapi.c	/^static int wait_on_ctr_state(struct capi_ctr *ctr, unsigned int state)$/;"	f	signature:(struct capi_ctr *ctr, unsigned int state)
> wait_on_dquot	fs/quota/dquot.c	/^static void wait_on_dquot(struct dquot *dquot)$/;"	f	signature:(struct dquot *dquot)
> wait_on_extent_buffer_writeback	fs/btrfs/extent_io.c	/^void wait_on_extent_buffer_writeback(struct extent_buffer *eb)$/;"	f	signature:(struct extent_buffer *eb)
> wait_on_inode	include/linux/writeback.h	/^static inline void wait_on_inode(struct inode *inode)$/;"	f	signature:(struct inode *inode)
> wait_on_journal	fs/gfs2/ops_fstype.c	/^static int wait_on_journal(struct gfs2_sbd *sdp)$/;"	f	signature:(struct gfs2_sbd *sdp)
> wait_on_page_bit	mm/filemap.c	/^void wait_on_page_bit(struct page *page, int bit_nr)$/;"	f	signature:(struct page *page, int bit_nr)
> wait_on_page_bit_common	mm/filemap.c	/^static inline int wait_on_page_bit_common(wait_queue_head_t *q,$/;"	f	signature:(wait_queue_head_t *q, struct page *page, int bit_nr, int state, enum behavior behavior)
> wait_on_page_bit_killable	mm/filemap.c	/^int wait_on_page_bit_killable(struct page *page, int bit_nr)$/;"	f	signature:(struct page *page, int bit_nr)
> wait_on_page_locked	include/linux/pagemap.h	/^static inline void wait_on_page_locked(struct page *page)$/;"	f	signature:(struct page *page)
> wait_on_page_locked_killable	include/linux/pagemap.h	/^static inline int wait_on_page_locked_killable(struct page *page)$/;"	f	signature:(struct page *page)
> wait_on_page_read	mm/filemap.c	/^static struct page *wait_on_page_read(struct page *page)$/;"	f	signature:(struct page *page)
> wait_on_page_writeback	include/linux/pagemap.h	/^static inline void wait_on_page_writeback(struct page *page)$/;"	f	signature:(struct page *page)
> wait_on_pending_writer	net/tls/tls_main.c	/^int wait_on_pending_writer(struct sock *sk, long *timeo)$/;"	f	signature:(struct sock *sk, long *timeo)
> wait_on_pipe	kernel/trace/trace.c	/^static int wait_on_pipe(struct trace_iterator *iter, int full)$/;"	f	signature:(struct trace_iterator *iter, int full)
> wait_on_sem	drivers/iommu/amd_iommu.c	/^static int wait_on_sem(volatile u64 *sem)$/;"	f	signature:(volatile u64 *sem)
> wait_on_state	fs/btrfs/extent_io.c	/^static void wait_on_state(struct extent_io_tree *tree,$/;"	f	signature:(struct extent_io_tree *tree, struct extent_state *state)
> wait_op_done	drivers/mtd/nand/raw/mxc_nand.c	/^static int wait_op_done(struct mxc_nand_host *host, int useirq)$/;"	f	signature:(struct mxc_nand_host *host, int useirq)
> wait_panel_off	drivers/gpu/drm/i915/intel_dp.c	/^static void wait_panel_off(struct intel_dp *intel_dp)$/;"	f	signature:(struct intel_dp *intel_dp)
> wait_panel_on	drivers/gpu/drm/i915/intel_dp.c	/^static void wait_panel_on(struct intel_dp *intel_dp)$/;"	f	signature:(struct intel_dp *intel_dp)
> wait_panel_power_cycle	drivers/gpu/drm/i915/intel_dp.c	/^static void wait_panel_power_cycle(struct intel_dp *intel_dp)$/;"	f	signature:(struct intel_dp *intel_dp)
> wait_panel_status	drivers/gpu/drm/i915/intel_dp.c	/^static void wait_panel_status(struct intel_dp *intel_dp,$/;"	f	signature:(struct intel_dp *intel_dp, u32 mask, u32 value)
> wait_pending_extra_info_updates	drivers/video/fbdev/omap2/omapfb/dss/apply.c	/^static void wait_pending_extra_info_updates(void)$/;"	f	signature:(void)
> wait_pending_remove	fs/dlm/lock.c	/^static void wait_pending_remove(struct dlm_rsb *r)$/;"	f	signature:(struct dlm_rsb *r)
> wait_phy_eeprom_ready	drivers/net/usb/sr9700.c	/^static int wait_phy_eeprom_ready(struct usbnet *dev, int phy)$/;"	f	signature:(struct usbnet *dev, int phy)
> wait_phy_ready	drivers/net/ethernet/microchip/enc28j60.c	/^static int wait_phy_ready(struct enc28j60_net *priv)$/;"	f	signature:(struct enc28j60_net *priv)
> wait_phys_link_offline_substates	drivers/infiniband/hw/hfi1/chip.c	/^static int wait_phys_link_offline_substates(struct hfi1_pportdata *ppd,$/;"	f	signature:(struct hfi1_pportdata *ppd, int msecs)
> wait_phys_link_out_of_offline	drivers/infiniband/hw/hfi1/chip.c	/^static int wait_phys_link_out_of_offline(struct hfi1_pportdata *ppd,$/;"	f	signature:(struct hfi1_pportdata *ppd, int msecs)
> wait_physical_linkstate	drivers/infiniband/hw/hfi1/chip.c	/^static int wait_physical_linkstate(struct hfi1_pportdata *ppd, u32 state,$/;"	f	signature:(struct hfi1_pportdata *ppd, u32 state, int msecs)
> wait_port_offline	drivers/scsi/cxlflash/main.c	/^static bool wait_port_offline(__be64 __iomem *fc_regs, u32 delay_us, u32 nretry)$/;"	f	signature:(__be64 __iomem *fc_regs, u32 delay_us, u32 nretry)
> wait_port_online	drivers/scsi/cxlflash/main.c	/^static bool wait_port_online(__be64 __iomem *fc_regs, u32 delay_us, u32 nretry)$/;"	f	signature:(__be64 __iomem *fc_regs, u32 delay_us, u32 nretry)
> wait_port_reset	drivers/scsi/isci/port.c	/^static void wait_port_reset(struct isci_host *ihost, struct isci_port *iport)$/;"	f	signature:(struct isci_host *ihost, struct isci_port *iport)
> wait_port_writable	drivers/char/virtio_console.c	/^static int wait_port_writable(struct port *port, bool nonblock)$/;"	f	signature:(struct port *port, bool nonblock)
> wait_probe_show	drivers/nvdimm/core.c	/^static ssize_t wait_probe_show(struct device *dev,$/;"	f	signature:(struct device *dev, struct device_attribute *attr, char *buf)
> wait_rcu_exp_gp	kernel/rcu/tree_exp.h	/^static void wait_rcu_exp_gp(struct work_struct *wp)$/;"	f	signature:(struct work_struct *wp)
> wait_read	drivers/hwmon/applesmc.c	/^static int wait_read(void)$/;"	f	signature:(void)
> wait_read_barrier	drivers/md/raid1.c	/^static void wait_read_barrier(struct r1conf *conf, sector_t sector_nr)$/;"	f	signature:(struct r1conf *conf, sector_t sector_nr)
> wait_ready_gpio0_bit1	drivers/media/pci/cx88/cx88-blackbird.c	/^static int wait_ready_gpio0_bit1(struct cx88_core *core, u32 state)$/;"	f	signature:(struct cx88_core *core, u32 state)
> wait_recfifo_ready	drivers/mtd/nand/raw/sh_flctl.c	/^static enum flctl_ecc_res_t wait_recfifo_ready$/;"	f	signature:(struct sh_flctl *flctl, int sector_number)
> wait_reg_mask	drivers/media/dvb-frontends/lgs8gxx.c	/^static int wait_reg_mask(struct lgs8gxx_state *priv, u8 reg, u8 mask,$/;"	f	signature:(struct lgs8gxx_state *priv, u8 reg, u8 mask, u8 val, u8 delay, u8 tries)
> wait_remaining_ms_from_jiffies	drivers/gpu/drm/i915/i915_drv.h	/^wait_remaining_ms_from_jiffies(unsigned long timestamp_jiffies, int to_wait_ms)$/;"	f	signature:(unsigned long timestamp_jiffies, int to_wait_ms)
> wait_request_timeout	net/ceph/osd_client.c	/^static int wait_request_timeout(struct ceph_osd_request *req,$/;"	f	signature:(struct ceph_osd_request *req, unsigned long timeout)
> wait_requests	fs/ceph/mds_client.c	/^static void wait_requests(struct ceph_mds_client *mdsc)$/;"	f	signature:(struct ceph_mds_client *mdsc)
> wait_reserve_ticket	fs/btrfs/extent-tree.c	/^static int wait_reserve_ticket(struct btrfs_fs_info *fs_info,$/;"	f	signature:(struct btrfs_fs_info *fs_info, struct btrfs_space_info *space_info, struct reserve_ticket *ticket, u64 orig_bytes)
> wait_reset	drivers/i2c/busses/i2c-pnx.c	/^static inline int wait_reset(struct i2c_pnx_algo_data *data)$/;"	f	signature:(struct i2c_pnx_algo_data *data)
> wait_resp	drivers/scsi/cxlflash/main.c	/^static int wait_resp(struct afu *afu, struct afu_cmd *cmd)$/;"	f	signature:(struct afu *afu, struct afu_cmd *cmd)
> wait_rfifo_ready	drivers/mtd/nand/raw/sh_flctl.c	/^static void wait_rfifo_ready(struct sh_flctl *flctl)$/;"	f	signature:(struct sh_flctl *flctl)
> wait_ring	drivers/video/fbdev/intelfb/intelfbhw.c	/^static int wait_ring(struct intelfb_info *dinfo, int n)$/;"	f	signature:(struct intelfb_info *dinfo, int n)
> wait_sample	drivers/gpu/drm/msm/msm_perf.c	/^static int wait_sample(struct msm_perf_state *perf)$/;"	f	signature:(struct msm_perf_state *perf)
> wait_sb_inodes	fs/fs-writeback.c	/^static void wait_sb_inodes(struct super_block *sb)$/;"	f	signature:(struct super_block *sb)
> wait_scsi_reset_done	drivers/scsi/a100u2w.c	/^static u8 wait_scsi_reset_done(struct orc_host * host)$/;"	f	signature:(struct orc_host * host)
> wait_serial_change	drivers/staging/greybus/uart.c	/^static int wait_serial_change(struct gb_tty *gb_tty, unsigned long arg)$/;"	f	signature:(struct gb_tty *gb_tty, unsigned long arg)
> wait_serial_change	drivers/usb/class/cdc-acm.c	/^static int wait_serial_change(struct acm *acm, unsigned long arg)$/;"	f	signature:(struct acm *acm, unsigned long arg)
> wait_session_msg	drivers/media/platform/qcom/venus/hfi.c	/^static int wait_session_msg(struct venus_inst *inst)$/;"	f	signature:(struct venus_inst *inst)
> wait_skb_queue_empty	drivers/net/usb/usbnet.c	/^static void wait_skb_queue_empty(struct sk_buff_head *q)$/;"	f	signature:(struct sk_buff_head *q)
> wait_startup	drivers/char/tpm/tpm_tis_core.c	/^static int wait_startup(struct tpm_chip *chip, int l)$/;"	f	signature:(struct tpm_chip *chip, int l)
> wait_status	drivers/gpu/drm/omapdrm/omap_dmm_tiler.c	/^static int wait_status(struct refill_engine *engine, u32 wait_mask)$/;"	f	signature:(struct refill_engine *engine, u32 wait_mask)
> wait_status	fs/dlm/recover.c	/^static int wait_status(struct dlm_ls *ls, uint32_t status)$/;"	f	signature:(struct dlm_ls *ls, uint32_t status)
> wait_status_0	drivers/media/usb/gspca/spca1528.c	/^static void wait_status_0(struct gspca_dev *gspca_dev)$/;"	f	signature:(struct gspca_dev *gspca_dev)
> wait_status_1	drivers/media/usb/gspca/spca1528.c	/^static void wait_status_1(struct gspca_dev *gspca_dev)$/;"	f	signature:(struct gspca_dev *gspca_dev)
> wait_status_all	fs/dlm/recover.c	/^static int wait_status_all(struct dlm_ls *ls, uint32_t wait_status,$/;"	f	signature:(struct dlm_ls *ls, uint32_t wait_status, int save_slots)
> wait_status_low	fs/dlm/recover.c	/^static int wait_status_low(struct dlm_ls *ls, uint32_t wait_status,$/;"	f	signature:(struct dlm_ls *ls, uint32_t wait_status, uint32_t status_flags)
> wait_task_continued	kernel/exit.c	/^static int wait_task_continued(struct wait_opts *wo, struct task_struct *p)$/;"	f	signature:(struct wait_opts *wo, struct task_struct *p)
> wait_task_inactive	include/linux/sched.h	/^static inline unsigned long wait_task_inactive(struct task_struct *p, long match_state)$/;"	f	signature:(struct task_struct *p, long match_state)
> wait_task_inactive	kernel/sched/core.c	/^unsigned long wait_task_inactive(struct task_struct *p, long match_state)$/;"	f	signature:(struct task_struct *p, long match_state)
> wait_task_stopped	kernel/exit.c	/^static int wait_task_stopped(struct wait_opts *wo,$/;"	f	signature:(struct wait_opts *wo, int ptrace, struct task_struct *p)
> wait_task_zombie	kernel/exit.c	/^static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)$/;"	f	signature:(struct wait_opts *wo, struct task_struct *p)
> wait_tb_buffers_until_unlocked	fs/reiserfs/fix_node.c	/^static int wait_tb_buffers_until_unlocked(struct tree_balance *tb)$/;"	f	signature:(struct tree_balance *tb)
> wait_til_done	drivers/block/floppy.c	/^static int wait_til_done(void (*handler)(void), bool interruptible)$/;"	f	signature:(void (*handler)(void), bool interruptible)
> wait_til_ready	drivers/block/floppy.c	/^static int wait_til_ready(void)$/;"	f	signature:(void)
> wait_till_cmd_acked	sound/pci/cs5535audio/cs5535audio.c	/^static void wait_till_cmd_acked(struct cs5535audio *cs5535au, unsigned long timeout)$/;"	f	signature:(struct cs5535audio *cs5535au, unsigned long timeout)
> wait_till_fw_empty	drivers/scsi/megaraid/megaraid_mbox.c	/^wait_till_fw_empty(adapter_t *adapter)$/;"	f	signature:(adapter_t *adapter)
> wait_timeout	drivers/gpu/drm/i915/intel_breadcrumbs.c	/^static unsigned long wait_timeout(void)$/;"	f	signature:(void)
> wait_timeout	drivers/i2c/busses/i2c-pnx.c	/^static inline int wait_timeout(struct i2c_pnx_algo_data *data)$/;"	f	signature:(struct i2c_pnx_algo_data *data)
> wait_timeout	drivers/net/appletalk/ltpc.c	/^static int wait_timeout(struct net_device *dev, int c)$/;"	f	signature:(struct net_device *dev, int c)
> wait_to_die	kernel/trace/ring_buffer_benchmark.c	/^static void wait_to_die(void)$/;"	f	signature:(void)
> wait_transaction_complete	drivers/acpi/sbshc.c	/^static int wait_transaction_complete(struct acpi_smb_hc *hc, int timeout)$/;"	f	signature:(struct acpi_smb_hc *hc, int timeout)
> wait_transaction_locked	fs/jbd2/transaction.c	/^static void wait_transaction_locked(journal_t *journal)$/;"	f	signature:(journal_t *journal)
> wait_transaction_switching	fs/jbd2/transaction.c	/^static void wait_transaction_switching(journal_t *journal)$/;"	f	signature:(journal_t *journal)
> wait_tulip	drivers/scsi/initio.c	/^static int wait_tulip(struct initio_host * host)$/;"	f	signature:(struct initio_host * host)
> wait_unsafe_requests	fs/ceph/mds_client.c	/^static void wait_unsafe_requests(struct ceph_mds_client *mdsc, u64 want_tid)$/;"	f	signature:(struct ceph_mds_client *mdsc, u64 want_tid)
> wait_until_divider_stable	drivers/clk/samsung/clk-cpu.c	/^static void wait_until_divider_stable(void __iomem *div_reg, unsigned long mask)$/;"	f	signature:(void __iomem *div_reg, unsigned long mask)
> wait_until_done_or_force_detached	drivers/block/drbd/drbd_actlog.c	/^void wait_until_done_or_force_detached(struct drbd_device *device, struct drbd_backing_dev *bdev,$/;"	f	signature:(struct drbd_device *device, struct drbd_backing_dev *bdev, unsigned int *done)
> wait_until_mux_stable	drivers/clk/samsung/clk-cpu.c	/^static void wait_until_mux_stable(void __iomem *mux_reg, u32 mux_pos,$/;"	f	signature:(void __iomem *mux_reg, u32 mux_pos, unsigned long mux_value)
> wait_until_not_busy	drivers/fpga/machxo2-spi.c	/^static int wait_until_not_busy(struct spi_device *spi)$/;"	f	signature:(struct spi_device *spi)
> wait_until_running	drivers/gpu/drm/i915/selftests/intel_hangcheck.c	/^static bool wait_until_running(struct hang *h, struct i915_request *rq)$/;"	f	signature:(struct hang *h, struct i915_request *rq)
> wait_until_sent	drivers/tty/synclink_gt.c	/^static void wait_until_sent(struct tty_struct *tty, int timeout)$/;"	f	signature:(struct tty_struct *tty, int timeout)
> wait_until_sent	drivers/tty/synclinkmp.c	/^static void wait_until_sent(struct tty_struct *tty, int timeout)$/;"	f	signature:(struct tty_struct *tty, int timeout)
> wait_uwire_csr_flag	drivers/spi/spi-omap-uwire.c	/^static int wait_uwire_csr_flag(u16 mask, u16 val, int might_not_catch)$/;"	f	signature:(u16 mask, u16 val, int might_not_catch)
> wait_vdqcr_start	drivers/soc/fsl/qbman/qman.c	/^static int wait_vdqcr_start(struct qman_portal **p, struct qman_fq *fq,$/;"	f	signature:(struct qman_portal **p, struct qman_fq *fq, u32 vdqcr, u32 flags)
> wait_vital	drivers/net/ethernet/mellanox/mlx5/core/main.c	/^static int wait_vital(struct pci_dev *pdev)$/;"	f	signature:(struct pci_dev *pdev)
> wait_warn	drivers/mtd/nand/onenand/omap2.c	/^static void wait_warn(char *msg, int state, unsigned int ctrl,$/;"	f	signature:(char *msg, int state, unsigned int ctrl, unsigned int intr)
> wait_wecfifo_ready	drivers/mtd/nand/raw/sh_flctl.c	/^static void wait_wecfifo_ready(struct sh_flctl *flctl)$/;"	f	signature:(struct sh_flctl *flctl)
> wait_wfifo_ready	drivers/mtd/nand/raw/sh_flctl.c	/^static void wait_wfifo_ready(struct sh_flctl *flctl)$/;"	f	signature:(struct sh_flctl *flctl)
> wait_while_offlining	mm/ksm.c	/^static void wait_while_offlining(void)$/;"	f	signature:(void)
> wait_woken	kernel/sched/wait.c	/^long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)$/;"	f	signature:(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
> wait_xfer_done	drivers/i2c/busses/i2c-au1550.c	/^static int wait_xfer_done(struct i2c_au1550_data *adap)$/;"	f	signature:(struct i2c_au1550_data *adap)
> waitbusy	drivers/net/wireless/cisco/airo.c	/^static int waitbusy (struct airo_info *ai) {$/;"	f	signature:(struct airo_info *ai)
> waitdebi	drivers/media/pci/ttpci/av7110_hw.c	/^static int waitdebi(struct av7110 *av7110, int adr, int state)$/;"	f	signature:(struct av7110 *av7110, int adr, int state)
> waiter_needs_recovery	fs/dlm/lock.c	/^static int waiter_needs_recovery(struct dlm_ls *ls, struct dlm_lkb *lkb,$/;"	f	signature:(struct dlm_ls *ls, struct dlm_lkb *lkb, int dir_nodeid)
> waiter_release	drivers/gpu/host1x/intr.c	/^static void waiter_release(struct kref *kref)$/;"	f	signature:(struct kref *kref)
> waiters_read	fs/dlm/debug_fs.c	/^static ssize_t waiters_read(struct file *file, char __user *userbuf,$/;"	f	signature:(struct file *file, char __user *userbuf, size_t count, loff_t *ppos)
> waitforCEC	drivers/isdn/hardware/mISDN/mISDNipac.c	/^waitforCEC(struct hscx_hw *hx)$/;"	f	signature:(struct hscx_hw *hx)
> waitforCEC	drivers/isdn/hisax/hscx_irq.c	/^waitforCEC(struct IsdnCardState *cs, int hscx)$/;"	f	signature:(struct IsdnCardState *cs, int hscx)
> waitforCEC	drivers/isdn/hisax/jade_irq.c	/^waitforCEC(struct IsdnCardState *cs, int jade, int reg)$/;"	f	signature:(struct IsdnCardState *cs, int jade, int reg)
> waitforHIA	drivers/isdn/hardware/mISDN/mISDNisar.c	/^waitforHIA(struct isar_hw *isar, int timeout)$/;"	f	signature:(struct isar_hw *isar, int timeout)
> waitforHIA	drivers/isdn/hisax/isar.c	/^waitforHIA(struct IsdnCardState *cs, int timeout)$/;"	f	signature:(struct IsdnCardState *cs, int timeout)
> waitforXFW	drivers/isdn/hardware/mISDN/mISDNipac.c	/^waitforXFW(struct hscx_hw *hx)$/;"	f	signature:(struct hscx_hw *hx)
> waitforXFW	drivers/isdn/hisax/hscx_irq.c	/^waitforXFW(struct IsdnCardState *cs, int hscx)$/;"	f	signature:(struct IsdnCardState *cs, int hscx)
> waitforXFW	drivers/isdn/hisax/jade_irq.c	/^waitforXFW(struct IsdnCardState *cs, int jade)$/;"	f	signature:(struct IsdnCardState *cs, int jade)
> waitfor_idle	drivers/atm/idt77252.c	/^waitfor_idle(struct idt77252_dev *card)$/;"	f	signature:(struct idt77252_dev *card)
> waiting_process_next	drivers/scsi/dc395x.c	/^static void waiting_process_next(struct AdapterCtlBlk *acb)$/;"	f	signature:(struct AdapterCtlBlk *acb)
> waiting_set_timer	drivers/scsi/dc395x.c	/^static void waiting_set_timer(struct AdapterCtlBlk *acb, unsigned long to)$/;"	f	signature:(struct AdapterCtlBlk *acb, unsigned long to)
> waiting_timeout	drivers/scsi/dc395x.c	/^static void waiting_timeout(struct timer_list *t)$/;"	f	signature:(struct timer_list *t)
> waitqueue_active	include/linux/wait.h	/^static inline int waitqueue_active(struct wait_queue_head *wq_head)$/;"	f	signature:(struct wait_queue_head *wq_head)
> waitrecmsg	drivers/isdn/hisax/isar.c	/^waitrecmsg(struct IsdnCardState *cs, u_char *len,$/;"	f	signature:(struct IsdnCardState *cs, u_char *len, u_char *msg, int maxdelay)
>
>
>
>
> > > Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> > > Cc: Logan Gunthorpe <logang@deltatee.com>
> > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> > > ---
> > >  scripts/coccinelle/api/stream_open.cocci | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
> > > index 350145da7669..12ce18fa6b74 100644
> > > --- a/scripts/coccinelle/api/stream_open.cocci
> > > +++ b/scripts/coccinelle/api/stream_open.cocci
> > > @@ -35,11 +35,11 @@ type loff_t;
> > >  // a function that blocks
> > >  @ blocks @
> > >  identifier block_f;
> > > -identifier wait_event =~ "^wait_event_.*";
> > > +identifier wait =~ "^wait_.*";
> > >  @@
> > >    block_f(...) {
> > >      ... when exists
> > > -    wait_event(...)
> > > +    wait(...)
> > >      ... when exists
> > >    }
> > >
> > > @@ -49,12 +49,12 @@ identifier wait_event =~ "^wait_event_.*";
> > >  // XXX currently reader_blocks supports only direct and 1-level indirect cases.
> > >  @ reader_blocks_direct @
> > >  identifier stream_reader.readstream;
> > > -identifier wait_event =~ "^wait_event_.*";
> > > +identifier wait =~ "^wait_.*";
> > >  @@
> > >    readstream(...)
> > >    {
> > >      ... when exists
> > > -    wait_event(...)
> > > +    wait(...)
> > >      ... when exists
> > >    }
> > >
> > > --
> > > 2.20.1
> > >
>
