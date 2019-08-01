Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5685FC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D58220679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564677282;
	bh=9dtaBDceSfT8Z//OdbDVGNrZL3XEU07S5L41ZyczgiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M0K8n3s7scTVHW46SnCG4VuKZyhiGO/gwKcli4a0FGNBJ36CmSTqfzmsNBOEnIRt3
	 gVURMOZ/3+Z6Ppppy2V9140cezJ1wpfJ2qeVpKAeSlSe/l5JqO5a6b7yvByR9ujNK3
	 JTPojpAyrqMHbvWctDLF3yDFavv4TIrRGI/imS5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbfHAQek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHAQek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:34:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93342087E;
        Thu,  1 Aug 2019 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564677279;
        bh=9dtaBDceSfT8Z//OdbDVGNrZL3XEU07S5L41ZyczgiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WT2m9/ZmMm0l9PwXVJS7ub8v7biP+JM2Y62c28yiUZZ9QKXP7twRdPLWgFwI4CO4F
         k/1R4ZL6/6F4iTr36TLbdNoALaNlJcTjdVXH9jp/L9E86sebkQn7zHNsLDvNsWaymg
         BpnOw0a1dhTCoN5oX6ebUvNpETCnfOT8vSmT4l+4=
Date:   Thu, 1 Aug 2019 18:34:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Harsh Jain <harshjain32@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:kpc2000:Fix dubious x | !y sparse warning
Message-ID: <20190801163437.GA8360@kroah.com>
References: <20190731183606.2513-1-harshjain32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731183606.2513-1-harshjain32@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:06:06AM +0530, Harsh Jain wrote:
> Bitwise OR(|) operation with 0 always yield same result.
> It fixes dubious x | !y sparse warning.
> 
> Signed-off-by: Harsh Jain <harshjain32@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc2000_i2c.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
> index b108da4..5f027d7c 100644
> --- a/drivers/staging/kpc2000/kpc2000_i2c.c
> +++ b/drivers/staging/kpc2000/kpc2000_i2c.c
> @@ -536,29 +536,15 @@ static u32 i801_func(struct i2c_adapter *adapter)
>  
>  	u32 f =
>  		I2C_FUNC_I2C                     | /* 0x00000001 (I enabled this one) */
> -		!I2C_FUNC_10BIT_ADDR             | /* 0x00000002 */
> -		!I2C_FUNC_PROTOCOL_MANGLING      | /* 0x00000004 */
>  		((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0) | /* 0x00000008 */
> -		!I2C_FUNC_SMBUS_BLOCK_PROC_CALL  | /* 0x00008000 */
>  		I2C_FUNC_SMBUS_QUICK             | /* 0x00010000 */
> -		!I2C_FUNC_SMBUS_READ_BYTE        | /* 0x00020000 */
> -		!I2C_FUNC_SMBUS_WRITE_BYTE       | /* 0x00040000 */
> -		!I2C_FUNC_SMBUS_READ_BYTE_DATA   | /* 0x00080000 */
> -		!I2C_FUNC_SMBUS_WRITE_BYTE_DATA  | /* 0x00100000 */
> -		!I2C_FUNC_SMBUS_READ_WORD_DATA   | /* 0x00200000 */
> -		!I2C_FUNC_SMBUS_WRITE_WORD_DATA  | /* 0x00400000 */
> -		!I2C_FUNC_SMBUS_PROC_CALL        | /* 0x00800000 */
> -		!I2C_FUNC_SMBUS_READ_BLOCK_DATA  | /* 0x01000000 */
> -		!I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | /* 0x02000000 */

This is ok, it is showing you that these bits are explicitly being not
set.  Which is good, now you can go through the list and see that all
are accounted for.

So I think this should stay as-is, thanks.

greg k-h
