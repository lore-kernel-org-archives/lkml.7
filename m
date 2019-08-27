Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E143C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C59A206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="h7UktN/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfH0J3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:29:45 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9966 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0J3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:29:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d64f8060001>; Tue, 27 Aug 2019 02:29:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 02:29:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Aug 2019 02:29:42 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:29:42 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:29:42 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Aug 2019 09:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPk9/JbQ7lWAkNP2VGdRU2Zs2rxTYWPTuuyNGUiTO5u2fo+ZWp8XTmm6Dyw4A6IRihs2xcN6Hwi7MBODE0/dEDnYvXcBoFGgGQXSfztGLNogBcPyaVnPnX4FHw/LYvrNOv3mDowHOJzQz8EGZdcF33C3XrXByOv64nKvwU+0E8zyJPPWSfBSIBmklxsoKIAcQADVs+ZXfrOaLQ8+P3xbSXbE6N1EUm6vPBXF5oiXfQFuS6X7leBcTfDkkTc7l2dqTzQKiI/XTkNPsOWzlON0867bwDskaPocdY8TlOtqe3zIFRty/PjEGil1qSwaQr1stP+6YIVlue0kgMOPuW9LMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsMgSPEDUppyjIR+35o7fwfJ4AF3j1IDfiuEBB7sCs8=;
 b=lhGfBn5MZ29j4KWNRbm9Ag4TVcc2ekRhgmiBQwcK8q3kalMoMeVC7xo+UXSf4WqnRBJm2xHkUcqQ4rNwk49FxeBWLRs4oC3u3R0zgud4C/PmUhuJinIFyZuANn7k/ENsKT9b1QEibHTgguh6sFmnGgsIFnopmwXZJCYQmKTCKK9/VCW3Tkhz2ddOXtrFmtvtH4u1eJp0NzYfy2pVKWgwakj0+VO7+vpUt9LUdodfY2CQ56WVtR8tFnXrcxc3wHd/dqriZNiggUBeY4w0boEXLuggS8QXZcEl2x95NDWrzeLvTLE3783xn7Cb6A1f+TqvQ8ApLzjSI+KGQ7oRFsnbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) by
 SN6PR12MB2735.namprd12.prod.outlook.com (52.135.107.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:29:41 +0000
Received: from SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b]) by SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 09:29:41 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shardar Mohammed" <smohammed@nvidia.com>
Subject: RE: [PATCH 05/14] serial: tegra: flush the RX fifo on frame error
Thread-Topic: [PATCH 05/14] serial: tegra: flush the RX fifo on frame error
Thread-Index: AQHVUQEm5lWnubMr+kW2WrAo1IzlK6b41oYAgAFRhRA=
Date:   Tue, 27 Aug 2019 09:29:41 +0000
Message-ID: <SN6PR12MB2734D923E15A855CB1E2B7BEC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-6-git-send-email-kyarlagadda@nvidia.com>
 <20190813094832.GJ1137@ulmo>
