Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86409C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552AB2067C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="O6zyLZKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLNWaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:30:10 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:43106 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNWaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576362607; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEWhWZNL/jPu0RwxR8LERWF18UwNV1mO1D4VZ77+j8o=;
        b=O6zyLZKHncXhQ6//v2GlPdHKSzDMtIJXjseU/ghuJjyN39edXj7NyIhANJHBPHl8Ej8u52
        3OdzUIpakCQe+++cQmQZSX4N01G+N6YEd+7feRXeUiNQM0h+akbC+qYivWnenn+c6324lH
        JKg91h+E6LwhnjgP81qfUE9Bd3wtEn0=
Date:   Sat, 14 Dec 2019 23:30:03 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 3/5] remoteproc: Add prepare/unprepare callbacks
To:     Fabien DESSENNE <fabien.dessenne@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1576362603.3.5@crapouillou.net>
In-Reply-To: <f25180f2-7c6d-0022-12b2-cd9c202f39d3@st.com>
References: <20191210164014.50739-1-paul@crapouillou.net>
        <20191210164014.50739-3-paul@crapouillou.net>
        <f25180f2-7c6d-0022-12b2-cd9c202f39d3@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,


Le jeu., d=E9c. 12, 2019 at 10:03, Fabien DESSENNE=20
<fabien.dessenne@st.com> a =E9crit :
> Hi Paul
>=20
>=20
> On 10/12/2019 5:40 PM, Paul Cercueil wrote:
>>  The .prepare() callback is called before the firmware is loaded to
>>  memory. This is useful for instance in the case where some setup is
>>  required for the memory to be accessible.
>=20
>=20
> I am trying to figure out what king of 'setup' may be required. From=20
> the
> ingenic driver I understand that you need to enable clocks to allow=20
> some
> memory access.
>=20
> Instead of adding this new ops, why not enabling clocks in probe()?

Enabling the clocks in the probe means that the clocks will be=20
unconditionally enabled until the driver is removed, even if the remote=20
processor end up being unused. That would be a waste of power.

Cheers,
-Paul


>=20
> BR
>=20
> Fabien
>=20
>=20
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>       v2-v4: No change
>>=20
>>    drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++++-
>>    include/linux/remoteproc.h           |  4 ++++
>>    2 files changed, 19 insertions(+), 1 deletion(-)
>>=20
>>  diff --git a/drivers/remoteproc/remoteproc_core.c=20
>> b/drivers/remoteproc/remoteproc_core.c
>>  index 0a9fc7fdd1c3..3ea5f675a148 100644
>>  --- a/drivers/remoteproc/remoteproc_core.c
>>  +++ b/drivers/remoteproc/remoteproc_core.c
>>  @@ -1299,11 +1299,19 @@ static int rproc_start(struct rproc *rproc,=20
>> const struct firmware *fw)
>>    	struct device *dev =3D &rproc->dev;
>>    	int ret;
>>=20
>>  +	if (rproc->ops->prepare) {
>>  +		ret =3D rproc->ops->prepare(rproc);
>>  +		if (ret) {
>>  +			dev_err(dev, "Failed to prepare rproc: %d\n", ret);
>>  +			return ret;
>>  +		}
>>  +	}
>>  +
>>    	/* load the ELF segments to memory */
>>    	ret =3D rproc_load_segments(rproc, fw);
>>    	if (ret) {
>>    		dev_err(dev, "Failed to load program segments: %d\n", ret);
>>  -		return ret;
>>  +		goto unprepare_rproc;
>>    	}
>>=20
>>    	/*
>>  @@ -1354,6 +1362,9 @@ static int rproc_start(struct rproc *rproc,=20
>> const struct firmware *fw)
>>    	rproc_unprepare_subdevices(rproc);
>>    reset_table_ptr:
>>    	rproc->table_ptr =3D rproc->cached_table;
>>  +unprepare_rproc:
>>  +	if (rproc->ops->unprepare)
>>  +		rproc->ops->unprepare(rproc);
>>=20
>>    	return ret;
>>    }
>>  @@ -1483,6 +1494,9 @@ static int rproc_stop(struct rproc *rproc,=20
>> bool crashed)
>>=20
>>    	rproc->state =3D RPROC_OFFLINE;
>>=20
>>  +	if (rproc->ops->unprepare)
>>  +		rproc->ops->unprepare(rproc);
>>  +
>>    	dev_info(dev, "stopped remote processor %s\n", rproc->name);
>>=20
>>    	return 0;
>>  diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>  index 5f201f0c86c3..a6272d1ba384 100644
>>  --- a/include/linux/remoteproc.h
>>  +++ b/include/linux/remoteproc.h
>>  @@ -355,6 +355,8 @@ enum rsc_handling_status {
>>=20
>>    /**
>>     * struct rproc_ops - platform-specific device handlers
>>  + * @prepare:	prepare the device for power up (before the firmware=20
>> is loaded)
>>  + * @unprepare:	unprepare the device after it is stopped
>>     * @start:	power on the device and boot it
>>     * @stop:	power off the device
>>     * @kick:	kick a virtqueue (virtqueue id given as a parameter)
>>  @@ -371,6 +373,8 @@ enum rsc_handling_status {
>>     * @get_boot_addr:	get boot address to entry point specified in=20
>> firmware
>>     */
>>    struct rproc_ops {
>>  +	int (*prepare)(struct rproc *rproc);
>>  +	void (*unprepare)(struct rproc *rproc);
>>    	int (*start)(struct rproc *rproc);
>>    	int (*stop)(struct rproc *rproc);
>>    	void (*kick)(struct rproc *rproc, int vqid);

=

