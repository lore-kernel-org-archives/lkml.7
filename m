Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D3FC17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F73222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tLrqLMFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfKMKfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:35:09 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59182 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726107AbfKMKfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:35:06 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADARwjR002853;
        Wed, 13 Nov 2019 11:35:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=3rXe662aPgObiFZJB8CM4UvzN5CMLsTHGP8ldFhlJes=;
 b=tLrqLMFH92XvEGyF9DqFBxS1wynsAlQXmp9ATX1gCCu3RPsuxB36W9fhV5RRqBgn8j3n
 UrHzgYH73pK20ULuPiHn4ld3sG13E4aVBGzfaDLgmY9rFy+4rLhuSIa4UZgPEBCUTQfM
 6WUToJidbNNScXFLBzTxnpUevMgNOljnsJoz9DODkejmr6Sc7iSzX91igPY7AuiM73SA
 cGn6Mf2hXhY+Cy7NkuHYQsiHa8upKjvUD27LKWQIW+6eGF9w8fvM4b99VNsBbsEGuQ48
 s5wbIWaRA38tdfP+HQH6yWnCHs4Ma+rozdkLS53GR+x2DyxaODDn8ytRY2cdbDlx4PGT bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w7pstyhjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 11:35:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D57E10002A;
        Wed, 13 Nov 2019 11:35:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F5152B530E;
        Wed, 13 Nov 2019 11:35:00 +0100 (CET)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 13 Nov
 2019 11:34:59 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1473.003; Wed, 13 Nov 2019 11:34:59 +0100
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
Thread-Index: AQHVkv2NUEsuP3FH4UGU8CGKAfhkTqeCAP2AgAU8NhCAAIpsgIABKdSA
Date:   Wed, 13 Nov 2019 10:34:59 +0000
Message-ID: <5153e66467204c9a938e1ce188993eb6@SFHDAG7NODE2.st.com>
References: <1572864570-10131-1-git-send-email-loic.pallardy@st.com>
 <20191109012027.GC5662@tuxbook-pro>
 <9879473e5b91499eb3d6ddd11584af16@SFHDAG7NODE2.st.com>
 <20191112173241.GG3797@yoga>
