Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF6AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946BA2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ezAwR9nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfKOP1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:27:32 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4476 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727443AbfKOP1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:27:32 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFFN0gJ028320;
        Fri, 15 Nov 2019 16:27:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=/DYTEUv9FMm0uphULjBcCaP+Yv0UkWCWRS43gUokZlA=;
 b=ezAwR9nvHh0gCu8wDuYBqFldLYcBVE0LcyfUfZocCZ+0Q1weCz/GiclumimptMnoVQDi
 1gV3AKp84Wuc198LCcoX54zcWpg7+/VK5tIqrrTJPVyCYOOkOEOSO90yv+ASvG2rR903
 f4h7akCZmuSL4DAhrLKt+BXBVdkktmxEZO/Cdg6rEWXP5lsk9JrW4ee1eWGCYCupNc2E
 Ukr3UM+0kNSqXaC63l4TV0GyMmg7jVAZI+zrafQKuOHY/Y2PWl12tXYet9RMx2QGjca4
 dKE/+MtszjLmKNtWD7ilgRkgxqmigJt8DJdG/0EaF+yfP4s/mbxu4FMnTibrsagOrGUS CA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w7psfn2y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 16:27:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F1B910002A;
        Fri, 15 Nov 2019 16:27:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6087B2C0FEA;
        Fri, 15 Nov 2019 16:27:25 +0100 (CET)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Nov
 2019 16:27:24 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1473.003; Fri, 15 Nov 2019 16:27:25 +0100
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "Fabien DESSENNE" <fabien.dessenne@st.com>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: RE: [PATCH v3 1/1] remoteproc: add support for co-processor loaded
 and booted before kernel
Thread-Topic: [PATCH v3 1/1] remoteproc: add support for co-processor loaded
 and booted before kernel
Thread-Index: AQHVmmliPLBKAnkp0ESJuBb9N++KraeK6m2AgAFpHrA=
Date:   Fri, 15 Nov 2019 15:27:24 +0000
Message-ID: <27c9d23478cf410481285182f9e42172@SFHDAG7NODE2.st.com>
References: <1573680543-39086-1-git-send-email-loic.pallardy@st.com>
 <20191114181909.GA21402@xps15>
