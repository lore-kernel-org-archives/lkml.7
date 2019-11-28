Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19B6C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADBF2158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k0x+Mnpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfK1Ijq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:39:46 -0500
Received: from mail-eopbgr140084.outbound.protection.outlook.com ([40.107.14.84]:41068
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726301AbfK1Ijq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:39:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN9gKKrvwkbRaFwLN0/GNNbLntztlh9kqr8D+4o4CdqVm8q4kzKZE26plPGyv030aqjcsx8AqywMvNJ5bHvfj5FEYKZnHG3+92+9ffCz++aQ+R+9sX2BcS83t77UKdW8cztSd6A5gYKpjzara3i/+emzhyec6679rkBpv09kbXOF9HjHiQP9m27+Soeh/4/RvY5rKmPEpBQXRXcCZuBbk7Fl6QaGIOsCahaFhY6RR3LlSG3bo4SzfmwK58G8+N5YOuYH+3veL8dZubx4SNuUbvWLpoamoqTJ27sz3dlJq5m3VzFSsGr4Cklhr3D6z8VwoZTiSMWQJt7cOm8KSlODiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwE2oQR5lwCM1/sx4R6m/lc32hGZsBr955dCdI1EkL4=;
 b=A/PxVVC1hQEU1jOEjOPpr8+D6VD+EvZM0Km2zM/DchVfM/x9v6Xgh7Ajin+oZFE9LgkYEEDuJrIMVvZBhkQrha/h2gurgNcTaJnv3BHGwssAtnqoLct4pw2Ou9HAKlPi6htS6RbtcSrb8Ug2UvJFxWxSTQJvNRNmH6c9fAWq85Xoq8s0cNAu5+bTl5Q4HNTboKMHchWh758uEKu8xcr0qaFlSB3Bs0pxkD2J36LgX+7YesVPWaV0RcSTWgE7vFuzUWute3yHeZ0AcDtcYmQOSpi4mTEVjzewZJYqtE0IKVz7rJj+xzpO48jmJ590xWwLXQCmJkriO5hPvVlpA/oLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwE2oQR5lwCM1/sx4R6m/lc32hGZsBr955dCdI1EkL4=;
 b=k0x+MnprbybL1tchdAwfF34RH/Ik+VuLB+GpHSapyq//VQw2PShL+gXmTtC2zbKVYvSCTBbB/TpRFsec4D2nlnTIn5ATB9r9kVvv4ZP5qePqW9BeMbY/gYIYllC9k8ijQjMqu37mbI6e9PTdr9m82KL6E/J9doeTiFRHW8Mm+Lg=
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com (20.179.24.74) by
 VI1PR04MB4880.eurprd04.prod.outlook.com (20.177.49.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 08:39:41 +0000
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::9056:3486:95b8:4eff]) by VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::9056:3486:95b8:4eff%4]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 08:39:41 +0000
From:   Laurentiu Palcu <laurentiu.palcu@nxp.com>
To:     =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC:     Uma Shankar <uma.shankar@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [EXT] Re: [PATCH] drm: fix HDR static metadata type field
 numbering
Thread-Topic: [EXT] Re: [PATCH] drm: fix HDR static metadata type field
 numbering
Thread-Index: AQHVpTDonNbf5j/+IEiOiFgD+u80BaefIQ+AgAEjT4A=
Date:   Thu, 28 Nov 2019 08:39:41 +0000
Message-ID: <20191128083940.GC10251@fsr-ub1664-121>
References: <1574865719-24490-1-git-send-email-laurentiu.palcu@nxp.com>
 <20191127151703.GJ1208@intel.com>
