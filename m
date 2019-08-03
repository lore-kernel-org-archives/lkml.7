Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USB_DRIVES,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F176C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 11:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDB42086A
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 11:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbfHCLpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 07:45:25 -0400
Received: from mail.antaris-organics.com ([91.227.220.155]:45350 "EHLO
        mail.antaris-organics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389812AbfHCLpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 07:45:24 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Aug 2019 07:45:23 EDT
Date:   Sat, 3 Aug 2019 13:36:06 +0200
From:   Markus Reichelt <ml@mareichelt.com>
To:     Justin Piszcz <jpiszcz@lucidpixels.com>
Cc:     'LKML' <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: 5.2.x kernel: WD 8TB USB Drives: Unaligned partial completion
 (resid=78, sector_sz=512)
Message-ID: <20190803113606.GB3746@pc21.mareichelt.com>
Mail-Followup-To: Justin Piszcz <jpiszcz@lucidpixels.com>,
        'LKML' <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <006d01d549db$54e42140$feac63c0$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <006d01d549db$54e42140$feac63c0$@lucidpixels.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can reproduce this with kernel 5.2.2 and a WD drive (WD40EZRZ-22GXCB0)
in a USB 3.0 enclosure featuring a JMicron SATA Bridge (ID 152d:2329)

I'm also interested in getting rid of the warnings.

* Justin Piszcz <jpiszcz@lucidpixels.com> wrote:

> Attached 2 x brand new Western Digital 8TB USB 3.0 drives awhile
> back and ran some file copy tests and was getting these warnings--
> is there any way to avoid these warnings?  I did confirm with
> parted that the partition was aligned but this appears to be
> something related to the firmware on the device according to [1]
> and [2]?
> 
> [1] https://patchwork.kernel.org/patch/9573203/
> [2] https://patchwork.kernel.org/patch/9597797/
> 
> Part of the patch in [2] - if the firmware is buggy is there a
> patch or workaround for these drives (when used in the USB
> enclosures) to avoid this issue?
> 
> +	default:
> +		/*
> +		 * In case of bogus fw or device, we could end up having
> +		 * an unaligned partial completion. Check this here and
> force
> +		 * alignment.
> +		 */
> +		resid = scsi_get_resid(SCpnt);
> +		if (resid & (sector_size - 1)) {
> +			sd_printk(KERN_INFO, sdkp,
> +				"Unaligned partial completion (resid=%u,
> sector_sz=%u)\n",
> +				resid, sector_size);
> +			resid = min(scsi_bufflen(SCpnt),
> +				    round_up(resid, sector_size));
> +			scsi_set_resid(SCpnt, resid);
> +		}
> 
> Errors:
> 
> Jul 18 16:25:02 name kernel: [87305.605993] sd 8:0:0:0: [sdg] Unaligned
> partial completion (resid=78, sector_sz=512)
> Jul 18 16:25:02 name kernel: [87305.605993] sd 8:0:0:0: [sdg] Unaligned
> partial completion (resid=78, sector_sz=512)
> 
> Jul 18 16:25:15 name kernel: [87318.292262] sd 7:0:0:0: [sdf] Unaligned
> partial completion (resid=78, sector_sz=512)
> Jul 18 16:25:15 name kernel: [87318.292262] sd 7:0:0:0: [sdf] Unaligned
> partial completion (resid=78, sector_sz=512)

-- 
left blank, right bald
