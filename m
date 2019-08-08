Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USB_DRIVES autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DC5C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5AF20880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="nYQAY+aN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbfHHI1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:27:23 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:33727 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732011AbfHHI1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:27:23 -0400
Received: by mail-qt1-f171.google.com with SMTP id r6so87047357qtt.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=E2W6U01vJdQF7ZRePehD0DnY3YLES58EmGuikRJVlMk=;
        b=nYQAY+aNEqyyPkPM1xvcVcJXkcQYvdFc+xLMQp/4s6VaEY+M/kXhrUSmzRdqhqjtt9
         s7a6UZkccQVpRSNHFsijTaHIcCvIzaBmF+XiLYosS7UmQeYK0C4tvKvH70c8R/8mdN7g
         i/hmaAuhV2CfAKLVMo5di2+JJD2qv7VOm9B6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=E2W6U01vJdQF7ZRePehD0DnY3YLES58EmGuikRJVlMk=;
        b=Q8L9D2tGnqPstNMkLrhxFLSX9W8kwuhq/FFhvg0dU0xClOYS59IVNWYG63wDc8WXm0
         sIqFrItUl+0V47PzXnQ+wMpgGe5UWuz6BTtckBU4ONq1tGkzxNDcNjBHpOQygoUIdslw
         A82Q7Gybq1xe0cGO+3fXl9/snNOqEowCXIaMwMZcq69Ze/Er6eO0olCk9cMZKEYG2rai
         419PB+UFto82M/guQdN7i29A6QK67OAEKWlAWDJVekQsBVXgRAQlFtKnAcLX2bFxFDQK
         xDyEK32S+2lTWhpcCQ11KdAgAzRL+0+91xFZQzGAk4Pt15q4KkcZKPADfIsX2tYnWOZ9
         KDDA==
X-Gm-Message-State: APjAAAWjZ2zMBTVI3uRIpMJ9vgxXiEJwUvuzQ2BVsNYoriEL0fyHHa2i
        gX6CJofarI16pwULrfaX/BtzapFbQUoqLg==
X-Google-Smtp-Source: APXvYqyP2WcpCVJBMfYL9+YcGdqldHxOkOHqH8EkajfPXBNkapg8v35ShMNLrxV2q5qKoKmDshAfJg==
X-Received: by 2002:a0c:d11c:: with SMTP id a28mr12125099qvh.180.1565252840992;
        Thu, 08 Aug 2019 01:27:20 -0700 (PDT)
Received: from WARPC (pool-173-72-201-135.clppva.fios.verizon.net. [173.72.201.135])
        by smtp.gmail.com with ESMTPSA id q6sm2560608qtr.23.2019.08.08.01.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 01:27:20 -0700 (PDT)
From:   "Justin Piszcz" <jpiszcz@lucidpixels.com>
To:     "'Martin K. Petersen'" <martin.petersen@oracle.com>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-scsi@vger.kernel.org>
References: <006d01d549db$54e42140$feac63c0$@lucidpixels.com> <yq1ftmcct1j.fsf@oracle.com>
In-Reply-To: <yq1ftmcct1j.fsf@oracle.com>
Subject: RE: 5.2.x kernel: WD 8TB USB Drives: Unaligned partial completion (resid=78, sector_sz=512)
Date:   Thu, 8 Aug 2019 04:27:18 -0400
Message-ID: <002d01d54dc3$17c278c0$47476a40$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIwp6+4+wiF5pA5Z1zpgf2isBdFKwHnSzfypir7r0A=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Martin K. Petersen [mailto:martin.petersen@oracle.com]=20
Sent: Wednesday, August 7, 2019 10:04 PM
To: Justin Piszcz
Cc: 'LKML'; linux-usb@vger.kernel.org; linux-scsi@vger.kernel.org
Subject: Re: 5.2.x kernel: WD 8TB USB Drives: Unaligned partial =
completion (resid=3D78, sector_sz=3D512)


Justin,

> Attached 2 x brand new Western Digital 8TB USB 3.0 drives awhile back =
and
> ran some file copy tests and was getting these warnings-- is there any =
way
> to avoid these warnings?  I did confirm with parted that the partition =
was
> aligned but this appears to be something related to the firmware on =
the
> device according to [1] and [2]?

Please send us the output of:

# sg_vpd -p bl /dev/sdN
# sg_vpd -p bdc /dev/sdN
# sg_readcap -l /dev/sdN

[ .. ]

Disk type:
---
Disk /dev/sdf: 7.3 TiB, 8001562869760 bytes, 15628052480 sectors
Disk model: My Book 25EE

# sg_vpd -p bl /dev/sdf > /tmp/sg_vpd_bl.txt
# sg_vpd -p bdc /dev/sdf > /tmp/sg_vpd_bdc.txt
# sg_readcap -l /dev/sdf > /tmp/sg_readcap.txt
#  ls -l /tmp/sg_vpd_bl.txt /tmp/sg_vpd_bdc.txt /tmp/sg_readcap.txt
-rw-r--r-- 1 root root 421 Aug  8 04:26 /tmp/sg_readcap.txt
-rw-r--r-- 1 root root 244 Aug  8 04:25 /tmp/sg_vpd_bdc.txt
-rw-r--r-- 1 root root 972 Aug  8 04:25 /tmp/sg_vpd_bl.txt

Output:

sg_readcap.txt
Read Capacity results:
   Protection: prot_en=3D0, p_type=3D0, p_i_exponent=3D0
   Logical block provisioning: lbpme=3D0, lbprz=3D0
   Last LBA=3D15628052479 (0x3a38127ff), Number of logical =
blocks=3D15628052480
   Logical block length=3D512 bytes
   Logical blocks per physical block exponent=3D3 [so physical block =
length=3D4096 bytes]
   Lowest aligned LBA=3D0
Hence:
   Device size: 8001562869760 bytes, 7630885.0 MiB, 8001.56 GB, 8.00 TB

sg_vpd_bdc.txt
Block device characteristics VPD page (SBC):
  Nominal rotation rate: 5400 rpm
  Product type: Not specified
  WABEREQ=3D0
  WACEREQ=3D0
  Nominal form factor: 3.5 inch
  ZONED=3D0
  RBWZ=3D0
  BOCS=3D0
  FUAB=3D0
  VBULS=3D0
  DEPOPULATION_TIME=3D0 (seconds)

sg_vpd_bl.txt
Block limits VPD page (SBC):
  Write same non-zero (WSNZ): 0
  Maximum compare and write length: 0 blocks [Command not implemented]
  Optimal transfer length granularity: 8 blocks
  Maximum transfer length: 65535 blocks
  Optimal transfer length: 65535 blocks
  Maximum prefetch transfer length: 65535 blocks
  Maximum unmap LBA count: 0 [Unmap command not implemented]
  Maximum unmap block descriptor count: 0 [Unmap command not =
implemented]
  Optimal unmap granularity: 0 blocks [not reported]
  Unmap granularity alignment valid: false
  Unmap granularity alignment: 0 [invalid]
  Maximum write same length: 0 blocks [not reported]
  Maximum atomic transfer length: 0 blocks [not reported]
  Atomic alignment: 0 [unaligned atomic writes permitted]
  Atomic transfer length granularity: 0 [no granularity requirement
  Maximum atomic transfer length with atomic boundary: 0 blocks [not =
reported]
  Maximum atomic boundary size: 0 blocks [can only write atomic 1 block]


