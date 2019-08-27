Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEF8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEEB21872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F2lhp+Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfH0JfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:35:13 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:1393 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfH0JfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:35:12 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d64f8150000>; Tue, 27 Aug 2019 17:29:57 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 02:29:56 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 27 Aug 2019 02:29:56 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:29:55 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.55) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Aug 2019 09:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N84Hu9yxeSO9jeIO7youy9VUg2k1uXP18Rhyebs05Fs3YA4ndGhCmIzbBwuEAktqiR3S4mFzDVkJ3jMkMQ+/1tcb84KKVX8Y9zbuahcJ8lYIG6OowiUK0l4guVSLu1OyfKheh3HOMdoZuxjpnNJYihYuEmPwHHyz6WTXpIrCBA5SZ39vizF0IusxVZuwurBdaDCtcGLnLi3GKnoGqgcUwaeKVoN7SmCZLQUZRcM78GIf9RZWKiJuafFBM+GKCNwQIl7nOm5/SfBj6rOUxSFl8WXTGIfbjC727/KE9V6wUOVvhy7QS3gSX5YvDeq3qT9DnCxXeKPFL4Ic4q3ZTC+/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kepMf0eleRPg0PqTPLbPapdIrQQ+skDhBifC/RPBVN4=;
 b=IErJvA782/MEF4nQJidbbrIT5LejwtoEoBf60f4lH8r299lnvzXk5U5GXlsM8FobYza9uqbFUR4rGNU4DqS3DRlkdA8i6P+4iLmWT+En98VOpYeh9fNMl6GJRRt9jvp/950EAehJwr9mhugoA5+6pYQNix2EnW4rBTUlRQr6wYysfqky9CUeDbVZHUlJd2BzqUlp2MpwGd6n1RxfijR0lrY+mphyspM6mJsM51XQ3hgJBogor6mjqQ2naPo9oJrqklw3g7ZBpz+PktHFejJoHavYG4WvzuIRL2wmqKML/TnGwkCyfJBNrdqlaeVnudyN1ossDnmsQIydGERLUmpF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) by
 SN6PR12MB2735.namprd12.prod.outlook.com (52.135.107.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:29:53 +0000
Received: from SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b]) by SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 09:29:53 +0000
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
Subject: RE: [PATCH 08/14] serial: tegra: check for FIFO mode enabled status
Thread-Topic: [PATCH 08/14] serial: tegra: check for FIFO mode enabled status
Thread-Index: AQHVUQEx09CaGjhYM0aBv+3E/hF1S6b42tWAgAGTJZA=
Date:   Tue, 27 Aug 2019 09:29:53 +0000
Message-ID: <SN6PR12MB273448A314407D72A764D76EC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-9-git-send-email-kyarlagadda@nvidia.com>
 <20190813100357.GM1137@ulmo>
