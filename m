Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25830C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A7821A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="GhvWRTv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKLIkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:40:09 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38844 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbfKLIkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:40:09 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAC8WZHP019861;
        Tue, 12 Nov 2019 09:40:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=SyHfsyU4mqmWjJV92fBoe/VI3PmrduyqcBPRcoa5WLI=;
 b=GhvWRTv3m/rPOqxmoOF0DSLcOhPuV6Jw/tqyDfYdsHyg6qp3Qw7hboyTt7iPRDnOSWDc
 GTWe/E2aji3ViM+eArXfjpS3OSv+GGSBJ4QvO0DHEqz0Po3c8tjBGWWa8kQO96gPEDN/
 gwzvJtv/C8rPQFPLPJhSMViw7K2IMwBhS+iz2dEuzvKzAPWyRC8ea5J5iGxAqDu8NkT+
 R/DA+Q/+q80dxgibkJljXmNJTHwDgK+X1p31k8pfZ1Mhuro1La5QZbb6pXaY0Uy+hNlx
 lC9a28nU3iuuJxorf27nr2yR1wwlzuVCpgJQQUngJoU5PFkn7NZY36X3mf6rlTjhOeGP NA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w7pstrsft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 09:40:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 07103100038;
        Tue, 12 Nov 2019 09:40:02 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E9AA92ADD47;
        Tue, 12 Nov 2019 09:40:01 +0100 (CET)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 09:40:01 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1473.003; Tue, 12 Nov 2019 09:40:01 +0100
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "Fabien DESSENNE" <fabien.dessenne@st.com>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: RE: [PATCH v2 1/1] remoteproc: add support for co-processor booted
 before kernel
Thread-Topic: [PATCH v2 1/1] remoteproc: add support for co-processor booted
 before kernel
Thread-Index: AQHVkv2NUEsuP3FH4UGU8CGKAfhkTqeCAP2AgAU8NhA=
Date:   Tue, 12 Nov 2019 08:40:01 +0000
Message-ID: <9879473e5b91499eb3d6ddd11584af16@SFHDAG7NODE2.st.com>
References: <1572864570-10131-1-git-send-email-loic.pallardy@st.com>
 <20191109012027.GC5662@tuxbook-pro>
In-Reply-To: <20191109012027.GC5662@tuxbook-pro>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_02:2019-11-11,2019-11-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for your review.

> -----Original Message-----
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> Sent: samedi 9 novembre 2019 02:20
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> benjamin.gaignard@linaro.org; Fabien DESSENNE
> <fabien.dessenne@st.com>; s-anna@ti.com
> Subject: Re: [PATCH v2 1/1] remoteproc: add support for co-processor
> booted before kernel
>=20
> On Mon 04 Nov 02:49 PST 2019, Loic Pallardy wrote:
>=20
> > Remote processor could boot independently or be started before Linux
> > kernel by bootloader or any firmware.
> > This patch introduces a new property in rproc core, named preloaded,
> > to be able to allocate resources and sub-devices like vdev and to
> > synchronize with current state without loading firmware from file syste=
m.
> > It is platform driver responsibility to implement the right firmware
> > load ops according to HW specificities.
> >
>=20
> Is it just preloaded or already started?
At the beginning, this properties was indeed to support an already started =
coprocessor, but discussing with Suman few months ago, we detected some cas=
es for which firmware may be loaded before kernel start (firmware located i=
n embedded flash or loaded by bootloaders) or may be loaded by a dedicated =
driver interface before rproc framework be called.
As rproc framework is mainly responsible for firmware loading and resource =
allocation, I named this property preloaded to cover as much as possible al=
l cases.
>=20
> > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> >
> > ---
> > Change from v1:
> > - Keep bool in struct rproc
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 37
> +++++++++++++++++++++++++++---------
> >  include/linux/remoteproc.h           |  2 ++
> >  2 files changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> > index 3c5fbbbfb0f1..7eaf0f949afa 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
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
> >
> >  	/*
> >  	 * if enabling an IOMMU isn't relevant for this rproc, this is
> > @@ -1728,7 +1732,7 @@ static void rproc_crash_handler_work(struct
> work_struct *work)
> >   */
> >  int rproc_boot(struct rproc *rproc)
> >  {
> > -	const struct firmware *firmware_p;
> > +	const struct firmware *firmware_p =3D NULL;
> >  	struct device *dev;
> >  	int ret;
> >
> > @@ -1759,11 +1763,17 @@ int rproc_boot(struct rproc *rproc)
> >
> >  	dev_info(dev, "powering up %s\n", rproc->name);
> >
> > -	/* load firmware */
> > -	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > -	if (ret < 0) {
> > -		dev_err(dev, "request_firmware failed: %d\n", ret);
> > -		goto downref_rproc;
> > +	if (!rproc->preloaded) {
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
>=20
> What happens when the remoteproc crashes? What happens if I stop it and
> try to start it again?
Exactly, it should be stopped, then firmware should be provided and coproce=
ssor restarted thanks to sysfs interface

>=20
> >  	}
> >
> >  	ret =3D rproc_fw_boot(rproc, firmware_p);
> > @@ -1917,8 +1927,17 @@ int rproc_add(struct rproc *rproc)
> >  	/* create debugfs entries */
> >  	rproc_create_debug_dir(rproc);
> >
> > -	/* if rproc is marked always-on, request it to boot */
> > -	if (rproc->auto_boot) {
> > +	if (rproc->preloaded) {
> > +		/*
> > +		 * If rproc is marked already booted, no need to wait
> > +		 * for firmware.
> > +		 * Just handle associated resources and start sub devices
> > +		 */
> > +		ret =3D rproc_boot(rproc);
>=20
> This will trickle down to your remoteproc driver's start() callback. If
> you really mean that "preloaded" means "already started", then I presume
> you're having some logic in your start() to turn it into a nop?
Yes it is the responsibility of the driver to know in which state coprocess=
or is.
Depending on the use case, driver could:
- do nothing if coprocessor already running
- boot coprocessor, if only firmware was preloaded
- reboot coprocessor to restart its execution on the preloaded firmware

>=20
> > +		if (ret < 0)
> > +			return ret;
> > +	} else if (rproc->auto_boot) {
> > +		/* if rproc is marked always-on, request it to boot */
> >  		ret =3D rproc_trigger_auto_boot(rproc);
> >  		if (ret < 0)
> >  			return ret;
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 16ad66683ad0..b68fbd576a77 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -479,6 +479,7 @@ struct rproc_dump_segment {
> >   * @table_sz: size of @cached_table
> >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> >   * @auto_boot: flag to indicate if remote processor should be auto-sta=
rted
> > + * @preloaded: remote processor has been preloaded before start
> sequence
>=20
> I think this should be "skip_firmware_load", or if you really mean that
> the bootloader started the remote process perhaps this should be
> "@fw_booted: remote processor was booted by firmware" (or something
> similar).
I'm fine with "skip_firmware_load" or "skip_fw_load" to have a shorter name=
.
I'll also add "preload" in patch title.

Regards,
Loic

>=20
> Regards,
> Bjorn
>=20
> >   * @dump_segments: list of segments in the firmware
> >   * @nb_vdev: number of vdev currently handled by rproc
> >   */
> > @@ -512,6 +513,7 @@ struct rproc {
> >  	size_t table_sz;
> >  	bool has_iommu;
> >  	bool auto_boot;
> > +	bool preloaded;
> >  	struct list_head dump_segments;
> >  	int nb_vdev;
> >  };
> > --
> > 2.7.4
> >
