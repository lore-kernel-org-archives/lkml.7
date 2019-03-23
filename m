Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1EFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89493218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="a5THVsVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfCWD6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:58:38 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:57074 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCWD6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:58:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4660BDA1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 03:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XwZpZSf-y0og for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 22:58:32 -0500 (CDT)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id EFAA1D51
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:58:31 -0500 (CDT)
Received: by mail-pg1-f199.google.com with SMTP id e5so3894106pgc.16
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zXT+0308zpZbEiIlMgifBqJCQW5n1zpSM6kZWm2ebAU=;
        b=a5THVsVqsmRc5ql+tnpjwOACF3GDFOi4lEu3Yxh86wfi5fis3DTCI6aCm4ciz3S2yz
         ToYOtFZPemU44pzLYjXO5Y8F4EaAKkEMJLvD1ePP9ifP/QdhBiDSsm+Ow/mRXJXHGKjF
         LrPySWQWYksqLpB4jfQN+SolzQ0SeWnEkEZ6CGu29DB1gmk44V3wm7Sa80f3HtCguzgq
         63Gy93B8SclVimoTyDUXhusdkfDaJAhL95RtRsr0BtZDaZRmR/SOz9ivXb/G7KSX8Bf8
         OhCdHbhuQH4wC96ccIVMpO8znklZ4ODkUZu++vf4huD4bfuRvQ9m6KbZc9PzmWrvbH9E
         lBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zXT+0308zpZbEiIlMgifBqJCQW5n1zpSM6kZWm2ebAU=;
        b=t7hb4V7l7HurnBZkO5QDFQiQoxlfYg8l2iqKkx9orVmOH8t3jlBf6f0mzlCYpGeHF3
         Kt3OTFlxtuFmliCy58deRgNd6vPqMr8bxm9p8XgqxuyoS188rqKjPNXDuiJu3N75ol46
         Xv9tJxI81heZJEVLJePuGDIUxMmu9uBsExrzeJtupu9KPO9yXcCYLe1UF0k3bPupVZcT
         MVoiLmxUqJzTQ9KMC9CwLscNyzPogwaX8uFL34eXbAY1XULcLV1zPir8+Jg6vnMb+cLG
         q0FXQ8Qi/q6F54JvpPOlpnPcVme7pVG7PPS/uCsR0cyPBLtpkHTLVLb3jFrw9l9KVeiJ
         7GXA==
X-Gm-Message-State: APjAAAV1CrnMHoAkSPCueGg3XMgj73L/+2O7bVStyHMUBqx7U5/ecgmH
        RfYyMbb/kbQjG3aklsSnvhcQFuElIZuRPLVEqUFxT+I9zr5TlSgHDwQ0W9a2SAdkkz1CSJAdz9W
        4bPEQNpHP7qX/0WMZgkF+ke2yPDfk
X-Received: by 2002:a63:d302:: with SMTP id b2mr12410867pgg.13.1553313511334;
        Fri, 22 Mar 2019 20:58:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwBsbjHR6stebXNwPiS1SShBEIwSyJvsuS+NSTaeth8keyu1SaKpK3I0QGthhRpY9Q9ac76VQ==
X-Received: by 2002:a63:d302:: with SMTP id b2mr12410854pgg.13.1553313511125;
        Fri, 22 Mar 2019 20:58:31 -0700 (PDT)
Received: from [10.184.4.71] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id m2sm9224060pgr.74.2019.03.22.20.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:58:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] net: wireless: fix missing checks for ioremap
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190311075440.1513-1-kjlu@umn.edu>
Date:   Fri, 22 Mar 2019 22:58:30 -0500
Cc:     pakki001@umn.edu, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <14BE624B-1425-453B-B876-F8524FDA8548@umn.edu>
References: <20190311075440.1513-1-kjlu@umn.edu>
To:     kjlu@umn.edu
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Can someone review the patch?

Thanks.

> On Mar 11, 2019, at 2:54 AM, Kangjie Lu <kjlu@umn.edu> wrote:
>=20
> ioremap could fail and returns NULL. The fix actively checks
> its return value and handles potential failures.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/net/wireless/ray_cs.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/wireless/ray_cs.c =
b/drivers/net/wireless/ray_cs.c
> index 44a943d18b84..cecd18a2f2de 100644
> --- a/drivers/net/wireless/ray_cs.c
> +++ b/drivers/net/wireless/ray_cs.c
> @@ -394,6 +394,10 @@ static int ray_config(struct pcmcia_device *link)
> 		goto failed;
> 	local->sram =3D ioremap(link->resource[2]->start,
> 			resource_size(link->resource[2]));
> +	if (!local->sram) {
> +		ret =3D -ENOMEM;
> +		goto failed;
> +	}
>=20
> /*** Set up 16k window for shared memory (receive buffer) =
***************/
> 	link->resource[3]->flags |=3D
> @@ -408,6 +412,10 @@ static int ray_config(struct pcmcia_device *link)
> 		goto failed;
> 	local->rmem =3D ioremap(link->resource[3]->start,
> 			resource_size(link->resource[3]));
> +	if (!local->rmem) {
> +		ret =3D -ENOMEM;
> +		goto failed;
> +	}
>=20
> /*** Set up window for attribute memory =
***********************************/
> 	link->resource[4]->flags |=3D
> @@ -422,6 +430,10 @@ static int ray_config(struct pcmcia_device *link)
> 		goto failed;
> 	local->amem =3D ioremap(link->resource[4]->start,
> 			resource_size(link->resource[4]));
> +	if (!local->amem) {
> +		ret =3D -ENOMEM;
> +		goto failed;
> +	}
>=20
> 	dev_dbg(&link->dev, "ray_config sram=3D%p\n", local->sram);
> 	dev_dbg(&link->dev, "ray_config rmem=3D%p\n", local->rmem);
> --=20
> 2.17.1
>=20

