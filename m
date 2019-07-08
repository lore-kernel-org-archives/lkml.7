Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990A4C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B07A216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G3xgqReY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405049AbfGHUem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:34:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39638 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbfGHUel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:34:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so17277537ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBFZRyCyJk4RFRv9CPsI2krQKYXMzg0NzprO2zX7A1I=;
        b=G3xgqReYoo3GSkZMfROj+G1V+LsFfZ+sxdSupWo479mM+nBsMYlhwh+Tu04N5jaNWt
         nSlvIFgmIAVDBnUi4N+s4Uy6bZFZl6VTNh1UzuKHMWRPTrDbrjkZlx85TsEJQarYbBFz
         9AW5ty334qmUJCphkzlsWNJG3h+Tk1sDgUuCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBFZRyCyJk4RFRv9CPsI2krQKYXMzg0NzprO2zX7A1I=;
        b=poSm6yi4ww0SDQBkYr/AYlkLTOOnEHu6hTaSuUZ9CxZcc101YcoemJJFIFqY+6KWOm
         OQVm+NKgUGwrlJ21/9xNI+BWWHP4aDr2foE1ehWNU5XmZCTk74Gwj43qM9xYNjqU732b
         ZW1jl1GvwYnUZJgoVcsl996r0OQaKsUEG4WxTMouUZgFkUKEwCZc3PE0d/iPtPdvtKL+
         VdihkhUTPQpPiJjEjLghOYOT+VsaZmcvw4pJCoG8eNkbh9vq0iarAt4koodsfwf8DSjZ
         mNsJUb/0Ho4UfYv6SQ3Y9R0sR65CDKtTLeYywCSQA39LsNEyjDdcfSCZXAvgf2oLnXM4
         ynAQ==
X-Gm-Message-State: APjAAAU4GYlKQnxVMzi/QoBjWBx+9kPPE9ponMUO5KSjjQUUOL+dsP0n
        hjAdoGXXponGw2SEGRHlg5UX2LLpLA4=
X-Google-Smtp-Source: APXvYqyjAXGiEoWtWpklHd9glrkq+rs0L86QAjQVVVDsAUrMpxpaaNZfJojGMo/DxLnbpP75KrfDew==
X-Received: by 2002:a2e:9950:: with SMTP id r16mr11751793ljj.173.1562618078710;
        Mon, 08 Jul 2019 13:34:38 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id g4sm2938920lfb.31.2019.07.08.13.34.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 13:34:35 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id v24so17283250ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:34:34 -0700 (PDT)
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr5676774ljl.18.1562618073778;
 Mon, 08 Jul 2019 13:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190708125050.3689133-1-arnd@arndb.de>
In-Reply-To: <20190708125050.3689133-1-arnd@arndb.de>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 8 Jul 2019 13:34:22 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOjPbZ0k8dvWr3b6ns_Y3c_ydanYA9+HVUA00btJB5rxQ@mail.gmail.com>
Message-ID: <CA+ASDXOjPbZ0k8dvWr3b6ns_Y3c_ydanYA9+HVUA00btJB5rxQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: work around uninitialized vht_pfr variable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Miaoqing Pan <miaoqing@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Balaji Pothunoori <bpothuno@codeaurora.org>,
        Wen Gong <wgong@codeaurora.org>,
        Pradeep kumar Chitrapu <pradeepc@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jul 8, 2019 at 5:50 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> As clang points out, the vht_pfr is assigned to a struct member
> without being initialized in one case:
>
> drivers/net/wireless/ath/ath10k/mac.c:7528:7: error: variable 'vht_pfr' is used uninitialized whenever 'if' condition
>       is false [-Werror,-Wsometimes-uninitialized]
>                 if (!ath10k_mac_can_set_bitrate_mask(ar, band, mask,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath10k/mac.c:7551:20: note: uninitialized use occurs here
>                 arvif->vht_pfr = vht_pfr;
>                                  ^~~~~~~
> drivers/net/wireless/ath/ath10k/mac.c:7528:3: note: remove the 'if' if its condition is always true
>                 if (!ath10k_mac_can_set_bitrate_mask(ar, band, mask,
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath10k/mac.c:7483:12: note: initialize the variable 'vht_pfr' to silence this warning
>         u8 vht_pfr;
>
> Add an explicit but probably incorrect initialization here.
> I suspect we want a better fix here, but chose this approach to
> illustrate the issue.
>
> Fixes: 8b97b055dc9d ("ath10k: fix failure to set multiple fixed rate")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/ath/ath10k/mac.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index e43a566eef77..0606416dc971 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -7541,6 +7541,8 @@ static int ath10k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
>                                                                 &vht_nss,
>                                                                 true);

^^ Technically, this call to ath10k_mac_bitrate_mask_get_single_rate()
can fail to assign 'vht_pfr' as well. I can't immediately tell whether
it provably will never hit the -EINVAL case, but if we do, then you'd
have another uninitialized case.

I *believe* it shouldn't fail, since we already pre-checked the VHT
MCS lists for "exactly 1" rate. But it still seems like better code to
pre-initialize and/or add error-handling, so we don't rely on that
implicit proof.

I'm not quite sure yet what the "better" answer should be for
resolving this, but at a minimum, I think the above could be improved.

Brian

>                         update_bitrate_mask = false;
> +               } else {
> +                       vht_pfr = 0;
>                 }
>
>                 mutex_lock(&ar->conf_mutex);
> --
> 2.20.0
>
