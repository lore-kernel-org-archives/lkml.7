Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87680C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522EF21473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBijOQ5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfEVNd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:33:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44172 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVNd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:33:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so2311983wru.11;
        Wed, 22 May 2019 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e/eilVLoEQqgBnvBe7r+LiENo1yLHv47YV+XQ5Ig/9o=;
        b=WBijOQ5m34sH5yA41I6jfN56RJ3Ua4m3bxmfmZEqhuL1hG6cvt736LJU0/uU3snKbV
         gHqRaohaeI56G74EYp6QWCaAZW2XYJvv02WhIeTBdA0aSLnfkkZUr6NzSP3sHdaEDyRK
         gMsvZYEUP+TgG0qU3ckz3uz5ih0tkwGC/ohU49yuKsRS+kALpv1IH2pOj6W0n0y82Rpd
         7RXs9zLqxU4kc+qhOpIQFDEaZ+NiOp3aU9ztn6MsVdr8kbulNAGqzlP7RlSP3k74zVC7
         pxCdaNxbxZc3hBHVoQqQ+T8xMFFBfzWuxKt7fOQOA6dSXk5G/j9wqiNSM4NQ/xoDAze8
         ZXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e/eilVLoEQqgBnvBe7r+LiENo1yLHv47YV+XQ5Ig/9o=;
        b=rWGATVSRahIvd/EBzyKUK0uw+j63KPBW7eNAQ2SCzXY8f2vH5RLsBSvmGH8/gN02fR
         QBWprb+9m9oWy0+bSvLDvgmuCRiQSHDU8HaJuVvg54mKKBi8n9uzL8KpEclKl7JxQGjg
         WzXvUjl8h19xzJwmUnOxEnDfjA4INEZPp1ZTWupWtXsuzjgNpl2TXPkL2L9JBZkrkBw2
         X0nvbn+brYwej3Pwqh2V5RIElp70PNtZyHDmi/9Vjj0qg09ohSyxK0QJoXmR+WKKcK8b
         QgprSChLEGV3gWncAqjOIjQ0h6mEN4kzzN7XyDtLHY7fuZDYL57cFgi80wUNOjW6SCmC
         Rx5g==
X-Gm-Message-State: APjAAAWTjxzRaiOpA/d+bEdJycBPYYRmIk5hATU+Fdf9SMs3bHCTztjU
        oFQuYJiNa18BxFe+tJjugf8=
X-Google-Smtp-Source: APXvYqwr9CDQH7mNQcJWQ05wWtBxQGNrzDpDSpJqX2p7aELro278CPZQ4YQJgdce1amiAtV3+xMJFA==
X-Received: by 2002:adf:fc8f:: with SMTP id g15mr1998390wrr.122.1558532034508;
        Wed, 22 May 2019 06:33:54 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id u15sm45042485wru.16.2019.05.22.06.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 06:33:53 -0700 (PDT)
Date:   Wed, 22 May 2019 15:33:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, jckuo@nvidia.com, talho@nvidia.com,
        josephl@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 00/12] LP0 entry and exit support for Tegra210
Message-ID: <20190522133352.GO30938@ulmo>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B3NBd8mrXZtPJEYR"
Content-Disposition: inline
In-Reply-To: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B3NBd8mrXZtPJEYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 04:31:11PM -0700, Sowjanya Komatineni wrote:
> This patch series includes Tegra210 deepsleep or LP0 support with
> deep sleep exit through RTC alarm wake and power button wake events.

There doesn't seem to be support for waking up from a power button
press. Is that in a patch that you didn't send out yet, or are you still
working on that?

The recipient list on this is very trimmed. I'm not sure if this was on
purpose. I'm fine if you want to keep it that way until things settle
down a bit, but eventually the subsystem maintainers will need to see
these, so make sure to Cc them when you think the patches are ready.

Thierry

