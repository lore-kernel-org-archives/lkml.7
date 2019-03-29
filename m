Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B864CC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873A8217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="0SVwoqOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfC2X2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:28:17 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38535 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbfC2X2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:28:16 -0400
Received: by mail-vs1-f67.google.com with SMTP id s2so1222144vsi.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 16:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+JtnuU29EdY9D4FrIJN6PNOqz5gfVF3nZGn0l9m1fUc=;
        b=0SVwoqOY8HAf1EO+n+FhSeIgPTLwZgG88y07dzUT/PSGEUmlXLoSPAI9BoYjVlTLEN
         LXXQ1noQFUySvCG0QoOJpeNg7t3+2F36MgeqeIlg+3xuQOV1wE2mbjea7/IjbdTJTXl0
         m+Dw7Gcik1UsrbXNt06jtHxDhtLypP76ornC/j8FOHyvbzDp7NvE809mWlnN2USNRmvc
         SABj7MOsHqx29GNOOGFlTFJHQxooMGuSfurpYqOSi7cEou9iWbB8FuTsNu5tCeac94+3
         r5zxZ+9r1RRJxj/BrkuLJcSOs7A/J5tbwJnEBUg+c8GPEVIdnatxJiTo8T5fiR0N9U8V
         XqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+JtnuU29EdY9D4FrIJN6PNOqz5gfVF3nZGn0l9m1fUc=;
        b=cWhKcK4t04L4Md1dJ9ZS7wKp1luRt3EaTtDnlzgYPsDTILUrCsuS0pHnj2Z8a442XU
         L9t/E3gXiXGSVZ0auXj+Lidq9JLt0rpmdqtrxJLHEbhXSGvP5cnQUXel+d23h9/VSRbR
         6wbfqEfi7OwKe6no+mWFmutoRiZ4puGeYfIHuETPQ1r9NojnyoFE3XwlSwwMqilp8q/B
         78DbkZKfv2pQEzxjS1n1eU1E+8zWbqIpkZvgEa84+9aiD5O5OIRg+4Ml9UflopwFo9xC
         RpNtBWPsBmW1QMbOd0TpjXedLMda3VMCwQ264NRrzTvuzW3246No9n1uVDmcaUsqWL7Z
         iNww==
X-Gm-Message-State: APjAAAVv1H7zdOqZPI0YeiHGjfcK1wpGXJ4uFGp1HF3Yb0s2pMZp8Mei
        vfT8Ec5ejxB+gNAe3csjFOiCgmhELcAJuua4kwQrsA==
X-Google-Smtp-Source: APXvYqyi0lTZgMz8oW1UdC2H57E/xYz7jsBaRc9Yr1bQDqABm3+bG07HdtxhvhLlnv/5SkSpGykalNOXYPRvpBYtl+E=
X-Received: by 2002:a67:6991:: with SMTP id e139mr30379607vsc.80.1553902095669;
 Fri, 29 Mar 2019 16:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190329215455.159717-1-dianders@chromium.org>
In-Reply-To: <20190329215455.159717-1-dianders@chromium.org>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 29 Mar 2019 20:28:04 -0300
Message-ID: <CAAEAJfCvZ_y-No6vQbf_3kUSyuPYujTjW8XhZHiB=-GU2_NWHQ@mail.gmail.com>
Subject: Re: [PATCH] clk: rockchip: Fix video codec clocks on rk3288
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Tomasz Figa <tfiga@chromium.org>,
        Ziyuan Xu <xzy.xu@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        ryandcase@chromium.org, Elaine Zhang <zhangqing@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 at 18:55, Douglas Anderson <dianders@chromium.org> wrot=
e:
>
> It appears that there is a typo in the rk3288 TRM.  For
> GRF_SOC_CON0[7] it says that 0 means "vepu" and 1 means "vdpu".  It's
> the other way around.
>
> How do I know?  Here's my evidence:
>
> 1. Prior to commit 4d3e84f99628 ("clk: rockchip: describe aclk_vcodec
>    using the new muxgrf type on rk3288") we always pretended that we
>    were using "aclk_vdpu" and the comment in the code said that this
>    matched the default setting in the system.  In fact the default
>    setting is 0 according to the TRM and according to reading memory
>    at bootup.  In addition rk3288-based Chromebooks ran like this and
>    the video codecs worked.
> 2. With the existing clock code if you boot up and try to enable the
>    new VIDEO_ROCKCHIP_VPU as a module (and without "clk_ignore_unused"
>    on the command line), you get errors like "failed to get ack on
>    domain 'pd_video', val=3D0x80208".  After flipping vepu/vdpu things
>    init OK.
> 3. If I export and add both the vepu and vdpu to the list of clocks
>    for RK3288_PD_VIDEO I can get past the power domain errors, but now
>    I freeze when the vpu_mmu gets initted.
> 4. If I just mark the "vdpu" as IGNORE_UNUSED then everything boots up
>    and probes OK showing that somehow the "vdpu" was important to keep
>    enabled.  This is because we were actually using it as a parent.
> 5. After this change I can hack "aclk_vcodec_pre" to parent from
>    "aclk_vepu" using assigned-clocks and the video codec still probes
>    OK.
>
> Fixes: 4d3e84f99628 ("clk: rockchip: describe aclk_vcodec using the new m=
uxgrf type on rk3288")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I currently have no way to test the JPEG mem2mem driver, so hopefully
> others can test this and make sure it's happy for them.  I'm just
> happy not to get strange errors at boot anymore.
>

I won't have access to this hardware for a few days, but I am happy
to provide a simple test tool.

Still haven't reviewed this, but thanks for chasing it down!

EZe

>  drivers/clk/rockchip/clk-rk3288.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk=
-rk3288.c
> index 5a67b7869960..4d767f9c3a80 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -219,7 +219,7 @@ PNAME(mux_hsadcout_p)       =3D { "hsadc_src", "ext_h=
sadc" };
>  PNAME(mux_edp_24m_p)   =3D { "ext_edp_24m", "xin24m" };
>  PNAME(mux_tspout_p)    =3D { "cpll", "gpll", "npll", "xin27m" };
>
> -PNAME(mux_aclk_vcodec_pre_p)   =3D { "aclk_vepu", "aclk_vdpu" };
> +PNAME(mux_aclk_vcodec_pre_p)   =3D { "aclk_vdpu", "aclk_vepu" };
>  PNAME(mux_usbphy480m_p)                =3D { "sclk_otgphy1_480m", "sclk_=
otgphy2_480m",
>                                     "sclk_otgphy0_480m" };
>  PNAME(mux_hsicphy480m_p)       =3D { "cpll", "gpll", "usbphy480m_src" };
> --
> 2.21.0.392.gf8f6787159e-goog
>


--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
