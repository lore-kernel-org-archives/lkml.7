Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE7CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D16C233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QEF3Ee7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfH2Djp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 23:39:45 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:32992
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726128AbfH2Djo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:39:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWm30uEIySy0RnDNT4bQWlsV+ZceSEK/rEij/jCX7/rYS8xZt6rhaWSYE4JzsMT6JYS6BnX555tV3ljNptxT0V5gqajXHuklizDTGIGUzh3Cclj5Sfwaze2WUaJrto7+iEcu41Ll0f2FcHTyr89sJTk11/j52yuJiN2z5BZHsp84VFQd1pfkE1KuhUDAyKk3M6U3rtaCI1beQpjW/QCHFOaOZiOXZJ+W9pBJrSvllg2pk0gF82mQQUfshvA8r18Ws6dexL75vDNOsR1n3c84HJWWgRiLSIDv80cpgkXorMwfIckddqhxKOlb6amB+vQSShHi6cCXQzXgUjv7vhGUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTC498B4ERTCYtAeuJqf03nypQrIhQqNbfqhgESUlrk=;
 b=M9g9J19DapUoX7DwCinpoSaVIqklQjCD4AhBFyEq9Z1qcwdsuorZA9eYj8ZEDQRBAm5XdOZbEPPItJzAy5VPze88Kl1fBhqzNRwytMxLxOAGJ8fip3M/TbPm2dUGmPcsgf2E+TuSC/23a7nipK/4mzbCRK6NWvoMDFhlXqzG1TRtJs/SEwC5T6UBcci0xtxVP4YHEWobPrdvK49PUxWJrCnLBz8273QdRdgxs+XGHJrkQBO31prbVu9wiQt2pXcnotOJmiCLJ2RJwqUUSVcZd5aFMw646aXBkZuw1udnWZqIvMblKcyUbdIBb3gxAVB7IuOZoJZ6DgE+uHGp0GfDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTC498B4ERTCYtAeuJqf03nypQrIhQqNbfqhgESUlrk=;
 b=QEF3Ee7wUKKOG8L+3U4oJ21x9tkd0+jba++tGp9WLU2aHT4zvjuCF/5LpLEntlqaoPFqZuC/XFq+CqzfTDo/Zu5kFoOHArWxmorEFEvN7uziIZUVF9k488WLI/8ipJXwyQzJjV3dGQJU9QsUrsZyzphagc+7iFUmSA4OMy3wWoM=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5309.eurprd04.prod.outlook.com (20.177.52.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 29 Aug 2019 03:39:40 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::e039:172d:fe77:320a]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::e039:172d:fe77:320a%4]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 03:39:40 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Chuhong Yuan <hslester96@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: msm: Use device-managed registration API
Thread-Topic: [PATCH] usb: chipidea: msm: Use device-managed registration API
Thread-Index: AQHVQQMqCyiV6SBdkkOiu7Ig/zYETKcQHUkAgACMCwCAAQttgA==
Date:   Thu, 29 Aug 2019 03:39:40 +0000
Message-ID: <20190829033941.GA14460@b29397-desktop>
References: <20190723030206.2919-1-hslester96@gmail.com>
 <20190828032118.GA2966@b29397-desktop>
 <CANhBUQ0PEOoVoVscO66spy0Jv4jf5wwtGKRUwa4vd=7b70kBwA@mail.gmail.com>
