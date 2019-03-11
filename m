Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61A1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADA7214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OyXQipDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfCKXyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:54:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41368 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725932AbfCKXyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:54:24 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2BNnrOx016891
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 16:54:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=6bFXpzp90QKX3qAYdMyaGXATL0vcmCXXDLFbz7SK4Uc=;
 b=OyXQipDS8kma+ofcXQM2Aj0bFHSFwDEhCOaZKPE+RdKfOub6GalsnGpM7OKUeCmx1d8/
 wglWG2ba6e7uIz8Rlrq8m+XobbSDFP1O1bPIZiV57Qtsu+rCLcURVb/egwCAjOQmfICL
 W5YU59kMxVHJyRvpG1+D/izzo1JTFwuhI5U= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2r5x1xrp3k-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 16:54:16 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 16:54:06 -0700
Received: by devbig008.ftw2.facebook.com (Postfix, from userid 10532)
        id AF78023A5B03; Mon, 11 Mar 2019 16:54:05 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Hostname: devbig008.ftw2.facebook.com
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] tpm: Make timeout logic simpler and more robust
Date:   Mon, 11 Mar 2019 16:54:04 -0700
Message-ID: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're having lots of problems with TPM commands timing out, and we're
seeing these problems across lots of different hardware (both v1/v2).

I instrumented the driver to collect latency data, but I wasn't able to
find any specific timeout to fix: it seems like many of them are too
aggressive. So I tried replacing all the timeout logic with a single
universal long timeout, and found that makes our TPMs 100% reliable.

Given that this timeout logic is very complex, problematic, and appears
to serve no real purpose, I propose simply deleting all of it.

Signed-off-by: Calvin Owens <calvinowens@fb.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c |  28 +-
 drivers/char/tpm/tpm-interface.c     |  41 +--
 drivers/char/tpm/tpm-sysfs.c         |  34 ---
 drivers/char/tpm/tpm.h               |  60 +---
 drivers/char/tpm/tpm1-cmd.c          | 423 ++-------------------------
 drivers/char/tpm/tpm2-cmd.c          | 120 --------
 drivers/char/tpm/tpm_crb.c           |  20 +-
 drivers/char/tpm/tpm_i2c_atmel.c     |   6 -
 drivers/char/tpm/tpm_i2c_infineon.c  |  33 +--
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  42 +--
 drivers/char/tpm/tpm_nsc.c           |   6 +-
 drivers/char/tpm/tpm_tis_core.c      |  96 +-----
 drivers/char/tpm/xen-tpmfront.c      |  17 +-
 13 files changed, 108 insertions(+), 818 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 64dc560859f2..433b9a72f0ef 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -154,13 +154,13 @@ static int request_locality(struct tpm_chip *chip)
 	if (ret < 0)
 		return ret;
 
-	stop = jiffies + chip->timeout_a;
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 
 	/* Request locality is usually effective after the request */
 	do {
 		if (check_locality(chip))
 			return tpm_dev->locality;
-		msleep(TPM_TIMEOUT);
+		msleep(TPM_TIMEOUT_POLL_MS);
 	} while (time_before(jiffies, stop));
 
 	/* could not get locality */
@@ -193,7 +193,7 @@ static int get_burstcount(struct tpm_chip *chip)
 	int burstcnt, status;
 	u8 temp;
 
-	stop = jiffies + chip->timeout_d;
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 	do {
 		status = tpm_dev->ops->recv(tpm_dev->phy_id, TPM_STS + 1,
 					    &temp, 1);
@@ -209,7 +209,7 @@ static int get_burstcount(struct tpm_chip *chip)
 		burstcnt |= temp << 8;
 		if (burstcnt)
 			return burstcnt;
-		msleep(TPM_TIMEOUT);
+		msleep(TPM_TIMEOUT_POLL_MS);
 	} while (time_before(jiffies, stop));
 	return -EBUSY;
 } /* get_burstcount() */
@@ -248,11 +248,11 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
  * @param: check_cancel, does the command can be cancelled ?
  * @return: the tpm status, 0 if success, -ETIME if timeout is reached.
  */
