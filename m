Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBDFC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0749020693
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559752948;
	bh=tnUHdOlrc3rIBKngjAMLoU0qfaMR5uL36FUK2j8EhRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ddHpHzpr9VRXFxzDuRbnza/uZJZVIsIgb9j3l05k+jZuGDj/h0Yn+dTYYv9YzxHvd
	 txl8sYe9XlfpLWH2ghnupZHoH5dLKvZIh0apwGlbKom2CCsmsbVUMRXIAsvvCdFfLX
	 jCWmYBqGnHVoyfvHeEEPxMxZ2n1F4sQTSgmhifM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfFEQm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbfFEQm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:42:27 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E0A3204EC;
        Wed,  5 Jun 2019 16:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559752945;
        bh=tnUHdOlrc3rIBKngjAMLoU0qfaMR5uL36FUK2j8EhRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJexOGmcwq/ETK3+QziyeHLpKxXgDrkfCpQn+rZHX9YvswDpi3Q4z7Y+9E6uvafa5
         XEZyix7wuXXrgz0uWu+k8DVieCoz2h/M+Tzg5A3MARuLIMUghZ/ahSC+/zLLQne/hq
         QQhaSFPAJLxkV7uKBg0R6J4CSyPkPtR3Ga/4Cyww=
Date:   Wed, 5 Jun 2019 12:42:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org
Subject: Re: [RFC 1/1] Add dm verity root hash pkcs7 sig validation.
Message-ID: <20190605164224.GE29739@sasha-vm>
References: <20190520215422.23939-1-jaskarankhurana@linux.microsoft.com>
 <20190520215422.23939-2-jaskarankhurana@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190520215422.23939-2-jaskarankhurana@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 02:54:22PM -0700, Jaskaran Khurana wrote:
>Adds in-kernel pkcs7 signature checking for the roothash of
>the dm-verity hash tree.
>
>The verification is to support cases where the roothash is not secured by
>Trusted Boot, UEFI Secureboot or similar technologies.
>One of the use cases for this is for dm-verity volumes mounted after boot,
>the root hash provided during the creation of the dm-verity volume has to
>be secure and thus in-kernel validation implemented here will be used
>before we trust the root hash and allow the block device to be created.
>
>The signature being provided for verification must verify the root hash and
>must be trusted by the builtin keyring for verification to succeed.
>
>Adds DM_VERITY_VERIFY_ROOTHASH_SIG: roothash verification
>against the roothash signature file *if* specified, if signature file is
>specified verification must succeed prior to creation of device mapper
>block device.
>
>Adds DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE: roothash signature *must* be
>specified for all dm verity volumes and verification must succeed prior
>to creation of device mapper block device.
>
>Signed-off-by: Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
>---
> drivers/md/Kconfig                |  23 ++++++
> drivers/md/Makefile               |   2 +-
> drivers/md/dm-verity-target.c     |  44 ++++++++--
> drivers/md/dm-verity-verify-sig.c | 129 ++++++++++++++++++++++++++++++
> drivers/md/dm-verity-verify-sig.h |  32 ++++++++
> 5 files changed, 222 insertions(+), 8 deletions(-)
> create mode 100644 drivers/md/dm-verity-verify-sig.c
> create mode 100644 drivers/md/dm-verity-verify-sig.h
>
>diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
>index db269a348b20..da4115753f25 100644
>--- a/drivers/md/Kconfig
>+++ b/drivers/md/Kconfig
>@@ -489,6 +489,29 @@ config DM_VERITY
>
> 	  If unsure, say N.
>
>+config DM_VERITY_VERIFY_ROOTHASH_SIG
>+	def_bool n
>+	bool "Verity data device root hash signature verification support"
>+	depends on DM_VERITY
>+	select SYSTEM_DATA_VERIFICATION
>+	  help
>+	  The device mapper target created by DM-VERITY can be validated if the
>+	  pre-generated tree of cryptographic checksums passed has a pkcs#7
>+	  signature file that can validate the roothash of the tree.
>+
>+	  If unsure, say N.
>+
>+config DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE
>+	def_bool n
>+	bool "Forces all dm verity data device root hash should be signed"
>+	depends on DM_VERITY_VERIFY_ROOTHASH_SIG
>+	  help
>+	  The device mapper target created by DM-VERITY will succeed only if the
>+	  pre-generated tree of cryptographic checksums passed also has a pkcs#7
>+	  signature file that can validate the roothash of the tree.
>+
>+	  If unsure, say N.
>+
> config DM_VERITY_FEC
> 	bool "Verity forward error correction support"
> 	depends on DM_VERITY
>diff --git a/drivers/md/Makefile b/drivers/md/Makefile
>index be7a6eb92abc..8a8c142bcfe1 100644
>--- a/drivers/md/Makefile
>+++ b/drivers/md/Makefile
>@@ -61,7 +61,7 @@ obj-$(CONFIG_DM_LOG_USERSPACE)	+= dm-log-userspace.o
> obj-$(CONFIG_DM_ZERO)		+= dm-zero.o
> obj-$(CONFIG_DM_RAID)	+= dm-raid.o
> obj-$(CONFIG_DM_THIN_PROVISIONING)	+= dm-thin-pool.o
>-obj-$(CONFIG_DM_VERITY)		+= dm-verity.o
>+obj-$(CONFIG_DM_VERITY)		+= dm-verity.o dm-verity-verify-sig.o

