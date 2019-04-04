Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8A5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C58A2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfDDMCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:02:04 -0400
Received: from ns.iliad.fr ([212.27.33.1]:48546 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbfDDMCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:02:03 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id E820721806;
        Thu,  4 Apr 2019 14:02:01 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id CFD8C20720;
        Thu,  4 Apr 2019 14:02:01 +0200 (CEST)
Subject: Re: correcting incorrect peripheral device type 0x0
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <ab8d589f-db76-9a95-1b55-3e906ad89487@free.fr>
 <yq1zhp6satq.fsf@oracle.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <69474538-b097-f672-a263-aefd5958dc90@free.fr>
Date:   Thu, 4 Apr 2019 14:02:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yq1zhp6satq.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Apr  4 14:02:02 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2019 05:34, Martin K. Petersen wrote:

> Marc wrote:
> 
>> scsi 0:0:0:49488: scsi_add_lun: correcting incorrect peripheral device type 0x0 for W-LUN 0x            c150hN
> 
>             ^^^^^ Where do these crazy LUN numbers come from? That
>             looks like something which needs fixing...

	sdev_printk(KERN_WARNING, sdev, "%s: correcting incorrect peripheral device type 0x%x for W-LUN 0x%16xhN\n",
			__func__, sdev->type, (unsigned int)sdev->lun);

What does the "hN" suffix stand for? It seems redundant with the "0x" prefix...
(Looks like hN might be "hexadecimal Number")


scsi 0:0:0:49488 -> 0xc150
scsi 0:0:0:49476 -> 0xc144
scsi 0:0:0:49456 -> 0xc130

4.7.7.5.1 Well known logical unit addressing

Table 37 — Well known logical unit extended addressing format

Bit         7         6         5         4         3         2         1         0
       ADDRESS METHOD (11b)     LENGTH (00b)          EXTENDED ADDRESS METHOD (1h)

1100 0001 = 0xc1

So W-LUN 0x50, 0x44, 0x30.

"The W-LUN field specifies the well known logical unit to be addressed (see SPC-4)."

Does anything seem out-of-place?


I'd change the log message like this:

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 53380e07b40e..d28c5a30f60a 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -820,8 +820,8 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
 		 */
 		if (scsi_is_wlun(sdev->lun) && sdev->type != TYPE_WLUN) {
 			sdev_printk(KERN_WARNING, sdev,
-				"%s: correcting incorrect peripheral device type 0x%x for W-LUN 0x%16xhN\n",
-				__func__, sdev->type, (unsigned int)sdev->lun);
+				"%s: correcting incorrect peripheral device type 0x%x for W-LUN 0x%016llx\n",
+				__func__, sdev->type, (unsigned long long)sdev->lun);
 			sdev->type = TYPE_WLUN;
 		}
 
