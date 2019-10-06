Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A89BC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0F02084B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pZNF06AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfJFJeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 05:34:06 -0400
Received: from mout.web.de ([212.227.17.12]:34567 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfJFJeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 05:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570354407;
        bh=NBS72s4G9mNZ3WzMI1DxdaMo0OErlqpG5qmV3BuMlZU=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=pZNF06AS/3DMU/K3SM8WQdRnpSQINzwQw1P/I20tfHdcpKf9vScrf4tFZn/y8Y8iD
         pP6nSUvqvEAOOuvw9DuAFbSLXvTbXtr/LCKUVlQwEHadC5T0fMk+EqQstg85j9JmjU
         npEA71wR1jQ7PCzpQ4rK2DUIdb/aOj2yI94IVOfU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.114.140]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MIvbh-1iEa4s2gYr-002VfF; Sun, 06
 Oct 2019 11:33:27 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20191004190938.15353-1-navid.emamdoost@gmail.com>
Subject: Re: drm/imx: Checking a kmemdup() call in imx_pd_bind()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Message-ID: <540321eb-7699-1d51-59d5-dde5ffcb8fc4@web.de>
Date:   Sun, 6 Oct 2019 11:33:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191004190938.15353-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9mEhHApvRLSLfrVaidVTASDIrRouu2LbdOnMIG6rWYMu+pdZgaW
 5LqTf5uN+peDd18uYxVPSaX1UbVhdoHy+aNcFMD7UZrSxUAUxm9V4k5RSP3Z7pL+utgAZi2
 kuBf7x5SZy/EWuRyYAmjXAb+7hMyfuBPd4/FdT+aOmA3LmjLCkmMftGwGedLMgAXEbQQaYk
 fFbvqe2eSc2BO0/zn0CEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+9qyh83oa28=:N9o4qbfKfvNblikgOLzyCp
 0Se1VG1t4md6rQ6Nl625v5sh814b5FaDF23ulz77km7/bFAUf0NIbOt/MMjXNLoCnS9WtPM7E
 dR9/+ei+o8SQlLkjPESQDY4mEY4SaqnD/eMZNTQz26Vtytsw2lFAyZb448W2O3zAEB5b5GuYx
 rPl6fMWiNLKs2alIqajdE9ZlnyDVC6xFSOcDjw0JzE3clgyKHOxfycDMoVtnAiN5aRMB/aWti
 ASCzWO660viQUg/0hAOGl0Iq3IzkKtZ9LPX+oRVXFG5nJWzFkr4ek7P/SobEQPGpB3kYUcYDm
 Pa3wYIWejcdaUO+yC0lq539DYUsXZ8z5Zw8GM5FSMA8564B7cRG4zsOvUQ72YcR6icQN+DNpF
 axHeD0H7U1dm5CixzDve8rH2I2NB3vFoZ4maN5kRUG1rt2LIclxGlDL5ckJOGcWC6BSf5U5yd
 SorcFi+PSf3rUey2bwMVgvoxc6Ot2QuosO8R3btSQ5OnUUSRxIPK2Z/OLV0j1aXjdPejTHUyn
 iWJIQ1LTsUoGmhLGOJdGWMvmW/Q7OYf47Gwj8smplyR17eTVxTf9iGXSdWqO55ATIFiN8Ww4d
 hMtuNtvSRusAHDXp63XVLVyFcLusYotQRob5YYbBVZZTikpLP2v4VfeqaCsdYJlh/zf3bqZko
 wct5X0DLbe+FYNu+nq8zb13YV42hp9ff0D+3v5HZskLk/WgVR17pcalY7Ow5WLfDbUAPXapPm
 /DQsXDnmh4Iz1swa67N025RZshvAM5fB3rVezNib6P9DfHr8+Gnxm9maBw9CRYhdp68+zcs6v
 tzAckWV6Cdioh2+X6fw1qYIaJWocL6l0xFeaQQhuAwxmZCO21WKEqD+HIpKPghAZ19r2If0Az
 DLdVa1imc45TWCyOwqMHNdKSyQxh8UF4ggNucPYiMjY43bHmRJTQDVxOnPj640PlsTPvrZhFW
 3+lMpMK8+UYla4obNNeZrSM+bLDjon9Zq0zdg/bK8uFfp3oQD7Mu3vclxehQkCbiVEydG80J8
 7Z+mbTxA4d02G3+jrxjiW2wb0/iE4yIf/bcUtPr+Vj5JxtMtlVG3Cb6XH5JaHgpU0LPZm0vYN
 n75vjfvjZAvCzpkUTyoHaASaB2R32EKCR1PTXnVZ3a3kN/ZLTbWL52Jx6ZG21+75o9oGtELFj
 0hS+IINjRiVqgjJXfbBl7FPNht4PSwXSreo39fwqJk5Hx0kWbp019EyRhBiXz/0sjrJkOggc9
 rm4Vk56pbilr2X+W9OLw/qmqOmmGso2XTsEIwhBjFYQ8J+C3pRagmoTmE6zI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have taken another look also at the implementation of the function =E2=
=80=9Cimx_pd_bind=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/gpu/drm/imx/parallel-display.c?id=3D43b815c6a8e7dbccb5b8bd9c4b099c24=
bc22d135#n197
https://elixir.bootlin.com/linux/v5.4-rc1/source/drivers/gpu/drm/imx/paral=
lel-display.c#L197

Now I find an unchecked call of the function =E2=80=9Ckmemdup=E2=80=9D sus=
picious.
Will this detail trigger further software development considerations?

Regards,
Markus