Can we avoid building dm-verity-verify-sig.o when
DM_VERITY_VERIFY_ROOTHASH_SIG is not set?

> obj-$(CONFIG_DM_CACHE)		+= dm-cache.o
> obj-$(CONFIG_DM_CACHE_SMQ)	+= dm-cache-smq.o
> obj-$(CONFIG_DM_ERA)		+= dm-era.o
>diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
>index f4c31ffaa88e..53aebfa8bc38 100644
>--- a/drivers/md/dm-verity-target.c
>+++ b/drivers/md/dm-verity-target.c
>@@ -16,7 +16,7 @@
>
> #include "dm-verity.h"
> #include "dm-verity-fec.h"
>-
>+#include "dm-verity-verify-sig.h"
> #include <linux/module.h>
> #include <linux/reboot.h>
>
>@@ -34,7 +34,11 @@
> #define DM_VERITY_OPT_IGN_ZEROES	"ignore_zero_blocks"
> #define DM_VERITY_OPT_AT_MOST_ONCE	"check_at_most_once"
>
>-#define DM_VERITY_OPTS_MAX		(2 + DM_VERITY_OPTS_FEC)
>+#define DM_VERITY_OPTS_MAX		(2 + DM_VERITY_OPTS_FEC + \
>+					 DM_VERITY_ROOT_HASH_VERIFICATION_OPTS)

It would be nice if DM_VERITY_OPTS_MAX would remain the same size as it
is now if DM_VERITY_VERIFY_ROOTHASH_SIG is not enabled.

>+#define DM_VERITY_MANDATORY_ARGS        10

This cleanup should be in a separate patch.

