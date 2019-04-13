Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9F3C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796042147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4UJ8Ms4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfDMVkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:40:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34372 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfDMVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:40:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id h5so7208677lfm.1;
        Sat, 13 Apr 2019 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WM9+U+xqebGhe2yULQ1djRoc5FHNKF/KatTj8+fcIg=;
        b=t4UJ8Ms4Ce3iP8rNGMCgpUL6UpbdmDAcXEyB+BmVmSUKWKJAMTCtbPs0nw3sWqVE7t
         K0MTya3U9p2IDXvcJ64Eyza4noBSRtRggfLbvhKWdvnv6jzAsLNW+mPqSPL8aN23rXF+
         +RCrpnIeb8L33iMSmOCNXN3zmOcOneaRmObhzQ8a5AD5JkLX45VUsNMinPWy1LBWfu7g
         7NLDw2jMa342fJG3/e/mHwyS0tWppQbQutymW2VvMskWw3kwNw2zRHRb8cby01Y6U6pH
         XqPE2gtxCFFHbpr4lQZiwRqkItL9E0o1cN8z8vimWBCpJfzN+r2wCrEQQqGqJxsHGMyy
         C+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WM9+U+xqebGhe2yULQ1djRoc5FHNKF/KatTj8+fcIg=;
        b=Xs8GWvQnDMAwNTqgEr7DuJ7fRyakTnbphnYf4D4PPDxjOm9lP3WBO0rDQ2iXsblmum
         as5cr7iUrWqGEPFWoO1giBLxQonAwaoo8VKRFv8pbpll4yTkz3boJNWP3m9TjTmPcRx9
         Cx9mPJlK+90rK6OSjns3u80me6qIRe6c60St63xreh0TeLFwySmD/EwfzcjVbFXm2ADE
         iStHyl9Ah26qy4ZzNh2mQpvnZNQrH5OhutZ/MPpl87t510iqxhabadxaDKARWhiukmn9
         P8dpTnABB4SAfG9nHQQjxBUN4PrndPw5AuaSUvJsWFU0QraqE91RlHv36nd9Ht1at95f
         19TA==
X-Gm-Message-State: APjAAAXAn3xVckVf8ZlbBjFubKPc1knM9ySU07FmU9YmX+XkDpDD/EUl
        Pf/F5qWxKRk69d3tITGYKt7n1S7JC4EcTJVKYaI=
X-Google-Smtp-Source: APXvYqz8lvzeE+ftYypSUbZk60lCvU7KPY1+LsoXFhJD5prqrpi9RCJOvh+IxVW6FgVfr2X/5qIUYhy1cw4sMXdk1rA=
X-Received: by 2002:ac2:48bb:: with SMTP id u27mr8646491lfg.17.1555191606341;
 Sat, 13 Apr 2019 14:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190413012822.30931-1-olteanv@gmail.com> <20190413012822.30931-17-olteanv@gmail.com>
 <20190413205629.GD2268@nanopsycho.orion>
In-Reply-To: <20190413205629.GD2268@nanopsycho.orion>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sun, 14 Apr 2019 00:39:55 +0300
Message-ID: <CA+h21hpStYyyg=BD4n=RppQx-4a1y03k45qKrJnAeF8xuj3ruQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 16/24] net: dsa: sja1105: Add support for VLAN operations
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2019 at 23:56, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Sat, Apr 13, 2019 at 03:28:14AM CEST, olteanv@gmail.com wrote:
> >VLAN filtering cannot be properly disabled in SJA1105. So in order to
> >emulate the "no VLAN awareness" behavior (not dropping traffic that is
> >tagged with a VID that isn't configured on the port), we need to hack
> >another switch feature: programmable TPID (which is 0x8100 for 802.1Q).
> >We are reprogramming the TPID to a bogus value (ETH_P_EDSA) which leaves
> >the switch thinking that all traffic is untagged, and therefore accepts
> >it.
> >
> >Under a vlan_filtering bridge, the proper TPID of ETH_P_8021Q is
> >installed again, and the switch starts identifying 802.1Q-tagged
> >traffic.
> >
> >Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> >Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> >---
> >Changes from v3:
> >Changed back to ETH_P_EDSA.
> >
> >Changes from v2:
> >Changed the TPID from ETH_P_EDSA (0xDADA) to a newly introduced one:
> >ETH_P_DSA_8021Q (0xDADB).
> >
> > drivers/net/dsa/sja1105/sja1105_main.c        | 254 +++++++++++++++++-
> > .../net/dsa/sja1105/sja1105_static_config.c   |  38 +++
> > .../net/dsa/sja1105/sja1105_static_config.h   |   3 +
> > 3 files changed, 293 insertions(+), 2 deletions(-)
> >
>
> [...]
>
>
> >+#define sja1105_vlan_filtering_enabled(priv) \
> >+      (((struct sja1105_general_params_entry *) \
> >+      ((struct sja1105_private *)priv)->static_config. \
> >+      tables[BLK_IDX_GENERAL_PARAMS].entries)->tpid == ETH_P_8021Q)
>
> This is unreadable. Please have it as function.
>

I admit to that. If I reach to a consensus with Andrew on 12/24
ideally I could just say cpu_dp->vlan_filtering.

Thanks,
-Vladimir
