Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96DDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D6E206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Es3ObDMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfH0J3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:29:55 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8284 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0J3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:29:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d64f8120000>; Tue, 27 Aug 2019 02:29:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 02:29:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Aug 2019 02:29:52 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:29:50 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.51) by
 HQMAIL110.nvidia.com (172.18.146.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Aug 2019 09:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ8262kWR5B6kdjXcu3RI/xXzC1jnqQIVDshY7hUywAann00KFElHm64wvuw8bqqUzFHIykhHsOXBcjpvU6Cf8AhPHEt79rFlrNBunh207tWYqYJmQ7iqntteEWG3CAHA8y/2e3RE+nHW+XOhH797PYFPmmhqYufVZp6ECj4gocOkEsgaXQl3J5y21g4tApee2GVXN4D+ZM6TyaMAUq0HZ5ewG/+7x5Syu5z32BCBFqpnQNxS5YF/lgMV7iSEDUWfVVncbCImDsQ+j4WmYsBNKKZOn4BVMUQ+/rXr8rlOccLvP0cW4yCAAqiT5ynQsprADeJh3jkjNvj8nae7zK9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuIoD16g8L/0bKPFTctTXcz/4CBIZjVONxhnyclUXgM=;
 b=Gn0N5VCS367KUUiS94dxpldI79/tCo8OhhCqCaJIvn0QebzowrGb141+CPHgKYh605IzYF0NAZ4Trs2xT0Jkp7Uuyb99zFRGHFeX5Y0mlYoou3vuUrSwremlGS+ZjBeAaj0Ws6+5dy1Aq/VgK6WJ19SqReDYGip61SwOhofL5L55KbcqHB25UKiibf4imnE0Lh79v5Y+9UqSgRVqWrOOwDDjN3RNcNWHDgNqziPU0F1x/JYEP8NcCmTgrjoDbRUQQyDNPXK0ppaJYGgV6UjR98oBFgD/NbMCxgeQTUWViKA9ULPjU7htV45sk+qIr5xVKfcBrDRK4SplW2+yCNKtYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) by
 SN6PR12MB2735.namprd12.prod.outlook.com (52.135.107.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:29:49 +0000
Received: from SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b]) by SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 09:29:49 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 07/14] serial: tegra: add compatible for new chips
Thread-Topic: [PATCH 07/14] serial: tegra: add compatible for new chips
Thread-Index: AQHVUQEwcq9Z/DTwI06B+FLQ/b6oN6b42HmAgAGMJkA=
Date:   Tue, 27 Aug 2019 09:29:48 +0000
Message-ID: <SN6PR12MB27347E57CCA735DB36A49E73C3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-8-git-send-email-kyarlagadda@nvidia.com>
 <20190813095531.GL1137@ulmo>
