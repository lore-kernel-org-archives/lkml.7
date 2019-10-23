Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F6CCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEA6205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="uiwfWWz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404034AbfJWKLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:11:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33320 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390965AbfJWKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:11:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id r5so31488375qtd.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45UH3jeZS+STm/wq23wqrF1WBf2AHal/DsaqIpXgXro=;
        b=uiwfWWz51TgMN4zK/OjfTR6icjwXobD6pklhiTYCecLtyiyMH64zINMBzMGs8se07f
         s/NWmmEgqDhLILPwUYEJm14ygukTrij6NnqSc7lxWcfZnwjw4Yt+RHfm7oDEF9SgXtJw
         t3afas224I1h2Vvlf/LgEQa0nUSCjO2geDICQlC07VitCmdd3akY+8in+4vqt6p7Vg+P
         uOiHLlC5mmFQKY+QxXTnMcTEfJ8lzs3/lwtrBOI09M2uJID61VaRVFoCcCKCJqfpYYFE
         3bV7R96sQ6vaUgsI19Wvaxkd77fUWgWa5Hl4ewMyE6rc1W8UZCDNdSnRZJisbeb9uT+V
         j3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45UH3jeZS+STm/wq23wqrF1WBf2AHal/DsaqIpXgXro=;
        b=DQY3SGG2h8GySoXiw+29a+q+y57bb1PWG9UzR5nZFvz7LOnXoV9/lKW+bBKPiVKtbn
         s16fBIxBYmL8+prmREAq8xgZk+ozI7omqrkDyPp8NUUlcF4n07MiFaa/M20QdrX9Da1e
         R6pIkeBvZ425UKikUPk3uVQ5z0DSeCq6i72q3i38U8au76OOMAGqddOBha89jaK6WiZ+
         LBfdUBajfPgS+mKCy1wnYXl+wVVht+7+vBKEu1qAlyboe2SjwQmSVkx1/AUSrdS+iIaw
         HoBXgL/0njkTTIwOLPW6jSkI8sJmN60jFyKMn5m6sXQWVsvDh1AfAz4aj08qRWATCUpE
         Y2uA==
X-Gm-Message-State: APjAAAU9ez00iWSu2cyvUla+fGB0FLG5Yx83c22UVxPGJkNrN97ej2Q3
        Gj+yhtbQBxSXxM4PIgKoQZ00Y+WFcStw1BQjrg9NJg==
X-Google-Smtp-Source: APXvYqy6glbhg/aUJCYFMAN9SuvCYntlkCtO/zF6EuEITpgQ95c+mqQohRDXiHboJuAhK6cSgRMv0Oioo1QNX6Cfcw0=
X-Received: by 2002:aed:3c49:: with SMTP id u9mr8054139qte.37.1571825461426;
 Wed, 23 Oct 2019 03:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191023075342.26656-1-yuehaibing@huawei.com>
In-Reply-To: <20191023075342.26656-1-yuehaibing@huawei.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 23 Oct 2019 18:10:50 +0800
Message-ID: <CAB4CAwek7u3_U9T_314P7qK2o7ReKQ0EVvYTkyzrORZjhdSRnA@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: remove set but not used variable 'rate_mask'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 3:54 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:4484:6:
>  warning: variable rate_mask set but not used [-Wunused-but-set-variable]
>
> It is never used since commit a9bb0b515778 ("rtl8xxxu: Improve
> TX performance of RTL8723BU on rtl8xxxu driver")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
Singed-off-by: Chris Chiu <chiu@endlessm.com>

>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 1e3b716..3843d7a 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4481,11 +4481,6 @@ static u16
>  rtl8xxxu_wireless_mode(struct ieee80211_hw *hw, struct ieee80211_sta *sta)
>  {
>         u16 network_type = WIRELESS_MODE_UNKNOWN;
> -       u32 rate_mask;
> -
> -       rate_mask = (sta->supp_rates[0] & 0xfff) |
> -                   (sta->ht_cap.mcs.rx_mask[0] << 12) |
> -                   (sta->ht_cap.mcs.rx_mask[0] << 20);
>
>         if (hw->conf.chandef.chan->band == NL80211_BAND_5GHZ) {
>                 if (sta->vht_cap.vht_supported)
> --
> 2.7.4

Thanks for pointing that out.

Chris
