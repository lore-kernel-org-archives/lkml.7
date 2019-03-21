Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB10DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA89521902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfCUSjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:39:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39116 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbfCUSjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:39:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so4785531pgp.6;
        Thu, 21 Mar 2019 11:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXivaLRJuDZ0DQPxuwi98nNvAanVTsthyFfvweVj7Bc=;
        b=tZFCe/Z4FaF33SiSW7zlZURpWM0EyRDAIFFX4knJXJeN33nabzGb4gUsWc0v0r/hzq
         Gwhpz2sHlG1Dy5y/D1PdN+VUbQtLvOTUgJ+gpC1UbIBOvvleMRGJt66B+zqCwYr9yVY/
         HOyeC6VRrc2xeyW5R8D+pb1OxdxQ240t3OPsF+afEoAflrulTqSsH+kavAusiQ3j7gEt
         fogkn5I3IH8wl83bAqZ/6MwqS3MfaZZyakzLhWGDAPsZB5suiPt8W62etybcGvS+44zw
         rbJ45QxLgemO9QbBEMMdZ4fa2jjew/48icm/xQTUkMya3mQVpX4JWIQyqKEYIjCi2Jxh
         1L4w==
X-Gm-Message-State: APjAAAU+bxcVCMFAltowLELrLLYwME8u7xuWBdD+bS0IICrJgZtbnYX1
        yTP6wdmr3KRYdThdj8HTYbw=
X-Google-Smtp-Source: APXvYqx7e+mGABzjvczyMBy0DF365TGmpnn8U0S+VciIxEcxb1bOCLeVDsS6a/UHwnF1NU74ly1QNw==
X-Received: by 2002:aa7:8156:: with SMTP id d22mr4843567pfn.230.1553193544829;
        Thu, 21 Mar 2019 11:39:04 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s5sm7405816pfm.184.2019.03.21.11.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 11:39:03 -0700 (PDT)
