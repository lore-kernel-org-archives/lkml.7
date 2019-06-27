Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2819DC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF012183F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561606376;
	bh=wBuccfjVsvbHvgUymwn0P7keujYCrvPAz6ddM3zEGPE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=qJxxHN1sY2HvlXarsj6DrNfd2lvfu2TZRHDzTX3NUp00mWjVBsGAeMfTQqr2NTw8+
	 h9pRbOmchs/sgPHwihjXLLR/NoUNph2NotY9vv/+CYm2zWrRFsOKFPxSPYIzDjSErt
	 8NIT3bN+ojEhYFqBlB/xmtFKG+24hEMKbwYDihBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfF0Dcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:32:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35013 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfF0Dcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:32:54 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so1607347ioo.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 20:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hl42QXY3S0Tzp/1iP5VPtBnoh/J5/Co6mxdvHc83Csg=;
        b=GbbX9yaDPCx8vkhF+bGE0Od6SliCL/rm+uB32WWHR6IylJo24Rc6p5mu19uHdbrWjr
         c7dljIdXwKy12zOHYXFNFc7uEjqUKoB4/1xwbcJjr5Yq22sqSuMicIsfbRHSR/zoxvoE
         6ISVzP0/P9NJ53w19r34RXX4+ew3Z2eM9gdAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hl42QXY3S0Tzp/1iP5VPtBnoh/J5/Co6mxdvHc83Csg=;
        b=pVf0x4dK2rQC63PI2ZE0UATAM6uyWWtmKtTUTm2zzrpmfNK4Rka5p8Hxd2HGa9KRyf
         xiTxgylEqMy6a95aWGAesfUhPISHbCcpBXIrau9YSxtt/+1S1fam8U8G9Mj04qSmNsnN
         wICvSSHW2/O/84puDqQX8OSdsOP/KSfIo0HECppFZBKm7JXTbxRaOSsRoYCDj/9Z/33l
         iSeto5sxeflvPGXaX1mrq7Eh1oYfae+hwg6bpM6JpWIPdDvWbqaAmwv10Z0s7mrBU42Z
         V/3+xlr5CXIhi+z9TbCi0jPXpn5fKuvk7RDAFi7sbTWh9+kSTnJv62UsuugwP2IbxmMS
         ZFEw==
X-Gm-Message-State: APjAAAVZutsPnkJKdbRGM29poqtU5In8FN0Z+AGGZ0ybEGAHGkwQt+Iy
        9xvw3SRzQKLy8H71hTt+mGrPyw==
X-Google-Smtp-Source: APXvYqyaXloZJxg9kW/xTu+BePSnDl0lA81eos0lva0/Hkey8A4xyXxY4mlCW84rxuvQWzq8ekAfYw==
X-Received: by 2002:a02:554a:: with SMTP id e71mr1814481jab.144.1561606373805;
        Wed, 26 Jun 2019 20:32:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p25sm957961iol.48.2019.06.26.20.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 20:32:53 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH v2] packet: Fix undefined behavior
 in bit shift
To:     Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190627010137.5612-1-c0d1n61at3@gmail.com>
 <20190627032532.18374-2-c0d1n61at3@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7f6f44b2-3fe4-85f6-df3c-ad59f2eadba2@linuxfoundation.org>
Date:   Wed, 26 Jun 2019 21:32:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627032532.18374-2-c0d1n61at3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 9:25 PM, Jiunn Chang wrote:
> Shifting signed 32-bit value by 31 bits is undefined.  Changing most
> significant bit to unsigned.
> 
> Changes included in v2:
>    - use subsystem specific subject lines
>    - CC required mailing lists
> 

These version change lines don't belong in the change log.

> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> ---

Move them here.

>   include/uapi/linux/if_packet.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
> index 467b654bd4c7..3d884d68eb30 100644
> --- a/include/uapi/linux/if_packet.h
> +++ b/include/uapi/linux/if_packet.h
> @@ -123,7 +123,7 @@ struct tpacket_auxdata {
>   /* Rx and Tx ring - header status */
>   #define TP_STATUS_TS_SOFTWARE		(1 << 29)
>   #define TP_STATUS_TS_SYS_HARDWARE	(1 << 30) /* deprecated, never set */
> -#define TP_STATUS_TS_RAW_HARDWARE	(1 << 31)
> +#define TP_STATUS_TS_RAW_HARDWARE	(1U << 31)
>   
>   /* Rx ring - feature request bits */
>   #define TP_FT_REQ_FILL_RXHASH	0x1
> 

thanks,
-- Shuah
