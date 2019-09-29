Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E41CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 11:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E682190F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 11:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TezKHyJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfI2LWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 07:22:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51283 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfI2LWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 07:22:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so10275684wme.1;
        Sun, 29 Sep 2019 04:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=+5mJbdKNBA+m8vppAhdI++7fky2Q3/YXSRQyiXoFCLc=;
        b=TezKHyJE5Sh4r/up5iuLlLvtQlnGcW+cP3IjZjdyn5mNmGmckP4YUZ8u37UQI5CyR1
         m1FoANAti7h7OpC1dgvPkyokVmeCFCBzhLGkHcypq17mEOUhfDO6m6kiacC4AkHBcS/V
         pB4fPiz8qqNc6npdgyAYdUAobBrUunE99yOU1yTCva+DlTDmV9EBtEujS5NOcTPlL6/n
         RXCs/THrVHusCcxQTTp54XhPw+EbTD3N2Cg01ICIIVWHrPwYb5egg6bbzc9eicSROIT5
         5Zy74W/86zXdQ4K6YH3DvUskoFg2xs0U3sVBuP7AAUvTyAYYQ/AbzHr4zPoJHpbM2PP5
         //Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=+5mJbdKNBA+m8vppAhdI++7fky2Q3/YXSRQyiXoFCLc=;
        b=sCa5RoHtSCTjh6Nk0isQnSAEktzBUqmOc0gViRmJRJ7vQoVgZSj1fLrInlsgUqQbm9
         KuL8Udc2yyAunH3wDXX/ALWAfsDNcYD0RQ8hXHr7KDr2hD17zdlt2edQ0a63h3I/dqcf
         6MC42J1pi1pLkY9FtmrGs03snwq58L227f/ju8OetanMU0c7JGVoSRaITOAwTIMfL8YQ
         z++YjDcXdRcJt3oWUU7fXy/mvdTF28DDARu6VwZ+k98uFMHrPQQTO5vn9dG+rBvGU0EV
         haU/dQWRFLxf5rGyTe002SnOAOuj4UtueylNZ/Z5Ctcob8wWqduCM0HwufO4YxkiNuns
         4U0Q==
X-Gm-Message-State: APjAAAW9lOeVcHY98xyiQeMlgLnLlbQqZScbtv5O5Zr2m8Ukhi8n2+AF
        hOd/lbUx2iZ/BSioZKeVISw=
X-Google-Smtp-Source: APXvYqwYBuT58Y/Ro1CA1xclbEevvBfYgIFxMJg2pEEKp5Se24KdjkrFWsiKF4sAjXe2yJ4wuhzJrw==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr13222224wmk.62.1569756141017;
        Sun, 29 Sep 2019 04:22:21 -0700 (PDT)
Received: from localhost ([94.73.41.211])
        by smtp.gmail.com with ESMTPSA id m62sm13230613wmm.35.2019.09.29.04.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 04:22:18 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <heiko@sntech.de>,
        <ezequiel@collabora.com>, <akash@openedev.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix usb-c on Hugsun X99 TV Box
Date:   Sun, 29 Sep 2019 13:22:17 +0200
MIME-Version: 1.0
Message-ID: <54c67ca8-8428-48ee-9a96-e1216ba02839@gmail.com>
In-Reply-To: <20190929032230.24628-1-npcomplete13@gmail.com>
References: <20190929032230.24628-1-npcomplete13@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 29, 2019 5:22:30 AM CEST, Vivek Unune wrote:
> Fix usb-c on X99 TV Box. Tested with armbian w/ kernel 5.3
>
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts=20
> b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> index 0d1f5f9a0de9..c133e8d64b2a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> @@ -644,7 +644,7 @@
>  =09status =3D "okay";
> =20
>  =09u2phy0_host: host-port {
> -=09=09phy-supply =3D <&vcc5v0_host>;
> +=09=09phy-supply =3D <&vcc5v0_typec>;
>  =09=09status =3D "okay";
>  =09};
> =20
> @@ -712,7 +712,7 @@
> =20
>  &usbdrd_dwc3_0 {
>  =09status =3D "okay";
> -=09dr_mode =3D "otg";
> +=09dr_mode =3D "host";
>  };
> =20
>  &usbdrd3_1 {

Hi Vivek,

which is the relationship of your patch and this commit:

e1d9149e8389f1690cdd4e4056766dd26488a0fe
arm64: dts: rockchip: Fix USB3 Type-C on rk3399-sapphire

with respect to this other commit:

c09b73cfac2a9317f1104169045c519c6021aa1d
usb: dwc3: don't set gadget->is_otg flag

?

I did not test reverting e1d9149e since c09b73cf was applied.

Regards,
  Vicen=C3=A7.

