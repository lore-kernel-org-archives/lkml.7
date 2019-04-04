Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E0FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEA0206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LVSp3FDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbfDDUmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:42:51 -0400
Received: from mout.web.de ([212.227.17.12]:55093 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbfDDUmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554410555;
        bh=6HIwiYbANMV6jQjWrx5bJc0orI/6ermAa1nqrngjzu8=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=LVSp3FDO7YidRv7nKROd5H8JEJGQg8SCYxo/1pOXQIj3wN3UlwPPZTubPAXfh6TuU
         jLaGDjXt1ihGg+SrJiIPJ7M0XT8Zyjv6iX8sCM4IH+cqbcrSVx+xuRNiIpjk4NT2rK
         INYtpgFycyZ9nuPJpj6TdvhWbFbEalAqd4Av44uw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.54.132]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAvGa-1h2D1j2t9g-009yHM; Thu, 04
 Apr 2019 22:42:35 +0200
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1554307455-40361-5-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [PATCH 4/7] drm/omap: fix possible object reference leak
To:     Wen Yang <wen.yang99@zte.com.cn>, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b34cb17c-aa74-3b15-5469-f7a1ba417d36@web.de>
Date:   Thu, 4 Apr 2019 22:42:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554307455-40361-5-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:auQSF9DF0zLXJ3FokmdszWz8yKEXutUAQX4VCAxRxWzVILMYlqN
 ffZqHOjH6KvFa3lPWRlftNoaYBrYSm2bZIqsrLQhJiEZcgkEdP8NQw9m+ZDmJ1UULGNDADo
 M18ZY7J4rAvNBEniQt1HKjLl9DwTUcQhMqH1+LUvT87HcnAmwxqlZ2c5USqPQXAzM10G6Ol
 hKf3vtfIRBn8LhnT9Aguw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:unFx00kRW/k=:PwaRw0i2A/yMMgTJgMeENd
 8D2gKtv/vI3x9Nq0AqTc+mfZcBBgHEpiAJcVvD7jj632Rj82hkfQO6oomRmPrT3rjxaiEFCl/
 7C0sI6j6x9/duelijt9lFfVotBc3YbJnzDVrPPMaDEcK6D4YbHRvykrrsx13/ahiZ6w9pajOf
 Q8N5/sAks+veCrW02M3gvhK4EkPZvjSHXs6HRpIAmuwVnxkldld64k348ju1SuWNq792kHv7c
 geGL5F+e+SyGI0PVzEh1i155JBYFW6dIHJTHXWC7yP3FmEQ+aFMibk4t1jXaVi63VQ2IiKgxF
 4/atgsC+237y8vv67Z6INP+F8T6dKYsVeTMIJXz1G6oHuqshBE0t4GLZfL+6OMBj9h8o30Clv
 Wl7yORdiJlU6XHExr8pKoMAudcu+GfbHVdL47j2iBxhPm6rhpF1DgQZ9xBV4NCbnfC9w1fb9a
 CJX7r8+hc4C6Fpg0H5m9TSTlRhW8gsnsIxLCggGhbbXqxREZZJIRzmB91yhsOM/S4zc/9pib8
 RKcJCCDUPgBddcC+3tHjXAbehnHmg18GzCqGPP6wKa/eNYI377O64LJG+z9iO/U4z0nmsM0Q1
 73eHhx3Jxb/3hoDeFFpJZhQvR1mIwzMvS/F7PxsbfolPpAsIAauVOPapfbh6BrtMO9fJbCH2R
 qLGhO+LVFJNo9MGc/gLcRWSO7COkyCLzykH2WCHwp3NewU1kkur9zjX+GBOCbL6g9KeBDkTzt
 4O4AL/yHH4VsGF53TumkIwG70GXXqUW8kda7U31vUz408KYtmPNfbyXXAhkxncDmc5M8BJ9Jm
 AQpGyX1Cw3uftlhoTblzJX5GGM5cjGAlBVvHEpoaMsCzulIzeLiGud5I8CT3R9Z/RMLXGM0Qb
 G6hsWVxzFZ/4hCY8qV/8v+MyQbFN3C+Vo5rLsJ9igHomf0YJ4qKiVwf+XN8nJHLQ+CD2gialX
 9viOE/perGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -208,8 +208,10 @@  static int __init omapdss_boot_init(void)
>
>  	dss =3D of_find_matching_node(NULL, omapdss_of_match);
>
> -	if (dss =3D=3D NULL || !of_device_is_available(dss))
> +	if (dss =3D=3D NULL || !of_device_is_available(dss)) {
> +		of_node_put(dss);
>  		return 0;
> +	}

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c?id=3D61de49cb596710b918f7a8=
0839f0b6de2017bc32#n203

Can it be nicer to add a jump target here?

+	if (!dss || !of_device_is_available(dss))
-		return 0;
+		goto put_node;


>
>  	omapdss_walk_device(dss, true);
>
> @@ -234,6 +236,7 @@  static int __init omapdss_boot_init(void)
>  		kfree(n);
>  	}
>

+put_node:

> +	of_node_put(dss);
>  	return 0;
>  }


Regards,
Markus
