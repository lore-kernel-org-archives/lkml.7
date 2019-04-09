Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33D2C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A144F20830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z7SwfGzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfDILum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:50:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43512 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfDILum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:50:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id w3so5458973edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B5sSsC3HMUSkiy5Yl/n4gRf0ImuIZQUiQCjBQDa4tno=;
        b=Z7SwfGzxwTdfm4ieM/XPyefn5q4DhbDYnIfNUA8AL6nZY+ezVPTEShive16a4k0ual
         WNP37uTAwjtFesb3iV2GnfwTGpjAf85mU2Txpph0F037w318tORFSYmNnNOCJP1Jzego
         eno8+uIypfJQOugQgz1fgPPEDuXkKnzOimXI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5sSsC3HMUSkiy5Yl/n4gRf0ImuIZQUiQCjBQDa4tno=;
        b=BpRhSwNSK9gvzKgN5fOYmidk3svYb4LF2BliOr1PtfWMwmuNoIKtme1E224q1RxJBW
         R9V2yffAfpxi0il+UiopkBf/Xo1Ha8U1iaaJhRAGi9LZLcCfP+b8AX/86ooXT7ymm6/s
         auO1/Wit91cuV4aFONyEKvoh6RfNXL9OqdBh2Xf0igAcP4hpFaQLZWYx33H4qPLgzSjw
         /ADPAik+bQ9K/QAb6FinvaPLOBQl6Flk5iV2nT4Y/94Y1IWJpeONK3fHtAtwI4QNI/xD
         ErqzdNi8VR8VP/y6Ipm+GMXYwEzwAqSI3yWmVCvMQP3MoxDe58diQEIoYhT1/s2MsOMe
         4UYw==
X-Gm-Message-State: APjAAAVxKszRP+y5n/2bEit2cnigE79KinZYAT8uJ0FdL49ZHunZ4SRb
        vYNG8MMf4qhSX0ZfZwycQNtisE3yp2wg96m6AVsXm4KPF+YdHgtNrNH1NmP54uhN5BauFg6+saj
        ZAT2F16Rxt5Ggp6E9+iVGUlsBMqo93uI3ub3HerRLTNvN2NgTslC4Ax8oggkVE+hzP3byJy74a8
        5aw5HknEmsl7M=
X-Google-Smtp-Source: APXvYqxKsnmTAGeoq0j9YwO3a6O29erZ0UKg2exQzRmflL20RP5fF5MOo00i2HfpAXnH/xjCH1ILwA==
X-Received: by 2002:a17:906:578f:: with SMTP id k15mr20062047ejq.140.1554810640177;
        Tue, 09 Apr 2019 04:50:40 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id c7sm9478331edt.70.2019.04.09.04.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 04:50:39 -0700 (PDT)
Subject: Re: [PATCH][V2] brcmfmac: fix leak of mypkt on error return path
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
References: <20190409114333.24342-1-colin.king@canonical.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <e0d984a7-6a6d-b902-6f75-26ee6f530efe@broadcom.com>
Date:   Tue, 9 Apr 2019 13:50:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409114333.24342-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/2019 1:43 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if the call to brcmf_sdiod_set_backplane_window fails then
> then error return path leaks mypkt. Fix this by returning by a new
> error path labelled 'out' that calls brcmu_pkt_buf_free_skb to free
> mypkt.  Also remove redundant check on err before calling
> brcmf_sdiod_skbuff_write.
> 
> Addresses-Coverity: ("Resource Leak")
> Fixes: a7c3aa1509e2 ("brcmfmac: Remove brcmf_sdiod_addrprep()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: Remove  redundant check on err before calling
> brcmf_sdiod_skbuff_write, kudos to Dan Carpenter and Arend Van Spriel
> for spotting this.
> 
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index ec129864cc9c..60aede5abb4d 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -628,15 +628,13 @@ int brcmf_sdiod_send_buf(struct brcmf_sdio_dev *sdiodev, u8 *buf, uint nbytes)
>   
>   	err = brcmf_sdiod_set_backplane_window(sdiodev, addr);
>   	if (err)
> -		return err;
> +		goto out;
>   
>   	addr &= SBSDIO_SB_OFT_ADDR_MASK;
>   	addr |= SBSDIO_SB_ACCESS_2_4B_FLAG;
>   
> -	if (!err)
> -		err = brcmf_sdiod_skbuff_write(sdiodev, sdiodev->func2, addr,
> -					       mypkt);
> -
> +	err = brcmf_sdiod_skbuff_write(sdiodev, sdiodev->func2, addr, mypkt);
> +out:

I am fine with it, but my suggestion was a bit different:

	err = brcmf_sdiod_set_backplane_window(sdiodev, addr);
	if (!err) {
		addr &= SBSDIO_SB_OFT_ADDR_MASK;
		addr |= SBSDIO_SB_ACCESS_2_4B_FLAG;
		err = brcmf_sdiod_skbuff_write(sdiodev, sdiodev->func2,
					       addr, mypkt);
	}

>   	brcmu_pkt_buf_free_skb(mypkt);
>   
>   	return err;
> 