-static int wait_for_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,
+static int wait_for_stat(struct tpm_chip *chip, u8 mask,
 			wait_queue_head_t *queue, bool check_cancel)
 {
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
-	unsigned long stop;
+	unsigned long stop, timeout;
 	int ret = 0;
 	bool canceled = false;
 	bool condition;
@@ -264,7 +264,7 @@ static int wait_for_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,
 	if ((status & mask) == mask)
 		return 0;
 
-	stop = jiffies + timeout;
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
 		cur_intrs = tpm_dev->intrs;
@@ -296,7 +296,7 @@ static int wait_for_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,
 
 	} else {
 		do {
-			msleep(TPM_TIMEOUT);
+			msleep(TPM_TIMEOUT_POLL_MS);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -321,7 +321,6 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 	while (size < count &&
 	       wait_for_stat(chip,
 			     TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-			     chip->timeout_c,
 			     &tpm_dev->read_queue, true) == 0) {
 		burstcnt = get_burstcount(chip);
 		if (burstcnt < 0)
@@ -384,7 +383,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
 		st33zp24_cancel(chip);
 		if (wait_for_stat
-		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
+		    (chip, TPM_STS_COMMAND_READY,
 		     &tpm_dev->read_queue, false) < 0) {
 			ret = -ETIME;
 			goto out_err;
@@ -430,7 +429,6 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
 
 		ret = wait_for_stat(chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-				tpm_calc_ordinal_duration(chip, ordinal),
 				&tpm_dev->read_queue, false);
 		if (ret < 0)
 			goto out_err;
@@ -539,12 +537,6 @@ int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
 	tpm_dev->phy_id = phy_id;
 	tpm_dev->ops = ops;
 	dev_set_drvdata(&chip->dev, tpm_dev);
-
-	chip->timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-	chip->timeout_b = msecs_to_jiffies(TIS_LONG_TIMEOUT);
-	chip->timeout_c = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-	chip->timeout_d = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-
 	tpm_dev->locality = LOCALITY0;
 
 	if (irq) {
@@ -644,7 +636,7 @@ int st33zp24_pm_resume(struct device *dev)
 	if (gpio_is_valid(tpm_dev->io_lpcpd)) {
 		gpio_set_value(tpm_dev->io_lpcpd, 1);
 		ret = wait_for_stat(chip,
-				TPM_STS_VALID, chip->timeout_b,
+				TPM_STS_VALID,
 				&tpm_dev->read_queue, false);
 	} else {
 		ret = tpm_pm_resume(dev);
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index d9439f9abe78..7ceefe02ca32 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -43,25 +43,6 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
 MODULE_PARM_DESC(suspend_pcr,
 		 "PCR to use for dummy writes to facilitate flush on suspend.");
 
-/**
- * tpm_calc_ordinal_duration() - calculate the maximum command duration
- * @chip:    TPM chip to use.
- * @ordinal: TPM command ordinal.
- *
- * The function returns the maximum amount of time the chip could take
- * to return the result for a particular ordinal in jiffies.
- *
- * Return: A maximal duration time for an ordinal in jiffies.
- */
-unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
-{
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return tpm2_calc_ordinal_duration(chip, ordinal);
-	else
-		return tpm1_calc_ordinal_duration(chip, ordinal);
-}
-EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
-
 static int tpm_validate_command(struct tpm_chip *chip,
 				 struct tpm_space *space,
 				 const u8 *cmd,
@@ -237,7 +218,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
 		goto out_recv;
 
-	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 	do {
 		u8 status = chip->ops->status(chip);
 		if ((status & chip->ops->req_complete_mask) ==
@@ -250,7 +231,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 			goto out;
 		}
 
-		tpm_msleep(TPM_TIMEOUT_POLL);
+		tpm_msleep(TPM_TIMEOUT_POLL_MS);
 		rmb();
 	} while (time_before(jiffies, stop));
 
@@ -307,7 +288,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
  *
  * A wrapper around tpm_try_transmit that handles TPM2_RC_RETRY
  * returns from the TPM and retransmits the command after a delay up
- * to a maximum wait of TPM2_DURATION_LONG.
+ * to a maximum wait of TPM_UNIVERSAL_TIMEOUT_MS.
  *
  * Note: TPM1 never returns TPM2_RC_RETRY so the retry logic is TPM2
  * only
@@ -322,7 +303,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	struct tpm_output_header *header = (struct tpm_output_header *)buf;
 	/* space for header and handles */
 	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
-	unsigned int delay_msec = TPM2_DURATION_SHORT;
+	unsigned int delay_msec = 20;
 	u32 rc = 0;
 	ssize_t ret;
 	const size_t save_size = min(space ? sizeof(save) : TPM_HEADER_SIZE,
@@ -351,7 +332,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
 			break;
 
-		if (delay_msec > TPM2_DURATION_LONG) {
+		if (delay_msec > TPM_UNIVERSAL_TIMEOUT_MS) {
 			if (rc == TPM2_RC_RETRY)
 				dev_err(&chip->dev, "in retry loop\n");
 			else
@@ -410,18 +391,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 }
 EXPORT_SYMBOL_GPL(tpm_transmit_cmd);
 
-int tpm_get_timeouts(struct tpm_chip *chip)
-{
-	if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
-		return 0;
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return tpm2_get_timeouts(chip);
-	else
-		return tpm1_get_timeouts(chip);
-}
-EXPORT_SYMBOL_GPL(tpm_get_timeouts);
-
 /**
  * tpm_is_tpm2 - do we a have a TPM2 chip?
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index b88e08ec2c59..f1813afe8d9b 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -252,38 +252,6 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(cancel);
 
-static ssize_t durations_show(struct device *dev, struct device_attribute *attr,
-			      char *buf)
-{
-	struct tpm_chip *chip = to_tpm_chip(dev);
-
-	if (chip->duration[TPM_LONG] == 0)
-		return 0;
-
-	return sprintf(buf, "%d %d %d [%s]\n",
-		       jiffies_to_usecs(chip->duration[TPM_SHORT]),
-		       jiffies_to_usecs(chip->duration[TPM_MEDIUM]),
-		       jiffies_to_usecs(chip->duration[TPM_LONG]),
-		       chip->duration_adjusted
-		       ? "adjusted" : "original");
-}
-static DEVICE_ATTR_RO(durations);
-
-static ssize_t timeouts_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
-{
-	struct tpm_chip *chip = to_tpm_chip(dev);
-
-	return sprintf(buf, "%d %d %d %d [%s]\n",
-		       jiffies_to_usecs(chip->timeout_a),
-		       jiffies_to_usecs(chip->timeout_b),
-		       jiffies_to_usecs(chip->timeout_c),
-		       jiffies_to_usecs(chip->timeout_d),
-		       chip->timeout_adjusted
-		       ? "adjusted" : "original");
-}
-static DEVICE_ATTR_RO(timeouts);
-
 static struct attribute *tpm_dev_attrs[] = {
 	&dev_attr_pubek.attr,
 	&dev_attr_pcrs.attr,
@@ -293,8 +261,6 @@ static struct attribute *tpm_dev_attrs[] = {
 	&dev_attr_temp_deactivated.attr,
 	&dev_attr_caps.attr,
 	&dev_attr_cancel.attr,
-	&dev_attr_durations.attr,
-	&dev_attr_timeouts.attr,
 	NULL,
 };
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f27d1f38a93d..d5c1c7e52086 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -50,14 +50,17 @@ enum tpm_const {
 	TPM_NUM_EVENT_LOG_FILES = 3,
 };
 
-enum tpm_timeout {
-	TPM_TIMEOUT = 5,	/* msecs */
-	TPM_TIMEOUT_RETRY = 100, /* msecs */
-	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
-	TPM_TIMEOUT_POLL = 1,	/* msecs */
-	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
-	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
-};
+/*
+ * Universal timeout, long enough for all commands.
+ */
+#define TPM_UNIVERSAL_TIMEOUT_MS 5000
+#define TPM_UNIVERSAL_TIMEOUT_JIFFIES msecs_to_jiffies(TPM_UNIVERSAL_TIMEOUT_MS)
+
+#define TPM_TIMEOUT_POLL_MS 1
+#define TPM_TIMEOUT_POLL_JIFFIES msecs_to_jiffies(TPM_TIMEOUT_POLL_MS)
+
+#define TPM_TIMEOUT_USECS_MIN 100
+#define TPM_TIMEOUT_USECS_MAX 500
 
 /* TPM addresses */
 enum tpm_addr {
@@ -65,16 +68,6 @@ enum tpm_addr {
 	TPM_ADDR = 0x4E,
 };
 
-/* Indexes the duration array */
-enum tpm_duration {
-	TPM_SHORT = 0,
-	TPM_MEDIUM = 1,
-	TPM_LONG = 2,
-	TPM_LONG_LONG = 3,
-	TPM_UNDEFINED,
-	TPM_NUM_DURATIONS = TPM_UNDEFINED,
-};
-
 #define TPM_WARN_RETRY          0x800
 #define TPM_WARN_DOING_SELFTEST 0x802
 #define TPM_ERR_DEACTIVATED     0x6
@@ -88,18 +81,6 @@ enum tpm2_const {
 	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
 };
 
-enum tpm2_timeouts {
-	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   2000,
-	TPM2_TIMEOUT_C          =    200,
-	TPM2_TIMEOUT_D          =     30,
-	TPM2_DURATION_SHORT     =     20,
-	TPM2_DURATION_MEDIUM    =    750,
-	TPM2_DURATION_LONG      =   2000,
-	TPM2_DURATION_LONG_LONG = 300000,
-	TPM2_DURATION_DEFAULT   = 120000,
-};
-
 enum tpm2_structures {
 	TPM2_ST_NO_SESSIONS	= 0x8001,
 	TPM2_ST_SESSIONS	= 0x8002,
@@ -244,14 +225,6 @@ struct tpm_chip {
 
 	struct mutex tpm_mutex;	/* tpm is processing */
 
-	unsigned long timeout_a; /* jiffies */
-	unsigned long timeout_b; /* jiffies */
-	unsigned long timeout_c; /* jiffies */
-	unsigned long timeout_d; /* jiffies */
-	bool timeout_adjusted;
-	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
-	bool duration_adjusted;
-
 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
 
 	const struct attribute_group *groups[3];
@@ -506,29 +479,24 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 void *buf, size_t bufsiz,
 			 size_t min_rsp_body_length, unsigned int flags,
 			 const char *desc);
-int tpm_get_timeouts(struct tpm_chip *);
 int tpm_auto_startup(struct tpm_chip *chip);
 
 int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr);
 int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm1_do_selftest(struct tpm_chip *chip);
-int tpm1_get_timeouts(struct tpm_chip *chip);
-unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg);
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
 int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
-unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
 
 static inline void tpm_msleep(unsigned int delay_msec)
 {
-	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
-		     delay_msec * 1000);
-};
+	usleep_range((delay_msec * 1000) - 300, delay_msec * 1000);
+}
 
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 __must_check int tpm_try_get_ops(struct tpm_chip *chip);
@@ -557,7 +525,6 @@ static inline u32 tpm2_rc_value(u32 rc)
 	return (rc & BIT(7)) ? rc & 0xff : rc;
 }
 
-int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 		    struct tpm2_digest *digests);
@@ -575,7 +542,6 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 
 int tpm2_auto_startup(struct tpm_chip *chip);
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
-unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm2_probe(struct tpm_chip *chip);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
 int tpm2_init_space(struct tpm_space *space);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 6f306338953b..8c5255909f07 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -24,293 +24,11 @@
 
 #define TPM_MAX_ORDINAL 243
 
-/*
- * Array with one entry per ordinal defining the maximum amount
- * of time the chip could take to return the result.  The ordinal
- * designation of short, medium or long is defined in a table in
- * TCG Specification TPM Main Part 2 TPM Structures Section 17. The
- * values of the SHORT, MEDIUM, and LONG durations are retrieved
- * from the chip during initialization with a call to tpm_get_timeouts.
- */
-static const u8 tpm1_ordinal_duration[TPM_MAX_ORDINAL] = {
-	TPM_UNDEFINED,		/* 0 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 5 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 10 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_LONG,
-	TPM_LONG,
-	TPM_MEDIUM,		/* 15 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_LONG,
-	TPM_SHORT,		/* 20 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_SHORT,		/* 25 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,		/* 30 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 35 */
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 40 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 45 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_LONG,
-	TPM_MEDIUM,		/* 50 */
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 55 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 60 */
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,		/* 65 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 70 */
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 75 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_LONG,		/* 80 */
-	TPM_UNDEFINED,
-	TPM_MEDIUM,
-	TPM_LONG,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 85 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 90 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 95 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 100 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 105 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 110 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 115 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_LONG,		/* 120 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_SHORT,		/* 125 */
-	TPM_SHORT,
-	TPM_LONG,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 130 */
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,		/* 135 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 140 */
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 145 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 150 */
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 155 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 160 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 165 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_LONG,		/* 170 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 175 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 180 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,		/* 185 */
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 190 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 195 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 200 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_SHORT,		/* 205 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,		/* 210 */
-	TPM_UNDEFINED,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,		/* 215 */
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_SHORT,		/* 220 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 225 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 230 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 235 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 240 */
-	TPM_UNDEFINED,
-	TPM_MEDIUM,
-};
-
-/**
- * tpm1_calc_ordinal_duration() - calculate the maximum command duration
- * @chip:    TPM chip to use.
- * @ordinal: TPM command ordinal.
- *
- * The function returns the maximum amount of time the chip could take
- * to return the result for a particular ordinal in jiffies.
- *
- * Return: A maximal duration time for an ordinal in jiffies.
- */
-unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
-{
-	int duration_idx = TPM_UNDEFINED;
-	int duration = 0;
-
-	/*
-	 * We only have a duration table for protected commands, where the upper
-	 * 16 bits are 0. For the few other ordinals the fallback will be used.
-	 */
-	if (ordinal < TPM_MAX_ORDINAL)
-		duration_idx = tpm1_ordinal_duration[ordinal];
-
-	if (duration_idx != TPM_UNDEFINED)
-		duration = chip->duration[duration_idx];
-	if (duration <= 0)
-		return 2 * 60 * HZ;
-	else
-		return duration;
-}
-
 #define TPM_ORD_STARTUP 153
 #define TPM_ST_CLEAR 1
 
+#define TPM_TIMEOUT_RETRY 100
+
 /**
  * tpm_startup() - turn on the TPM
  * @chip: TPM chip to use
@@ -342,112 +60,6 @@ static int tpm1_startup(struct tpm_chip *chip)
 	return rc;
 }
 
-int tpm1_get_timeouts(struct tpm_chip *chip)
-{
-	cap_t cap;
-	unsigned long timeout_old[4], timeout_chip[4], timeout_eff[4];
-	ssize_t rc;
-
-	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
-			 sizeof(cap.timeout));
-	if (rc == TPM_ERR_INVALID_POSTINIT) {
-		if (tpm1_startup(chip))
-			return rc;
-
-		rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
-				 "attempting to determine the timeouts",
-				 sizeof(cap.timeout));
-	}
-
-	if (rc) {
-		dev_err(&chip->dev, "A TPM error (%zd) occurred attempting to determine the timeouts\n",
-			rc);
-		return rc;
-	}
-
-	timeout_old[0] = jiffies_to_usecs(chip->timeout_a);
-	timeout_old[1] = jiffies_to_usecs(chip->timeout_b);
-	timeout_old[2] = jiffies_to_usecs(chip->timeout_c);
-	timeout_old[3] = jiffies_to_usecs(chip->timeout_d);
-	timeout_chip[0] = be32_to_cpu(cap.timeout.a);
-	timeout_chip[1] = be32_to_cpu(cap.timeout.b);
-	timeout_chip[2] = be32_to_cpu(cap.timeout.c);
-	timeout_chip[3] = be32_to_cpu(cap.timeout.d);
-	memcpy(timeout_eff, timeout_chip, sizeof(timeout_eff));
-
-	/*
-	 * Provide ability for vendor overrides of timeout values in case
-	 * of misreporting.
-	 */
-	if (chip->ops->update_timeouts)
-		chip->timeout_adjusted =
-			chip->ops->update_timeouts(chip, timeout_eff);
-
-	if (!chip->timeout_adjusted) {
-		/* Restore default if chip reported 0 */
-		unsigned int i;
-
-		for (i = 0; i < ARRAY_SIZE(timeout_eff); i++) {
-			if (timeout_eff[i])
-				continue;
-
-			timeout_eff[i] = timeout_old[i];
-			chip->timeout_adjusted = true;
-		}
-
-		if (timeout_eff[0] != 0 && timeout_eff[0] < 1000) {
-			/* timeouts in msec rather usec */
-			for (i = 0; i != ARRAY_SIZE(timeout_eff); i++)
-				timeout_eff[i] *= 1000;
-			chip->timeout_adjusted = true;
-		}
-	}
-
-	/* Report adjusted timeouts */
-	if (chip->timeout_adjusted) {
-		dev_info(&chip->dev, HW_ERR "Adjusting reported timeouts: A %lu->%luus B %lu->%luus C %lu->%luus D %lu->%luus\n",
-			 timeout_chip[0], timeout_eff[0],
-			 timeout_chip[1], timeout_eff[1],
-			 timeout_chip[2], timeout_eff[2],
-			 timeout_chip[3], timeout_eff[3]);
-	}
-
-	chip->timeout_a = usecs_to_jiffies(timeout_eff[0]);
-	chip->timeout_b = usecs_to_jiffies(timeout_eff[1]);
-	chip->timeout_c = usecs_to_jiffies(timeout_eff[2]);
-	chip->timeout_d = usecs_to_jiffies(timeout_eff[3]);
-
-	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_DURATION, &cap,
-			 "attempting to determine the durations",
-			  sizeof(cap.duration));
-	if (rc)
-		return rc;
-
-	chip->duration[TPM_SHORT] =
-		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_short));
-	chip->duration[TPM_MEDIUM] =
-		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_medium));
-	chip->duration[TPM_LONG] =
-		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_long));
-	chip->duration[TPM_LONG_LONG] = 0; /* not used under 1.2 */
-
-	/* The Broadcom BCM0102 chipset in a Dell Latitude D820 gets the above
-	 * value wrong and apparently reports msecs rather than usecs. So we
-	 * fix up the resulting too-small TPM_SHORT value to make things work.
-	 * We also scale the TPM_MEDIUM and -_LONG values by 1000.
-	 */
-	if (chip->duration[TPM_SHORT] < (HZ / 100)) {
-		chip->duration[TPM_SHORT] = HZ;
-		chip->duration[TPM_MEDIUM] *= 1000;
-		chip->duration[TPM_LONG] *= 1000;
-		chip->duration_adjusted = true;
-		dev_info(&chip->dev, "Adjusting TPM timeout parameters.");
-	}
-
-	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
-	return 0;
-}
-
 #define TPM_ORD_PCR_EXTEND 20
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg)
@@ -639,12 +251,9 @@ int tpm1_do_selftest(struct tpm_chip *chip)
 	int rc;
 	unsigned int loops;
 	unsigned int delay_msec = 100;
