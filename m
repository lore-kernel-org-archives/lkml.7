Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68248C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FA220693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAtJ12dy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfC1QcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:32:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37453 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfC1QcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:32:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so23716803wrm.4;
        Thu, 28 Mar 2019 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PovC3EuLhFga0BC5lv/9r5AZfIsaQTiIHB/zyRgwpD4=;
        b=YAtJ12dy79W4EyseaTuaijmRj7FxvJzZr0ERNefbEC5k+c6FXlm/WOR+sfUQvgfsoy
         fFZxP2w7YlQX9Fv9IduMi9Lme13uWf6EEo2TLs0PIqgTcMj0K/vTZy1bvuPl/Fgkn9ro
         uB4/igdjr8CcaL/fTc7QMpokwsfwTwm3S1b9O3GOYMxfGb5vBKZH6KxZ72PN+LnixO0t
         w5pdruGK0M8pzTEVHeosiUvJJ2nbhiHjJ4YyUE6iImgmg1rWOwIybDkHTUi1Ffor4NSd
         i9hk9wZyuTc9tgmh1tqIqbFzxpzM6tjYe6F2LnE2s8z1HwO0wUZ3QAsebLqkICRqtMaN
         ltyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PovC3EuLhFga0BC5lv/9r5AZfIsaQTiIHB/zyRgwpD4=;
        b=QTi08oRt8qDXwJGZttt+dMfCV4wJad/UrHj/+zPvQIk3ZOIK/1OvJJH+Hg2idhyq8B
         +gQ2TK6cwx/Kuwt+KZf/hCVDYIEs4UhfgBHQCklwnoMS5tGqmaVsAvQCj68d/hOzdd07
         77w+nWu2bWkZjrlc/47lKm1O+VmMqQ5uwJgxZDGEtjsoXIiPjBZEl31wfEBo5wALWWCr
         5E1wzGGBS1MZTlvMWoSs9c9NO0bu0+5DscyVwtme/O5RlkuiaF0t5HXk658fzZFusOhr
         ZvJ3NuC2A/KJkoUM96XZiN7lNHcu5zLb9En1SSKVzinRH8HFM92smvJsv4px8LH/LvsC
         gPKA==
X-Gm-Message-State: APjAAAUpduGZr7JZpsh/KxCsRsJp9AOsDNMzwD3ODZS02HQU7uy10ull
        Z2RWFnxcwvOT+DLJVw28Kvs=
X-Google-Smtp-Source: APXvYqxmP3mW/xlO0iSLBP5o0YzOH2QVpNgr980+TCqoyvv7fzVGZO8n9QfRWbQ5sIUYO92GizGCQg==
X-Received: by 2002:a5d:63c4:: with SMTP id c4mr27055846wrw.307.1553790737481;
        Thu, 28 Mar 2019 09:32:17 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id 7sm85610282wrc.81.2019.03.28.09.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:32:16 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:32:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, treding@nvidia.com,
        jonathanh@nvidia.com, josephl@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: dts: enable aconnect, adma and agic
Message-ID: <20190328163215.GA31367@ulmo>
References: <1552400705-1179-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <1552400705-1179-1-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 07:55:04PM +0530, Sameer Pujar wrote:
> Enable aconnect, adma and agic for Tegra Jetson TX1.
>=20
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied to for-5.2/arm64/dt, thanks.

Thierry

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyc9w0ACgkQ3SOs138+
s6GPkRAAsHTq0EGmjGMqcTVmJfdXUIIJeDv6vk1RBhXVgg9si8SlLtTm7JDM55DR
XASpL4NBzMPwZ6iKAmfWcaCbA9CXlNaIjjKyHZVVdy5g4wjXtphsKPgtXXMT5QTl
Z10XZvN8/QsSsV6l4Br4ZBmJCy0Hqti7IvymNN5CU3uBnf6Nk+OE+4vb0+eKR4SU
6GOZ1Cf4WgnZzLWMceQhSALvpGewgeHKNQIgAAKuJj7bncsl5XcYxijO5fMwun5w
1P0hcWbcXk5KBuGrIN6z1nFZPq5w04MMMGDTsk23DGxF2G5a2VBPGbH8ja/NrfU8
6DOF93JFwFY8M+pMbdvbgfbDMQLQCg49ctU4IT68smDjXpt30sgg0Ru3W7Bxark7
2lcHF+Iohib5MFxLs+xbSQ+SEFMpRXX/iaJ55Pr+ObL0yBGWDTsgQdzDJf6BXRKd
RIngYTLsdge+NOYyz8c2QZaWppbFz/VUWGHFauTzMeEu3o4YG4VFyg2u9PFiHWK9
XNS4pe8HOa2dB5dKs2XoRk3kp4EosMfJf+e/7RFupoDiZUvleiUAx0uSoYl3sLPU
51sFKfaOV7y+vpsG2yE/hXlHxKfQkhrBuqop/3FWb0iKlnGXUS4R+uYcRjOyd0E6
UKThMNtY1nyM9YcQtqSkOY7Igg8oRrGJoLcdtIlKud8Wwvp8YzY=
=vQrx
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