In-Reply-To: <20190813095531.GL1137@ulmo>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kyarlagadda@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-27T09:29:46.6007063Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=3af05ec4-dac5-42a8-bb1c-3d414e20b0b7;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kyarlagadda@nvidia.com; 
x-originating-ip: [115.114.118.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 033a431a-b740-4c8c-ad77-08d72ad11b55
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2735;
x-ms-traffictypediagnostic: SN6PR12MB2735:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27359C88027906BF30A20B40C3A00@SN6PR12MB2735.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(13464003)(66066001)(316002)(81156014)(53546011)(6506007)(81166006)(8936002)(55236004)(6436002)(76116006)(8676002)(33656002)(6246003)(55016002)(7736002)(305945005)(76176011)(52536014)(71200400001)(4326008)(53936002)(66446008)(64756008)(66556008)(66476007)(7696005)(6116002)(3846002)(66946007)(2906002)(486006)(476003)(9686003)(446003)(229853002)(14454004)(26005)(102836004)(14444005)(256004)(86362001)(11346002)(99286004)(25786009)(71190400001)(6916009)(54906003)(74316002)(186003)(5660300002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2735;H:SN6PR12MB2734.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uArgHP2KhdztOvCSW/xrvItYFmbz3FvXbRk1/HOWcngLDXMJ93j35y2EOeXgHsdxKVkUNvVY+enxLZLawGdyLeMhxPD/4cFyFdLgsfZPIW3z3nOby7UJxNtJHDPMYTRpeyosFRZya8651cz3bAZ1Ss3IrGlh6nX5tUzLAxtwD9dbVZfMYN+xPA0BA6+61fqqmlawV3In3J7oUTlcixzgqVtoACAsB/0+eKqzPhGRY2genG8bZg6bPiNQnI90UtsrSRayk5xzR0zkeFjliTVoTBuGI+k4jnBCFr3eBw6ZhCdXdy7rlAA47BPFiSP6nejmoOd+ZcldbE3botR7HnTH0M3pOboZ+9+gwH5Qd7/G6UWbDPNljxnu9Ki62wcTRa2DJFLX/bWLmVeroQ2zRpwodP6V/g39Wb7+t2c98/nSQ5s=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 033a431a-b740-4c8c-ad77-08d72ad11b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:29:49.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 549rg5gPxM1BJ0R1mB/szaDw9eTW9CxwsQeHQZ3gW4a3nmJ2fRd2Mp9MQBXoduycFnowLVNtQ2awFz5jPZl7aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2735
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566898194; bh=cuIoD16g8L/0bKPFTctTXcz/4CBIZjVONxhnyclUXgM=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=Es3ObDMqc7CEohbci4wstMGteqVy6KQfYmfmzMqGkpRRfjYhPB77zjUOvvM9zDI7H
         531Ks9DPHHXhNFMVlsbv9jmO1m0o19JlU/jU/DrTc6hB3GPuKe7EjljgIxrDwtillH
         RumtiVwNJ92/yKw1O+NAjsyuz6LE8eDOiAMkXsg4yD0IuyGVsbuGzgo9GcoQuMMMHS
         kuDxpg+g3SXCFf+n+WFiE330SXHPm/CWH86bHeW9q5naMOuS0ElSQpD/NYLoYsElLG
         IZ7/FPAEvKUl+VX5trtlEMR/XGXUfFB934iTpUpMPCKgXXz/Uy9Nve9ekz/ro0DmWS
         lmqa7FtMbSN5w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Tuesday, August 13, 2019 3:26 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 07/14] serial: tegra: add compatible for new chips
>=20
> On Mon, Aug 12, 2019 at 04:58:16PM +0530, Krishna Yarlagadda wrote:
> > Add new compatible string for Tegra186. It differs from earlier chips
> > as it has fifo mode enable check and 8 byte dma buffer.
> > Add new compatible string for Tegra194. Tegra194 has different error
> > tolerance levels for baud rate compared to older chips.
> >
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt |
> > 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> I think device tree binding patches are supposed to start with
> "dt-binding: ...".
>=20
> Also: "fifo" -> "FIFO" and "dma" -> "DMA" in the commit message.
>=20
> >
> > diff --git
> > a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > index d7edf73..187ec78 100644
> > ---
> > a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.t
> > +++ xt
> > @@ -1,7 +1,8 @@
> >  NVIDIA Tegra20/Tegra30 high speed (DMA based) UART controller driver.
> >
> >  Required properties:
> > -- compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsua=
rt".
> > +- compatible : should be "nvidia,tegra30-hsuart",
> > +"nvidia,tegra20-hsuart",
> > +  nvidia,tegra186-hsuart, nvidia,tegra194-hsuart.
>=20
> Please use quotes around the compatible strings like the existing ones.
> Also, I think it might be better to list these explicitly rather than jus=
t give a list
> of potential values. As it is right now, it's impossible to tell whether =
this is
> meant to say "should be all of these"
> or whether it is meant to say "should be one of these".
>=20
> Thierry
>=20
Will update in next version.
KY
> >  - reg: Should contain UART controller registers location and length.
> >  - interrupts: Should contain UART controller interrupts.
> >  - clocks: Must contain one entry, for the module clock.
> > --
> > 2.7.4
> >
