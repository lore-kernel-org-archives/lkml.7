Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DA7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BF320700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfC0Lbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:31:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:47244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfC0Lbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:31:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 367FCAEE3;
        Wed, 27 Mar 2019 11:31:38 +0000 (UTC)
Subject: Re: megasas: Unexpected response from lun 1 while scanning, scan
 aborted
To:     Dongli Zhang <dongli.zhang@oracle.com>, qemu-block@nongnu.org,
        linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com
Cc:     linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
References: <9c3849cf-86c6-4568-bff5-1050b445322d@default>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c3a8f877-82bc-44ab-72e8-51f62c0a65ed@suse.de>
Date:   Wed, 27 Mar 2019 12:31:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9c3849cf-86c6-4568-bff5-1050b445322d@default>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 5:47 PM, Dongli Zhang wrote:
> I am reporting an error that the scsi lun cannot initialize successfully when I
> am emulating megasas scsi controller with qemu.
> 
> I am not sure if this is issue in qemu or linux kernel.
> 
> When 'lun=1' is specified, there is "Unexpected response from lun 1 while
> scanning, scan aborted".
> 
> Everything works well if 'lun=0' is specified.
> 
> 
> Below is the qemu cmdline involved:
> 
> -device megasas,id=scsi0 \
> -device scsi-hd,drive=drive0,bus=scsi0.0,lun=1 \
> -drive file=/home/zhang/img/test.img,if=none,id=drive0,format=raw
> 
> 
> Below is the syslog related to 'scsi|SCSI'
> 
> # dmesg | grep SCSI
> [    0.392494] SCSI subsystem initialized
> [    0.460666] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
> [    0.706788] sd 1:0:0:0: [sda] Attached SCSI disk
> # dmesg | grep scsi
> [    0.511643] scsi host0: Avago SAS based MegaRAID driver
> [    0.523302] scsi 0:2:0:0: Unexpected response from lun 1 while scanning, scan aborted
> [    0.540364] scsi host1: ata_piix
> [    0.540780] scsi host2: ata_piix
> [    0.702396] scsi 1:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> 
> When 'lun=1' is changed to 'lun=0', there is no issue.
> 
> Thank you very much!
> 
That's an artifact from the megasas emulation in quemu.
Megasas (internally) can't handle LUN numbers (the RAID part only knows 
about 'disks'), so I took the decision to not expose devices with LUN != 0.
Please use a different SCSI target number, not a non-zero LUN number.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