In-Reply-To: <20190813100357.GM1137@ulmo>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kyarlagadda@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-27T09:29:50.9770192Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=25629056-bf69-47f2-891d-41d271cc6f6b;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kyarlagadda@nvidia.com; 
x-originating-ip: [115.114.118.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 633a47fa-3b6a-421d-e583-08d72ad11dd3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2735;
x-ms-traffictypediagnostic: SN6PR12MB2735:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB273561B405D9392117B08680C3A00@SN6PR12MB2735.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(13464003)(66066001)(316002)(81156014)(53546011)(6506007)(81166006)(8936002)(55236004)(6436002)(76116006)(107886003)(8676002)(33656002)(6246003)(55016002)(7736002)(305945005)(76176011)(52536014)(71200400001)(4326008)(53936002)(66446008)(64756008)(66556008)(66476007)(7696005)(6116002)(3846002)(66946007)(2906002)(486006)(476003)(9686003)(446003)(229853002)(14454004)(26005)(102836004)(256004)(86362001)(11346002)(99286004)(25786009)(71190400001)(6916009)(54906003)(74316002)(186003)(5660300002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2735;H:SN6PR12MB2734.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FinSitTAUEWk/7Ocnrxo1zNihlekH6/SFoLL3IRK27XRWRoC9dMu5VgdhEQ0HeWq1YodrklTkEQXNxSkqiTO5qRlgNUbODwKAwQCOLaSrr7t5YNDL31Q8A9RKpV3983cJrb37dOC5Ig8acNpqri4lRMpM2EI710L3nbymsTVGcrZSjsi9y1CNhRvh7tPEMuzQt8xX0ANiwwekbOxnyIQAwFPHILA1fuMfPtBw7xOH0QFx4ob3VTYeZo2PmmEjIr3T/Z6r8TmNXyzZ5nH7b/5iZKucODpYtJnZ3o5KcaTF1lUabW0KPNdvqgLiz/KZOlp5Hq3egk+G9ulJTlTEVgIW4cs1LKVsGB72vDpsq3DvIFTipSMfihHB273WggXA5IZprprFz9hol0dW+xa7P2eq7SlEt/e1QHuBXg+fnLTM7c=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 633a47fa-3b6a-421d-e583-08d72ad11dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:29:53.2042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrHptL4Nl5J3G4VXn0NKchiiFD6Qv98ZjbYQtIQQ+/PkHMuu2yORWVK+a3X5fIV0STmssAfR7GeXbZ//+Y5vhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2735
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566898197; bh=kepMf0eleRPg0PqTPLbPapdIrQQ+skDhBifC/RPBVN4=;
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
        b=F2lhp+Qrw1NBCpSfL2FNBQcVvc+wjVvbAH9iguJoQCELVapam5uDcDEQhGkwDEnr6
         JOXz6sb/YHD724xunZIHvt29ET9fsQueWJb8GLxbiMyYNjP6TVVuFof/z51is5RMmu
         3Rk7mp7fKvYeYlSR7psKTosTM2T3gflTlFDlFMEXERCdPSTzizq0bYked7oNhyhqzU
         faDUkcxaSsL/EcopRbbnzFlftwIZ8r9KSAjfkCdw6iJcU00yqG7Ft3Zca5M4113lDe
         3B2HsgXvLugt+jJcfGgWvp7aCLqVGBYA2NseLyUqe8YtNxGJARr+ONZy31Qm6nIMxw
         0N1UJPkenZ+Zw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-tegra-owner@vger.kernel.org <linux-tegra-
> owner@vger.kernel.org> On Behalf Of Thierry Reding
> Sent: Tuesday, August 13, 2019 3:34 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Shardar Mohammed
> <smohammed@nvidia.com>
> Subject: Re: [PATCH 08/14] serial: tegra: check for FIFO mode enabled sta=
tus
>=20
> On Mon, Aug 12, 2019 at 04:58:17PM +0530, Krishna Yarlagadda wrote:
> > Chips prior to Tegra186 needed delay of 3 UART clock cycles to avoid
> > data loss. This issue is fixed in Tegra186 and a new flag is added to
> > check if fifo mode is enabled. chip data updated to check if this flag
> > is available for a chip. Tegra186 has new compatible to enable this
> > flag.
> >
> > Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 52
> > ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 46 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index 7ab81bb..e0379d9 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -72,6 +72,8 @@
> >  #define TEGRA_TX_PIO				1
> >  #define TEGRA_TX_DMA				2
> >
> > +#define TEGRA_UART_FCR_IIR_FIFO_EN		0x40
> > +
> >  /**
> >   * tegra_uart_chip_data: SOC specific data.
> >   *
> > @@ -84,6 +86,7 @@ struct tegra_uart_chip_data {
> >  	bool	tx_fifo_full_status;
> >  	bool	allow_txfifo_reset_fifo_mode;
> >  	bool	support_clk_src_div;
> > +	bool	fifo_mode_enable_status;
> >  };
> >
> >  struct tegra_uart_port {
> > @@ -263,6 +266,22 @@ static void tegra_uart_wait_sym_time(struct
> tegra_uart_port *tup,
> >  			tup->current_baud));
> >  }
> >
> > +static int tegra_uart_is_fifo_mode_enabled(struct tegra_uart_port
> > +*tup)
>=20
> I think this is a bad name. "is" makes it sound like this will return a b=
oolean
> value. Also, this doesn't really check whether FIFO mode is enabled, but
> rather it waits for the FIFO mode to become enabled.
> Perhaps, then, a better name would be
>=20
> 	tegra_uart_wait_fifo_mode_enabled()
>=20
> ?
>=20
Sounds good. Will make changes

> > +{
> > +	unsigned long iir;
> > +	unsigned int tmout =3D 100;
> > +
> > +	do {
> > +		iir =3D tegra_uart_read(tup, UART_IIR);
> > +		if (iir & TEGRA_UART_FCR_IIR_FIFO_EN)
> > +			return 0;
> > +		udelay(1);
> > +	} while (--tmout);
> > +	dev_err(tup->uport.dev, "FIFO mode not enabled\n");
>=20
> I'd push this out to callers. That way this function becomes useful in
> situations where you don't want to output an error.
>=20
> > +
> > +	return -EIO;
>=20
> -ETIMEDOUT?
>=20
> Thierry
>=20
Will push this to caller and change the error code
KY
> > +}
> > +
> >  static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8
> > fcr_bits)  {
> >  	unsigned long fcr =3D tup->fcr_shadow; @@ -282,6 +301,8 @@ static
> void
> > tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
> >  		tegra_uart_write(tup, fcr, UART_FCR);
> >  		fcr |=3D UART_FCR_ENABLE_FIFO;
> >  		tegra_uart_write(tup, fcr, UART_FCR);
> > +		if (tup->cdata->fifo_mode_enable_status)
> > +			tegra_uart_is_fifo_mode_enabled(tup);
> >  	}
> >
> >  	/* Dummy read to ensure the write is posted */ @@ -918,12 +939,19
> @@
> > static int tegra_uart_hw_init(struct tegra_uart_port *tup)
> >  	/* Dummy read to ensure the write is posted */
> >  	tegra_uart_read(tup, UART_SCR);
> >
> > -	/*
> > -	 * For all tegra devices (up to t210), there is a hardware issue that
> > -	 * requires software to wait for 3 UART clock periods after enabling
> > -	 * the TX fifo, otherwise data could be lost.
> > -	 */
> > -	tegra_uart_wait_cycle_time(tup, 3);
> > +	if (tup->cdata->fifo_mode_enable_status) {
> > +		ret =3D tegra_uart_is_fifo_mode_enabled(tup);
> > +		if (ret < 0)
> > +			return ret;
> > +	} else {
> > +		/*
> > +		 * For all tegra devices (up to t210), there is a hardware
> > +		 * issue that requires software to wait for 3 UART clock
> > +		 * periods after enabling the TX fifo, otherwise data could
> > +		 * be lost.
> > +		 */
> > +		tegra_uart_wait_cycle_time(tup, 3);
> > +	}
> >
> >  	/*
> >  	 * Initialize the UART with default configuration @@ -1294,12
> > +1322,21 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data =
=3D
> {
> >  	.tx_fifo_full_status		=3D false,
> >  	.allow_txfifo_reset_fifo_mode	=3D true,
> >  	.support_clk_src_div		=3D false,
> > +	.fifo_mode_enable_status	=3D false,
> >  };
> >
> >  static struct tegra_uart_chip_data tegra30_uart_chip_data =3D {
> >  	.tx_fifo_full_status		=3D true,
> >  	.allow_txfifo_reset_fifo_mode	=3D false,
> >  	.support_clk_src_div		=3D true,
> > +	.fifo_mode_enable_status	=3D false,
> > +};
> > +
> > +static struct tegra_uart_chip_data tegra186_uart_chip_data =3D {
> > +	.tx_fifo_full_status		=3D true,
> > +	.allow_txfifo_reset_fifo_mode	=3D false,
> > +	.support_clk_src_div		=3D true,
> > +	.fifo_mode_enable_status	=3D true,
> >  };
> >
> >  static const struct of_device_id tegra_uart_of_match[] =3D { @@ -1310,=
6
> > +1347,9 @@ static const struct of_device_id tegra_uart_of_match[] =3D {
> >  		.compatible	=3D "nvidia,tegra20-hsuart",
> >  		.data		=3D &tegra20_uart_chip_data,
> >  	}, {
> > +		.compatible     =3D "nvidia,tegra186-hsuart",
> > +		.data		=3D &tegra186_uart_chip_data,
> > +	}, {
> >  	},
> >  };
> >  MODULE_DEVICE_TABLE(of, tegra_uart_of_match);
> > --
> > 2.7.4
> >