>=20
> This series also includes save and restore of PLLs, clocks, OSC contexts
> for basic LP0 exit.
>=20
> This patch series is doesn't support for 100% suspend/resume to fully
> functional state and we are working on some more drivers suspend and
> resume implementations.
>=20
> Sowjanya Komatineni (12):
>   irqchip: tegra: do not disable COP IRQ during suspend
>   pinctrl: tegra: add suspend and resume support
>   clk: tegra: save and restore PLLs state for system
>   clk: tegra: add support for peripheral clock suspend and resume
>   clk: tegra: add support for OSC clock resume
>   clk: tegra: add suspend resume support for DFLL clock
>   clk: tegra: support for Tegra210 clocks suspend-resume
>   soc/tegra: pmc: allow support for more tegra wake models
>   soc/tegra: pmc: add pmc wake support for tegra210
>   gpio: tegra: implement wake event support for Tegra210 and prior GPIO
>   soc/tegra: pmc: configure tegra deep sleep control settings
>   arm64: tegra: enable wake from deep sleep on RTC alarm.
>=20
>  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi |   7 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi       |   5 +-
>  drivers/clk/tegra/clk-dfll.c                   |  82 ++++++
>  drivers/clk/tegra/clk-dfll.h                   |   2 +
>  drivers/clk/tegra/clk-divider.c                |  19 ++
>  drivers/clk/tegra/clk-pll-out.c                |  25 ++
>  drivers/clk/tegra/clk-pll.c                    | 220 ++++++++++++--
>  drivers/clk/tegra/clk-tegra-fixed.c            |  15 +
>  drivers/clk/tegra/clk-tegra210.c               | 382 +++++++++++++++++++=
++++++
>  drivers/clk/tegra/clk.c                        |  74 ++++-
>  drivers/clk/tegra/clk.h                        |  18 ++
>  drivers/gpio/gpio-tegra.c                      | 109 ++++++-
>  drivers/irqchip/irq-tegra.c                    |  10 +-
>  drivers/pinctrl/tegra/pinctrl-tegra.c          |  68 ++++-
>  drivers/pinctrl/tegra/pinctrl-tegra.h          |   3 +
>  drivers/pinctrl/tegra/pinctrl-tegra114.c       |   1 +
>  drivers/pinctrl/tegra/pinctrl-tegra124.c       |   1 +
>  drivers/pinctrl/tegra/pinctrl-tegra20.c        |   1 +
>  drivers/pinctrl/tegra/pinctrl-tegra210.c       |   1 +
>  drivers/pinctrl/tegra/pinctrl-tegra30.c        |   1 +
>  drivers/soc/tegra/pmc.c                        | 159 +++++++++-
>  21 files changed, 1167 insertions(+), 36 deletions(-)
>=20
> --=20
> 2.7.4
>=20

--B3NBd8mrXZtPJEYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzlT8AACgkQ3SOs138+
s6E/gxAAu98wY6tGYvONnepzK4edJe84108hoTkQo81y8IT5p0twCMrJCLSK3kbl
Pw1K9ixrGK1cqV2mvTfaZAiF/Dt+ueZCIWrpqKSvyPRuGIYF6lVUEZ+PXak7J8t1
uVHA8+M6/TvDOytvb4cjWwVv8bWoMkgbUU2AdYObEfvMjSrl54ZhCjk1TyuuOfFY
Cg84ygIRe+EXFhrmahxWs3EgupHziiFDXMaZrctTgenmgGLWKV1F3wIWehDQ/HP/
wPtxI4Vez7uX+JhArAtkXEVUusFce3e8j0plsWeXLhx1LVNNlpEEuBown/qaU4oA
2neByqV3oTO30r2wtqjv3snwN2Eosu/66EZGkpDO0zKbQcf8LTqadnqja6zmzMQB
TLFArTqpmH3oi6hmAhMNE/rYx4W4uMKKYaPfaugGrXn5a92byJ9kJEC1U+bh7dpH
976Sm9ksAlVFfYH+YaChyrwIWOfhWiSZ8TgoqlJ7iSp6SpHGnNsGvR1ZOecg53YF
s+VUjwfT/s+s9ykWyNHA/Swf+GsGey1L1glvbEcCBqCL0dp5PkI5A4DFigvEVnUK
KaND7VQe7zfBC5v/+Nc5GjWBgt7SaOKs83kn/zzyWmsMjNRyY8CeplykBdCrHD+b
Sik2p0It26u3IfQPEKHfTk9Jrt/BRiL+c6TeWwJGVz5zl/TBd+o=
=3vyI
-----END PGP SIGNATURE-----

--B3NBd8mrXZtPJEYR--
