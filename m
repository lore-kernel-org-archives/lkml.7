Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811C5C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 11:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4738320673
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 11:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="h8bf4dNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfJLL4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 07:56:35 -0400
Received: from mout.web.de ([212.227.15.4]:48803 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbfJLLye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 07:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570881248;
        bh=6rBqNUzM2LQ+qbqvfiyKiKBgp0+NLYt6FtzenMzPpa8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=h8bf4dNVi3gjlLu11LtS6sL3jk55vmHJhYJ2IiY/s0dHiVBEsvf13bOjLzlemOr9r
         GIMEthqa6YhoMqdCxuHwWMwzoyb2k7Ek+I1lC+fHeaGxC2/At2646O7VlRvGRWlIK3
         Y0b8HdVu7zg/zloB4a+PgoQh69+sQ5RlrFWM8s6c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.155.250]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbOuI-1hdpH821e6-00kw0W; Sat, 12
 Oct 2019 13:54:08 +0200
Subject: Re: [PATCH] drm/imx: fix memory leak in imx_pd_bind
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        kernel@pengutronix.de
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
 <027fde47-86b3-35c8-85e6-ea7c191e772c@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f90d7b4a-c4af-eac1-f326-211e932dbd22@web.de>
Date:   Sat, 12 Oct 2019 13:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <027fde47-86b3-35c8-85e6-ea7c191e772c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dqGMq/vAHm39/dR4lleWUi6qJbQkT3h9gxOrm2XzgVDFani0qBx
 yN9tjx7pCa+DfNgBoYnj+SodZw/09onwCsKFORsAqZNxS6xpbaEIKysPidx3yO4Sa75Z5iY
 +qdB/XVUw5Yvqr1Ihp+pg+a+xCcMz50ttLtLsirHGpgLOuv8Awvh3rSQGM4zQHtv+A7nMSQ
 WJUU5yG6m2WB/1QCt1l3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TfxbhXI6wCc=:518nXADVY26Wq5v0YxTKk2
 DP5usAbuHA8IiDuPs18sK8pD2xEFOLByqy3L6WrbsklerDrWcJEjDBUBRYFGpJ2/1Ay+rGcmP
 Pc4UMYKl4bXJXpoA3yVdbhT1C+d638w+KHF+akbsntLesXw/eOysRnPyWBnqh5qfJ21m7JW/B
 CslJn1vQbO7yyTNWD7ycZefbocH4ckYRGt61xUIBwsNLASS1byvAEAjGcEtULdjn0vrNvjlFr
 WSAnZOT0+Lc3B4DIqjIQy6tT7yWOX1e/7aEoUZXrabSjnzX7hjuzVT/o/VanC/MaZnAQlmdfB
 d4CJhEOgz5gdmtJyUF+dDsIyv2HlVYPeBaLwCm1+CIyPwaNHPP1kbyuDnw2Dad54AAf5lLJMI
 hXQNkHbHmjx1uWx9Doy3lj8SbgjiJXAVnZVpZKsYrS5QG9KyrHlr9sYzAe6tghIYfrFWkMTFV
 usBCqIG6DxW2XmyyUAKw5xIDhPkDVkiYScNMCUsAHAzg8doKiG2Z6f6MFpSwSkhiBnYGuS1jl
 NbeDg2oept4aKKkoubXu5c4kmSUYqNu/4j/RTD7dnhPfYNQdIKqbsptApP2O2H9hDA/U9uar/
 D0iiTNSs2InEgQtaoG7en6ImfqFobQvhvT3ME+MzwtnInmh4VTVYIxmgDUq3MRyTW/Zijs0pP
 EzxwWsdwvXP0iaZZe2kA1bZCdixqPbvIsDl9JLuXcHq20/AfTvoaSsa4m4nB9exPDVArC//zb
 uU6pbHNWigo3v5eOtU21jOvSu0dby3vTG5nDIG1HrWdPMNIY5wwiJyFCEhIOO9ct6CBGYAFnn
 Z8uEDHBx8iTEBKeFHjvosmKtXc1xoSjFzpi8JHvUnd8HfhB6G75lS1aL6Y6GXsWnj2AQe3P5v
 YQBurvRrXu/HSm1W7LXsDaC0dRtsCTbLl0u2hB02UhXCgRa2RhfdcdLNmnk9XHLReo5o+mFMt
 ujzSInF5QlGt7H3U2XF3Muw7Uc8d1IbFd+G36Cz8lizi8WRscIBT3jAhcUa69zxIYFBAN+DnK
 Jf+yvSyVsWTak6VpEsM/c1W9J6sN2HDVwAxZq+l9vGJmAy2TOucB9VX1Hwb8K/qclyILsMTZm
 gGnu+ngYI//4Bu5ZBn7j9m/okvbSB3VDf1mIcPthwtGMxY6p9bnSbsKqIo1tHMy8Ck7lg/MHM
 /C3QdmrVaLU3+pi2Ey/bmeaRJoyMC43mR4LwoeU3kPzFkg5xGD9p8h8KyVYADWg48QyufaF9a
 AgPOUw6moZnyuxHlsJ6i4gGbvitpZNX3Nsg+sXgX/sy1Ks+H+7hjHICAI0yg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +free_edid:
> + 	kfree(imxpd->edid);
> + 	return ret;

I have taken another look at this change idea.
Can the function call =E2=80=9Cdevm_kfree(dev, imxpd)=E2=80=9D become rele=
vant
also at this place?

Would you like to combine it with the update suggestion
=E2=80=9CFix error handling for a kmemdup() call in imx_pd_bind()=E2=80=9D=
?
https://lore.kernel.org/r/3fd6aa8b-2529-7ff5-3e19-05267101b2a4@web.de/
https://lore.kernel.org/patchwork/patch/1138912/
https://lkml.org/lkml/2019/10/12/87

Regards,
Markus
