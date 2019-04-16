Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FC2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86297206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Ah93HE3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfDPQLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:11:41 -0400
Received: from mout.web.de ([212.227.17.11]:32913 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbfDPQLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1555430960;
        bh=0JYnvf64ENF937ejRJiimDrz7qQKiPdYGHBDEYD0nE0=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=Ah93HE3/X4A67jFQWkyPwbBsgqiTEWkbnlFSCRXGe2fIJTvnNLkeH/3WuPkC9B43Y
         G99Mg0j7TlLvc3QCG1Rk6ZICQlpJTMdWT3dNVd5v6m4CFSXAmLjLiGrKNog8rwpoi2
         R7e472ghEXjsxFQ+V7F9mGYi+mhV09MFCYOAvxlM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.159.183]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M25FH-1h15ch0NYp-00u5uO; Tue, 16
 Apr 2019 18:09:20 +0200
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Russell King <linux@armlinux.org.uk>, linux@armlinux.org.uk
Cc:     Fabio Estevam <festevam@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <1555139666-948-11-git-send-email-hofrat@osadl.org>
Subject: Re: [2/3] ARM: hisi: check of_iomap and fix missing of_node_put
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7d17a344-770d-c9a9-8d2b-d7907997ef49@web.de>
Date:   Tue, 16 Apr 2019 18:09:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555139666-948-11-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zy9zujMe0XOd3KHJ9A0ROO+WHXHHuBHPKSK8a+LbWLiIa9DfDiX
 m6YIdZY1Pd/UM6l6DJyVQe1FR8MTRDtXK9oKuwS3AOkFcDSHtxUxtMmnfPHemR8lw1mqTPw
 HsFGi9xzdoIX9oRnRLZYcFo+0vvoj9xs6wkuP6uinL+pOoxDkPq/2y0AWChZ6k8YWOvrNTx
 38NDAeL7kZ4m9YM0H9HkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1wOjl2UPsdk=:fvbkWBVRXzyiBTAxoK4NAQ
 PCWSySmRkDTyI7nB8JRWIT3xfUTh2T3ScDJaPEjb1qhN21WGPc9Po/Wvyt0buWrmkv6oYtus5
 gvUwv8wqrEZxcN3fA0GUXCyYXwabx4rGzDk7VeNiikiTVYccBpCrcAkHq0kWI1gEpoCYtZ459
 vY5+vA/8jIWs1AuBOesMpHp8XkP2D3eQVH6VWh1sMWmvx8YNX+GDYfUbYe0lS/bf3deeuadTT
 HWzUcRtVEJUlLFpFfqSya1+vHb67E8XeH9UgECDwBeNmkdimC3HGfQTcqy9a0mYa7cCkHltij
 M8PTxnHa2qAgaPZyqKzcDmOwH3NxXexa54xJ88LSXPN0/Kd0MzwEdk3Om0ZmL0aURNpqnN7UQ
 qVIHfD+uxaQ/CgcWdGmNdya8CyhXi+ubZB3Qx7a1TXgYcsga96KdiyLzsCTYvOa7XjycDiUFC
 ivr+3XgcgG5csoD2cAB4ktOjDX6PWUqueib+JpkqY39JB/cDoqYCHnHOdn7oPp48CtxopQWCn
 89pIui+eePskWhkM1B7Jswm6JYmTHsJkbJNvcDuFKetVZJPpQVnXN0TD4qwdjR8JgZ71IgX4y
 gVD8qTYlFSKBp3MLeXPBXw9vUXzhD4p6Z9NFnK1TKwZwfWZaqpZM+3nGDd/v7I/Pa6ADNiTcB
 GS2UXT5KS9XCt48ptUhj2MhuRSAuIfXwQch0BZ89ZetoEkTDmCty4SdEI6URHwgZvYyffvIF5
 5RecKfeAL975MsllmlhXQb0FC3aUofeZtDe6huIP2Ov3iHAcnbyJejumRccN0R8epjUPxGHF1
 RalYjxIjHaeYd/YIjkYBcvLaNB/SOGd6+pKYzkfFuxzjbPAVImaEZM4uGcEUj0Ol0XdOA/TzE
 kafTCB0DnZ0bOzZeCRDfYtqVSck1px+CKY/91l0jV8Fd8FqYyOZ4qbpBk8upqoW67CBzy8gSh
 WNrjTTeQStQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/arch/arm/mach-hisi/hotplug.c
> @@ -173,11 +173,15 @@  static bool hix5hd2_hotplug_init(void)
=E2=80=A6
> +	ctrl_base =3D of_iomap(np, 0);
> +	of_node_put(np);
> +	if (!ctrl_base)
> +		return false;
> +
> +	return true;
>  }
>
>  void hix5hd2_set_cpu(int cpu, bool enable)

Would the use of a ternary operator be more succinct here?

+	return ctrl_base ? true : false;

Regards,
Markus
