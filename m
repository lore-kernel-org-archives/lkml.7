Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E61C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C46A20409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VLG56Qhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfLPNlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:41:07 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44946 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfLPNlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576503665; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H294czyNOxXLRiUnhSh84JjUSdKrChOTGztkeWRPDKo=;
        b=VLG56Qhb4PeiZEfefSApkXt0NDXHvwvrVQs0rh0WWwe7SpqMouCkultiOpoRvX8QaHOfGY
        vJ0kXn/DRBXXNFdihWuqNY52w4vIhyq0hyFHhSD+tjMXA4qJuJM6eTqfh6fN0Wz5IE/hOi
        MFHGTdIY0v+446X6LvcA7+AEDNvkwc0=
Date:   Mon, 16 Dec 2019 14:41:00 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 2/5] remoteproc: Add device-managed variants of
 rproc_alloc/rproc_add
To:     =?iso-8859-1?q?Cl=E9ment?= Leger <cleger@kalray.eu>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od <od@zcrc.me>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <1576503660.3.3@crapouillou.net>
In-Reply-To: <340758118.96812669.1576493172804.JavaMail.zimbra@kalray.eu>
References: <20191210164014.50739-1-paul@crapouillou.net>
        <20191210164014.50739-2-paul@crapouillou.net>
        <340758118.96812669.1576493172804.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cl=E9ment,


Le lun., d=E9c. 16, 2019 at 11:46, Cl=E9ment Leger <cleger@kalray.eu> a=20
=E9crit :
> Hi Paul,
>=20
> I tested it on our driver and freeing/remove are called correctly on=20
> probe error and on module removal.
>=20
> Tested-By: Clement Leger <cleger@kalray.eu>

Great, thanks.

Did you also test the prepare/unprepare callbacks? Is it working for=20
you?

Thanks,
-Paul


> ----- On 10 Dec, 2019, at 17:40, Paul Cercueil paul@crapouillou.net=20
> wrote:
>=20
>>  Add API functions devm_rproc_alloc() and devm_rproc_add(), which=20
>> behave
>>  like rproc_alloc() and rproc_add() respectively, but register their
>>  respective cleanup function to be called on driver detach.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>     v3: New patch
>>     v4: No change
>>=20
>>  drivers/remoteproc/remoteproc_core.c | 67=20
>> ++++++++++++++++++++++++++++
>>  include/linux/remoteproc.h           |  5 +++
>>  2 files changed, 72 insertions(+)
>>=20
>>  diff --git a/drivers/remoteproc/remoteproc_core.c
>>  b/drivers/remoteproc/remoteproc_core.c
>>  index 307df98347ba..0a9fc7fdd1c3 100644
>>  --- a/drivers/remoteproc/remoteproc_core.c
>>  +++ b/drivers/remoteproc/remoteproc_core.c
>>  @@ -1932,6 +1932,33 @@ int rproc_add(struct rproc *rproc)
>>  }
>>  EXPORT_SYMBOL(rproc_add);
>>=20
>>  +static void devm_rproc_remove(void *rproc)
>>  +{
>>  +	rproc_del(rproc);
>>  +}
>>  +
>>  +/**
>>  + * devm_rproc_add() - resource managed rproc_add()
>>  + * @dev: the underlying device
>>  + * @rproc: the remote processor handle to register
>>  + *
>>  + * This function performs like rproc_add() but the registered=20
>> rproc device will
>>  + * automatically be removed on driver detach.
>>  + *
>>  + * Returns 0 on success and an appropriate error code otherwise.
>>  + */
>>  +int devm_rproc_add(struct device *dev, struct rproc *rproc)
>>  +{
>>  +	int err;
>>  +
>>  +	err =3D rproc_add(rproc);
>>  +	if (err)
>>  +		return err;
>>  +
>>  +	return devm_add_action_or_reset(dev, devm_rproc_remove, rproc);
>>  +}
>>  +EXPORT_SYMBOL(devm_rproc_add);
>>  +
>>  /**
>>   * rproc_type_release() - release a remote processor instance
>>   * @dev: the rproc's device
>>  @@ -2149,6 +2176,46 @@ int rproc_del(struct rproc *rproc)
>>  }
>>  EXPORT_SYMBOL(rproc_del);
>>=20
>>  +static void devm_rproc_free(struct device *dev, void *res)
>>  +{
>>  +	rproc_free(*(struct rproc **)res);
>>  +}
>>  +
>>  +/**
>>  + * devm_rproc_alloc() - resource managed rproc_alloc()
>>  + * @dev: the underlying device
>>  + * @name: name of this remote processor
>>  + * @ops: platform-specific handlers (mainly start/stop)
>>  + * @firmware: name of firmware file to load, can be NULL
>>  + * @len: length of private data needed by the rproc driver (in=20
>> bytes)
>>  + *
>>  + * This function performs like rproc_alloc() but the acuired rproc=20
>> device will
>>  + * automatically be released on driver detach.
>>  + *
>>  + * On success the new rproc is returned, and on failure, NULL.
>>  + */
>>  +struct rproc *devm_rproc_alloc(struct device *dev, const char=20
>> *name,
>>  +			       const struct rproc_ops *ops,
>>  +			       const char *firmware, int len)
>>  +{
>>  +	struct rproc **ptr, *rproc;
>>  +
>>  +	ptr =3D devres_alloc(devm_rproc_free, sizeof(*ptr), GFP_KERNEL);
>>  +	if (!ptr)
>>  +		return ERR_PTR(-ENOMEM);
>>  +
>>  +	rproc =3D rproc_alloc(dev, name, ops, firmware, len);
>>  +	if (rproc) {
>>  +		*ptr =3D rproc;
>>  +		devres_add(dev, ptr);
>>  +	} else {
>>  +		devres_free(ptr);
>>  +	}
>>  +
>>  +	return rproc;
>>  +}
>>  +EXPORT_SYMBOL(devm_rproc_alloc);
>>  +
>>  /**
>>   * rproc_add_subdev() - add a subdevice to a remoteproc
>>   * @rproc: rproc handle to add the subdevice to
>>  diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>  index 16ad66683ad0..5f201f0c86c3 100644
>>  --- a/include/linux/remoteproc.h
>>  +++ b/include/linux/remoteproc.h
>>  @@ -595,6 +595,11 @@ int rproc_add(struct rproc *rproc);
>>  int rproc_del(struct rproc *rproc);
>>  void rproc_free(struct rproc *rproc);
>>=20
>>  +struct rproc *devm_rproc_alloc(struct device *dev, const char=20
>> *name,
>>  +			       const struct rproc_ops *ops,
>>  +			       const char *firmware, int len);
>>  +int devm_rproc_add(struct device *dev, struct rproc *rproc);
>>  +
>>  void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry=20
>> *mem);
>>=20
>>  struct rproc_mem_entry *
>>  --
>>  2.24.0

=

