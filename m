Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F227C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216B92067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="gJ68o9f/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfLPQQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:16:52 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:37848 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:16:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 6B3DC27E071F;
        Mon, 16 Dec 2019 17:16:50 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AP85RCpn7i6n; Mon, 16 Dec 2019 17:16:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 407CC27E0BD7;
        Mon, 16 Dec 2019 17:16:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 407CC27E0BD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1576513009;
        bh=KR939lExQcRXFUHVUhpJ/ZllnQWAxZq25C9GZNkR76U=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gJ68o9f/e8oFmWIH5unONRa2aEajhIPONxIGQK7Y7vK/b87SpQ/Y6aaAPSrYCG2EE
         9pMx+CZOtCmNUACqRWsjg2muWJeLoTo5Ts7SFDVHGHKC2bls/VgsAU8t4az2ITGpx2
         FqeCz12tAfoCC9QY6wj3XVCKu9Lu9GDpVHPVI72w=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vxr3CEuQAYvY; Mon, 16 Dec 2019 17:16:49 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 225B127E071F;
        Mon, 16 Dec 2019 17:16:49 +0100 (CET)
Date:   Mon, 16 Dec 2019 17:16:48 +0100 (CET)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od <od@zcrc.me>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1421722418.96878492.1576513008758.JavaMail.zimbra@kalray.eu>
In-Reply-To: <1428337657.96784882.1576485771590.JavaMail.zimbra@kalray.eu>
References: <20191210164014.50739-1-paul@crapouillou.net> <20191210164014.50739-3-paul@crapouillou.net> <f25180f2-7c6d-0022-12b2-cd9c202f39d3@st.com> <1576362603.3.5@crapouillou.net> <1428337657.96784882.1576485771590.JavaMail.zimbra@kalray.eu>
Subject: Re: [PATCH v4 3/5] remoteproc: Add prepare/unprepare callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - GC75 (Linux)/8.8.12_GA_3794)
Thread-Topic: remoteproc: Add prepare/unprepare callbacks
Thread-Index: uueckZt7bHlt5Prq/c0hmSkfQsRjRiJ9Kq+O
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I tested your patch and implemented the prepare callback only.
This is working correctly and the callback is correctly called
to enable clocks right before loading code into memory.

Regarding unprepare, I have no usecase for this since clocks
disabling and resetting is done in rproc_stop. Thus, I did not
tested this part. Did you add it to be called after the subdevices
unprepare call ? If not, what is the use case for this ?
ie, what are you doing in unprepare that you don't do in stop ?

Obviously it should work but I can't say I tested it completely !

Regards,

Cl=C3=A9ment


----- On 16 Dec, 2019, at 09:42, Cl=C3=A9ment Leger cleger@kalray.eu wrote:

> Hi Paul
>=20
> ----- On 14 Dec, 2019, at 23:30, Paul Cercueil paul@crapouillou.net wrote=
:
>=20
>> Hi Fabien,
>>=20
>>=20
>> Le jeu., d=C3=A9c. 12, 2019 at 10:03, Fabien DESSENNE
>> <fabien.dessenne@st.com> a =C3=A9crit :
>>> Hi Paul
>>>=20
>>>=20
>>> On 10/12/2019 5:40 PM, Paul Cercueil wrote:
>>>>  The .prepare() callback is called before the firmware is loaded to
>>>>  memory. This is useful for instance in the case where some setup is
>>>>  required for the memory to be accessible.
>>>=20
>>>=20
>>> I am trying to figure out what king of 'setup' may be required. From
>>> the
>>> ingenic driver I understand that you need to enable clocks to allow
>>> some
>>> memory access.
>>>=20
>>> Instead of adding this new ops, why not enabling clocks in probe()?
>>=20
>> Enabling the clocks in the probe means that the clocks will be
>> unconditionally enabled until the driver is removed, even if the remote
>> processor end up being unused. That would be a waste of power.
>=20
> We have the same kind of "problem" for k1c remoteproc driver (not yet
> upstream, depends on new arch). We need to enable clocks to load code
> into remote processor memory and currently we do that in probe.
> However, as you stated, we would like to enable them as late as possible
> (just before loading code) to avoid wasting power unnecessarily. So the
> "prepare" callback totally makes sense.
>=20
> Regards,
>=20
> Cl=C3=A9ment
>=20
>>=20
>> Cheers,
>> -Paul
>>=20
>>=20
>>>=20
>>> BR
>>>=20
>>> Fabien
>>>=20
>>>=20
>>>>=20
>>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>  ---
>>>>=20
>>>>  Notes:
>>>>       v2-v4: No change
>>>>=20
>>>>    drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++++-
>>>>    include/linux/remoteproc.h           |  4 ++++
>>>>    2 files changed, 19 insertions(+), 1 deletion(-)
>>>>=20
>>>>  diff --git a/drivers/remoteproc/remoteproc_core.c
>>>> b/drivers/remoteproc/remoteproc_core.c
>>>>  index 0a9fc7fdd1c3..3ea5f675a148 100644
>>>>  --- a/drivers/remoteproc/remoteproc_core.c
>>>>  +++ b/drivers/remoteproc/remoteproc_core.c
>>>>  @@ -1299,11 +1299,19 @@ static int rproc_start(struct rproc *rproc,
>>>> const struct firmware *fw)
>>>>    =09struct device *dev =3D &rproc->dev;
>>>>    =09int ret;
>>>>=20
>>>>  +=09if (rproc->ops->prepare) {
>>>>  +=09=09ret =3D rproc->ops->prepare(rproc);
>>>>  +=09=09if (ret) {
>>>>  +=09=09=09dev_err(dev, "Failed to prepare rproc: %d\n", ret);
>>>>  +=09=09=09return ret;
>>>>  +=09=09}
>>>>  +=09}
>>>>  +
>>>>    =09/* load the ELF segments to memory */
>>>>    =09ret =3D rproc_load_segments(rproc, fw);
>>>>    =09if (ret) {
>>>>    =09=09dev_err(dev, "Failed to load program segments: %d\n", ret);
>>>>  -=09=09return ret;
>>>>  +=09=09goto unprepare_rproc;
>>>>    =09}
>>>>=20
>>>>    =09/*
>>>>  @@ -1354,6 +1362,9 @@ static int rproc_start(struct rproc *rproc,
>>>> const struct firmware *fw)
>>>>    =09rproc_unprepare_subdevices(rproc);
>>>>    reset_table_ptr:
>>>>    =09rproc->table_ptr =3D rproc->cached_table;
>>>>  +unprepare_rproc:
>>>>  +=09if (rproc->ops->unprepare)
>>>>  +=09=09rproc->ops->unprepare(rproc);
>>>>=20
>>>>    =09return ret;
>>>>    }
>>>>  @@ -1483,6 +1494,9 @@ static int rproc_stop(struct rproc *rproc,
>>>> bool crashed)
>>>>=20
>>>>    =09rproc->state =3D RPROC_OFFLINE;
>>>>=20
>>>>  +=09if (rproc->ops->unprepare)
>>>>  +=09=09rproc->ops->unprepare(rproc);
>>>>  +
>>>>    =09dev_info(dev, "stopped remote processor %s\n", rproc->name);
>>>>=20
>>>>    =09return 0;
>>>>  diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>>  index 5f201f0c86c3..a6272d1ba384 100644
>>>>  --- a/include/linux/remoteproc.h
>>>>  +++ b/include/linux/remoteproc.h
>>>>  @@ -355,6 +355,8 @@ enum rsc_handling_status {
>>>>=20
>>>>    /**
>>>>     * struct rproc_ops - platform-specific device handlers
>>>>  + * @prepare:=09prepare the device for power up (before the firmware
>>>> is loaded)
>>>>  + * @unprepare:=09unprepare the device after it is stopped
>>>>     * @start:=09power on the device and boot it
>>>>     * @stop:=09power off the device
>>>>     * @kick:=09kick a virtqueue (virtqueue id given as a parameter)
>>>>  @@ -371,6 +373,8 @@ enum rsc_handling_status {
>>>>     * @get_boot_addr:=09get boot address to entry point specified in
>>>> firmware
>>>>     */
>>>>    struct rproc_ops {
>>>>  +=09int (*prepare)(struct rproc *rproc);
>>>>  +=09void (*unprepare)(struct rproc *rproc);
>>>>    =09int (*start)(struct rproc *rproc);
>>>>    =09int (*stop)(struct rproc *rproc);
> > >>    =09void (*kick)(struct rproc *rproc, int vqid);
