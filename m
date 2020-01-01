Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F353C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FCF206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="efIoY73Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgAAQi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 11:38:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgAAQi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 11:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e9xmC6WZve72kHa7WhwPzTlTU4WTjL1WO/1gzCOJ5zo=; b=efIoY73QpMA4ZHweuOSr4KR7k
        F/QRCsWO5WCO5ZOU+XHd62ji24UBRSDQU9EzyLPl2V0gEHXDd++oKBqOfbtd52htq0TCqpohg+riD
        safH+ibGhGvx2esBP++fXKRmKkSSHwmcmgoekupvjRAv3JlGsC/hnRSbfsTVZej1qV7PW1n/WMD3h
        MbcrFzkBO1NYXZH9ApA/eGZQoDN7I9kHZnZ3j7kxxCWp9T+LIZJg0gkhmLEolhuwoGHtpyzLdTpMx
        IfWz2S23pTlupTNKuAkv4vaEK3bQbPaTgJ6A76oPL/M2zS58Ci0PDotf81ajSSd7BPYyh3CtolNVL
        sGSrb7nDw==;
Received: from [2601:1c0:6280:3f0::34d9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1imh0s-0004pt-JU; Wed, 01 Jan 2020 16:38:26 +0000
Subject: Re: Fw: usbcore missing parentheses in USE_NEW_SCHEME
To:     atmgnd <atmgnd@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
References: <7sP4K0IcPrf4Z5urpZjWaiquSFhnNSNGLGsuYj8jbRl8aGGboUyknXW1w7DSBIYNUY308G2QnfDOTmblnyPKyoWMeiYwtqS6mdTxKZqfBO8=@protonmail.com>
 <S5_bTeKG4QYpmSUODHFha_LSjMOM5NMirKYBTHik11iEynJ-WjOAofdiOboo502BpM9CV2Z9xkU93MnoqGz7zdCzwLY7fpqiL5PZZ0-ByQk=@protonmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ca600d41-d978-d799-a871-ce6e1438a4cc@infradead.org>
Date:   Wed, 1 Jan 2020 08:38:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <S5_bTeKG4QYpmSUODHFha_LSjMOM5NMirKYBTHik11iEynJ-WjOAofdiOboo502BpM9CV2Z9xkU93MnoqGz7zdCzwLY7fpqiL5PZZ0-ByQk=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-usb mailing list]

On 1/1/20 6:46 AM, atmgnd wrote:
> I think there is missing parentheses in macro USE_NEW_SCHEME, it should be:
> #define USE_NEW_SCHEME(i, scheme)      ((i) / 2 == (int)(scheme))
> 
> causes a fail wiht "device descriptor read/64, error -110" using my usb drive on vmware using usb 3.0 hub.
> from https://github.com/torvalds/linux/commit/25244227158e1502062041365a439a54cb8fe673#diff-28615d62e1250eadc353d804f49bc6d6
> 
> someone changed USE_NEW_SCHEME, but without parentheses for second parameter. as result. in fuction use_new_scheme when old_scheme_first is 1, use_new_scheme will return 1 always(actullay is should return 0). it also make https://github.com/torvalds/linux/commit/bd0e6c9614b95352eb31d0207df16dc156c527fa#diff-28615d62e1250eadc353d804f49bc6d6 fails.
> 
> I cannot use git send-mail, there some issue with my network provider. patch below, :
> 
> 
> From 85f01b89d050a988f4d9fc78232de47e793c6a7c Mon Sep 17 00:00:00 2001
> From: atmgnd <atmgnd@outlook.com>
> Date: Wed, 1 Jan 2020 21:27:13 +0800
> Subject: [PATCH] usb: hub: missing parentheses in USE_NEW_SCHEME
> 
> accroding to bd0e6c9#diff-28615d62e1250eadc353d804f49bc6d6, will try old enumeration
> scheme first for high speed devices. for example, when a high speed device pluged in,
> line 2720 should expand to 0 at the first time. USE_NEW_SCHEME(0, 0 || 0 || 1) === 0.
> but it wrongly expand to 1(alway expand to 1 for high speed device), and change
> USE_NEW_SCHEME to USE_NEW_SCHEME((i) % 2 == (int)(scheme)) may be better ?
> 
> Signed-off-by: atmgnd <atmgnd@outlook.com>
> ---
>  drivers/usb/core/hub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index f229ad6952c0..7d17deca7021 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2692,7 +2692,7 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
>  #define SET_ADDRESS_TRIES 2
>  #define GET_DESCRIPTOR_TRIES 2
>  #define SET_CONFIG_TRIES (2 * (use_both_schemes + 1))
> -#define USE_NEW_SCHEME(i, scheme) ((i) / 2 == (int)scheme)
> +#define USE_NEW_SCHEME(i, scheme) ((i) / 2 == (int)(scheme))
> 
>  #define HUB_ROOT_RESET_TIME 60 /* times are in msec */
>  #define HUB_SHORT_RESET_TIME 10
> --
> 2.17.1
> 


-- 
~Randy

