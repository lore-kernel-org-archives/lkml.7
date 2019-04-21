Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A736CC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738AB2075A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 15:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P4pm51qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfDUPz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 11:55:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfDUPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 11:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NBvhVPd8Qu3O8fth05cQIOka+zx6SaVtqkXym6E0tbk=; b=P4pm51qqZsBoHGTwnQOMRpt69
        B/r8MuqRNwChKJ7koLcqfNIpUrGqaCtsZ5PpCx6nc/19Hk9Cs90SJ2m+pDCQJg8XLBgFB/N1bNIIW
        cpk13ozY9OXs37u3wlCqKp1+15plIW/CWAcb9KKde0a7oH849dqKl7AdQ68B7+RPyrgP5YmCBip2J
        XbHIFBLYCVlHu1NrMbrmmcfyfzsGPbdl9p6gtLqL2emIZU7q5CJ3EvEuZ7x6pmkVUIAzeKXzLmNSm
        QOGTkjkeIVvT36DKKmpic1A0GGoNn8UgDsbXTkt3B2L9s9CIe8E5EOLf4c4k9wNxQluMR+4Mzse64
        00US7HOxA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIEov-0004zD-Jt; Sun, 21 Apr 2019 15:55:57 +0000
Subject: Re: Reasons for oldconfig resetting config options to =m
To:     =?UTF-8?Q?Niklas_Hamb=c3=bcchen?= <mail@nh2.me>,
        lkml <linux-kernel@vger.kernel.org>
References: <9500a6a9-d63c-4572-7281-50e744c15679@nh2.me>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ba92fbf8-7870-4bc5-4e1d-70085f0b4dbc@infradead.org>
Date:   Sun, 21 Apr 2019 08:55:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9500a6a9-d63c-4572-7281-50e744c15679@nh2.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/19 8:11 AM, Niklas Hambüchen wrote:
> When you set an option to `=y` but one of its dependencies is set to `=m`, then `make oldconfig` will reset it back to `=m` as well.
> 
> That makes sense, but does there exist a feature somewhere that can tell me explicitly when this happens, ideally with a reason like:
> 
>     Resetting CONFIG_USB_STORAGE from =y to =m
>         because its dependency CONFIG_... is set to =m
>         Consequently also resetting the following dependent options from =y to =m:
>             CONFIG_USB_STORAGE_REALTEK
>             CONFIG_USB_...
> 
> This would help tuning kernel configs in situations where menuconfig is not appropriate, for example when working with diffs of configs.
> 
> Is there such tooling, or what do people use?

When using 'make menuconfig', enter /usb_storage and it says:

  │ Symbol: USB_STORAGE [=m]                                                │  
  │ Type  : tristate                                                        │  
  │ Prompt: USB Mass Storage support                                        │  
  │   Location:                                                             │  
  │     -> Device Drivers                                                   │  
  │ (1)   -> USB support (USB_SUPPORT [=y])                                 │  
  │   Defined at drivers/usb/storage/Kconfig:9                              │  
  │   Depends on: USB_SUPPORT [=y] && USB [=m] && SCSI [=m]

so it is limited to m (or n) by USB and SCSI.

Or you can just find the symbol of interest and use Help to get the same info.

The same can be done with 'make nconfig'.

With 'make xconfig', if you click on "USB Mass Storage support" (e.g.), it shows
the same info.  Or you can use Ctrl+F (or Edit/Find), enter a symbol (or
a partial symbol name), like USB_STORAGE, which gives you a list of symbols.
Click on one of them and it will give you the same info.

HTH.  There is nothing quite as explicit as your example output.

-- 
~Randy
