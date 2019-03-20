Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA5BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429CA213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCTQtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:49:10 -0400
Received: from authsmtp21.register.it ([81.88.48.44]:43165 "EHLO
        authsmtp.register.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726123AbfCTQtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:49:10 -0400
Received: from [192.168.1.1] ([93.41.32.9])
        by cmsmtp with ESMTPSA
        id 6eKCht8VTjSal6eKDhlSjd; Wed, 20 Mar 2019 17:44:21 +0100
X-Rid:  guido@trentalancia.com@93.41.32.9
Message-ID: <1553100260.5175.4.camel@trentalancia.com>
Subject: [PATCH v2] scsi: ignore Synchronize Cache command failures to keep
 using drives not supporting it
From:   Guido Trentalancia <guido@trentalancia.com>
To:     linux-kernel@vger.kernel.org
Cc:     eric@andante.org
Date:   Wed, 20 Mar 2019 17:44:20 +0100
In-Reply-To: <1552845068.5940.6.camel@trentalancia.com>
References: <1552845068.5940.6.camel@trentalancia.com>
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCn15N8s2wQzRl6ay30aMtcizvKybpp+nOKP25gk6X8IpHPzDKNnfjyaBJ6PwdbmjH2hQf0rlvb7wbmJ50x0F2UMpwN7z/fEjtQiMXGDw8yfOFSqCTQ/
 ZGs6JLwN/pYOoDsdJXzqqD3DJKT6IQeFqaSjkM+UxLX0BA9m5kDIJ2t3dzGSK61c/xOYanwGYamD3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many obsolete hard drives do not support the Synchronize Cache SCSI
command. Such command is generally issued during fsync() calls which
at the moment therefore fail with the ILLEGAL_REQUEST sense key.

Since this failure is currently treated as critical in the kernel SCSI
disk driver, such obsolete hard drives cannot be used anymore (at least
since kernel 4.10, maybe even earlier): they cannot be formatted,
mounted and/or checked using tools such as e2fsprogs.

Because there is nothing which can be done if the drive does not support
such command, such ILLEGAL_REQUEST should be treated as non-critical so
that the underlying operation does not fail and the obsolete hard drive
can be used normally.

This second version of the patch (v2) disables the Write Cache feature
as a precaution on hard drives which do not support the Synchronize Cache
command and therefore the cache flushing functionality.

Although the Write Cache is disabled (v2) when using such hard drives
which do not feature the Synchronize Cache SCSI command there is still
some risk of data loss in case of power cuts, USB cable disconnects and
so on: YOU HAVE BEEN WARNED - THE DRIVE MANIFACTURER SHOULD HAVE BEEN
WARNED YOU IN THE FIRST PLACE - IN DOUBT, UPGRADE TO A NEWER HARD DRIVE !!

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 drivers/scsi/sd.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff -pru linux-5.0.2-orig/drivers/scsi/sd.c linux-5.0.2/drivers/scsi/sd.c
--- linux-5.0.2-orig/drivers/scsi/sd.c	2019-03-17 18:22:04.822720851 +0100
+++ linux-5.0.2/drivers/scsi/sd.c	2019-03-20 17:41:44.526957307 +0100
@@ -22,6 +22,10 @@
  *	 - Badari Pulavarty <pbadari@us.ibm.com>, Matthew Wilcox 
  *	   <willy@debian.org>, Kurt Garloff <garloff@suse.de>: 
  *	   Support 32k/1M disks.
+ *	 - Guido Trentalancia <guido@trentalancia.com> ignore Synchronize
+ *	   Cache command failures on hard-drives that do not support it
+ *	   and disable the Write Cache functionality on such devices as a
+ *	   precaution: this allows to keep using several obsolete drives.
  *
  *	Logging policy (needs CONFIG_SCSI_LOGGING defined):
  *	 - setting up transfer: SCSI_LOG_HLQUEUE levels 1 and 2
@@ -1633,6 +1637,20 @@ static int sd_sync_cache(struct scsi_dis
 	}
 
 	if (res) {
+		/*
+		 * sshdr.sense_key == ILLEGAL_REQUEST means this drive
+		 * doesn't support sync. There's not much to do and
+		 * sync shouldn't fail.
+		 */
+		if (sshdr->sense_key == ILLEGAL_REQUEST && sshdr->asc == 0x20) {
+			if (sdkp->WCE) {
+				sdkp->WCE = 0;
+				sd_printk(KERN_NOTICE, sdkp, "Drive does not support Synchronize Cache(10) command: disabling write cache.\n");
+				sd_set_flush_flag(sdkp);
+			}
+			return 0;
+		}
+
 		sd_print_result(sdkp, "Synchronize Cache(10) failed", res);
 
 		if (driver_byte(res) == DRIVER_SENSE)
@@ -2022,6 +2040,17 @@ static int sd_done(struct scsi_cmnd *SCp
 					req->rq_flags |= RQF_QUIET;
 				}
 				break;
+			case SYNCHRONIZE_CACHE:
+				if (sshdr.asc == 0x20) {
+					if (sdkp->WCE) {
+						sdkp->WCE = 0;
+						sd_printk(KERN_NOTICE, sdkp, "Drive does not support Synchronize Cache(10) command: disabling write cache.\n");
+						sd_set_flush_flag(sdkp);
+					}
+					SCpnt->result = 0;
+					good_bytes = scsi_bufflen(SCpnt);
+				}
+				break;
 			}
 		}
 		break;