-	unsigned long duration;
 	u8 dummy[TPM_DIGEST_SIZE];
 
-	duration = tpm1_calc_ordinal_duration(chip, TPM_ORD_CONTINUE_SELFTEST);
-
-	loops = jiffies_to_msecs(duration) / delay_msec;
+	loops = TPM_UNIVERSAL_TIMEOUT_MS / delay_msec;
 
 	rc = tpm1_continue_selftest(chip);
 	if (rc == TPM_ERR_INVALID_POSTINIT) {
@@ -698,11 +307,31 @@ EXPORT_SYMBOL_GPL(tpm1_do_selftest);
  */
 int tpm1_auto_startup(struct tpm_chip *chip)
 {
+	cap_t unused;
 	int rc;
 
-	rc = tpm1_get_timeouts(chip);
-	if (rc)
-		goto out;
+	/*
+	 * We now ignore the timeouts the device specifies, but the original
+	 * initialization sequence began by asking for them so we still do.
+	 */
+
+	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &unused, NULL,
+			 sizeof(unused.timeout));
+	if (rc == TPM_ERR_INVALID_POSTINIT) {
+		if (tpm1_startup(chip))
+			return rc;
+
+		rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &unused,
+				 "attempting to determine the timeouts",
+				 sizeof(unused.timeout));
+	}
+
+
+	if (rc) {
+		dev_err(&chip->dev, "TPM failed to init (%d)\n", rc);
+		return rc;
+	}
+
 	rc = tpm1_do_selftest(chip);
 	if (rc) {
 		dev_err(&chip->dev, "TPM self test failed\n");
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a6bec13afa69..ab4d6d42888e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -40,122 +40,6 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SM3_256, TPM2_ALG_SM3_256},
 };
 