In-Reply-To: <20191127151703.GJ1208@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.palcu@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09e49c6e-afec-4cde-c5dc-08d773de8356
x-ms-traffictypediagnostic: VI1PR04MB4880:|VI1PR04MB4880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4880C624B96E7111E431FC47FF470@VI1PR04MB4880.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(189003)(199004)(6512007)(3846002)(9686003)(229853002)(6116002)(71200400001)(76116006)(71190400001)(6486002)(6436002)(478600001)(186003)(11346002)(446003)(76176011)(6506007)(86362001)(33656002)(26005)(102836004)(14444005)(2906002)(25786009)(256004)(44832011)(305945005)(6246003)(7736002)(91956017)(1076003)(66574012)(316002)(54906003)(64756008)(66446008)(6916009)(66066001)(66556008)(14454004)(66476007)(66946007)(4326008)(5660300002)(81156014)(8936002)(8676002)(81166006)(99286004)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4880;H:VI1PR04MB6237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t3oR8ULZ1AWH6nz3sJhwd3ZKYnGMrRtyP5TfFk3drmwSFk9OzFr4+ghvncualL1cBj7hRq/b4/dv+d9LFFl2OQytGvaAbOrbmKbTDgMAy2Ao2JfJ/KRTBUxClzYubqfF2bcv+5t1N8VNaBlAgzqvivsrIUs37n7pKtIrfxO1AZolwnT9EWUqQjtSfQBAGyHN9KKZAnR8pmPeaTw+38crwUoX96AYv3KHPtFPxvyAXCvcTczBhJ63xCXQJp8QiVT9JFUwFbslG/D7VhuaZfGrK1blJxsVdZJMaEHlKlNy7voKyIR1zZHEuo6SDeLdG2qeTvTJ0Kcgea6fOOjvjZd7lXfCQ/MJMWhwr+2pA53Gg+3v8My/tbYPKqovuU++OR8QxUrR/pSrB1Bxoa66DqhxhcsJV3mxJLK7jRMPxLeKWIiPuEm1R9zZSEeEjXRXp6oS
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <09903457459C43408EEE994B2177CD2A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e49c6e-afec-4cde-c5dc-08d773de8356
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 08:39:41.8401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CS22ezZ32Q5KAusHAkiI5CbG2jO6vgP59J8gxaH8/lzDH7fiazvaXwNIffJoBmmDBjJx2nAPR3XH+JUn3KncUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4880
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 05:17:03PM +0200, Ville Syrj=E4l=E4 wrote:
> Caution: EXT Email
>=20
> On Wed, Nov 27, 2019 at 02:42:35PM +0000, Laurentiu Palcu wrote:
> > According to CTA-861 specification, HDR static metadata data block allo=
ws a
> > sink to indicate which HDR metadata types it supports by setting the SM=
_0 to
> > SM_7 bits. Currently, only Static Metadata Type 1 is supported and this=
 is
> > indicated by setting the SM_0 bit to 1.
> >
> > However, the connector->hdr_sink_metadata.hdmi_type1.metadata_type is a=
lways
> > 0, because hdr_metadata_type() in drm_edid.c checks the wrong bit.
> >
> > This patch corrects the HDMI_STATIC_METADATA_TYPE1 bit position.
>=20
> Was confused for a while why this has even been workning, but I guess
> that's due to userspace populating the metadata infoframe blob correctly
> even if we misreported the metadata types in the parsed EDID metadata
> blob.
>=20
> Hmm. Actually on further inspection this all seems to be dead code. The
> only thing we seem to use from the parsed EDID metadata stuff is
> eotf bitmask. We check that in drm_hdmi_infoframe_set_hdr_metadata()
> but we don't check the metadata type.
>=20
> Maybe we should just nuke this EDID parsing stuff entirely? Seems
> pretty much pointless.

I've been thinking about that but we may need the rest of the fields as
well, even though they're not currently used. I'm referring to sink's
min/max luminance data. Shouldn't we also check min/max cll, besides
eotf, to make sure the source does not pass higher/lower luminance
values, than the sink supports, for optimal content rendering?

However, CTA-861 is not very clear on how a sink should behave if
the CLL values exceed the allowed range... :/ Also, if the CLL range or
the FALL values passed in the DRM infoframe exceed the sink's advertised
min/max values, I guess the sink cannot go lower/higher than it can
anyway. In which case, we don't really need the rest of the HDR static
metadata block and nuking that part should be ok.

Thanks,
laurentiu


>=20
> >
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > ---
> >  include/linux/hdmi.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> > index 9918a6c..216e25e 100644
> > --- a/include/linux/hdmi.h
> > +++ b/include/linux/hdmi.h
> > @@ -155,7 +155,7 @@ enum hdmi_content_type {
> >  };
> >
> >  enum hdmi_metadata_type {
> > -     HDMI_STATIC_METADATA_TYPE1 =3D 1,
> > +     HDMI_STATIC_METADATA_TYPE1 =3D 0,
> >  };
> >
> >  enum hdmi_eotf {
> > --
> > 2.7.4
>=20
> --
> Ville Syrj=E4l=E4
> Intel=
