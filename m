Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D82C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243A820857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WiQRGrGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDILko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:40:44 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33734 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDILkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:40:43 -0400
Received: by mail-yb1-f195.google.com with SMTP id i10so6403876ybk.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LlPm/N5dUY5+UJCEvk0q++bqpxQ/TGCVaKuO1hQyKJY=;
        b=WiQRGrGYqt8cN1puITGJRCgKDfcm+z+vbQifpeArnGgnAXZ76Wt6fyoInFnw7N2Ry4
         Da18aAI4PFNGNZd2jIv5lsLDXwlAVTJ594iTkGDkITM53ZoPREMkJHLa5zFVxBIq57DM
         a3lMX4QjtkzeSZN+6y52W8XvHhpmJKSWsJK/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LlPm/N5dUY5+UJCEvk0q++bqpxQ/TGCVaKuO1hQyKJY=;
        b=l7vbOa19M8YoteTLptS15LAPkt2YI3au7KoblJxKQFxCHKjb+/L8s0ZBnp+Rdc55oZ
         x5+CobUFNLdtySL0NRpAS1OrPRUTpXsJ2LJHqI7ksBv32uq/FPlCarlVRUPXj0ZPU70g
         iUU/U4OzB55frzEnF993OF/EWlR7TeuL5ZJAAITYRC9b/HbFP4o6rZJmHY54EmAdC8+R
         P6Pv8QQpxoLSKE4WWXI3QNHTa1AaIZrJBAb12VyZtusW5GaKLZ5xuzqFmyg/Q6E+bTH8
         IbOKeI9XEZ3va3UTx/Ys26aEoD0LQ/WS61T/f3PbkSFqjmXP4JKS0GT7FqWimYlepF0F
         T/Uw==
X-Gm-Message-State: APjAAAV+WY6gUAb3jfKatxljW48EX7ZcBwzwQi3bF5iqG9aCbDOcNzqa
        AACppBxLy765kXkH5G6k7lDOpt2kjtCOcgPKbd5TPZaUPWy6tEImNASABbu7HYk66OkHJ4S1pWj
        a3nxOKtDigAkQp/jB/4KQwi4uaskwJjuWJj9lBNH+MrjIgFHCHPRAgluvl7LttcOEF3uMdKs2rv
        8b6O3gkLwGBQ8=
X-Google-Smtp-Source: APXvYqzTd2pc7Bl6VEDFCtQrY96BgpEolvCi7QgdnGJss2efIVjeXXHTdgsL+YxwjVAuZGGGaLSPTw==
X-Received: by 2002:a25:bcf:: with SMTP id 198mr17282534ybl.329.1554810042718;
        Tue, 09 Apr 2019 04:40:42 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id 18sm11580240ywi.41.2019.04.09.04.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 04:40:42 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: fix leak of mypkt on error return path
To:     Colin King <colin.king@canonical.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190409112011.19546-1-colin.king@canonical.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <77f41e34-8358-f22b-615d-15de7c091ff7@broadcom.com>
Date:   Tue, 9 Apr 2019 13:40:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409112011.19546-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/2019 1:20 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if the call to brcmf_sdiod_set_backplane_window fails then
> then error return path leaks mypkt. Fix this by returning by a new
> error path labelled 'out' that calls brcmu_pkt_buf_free_skb to free
> mypkt.
> 
> Addresses-Coverity: ("Resource Leak")
> Fixes: a7c3aa1509e2 ("brcmfmac: Remove brcmf_sdiod_addrprep()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index ec129864cc9c..f3d11e024e71 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -628,7 +628,7 @@ int brcmf_sdiod_send_buf(struct brcmf_sdio_dev *sdiodev, u8 *buf, uint nbytes)
>   
>   	err = brcmf_sdiod_set_backplane_window(sdiodev, addr);
>   	if (err)
> -		return err;
> +		goto out;

Actually seems you can just get rid of the if statement entirely as 
below it skips brcmf_sdiod_skbuff_write() when an error occurred so no 
label is necessary.

Regards,
Arend

>   	addr &= SBSDIO_SB_OFT_ADDR_MASK;
>   	addr |= SBSDIO_SB_ACCESS_2_4B_FLAG;
> @@ -636,7 +636,7 @@ int brcmf_sdiod_send_buf(struct brcmf_sdio_dev *sdiodev, u8 *buf, uint nbytes)
>   	if (!err)
>   		err = brcmf_sdiod_skbuff_write(sdiodev, sdiodev->func2, addr,
>   					       mypkt);
> -
> +out:
>   	brcmu_pkt_buf_free_skb(mypkt);
>   
>   	return err;
> 