-int tpm2_get_timeouts(struct tpm_chip *chip)
-{
-	/* Fixed timeouts for TPM2 */
-	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
-	chip->timeout_b = msecs_to_jiffies(TPM2_TIMEOUT_B);
-	chip->timeout_c = msecs_to_jiffies(TPM2_TIMEOUT_C);
-	chip->timeout_d = msecs_to_jiffies(TPM2_TIMEOUT_D);
-
-	/* PTP spec timeouts */
-	chip->duration[TPM_SHORT] = msecs_to_jiffies(TPM2_DURATION_SHORT);
-	chip->duration[TPM_MEDIUM] = msecs_to_jiffies(TPM2_DURATION_MEDIUM);
-	chip->duration[TPM_LONG] = msecs_to_jiffies(TPM2_DURATION_LONG);
-
-	/* Key creation commands long timeouts */
-	chip->duration[TPM_LONG_LONG] =
-		msecs_to_jiffies(TPM2_DURATION_LONG_LONG);
-
-	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
-
-	return 0;
-}
-
-/**
- * tpm2_ordinal_duration_index() - returns an index to the chip duration table
- * @ordinal: TPM command ordinal.
- *
- * The function returns an index to the chip duration table
- * (enum tpm_duration), that describes the maximum amount of
- * time the chip could take to return the result for a  particular ordinal.
- *
- * The values of the MEDIUM, and LONG durations are taken
- * from the PC Client Profile (PTP) specification (750, 2000 msec)
- *
- * LONG_LONG is for commands that generates keys which empirically takes
- * a longer time on some systems.
- *
- * Return:
- * * TPM_MEDIUM
- * * TPM_LONG
- * * TPM_LONG_LONG
- * * TPM_UNDEFINED
- */
-static u8 tpm2_ordinal_duration_index(u32 ordinal)
-{
-	switch (ordinal) {
-	/* Startup */
-	case TPM2_CC_STARTUP:                 /* 144 */
-		return TPM_MEDIUM;
-
-	case TPM2_CC_SELF_TEST:               /* 143 */
-		return TPM_LONG;
-
-	case TPM2_CC_GET_RANDOM:              /* 17B */
-		return TPM_LONG;
-
-	case TPM2_CC_SEQUENCE_UPDATE:         /* 15C */
-		return TPM_MEDIUM;
-	case TPM2_CC_SEQUENCE_COMPLETE:       /* 13E */
-		return TPM_MEDIUM;
-	case TPM2_CC_EVENT_SEQUENCE_COMPLETE: /* 185 */
-		return TPM_MEDIUM;
-	case TPM2_CC_HASH_SEQUENCE_START:     /* 186 */
-		return TPM_MEDIUM;
-
-	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
-		return TPM_LONG;
-
-	case TPM2_CC_PCR_EXTEND:              /* 182 */
-		return TPM_MEDIUM;
-
-	case TPM2_CC_HIERARCHY_CONTROL:       /* 121 */
-		return TPM_LONG;
-	case TPM2_CC_HIERARCHY_CHANGE_AUTH:   /* 129 */
-		return TPM_LONG;
-
-	case TPM2_CC_GET_CAPABILITY:          /* 17A */
-		return TPM_MEDIUM;
-
-	case TPM2_CC_NV_READ:                 /* 14E */
-		return TPM_LONG;
-
-	case TPM2_CC_CREATE_PRIMARY:          /* 131 */
-		return TPM_LONG_LONG;
-	case TPM2_CC_CREATE:                  /* 153 */
-		return TPM_LONG_LONG;
-	case TPM2_CC_CREATE_LOADED:           /* 191 */
-		return TPM_LONG_LONG;
-
-	default:
-		return TPM_UNDEFINED;
-	}
-}
-
-/**
- * tpm2_calc_ordinal_duration() - calculate the maximum command duration
- * @chip:    TPM chip to use.
- * @ordinal: TPM command ordinal.
- *
- * The function returns the maximum amount of time the chip could take
- * to return the result for a particular ordinal in jiffies.
- *
- * Return: A maximal duration time for an ordinal in jiffies.
- */
-unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
-{
-	unsigned int index;
-
-	index = tpm2_ordinal_duration_index(ordinal);
-
-	if (index != TPM_UNDEFINED)
-		return chip->duration[index];
-	else
-		return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
-}
-
-
 struct tpm2_pcr_read_out {
 	__be32	update_cnt;
 	__be32	pcr_selects_cnt;
@@ -987,10 +871,6 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 {
 	int rc;
 
-	rc = tpm2_get_timeouts(chip);
-	if (rc)
-		goto out;
-
 	rc = tpm2_do_selftest(chip);
 	if (rc && rc != TPM2_RC_INITIALIZE)
 		goto out;
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 36952ef98f90..f683667ed0e4 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -112,14 +112,13 @@ struct tpm2_crb_smc {
 	u32 smc_func_id;
 };
 
-static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
-				unsigned long timeout)
+static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value)
 {
 	ktime_t start;
 	ktime_t stop;
 
 	start = ktime_get();
-	stop = ktime_add(start, ms_to_ktime(timeout));
+	stop = ktime_add(start, ms_to_ktime(TPM_UNIVERSAL_TIMEOUT_MS));
 
 	do {
 		if ((ioread32(reg) & mask) == value)
@@ -157,9 +156,7 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
 	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
 
 	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
-				 CRB_CTRL_REQ_GO_IDLE/* mask */,
-				 0, /* value */
-				 TPM2_TIMEOUT_C)) {
+				 CRB_CTRL_REQ_GO_IDLE, 0)) {
 		dev_warn(dev, "goIdle timed out\n");
 		return -ETIME;
 	}
