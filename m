Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BB2C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299C92070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfFSJmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:42:47 -0400
Received: from ns.iliad.fr ([212.27.33.1]:57586 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfFSJmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:42:47 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id C17B62067B;
        Wed, 19 Jun 2019 11:42:44 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id ABD7320198;
        Wed, 19 Jun 2019 11:42:44 +0200 (CEST)
Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr>
 <621306ee-7ab6-9cd2-e934-94b3d6d731fc@acm.org>
 <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com>
 <alpine.LNX.2.21.1906181107240.287@nippy.intranet>
 <017cf3cf-ecd8-19c2-3bbd-7e7c28042c3c@free.fr>
 <f8339103-5b45-b72d-9f87-fd4dd7b3081e@interlog.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <f1f98ab0-399a-6c12-073d-ee8ad47d5588@free.fr>
Date:   Wed, 19 Jun 2019 11:42:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f8339103-5b45-b72d-9f87-fd4dd7b3081e@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Jun 19 11:42:44 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2019 17:31, Douglas Gilbert wrote:

> On 2019-06-18 3:29 a.m., Marc Gonzalez wrote:
> 
>> Please note that I am _in no way_ suggesting that we remove any code.
>>
>> I just think it might be time to stop forcing CONFIG_SCSI_PROC_FS into
>> every config, and instead require one to explicitly request the aging
>> feature (which makes CONFIG_SCSI_PROC_FS show up in a defconfig).
>>
>> Maybe we could add CONFIG_SCSI_PROC_FS to arch/x86/configs/foo ?
>> (For which foo? In a separate patch or squashed with this one?)
> 
> Since current sg driver usage seems to depend more on SCSI_PROC_FS
> being "y" than other parts of the SCSI subsystem then if
> SCSI_PROC_FS is to default to "n" in the future then a new
> CONFIG_SG_PROC_FS variable could be added.
> 
> If CONFIG_CHR_DEV_SG is "*" or "m" then default CONFIG_SG_PROC_FS
> to "y"; if CONFIG_SCSI_PROC_FS is "y" then default CONFIG_SG_PROC_FS
> to "y"; else default CONFIG_SG_PROC_FS to "n". Obviously the
> sg driver would need to be changed to use CONFIG_SG_PROC_FS instead
> of CONFIG_SCSI_PROC_FS .

I like your idea, and I think it might even be made slightly simpler.

I assume sg3_utils requires CHR_DEV_SG. Is it the case?

If so, we would just need to enable SCSI_PROC_FS when CHR_DEV_SG is enabled.

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 73bce9b6d037..642ca0e7d363 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -54,14 +54,12 @@ config SCSI_NETLINK
 config SCSI_PROC_FS
 	bool "legacy /proc/scsi/ support"
 	depends on SCSI && PROC_FS
-	default y
+	default CHR_DEV_SG
 	---help---
 	  This option enables support for the various files in
 	  /proc/scsi.  In Linux 2.6 this has been superseded by
 	  files in sysfs but many legacy applications rely on this.
 
-	  If unsure say Y.
-
 comment "SCSI support type (disk, tape, CD-ROM)"
 	depends on SCSI
 

Would that work for you?
I checked that SCSI_PROC_FS=y whether CHR_DEV_SG=y or m
I can spin a v2, with a blurb about how sg3_utils relies on SCSI_PROC_FS.

> Does that defeat the whole purpose of your proposal or could it be
> seen as a partial step in that direction? What is the motivation
> for this proposal?

The rationale was just to look for "special-purpose" options that are
enabled by default, and change the default wherever possible, as a
matter of uniformity.

> BTW We still have the non-sg related 'cat /proc/scsi/scsi' usage
> and 'cat /proc/scsi/device_info'. And I believe the latter one is
> writable even though its permissions say otherwise.

Any relation between SG and BSG?

Regards.