Message-ID: <1553193542.65329.119.camel@acm.org>
Subject: Re: [RFC PATCH v2] scsi: fix oops in scsi_uninit_cmd()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, tom.leiming@gmail.com
Date:   Thu, 21 Mar 2019 11:39:02 -0700
In-Reply-To: <20190316020905.14962-1-yanaijie@huawei.com>
References: <20190316020905.14962-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-16 at 10:09 +-0800, Jason Yan wrote:
+AD4 If we remove the scsi disk when running io with fio, oops occured with
+AD4 the following condition.
+AD4 
+AD4 +AFs-scsi+AF8-eh+AF8-0+AF0                              +AFs-fio+AF0
+AD4 scsi+AF8-end+AF8-request
+AD4   -+AD4-blk+AF8-update+AF8-request
+AD4     -+AD4-end+AF8-bio(io returned to userspace)
+AD4                                          close
+AD4                                            -+AD4-sd+AF8-release
+AD4                                               -+AD4-scsi+AF8-disk+AF8-put
+AD4                                                  -+AD4-scsi+AF8-disk+AF8-release
+AD4                                                      -+AD4-disk-+AD4-private+AF8-data +AD0 NULL+ADs
+AD4 
+AD4   -+AD4-scsi+AF8-mq+AF8-uninit+AF8-cmd
+AD4     -+AD4-scsi+AF8-uninit+AF8-cmd
+AD4       -+AD4-scsi+AF8-cmd+AF8-to+AF8-driver
+AD4     -+AD4-drv is NULL, Oops
+AD4 
+AD4 There is a small window between blk+AF8-update+AF8-request() and
+AD4 scsi+AF8-mq+AF8-uninit+AF8-cmd() that scsi disk may have been released. This will
+AD4 cause a oops like below:
+AD4 
+AD4 Unable to handle kernel NULL pointer dereference at virtual address
+AD4 0000000000000000
+AD4 s/sync.c:67, func+AD0-xfer, error+AD0-In+AFs-11347.116050+AF0 Mem abort info:
+AD4 put/output error
+AD4 +AFs-11347.121598+AF0   ESR +AD0 0x96000006
+AD4 +AFs-11347.126200+AF0   Exception class +AD0 DABT (current EL), IL +AD0 32 bits
+AD4 +AFs-11347.132117+AF0   SET +AD0 0, FnV +AD0 0
+AD4 +AFs-11347.135170+AF0   EA +AD0 0, S1PTW +AD0 0
+AD4 +AFs-11347.138308+AF0 Data abort info:
+AD4 +AFs-11347.141186+AF0   ISV +AD0 0, ISS +AD0 0x00000006
+AD4 +AFs-11347.145019+AF0   CM +AD0 0, WnR +AD0 0
+AD4 +AFs-11347.147977+AF0 user pgtable: 4k pages, 48-bit VAs, pgdp +AD0
+AD4 00000000a67aece2
+AD4 +AFs-11347.154591+AF0 +AFs-0000000000000000+AF0 pgd+AD0-0000002f90774003,
+AD4 pud+AD0-0000002fab098003, pmd+AD0-0000000000000000
+AD4 +AFs-11347.163304+AF0 Internal error: Oops: 96000006 +AFsAIw-1+AF0 PREEMPT SMP
+AD4 +AFs-11347.168870+AF0 Modules linked in: hisi+AF8-sas+AF8-v3+AF8-hw hisi+AF8-sas+AF8-main libsas
+AD4 +AFs-11347.175044+AF0 CPU: 56 PID: 4294 Comm: scsi+AF8-eh+AF8-2 Not tainted
+AD4 4.19.0-g8052059-dirty +ACM-2
+AD4 +AFs-11347.182600+AF0 Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI
+AD4 RC0 - B601 (V6.01) 11/08/2018
+AD4 +AFs-11347.191370+AF0 pstate: a0c00009 (NzCv daif +PAN+UAO113471w

Please verify whether the following patch is a valid alternative for your patch:

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ed34bfbc3844..745ffdda1bc1 100644
--- a/drivers/scsi/sd.c
+-+-+- b/drivers/scsi/sd.c
+AEAAQA -1408,6 +-1408,7 +AEAAQA static void sd+AF8-release(struct gendisk +ACo-disk, fmode+AF8-t mode)
 +AHs
 	struct scsi+AF8-disk +ACo-sdkp +AD0 scsi+AF8-disk(disk)+ADs
 	struct scsi+AF8-device +ACo-sdev +AD0 sdkp-+AD4-device+ADs
+-	struct request+AF8-queue +ACo-q +AD0 sdkp-+AD4-disk-+AD4-queue+ADs
 
 	SCSI+AF8-LOG+AF8-HLQUEUE(3, sd+AF8-printk(KERN+AF8-INFO, sdkp, +ACI-sd+AF8-release+AFw-n+ACI))+ADs
 
+AEAAQA -1417,9 +-1418,12 +AEAAQA static void sd+AF8-release(struct gendisk +ACo-disk, fmode+AF8-t mode)
 	+AH0
 
 	/+ACo
-	 +ACo XXX and what if there are packets in flight and this close()
-	 +ACo XXX is followed by a +ACI-rmmod sd+AF8-mod+ACI?
+-	 +ACo Wait until any requests that are in progress have completed.
+-	 +ACo This is necessary to avoid that e.g. scsi+AF8-end+AF8-request() crashes
+-	 +ACo due to scsi+AF8-disk+AF8-relase() clearing the disk-+AD4-private+AF8-data pointer.
 	 +ACo-/
+-	blk+AF8-mq+AF8-freeze+AF8-queue(q)+ADs
+-	blk+AF8-mq+AF8-unfreeze+AF8-queue(q)+ADs
 
 	scsi+AF8-disk+AF8-put(sdkp)+ADs
 +AH0

Thanks,

Bart.
