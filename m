Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C90C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 09:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E762196E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 09:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FnFKrp2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfJLJID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 05:08:03 -0400
Received: from mout.web.de ([212.227.15.4]:48609 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbfJLJIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 05:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570871265;
        bh=AjczjtWa014d2oNkGkskMjgMbvAv8DZY578FD5Vwzro=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=FnFKrp2/XWEM8dOlFdZfqLelmhS/Ef+L70H6f1OB4kqmaR5PVi1L9G8BZechN+eRX
         cSS5t7bU4wnzXA5C1JVm1yz/CkMQMUNQhQEH9E9tzszzbMsPK6GxaeqGOar2TfAT3x
         Ji1bQ8scK5pozNpQvRnhMHEyt+j3Awwp/Uk4ODFI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.155.250]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lv7eE-1htKSI3OEs-010OUV; Sat, 12
 Oct 2019 11:07:45 +0200
Subject: [PATCH 1/2] drm/imx: Fix error handling for a kmemdup() call in
 imx_pd_bind()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Peter Senna Tschudin <peter.senna@collabora.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20191004190938.15353-1-navid.emamdoost@gmail.com>
 <540321eb-7699-1d51-59d5-dde5ffcb8fc4@web.de>
 <CAEkB2ETtVwtmkpup65D3wqyLn=84ZHt0QRo0dJK5GsV=-L=qVw@mail.gmail.com>
 <2abf545b-023b-853a-95ef-ce99e1896a5d@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3fd6aa8b-2529-7ff5-3e19-05267101b2a4@web.de>
Date:   Sat, 12 Oct 2019 11:07:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2abf545b-023b-853a-95ef-ce99e1896a5d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W3Z0O1POMaaQIJ32IhrHrxFn2Y1KIKAiwjwlF8eRe4dGsAUf5tZ
 kPREuBKVCE1UElNcRmccWO6u+Pg6Cfl6+JDbCLzTlaSVqDnMsWMdpAN1Dx1xTLZzZZ9hkba
 PV0qOTC7vKI7tgwZI62Ee1Q3eoCmHzWNE+9ewrmFdwFjJvc3P8hv50eZDSxElt+0cZYgw6W
 wlQgsdfT1F7ofcdoJbtaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oumwdnv/zE0=:3Iy6j1/x5cfqhd5YgzsPAQ
 GRw8wn8MLKMc1n7oovMS7iBTuLZtCMtfCa2aBX7tg9JlzdnYNx0ivcTgc1KAXMyuTssbgUSM4
 PfKlGp44/oxedaw1MM1A2p1O+AE2X2NcC0uwEX/I+wlCNzGiMY/M/OVLWcjt5jtoVB1MmeafT
 jep7Fg3gL2XmJCq99/L6Z1qgB8lfvDENs1mMwkbS879wvP5ucJziIdk62X24XkKWbqgpBpuVQ
 Ks40KuQvvpqDdbfQny5cnn2A3YUVhrAD2JLcRN3HNnqlK0RymL7KCirIArMP9a4ncao0zxHqT
 rlszRfFSm5sLKhK7X7OsYyVVouxF+270kLP5vj86xWNwk4IibhlyoyOYupajdRD08D+sJuKHC
 ydot2lyO4/2ZxJXLBrsz8ZQae2CaQBfOl2bDpBE5/mjGv+RKiecDXQZAdqvjACS0FYhO1k55S
 LxO2Q4ngVytMseTBfOna96yu2Mzv7KGlq8t77HLEvT6vFAlR5PMVPhCnnxajJ0Q0pFnztBR3f
 x6ODMqXyvK9Yf2wwW8ms9Xr/iuIoud2+EFIc9O8vTSjZnXgPIvS1+FpkmWA/Van2llceb5lbj
 UnZctnhzR6AMAaey3ESkLVsF6uq9lnxAR0AO7QCOaJR6JNizUkjzLg47nfA1rZ6ilirsYaZIJ
 KKeRT6H8hXEslNq75JQenRgfpUKHhLtzW5xstrMNbeTOELnAeQ6e8dBoNNfZPoPpp0hyGwXWL
 rxIVVhcIDP6wF2a13ElHbNv+witeXpZNv55UDWnxnPzWeye4mciX2vXlBjh0sLk1F9jFm8r9S
 fdPQTJm+I1d8EsPTeL+9qsOrmjJ38KIkd1+YEYXgeHcgtsSL/ln+9IHznyGHzKSxv/Jgr+oKU
 ne1zrzM7TpmiQjWskR1u9avXMC5EFVHuZoLRVUl2xkgPP6QUzkVahRwpsCDoYKZqb44VBn2Qi
 GkCNnMbNBA2UQPOW6n3mZQY3LU1ywTbHKAK6RsHlsaAxmOd10MsdLFtBtr511zYfczb7XZWFN
 72z7R7aC7cxDlml8zEFHN2XSghx6Cl/uLUuMLR4sIAcle8y3ZMLP6QD8IO0bBn0ixjkUKgbD6
 hxRxgVKWbPmoVvlrwA3IiOGjDjdDQuGjx5+PbqnYKs0FIBuJpslUohOy92hhRCT3hZoTww4GS
 pVkHv5MLP5vCWLLDIywUNDYUOxw/xQ7Hej5MXqmTAGPRAr0RinNHDxCScvqlPAdEby9rNsjXD
 rIz+m/SRaMSBFaIbvmD9KaC+c16VddxGKfCaoyN/k6k2ir04a2qIsfjIfny0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 12 Oct 2019 10:30:21 +0200

The return value from a call of the function =E2=80=9Ckmemdup=E2=80=9D was=
 not checked
in this function implementation. Thus add the corresponding error handling=
.

Fixes: 19022aaae677dfa171a719e9d1ff04823ce65a65 ("staging: drm/imx: Add pa=
rallel display support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/imx/parallel-display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/=
parallel-display.c
index 35518e5de356..39c4798f56b6 100644
=2D-- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -210,8 +210,13 @@ static int imx_pd_bind(struct device *dev, struct dev=
ice *master, void *data)
 		return -ENOMEM;

 	edidp =3D of_get_property(np, "edid", &imxpd->edid_len);
-	if (edidp)
+	if (edidp) {
 		imxpd->edid =3D kmemdup(edidp, imxpd->edid_len, GFP_KERNEL);
+		if (!imxpd->edid) {
+			devm_kfree(dev, imxpd);
+			return -ENOMEM;
+		}
+	}

 	ret =3D of_property_read_string(np, "interface-pix-fmt", &fmt);
 	if (!ret) {
=2D-
2.23.0

