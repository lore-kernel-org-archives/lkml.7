Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D96C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3489207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="pT2UXCEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfLPKqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:46:16 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:36816 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:46:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id BF31D27E038D;
        Mon, 16 Dec 2019 11:46:13 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dL9Pma99PY6C; Mon, 16 Dec 2019 11:46:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 2643327E0650;
        Mon, 16 Dec 2019 11:46:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 2643327E0650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1576493173;
        bh=Q3J3IGqUHa44cwERxlcia+XQrwcBXBAjLyRwd25v6zc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pT2UXCEyjDQxsTkin3laAuvBsQyHND9Gfas+cElTO7ssTizN/EkZrv6VMlF2kL3ZR
         s/xVZXjP2UAdijixv0utsaSxxj4CdrLqrfkch9XgvqLxWxZYRziSAcjEwERXbnNZkX
         b1/Cj/AS9UPWkiScCZgWahq81mKrErpyqph4px6Q=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CyTpA5Zjb0LS; Mon, 16 Dec 2019 11:46:13 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 0ABF727E038D;
        Mon, 16 Dec 2019 11:46:13 +0100 (CET)
Date:   Mon, 16 Dec 2019 11:46:12 +0100 (CET)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od <od@zcrc.me>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <340758118.96812669.1576493172804.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20191210164014.50739-2-paul@crapouillou.net>
References: <20191210164014.50739-1-paul@crapouillou.net> <20191210164014.50739-2-paul@crapouillou.net>
Subject: Re: [PATCH v4 2/5] remoteproc: Add device-managed variants of
 rproc_alloc/rproc_add
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - GC75 (Linux)/8.8.12_GA_3794)
Thread-Topic: remoteproc: Add device-managed variants of rproc_alloc/rproc_add
Thread-Index: A1lvR1ZnQGMreymAk0HLkaguiV5GCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I tested it on our driver and freeing/remove are called correctly on probe =
error and on module removal.

Tested-By: Clement Leger <cleger@kalray.eu>

Regards,

Cl=C3=A9ment

----- On 10 Dec, 2019, at 17:40, Paul Cercueil paul@crapouillou.net wrote:

> Add API functions devm_rproc_alloc() and devm_rproc_add(), which behave
> like rproc_alloc() and rproc_add() respectively, but register their
> respective cleanup function to be called on driver detach.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>    v3: New patch
>    v4: No change
>=20
> drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++++++++++
> include/linux/remoteproc.h           |  5 +++
> 2 files changed, 72 insertions(+)
>=20
> diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> index 307df98347ba..0a9fc7fdd1c3 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1932,6 +1932,33 @@ int rproc_add(struct rproc *rproc)
> }
> EXPORT_SYMBOL(rproc_add);
>=20
> +static void devm_rproc_remove(void *rproc)
> +{
> +=09rproc_del(rproc);
> +}
> +
> +/**
> + * devm_rproc_add() - resource managed rproc_add()
> + * @dev: the underlying device
> + * @rproc: the remote processor handle to register
> + *
> + * This function performs like rproc_add() but the registered rproc devi=
ce will
> + * automatically be removed on driver detach.
> + *
> + * Returns 0 on success and an appropriate error code otherwise.
> + */
> +int devm_rproc_add(struct device *dev, struct rproc *rproc)
> +{
> +=09int err;
> +
> +=09err =3D rproc_add(rproc);
> +=09if (err)
> +=09=09return err;
> +
> +=09return devm_add_action_or_reset(dev, devm_rproc_remove, rproc);
> +}
> +EXPORT_SYMBOL(devm_rproc_add);
> +
> /**
>  * rproc_type_release() - release a remote processor instance
>  * @dev: the rproc's device
> @@ -2149,6 +2176,46 @@ int rproc_del(struct rproc *rproc)
> }
> EXPORT_SYMBOL(rproc_del);
>=20
> +static void devm_rproc_free(struct device *dev, void *res)
> +{
> +=09rproc_free(*(struct rproc **)res);
> +}
> +
> +/**
> + * devm_rproc_alloc() - resource managed rproc_alloc()
> + * @dev: the underlying device
> + * @name: name of this remote processor
> + * @ops: platform-specific handlers (mainly start/stop)
> + * @firmware: name of firmware file to load, can be NULL
> + * @len: length of private data needed by the rproc driver (in bytes)
> + *
> + * This function performs like rproc_alloc() but the acuired rproc devic=
e will
> + * automatically be released on driver detach.
> + *
> + * On success the new rproc is returned, and on failure, NULL.
> + */
> +struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
> +=09=09=09       const struct rproc_ops *ops,
> +=09=09=09       const char *firmware, int len)
> +{
> +=09struct rproc **ptr, *rproc;
> +
> +=09ptr =3D devres_alloc(devm_rproc_free, sizeof(*ptr), GFP_KERNEL);
> +=09if (!ptr)
> +=09=09return ERR_PTR(-ENOMEM);
> +
> +=09rproc =3D rproc_alloc(dev, name, ops, firmware, len);
> +=09if (rproc) {
> +=09=09*ptr =3D rproc;
> +=09=09devres_add(dev, ptr);
> +=09} else {
> +=09=09devres_free(ptr);
> +=09}
> +
> +=09return rproc;
> +}
> +EXPORT_SYMBOL(devm_rproc_alloc);
> +
> /**
>  * rproc_add_subdev() - add a subdevice to a remoteproc
>  * @rproc: rproc handle to add the subdevice to
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad66683ad0..5f201f0c86c3 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -595,6 +595,11 @@ int rproc_add(struct rproc *rproc);
> int rproc_del(struct rproc *rproc);
> void rproc_free(struct rproc *rproc);
>=20
> +struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
> +=09=09=09       const struct rproc_ops *ops,
> +=09=09=09       const char *firmware, int len);
> +int devm_rproc_add(struct device *dev, struct rproc *rproc);
> +
> void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)=
;
>=20
> struct rproc_mem_entry *
> --
> 2.24.0