In-Reply-To: <20191114181909.GA21402@xps15>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> -----Original Message-----
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> Sent: jeudi 14 novembre 2019 19:19
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: bjorn.andersson@linaro.org; ohad@wizery.com; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Arnaud
> POULIQUEN <arnaud.pouliquen@st.com>; benjamin.gaignard@linaro.org;
> Fabien DESSENNE <fabien.dessenne@st.com>; s-anna@ti.com
> Subject: Re: [PATCH v3 1/1] remoteproc: add support for co-processor
> loaded and booted before kernel
>=20
> Hi Loic,
>=20
> On Wed, Nov 13, 2019 at 10:29:03PM +0100, Loic Pallardy wrote:
> > Remote processor could boot independently or be loaded/started before
> > Linux kernel by bootloader or any firmware.
> > This patch introduces a new property in rproc core, named skip_fw_load,
> > to be able to allocate resources and sub-devices like vdev and to
> > synchronize with current state without loading firmware from file syste=
m.
> > It is platform driver responsibility to implement the right firmware
> > load ops according to HW specificities.
> >
> > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> >
> > ---
> > Change from v2:
> > - rename property into skip_fw_load
> > - update rproc_boot and rproc_fw_boot description
> > - update commit message
> > Change from v1:
> > - Keep bool in struct rproc
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 51
> +++++++++++++++++++++++++++---------
> >  include/linux/remoteproc.h           |  2 ++
> >  2 files changed, 40 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> > index 3c5fbbbfb0f1..585cdca8b241 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1360,7 +1360,7 @@ static int rproc_start(struct rproc *rproc, const
> struct firmware *fw)
> >  }
> >
> >  /*
> > - * take a firmware and boot a remote processor with it.
> > + * Handle resources defined in resource table and start a remote
> processor.
> >   */
> >  static int rproc_fw_boot(struct rproc *rproc, const struct firmware *f=
w)
> >  {
> > @@ -1372,7 +1372,11 @@ static int rproc_fw_boot(struct rproc *rproc,
> const struct firmware *fw)
> >  	if (ret)
> >  		return ret;
> >
> > -	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
> > +	if (fw)
> > +		dev_info(dev, "Booting fw image %s, size %zd\n", name,
> > +			 fw->size);
> > +	else
> > +		dev_info(dev, "Synchronizing with preloaded co-
> processor\n");
>=20
> Here we assume that if @fw is NULL then the image is already loaded.  The
> first
> question that comes to mind is if that means the ELF image has already be=
en
> copied to the coprocessor's boot address.  If that is the case it would b=
e nice
> to make it explicit with a comment in the code.

Yes, but will be better to test "skip_fw_load" properties to change display=
 info message.
Anyway, agree to mention that if @fw is NULL that means fw considered as al=
ready loaded.
>=20
> Following the earlier comments made on the thread for this serie, I
> understand
> the rproc_ops fed to the core should provision for @fw being NULL.  In
> this case though st_rproc_ops[1] reference a number of core operations th=
at
> aren't tailored to handled a NULL @fw parameter.

True, some patches will follow

>=20
> I am pretty sure you're well aware of this and you have more patches to g=
o
> with
> this one or said patches have already been published and I'm looking at t=
he
> wrong tree. If that is the case would you mind making those patches publi=
c or
> pointing me to a repository somewhere?

Please have a look here [1].
The properties is named preloaded instead of skip_fw_load, but that's the s=
ame.
Impacted ops are working differently according to preloaded status.

When skip_fw_load is true, no ELF image is used. Platform driver is in char=
ge of providing resource table location somewhere in memory.
Somewhere is platform dependent.

Regards,
Loic
[1] https://github.com/STMicroelectronics/linux/blob/v4.19-stm32mp/drivers/=
remoteproc/stm32_rproc.c

>=20
> I have other concerns about the specifics shared between the application
> and co
> processors using the ELF image but I'll wait for your reply to the above =
before
> addressing those.
>=20
> Regards,
> Mathieu
>=20
> [1]. https://elixir.bootlin.com/linux/v5.4-
> rc7/source/drivers/remoteproc/stm32_rproc.c#L470
>=20
> >
> >  	/*
> >  	 * if enabling an IOMMU isn't relevant for this rproc, this is
> > @@ -1719,16 +1723,22 @@ static void rproc_crash_handler_work(struct
> work_struct *work)
> >   * rproc_boot() - boot a remote processor
> >   * @rproc: handle of a remote processor
> >   *
> > - * Boot a remote processor (i.e. load its firmware, power it on, ...).
> > + * Boot a remote processor (i.e. load its firmware, power it on, ...) =
from
> > + * different contexts:
> > + * - power off
> > + * - preloaded firmware
> > + * - started before kernel execution
> > + * The different operations are selected thanks to properties defined =
by
> > + * platform driver.
> >   *
> > - * If the remote processor is already powered on, this function
> immediately
> > - * returns (successfully).
> > + * If the remote processor is already powered on at rproc level, this
> function
> > + * immediately returns (successfully).
> >   *
> >   * Returns 0 on success, and an appropriate error value otherwise.
> >   */
> >  int rproc_boot(struct rproc *rproc)
> >  {
> > -	const struct firmware *firmware_p;
> > +	const struct firmware *firmware_p =3D NULL;
> >  	struct device *dev;
> >  	int ret;
> >
> > @@ -1759,11 +1769,17 @@ int rproc_boot(struct rproc *rproc)
> >
> >  	dev_info(dev, "powering up %s\n", rproc->name);
> >
> > -	/* load firmware */
> > -	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > -	if (ret < 0) {
> > -		dev_err(dev, "request_firmware failed: %d\n", ret);
> > -		goto downref_rproc;
> > +	if (!rproc->skip_fw_load) {
> > +		/* load firmware */
> > +		ret =3D request_firmware(&firmware_p, rproc->firmware,
> dev);
> > +		if (ret < 0) {
> > +			dev_err(dev, "request_firmware failed: %d\n", ret);
> > +			goto downref_rproc;
> > +		}
> > +	} else {
> > +		/* set firmware name to null as unknown */
> > +		kfree(rproc->firmware);
> > +		rproc->firmware =3D NULL;
> >  	}
> >
> >  	ret =3D rproc_fw_boot(rproc, firmware_p);
> > @@ -1917,8 +1933,17 @@ int rproc_add(struct rproc *rproc)
> >  	/* create debugfs entries */
> >  	rproc_create_debug_dir(rproc);
> >
> > -	/* if rproc is marked always-on, request it to boot */
> > -	if (rproc->auto_boot) {
> > +	if (rproc->skip_fw_load) {
> > +		/*
> > +		 * If rproc is marked already booted, no need to wait
> > +		 * for firmware.
> > +		 * Just handle associated resources and start sub devices
> > +		 */
> > +		ret =3D rproc_boot(rproc);
> > +		if (ret < 0)
> > +			return ret;
> > +	} else if (rproc->auto_boot) {
> > +		/* if rproc is marked always-on, request it to boot */
> >  		ret =3D rproc_trigger_auto_boot(rproc);
> >  		if (ret < 0)
> >  			return ret;
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 16ad66683ad0..4fd5bedab4fa 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -479,6 +479,7 @@ struct rproc_dump_segment {
> >   * @table_sz: size of @cached_table
> >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> >   * @auto_boot: flag to indicate if remote processor should be auto-sta=
rted
> > + * @skip_fw_load: remote processor has been preloaded before start
> sequence
> >   * @dump_segments: list of segments in the firmware
> >   * @nb_vdev: number of vdev currently handled by rproc
> >   */
> > @@ -512,6 +513,7 @@ struct rproc {
> >  	size_t table_sz;
> >  	bool has_iommu;
> >  	bool auto_boot;
> > +	bool skip_fw_load;
> >  	struct list_head dump_segments;
> >  	int nb_vdev;
> >  };
> > --
> > 2.7.4
> >
