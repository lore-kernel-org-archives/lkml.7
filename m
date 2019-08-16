Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7A5C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3435320644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R2oB/ft4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfHPMZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:25:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58449 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHPMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:25:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GCP98J2801002
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 05:25:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GCP98J2801002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565958309;
        bh=WT5AhycWZYysrWH/S8jXTu4DVUQHLY0iSHg50Eu7hO4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=R2oB/ft41B6JrZrw+xQUVHg2kAx+SM5zFwdH7ghqi+ZQeIVymMqMZZgUW1+IhEt5T
         Yu2fHT5Z4/hj5AVIPJG38szOC5z6bB0ZigyufswCZOXaziqsZHm0XbFzDeCJ9FPYid
         K8kxYsEp7ZYswomqzIsb90fYLdJT6TMdklozEGh81Op/exrwvWfdsGM29H5vawsIYa
         tvt72qxOBoFUgf3lqXPvF6YkUStLptnAlBzF7v3ek9uf4Hr3h23tQo4kwOCtzvpb1r
         KgmpZWU7tjC5l9We9Rsf7cNgkPOGoI3AjuJq6c/HN7dJ+ziIlSh0Mzd63AS4cjcz3q
         xqINmXP+Y/7Pw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GCP8nK2800999;
        Fri, 16 Aug 2019 05:25:08 -0700
Date:   Fri, 16 Aug 2019 05:25:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for John Hubbard <tipbot@zytor.com>
Message-ID: <tip-a90118c445cc7f07781de26a9684d4ec58bfcfd1@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        jhubbard@nvidia.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, jhubbard@nvidia.com
In-Reply-To: <20190731054627.5627-2-jhubbard@nvidia.com>
References: <20190731054627.5627-2-jhubbard@nvidia.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot: Save fields explicitly, zero out
 everything else
Git-Commit-ID: a90118c445cc7f07781de26a9684d4ec58bfcfd1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a90118c445cc7f07781de26a9684d4ec58bfcfd1
Gitweb:     https://git.kernel.org/tip/a90118c445cc7f07781de26a9684d4ec58bfcfd1
Author:     John Hubbard <jhubbard@nvidia.com>
AuthorDate: Tue, 30 Jul 2019 22:46:27 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 16 Aug 2019 14:20:00 +0200

x86/boot: Save fields explicitly, zero out everything else

Recent gcc compilers (gcc 9.1) generate warnings about an out of bounds
memset, if the memset goes accross several fields of a struct. This
generated a couple of warnings on x86_64 builds in sanitize_boot_params().

Fix this by explicitly saving the fields in struct boot_params
that are intended to be preserved, and zeroing all the rest.

[ tglx: Tagged for stable as it breaks the warning free build there as well ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190731054627.5627-2-jhubbard@nvidia.com

---
 arch/x86/include/asm/bootparam_utils.h | 63 ++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 101eb944f13c..f5e90a849bca 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -18,6 +18,20 @@
  * Note: efi_info is commonly left uninitialized, but that field has a
  * private magic, so it is better to leave it unchanged.
  */
+
+#define sizeof_mbr(type, member) ({ sizeof(((type *)0)->member); })
+
+#define BOOT_PARAM_PRESERVE(struct_member)				\
+	{								\
+		.start = offsetof(struct boot_params, struct_member),	\
+		.len   = sizeof_mbr(struct boot_params, struct_member),	\
+	}
+
+struct boot_params_to_save {
+	unsigned int start;
+	unsigned int len;
+};
+
 static void sanitize_boot_params(struct boot_params *boot_params)
 {
 	/* 
@@ -35,21 +49,40 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 	 * problems again.
 	 */
 	if (boot_params->sentinel) {
-		/* fields in boot_params are left uninitialized, clear them */
-		boot_params->acpi_rsdp_addr = 0;
-		memset(&boot_params->ext_ramdisk_image, 0,
-		       (char *)&boot_params->efi_info -
-			(char *)&boot_params->ext_ramdisk_image);
-		memset(&boot_params->kbd_status, 0,
-		       (char *)&boot_params->hdr -
-		       (char *)&boot_params->kbd_status);
-		memset(&boot_params->_pad7[0], 0,
-		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
-			(char *)&boot_params->_pad7[0]);
-		memset(&boot_params->_pad8[0], 0,
-		       (char *)&boot_params->eddbuf[0] -
-			(char *)&boot_params->_pad8[0]);
-		memset(&boot_params->_pad9[0], 0, sizeof(boot_params->_pad9));
+		static struct boot_params scratch;
+		char *bp_base = (char *)boot_params;
+		char *save_base = (char *)&scratch;
+		int i;
+
+		const struct boot_params_to_save to_save[] = {
+			BOOT_PARAM_PRESERVE(screen_info),
+			BOOT_PARAM_PRESERVE(apm_bios_info),
+			BOOT_PARAM_PRESERVE(tboot_addr),
+			BOOT_PARAM_PRESERVE(ist_info),
+			BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
+			BOOT_PARAM_PRESERVE(hd0_info),
+			BOOT_PARAM_PRESERVE(hd1_info),
+			BOOT_PARAM_PRESERVE(sys_desc_table),
+			BOOT_PARAM_PRESERVE(olpc_ofw_header),
+			BOOT_PARAM_PRESERVE(efi_info),
+			BOOT_PARAM_PRESERVE(alt_mem_k),
+			BOOT_PARAM_PRESERVE(scratch),
+			BOOT_PARAM_PRESERVE(e820_entries),
+			BOOT_PARAM_PRESERVE(eddbuf_entries),
+			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
+			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
+			BOOT_PARAM_PRESERVE(e820_table),
+			BOOT_PARAM_PRESERVE(eddbuf),
+		};
+
+		memset(&scratch, 0, sizeof(scratch));
+
+		for (i = 0; i < ARRAY_SIZE(to_save); i++) {
+			memcpy(save_base + to_save[i].start,
+			       bp_base + to_save[i].start, to_save[i].len);
+		}
+
+		memcpy(boot_params, save_base, sizeof(*boot_params));
 	}
 }
 