In-Reply-To: <20190813094832.GJ1137@ulmo>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kyarlagadda@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-27T09:29:38.6891102Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=5d7b9d43-8e97-4eaf-a555-dcaeae1720f3;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kyarlagadda@nvidia.com; 
x-originating-ip: [115.114.118.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba6af884-b328-48f3-0ec8-08d72ad11688
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2735;
x-ms-traffictypediagnostic: SN6PR12MB2735:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27354A25EC22D0CA5416EF8AC3A00@SN6PR12MB2735.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(43544003)(13464003)(66066001)(316002)(81156014)(53546011)(6506007)(81166006)(8936002)(55236004)(6436002)(76116006)(107886003)(8676002)(33656002)(6246003)(55016002)(7736002)(305945005)(76176011)(52536014)(71200400001)(4326008)(53936002)(66446008)(64756008)(66556008)(66476007)(7696005)(6116002)(3846002)(66946007)(2906002)(486006)(476003)(9686003)(446003)(229853002)(14454004)(26005)(102836004)(14444005)(256004)(86362001)(11346002)(99286004)(25786009)(71190400001)(6916009)(54906003)(74316002)(186003)(5660300002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2735;H:SN6PR12MB2734.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S+OLoDqAPFlnF/qvC75bJeTZE+Tp92n20VhXg1wZfZIHAjP42Ks9fIi09TAVBGhlKH9rO12GEMiPFVH2ek4iQ0gFztFRtFpW6u8msa8fxs0Pu9GXH+Pzi5dMMVHVcuovfcxkHI4poNHUvOoZONWhZHi5C2h83kIkHE6lo3MvTG2gTGH36qE6qIvwibIOrV7jOratYmCSO8uTd+JEyKaxehorVol0iqUq9F8VwDhOjrPCh4xi9JaBXVGm+Q3Pkd3Q84zAVaCjZwu/NPooHiRPMJnQAqE22MASjHhYgYu51Oy5D/8PblP53jDS8Q3Yp0iP6ZJzZJ/gUBDJzNJIf5r+yssVWrSn2TGl1zzXOaXtc/EmXSPhWur+dXzLCCRcgZdahBBiyuHpia6htnt30JqucNGSNNcczTVcqq1T76AsmMk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6af884-b328-48f3-0ec8-08d72ad11688
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:29:41.0301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obua9cpm5Pz/KkFEk3pRLLBqFdj0a2acJ09JraeiktrZA0nK7tp17k1U8tcC2CgVL7vuPzVuzfgPIdw470zzrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2735
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566898183; bh=XsMgSPEDUppyjIR+35o7fwfJ4AF3j1IDfiuEBB7sCs8=;
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
        b=h7UktN/DlPELnkq2i5yp1Q9ZACNTD4AOwjGWReubkE4gR0+piWHW3yTkAFiTs7II/
         Iv/W/np1K12Xur860MLU3RfqmQAArFxNY3smtMBvViu+vjPEjHZBrhvMfpZT/uFuuk
         LxGQ2WeNf37L3YjMGS+6oWXV6dsOUUvsBinYJOsqBx6dMqgnrbRlodSgslTnBiOoKE
         8RZ/dEgzj3ZPx6SYsWe5h/Xws3r1YEYuMHk1rp2/cRqn+x+mv6Ps7pbIk6WFGCyCBn
         KZnHkvohywzu3vlDcgqplHPR8M3nlv0urAFZw4vl9rG5B/nudkay/qKymmQ4/W9UPL
         QrzEt5zFOJ5tQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Tuesday, August 13, 2019 3:19 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Shardar Mohammed
> <smohammed@nvidia.com>
> Subject: Re: [PATCH 05/14] serial: tegra: flush the RX fifo on frame erro=
r
>=20
> On Mon, Aug 12, 2019 at 04:58:14PM +0530, Krishna Yarlagadda wrote:
> > From: Shardar Shariff Md <smohammed@nvidia.com>
> >
> > FIFO reset/flush code implemented now does not follow programming
> > guidelines. RTS line has to be turned off while flushing fifos to
> > avoid new transfers. Also check LSR bits UART_LSR_TEMT and
> UART_LSR_DR
> > to confirm fifos are flushed.
>=20
> You use inconsistent spelling for FIFO here.
Will fix in next version and take care of this in all patches

>=20
> > Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index ae7225c..f6a3f4e 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -266,6 +266,10 @@ static void tegra_uart_wait_sym_time(struct
> > tegra_uart_port *tup,  static void tegra_uart_fifo_reset(struct
> > tegra_uart_port *tup, u8 fcr_bits)  {
> >  	unsigned long fcr =3D tup->fcr_shadow;
> > +	unsigned int lsr, tmout =3D 10000;
> > +
> > +	if (tup->rts_active)
> > +		set_rts(tup, false);
> >
> >  	if (tup->cdata->allow_txfifo_reset_fifo_mode) {
> >  		fcr |=3D fcr_bits & (UART_FCR_CLEAR_RCVR |
> UART_FCR_CLEAR_XMIT); @@
> > -289,6 +293,17 @@ static void tegra_uart_fifo_reset(struct tegra_uart_p=
ort
> *tup, u8 fcr_bits)
> >  	 * to propagate, otherwise data could be lost.
> >  	 */
> >  	tegra_uart_wait_cycle_time(tup, 32);
> > +
> > +	do {
> > +		lsr =3D tegra_uart_read(tup, UART_LSR);
> > +		if (lsr | UART_LSR_TEMT)
> > +			if (!(lsr & UART_LSR_DR))
>=20
> Can't both of these go on the same line?
>=20
> Thierry
>=20
They can be. Will fix in next version
KY

> > +				break;
> > +		udelay(1);
> > +	} while (--tmout);
> > +
> > +	if (tup->rts_active)
> > +		set_rts(tup, true);
> >  }
> >
> >  static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned
> > int baud)
> > --
> > 2.7.4
> >