@@ -183,7 +180,6 @@ static int crb_go_idle(struct tpm_chip *chip)
  *
  * Write CRB_CTRL_REQ_CMD_READY to TPM_CRB_CTRL_REQ
  * and poll till the device acknowledge it by clearing the bit.
- * The device should respond within TIMEOUT_C.
  *
  * The function does nothing for devices with ACPI-start method
  * or SMC-start method.
@@ -199,9 +195,7 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
 
 	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
 	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
-				 CRB_CTRL_REQ_CMD_READY /* mask */,
-				 0, /* value */
-				 TPM2_TIMEOUT_C)) {
+				 CRB_CTRL_REQ_CMD_READY, 0)) {
 		dev_warn(dev, "cmdReady timed out\n");
 		return -ETIME;
 	}
@@ -227,8 +221,7 @@ static int __crb_request_locality(struct device *dev,
 		return 0;
 
 	iowrite32(CRB_LOC_CTRL_REQUEST_ACCESS, &priv->regs_h->loc_ctrl);
-	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, value, value,
-				 TPM2_TIMEOUT_C)) {
+	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, value, value)) {
 		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
 		return -ETIME;
 	}
@@ -254,8 +247,7 @@ static int __crb_relinquish_locality(struct device *dev,
 		return 0;
 
 	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
-	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
-				 TPM2_TIMEOUT_C)) {
+	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value)) {
 		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
 		return -ETIME;
 	}
diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index 95ce2e9ccdc6..b058829eccf8 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -169,12 +169,6 @@ static int i2c_atmel_probe(struct i2c_client *client,
 	if (!priv)
 		return -ENOMEM;
 
-	/* Default timeouts */
-	chip->timeout_a = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-	chip->timeout_b = msecs_to_jiffies(TPM_I2C_LONG_TIMEOUT);
-	chip->timeout_c = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-	chip->timeout_d = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-
 	dev_set_drvdata(&chip->dev, priv);
 
 	/* There is no known way to probe for this device, and all version
diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 9086edc9066b..6354cea0036b 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -50,7 +50,7 @@
 #define SLEEP_DURATION_RESET_HI 2600
 
 /* we want to use usleep_range instead of msleep for the 5ms TPM_TIMEOUT */
-#define TPM_TIMEOUT_US_LOW (TPM_TIMEOUT * 1000)
+#define TPM_TIMEOUT_US_LOW (TPM_TIMEOUT_POLL_MS * 1000)
 #define TPM_TIMEOUT_US_HI  (TPM_TIMEOUT_US_LOW + 2000)
 
 /* expected value for DIDVID register */
@@ -304,11 +304,6 @@ enum tis_status {
 	TPM_STS_DATA_EXPECT = 0x08,
 };
 
-enum tis_defaults {
-	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
-};
-
 #define	TPM_ACCESS(l)			(0x0000 | ((l) << 4))
 #define	TPM_STS(l)			(0x0001 | ((l) << 4))
 #define	TPM_DATA_FIFO(l)		(0x0005 | ((l) << 4))
@@ -357,7 +352,7 @@ static int request_locality(struct tpm_chip *chip, int loc)
 	iic_tpm_write(TPM_ACCESS(loc), &buf, 1);
 
 	/* wait for burstcount */
-	stop = jiffies + chip->timeout_a;
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 	do {
 		if (check_locality(chip, loc))
 			return loc;
@@ -399,7 +394,7 @@ static ssize_t get_burstcount(struct tpm_chip *chip)
 
 	/* wait for burstcount */
 	/* which timeout value, spec has 2 answers (c & d) */
-	stop = jiffies + chip->timeout_d;
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 	do {
 		/* Note: STS is little endian */
 		if (iic_tpm_read(TPM_STS(tpm_dev.locality)+1, buf, 3) < 0)
@@ -415,8 +410,7 @@ static ssize_t get_burstcount(struct tpm_chip *chip)
 	return -EBUSY;
 }
 
-static int wait_for_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,
-			 int *status)
+static int wait_for_stat(struct tpm_chip *chip, u8 mask, int *status)
 {
 	unsigned long stop;
 
@@ -425,7 +419,7 @@ static int wait_for_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,
 	if ((*status != 0xFF) && (*status & mask) == mask)
 		return 0;
 
-	stop = jiffies + timeout;
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 	do {
 		/* since we just checked the status, give the TPM some time */
 		usleep_range(TPM_TIMEOUT_US_LOW, TPM_TIMEOUT_US_HI);
@@ -502,7 +496,7 @@ static int tpm_tis_i2c_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	wait_for_stat(chip, TPM_STS_VALID, chip->timeout_c, &status);
+	wait_for_stat(chip, TPM_STS_VALID, &status);
 	if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
 		dev_err(&chip->dev, "Error left over data\n");
 		size = -EIO;
@@ -536,9 +530,7 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	status = tpm_tis_i2c_status(chip);
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
 		tpm_tis_i2c_ready(chip);
-		if (wait_for_stat
-		    (chip, TPM_STS_COMMAND_READY,
-		     chip->timeout_b, &status) < 0) {
+		if (wait_for_stat(chip, TPM_STS_COMMAND_READY, &status) < 0) {
 			rc = -ETIME;
 			goto out_err;
 		}
@@ -567,8 +559,7 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t len)
 			goto out_err;
 		}
 
-		wait_for_stat(chip, TPM_STS_VALID,
-			      chip->timeout_c, &status);
+		wait_for_stat(chip, TPM_STS_VALID, &status);
 
 		if ((status & TPM_STS_DATA_EXPECT) == 0) {
 			rc = -EIO;
@@ -578,7 +569,7 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t len)
 
 	/* write last byte */
 	iic_tpm_write(TPM_DATA_FIFO(tpm_dev.locality), &(buf[count]), 1);
-	wait_for_stat(chip, TPM_STS_VALID, chip->timeout_c, &status);
+	wait_for_stat(chip, TPM_STS_VALID, &status);
 	if ((status & TPM_STS_DATA_EXPECT) != 0) {
 		rc = -EIO;
 		goto out_err;
@@ -624,12 +615,6 @@ static int tpm_tis_i2c_init(struct device *dev)
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
-	/* Default timeouts */
-	chip->timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-	chip->timeout_b = msecs_to_jiffies(TIS_LONG_TIMEOUT);
-	chip->timeout_c = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-	chip->timeout_d = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-
 	if (request_locality(chip, 0) != 0) {
 		dev_err(dev, "could not request locality\n");
 		rc = -ENODEV;
diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index 217f7f1cbde8..38ab38b8c4e5 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -149,7 +149,7 @@ static void i2c_nuvoton_ready(struct tpm_chip *chip)
 static int i2c_nuvoton_get_burstcount(struct i2c_client *client,
 				      struct tpm_chip *chip)
 {
-	unsigned long stop = jiffies + chip->timeout_d;
+	unsigned long stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 	s32 status;
 	int burst_count = -1;
 	u8 data;
@@ -182,7 +182,7 @@ static bool i2c_nuvoton_check_status(struct tpm_chip *chip, u8 mask, u8 value)
 }
 
 static int i2c_nuvoton_wait_for_stat(struct tpm_chip *chip, u8 mask, u8 value,
-				     u32 timeout, wait_queue_head_t *queue)
+				     wait_queue_head_t *queue)
 {
 	if ((chip->flags & TPM_CHIP_FLAG_IRQ) && queue) {
 		s32 rc;
@@ -192,7 +192,7 @@ static int i2c_nuvoton_wait_for_stat(struct tpm_chip *chip, u8 mask, u8 value,
 		enable_irq(priv->irq);
 		rc = wait_event_interruptible_timeout(*queue,
 						      cur_intrs != priv->intrs,
-						      timeout);
+						      TPM_UNIVERSAL_TIMEOUT_JIFFIES);
 		if (rc > 0)
 			return 0;
 		/* At this point we know that the SINT pin is asserted, so we
@@ -208,7 +208,7 @@ static int i2c_nuvoton_wait_for_stat(struct tpm_chip *chip, u8 mask, u8 value,
 
 		/* use polling to wait for the event */
 		ten_msec = jiffies + usecs_to_jiffies(TPM_I2C_RETRY_DELAY_LONG);
-		stop = jiffies + timeout;
+		stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 		do {
 			if (time_before(jiffies, ten_msec))
 				usleep_range(TPM_I2C_RETRY_DELAY_SHORT,
@@ -230,13 +230,13 @@ static int i2c_nuvoton_wait_for_stat(struct tpm_chip *chip, u8 mask, u8 value,
 }
 
 /* wait for dataAvail field to be set in the TPM_STS register */
-static int i2c_nuvoton_wait_for_data_avail(struct tpm_chip *chip, u32 timeout,
+static int i2c_nuvoton_wait_for_data_avail(struct tpm_chip *chip,
 					   wait_queue_head_t *queue)
 {
 	return i2c_nuvoton_wait_for_stat(chip,
 					 TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 					 TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-					 timeout, queue);
+					 queue);
 }
 
 /* Read @count bytes into @buf from TPM_RD_FIFO register */
@@ -249,7 +249,6 @@ static int i2c_nuvoton_recv_data(struct i2c_client *client,
 
 	while (size < count &&
 	       i2c_nuvoton_wait_for_data_avail(chip,
-					       chip->timeout_c,
 					       &priv->read_queue) == 0) {
 		burst_count = i2c_nuvoton_get_burstcount(client, chip);
 		if (burst_count < 0) {
@@ -303,7 +302,7 @@ static int i2c_nuvoton_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		 * tag, paramsize, and result
 		 */
 		status = i2c_nuvoton_wait_for_data_avail(
-			chip, chip->timeout_c, &priv->read_queue);
+			chip, &priv->read_queue);
 		if (status != 0) {
 			dev_err(dev, "%s() timeout on dataAvail\n", __func__);
 			size = -ETIMEDOUT;
@@ -343,8 +342,7 @@ static int i2c_nuvoton_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		}
 		if (i2c_nuvoton_wait_for_stat(
 			    chip, TPM_STS_VALID | TPM_STS_DATA_AVAIL,
-			    TPM_STS_VALID, chip->timeout_c,
-			    NULL)) {
+			    TPM_STS_VALID, NULL)) {
 			dev_err(dev, "%s() error left over data\n", __func__);
 			size = -ETIMEDOUT;
 			continue;
@@ -369,15 +367,13 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	struct device *dev = chip->dev.parent;
 	struct i2c_client *client = to_i2c_client(dev);
 	u32 ordinal;
-	unsigned long duration;
 	size_t count = 0;
 	int burst_count, bytes2write, retries, rc = -EIO;
 
 	for (retries = 0; retries < TPM_RETRY; retries++) {
 		i2c_nuvoton_ready(chip);
 		if (i2c_nuvoton_wait_for_stat(chip, TPM_STS_COMMAND_READY,
-					      TPM_STS_COMMAND_READY,
-					      chip->timeout_b, NULL)) {
+					      TPM_STS_COMMAND_READY, NULL)) {
 			dev_err(dev, "%s() timeout on commandReady\n",
 				__func__);
 			rc = -EIO;
@@ -409,7 +405,6 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 						       TPM_STS_EXPECT,
 						       TPM_STS_VALID |
 						       TPM_STS_EXPECT,
-						       chip->timeout_c,
 						       NULL);
 			if (rc < 0) {
 				dev_err(dev, "%s() timeout on Expect\n",
@@ -433,8 +428,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		dev_dbg(dev, "%s(last): %02x", __func__, buf[count]);
 		rc = i2c_nuvoton_wait_for_stat(chip,
 					       TPM_STS_VALID | TPM_STS_EXPECT,
-					       TPM_STS_VALID,
-					       chip->timeout_c, NULL);
+					       TPM_STS_VALID, NULL);
 		if (rc) {
 			dev_err(dev, "%s() timeout on Expect to clear\n",
 				__func__);
@@ -456,12 +450,11 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		return rc;
 	}
 	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
-	duration = tpm_calc_ordinal_duration(chip, ordinal);
 
-	rc = i2c_nuvoton_wait_for_data_avail(chip, duration, &priv->read_queue);
+	rc = i2c_nuvoton_wait_for_data_avail(chip, &priv->read_queue);
 	if (rc) {
-		dev_err(dev, "%s() timeout command duration %ld\n",
-			__func__, duration);
+		dev_err(dev, "%s() timeout command duration %d\n",
+			__func__, TPM_UNIVERSAL_TIMEOUT_MS);
 		i2c_nuvoton_ready(chip);
 		return rc;
 	}
@@ -572,12 +565,6 @@ static int i2c_nuvoton_probe(struct i2c_client *client,
 
 	init_waitqueue_head(&priv->read_queue);
 
-	/* Default timeouts */
-	chip->timeout_a = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-	chip->timeout_b = msecs_to_jiffies(TPM_I2C_LONG_TIMEOUT);
-	chip->timeout_c = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-	chip->timeout_d = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-
 	dev_set_drvdata(&chip->dev, priv);
 
 	/*
@@ -605,7 +592,6 @@ static int i2c_nuvoton_probe(struct i2c_client *client,
 			rc = i2c_nuvoton_wait_for_stat(chip,
 						       TPM_STS_COMMAND_READY,
 						       TPM_STS_COMMAND_READY,
-						       chip->timeout_b,
 						       NULL);
 			if (rc == 0) {
 				/*
@@ -622,7 +608,7 @@ static int i2c_nuvoton_probe(struct i2c_client *client,
 				i2c_nuvoton_ready(chip);
 			} else {
 				/*
-				 * timeout_b reached - command was
+				 * timeout reached - command was
 				 * aborted. TIS should now be in idle state -
 				 * only TPM_STS_VALID should be set
 				 */
diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
index 5d6cce74cd3f..2cfe79458bdd 100644
--- a/drivers/char/tpm/tpm_nsc.c
+++ b/drivers/char/tpm/tpm_nsc.c
@@ -85,7 +85,7 @@ static int wait_for_stat(struct tpm_chip *chip, u8 mask, u8 val, u8 * data)
 	/* wait for status */
 	stop = jiffies + 10 * HZ;
 	do {
-		msleep(TPM_TIMEOUT);
+		msleep(TPM_TIMEOUT_POLL_MS);
 		*data = inb(priv->base + 1);
 		if ((*data & mask) == val)
 			return 0;
@@ -109,9 +109,9 @@ static int nsc_wait_for_ready(struct tpm_chip *chip)
 		return 0;
 
 	/* wait for status */
-	stop = jiffies + 100;
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 	do {
-		msleep(TPM_TIMEOUT);
+		msleep(TPM_TIMEOUT_POLL_MS);
 		status = inb(priv->base + NSC_STATUS);
 		if (status & NSC_STATUS_OBF)
 			status = inb(priv->base + NSC_DATA);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index bf7e49cfa643..0a592efb28c4 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -49,10 +49,9 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 }
 
 static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
-		unsigned long timeout, wait_queue_head_t *queue,
-		bool check_cancel)
+		wait_queue_head_t *queue, bool check_cancel)
 {
-	unsigned long stop;
+	unsigned long stop, timeout;
 	long rc;
 	u8 status;
 	bool canceled = false;
@@ -62,8 +61,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 	if ((status & mask) == mask)
 		return 0;
 
-	stop = jiffies + timeout;
-
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
 again:
 		timeout = stop - jiffies;
@@ -102,7 +100,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 static int wait_startup(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	unsigned long stop = jiffies + chip->timeout_a;
+	unsigned long stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 
 	do {
 		int rc;
@@ -114,7 +112,7 @@ static int wait_startup(struct tpm_chip *chip, int l)
 
 		if (access & TPM_ACCESS_VALID)
 			return 0;
-		tpm_msleep(TPM_TIMEOUT);
+		tpm_msleep(TPM_TIMEOUT_POLL_MS);
 	} while (time_before(jiffies, stop));
 	return -1;
 }
@@ -163,7 +161,7 @@ static int release_locality(struct tpm_chip *chip, int l)
 
 	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
 
-	stop = jiffies + chip->timeout_a;
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
 again:
@@ -186,7 +184,7 @@ static int release_locality(struct tpm_chip *chip, int l)
 		do {
 			if (locality_inactive(chip, l))
 				return 0;
-			tpm_msleep(TPM_TIMEOUT);
+			tpm_msleep(TPM_TIMEOUT_POLL_MS);
 		} while (time_before(jiffies, stop));
 	}
 	return -1;
@@ -205,7 +203,7 @@ static int request_locality(struct tpm_chip *chip, int l)
 	if (rc < 0)
 		return rc;
 
-	stop = jiffies + chip->timeout_a;
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
 again:
@@ -227,7 +225,7 @@ static int request_locality(struct tpm_chip *chip, int l)
 		do {
 			if (check_locality(chip, l))
 				return l;
-			tpm_msleep(TPM_TIMEOUT);
+			tpm_msleep(TPM_TIMEOUT_POLL_MS);
 		} while (time_before(jiffies, stop));
 	}
 	return -1;
@@ -262,10 +260,7 @@ static int get_burstcount(struct tpm_chip *chip)
 	u32 value;
 
 	/* wait for burstcount */
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		stop = jiffies + chip->timeout_a;
-	else
-		stop = jiffies + chip->timeout_d;
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 	do {
 		rc = tpm_tis_read32(priv, TPM_STS(priv->locality), &value);
 		if (rc < 0)
@@ -287,7 +282,6 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 	while (size < count) {
 		rc = wait_for_tpm_stat(chip,
 				 TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-				 chip->timeout_c,
 				 &priv->read_queue, true);
 		if (rc < 0)
 			return rc;
@@ -341,7 +335,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
+	if (wait_for_tpm_stat(chip, TPM_STS_VALID,
 				&priv->int_queue, false) < 0) {
 		size = -ETIME;
 		goto out;
@@ -374,7 +368,7 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
 		tpm_tis_ready(chip);
 		if (wait_for_tpm_stat
-		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
+		    (chip, TPM_STS_COMMAND_READY,
 		     &priv->int_queue, false) < 0) {
 			rc = -ETIME;
 			goto out_err;
@@ -396,7 +390,7 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 
 		count += burstcnt;
 
-		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
+		if (wait_for_tpm_stat(chip, TPM_STS_VALID,
 					&priv->int_queue, false) < 0) {
 			rc = -ETIME;
 			goto out_err;
@@ -413,7 +407,7 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	if (rc < 0)
 		goto out_err;
 
-	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
+	if (wait_for_tpm_stat(chip, TPM_STS_VALID,
 				&priv->int_queue, false) < 0) {
 		rc = -ETIME;
 		goto out_err;
@@ -459,7 +453,6 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int rc;
 	u32 ordinal;
-	unsigned long dur;
 
 	rc = tpm_tis_send_data(chip, buf, len);
 	if (rc < 0)
@@ -473,9 +466,8 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
 		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
 
-		dur = tpm_calc_ordinal_duration(chip, ordinal);
 		if (wait_for_tpm_stat
-		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
+		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 		     &priv->read_queue, false) < 0) {
 			rc = -ETIME;
 			goto out_err;
@@ -510,48 +502,6 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	return rc;
 }
 
-struct tis_vendor_timeout_override {
-	u32 did_vid;
-	unsigned long timeout_us[4];
-};
-
-static const struct tis_vendor_timeout_override vendor_timeout_overrides[] = {
-	/* Atmel 3204 */
-	{ 0x32041114, { (TIS_SHORT_TIMEOUT*1000), (TIS_LONG_TIMEOUT*1000),
-			(TIS_SHORT_TIMEOUT*1000), (TIS_SHORT_TIMEOUT*1000) } },
-};
-
-static bool tpm_tis_update_timeouts(struct tpm_chip *chip,
-				    unsigned long *timeout_cap)
-{
-	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	int i, rc;
-	u32 did_vid;
-
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, true);
-
-	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &did_vid);
-	if (rc < 0)
-		goto out;
-
-	for (i = 0; i != ARRAY_SIZE(vendor_timeout_overrides); i++) {
-		if (vendor_timeout_overrides[i].did_vid != did_vid)
-			continue;
-		memcpy(timeout_cap, vendor_timeout_overrides[i].timeout_us,
-		       sizeof(vendor_timeout_overrides[i].timeout_us));
-		rc = true;
-	}
-
-	rc = false;
-
-out:
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, false);
-
-	return rc;
-}
-
 /*
  * Early probing for iTPM with STS_DATA_EXPECT flaw.
  * Try sending command without itpm flag set and if that
@@ -842,7 +792,6 @@ static const struct tpm_class_ops tpm_tis = {
 	.recv = tpm_tis_recv,
 	.send = tpm_tis_send,
 	.cancel = tpm_tis_ready,
-	.update_timeouts = tpm_tis_update_timeouts,
 	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_canceled = tpm_tis_req_canceled,
@@ -873,11 +822,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 
 	chip->hwrng.quality = priv->rng_quality;
 
-	/* Maximum timeouts */
-	chip->timeout_a = msecs_to_jiffies(TIS_TIMEOUT_A_MAX);
-	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
-	chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
-	chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
 	priv->phy_ops = phy_ops;
 	dev_set_drvdata(&chip->dev, priv);
 
@@ -967,16 +911,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	init_waitqueue_head(&priv->read_queue);
 	init_waitqueue_head(&priv->int_queue);
 	if (irq != -1) {
-		/* Before doing irq testing issue a command to the TPM in polling mode
-		 * to make sure it works. May as well use that command to set the
-		 * proper timeouts for the driver.
-		 */
-		if (tpm_get_timeouts(chip)) {
-			dev_err(dev, "Could not get TPM timeouts and durations\n");
-			rc = -ENODEV;
-			goto out_err;
-		}
-
 		if (irq) {
 			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
 						 irq);
diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index b150f87f38f5..fa9a1c94c12f 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -56,10 +56,9 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 }
 
 static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
-		unsigned long timeout, wait_queue_head_t *queue,
-		bool check_cancel)
+		wait_queue_head_t *queue, bool check_cancel)
 {
-	unsigned long stop;
+	unsigned long stop, timeout;
 	long rc;
 	u8 status;
 	bool canceled = false;
@@ -69,7 +68,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 	if ((status & mask) == mask)
 		return 0;
 
-	stop = jiffies + timeout;
+	stop = jiffies + TPM_UNIVERSAL_TIMEOUT_JIFFIES;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
 again:
@@ -91,7 +90,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			tpm_msleep(TPM_TIMEOUT);
+			tpm_msleep(TPM_TIMEOUT_POLL_MS);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -141,7 +140,6 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 	unsigned int offset = shr_data_offset(shr);
 
 	u32 ordinal;
-	unsigned long duration;
 
 	if (offset > PAGE_SIZE)
 		return -EINVAL;
@@ -150,7 +148,7 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 		return -EINVAL;
 
 	/* Wait for completion of any existing command or cancellation */
-	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, chip->timeout_c,
+	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE,
 			&priv->read_queue, true) < 0) {
 		vtpm_cancel(chip);
 		return -ETIME;
@@ -164,9 +162,8 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 	notify_remote_via_evtchn(priv->evtchn);
 
 	ordinal = be32_to_cpu(((struct tpm_input_header*)buf)->ordinal);
-	duration = tpm_calc_ordinal_duration(chip, ordinal);
 
-	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, duration,
+	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE,
 			&priv->read_queue, true) < 0) {
 		/* got a signal or timeout, try to cancel */
 		vtpm_cancel(chip);
@@ -187,7 +184,7 @@ static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		return -ECANCELED;
 
 	/* In theory the wait at the end of _send makes this one unnecessary */
-	if (wait_for_tpm_stat(chip, VTPM_STATUS_RESULT, chip->timeout_c,
+	if (wait_for_tpm_stat(chip, VTPM_STATUS_RESULT,
 			&priv->read_queue, true) < 0) {
 		vtpm_cancel(chip);
 		return -ETIME;
-- 
2.17.1