In-Reply-To: <CANhBUQ0PEOoVoVscO66spy0Jv4jf5wwtGKRUwa4vd=7b70kBwA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f12e4617-cec0-445b-c25b-08d72c328624
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5309;
x-ms-traffictypediagnostic: VI1PR04MB5309:
x-microsoft-antispam-prvs: <VI1PR04MB53093B5FEBD3AB630B348DCD8BA20@VI1PR04MB5309.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(5660300002)(6246003)(305945005)(6436002)(81156014)(2906002)(8676002)(8936002)(3846002)(7736002)(6116002)(66066001)(76116006)(14454004)(66946007)(81166006)(91956017)(66446008)(66476007)(66556008)(64756008)(1411001)(478600001)(33656002)(33716001)(316002)(486006)(6916009)(54906003)(44832011)(11346002)(446003)(1076003)(229853002)(76176011)(99286004)(186003)(53546011)(102836004)(26005)(71190400001)(256004)(53936002)(6486002)(4326008)(71200400001)(6512007)(25786009)(6506007)(9686003)(476003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5309;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /+tPN4V07JgQRN7VgXv9dJ7BCPHKK3TvTpUqIcRFrZflqhfnSCMHB7cyVVD1l8lXFvUQ11s0Jpxgpw0/uX7vXy5gvCjWTzXj6hojP1DWAuP3BKCCmEGNT7BcacJtN4Gzq7ETCK/KIrCG5tUDZPRnTbdibO6BsmEujdbis5j6rz92MOfnGYgXj/K77EjeysObozQWQcG6TK6Gskeyz4MQqFvo+AvGJjPEO4tOqmV3WOjb/AZHzzXg5gHjBgY69scTWFAIaETCi5asgtvX4H7oUfALQaPBeQIVN7BUN67qCixrjBQqIUIsgXV4CXqKgp9hv+Pl4cHaFXJ4dNG+M7ufQUR4hEhSmF7/oy4UDgk2wlzVh3iYrzkXE7hiInM9JHHAtHJvs9AINMjTOjfR2HhS+1XgOk2CuQrupK/9EuDLnsI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <48AB56A5E5670F41B0BE6A17F1BFAEDE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12e4617-cec0-445b-c25b-08d72c328624
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 03:39:40.5858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJC0dj47BHhrBSSDWtn+MMH/D6etiDmeebXEiA3iqWm1m2MD6syqtbPofTISd2fhMv9WfcnKguVTXtUSqi6Iww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-08-28 19:42:32, Chuhong Yuan wrote:
> On Wed, Aug 28, 2019 at 11:24 AM Peter Chen <peter.chen@nxp.com> wrote:
> >
> > On 19-07-23 11:02:07, Chuhong Yuan wrote:
> > > Use devm_reset_controller_register to get rid
> > > of manual unregistration.
> > >
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > ---
> > >  drivers/usb/chipidea/ci_hdrc_msm.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipide=
a/ci_hdrc_msm.c
> > > index bb4645a8ca46..067542e84aea 100644
> > > --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> > > +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> > > @@ -216,7 +216,7 @@ static int ci_hdrc_msm_probe(struct platform_devi=
ce *pdev)
> > >       ci->rcdev.ops =3D &ci_hdrc_msm_reset_ops;
> > >       ci->rcdev.of_node =3D pdev->dev.of_node;
> > >       ci->rcdev.nr_resets =3D 2;
> > > -     ret =3D reset_controller_register(&ci->rcdev);
> > > +     ret =3D devm_reset_controller_register(&pdev->dev, &ci->rcdev);
> > >       if (ret)
> > >               return ret;
> > >
> > > @@ -272,7 +272,6 @@ static int ci_hdrc_msm_probe(struct platform_devi=
ce *pdev)
> > >  err_iface:
> > >       clk_disable_unprepare(ci->core_clk);
> > >  err_fs:
> > > -     reset_controller_unregister(&ci->rcdev);
> >
> > It is devm API, why the unregister needs to be called at
> > fail path?
> >
>=20
> I am not very clear about your problem...
> After using devm_reset_controller_register(), I have removed
> reset_controller_unregister() calls
> in this patch.
>=20

Sorry, my fault.

Your patch is ok, but try to clean up the label "err_fs" since
it is not needed.

Peter

> > Peter
> >
> > >       return ret;
> > >  }
> > >
> > > @@ -284,7 +283,6 @@ static int ci_hdrc_msm_remove(struct platform_dev=
ice *pdev)
> > >       ci_hdrc_remove_device(ci->ci);
> > >       clk_disable_unprepare(ci->iface_clk);
> > >       clk_disable_unprepare(ci->core_clk);
> > > -     reset_controller_unregister(&ci->rcdev);
> > >
> > >       return 0;
> > >  }
> > > --
> > > 2.20.1
> > >=