In-Reply-To: <20191112173241.GG3797@yoga>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_02:2019-11-13,2019-11-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
> owner@vger.kernel.org> On Behalf Of Bjorn Andersson
> Sent: mardi 12 novembre 2019 18:33
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> benjamin.gaignard@linaro.org; Fabien DESSENNE
> <fabien.dessenne@st.com>; s-anna@ti.com
> Subject: Re: [PATCH v2 1/1] remoteproc: add support for co-processor
> booted before kernel
>=20
> On Tue 12 Nov 00:40 PST 2019, Loic PALLARDY wrote:
>=20
> > Hi Bjorn,
> >
> > Thanks for your review.
> >
> > > -----Original Message-----
> > > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Sent: samedi 9 novembre 2019 02:20
> > > To: Loic PALLARDY <loic.pallardy@st.com>
> > > Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Arnaud POULIQUEN
> <arnaud.pouliquen@st.com>;
> > > benjamin.gaignard@linaro.org; Fabien DESSENNE
> > > <fabien.dessenne@st.com>; s-anna@ti.com
> > > Subject: Re: [PATCH v2 1/1] remoteproc: add support for co-processor
> > > booted before kernel
> > >
> > > On Mon 04 Nov 02:49 PST 2019, Loic Pallardy wrote:
> > >
> > > > Remote processor could boot independently or be started before Linu=
x
> > > > kernel by bootloader or any firmware.
> > > > This patch introduces a new property in rproc core, named preloaded=
,
> > > > to be able to allocate resources and sub-devices like vdev and to
> > > > synchronize with current state without loading firmware from file
> system.
> > > > It is platform driver responsibility to implement the right firmwar=
e
> > > > load ops according to HW specificities.
> > > >
> > >
> > > Is it just preloaded or already started?
> > At the beginning, this properties was indeed to support an already
> > started coprocessor, but discussing with Suman few months ago, we
> > detected some cases for which firmware may be loaded before kernel
> > start (firmware located in embedded flash or loaded by bootloaders) or
> > may be loaded by a dedicated driver interface before rproc framework
> > be called.
> > As rproc framework is mainly responsible for firmware loading and
> > resource allocation, I named this property preloaded to cover as much
> > as possible all cases.
>=20
> Cool, then I like this patch :)
>=20
> > >
> > > > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > > >
> > > > ---
> > > > Change from v1:
> > > > - Keep bool in struct rproc
> > > > ---
> > > >  drivers/remoteproc/remoteproc_core.c | 37
> > > +++++++++++++++++++++++++++---------
> > > >  include/linux/remoteproc.h           |  2 ++
> > > >  2 files changed, 30 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/remoteproc/remoteproc_core.c
> > > b/drivers/remoteproc/remoteproc_core.c
> > > > index 3c5fbbbfb0f1..7eaf0f949afa 100644
> > > > --- a/drivers/remoteproc/remoteproc_core.c
> > > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > > @@ -1372,7 +1372,11 @@ static int rproc_fw_boot(struct rproc *rproc=
,
> > > const struct firmware *fw)
> > > >  	if (ret)
> > > >  		return ret;
> > > >
> > > > -	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
> > > > +	if (fw)
> > > > +		dev_info(dev, "Booting fw image %s, size %zd\n", name,
> > > > +			 fw->size);
> > > > +	else
> > > > +		dev_info(dev, "Synchronizing with preloaded co-
> > > processor\n");
> > > >
> > > >  	/*
> > > >  	 * if enabling an IOMMU isn't relevant for this rproc, this is
> > > > @@ -1728,7 +1732,7 @@ static void rproc_crash_handler_work(struct
> > > work_struct *work)
> > > >   */
> > > >  int rproc_boot(struct rproc *rproc)
> > > >  {
> > > > -	const struct firmware *firmware_p;
> > > > +	const struct firmware *firmware_p =3D NULL;
> > > >  	struct device *dev;
> > > >  	int ret;
> > > >
> > > > @@ -1759,11 +1763,17 @@ int rproc_boot(struct rproc *rproc)
> > > >
> > > >  	dev_info(dev, "powering up %s\n", rproc->name);
> > > >
> > > > -	/* load firmware */
> > > > -	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > > > -	if (ret < 0) {
> > > > -		dev_err(dev, "request_firmware failed: %d\n", ret);
> > > > -		goto downref_rproc;
> > > > +	if (!rproc->preloaded) {
> > > > +		/* load firmware */
> > > > +		ret =3D request_firmware(&firmware_p, rproc->firmware,
> > > dev);
> > > > +		if (ret < 0) {
> > > > +			dev_err(dev, "request_firmware failed: %d\n", ret);
> > > > +			goto downref_rproc;
> > > > +		}
> > > > +	} else {
> > > > +		/* set firmware name to null as unknown */
> > > > +		kfree(rproc->firmware);
> > > > +		rproc->firmware =3D NULL;
> > >
> > > What happens when the remoteproc crashes? What happens if I stop it
> and
> > > try to start it again?
> > Exactly, it should be stopped, then firmware should be provided and
> > coprocessor restarted thanks to sysfs interface
> >
>=20
> But in both these cases you rely on the firmware being persistent in
> some memory - be it some protected portion of RAM or some ROM?
>=20
> I.e. with this patch, and not setting "firmware" the remote is expected
> to just boot again on the same firmware.

Today no, we need to reload a firmware, but indeed it is an option is we co=
nsider the code located in a protected memory.
I have another patch to clean-up recovery operation, for example generating=
 a core dump without automatically restarting the coprocessor...
I'll rebase and share it too.

>=20
> > >
> > > >  	}
> > > >
> > > >  	ret =3D rproc_fw_boot(rproc, firmware_p);
> > > > @@ -1917,8 +1927,17 @@ int rproc_add(struct rproc *rproc)
> > > >  	/* create debugfs entries */
> > > >  	rproc_create_debug_dir(rproc);
> > > >
> > > > -	/* if rproc is marked always-on, request it to boot */
> > > > -	if (rproc->auto_boot) {
> > > > +	if (rproc->preloaded) {
> > > > +		/*
> > > > +		 * If rproc is marked already booted, no need to wait
> > > > +		 * for firmware.
> > > > +		 * Just handle associated resources and start sub devices
> > > > +		 */
> > > > +		ret =3D rproc_boot(rproc);
> > >
> > > This will trickle down to your remoteproc driver's start() callback. =
If
> > > you really mean that "preloaded" means "already started", then I
> presume
> > > you're having some logic in your start() to turn it into a nop?
> > Yes it is the responsibility of the driver to know in which state copro=
cessor
> is.
> > Depending on the use case, driver could:
> > - do nothing if coprocessor already running
> > - boot coprocessor, if only firmware was preloaded
> > - reboot coprocessor to restart its execution on the preloaded firmware
> >
>=20
> I'm slightly worried about the cases of finding an already booted
> coprocessor, as this often means that we have to make assumptions about
> clock states etc.

Yes that part is very platform driver specific and it will be driver respon=
sibility to preserve or to update associated clocks.

Regards,
Loic

>=20
> But with the focus of supporting persistent firmware, I like this.
>=20
> > >
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > +	} else if (rproc->auto_boot) {
> > > > +		/* if rproc is marked always-on, request it to boot */
> > > >  		ret =3D rproc_trigger_auto_boot(rproc);
> > > >  		if (ret < 0)
> > > >  			return ret;
> > > > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.=
h
> > > > index 16ad66683ad0..b68fbd576a77 100644
> > > > --- a/include/linux/remoteproc.h
> > > > +++ b/include/linux/remoteproc.h
> > > > @@ -479,6 +479,7 @@ struct rproc_dump_segment {
> > > >   * @table_sz: size of @cached_table
> > > >   * @has_iommu: flag to indicate if remote processor is behind an M=
MU
> > > >   * @auto_boot: flag to indicate if remote processor should be auto=
-
> started
> > > > + * @preloaded: remote processor has been preloaded before start
> > > sequence
> > >
> > > I think this should be "skip_firmware_load", or if you really mean th=
at
> > > the bootloader started the remote process perhaps this should be
> > > "@fw_booted: remote processor was booted by firmware" (or
> something
> > > similar).
> > I'm fine with "skip_firmware_load" or "skip_fw_load" to have a shorter
> name.
> > I'll also add "preload" in patch title.
> >
>=20
> skip_fw_load sounds good.
>=20
> Thanks,
> Bjorn
>=20
> > Regards,
> > Loic
> >
> > >
> > > Regards,
> > > Bjorn
> > >
> > > >   * @dump_segments: list of segments in the firmware
> > > >   * @nb_vdev: number of vdev currently handled by rproc
> > > >   */
> > > > @@ -512,6 +513,7 @@ struct rproc {
> > > >  	size_t table_sz;
> > > >  	bool has_iommu;
> > > >  	bool auto_boot;
> > > > +	bool preloaded;
> > > >  	struct list_head dump_segments;
> > > >  	int nb_vdev;
> > > >  };
> > > > --
> > > > 2.7.4
> > > >
