Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1158AC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B642173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYNvvqHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfFNUy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:54:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39938 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfFNUy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:54:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so2176630pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKHkgrIbFIJQCw8wD1XxUrC5d565aFWlPJdUMDKpdyQ=;
        b=UYNvvqHsSN3OaOxZAwJbcHL/kAM6bZCt067wRLaW4K0iLAEnyEuF49dvaz4R2zUK11
         7rG44DxDakEJrq1wsGwvd3paGg/qc/a2juliCIwXm3mrmA0s+IpB93Q0zFwd5ntNN1JC
         DDiqbbQ4uHNrbwHy8I+7jSU82ex56I/A91uD186Frx7w406ZHmXMf69GhoL6OFtnBZfs
         81sTgsbYzCOXOuUJ9Ug6qekjUNk+wtcozA3VKnwDhvQO4HHPEoiS9x+4nftynLX3XOpu
         k/y7UnfgwWcCh0eMSL2wPUzWbe5Pl0H92YIhGvtJ6UTckOAUReRQu1mYr0xEqcVLnhXi
         i8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKHkgrIbFIJQCw8wD1XxUrC5d565aFWlPJdUMDKpdyQ=;
        b=lJ297mSXSZ1oI4r1k4nsa9CEnhLuPWQO1kJlHmyBkTnggPC1eUW8C3Yo94DO2j77B/
         bgoxkqlG7v+JCU4gJfDXxpy1QN8BL5hyyHQULxAkdv5hqFGEvZujcXKZ/Rt1CR1sOGhH
         b0B7HV2IWhfljTGZABSOyWFakm3YpUdwl8zOI7KXkL3E0B70rLXB7MfIV+wdY6XBLPCj
         vX8zuhv0sCjaG3YfFWy9NsuZvirjdxKm2KzfKthfkkfFZrPogzPgF9WbnEi5olO6Za4i
         0QzUnpWCRUYQ8NpjCS79vX5CPr12D9ch1SGR2+W7zkcdx5j4EYoFAp9oQ3yyk2OuQHxn
         k6ag==
X-Gm-Message-State: APjAAAXko4KRsCZ4m/bov3+RtO4Ehk54rVvyv3XT0VImS//H8UfX0CMR
        +UNxFw+WfNM6lsGWAH6isfRZzu80wuL+fUKAQht5dg==
X-Google-Smtp-Source: APXvYqxJQiLj537BJ3ZR5Sc93ULFhtds6hlQxqUz2ekknc3TBei1vqS5haeJD3AIue6VRnuxGWBLCLJqsyCPEP1Wv9Y=
X-Received: by 2002:a63:306:: with SMTP id 6mr24636738pgd.263.1560545667771;
 Fri, 14 Jun 2019 13:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190614171713.89262-1-nhuck@google.com>
In-Reply-To: <20190614171713.89262-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Jun 2019 13:54:16 -0700
Message-ID: <CAKwvOd=jFYn=7NGPD8UDx3_g30qD+40bCjzmWJJSzmb6pNUusQ@mail.gmail.com>
Subject: Re: [PATCH] wl18xx: Fix Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>, eliad@wizery.com,
        arik@wizery.com
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 10:17 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Clang produces the following warning
>
> drivers/net/wireless/ti/wl18xx/main.c:1850:43: warning: unused variable
> 'wl18xx_iface_ap_cl_limits' [-Wunused-const-variable] static const struct
> ieee80211_iface_limit wl18xx_iface_ap_cl_limits[] = { ^
> drivers/net/wireless/ti/wl18xx/main.c:1869:43: warning: unused variable
> 'wl18xx_iface_ap_go_limits' [-Wunused-const-variable] static const struct
> ieee80211_iface_limit wl18xx_iface_ap_go_limits[] = { ^
>
> The commit that added these variables never used them. Removing them.

Previous thread, for context:
https://groups.google.com/forum/#!topic/clang-built-linux/1Lu1GT9ic94

Looking at drivers/net/wireless/ti/wl18xx/main.c, there 4 globally
declared `struct ieee80211_iface_limit` but as your patch notes, only
2 are used.  The thing is, their uses are in a `struct
ieee80211_iface_limit []`.

Looking at
$ git blame drivers/net/wireless/ti/wl18xx/main.c -L 1850
points to
commit 7845af35e0de ("wlcore: add p2p device support")
Adding Eliad and Arik to the thread; it's not clear to me what the
these variables were supposed to do, but seeing as the code in
question was already dead, this is no functional change from a user's
perspective.  With that in mind:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

So I'd at least add the tag.
Fixes: 7845af35e0de ("wlcore: add p2p device support")

> --- a/drivers/net/wireless/ti/wl18xx/main.c
> +++ b/drivers/net/wireless/ti/wl18xx/main.c
> @@ -1847,44 +1847,6 @@ static const struct ieee80211_iface_limit wl18xx_iface_ap_limits[] = {
>         },
>  };
>
> -static const struct ieee80211_iface_limit wl18xx_iface_ap_cl_limits[] = {
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_STATION),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_AP),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_P2P_CLIENT),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_P2P_DEVICE),
> -       },
> -};
> -
> -static const struct ieee80211_iface_limit wl18xx_iface_ap_go_limits[] = {
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_STATION),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_AP),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_P2P_GO),
> -       },
> -       {
> -               .max = 1,
> -               .types = BIT(NL80211_IFTYPE_P2P_DEVICE),
> -       },
> -};
> -

-- 
Thanks,
~Nick Desaulniers
