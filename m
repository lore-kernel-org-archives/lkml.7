Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1200204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ed5nrXFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfC1AnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:43:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54042 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1AnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:43:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2S0cZdD184006;
        Thu, 28 Mar 2019 00:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=K4KGrj9DTxQpE3Z97Uz8xJr0r3YGRKAUWzS0FAdlioQ=;
 b=ed5nrXFZHxzE1fXagZdyHM+Ke3X9D7+699m9Qme7f1urHtbto12Tn47gtnIR5ZGolnKQ
 JPlNzKuEgTCRVZzWioahmvjhxBJZHXJ+z3A/hjDRdkGkjmpXNtvxc1mDmMNT7HNF5atq
 KBqG25Qs5tertcbB69b/GGMa/BjiDQleIJWBAkAAgqA21CvZFgD9455WgYUGijCaADLq
 cJx8QgBM34M93GYq25CJuAY5dABKR4/1OQwByxP/+z3hAKhM1sR+lc56XloSl3OwdUWi
 iua3lDfFwgi/UAEZMl38+ffOSPOVcnwb1VNW3We/9mp5M2coVGSTOe6wyryxMlnHMSkm jg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g1bpfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 00:43:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2S0h8Ht008592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 00:43:08 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2S0h6RH025834;
        Thu, 28 Mar 2019 00:43:07 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 17:43:06 -0700
Subject: Re: [Qemu-devel] megasas: Unexpected response from lun 1 while
 scanning, scan aborted
To:     Hannes Reinecke <hare@suse.de>
Cc:     qemu-block@nongnu.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org
References: <9c3849cf-86c6-4568-bff5-1050b445322d@default>
 <c3a8f877-82bc-44ab-72e8-51f62c0a65ed@suse.de>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <442316ee-8800-275c-85e9-a5d054a28e63@oracle.com>
Date:   Thu, 28 Mar 2019 08:47:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c3a8f877-82bc-44ab-72e8-51f62c0a65ed@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/19 7:31 PM, Hannes Reinecke wrote:
> On 3/26/19 5:47 PM, Dongli Zhang wrote:
>> I am reporting an error that the scsi lun cannot initialize successfully when I
>> am emulating megasas scsi controller with qemu.
>>
>> I am not sure if this is issue in qemu or linux kernel.
>>
>> When 'lun=1' is specified, there is "Unexpected response from lun 1 while
>> scanning, scan aborted".
>>
>> Everything works well if 'lun=0' is specified.
>>
>>
>> Below is the qemu cmdline involved:
>>
>> -device megasas,id=scsi0 \
>> -device scsi-hd,drive=drive0,bus=scsi0.0,lun=1 \
>> -drive file=/home/zhang/img/test.img,if=none,id=drive0,format=raw
>>
>>
>> Below is the syslog related to 'scsi|SCSI'
>>
>> # dmesg | grep SCSI
>> [    0.392494] SCSI subsystem initialized
>> [    0.460666] Block layer SCSI generic (bsg) driver version 0.4 loaded (major
>> 251)
>> [    0.706788] sd 1:0:0:0: [sda] Attached SCSI disk
>> # dmesg | grep scsi
>> [    0.511643] scsi host0: Avago SAS based MegaRAID driver
>> [    0.523302] scsi 0:2:0:0: Unexpected response from lun 1 while scanning,
>> scan aborted
>> [    0.540364] scsi host1: ata_piix
>> [    0.540780] scsi host2: ata_piix
>> [    0.702396] scsi 1:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+
>> PQ: 0 ANSI: 5
>>
>> When 'lun=1' is changed to 'lun=0', there is no issue.
>>
>> Thank you very much!
>>
> That's an artifact from the megasas emulation in quemu.
> Megasas (internally) can't handle LUN numbers (the RAID part only knows about
> 'disks'), so I took the decision to not expose devices with LUN != 0.
> Please use a different SCSI target number, not a non-zero LUN number.

The guest kernel is able to detect the disk if lun is always 0, while target
number is changed:

-device scsi-hd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=0,lun=0
-device scsi-hd,drive=drive1,bus=scsi0.0,channel=0,scsi-id=1,lun=0

# dmesg | grep scsi
[    0.935999] scsi host0: ata_piix
[    0.936401] scsi host1: ata_piix
[    1.100945] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+
PQ: 0 ANSI: 5
[    1.102409] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.672952] scsi host2: Avago SAS based MegaRAID driver
[    1.683886] scsi 2:2:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+
PQ: 0 ANSI: 5
[    1.684915] scsi 2:2:1:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+
PQ: 0 ANSI: 5
[    1.701529] sd 2:2:0:0: Attached scsi generic sg1 type 0
[    1.704795] sd 2:2:1:0: Attached scsi generic sg2 type 0
# dmesg | grep SCSI
[    0.111015] SCSI subsystem initialized
[    0.904712] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    1.121174] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.703739] sd 2:2:0:0: [sdb] Attached SCSI disk
[    1.706964] sd 2:2:1:0: [sdc] Attached SCSI disk



If device with LUN != 0 will not be exposed, why not set max_lun = 0 as what
qemu lsi is doing?

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index a56317e..c966ee0 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2298,7 +2298,7 @@ static void megasas_scsi_uninit(PCIDevice *d)
 static const struct SCSIBusInfo megasas_scsi_info = {
     .tcq = true,
     .max_target = MFI_MAX_LD,
-    .max_lun = 255,
+    .max_lun = 0,

     .transfer_data = megasas_xfer_complete,
     .get_sg_list = megasas_get_sg_list,


Thank you very much!

Dongli Zhang
