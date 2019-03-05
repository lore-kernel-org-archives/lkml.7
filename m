Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6957C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880B220661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="quPJ5nEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCEQwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:52:13 -0500
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:9902
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfCEQwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ov/QaKtCzXvCp6grtvMJDfK2eE01yCymxTZr1e452kc=;
 b=quPJ5nEMWHOvEpkT1vhaejKmL+H9UNVV6fY9sDzQht5HzQMpb50d4gEixdba7FIiuE9/S/rUlZskv5zy6J+6XonJfKCSV48cVx3FwAeWtI0zRGX7xn51y1EODnEbBkdWj2eXNiqUSlLN/zbbOrmeeBMPUwx3aVAVqJYLeFX2zXQ=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2496.eurprd05.prod.outlook.com (10.168.136.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Tue, 5 Mar 2019 16:52:07 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 16:52:07 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Or Gerlitz <gerlitz.or@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: RE: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Topic: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Index: AQHUz/D0zHEkReNVsEa2RSWOI/Q4NKX3M+0AgAOlj4CAAXD1gIAA+7Ug
Date:   Tue, 5 Mar 2019 16:52:06 +0000
Message-ID: <VI1PR0501MB22718228FC8198C068EFC455D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
        <20190301120358.7970f0ad@cakuba.netronome.com>
        <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190304174551.2300b7bc@cakuba.netronome.com>
In-Reply-To: <20190304174551.2300b7bc@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edcba664-ac82-4382-f6fa-08d6a18ae6f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2496;
x-ms-traffictypediagnostic: VI1PR0501MB2496:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR0501MB2496;23:ZPddFJG9KEnlu8dV7/QeJ1W6S+w6ZNAOfjOHH+h?=
 =?us-ascii?Q?mc2mxlZsk2xVhgsLlag0Gbvvc6tf1GF2o9gbBc3FNGhdvg9vcIS38NcchTk1?=
 =?us-ascii?Q?BaZyJk2zz8DmguBcGfmcCBjzhBum74Ut61D2PWIxR8yU29DqH9Bf0lXVUTK1?=
 =?us-ascii?Q?upBMvAw+8ZBiIrpAz2yGc3TUo7n2im7/kiUOYodyVInYbBthT3NxNRAIsIgO?=
 =?us-ascii?Q?W9gbaWaMCPeHjd+MbaqXIy8fePeNynklouxnZNKDPH/KQL/XVd/nF1Yd+cQO?=
 =?us-ascii?Q?xSxCrfIM6pSTZRKDULYi0tQmerRC5hqgLTUChSN5VKopTliEJAWPl8/5RgbJ?=
 =?us-ascii?Q?pS/KXCatgIoJzMHjmhi/7MFHWsM9BQnTKxtaHBQmHHkDyYiKGclIYkgcqx/w?=
 =?us-ascii?Q?qztyKS+jedhaYqgsfdxhex8MPpWQkesDVTzdwYl5dgKhJYeo/3Hk2/QS6GrO?=
 =?us-ascii?Q?moWmJ+wLineH95Sdyl6j9i6Bv/DRI7IqPVigjaoy/r8+aQnbyE2L9rp0b7RW?=
 =?us-ascii?Q?buP6VWM3eENgkJEk4MUZ8fOzy9GZxFSlupkhJCRo1NiHVpQp6JkttTOxx2RN?=
 =?us-ascii?Q?/Xao9okGfZxJk0TAl9dn7VLoZiqCTmEnaAre9B3UiP9ZtlUMcsO1K6y3Pg/9?=
 =?us-ascii?Q?rHEUg31TrujmQvs6dBj5iRfQ75KSAxwwRjNd5aoMmRn6CGL/wWtP1knPUKU5?=
 =?us-ascii?Q?o+DxSJXXYtQE83e+5cs1Thc2laK/IiQ1ThlymXDUbuR0+RXk17+z8DVDFr5o?=
 =?us-ascii?Q?xHyVKpWFMk8x6qA5bXj9VU3Wj/YKC+AebeLLGV6xO06YxTB+esxX11vjKGoe?=
 =?us-ascii?Q?BYUErxQOMIJU7bej6RIeFKo8kvEyXEuL8PRzyjZqi7QZy8Rmvqei2izhGEgI?=
 =?us-ascii?Q?2+Ngo2NzGv06N3NvIK9mBc5fkVBMWq7tOe+k7J2FGfEeMhuz4OFPk42nTElJ?=
 =?us-ascii?Q?5O494i0TxxLIa4mTCZeIS0kbhuEQ/nBW1pffSB18+0FEdAJFd9IBhZ0nVQi/?=
 =?us-ascii?Q?tfxAK2L5s77yGm1ktSJShnQQ3kp0zqxJwYI/OZa3aJiT79QzKlLXP8hYa+hV?=
 =?us-ascii?Q?ulu2rQlY1w0TDFJqd4p8BwV5msdyY8QS+gYSq26McDhAu5nLZXaCp2TjmeGv?=
 =?us-ascii?Q?t7gq/Cg69YhFNNotg2dGF+tWnN1PgIfw+tvUziPCp2gSEUAAmkfvEPDfjA4m?=
 =?us-ascii?Q?zXjX/4sZeAIV3Om/VgHe1ByqAtLCb4bgM2Rg7HdElt/ka8qg2PM0xJGA/P7h?=
 =?us-ascii?Q?G61KPOsWfJiCx69avooV+PWrPBivrQRtHfUy+DLmo6uIloub2DdkQM4kONbD?=
 =?us-ascii?Q?rLwnCBS3by4na0nS5lYOoZvs=3D?=
x-microsoft-antispam-prvs: <VI1PR0501MB249672668B8AEDAE1DB5F85DD1720@VI1PR0501MB2496.eurprd05.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(366004)(199004)(189003)(13464003)(9686003)(55016002)(71200400001)(6916009)(71190400001)(97736004)(33656002)(25786009)(478600001)(3846002)(6116002)(2906002)(66066001)(14454004)(229853002)(86362001)(93886005)(305945005)(99286004)(81166006)(446003)(8676002)(102836004)(6506007)(53546011)(7736002)(11346002)(81156014)(6436002)(7696005)(476003)(8936002)(186003)(26005)(54906003)(107886003)(4326008)(5660300002)(52536013)(53936002)(14444005)(256004)(6246003)(74316002)(105586002)(106356001)(316002)(68736007)(76176011)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2496;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nMuRwrkB7+2+U5p83aUGjzyomkKXqVlyrLaQHpqKDye8O272/y//24zTXWD6St/wCTgDBJnNcZ0WHgbtl4qbCyRfS9vZZJ09so+gUtf86SAvHnHL1CkO+jnC+3hlrzoR1ne3eF1ww9VFoTchPGbBh1gfb67GJOccZHxr1lwtKfWWeQX0qcRbDHwtQjFVhAhdj0/5Y7V17xbhUa0N8pQonW8yehqd+LLBJlAlyLVwduyMK0D9Tr1gda/6bGhs3VGU0vC4jnmIWj6YqKNtcqIayQEF7c4xfymhkr9XBvd/aaDdVumZBp/MMr0pZOZQxJNTslrBklmNifKKPWy/d8UupONSFH5jIL4tFSIzbwiWpjibSzeBOf9I20XCsdesfWuTrmIjNu52krQvPsV2/nJVa3I+y0kfp1Eekxvq6SQmIvA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcba664-ac82-4382-f6fa-08d6a18ae6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 16:52:06.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> Sent: Monday, March 4, 2019 7:46 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: Or Gerlitz <gerlitz.or@gmail.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; michal.lkml@markovi.net; davem@davemloft.net;
> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>
> Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extens=
ion
>=20
> On Mon, 4 Mar 2019 04:41:01 +0000, Parav Pandit wrote:
> > > > $ devlink dev show
> > > > pci/0000:05:00.0
> > > > subdev/subdev0
> > >
> > > Please don't spawn devlink instances.  Devlink instance is supposed
> > > to represent an ASIC.  If we start spawning them willy nilly for
> > > whatever software construct we want to model the clarity of the
> > > ontology will suffer a lot.
> > Devlink devices not restricted to ASIC even though today it is
> > representing ASIC for one vendor. Today for one ASIC, it already
> > presents multiple devlink devices (128 or more) for PF and VFs, two
> > PFs on same ASIC etc. VF is just a sub-device which is well defined by
> > PCISIG, whereas sub-device is not. Sub-device do consume actual ASIC
> > resources (just like PFs and VFs), Hence point-(6) of cover-letter
> > indicate that the devlink capability to tell how many such sub-devices
> > can be created.
> >
> > In above example, they are created for a given bus-device following
> > existing devlink construct.
>=20
> No, it's not "representing the ASIC for one vendor".  It's how it works f=
or
> switches (including mlxsw) and how it was described in the original cover
> letter:
>=20
Sorry for the confusion.
I meant to say, my understanding is Netronome creates one devlink instance =
for whole ASIC.
Please correct me if this is incorrect.
mlx5_core driver creates multiple devlink devices for PF and VFs for one AS=
IC.

>     Introduce devlink interface and first drivers to use it
>=20
>     There a is need for some userspace API that would allow to expose thi=
ngs
>     that are not directly related to any device class like net_device of
>     ib_device, but rather chip-wide/switch-ASIC-wide stuff.
>=20
>     [...]
>=20
> We can deviate from the original intent if need be and dilute the ontolog=
y.
> But let's be clear on the status quo, please.
Status quo is mlx5_core driver creates multiple devlink devices. It creates=
 for devlink device for each PF and VF of a single ASIC.=20
