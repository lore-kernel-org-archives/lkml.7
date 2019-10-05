Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FDCC4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 15:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB419222CC
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 15:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RAfjfK9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfJEPDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 11:03:32 -0400
Received: from mout.web.de ([212.227.15.14]:58527 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfJEPDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 11:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570287780;
        bh=nyYdbbFOVLBA5h5OHeTnZ5r7BtCXWWl3ElrsogOlzbQ=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=RAfjfK9t44dJR/c5J4bUNNHHA26rArZPFJX6zJbr8WrVZCC10OY08rSAfEn2pRe1r
         /9JDHc3+ukRDBQtA1SfAXDBdGDaBkWj5KoAFEyQSAjsAmEhynca877yiOW1d0carTU
         /mGmmVtYpmttuWY+GZ90NNGvcozM8RMqBa/Clc4E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.178.111]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MD8VY-1iK1lo0u9k-00GdCf; Sat, 05
 Oct 2019 17:03:00 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20191004190938.15353-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] drm/imx: fix memory leak in imx_pd_bind
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        kernel@pengutronix.de
Message-ID: <027fde47-86b3-35c8-85e6-ea7c191e772c@web.de>
Date:   Sat, 5 Oct 2019 17:02:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191004190938.15353-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E1C7ZXn0sIkuGIHReU9/lVIcTt8hBkdC/Bp3sJ6tSh/0LrccdmX
 qJh3VHjQ04ml8iPbpXidujfenImPDZMGyw54HaqR+tZcWLGdpy20u/1KqQgLb4AX4VQU08O
 TCK4heuknQGbY+FUp9PP6m1+hQWg5yXIRKSe5m7LSdZegj7/Lc7lYeRnoTsxyBPFgbgY3EX
 34LLIjDb00xkaAdTfn75g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LFzJ8fXGnDk=:elS2SnD1Bvlba4od2uwKrA
 K3zsanE8KpP/p7AnoMZccjRdWYN9F/OeeTITObKjUDg2mg4tIQvB6/d80HrlGvGHrossyiG+g
 EbpAWw101HOLqQKDSVdZ8zrYbSBWl8tB/v/ksWtD9Ou0pwIpyRmFc9dWihoEVC8UQRGo24RYZ
 pApz3h/B9TEtlb5IFSt6XzI7G7eEzDcCM+ETf06oJlGUMoWHb9j+1rRyjFvg9CT3NXQMy2L68
 CjHE0knGu4RLzfywKavfK29HD+5MOU3OMY6Da7L3lYZxqhR/OqpahTJW9x11nKzrg4HAGBJ8A
 5feIJEsEzsuZnzWCVm/mtvgVMNCjI772JiiJX9gH5awSonjtKXWlIL1IDCXUydm4wq+ossqRU
 xuBFW3Be197ruE8o0PpyYLSQrj+HSJRru0OpELTz/WeQFOLBQ9CiWUkpSutXySRhLh5gc8HmR
 DN4ZWV0F+SBz0zid5YirEQBJRYFlteZ9NdzILc9LwvzEMu770iimdS5OsabNcc2c1/mhBsniw
 3mo0DgN7ax39n38hIm3NRh3D4FmEyS9QqS8rot/mGXXBFrXS0hpHw1JqiuhcR9OcVqmFiFo1b
 i8SjHqJ/bT/HsnMh3219kYzax2EbLJMwKGacvbFB7aqNVr8Jtd07wptHRMyoGP1VHGZFvbcKR
 4zY/WjtI+AAjFHXiR5PzlLSFQuGSXJZhFvgi2lA7nhEc1qksrKGDTTikuqsPWORUGZT2SV4Wu
 rvBRpojj79tk+P9Mqof9fop/H3RIkVUysKEKPbx/vPz5bdbPCof4HKQaMEr9Q9Wf7nlyBVMcz
 9SPHcvn13QIHpJqABIYHZoVXMvA7cWUOMYtEzad4ZCMg6Swyh3RZIlj861MS9n9TW4n5LNV5y
 8jkSb0+7jPyoUJWVTURUbfkODQjFeK9+pCkzlLPBo0eTzRgefN9iisbtGgvE2Z3Go1Cu9WLQ/
 Zawc8uPYKeaHgI2o4gan963xxDh47q8ejXpDKtLjkwIzQM55NvANoFvknfZwpC+Qflj263Hxa
 kH2Uv6FVgecWsPCVNYO1kKNisCytVbfeTDxCWAM/sP2WIbWA9gilJnnF1tuxKtaR1CLWzn9aB
 mL+4gVAwUP97e2SuwaPh43wm8yclzpfIWFyQUhCcRskWU7R0YSZ+2Xymk8n2/nH5pKIX0Dn2E
 f0n9PndR3jJVdlvF6gT8M9X2Kc0OnLRv0ntil6Z/oVqpmm5zylplUi4/Aw9ov7rgOyDYT/GDz
 CgMCEnamLAqycsgeaA7gGFWb6gwwvXMYeBQjCcqEknJSXM2DKWS94jaMsULY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In imx_pd_bind, the duplicated memory for imxpd->edid via kmemdup should
> be released in drm_of_find_panel_or_bridge or imx_pd_register fail.

Please improve this change description.


> +++ b/drivers/gpu/drm/imx/parallel-display.c
> @@ -227,14 +227,18 @@ static int imx_pd_bind(struct device *dev, struct =
device *master, void *data)
>
>  	/* port@1 is the output port */
>  	ret =3D drm_of_find_panel_or_bridge(np, 1, 0, &imxpd->panel, &imxpd->b=
ridge);
> -	if (ret && ret !=3D -ENODEV)
> +	if (ret && ret !=3D -ENODEV) {
> +		kfree(imxpd->edid);
>  		return ret;
> +	}
>
>  	imxpd->dev =3D dev;

Please use a jump target here instead of adding duplicate source code
for the completion of exception handling.

 	if (ret && ret !=3D -ENODEV)
-		return ret;
+		goto free_edid;

=E2=80=A6

+free_edid:
+ 	kfree(imxpd->edid);
+ 	return ret;


Regards,
Markus
