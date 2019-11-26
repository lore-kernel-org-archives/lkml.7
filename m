Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31BFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D062071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfKZVLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:11:53 -0500
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:56829 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726033AbfKZVLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 16:11:53 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9DC605839;
        Tue, 26 Nov 2019 21:11:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: magic54_663b29c08ec56
X-Filterd-Recvd-Size: 36568
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 Nov 2019 21:11:42 +0000 (UTC)
Message-ID: <1e2aaf2e0828757a327697dbdb8f1c00568dc032.camel@perches.com>
Subject: trivial script to reformat malformed struct definitions
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Nov 2019 13:11:14 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several struct definitions in include/
that use the form

struct foo
{
	...
};

instead of the typical

struct foo {
	...
};

This non-standard form makes it difficult to grep for
struct definitions.

The trivial script below standardizes the form.
Can you run it one day after immediately before
an rc1 release?

$ git grep --name-only -P '^[ \t]*struct\s+\w+[ \t]*$' include | \
  xargs perl -i -e 'local $/; while (<>) { s/(\n[ \t]*struct[ \t]+\w+)[ \t]*\n[ \t]*\{[ \t]*\n/$1 {\n/g; print; }'

This currently creates in -next:
---
 include/asm-generic/extable.h                  |  3 +-
 include/asm-generic/module.h                   |  3 +-
 include/linux/cdrom.h                          |  6 ++--
 include/linux/dtlk.h                           |  3 +-
 include/linux/elevator.h                       |  6 ++--
 include/linux/elfcore-compat.h                 |  9 ++----
 include/linux/if_frad.h                        |  9 ++----
 include/linux/input/cy8ctmg110_pdata.h         |  3 +-
 include/linux/interrupt.h                      |  6 ++--
 include/linux/jbd2.h                           |  9 ++----
 include/linux/libata.h                         |  3 +-
 include/linux/lockd/xdr.h                      |  3 +-
 include/linux/mbus.h                           |  3 +-
 include/linux/moduleparam.h                    |  3 +-
 include/linux/n_r3964.h                        |  3 +-
 include/linux/parport_pc.h                     |  3 +-
 include/linux/pid.h                            |  3 +-
 include/linux/pktcdvd.h                        | 24 ++++++----------
 include/linux/pmu.h                            |  3 +-
 include/linux/relay.h                          |  9 ++----
 include/linux/sungem_phy.h                     |  9 ++----
 include/linux/textsearch.h                     |  9 ++----
 include/linux/textsearch_fsm.h                 |  3 +-
 include/media/drv-intf/saa7146.h               |  9 ++----
 include/media/drv-intf/saa7146_vv.h            |  9 ++----
 include/media/v4l2-dev.h                       |  3 +-
 include/scsi/sg.h                              |  3 +-
 include/sound/wavefront.h                      | 18 ++++--------
 include/uapi/linux/a.out.h                     |  3 +-
 include/uapi/linux/acct.h                      |  6 ++--
 include/uapi/linux/cdrom.h                     | 39 +++++++++-----------------
 include/uapi/linux/coff.h                      |  3 +-
 include/uapi/linux/elfcore.h                   |  9 ++----
 include/uapi/linux/gsmmux.h                    |  3 +-
 include/uapi/linux/if_frad.h                   |  6 ++--
 include/uapi/linux/ipc.h                       |  3 +-
 include/uapi/linux/jffs2.h                     | 15 ++++------
 include/uapi/linux/netfilter_arp/arp_tables.h  |  3 +-
 include/uapi/linux/netfilter_arp/arpt_mangle.h |  3 +-
 include/uapi/linux/netfilter_bridge/ebt_arp.h  |  3 +-
 include/uapi/linux/raw.h                       |  3 +-
 include/uapi/linux/termios.h                   |  3 +-
 include/uapi/linux/uio.h                       |  3 +-
 include/xen/grant_table.h                      |  3 +-
 include/xen/interface/io/xs_wire.h             |  6 ++--
 include/xen/xenbus.h                           |  9 ++----
 46 files changed, 100 insertions(+), 200 deletions(-)

diff --git a/include/asm-generic/extable.h b/include/asm-generic/extable.h
index f9618b..2c2864d 100644
--- a/include/asm-generic/extable.h
+++ b/include/asm-generic/extable.h
@@ -15,8 +15,7 @@
  * on our cache or tlb entries.
  */
 
