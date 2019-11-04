Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE60CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A3A2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572886313;
	bh=ZmHGadF8VrETaBFi+B+Z6MDGAsQZ0t9Gj/4iezFDasU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0FWpgM9RY0DSY6nj8l7xv8twSHqWxTGyV/0FSUG2qzHf0XRFuVnQx5bUutc3Bum3X
	 cGn+U1Uogk1FfVArIokyWujKjzGUzdxyLNgbNFowYdgd1TrtR3VBsesULBUp7KUHVM
	 TS3YudsT5ApSr19ZjBonLgkYUVg5NvSteIGg5OK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfKDQvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbfKDQvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:51:51 -0500
Received: from localhost (host6-102.lan-isdn.imaginet.fr [195.68.6.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A772080F;
        Mon,  4 Nov 2019 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572886311;
        bh=ZmHGadF8VrETaBFi+B+Z6MDGAsQZ0t9Gj/4iezFDasU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVUFC0x9QvBB6c7Za3K5mBIEw+ZH7xtUz3kovv0i72+I9G4zU3GDixfLyhghR7VJQ
         wQYkEojIK2stVJQFPjsEd5u6xAzGlGRwlUI3tVpbK0SpOcXjDEPsSHHCYY9QmCTNid
         Wi5VJnwkLplkT55ISaydRIrptKkjA0RgWMVbTvwA=
Date:   Mon, 4 Nov 2019 17:51:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: rewrite macro with GNU extension
 __auto_type
Message-ID: <20191104165148.GA2293059@kroah.com>
References: <20191104164400.9935-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104164400.9935-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:44:00PM +0000, Jules Irenge wrote:
> Rewrite macro function with GNU extension __auto_type
> to remove issue detected by checkpatch tool.
> CHECK: MACRO argument reuse - possible side-effects?
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx_chip.h | 92 +++++++++++++++++------------
>  1 file changed, 55 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_chip.h b/drivers/staging/rts5208/rtsx_chip.h
> index bac65784d4a1..4b986d5c68da 100644
> --- a/drivers/staging/rts5208/rtsx_chip.h
> +++ b/drivers/staging/rts5208/rtsx_chip.h
> @@ -386,23 +386,31 @@ struct zone_entry {
>  
>  /* SD card */
>  #define CHK_SD(sd_card)			(((sd_card)->sd_type & 0xFF) == TYPE_SD)
> -#define CHK_SD_HS(sd_card)		(CHK_SD(sd_card) && \
> -					 ((sd_card)->sd_type & SD_HS))
> -#define CHK_SD_SDR50(sd_card)		(CHK_SD(sd_card) && \
> -					 ((sd_card)->sd_type & SD_SDR50))
> -#define CHK_SD_DDR50(sd_card)		(CHK_SD(sd_card) && \
> -					 ((sd_card)->sd_type & SD_DDR50))
> -#define CHK_SD_SDR104(sd_card)		(CHK_SD(sd_card) && \
> -					 ((sd_card)->sd_type & SD_SDR104))
> -#define CHK_SD_HCXC(sd_card)		(CHK_SD(sd_card) && \
> -					 ((sd_card)->sd_type & SD_HCXC))
> -#define CHK_SD_HC(sd_card)		(CHK_SD_HCXC(sd_card) && \
> -					 ((sd_card)->capacity <= 0x4000000))
> -#define CHK_SD_XC(sd_card)		(CHK_SD_HCXC(sd_card) && \
> -					 ((sd_card)->capacity > 0x4000000))
> -#define CHK_SD30_SPEED(sd_card)		(CHK_SD_SDR50(sd_card) || \
> -					 CHK_SD_DDR50(sd_card) || \
> -					 CHK_SD_SDR104(sd_card))
> +#define CHK_SD_HS(sd_card)\
> +	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
> +					 (_sd->sd_type & SD_HS); })
> +#define CHK_SD_SDR50(sd_card)\
> +	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
> +					 (_sd->sd_type & SD_SDR50); })
> +#define CHK_SD_DDR50(sd_card)\
> +	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
> +					 (_sd->sd_type & SD_DDR50); })
> +#define CHK_SD_SDR104(sd_card)\
> +	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
> +					 (_sd->sd_type & SD_SDR104); })
> +#define CHK_SD_HCXC(sd_card)\
> +	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
> +					 (_sd->sd_type & SD_HCXC); })
> +#define CHK_SD_HC(sd_card)\
> +	({__auto_type _sd = sd_card; CHK_SD_HCXC(_sd) && \
> +					(_sd->capacity <= 0x4000000); })
> +#define CHK_SD_XC(sd_card)\
> +	({__auto_type _sd = sd_card; CHK_SD_HCXC(_sd) && \
> +					 (_sd->capacity > 0x4000000); })
> +#define CHK_SD30_SPEED(sd_card)\
> +	({__auto_type _sd = sd_card; CHK_SD_SDR50(_sd) || \
> +					CHK_SD_DDR50(_sd) || \
> +					CHK_SD_SDR104(_sd); })
>  
>  #define SET_SD(sd_card)			((sd_card)->sd_type = TYPE_SD)
>  #define SET_SD_HS(sd_card)		((sd_card)->sd_type |= SD_HS)
> @@ -420,18 +428,24 @@ struct zone_entry {
>  /* MMC card */
>  #define CHK_MMC(sd_card)		(((sd_card)->sd_type & 0xFF) == \
>  					 TYPE_MMC)
> -#define CHK_MMC_26M(sd_card)		(CHK_MMC(sd_card) && \
> -					 ((sd_card)->sd_type & MMC_26M))
> -#define CHK_MMC_52M(sd_card)		(CHK_MMC(sd_card) && \
> -					 ((sd_card)->sd_type & MMC_52M))
> -#define CHK_MMC_4BIT(sd_card)		(CHK_MMC(sd_card) && \
> -					 ((sd_card)->sd_type & MMC_4BIT))
> -#define CHK_MMC_8BIT(sd_card)		(CHK_MMC(sd_card) && \
> -					 ((sd_card)->sd_type & MMC_8BIT))
> -#define CHK_MMC_SECTOR_MODE(sd_card)	(CHK_MMC(sd_card) && \
> -					 ((sd_card)->sd_type & MMC_SECTOR_MODE))
> -#define CHK_MMC_DDR52(sd_card)		(CHK_MMC(sd_card) && \
> -					 ((sd_card)->sd_type & MMC_DDR52))
> +#define CHK_MMC_26M(sd_card)\
> +	({__auto_type _sd = sd_card; CHK_MMC(_sd) && \
> +					 (_sd->sd_type & MMC_26M); })

Ick, no.  These are obviously pointers, which can not be "evaluated
twice" so this whole thing is just fine.

checkpatch is just a "hint" that you might want to look at the code.
This stuff is just fine, look at how it is being used for proof of that.

thanks,

greg k-h
