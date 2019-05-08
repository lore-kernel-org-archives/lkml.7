Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BA4C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B680820675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bdqEsys2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfEHUW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:22:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfEHUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hdT4nb0cGuPnHMbL5NAXdzYKa3DNcwqzJrUuCUCeNYs=; b=bdqEsys2xjpVja6b0AxAJI2Rl
        TBGp2ktget+NTTuLaqPHkhJd2oCHu/91mNQ3ElPn3IP6sBv6y0NjKfGoB2ZjhI9jALeBZvMdi87IO
        bdGYLSz67o+eM8pK685SWO8sxBq1B5Zy+5ib/A2HtVxrNG2ACM+UvmxoRpw43gaG+lqY9rmnDj5AT
        yaTPCTKWZI6xAzxHGfl1QxyHIrE+abjWdcA08epLLoL1NtnrSWRBHuoqXYvYtJXMNKy4gBi2bEzOv
        H+qxhboJJrmRjo5c0bkTMr9iTK3mfp5Gm8akWC9r9eyrime73Uo/Qriwi8rGH2wdd3mCpa6623EUU
        +nm9qo15A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOT5d-0007uG-4T; Wed, 08 May 2019 20:22:57 +0000
Subject: Re: linux-next: Tree for May 8 (drivers/media/pci/meye/)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20190508173403.6088d0db@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f4242ed8-971e-7d07-7df9-628c40d7dbf7@infradead.org>
Date:   Wed, 8 May 2019 13:22:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508173403.6088d0db@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/19 12:34 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190507:
> 
> The ubifs tree gained a conflict against Linus' tree.
> 


Hi Mauro,

Commit 6159e12e11770fb25e748af90f6c5206c1df09ee:
media: meye: allow building it with COMPILE_TEST on non-x86

causes a build failure when
CONFIG_VIDEO_MEYE=y
CONFIG_SONY_LAPTOP=m


ld: drivers/media/pci/meye/meye.o: in function `meye_s_ctrl':
meye.c:(.text+0x5bb): undefined reference to `sony_pic_camera_command'
ld: meye.c:(.text+0x5db): undefined reference to `sony_pic_camera_command'
ld: meye.c:(.text+0x5fb): undefined reference to `sony_pic_camera_command'
ld: meye.c:(.text+0x61b): undefined reference to `sony_pic_camera_command'
ld: meye.c:(.text+0x63b): undefined reference to `sony_pic_camera_command'
ld: drivers/media/pci/meye/meye.o:meye.c:(.text+0x65b): more undefined references to `sony_pic_camera_command' follow



-- 
~Randy
