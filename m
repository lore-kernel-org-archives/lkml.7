Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D0DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8BE20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="BHpocQOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfCZJgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:36:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39508 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZJgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:36:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id p20so9641034eds.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PSFfo1XYuTsNI5Q++mpIqLdCe2wZvdxW6Z15feDbVU8=;
        b=BHpocQOLKspioF6M8qgm9e1HETjtxrwoInhXRaWw2KQMUPDmi8+6jZ5+aIerAq9Nc+
         KS8uv1pbUyYtWG7tsfG3wEF8UQSLG9VEEkqFRmXFxUCmP0PbRhonrXRd+Nk54z3V5dbp
         7ia1xsiWHdzsWZ/8aZ/7UE0TCiBQDfddEtq81VhBA1KGOGdjpSAHJLuM5ijF3I2AUOyX
         GfyWVsiK8pTKIIjukL6IhdDUNSaYiAJyeG6Gu4gZIlYgAhsPf91+ssqLGQJ+rf0i9crM
         AXNv6XGaPJFMmWDk1eZhROvhXPm6irjTM+B3xEusO2GS8/9JpU3xf1j/okVvHwl96zjV
         XXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PSFfo1XYuTsNI5Q++mpIqLdCe2wZvdxW6Z15feDbVU8=;
        b=Uant1Y5Rz9phoqTUkXgEfYYc5sVcC/aOVv/TgVz5drFoaKTyIdzOqWT6i6bFNdTZfi
         UodSDFhYSW7oKJ1xx0dfUP+fMoCt1JAkmMES38tIzmg+q8u3o8iuOl8CKLqnDvNJF4gy
         oZgIUzaloPrS20NZwIISZkMkUAzRQBAmuBR6jNehxE0jddgVio6tcrmM656PbqrIxpVZ
         ErBk0JsduhDjFORmeNK7ukd5aNoDsLZ6V9b+Z+9OYDc/FHJNdcxt4hu/ja/UCzCDaZYW
         mGSHDh/Tx7yaxLmW4or55Mk9NGsrhK7pyJ23b1mQBAQgpqFr9qx/ZhxjGEqOCrVDRRbh
         /P+g==
X-Gm-Message-State: APjAAAUOmYCtyuMaWs58+Iob04MJFiMnK4WVEttc//Ui5ynb4NFtxSuF
        iUjq/AdGlxTlS+ymcWVAZPeX7A==
X-Google-Smtp-Source: APXvYqwFPfLtN610Iz2ze6L4hqrE/k7BCJQ2g5eCDY39Dzxizq0Bv/Qohtec86vQE2T79xhS6F8oCw==
X-Received: by 2002:a17:906:c50:: with SMTP id t16mr16268680ejf.97.1553592962876;
        Tue, 26 Mar 2019 02:36:02 -0700 (PDT)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id d10sm6577409edk.14.2019.03.26.02.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 02:36:02 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:36:00 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] cfg80211: Change an 'else if' into an 'else' in
 cfg80211_calculate_bitrate_he
Message-ID: <20190326093558.ymokh5xxyww2dti5@netronome.com>
References: <20190307235735.31487-1-natechancellor@gmail.com>
 <CAK8P3a1vsJ9qUg_p0UN_xSmYupApY++J8ZP2frmYR7Ja3Hc4iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1vsJ9qUg_p0UN_xSmYupApY++J8ZP2frmYR7Ja3Hc4iQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:16:06PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 8, 2019 at 12:57 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > net/wireless/util.c:1223:11: warning: variable 'result' is used
> > uninitialized whenever 'if' condition is false
> > [-Wsometimes-uninitialized]
> >
> > Clang can't evaluate at this point that WARN(1, ...) always returns true
> > because __ret_warn_on is defined as !!(condition), which isn't
> > immediately evaluated as 1. Change this branch to else so that it's
> > clear to Clang that we intend to bail out here.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/382
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  net/wireless/util.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/wireless/util.c b/net/wireless/util.c
> > index e4b8db5e81ec..75899b62bdc9 100644
> > --- a/net/wireless/util.c
> > +++ b/net/wireless/util.c
> > @@ -1220,9 +1220,11 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
> >         else if (rate->bw == RATE_INFO_BW_HE_RU &&
> >                  rate->he_ru_alloc == NL80211_RATE_INFO_HE_RU_ALLOC_26)
> >                 result = rates_26[rate->he_gi];
> > -       else if (WARN(1, "invalid HE MCS: bw:%d, ru:%d\n",
> > -                     rate->bw, rate->he_ru_alloc))
> > +       else {
> > +               WARN(1, "invalid HE MCS: bw:%d, ru:%d\n",
> > +                    rate->bw, rate->he_ru_alloc);
> >                 return 0;
> > +       }
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> I independently came up with the same fix before I saw yours,
> the only difference was that I avoided the extra curly braces
> using
> 
> +       else
> +               return !WARN(1, "invalid HE MCS: bw:%d, ru:%d\n",
> +                            rate->bw, rate->he_ru_alloc);
> 
> to avoid the mix of bare if() and if() {}

Right, shouldn't all arms of the if/else if/else conditional have {}
if any arm has {}.
