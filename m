Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42029C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1862F20879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfEVO52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:57:28 -0400
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:39736 "EHLO
        11.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbfEVO52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:57:28 -0400
X-Greylist: delayed 16200 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2019 10:57:26 EDT
Received: from player715.ha.ovh.net (unknown [10.108.42.119])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 6D41211DCD6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:11:44 +0200 (CEST)
Received: from bealr.fr (unknown [176.178.90.37])
        (Authenticated sender: ml@bealr.fr)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id 3BE965FB9C6A
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:11:44 +0000 (UTC)
To:     linux-kernel@vger.kernel.org
From:   Romain BEAL <ml@bealr.fr>
Subject: IMX6 error binding ipu on vdic
Message-ID: <bd1184c2-6d5a-a12b-f0e6-55537f6965b6@bealr.fr>
Date:   Wed, 22 May 2019 12:11:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2332864608621626647
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudduvddgvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tested on gateworks ventana and variscite dart platform :
Unable to bind ipu1_csi0 on ipu1_vdic AND ipu2_csi1 on ipu2_vdic.

Steps to reproduce on ventana board :

$ media_ctl -p
- entity 53: ipu1_csi0 (3 pads, 4 links)
              type V4L2 subdev subtype Unknown flags 0
              device node name /dev/v4l-subdev8
         pad0: Sink
                 [fmt:UYVY8_2X8/640x480@1/30 field:none 
colorspace:smpte170m xfer:709 ycbcr:601 quantization:lim-range
                  crop.bounds:(0,0)/640x480
                  crop:(0,0)/640x480
                  compose.bounds:(0,0)/640x480
                  compose:(0,0)/640x480]
                 <- "ipu1_csi0_mux":5 []
         pad1: Source
                 [fmt:AYUV8_1X32/640x480@1/30 field:none 
colorspace:smpte170m xfer:709 ycbcr:601 quantization:lim-range]
                 -> "ipu1_ic_prp":0 []
                 -> "ipu1_vdic":0 []
         pad2: Source
                 [fmt:AYUV8_1X32/640x480@1/30 field:none 
colorspace:smpte170m xfer:709 ycbcr:601 quantization:lim-range]
                 -> "ipu1_csi0 capture":0 []


- entity 1: ipu1_vdic (3 pads, 3 links)
             type V4L2 subdev subtype Unknown flags 0
             device node name /dev/v4l-subdev0
         pad0: Sink
                 [fmt:AYUV8_1X32/640x480@1/30 field:none 
colorspace:smpte170m xfer:709 ycbcr:601 quantization:lim-range]
                 <- "ipu1_csi0":1 []
                 <- "ipu1_csi1":1 []
         pad1: Sink
                 [fmt:UYVY8_2X8/640x480@1/30 field:none 
colorspace:smpte170m xfer:709 ycbcr:601 quantization:lim-range]
         pad2: Source
                 [fmt:AYUV8_1X32/640x480@1/60 field:none 
colorspace:smpte170m xfer:709 ycbcr:601 quantization:lim-range]
                 -> "ipu1_ic_prp":0 []



$ media-ctl -l "'ipu1_csi0':1 -> 'ipu1_vdic':0[1]" -v
Opening media device /dev/media0
Enumerating entities
Found 19 entities
Enumerating pads and links
Setting up link 53:1 -> 1:0 [1]
Opening media device /dev/media0
media_setup_link: Unable to setup link (Invalid argument)

  'ipu1_csi0':1 -> 'ipu1_vdic':0[1]
                                  ^
Unable to parse link: Invalid argument (22)


Others links works great.
The ipu -> vdic bind worked on 4.14

Is it a kernel bug?

---
Romain BEAL