>+
>
> static unsigned dm_verity_prefetch_cluster = DM_VERITY_DEFAULT_PREFETCH_SIZE;
>
>@@ -855,7 +859,8 @@ static int verity_alloc_zero_digest(struct dm_verity *v)
> 	return r;
> }
>
>-static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v)
>+static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
>+				 struct dm_verity_sig_opts *verify_args)
> {
> 	int r;
> 	unsigned argc;
>@@ -904,6 +909,15 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v)
> 			if (r)
> 				return r;
> 			continue;
>+		} else if (verity_verify_is_sig_opt_arg(arg_name)) {
>+			r = verity_verify_sig_parse_opt_args(as, v,
>+							     verify_args,
>+							     &argc, arg_name);

Hm, I don't see empty verity_verify_is_sig_opt_arg() or
verity_verify_sig_parse_opt_args() for when this config option is
disabled.

>+			if (r) {
>+				ti->error = "Could not parse the sig args";
>+				return r;
>+			}
>+			continue;
> 		}
>
> 		ti->error = "Unrecognized verity feature request";
>@@ -930,6 +944,7 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v)
> static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> {
> 	struct dm_verity *v;
>+	struct dm_verity_sig_opts verify_args = {0};
> 	struct dm_arg_set as;
> 	unsigned int num;
> 	unsigned long long num_ll;
>@@ -937,6 +952,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> 	int i;
> 	sector_t hash_position;
> 	char dummy;
>+	char *root_hash_digest_to_validate = NULL;
>
> 	v = kzalloc(sizeof(struct dm_verity), GFP_KERNEL);
> 	if (!v) {
>@@ -956,7 +972,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> 		goto bad;
> 	}
>
>-	if (argc < 10) {
>+	if (argc < DM_VERITY_MANDATORY_ARGS) {
> 		ti->error = "Not enough arguments";
> 		r = -EINVAL;
> 		goto bad;
>@@ -1070,6 +1086,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> 		r = -EINVAL;
> 		goto bad;
> 	}
>+	root_hash_digest_to_validate = argv[8];

Can we avoid magic numbers?

>
> 	if (strcmp(argv[9], "-")) {
> 		v->salt_size = strlen(argv[9]) / 2;
>@@ -1087,19 +1104,28 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> 		}
> 	}
>
>-	argv += 10;
>-	argc -= 10;
>+	argv += DM_VERITY_MANDATORY_ARGS;
>+	argc -= DM_VERITY_MANDATORY_ARGS;
>
> 	/* Optional parameters */
> 	if (argc) {
> 		as.argc = argc;
> 		as.argv = argv;
>
>-		r = verity_parse_opt_args(&as, v);
>+		r = verity_parse_opt_args(&as, v, &verify_args);
> 		if (r < 0)
> 			goto bad;
> 	}
>
>+	/* Root hash signature is  a optional parameter*/
				   an
>+	r = verity_verify_root_hash(root_hash_digest_to_validate,
>+				    strlen(root_hash_digest_to_validate),
>+				    verify_args.sig,
>+				    verify_args.sig_size);
>+	if (r < 0) {
>+		ti->error = "Root hash verification failed";
>+		goto bad;
>+	}
> 	v->hash_per_block_bits =
> 		__fls((1 << v->hash_dev_block_bits) / v->digest_size);
>
>@@ -1165,9 +1191,13 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> 	ti->per_io_data_size = roundup(ti->per_io_data_size,
> 				       __alignof__(struct dm_verity_io));
>
>+	verity_verify_sig_opts_cleanup(&verify_args);
>+
> 	return 0;
>
> bad:
>+
>+	verity_verify_sig_opts_cleanup(&verify_args);
> 	verity_dtr(ti);
>
> 	return r;
>diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
>new file mode 100644
>index 000000000000..491c84eb58ef
>--- /dev/null
>+++ b/drivers/md/dm-verity-verify-sig.c
>@@ -0,0 +1,129 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright (C) 2019 Microsoft Corporation.
>+ *
>+ * Author:  Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
>+ *
>+ * This file is released under the GPLv2.

We don't need to state this, that's why we have SPDX.

>+ */
>+#include <linux/device-mapper.h>
>+#include <linux/verification.h>
>+#include "dm-verity.h"
>+#include "dm-verity-verify-sig.h"
>+
>+#define DM_VERITY_VERIFY_ERR(s) DM_VERITY_ROOT_HASH_VERIFICATION " " s
>+
>+bool verity_verify_is_sig_opt_arg(const char *arg_name)
>+{
>+	return (!strcasecmp(arg_name,
>+			    DM_VERITY_ROOT_HASH_VERIFICATION_OPT_SIG));
>+}
>+EXPORT_SYMBOL_GPL(verity_verify_is_sig_opt_arg);

For whom are all these symbols exported for?

>+
>+int verity_verify_sig_parse_opt_args(struct dm_arg_set *as,
>+				     struct dm_verity *v,
>+				     struct dm_verity_sig_opts *sig_opts,
>+				     unsigned int *argc,
>+				     const char *arg_name)
>+{
>+	const char *sig_size;
>+	const char *sig_buf;
>+	char dummy;
>+	struct dm_target *ti = v->ti;
>+	int r = 0;
>+
>+	if (*argc < DM_VERITY_ROOT_HASH_VERIFICATION_OPTS - 1) {
>+		ti->error = DM_VERITY_VERIFY_ERR("sig values not specified");
>+		return -EINVAL;
>+	}
>+
>+	sig_size = dm_shift_arg(as);
>+	(*argc)--;
>+
>+	if (strcasecmp(arg_name, DM_VERITY_ROOT_HASH_VERIFICATION_OPT_SIG) ||
>+	    sscanf(sig_size, "%u%c",
>+		   &sig_opts->sig_size, &dummy) != 1) {
>+		ti->error = DM_VERITY_VERIFY_ERR("invalid signature size");
>+		return -EINVAL;
>+	}
>+
>+	sig_buf = dm_shift_arg(as);
>+	(*argc)--;
>+
>+	if (strlen(sig_buf) != sig_opts->sig_size * 2) {
>+		ti->error = DM_VERITY_VERIFY_ERR("sig buffer, size: mismatch");
>+		return -EINVAL;
>+	}
>+
>+	sig_opts->sig =	kmalloc(sig_opts->sig_size, GFP_KERNEL);
>+	if (!sig_opts->sig) {
>+		r = -ENOMEM;
>+		goto end;

Why not return directly here?

>+	}
>+
>+	r = hex2bin(sig_opts->sig, sig_buf, sig_opts->sig_size);
>+
>+	if (r < 0) {
>+		ti->error = DM_VERITY_VERIFY_ERR("invalid roothash sig buf");
>+		r = -EINVAL;
>+		goto end;

We'll get to 'end' anyway.

>+	}
>+
>+end:
>+	if (r < 0)
>+		verity_verify_sig_opts_cleanup(sig_opts);
>+	return r;
>+}
>+EXPORT_SYMBOL_GPL(verity_verify_sig_parse_opt_args);
>+
>+#ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG
>+/*
>+ * verify_verify_roothash - Verify the root hash of the verity hash device
>+ *			     using builtin trusted keys.
>+ *
>+ * @root_hash: For verity, the roothash/data to be verified.
>+ * @root_hash_len: Size of the roothash/data to be verified.
>+ * @sig_data: The trusted signature that verifies the roothash/data.
>+ * @sig_len: Size of the signature.
>+ *
>+ */
>+int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
>+			    const void *sig_data, size_t sig_len)
>+{
>+	int r;
>+
>+	if (!root_hash || root_hash_len == 0)
>+		return -EINVAL;
>+
>+	if (!sig_data  || sig_len == 0) {
>+		if (IS_ENABLED(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE))
>+			return -EINVAL;

I'm not sure -EINVAL is the right failure here.

>+		else
>+			return 0;
>+	}
>+
>+	r = verify_pkcs7_signature(root_hash, root_hash_len, sig_data, sig_len,
>+				   NULL, VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
>+				   NULL);
>+	if (r < 0)
>+		goto end;

This statement makes no sense :)

>+
>+end:
>+	return r;
>+}
>+#else
>+int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
>+			    const void *sig_data, size_t sig_len)
>+{
>+	return 0;
>+}
>+#endif
>+EXPORT_SYMBOL_GPL(verity_verify_root_hash);
>+void verity_verify_sig_opts_cleanup(struct dm_verity_sig_opts *sig_opts)

Why doesn't this live somewhere inside verity_dtr()?

--
Thanks,
Sasha
