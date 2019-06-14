Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20940C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F136821841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534329;
	bh=kx4whV3+G7xv6Ua4IzE5Zy4KcxaFapVmVAK6sYZUR9w=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=Q9q7OVg/F9p4SbsBpl2X37dmhwAY8M+UPQzm+FnGjkbdtI4Phv83qKsinz9ROFzx6
	 5wDuNhwb/5MmrikqWGcTxXM9KD5gzC8AnLXHT65qcuxWjjWWv+5S61fArX9IpdtXDB
	 N5X3368Qgvve9dt5cDMYmJhuZCs8DEAb74ZAy1S4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFNRp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfFNRp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:45:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F805217D6;
        Fri, 14 Jun 2019 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560534326;
        bh=kx4whV3+G7xv6Ua4IzE5Zy4KcxaFapVmVAK6sYZUR9w=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=NnyqCi+vlDw4kRWkVqrmIm6G5wsVWphvPzg9cKyQ3snje5k3zJEzryynKo3PS9a2Y
         iBbL+mLbmkn5RscFsNohnZ0C3pUPnTFOGFc56J9DXIKAKaqyw4VrIcEnDi8nh/s8+f
         eUqgn4VUbY0weoGF+brolP67G/unwp9nY71RNGzE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190614165454.13743-4-heiko@sntech.de>
References: <20190614165454.13743-1-heiko@sntech.de> <20190614165454.13743-4-heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/4] ARM: dts: rockchip: add display nodes for rk322x
Cc:     linux-arm-kernel@lists.infradead.org,
        justin.swartz@risingedge.co.za, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        Heiko Stuebner <heiko@sntech.de>
User-Agent: alot/0.8.1
Date:   Fri, 14 Jun 2019 10:45:25 -0700
Message-Id: <20190614174526.6F805217D6@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiko Stuebner (2019-06-14 09:54:53)
> From: Justin Swartz <justin.swartz@risingedge.co.za>
>=20
> Add display_subsystem, hdmi_phy, vop, and hdmi device nodes plus
> a few hdmi pinctrl entries to allow for HDMI output.
>=20
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> [added assigned-clock settings for hdmiphy output]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/rk322x.dtsi | 83 +++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
> index da102fff96a2..148f9b5157ea 100644
> --- a/arch/arm/boot/dts/rk322x.dtsi
> +++ b/arch/arm/boot/dts/rk322x.dtsi
> @@ -143,6 +143,11 @@
>                 #clock-cells =3D <0>;
>         };
> =20
> +       display_subsystem: display-subsystem {
> +               compatible =3D "rockchip,display-subsystem";
> +               ports =3D <&vop_out>;
> +       };
> +

What is this? It doesn't have a reg property so it looks like a virtual
device. Why is it in DT?

