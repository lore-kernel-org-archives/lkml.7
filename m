Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2234BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11A32186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LC8ljuIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbfDRQcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:32:09 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44029 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRQcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:32:08 -0400
Received: by mail-vs1-f67.google.com with SMTP id t23so1471882vso.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7aEoO3va/0BYOjnj8WvPH3DexQjXPldBvVCPc/BO0+E=;
        b=LC8ljuIS5vQfdwj932zztWi2uWtQdGmIdN0IIpsyiY77Bi4RDLcIvAo69jBT1JMlYG
         WJZ/QDfIWn+DqAp1S0hK8lWv9LnFufnqdAwmtIaRScKvGXHGbspyzpuKv795j3mLdvqg
         6Vnk51E3Xcv8blk7fPARmZ8hM/jqctLsUKl7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7aEoO3va/0BYOjnj8WvPH3DexQjXPldBvVCPc/BO0+E=;
        b=Tun3q58zxqQC2JSuFyQi4vKINC0w56tYgdf75yQ4pQzv6h9mnfSwvn1dYK45NJew9P
         3BpSoPKdoOgklPLetmbXOMS+TadcWzztOk8JhP17jx4PDn4Ba/T7tkpModGByi+HmUAw
         zabl5wtEOXnv1LgKurnWEkaZkeuLfymoP4PP3ktyvC+kAvXHWKKrB57+M4nyQtaRU3sZ
         blsWbLnz0rCYilTrmj/5N6qjn5Wlp8HchdQ29qZAx6MhCZjdVmRpfALP/+KlTeqKRzxr
         ySGS1M+nP4Bik1pF007lndFDClxDFxhppNkERansgZWfrnAfqGMJeaB65wFYYhNeszpY
         BGFA==
X-Gm-Message-State: APjAAAVZVOJDx0X91+rJ3hpWHj0rl0e25vNg9eC5n9W7SwurHVP/ObEP
        blDUpTtObsmILN6BWJuc3Kecnx0Tixc=
X-Google-Smtp-Source: APXvYqzEJNfUKcqrcjhmwzcMXMJmOhbOsI+VmbfhUQ+Dcy2HFtWLct/HcjC2m06hAJOsHo5esoP8NA==
X-Received: by 2002:a67:f948:: with SMTP id u8mr9728875vsq.179.1555605127111;
        Thu, 18 Apr 2019 09:32:07 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id c191sm451766vsd.4.2019.04.18.09.32.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 09:32:04 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a46so963557uae.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:32:04 -0700 (PDT)
X-Received: by 2002:ab0:2692:: with SMTP id t18mr23156240uao.106.1555605123742;
 Thu, 18 Apr 2019 09:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190404040106.40519-1-dianders@chromium.org> <874l7egxdj.fsf@codeaurora.org>
 <CA+ASDXNfOUmMEWYwts8PuiDaEjuoPK+tZ0BhDSSte5u5toydkA@mail.gmail.com> <87ef6hruno.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87ef6hruno.fsf@kamboji.qca.qualcomm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Apr 2019 09:31:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WgTUgMg-r2ZJ6rKOiv5Lw_m-EX6c0it6znA9v8AO+z_A@mail.gmail.com>
Message-ID: <CAD=FV=WgTUgMg-r2ZJ6rKOiv5Lw_m-EX6c0it6znA9v8AO+z_A@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: Make resume actually do something useful again
 on SDIO cards
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ganapathi Bhat <gbhat@marvell.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Nishant Sarmukadam <nishants@marvell.com>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Xinming Hu <huxinming820@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 4, 2019 at 8:35 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Brian Norris <briannorris@chromium.org> writes:
>
> > On Wed, Apr 3, 2019 at 10:20 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> >> Douglas Anderson <dianders@chromium.org> writes:
> >> > Fixes: fc3a2fcaa1ba ("mwifiex: use atomic bitops to represent
> >> > adapter status variables")
> >> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>
> >> I'm planning to queue this for 5.1.

Do you know when you plan to queue this?  I don't see the patch in
Linus's tree nor in linux-next.  Just want to make sure it didn't get
forgotten...

Thanks!

-Doug
