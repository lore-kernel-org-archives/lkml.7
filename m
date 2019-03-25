Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C39C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4483B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5HCtFVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfCYOKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:10:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37750 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfCYOKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:10:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so7966258ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fu8AgEX5gUBRp361nW/mG2J0GbtM6cqKS93FYoescJw=;
        b=k5HCtFVf4+XfVAPhRZWZgfjFTkkA9iTe6+gUCLA767SFjjWw35ACW8Xfa2ggpwi3lb
         /J9pdW0sg5FEPZ2W+uQIfzoFiBrrrYibQ+w2XXrMJXsqb5Jvf8H57b/fyPBXQq+0LNbn
         Fam3JLgcSirRScEyO3HUzIW3Au6t4lkTL2oEjFDrg7O+5Jz8oG8GlJlExUIr9ZVAA1za
         SLT/Mci7srhRsE11F1LybF1IU7qIgSTHybDKi4sdSEPpgU5oZ3hCtP+LqPew48H9ARgY
         AtwTWM5wA4sJ0KIjgp0U6O9//2cV1PC4kyRoD1QK4PuPrrgF7AX2Tei7iY93Xsf/6T/4
         0Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fu8AgEX5gUBRp361nW/mG2J0GbtM6cqKS93FYoescJw=;
        b=RxLvOn/K+iI2MKQ8qUv/y/bVBOmgs2ba3NG5xHG+ntfxu5gRsdWI7uNfouO4WKTQZV
         4vsJ8gx2jMFS/RwcpETPVq71eblypPrpEfsIthp+7Ncnj+As4Z+6zwOvIhrI86rmGWcg
         R6m2Vkr/6+2lZSmqBh3xw91ejExgWdz2nZr1tcxUbAHc0iRXTJoqjN0d55D5pNDW+9eS
         N8WD9SwOXEf49U7xDVgtJOaLL21c5DR+CbF20chHTaSR7wrQX4OaTL8mMCjb+iIUQWCd
         zcyBUgvBY+st6SF5dvkf9o9SzpHCDauJzYNiDgy/yAbAdA4hjInKs58/nFImFpAJju35
         Yh0A==
X-Gm-Message-State: APjAAAWJlmKkZiTixOJtpAUmtrYSMZjMDpnLrpDlw7chzv5C1tJ3ATK1
        dGjMNdqhM9TLDWia0wumeoftYtvvNr7R3RrlYwQ=
X-Google-Smtp-Source: APXvYqww81Of0MMz7b1G+A5v7IbE2mSWIMJwHX57SC7YHWv1Mn5BK5am07OVs7xM3VEkbR7A11z6XL8uQY2tTITvHrQ=
X-Received: by 2002:a2e:899a:: with SMTP id c26mr13235124lji.192.1553523044867;
 Mon, 25 Mar 2019 07:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553522676.git.agx@sigxcpu.org> <6a50cfdf0fd68aa120f7d8b67357ab45a2275355.1553522676.git.agx@sigxcpu.org>
In-Reply-To: <6a50cfdf0fd68aa120f7d8b67357ab45a2275355.1553522676.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 25 Mar 2019 11:10:47 -0300
Message-ID: <CAOMZO5BfhaR2BjBKvLwGk_=ULtGUx_x46jskX1WiAOY5vzxgbw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: Add Rocktech jh057n00900 panel bindings
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:06 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote=
:

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n0090=
0.txt
> @@ -0,0 +1,18 @@
> +Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "rocktech,jh057n00900"
> +- reg: DSI virtual channel of the peripheral
> +- reset-gpios: panel reset gpio
> +- backlight: phandle of the backlight device attached to the panel
> +
> +Example:
> +
> +       &mipi_dsi {
> +               panel {
> +                       compatible =3D "rocktech,jh057n00900";
> +                       reg =3D <0>;

Passing the reg property without its corresponding @0 would cause a
dtc warning when building with W=3D1.