-struct exception_table_entry
-{
+struct exception_table_entry {
 	unsigned long insn, fixup;
 };
 
diff --git a/include/asm-generic/module.h b/include/asm-generic/module.h
index 98e1541..ea4d81 100644
--- a/include/asm-generic/module.h
+++ b/include/asm-generic/module.h
@@ -7,8 +7,7 @@
  * loader without arch specific data.
  */
 #ifndef CONFIG_HAVE_MOD_ARCH_SPECIFIC
-struct mod_arch_specific
-{
+struct mod_arch_specific {
 };
 #endif
 
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 528271..e4d8ee 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -16,8 +16,7 @@
 #include <scsi/scsi_common.h>
 #include <uapi/linux/cdrom.h>
 
-struct packet_command
-{
+struct packet_command {
 	unsigned char 		cmd[CDROM_PACKET_SIZE];
 	unsigned char 		*buffer;
 	unsigned int 		buflen;
@@ -232,8 +231,7 @@ typedef struct {
 	__u8 subhdr3;
 } __attribute__((packed)) write_param_page;
 
-struct modesel_head
-{
+struct modesel_head {
 	__u8	reserved1;
 	__u8	medium;
 	__u8	reserved2;
diff --git a/include/linux/dtlk.h b/include/linux/dtlk.h
index 27b95e7..df72a1 100644
--- a/include/linux/dtlk.h
+++ b/include/linux/dtlk.h
@@ -62,8 +62,7 @@
 				   TS is also 1).  */
 
 				/* data returned by Interrogate command */
-struct dtlk_settings
-{
+struct dtlk_settings {
   unsigned short serial_number;	/* 0-7Fh:0-7Fh */
   unsigned char rom_version[24]; /* null terminated string */
   unsigned char mode;		/* 0=Character; 1=Phoneme; 2=Text */
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 901bda..6424f0 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -63,8 +63,7 @@ struct elv_fs_entry {
 /*
  * identifies an elevator type, such as AS or deadline
  */
-struct elevator_type
-{
+struct elevator_type {
 	/* managed by elevator core */
 	struct kmem_cache *icq_cache;
 
@@ -98,8 +97,7 @@ struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
 /*
  * each queue has an elevator_queue associated with it
  */
-struct elevator_queue
-{
+struct elevator_queue {
 	struct elevator_type *type;
 	void *elevator_data;
 	struct kobject kobj;
diff --git a/include/linux/elfcore-compat.h b/include/linux/elfcore-compat.h
index 7a37f4c..cd1f1d 100644
--- a/include/linux/elfcore-compat.h
+++ b/include/linux/elfcore-compat.h
@@ -10,15 +10,13 @@
  * Make sure these layouts match the linux/elfcore.h native definitions.
  */
 
-struct compat_elf_siginfo
-{
+struct compat_elf_siginfo {
 	compat_int_t			si_signo;
 	compat_int_t			si_code;
 	compat_int_t			si_errno;
 };
 
-struct compat_elf_prstatus
-{
+struct compat_elf_prstatus {
 	struct compat_elf_siginfo	pr_info;
 	short				pr_cursig;
 	compat_ulong_t			pr_sigpend;
@@ -39,8 +37,7 @@ struct compat_elf_prstatus
 	compat_int_t			pr_fpvalid;
 };
 
-struct compat_elf_prpsinfo
-{
+struct compat_elf_prpsinfo {
 	char				pr_state;
 	char				pr_sname;
 	char				pr_zomb;
diff --git a/include/linux/if_frad.h b/include/linux/if_frad.h
index 52224d..6fcdd9 100644
--- a/include/linux/if_frad.h
+++ b/include/linux/if_frad.h
@@ -25,8 +25,7 @@
 #if defined(CONFIG_DLCI) || defined(CONFIG_DLCI_MODULE)
 
 /* these are the fields of an RFC 1490 header */
-struct frhdr
-{
+struct frhdr {
    unsigned char  control;
 
    /* for IP packets, this can be the NLPID */
@@ -48,8 +47,7 @@ struct frhdr
 #define FRAD_P_CLNP		0x81
 #define FRAD_P_IP		0xCC
 
-struct dlci_local
-{
+struct dlci_local {
    struct net_device      *master;
    struct net_device      *slave;
    struct dlci_conf       config;
@@ -60,8 +58,7 @@ struct dlci_local
    void              (*receive)(struct sk_buff *skb, struct net_device *);
 };
 
-struct frad_local
-{
+struct frad_local {
    /* devices which this FRAD is slaved to */
    struct net_device     *master[CONFIG_DLCI_MAX];
    short             dlci[CONFIG_DLCI_MAX];
diff --git a/include/linux/input/cy8ctmg110_pdata.h b/include/linux/input/cy8ctmg110_pdata.h
index 77582ae..831a2e 100644
--- a/include/linux/input/cy8ctmg110_pdata.h
+++ b/include/linux/input/cy8ctmg110_pdata.h
@@ -2,8 +2,7 @@
 #ifndef _LINUX_CY8CTMG110_PDATA_H
 #define _LINUX_CY8CTMG110_PDATA_H
 
-struct cy8ctmg110_pdata
-{
+struct cy8ctmg110_pdata {
 	int reset_pin;		/* Reset pin is wired to this GPIO (optional) */
 	int irq_pin;		/* IRQ pin is wired to this GPIO */
 };
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c5fe60..69def87 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -550,8 +550,7 @@ extern const char * const softirq_to_name[NR_SOFTIRQS];
  * asm/hardirq.h to get better cache usage.  KAO
  */
 
-struct softirq_action
-{
+struct softirq_action {
 	void	(*action)(struct softirq_action *);
 };
 
@@ -601,8 +600,7 @@ static inline struct task_struct *this_cpu_ksoftirqd(void)
      he makes it with spinlocks.
  */
 
-struct tasklet_struct
-{
+struct tasklet_struct {
 	struct tasklet_struct *next;
 	unsigned long state;
 	atomic_t count;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 29dce6..362d1a 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -477,8 +477,7 @@ struct jbd2_revoke_table_s;
  * in so it can be fixed later.
  */
 
-struct jbd2_journal_handle
-{
+struct jbd2_journal_handle {
 	union {
 		transaction_t	*h_transaction;
 		/* Which journal handle belongs to - used iff h_reserved set */
@@ -553,8 +552,7 @@ struct transaction_chp_stats_s {
  *
  */
 
-struct transaction_s
-{
+struct transaction_s {
 	/* Pointer to the journal for this transaction. [no locking] */
 	journal_t		*t_journal;
 
@@ -750,8 +748,7 @@ jbd2_time_diff(unsigned long start, unsigned long end)
  * struct journal_s - The journal_s type is the concrete type associated with
  *     journal_t.
  */
-struct journal_s
-{
+struct journal_s {
 	/**
 	 * @j_flags: General journaling state flags [j_state_lock]
 	 */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d3bbfdd..87bcf8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -766,8 +766,7 @@ struct ata_eh_context {
 	unsigned long		last_reset;
 };
 
-struct ata_acpi_drive
-{
+struct ata_acpi_drive {
 	u32 pio;
 	u32 dma;
 } __packed;
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index 7ab9f26..93be79 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -50,8 +50,7 @@ struct nlm_lock {
  *	32 bytes.
  */
  
-struct nlm_cookie
-{
+struct nlm_cookie {
 	unsigned char data[NLM_MAXCOOKIELEN];
 	unsigned int len;
 };
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index 4773145..accce3d 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -15,8 +15,7 @@
 
 struct resource;
 
-struct mbus_dram_target_info
-{
+struct mbus_dram_target_info {
 	/*
 	 * The 4-bit MBUS target ID of the DRAM controller.
 	 */
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index e5c3e23..4053f9 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -89,8 +89,7 @@ struct kparam_string {
 };
 
 /* Special one for arrays */
-struct kparam_array
-{
+struct kparam_array {
 	unsigned int max;
 	unsigned int elemsize;
 	unsigned int *num;
diff --git a/include/linux/n_r3964.h b/include/linux/n_r3964.h
index 90a803a..5f9b7d8 100644
--- a/include/linux/n_r3964.h
+++ b/include/linux/n_r3964.h
@@ -114,8 +114,7 @@ struct r3964_message {
  * Header of received block in rx_buf/tx_buf:
  */
 
-struct r3964_block_header 
-{
+struct r3964_block_header {
 	unsigned int length;             /* length in chars without header */
 	unsigned char *data;             /* usually data is located 
                                         immediately behind this struct */
diff --git a/include/linux/parport_pc.h b/include/linux/parport_pc.h
index 3d6fc5..4f7d91 100644
--- a/include/linux/parport_pc.h
+++ b/include/linux/parport_pc.h
@@ -43,8 +43,7 @@ struct parport_pc_private {
 	struct parport *port;
 };
 
-struct parport_pc_via_data
-{
+struct parport_pc_via_data {
 	/* ISA PnP IRQ routing register 1 */
 	u8 via_pci_parport_irq_reg;
 	/* ISA PnP DMA request routing register */
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 998ae7..0cc18a 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -56,8 +56,7 @@ struct upid {
 	struct pid_namespace *ns;
 };
 
-struct pid
-{
+struct pid {
 	refcount_t count;
 	unsigned int level;
 	/* lists of tasks that use this pid */
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 174601..77811d 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -25,8 +25,7 @@
 #define PKT_WRITE_CONGESTION_OFF   9000
 
 
-struct packet_settings
-{
+struct packet_settings {
 	__u32			size;		/* packet size in (512 byte) sectors */
 	__u8			fp;		/* fixed packets */
 	__u8			link_loss;	/* the rest is specified
@@ -39,8 +38,7 @@ struct packet_settings
 /*
  * Very crude stats for now
  */
-struct packet_stats
-{
+struct packet_stats {
 	unsigned long		pkt_started;
 	unsigned long		pkt_ended;
 	unsigned long		secs_w;
@@ -48,8 +46,7 @@ struct packet_stats
 	unsigned long		secs_r;
 };
 
-struct packet_cdrw
-{
+struct packet_cdrw {
 	struct list_head	pkt_free_list;
 	struct list_head	pkt_active_list;
 	spinlock_t		active_list_lock; /* Serialize access to pkt_active_list */
@@ -63,8 +60,7 @@ struct packet_cdrw
  */
 #define HI_SPEED_SWITCH 512
 
-struct packet_iosched
-{
+struct packet_iosched {
 	atomic_t		attention;	/* Set to non-zero when queue processing is needed */
 	int			writing;	/* Non-zero when writing, zero when reading */
 	spinlock_t		lock;		/* Protecting read/write queue manipulations */
@@ -102,8 +98,7 @@ enum packet_data_state {
  */
 struct pktcdvd_device;
 
-struct packet_data
-{
+struct packet_data {
 	struct list_head	list;
 
 	spinlock_t		lock;		/* Lock protecting state transitions and */
@@ -145,23 +140,20 @@ struct pkt_rb_node {
 	struct bio		*bio;
 };
 
-struct packet_stacked_data
-{
+struct packet_stacked_data {
 	struct bio		*bio;		/* Original read request bio */
 	struct pktcdvd_device	*pd;
 };
 #define PSD_POOL_SIZE		64
 
-struct pktcdvd_kobj
-{
+struct pktcdvd_kobj {
 	struct kobject		kobj;
 	struct pktcdvd_device	*pd;
 };
 #define to_pktcdvdkobj(_k) \
   ((struct pktcdvd_kobj*)container_of(_k,struct pktcdvd_kobj,kobj))
 
-struct pktcdvd_device
-{
+struct pktcdvd_device {
 	struct block_device	*bdev;		/* dev attached */
 	dev_t			pkt_dev;	/* our dev */
 	char			name[20];
diff --git a/include/linux/pmu.h b/include/linux/pmu.h
index 52453a24..d0d75f0 100644
--- a/include/linux/pmu.h
+++ b/include/linux/pmu.h
@@ -62,8 +62,7 @@ extern void pmu_backlight_set_sleep(int sleep);
 #define PMU_BATT_TYPE_HOOPER	0x00000020 /* 3400/3500 */
 #define PMU_BATT_TYPE_COMET	0x00000030 /* 2400 */
 
-struct pmu_battery_info
-{
+struct pmu_battery_info {
 	unsigned int	flags;
 	unsigned int	charge;		/* current charge */
 	unsigned int	max_charge;	/* maximum charge */
diff --git a/include/linux/relay.h b/include/linux/relay.h
index c759f9..774f8d 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -31,8 +31,7 @@
 /*
  * Per-cpu relay channel buffer
  */
-struct rchan_buf
-{
+struct rchan_buf {
 	void *start;			/* start of channel buffer */
 	void *data;			/* start of current sub-buffer */
 	size_t offset;			/* current offset into sub-buffer */
@@ -56,8 +55,7 @@ struct rchan_buf
 /*
  * Relay channel data structure
  */
-struct rchan
-{
+struct rchan {
 	u32 version;			/* the version of this struct */
 	size_t subbuf_size;		/* sub-buffer size */
 	size_t n_subbufs;		/* number of sub-buffers per buffer */
@@ -77,8 +75,7 @@ struct rchan
 /*
  * Relay channel client callbacks
  */
-struct rchan_callbacks
-{
+struct rchan_callbacks {
 	/*
 	 * subbuf_start - called on buffer-switch to a new sub-buffer
 	 * @buf: the channel buffer containing the new sub-buffer
diff --git a/include/linux/sungem_phy.h b/include/linux/sungem_phy.h
index 3a11fa..23f5027 100644
--- a/include/linux/sungem_phy.h
+++ b/include/linux/sungem_phy.h
@@ -5,8 +5,7 @@
 struct mii_phy;
 
 /* Operations supported by any kind of PHY */
-struct mii_phy_ops
-{
+struct mii_phy_ops {
 	int		(*init)(struct mii_phy *phy);
 	int		(*suspend)(struct mii_phy *phy);
 	int		(*setup_aneg)(struct mii_phy *phy, u32 advertise);
@@ -17,8 +16,7 @@ struct mii_phy_ops
 };
 
 /* Structure used to statically define an mii/gii based PHY */
-struct mii_phy_def
-{
+struct mii_phy_def {
 	u32				phy_id;		/* Concatenated ID1 << 16 | ID2 */
 	u32				phy_id_mask;	/* Significant bits */
 	u32				features;	/* Ethtool SUPPORTED_* defines */
@@ -36,8 +34,7 @@ enum {
 };
 
 /* An instance of a PHY, partially borrowed from mii_if_info */
-struct mii_phy
-{
+struct mii_phy {
 	struct mii_phy_def*	def;
 	u32			advertising;
 	int			mii_id;
diff --git a/include/linux/textsearch.h b/include/linux/textsearch.h
index 13770cf..2142f3c 100644
--- a/include/linux/textsearch.h
+++ b/include/linux/textsearch.h
@@ -20,8 +20,7 @@ struct ts_config;
  * @offset: offset for next match
  * @cb: control buffer, for persistent variables of get_next_block()
  */
-struct ts_state
-{
+struct ts_state {
 	unsigned int		offset;
 	char			cb[40];
 };
@@ -36,8 +35,7 @@ struct ts_state
  * @get_pattern_len: return length of pattern
  * @owner: module reference to algorithm
  */
-struct ts_ops
-{
+struct ts_ops {
 	const char		*name;
 	struct ts_config *	(*init)(const void *, unsigned int, gfp_t, int);
 	unsigned int		(*find)(struct ts_config *,
@@ -56,8 +54,7 @@ struct ts_ops
  * @get_next_block: callback to fetch the next block to search in
  * @finish: callback to finalize a search
  */
-struct ts_config
-{
+struct ts_config {
 	struct ts_ops		*ops;
 	int 			flags;
 
diff --git a/include/linux/textsearch_fsm.h b/include/linux/textsearch_fsm.h
index b57231..94167d 100644
--- a/include/linux/textsearch_fsm.h
+++ b/include/linux/textsearch_fsm.h
@@ -39,8 +39,7 @@ enum {
  * @recur: number of recurrences
  * @value: character value for TS_FSM_SPECIFIC
  */
-struct ts_fsm_token
-{
+struct ts_fsm_token {
 	__u16		type;
 	__u8		recur;
 	__u8		value;
diff --git a/include/media/drv-intf/saa7146.h b/include/media/drv-intf/saa7146.h
index 71ce63..8c490c 100644
--- a/include/media/drv-intf/saa7146.h
+++ b/include/media/drv-intf/saa7146.h
@@ -86,8 +86,7 @@ struct saa7146_pci_extension_data {
 		.driver_data = (unsigned long)& x_var,		\
 	}
 
-struct saa7146_extension
-{
+struct saa7146_extension {
 	char	name[32];		/* name of the device */
 #define SAA7146_USE_I2C_IRQ	0x1
 #define SAA7146_I2C_SHORT_DELAY	0x2
@@ -108,14 +107,12 @@ struct saa7146_extension
 	void	(*irq_func)(struct saa7146_dev*, u32* irq_mask);
 };
 
-struct saa7146_dma
-{
+struct saa7146_dma {
 	dma_addr_t	dma_handle;
 	__le32		*cpu_addr;
 };
 
-struct saa7146_dev
-{
+struct saa7146_dev {
 	struct module			*module;
 
 	struct v4l2_device		v4l2_dev;
diff --git a/include/media/drv-intf/saa7146_vv.h b/include/media/drv-intf/saa7146_vv.h
index 635805..219186 100644
--- a/include/media/drv-intf/saa7146_vv.h
+++ b/include/media/drv-intf/saa7146_vv.h
@@ -39,8 +39,7 @@ struct saa7146_format {
 	u8	swap;
 };
 
-struct saa7146_standard
-{
+struct saa7146_standard {
 	char          *name;
 	v4l2_std_id   id;
 
@@ -101,8 +100,7 @@ struct saa7146_fh {
 #define STATUS_OVERLAY	0x01
 #define STATUS_CAPTURE	0x02
 
-struct saa7146_vv
-{
+struct saa7146_vv {
 	/* vbi capture */
 	struct saa7146_dmaqueue		vbi_dmaq;
 	struct v4l2_vbi_format		vbi_fmt;
@@ -148,8 +146,7 @@ struct saa7146_vv
 /* flags */
 #define SAA7146_USE_PORT_B_FOR_VBI	0x2     /* use input port b for vbi hardware bug workaround */
 
-struct saa7146_ext_vv
-{
+struct saa7146_ext_vv {
 	/* information about the video capabilities of the device */
 	int	inputs;
 	int	audios;
diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index 48531e..2b0936 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -253,8 +253,7 @@ struct v4l2_file_operations {
  *	Only set @dev_parent if that can't be deduced from @v4l2_dev.
  */
 
-struct video_device
-{
+struct video_device {
 #if defined(CONFIG_MEDIA_CONTROLLER)
 	struct media_entity entity;
 	struct media_intf_devnode *intf_devnode;
diff --git a/include/scsi/sg.h b/include/scsi/sg.h
index f91bcca..a779e3e 100644
--- a/include/scsi/sg.h
+++ b/include/scsi/sg.h
@@ -220,8 +220,7 @@ typedef struct sg_req_info Sg_req_info;
 
 #define SG_MAX_SENSE 16   /* this only applies to the sg_header interface */
 
-struct sg_header
-{
+struct sg_header {
     int pack_len;    /* [o] reply_len (ie useless), ignored as input */
     int reply_len;   /* [i] max length of expected reply (inc. sg_header) */
     int pack_id;     /* [io] id number of packet (use ints >= 0) */
diff --git a/include/sound/wavefront.h b/include/sound/wavefront.h
index 37ed43..097340 100644
--- a/include/sound/wavefront.h
+++ b/include/sound/wavefront.h
@@ -191,8 +191,7 @@ typedef u8 UCHAR8;
 #define DrumkitFileID  "DrumKit"
 #define ProgramFileID  "Program"
 
-struct wf_envelope
-{
+struct wf_envelope {
     u8 attack_time:7;
     u8 Unused1:1;
 
@@ -228,8 +227,7 @@ struct wf_envelope
 };
 typedef struct wf_envelope wavefront_envelope;
 
-struct wf_lfo
-{
+struct wf_lfo {
     u8 sample_number;
 
     u8 frequency:7;
@@ -251,8 +249,7 @@ struct wf_lfo
 };
 typedef struct wf_lfo wavefront_lfo;
 
-struct wf_patch
-{
+struct wf_patch {
     s16  frequency_bias;         /*  ** THIS IS IN MOTOROLA FORMAT!! ** */
 
     u8 amplitude_bias:7;
@@ -306,8 +303,7 @@ struct wf_patch
 };
 typedef struct wf_patch wavefront_patch;
 
-struct wf_layer
-{
+struct wf_layer {
     u8 patch_number;
 
     u8 mix_level:7;
@@ -323,14 +319,12 @@ struct wf_layer
 };
 typedef struct wf_layer wavefront_layer;
 
-struct wf_program
-{
+struct wf_program {
     struct wf_layer layer[WF_NUM_LAYERS];
 };
 typedef struct wf_program wavefront_program;
 
-struct wf_sample_offset
-{
+struct wf_sample_offset {
     s32 Fraction:4;
     s32 Integer:20;
     s32 Unused:8;
diff --git a/include/uapi/linux/a.out.h b/include/uapi/linux/a.out.h
index 5fafde..338635 100644
--- a/include/uapi/linux/a.out.h
+++ b/include/uapi/linux/a.out.h
@@ -221,8 +221,7 @@ struct nlist {
    all of which apply to the text section.
    Likewise, the data-relocation section applies to the data section.  */
 
-struct relocation_info
-{
+struct relocation_info {
   /* Address (within segment) to be relocated.  */
   int r_address;
   /* The meaning of r_symbolnum depends on r_extern.  */
diff --git a/include/uapi/linux/acct.h b/include/uapi/linux/acct.h
index 0e72172..43d22e 100644
--- a/include/uapi/linux/acct.h
+++ b/include/uapi/linux/acct.h
@@ -41,8 +41,7 @@ typedef __u32	comp2_t;
 
 #define ACCT_COMM	16
 
-struct acct
-{
+struct acct {
 	char		ac_flag;		/* Flags */
 	char		ac_version;		/* Always set to ACCT_VERSION */
 	/* for binary compatibility back until 2.0 */
@@ -71,8 +70,7 @@ struct acct
 	__u32		ac_gid;			/* Real Group ID */
 };
 
-struct acct_v3
-{
+struct acct_v3 {
 	char		ac_flag;		/* Flags */
 	char		ac_version;		/* Always set to ACCT_VERSION */
 	__u16		ac_tty;			/* Control Terminal */
diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
index 281723..37f0aa 100644
--- a/include/uapi/linux/cdrom.h
+++ b/include/uapi/linux/cdrom.h
@@ -152,8 +152,7 @@
  *******************************************************/
 
 /* Address in MSF format */
-struct cdrom_msf0		
-{
+struct cdrom_msf0 {
 	__u8	minute;
 	__u8	second;
 	__u8	frame;
@@ -167,8 +166,7 @@ union cdrom_addr
 };
 
 /* This struct is used by the CDROMPLAYMSF ioctl */ 
-struct cdrom_msf 
-{
+struct cdrom_msf {
 	__u8	cdmsf_min0;	/* start minute */
 	__u8	cdmsf_sec0;	/* start second */
 	__u8	cdmsf_frame0;	/* start frame */
@@ -178,8 +176,7 @@ struct cdrom_msf
 };
 
 /* This struct is used by the CDROMPLAYTRKIND ioctl */
-struct cdrom_ti 
-{
+struct cdrom_ti {
 	__u8	cdti_trk0;	/* start track */
 	__u8	cdti_ind0;	/* start index */
 	__u8	cdti_trk1;	/* end track */
@@ -187,15 +184,13 @@ struct cdrom_ti
 };
 
 /* This struct is used by the CDROMREADTOCHDR ioctl */
-struct cdrom_tochdr 	
-{
+struct cdrom_tochdr {
 	__u8	cdth_trk0;	/* start track */
 	__u8	cdth_trk1;	/* end track */
 };
 
 /* This struct is used by the CDROMVOLCTRL and CDROMVOLREAD ioctls */
-struct cdrom_volctrl
-{
+struct cdrom_volctrl {
 	__u8	channel0;
 	__u8	channel1;
 	__u8	channel2;
@@ -203,8 +198,7 @@ struct cdrom_volctrl
 };
 
 /* This struct is used by the CDROMSUBCHNL ioctl */
-struct cdrom_subchnl 
-{
+struct cdrom_subchnl {
 	__u8	cdsc_format;
 	__u8	cdsc_audiostatus;
 	__u8	cdsc_adr:	4;
@@ -217,8 +211,7 @@ struct cdrom_subchnl
 
 
 /* This struct is used by the CDROMREADTOCENTRY ioctl */
-struct cdrom_tocentry 
-{
+struct cdrom_tocentry {
 	__u8	cdte_track;
 	__u8	cdte_adr	:4;
 	__u8	cdte_ctrl	:4;
@@ -228,16 +221,14 @@ struct cdrom_tocentry
 };
 
 /* This struct is used by the CDROMREADMODE1, and CDROMREADMODE2 ioctls */
-struct cdrom_read      
-{
+struct cdrom_read {
 	int	cdread_lba;
 	char 	*cdread_bufaddr;
 	int	cdread_buflen;
 };
 
 /* This struct is used by the CDROMREADAUDIO ioctl */
-struct cdrom_read_audio
-{
+struct cdrom_read_audio {
 	union cdrom_addr addr; /* frame address */
 	__u8 addr_format;      /* CDROM_LBA or CDROM_MSF */
 	int nframes;           /* number of 2352-byte-frames to read at once */
@@ -245,8 +236,7 @@ struct cdrom_read_audio
 };
 
 /* This struct is used with the CDROMMULTISESSION ioctl */
-struct cdrom_multisession
-{
+struct cdrom_multisession {
 	union cdrom_addr addr; /* frame address: start-of-last-session 
 	                           (not the new "frame 16"!).  Only valid
 	                           if the "xa_flag" is true. */
@@ -259,14 +249,12 @@ struct cdrom_multisession
  * which should just be the Medium Catalog Number on the box.  Also note 
  * that the way the codeis written on CD is _not_ uniform across all discs!
  */  
-struct cdrom_mcn 
-{
+struct cdrom_mcn {
   __u8 medium_catalog_number[14]; /* 13 ASCII digits, null-terminated */
 };
 
 /* This is used by the CDROMPLAYBLK ioctl */
-struct cdrom_blk 
-{
+struct cdrom_blk {
 	unsigned from;
 	unsigned short len;
 };
@@ -279,8 +267,7 @@ struct cdrom_blk
 #define CGC_DATA_NONE		3
 
 /* for CDROM_PACKET_COMMAND ioctl */
-struct cdrom_generic_command
-{
+struct cdrom_generic_command {
 	unsigned char 		cmd[CDROM_PACKET_SIZE];
 	unsigned char		__user *buffer;
 	unsigned int 		buflen;
diff --git a/include/uapi/linux/coff.h b/include/uapi/linux/coff.h
index ab5c7e8..cffbc36 100644
--- a/include/uapi/linux/coff.h
+++ b/include/uapi/linux/coff.h
@@ -240,8 +240,7 @@ struct COFF_lineno {
  *  All symbols and sections have the following definition
  */
 
-struct COFF_syment 
-{
+struct COFF_syment {
   union {
     char e_name[E_SYMNMLEN];    /* Symbol name (first 8 characters) */
     struct {
diff --git a/include/uapi/linux/elfcore.h b/include/uapi/linux/elfcore.h
index baf035..2fd5aa 100644
--- a/include/uapi/linux/elfcore.h
+++ b/include/uapi/linux/elfcore.h
@@ -9,8 +9,7 @@
 #include <linux/elf.h>
 #include <linux/fs.h>
 
-struct elf_siginfo
-{
+struct elf_siginfo {
 	int	si_signo;			/* signal number */
 	int	si_code;			/* extra code */
 	int	si_errno;			/* errno */
@@ -34,8 +33,7 @@ typedef elf_fpxregset_t fpxregset_t;
  * not support and which gdb doesn't really use excluded.
  * Fields present but not used are marked with "XXX".
  */
-struct elf_prstatus
-{
+struct elf_prstatus {
 #if 0
 	long	pr_flags;	/* XXX Process flags */
 	short	pr_why;		/* XXX Reason for process halt */
@@ -76,8 +74,7 @@ struct elf_prstatus
 
 #define ELF_PRARGSZ	(80)	/* Number of chars for args */
 
-struct elf_prpsinfo
-{
+struct elf_prpsinfo {
 	char	pr_state;	/* numeric process state */
 	char	pr_sname;	/* char for pr_state */
 	char	pr_zomb;	/* zombie */
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index cb8693b..90d9b81 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -6,8 +6,7 @@
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
-struct gsm_config
-{
+struct gsm_config {
 	unsigned int adaption;
 	unsigned int encapsulation;
 	unsigned int initiator;
diff --git a/include/uapi/linux/if_frad.h b/include/uapi/linux/if_frad.h
index 3c6ee85..0c291d 100644
--- a/include/uapi/linux/if_frad.h
+++ b/include/uapi/linux/if_frad.h
@@ -29,8 +29,7 @@
 
 /* Structures and constants associated with the DLCI device driver */
 
-struct dlci_add
-{
+struct dlci_add {
    char  devname[IFNAMSIZ];
    short dlci;
 };
@@ -81,8 +80,7 @@ struct dlci_conf {
  * necessary to this structure, a routine will need to be 
  * added to that module to copy fields.
  */
-struct frad_conf 
-{
+struct frad_conf {
    short station;
    short flags;
    short kbaud;
diff --git a/include/uapi/linux/ipc.h b/include/uapi/linux/ipc.h
index 5995fc..87d9f9 100644
--- a/include/uapi/linux/ipc.h
+++ b/include/uapi/linux/ipc.h
@@ -7,8 +7,7 @@
 #define IPC_PRIVATE ((__kernel_key_t) 0)  
 
 /* Obsolete, used only for backwards compatibility and libc5 compiles */
-struct ipc_perm
-{
+struct ipc_perm {
 	__kernel_key_t	key;
 	__kernel_uid_t	uid;
 	__kernel_gid_t	gid;
diff --git a/include/uapi/linux/jffs2.h b/include/uapi/linux/jffs2.h
index 784ba0..deef24 100644
--- a/include/uapi/linux/jffs2.h
+++ b/include/uapi/linux/jffs2.h
@@ -99,8 +99,7 @@ typedef struct {
 	__u16 v16;
 } __attribute__((packed)) jint16_t;
 
-struct jffs2_unknown_node
-{
+struct jffs2_unknown_node {
 	/* All start like this */
 	jint16_t magic;
 	jint16_t nodetype;
@@ -108,8 +107,7 @@ struct jffs2_unknown_node
 	jint32_t hdr_crc;
 };
 
-struct jffs2_raw_dirent
-{
+struct jffs2_raw_dirent {
 	jint16_t magic;
 	jint16_t nodetype;	/* == JFFS2_NODETYPE_DIRENT */
 	jint32_t totlen;
@@ -132,8 +130,7 @@ struct jffs2_raw_dirent
    they really need them extended, it's simple enough to add support for
    a new type of raw node.
 */
-struct jffs2_raw_inode
-{
+struct jffs2_raw_inode {
 	jint16_t magic;      /* A constant magic number.  */
 	jint16_t nodetype;   /* == JFFS2_NODETYPE_INODE */
 	jint32_t totlen;     /* Total length of this node (inc data, etc.) */
@@ -173,8 +170,7 @@ struct jffs2_raw_xattr {
 	__u8 data[0];
 } __attribute__((packed));
 
-struct jffs2_raw_xref
-{
+struct jffs2_raw_xref {
 	jint16_t magic;
 	jint16_t nodetype;	/* = JFFS2_NODETYPE_XREF */
 	jint32_t totlen;
@@ -185,8 +181,7 @@ struct jffs2_raw_xref
 	jint32_t node_crc;
 } __attribute__((packed));
 
-struct jffs2_raw_summary
-{
+struct jffs2_raw_summary {
 	jint16_t magic;
 	jint16_t nodetype; 	/* = JFFS2_NODETYPE_SUMMARY */
 	jint32_t totlen;
diff --git a/include/uapi/linux/netfilter_arp/arp_tables.h b/include/uapi/linux/netfilter_arp/arp_tables.h
index bbf5af2..2d2f89 100644
--- a/include/uapi/linux/netfilter_arp/arp_tables.h
+++ b/include/uapi/linux/netfilter_arp/arp_tables.h
@@ -93,8 +93,7 @@ struct arpt_arp {
 /* This structure defines each of the firewall rules.  Consists of 3
    parts which are 1) general ARP header stuff 2) match specific
    stuff 3) the target to perform if the rule matches */
-struct arpt_entry
-{
+struct arpt_entry {
 	struct arpt_arp arp;
 
 	/* Size of arpt_entry + matches */
diff --git a/include/uapi/linux/netfilter_arp/arpt_mangle.h b/include/uapi/linux/netfilter_arp/arpt_mangle.h
index 60135d5..6965692 100644
--- a/include/uapi/linux/netfilter_arp/arpt_mangle.h
+++ b/include/uapi/linux/netfilter_arp/arpt_mangle.h
@@ -4,8 +4,7 @@
 #include <linux/netfilter_arp/arp_tables.h>
 
 #define ARPT_MANGLE_ADDR_LEN_MAX sizeof(struct in_addr)
-struct arpt_mangle
-{
+struct arpt_mangle {
 	char src_devaddr[ARPT_DEV_ADDR_LEN_MAX];
 	char tgt_devaddr[ARPT_DEV_ADDR_LEN_MAX];
 	union {
diff --git a/include/uapi/linux/netfilter_bridge/ebt_arp.h b/include/uapi/linux/netfilter_bridge/ebt_arp.h
index 628b4f..c0f9ba4 100644
--- a/include/uapi/linux/netfilter_bridge/ebt_arp.h
+++ b/include/uapi/linux/netfilter_bridge/ebt_arp.h
@@ -18,8 +18,7 @@
    EBT_ARP_GRAT)
 #define EBT_ARP_MATCH "arp"
 
-struct ebt_arp_info
-{
+struct ebt_arp_info {
 	__be16 htype;
 	__be16 ptype;
 	__be16 opcode;
diff --git a/include/uapi/linux/raw.h b/include/uapi/linux/raw.h
index dc96dda..89db13f 100644
--- a/include/uapi/linux/raw.h
+++ b/include/uapi/linux/raw.h
@@ -7,8 +7,7 @@
 #define RAW_SETBIND	_IO( 0xac, 0 )
 #define RAW_GETBIND	_IO( 0xac, 1 )
 
-struct raw_config_request 
-{
+struct raw_config_request {
 	int	raw_minor;
 	__u64	block_major;
 	__u64	block_minor;
diff --git a/include/uapi/linux/termios.h b/include/uapi/linux/termios.h
index 33961d..06c439 100644
--- a/include/uapi/linux/termios.h
+++ b/include/uapi/linux/termios.h
@@ -7,8 +7,7 @@
 
 #define NFF	5
 
-struct termiox
-{
+struct termiox {
 	__u16	x_hflag;
 	__u16	x_cflag;
 	__u16	x_rflag[NFF];
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index 059b1a9..4fbe93 100644
--- a/include/uapi/linux/uio.h
+++ b/include/uapi/linux/uio.h
@@ -14,8 +14,7 @@
 #include <linux/types.h>
 
 
-struct iovec
-{
+struct iovec {
 	void __user *iov_base;	/* BSD uses caddr_t (1003.1g requires void *) */
 	__kernel_size_t iov_len; /* Must be size_t (1003.1g) */
 };
diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
index 9bc5bc..0b267c 100644
--- a/include/xen/grant_table.h
+++ b/include/xen/grant_table.h
@@ -66,8 +66,7 @@ struct gntab_unmap_queue_data;
 
 typedef void (*gnttab_unmap_refs_done)(int result, struct gntab_unmap_queue_data *data);
 
-struct gntab_unmap_queue_data
-{
+struct gntab_unmap_queue_data {
 	struct delayed_work	gnttab_work;
 	void *data;
 	gnttab_unmap_refs_done	done;
diff --git a/include/xen/interface/io/xs_wire.h b/include/xen/interface/io/xs_wire.h
index 1517c7e..73ebcd8 100644
--- a/include/xen/interface/io/xs_wire.h
+++ b/include/xen/interface/io/xs_wire.h
@@ -39,8 +39,7 @@ enum xsd_sockmsg_type
 #define XS_WRITE_CREATE_EXCL "CREATE|EXCL"
 
 /* We hand errors as strings, for portability. */
-struct xsd_errors
-{
+struct xsd_errors {
     int errnum;
     const char *errstring;
 };
@@ -62,8 +61,7 @@ static struct xsd_errors xsd_errors[] __attribute__((unused)) = {
     XSD_ERROR(EISCONN)
 };
 
-struct xsd_sockmsg
-{
+struct xsd_sockmsg {
     uint32_t type;  /* XS_??? */
     uint32_t req_id;/* Request identifier, echoed in daemon's response.  */
     uint32_t tx_id; /* Transaction id (0 if not related to a transaction). */
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 869c81..d63304 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -52,8 +52,7 @@
 #define INVALID_GRANT_HANDLE       (~0U)
 
 /* Register callback to watch this node. */
-struct xenbus_watch
-{
+struct xenbus_watch {
 	struct list_head list;
 
 	/* Path being watched. */
@@ -83,8 +82,7 @@ static inline struct xenbus_device *to_xenbus_device(struct device *dev)
 	return container_of(dev, struct xenbus_device, dev);
 }
 
-struct xenbus_device_id
-{
+struct xenbus_device_id {
 	/* .../device/<device_type>/<identifier> */
 	char devicetype[32]; 	/* General class of device. */
 };
@@ -125,8 +123,7 @@ int __must_check __xenbus_register_backend(struct xenbus_driver *drv,
 
 void xenbus_unregister_driver(struct xenbus_driver *drv);
 
-struct xenbus_transaction
-{
+struct xenbus_transaction {
 	u32 id;
 };
 

