Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2F9C31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CAF2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJtImIi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfFSITC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:19:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36738 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfFSITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:19:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so2331175wrs.3;
        Wed, 19 Jun 2019 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BS73/3tZp1ehKlLKXUYpGVFZT5e0vtyoTb//KYOGHmU=;
        b=nJtImIi+G4PbEgndIPpxBqfGRwuN/ZgeII2mobNMZlEYKCUXmpT6M0TVzN5qp4MQH1
         jOg3q1ngSjAhLGyAfABSt0Rbfkcx6PkpxhxxmTGbC3YQRkO/aZDt98tqCvBPll+i6R4U
         ceNkXe2uxBMSnYZzPnwEVuFe020Uqy2lrBV4UB1mn2ZL76E+K+K7s8hjs21kDnhHpzCr
         7yrFO0Wh1azm0SOCt8Zittelag9Txtt5npoOcr2l1RbMvQu67OeJsCkzb2aOzhbqoyiT
         lkM+sOVzSAC/gX/Etes+DYM/Ksjs7qj/upB/fyQvQ+GXjVbDMATjsu4vE/vU8CCFnMZZ
         2IdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BS73/3tZp1ehKlLKXUYpGVFZT5e0vtyoTb//KYOGHmU=;
        b=rzSquJ7ZZgo26L8jby9I4ijxV2TFaAjlUaBf8zAEfT8k+CUtTb5WiORTs8s/Og8In0
         xZjmCpCpZbnXBtEh3WOHAXycKqhC8s+7IqoiSEIwMAZ9rGVCykRZyVqI5J9zqix77Wa2
         KUPSpGD0WPzvtiPWrTaoxFXUxFz6kh50rIKkYtz6VeNasdyEZidLPKvflE7EWR2ZQfBO
         GBqeirtdW5BMGWi5ZKqMrvI0nLRwWALE0DHeRfBDwN8FClAcw8AoUN5CuauptA/AMkmt
         Q6+gBAL5+G742WgKn+8LKSpzd9N8xmngxbkf4RRBAYHMplheW1jB1bIoh1hC4pzIyYeq
         zRTg==
X-Gm-Message-State: APjAAAW1jUCg3eyjNlMyrQSwMHybN78vJ/QtxkWzyarhw1GmNZVpB+8H
        QbxDnZRI/7vj4/JLsroW93Y=
X-Google-Smtp-Source: APXvYqy3BoizrnBBr3/d+4egHRQv3imcrH6+AlWUlT8GWXq4yj9kqs6+vuEuL+wd9gBjfBMRSfTaAg==
X-Received: by 2002:a5d:6212:: with SMTP id y18mr3050109wru.178.1560932338686;
        Wed, 19 Jun 2019 01:18:58 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id k82sm1195447wma.15.2019.06.19.01.18.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 01:18:57 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:18:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] clocksource/drivers/tegra: Restore base address
 before cleanup
Message-ID: <20190619081857.GG3187@ulmo>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
Content-Disposition: inline
In-Reply-To: <20190618140358.13148-7-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 05:03:56PM +0300, Dmitry Osipenko wrote:
> We're adjusting the timer's base for each per-CPU timer to point to the
> actual start of the timer since device-tree defines a compound registers
> range that includes all of the timers. In this case the original base
> need to be restore before calling iounmap to unmap the proper address.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0J7/AACgkQ3SOs138+
s6G//w/+LuaiOSjzCI5doh93svlKmXL2y/HbIfj0eUbei7qZ6r2GfkksqnlvkqFB
il0eCJ01RrN0PveODIw/KOYDqQ8++WRCVuneUAOrt9Eh/hrozKuL5gKweyAZ/xy/
zy48TL9ano+8YYtsgq7+7oZ/edC9vLIG/k0JZl9/3NR6+VoTtFFH74TQ8nBgR+r8
umrlMpQhf+7FkzDW07IphsllABb+NdoImqAAudiIl3XQKR7xVQb72i0o5grffUM8
cWnNHGAmDH8IKC+m/cNuUoACuXa+ZQxh+AvXYKiN5rB8UFKm5MccWIdlQHRDlH8E
00sl6mNfMwvNqPL/8oOj7LaLAt76Ypz0jJ3DchpzA6Dno/yT52cdBJhC5lqp1TY9
tCv+vkA24Jqf1LhPdsUzDD0/X/174kDU0xK1KPRHjHfgqgSVWBg3QLnyacaGv73l
WkYL63Sg2OXiPy1VBrq47u8ZmXVJrFL3wFIYMvhIp4X14P9m3fn9sPqKNfVNwf69
I1XX7DQSmxCYCZJnKmCn0A+HwygLVdrXkaUiJfAX5Ge7ICgDr8WsSQF8Q03OzrnH
3lWYmAvnXYd0VpkiA1/RVak7S5OdK0WKlAljNB8we6DwtfPBrJLs7GnOiMc5k2DK
0JeP49BssprFT4Dh1usnOEdBv+GHJMBlR+azMIaorXWS9IFPugs=
=DBtq
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--
