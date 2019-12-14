Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB52C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A12205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="k3Wr0qSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfLNW2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:28:06 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40884 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNW2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576362483; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkyNSdZg4kfbaq1R2dOR/fJNQfzwkysyQhkhXjiurGE=;
        b=k3Wr0qSCNDiVPoB699vi5kHG7olQz7GQXV8W7sMgHj8W9/Qh1ke2RxmAK9T/68K/pdKkWU
        XTjeLHsu4YENIsnve24tzceAbbKZbDjMgNP7bLENPaF5nwkU5a7kaRRkvmiQymDWyt5X0h
        BhX12+Y3hh4c5z13Q2w8ZvOl5I51cMo=
Date:   Sat, 14 Dec 2019 23:27:58 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 2/5] remoteproc: Add device-managed variants of
 rproc_alloc/rproc_add
To:     Fabien DESSENNE <fabien.dessenne@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1576362478.3.4@crapouillou.net>
In-Reply-To: <6fff431f-dd3f-a67e-e40b-8cee4060c37a@st.com>
References: <20191210164014.50739-1-paul@crapouillou.net>
        <20191210164014.50739-2-paul@crapouillou.net>
        <6fff431f-dd3f-a67e-e40b-8cee4060c37a@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,


Le jeu., d=E9c. 12, 2019 at 09:43, Fabien DESSENNE=20
<fabien.dessenne@st.com> a =E9crit :
> Hi Paul,
>=20
>=20
> Good initiative! See me remarks below.
>=20
>=20
> On 10/12/2019 5:40 PM, Paul Cercueil wrote:
>>  Add API functions devm_rproc_alloc() and devm_rproc_add(), which=20
>> behave
>>  like rproc_alloc() and rproc_add() respectively, but register their
>>  respective cleanup function to be called on driver detach.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>       v3: New patch
>>       v4: No change
>>=20
>>    drivers/remoteproc/remoteproc_core.c | 67=20
>> ++++++++++++++++++++++++++++
>>    include/linux/remoteproc.h           |  5 +++
>>    2 files changed, 72 insertions(+)
>>=20
>>  diff --git a/drivers/remoteproc/remoteproc_core.c=20
>> b/drivers/remoteproc/remoteproc_core.c
>>  index 307df98347ba..0a9fc7fdd1c3 100644
>>  --- a/drivers/remoteproc/remoteproc_core.c
>>  +++ b/drivers/remoteproc/remoteproc_core.c
>=20
>=20
> Maybe these devm function shall be defined in a new=20
> remoteproc/devres.c
> file. Although it seems to be a common usage I don't know if there is=20
> a
> rule for that.

It's not a rule, more like a good practice. I'll do that.


>=20
>>  @@ -1932,6 +1932,33 @@ int rproc_add(struct rproc *rproc)
>>    }
>>    EXPORT_SYMBOL(rproc_add);
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
>>    /**
>>     * rproc_type_release() - release a remote processor instance
>>     * @dev: the rproc's device
>>  @@ -2149,6 +2176,46 @@ int rproc_del(struct rproc *rproc)
>>    }
>>    EXPORT_SYMBOL(rproc_del);
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
>=20
>=20
> typo: s/acuired/acquired
>=20
>=20
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
>=20
>=20
> Can't you use devm_add_action_or_reset() here too?

Yes, I guess that will make things simpler.

Thanks,
-Paul


>=20
>>  +}
>>  +EXPORT_SYMBOL(devm_rproc_alloc);
>>  +
>>    /**
>>     * rproc_add_subdev() - add a subdevice to a remoteproc
>>     * @rproc: rproc handle to add the subdevice to
>>  diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>  index 16ad66683ad0..5f201f0c86c3 100644
>>  --- a/include/linux/remoteproc.h
>>  +++ b/include/linux/remoteproc.h
>>  @@ -595,6 +595,11 @@ int rproc_add(struct rproc *rproc);
>>    int rproc_del(struct rproc *rproc);
>>    void rproc_free(struct rproc *rproc);
>>=20
>>  +struct rproc *devm_rproc_alloc(struct device *dev, const char=20
>> *name,
>>  +			       const struct rproc_ops *ops,
>>  +			       const char *firmware, int len);
>>  +int devm_rproc_add(struct device *dev, struct rproc *rproc);
>>  +
>>    void rproc_add_carveout(struct rproc *rproc, struct=20
>> rproc_mem_entry *mem);
>>=20
>>    struct rproc_mem_entry *
>=20
>=20
> BR
>=20
> Fabien

=

