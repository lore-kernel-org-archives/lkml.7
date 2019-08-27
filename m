Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAACC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE6821872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gfV2hkVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfH0J30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:29:26 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8235 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0J3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:29:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d64f7f40000>; Tue, 27 Aug 2019 02:29:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 02:29:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Aug 2019 02:29:22 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:29:22 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:29:22 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.54) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Aug 2019 09:29:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzuZUZ0jzZRZaKgYCvysl4+24H0XxcgbR9m5KSllmq7CaP4wXRGP4/17iOX//k+62jT4i56HaluiWL5GHYbW9gQM0ruhnE8BbQ0DUAngkiL2RUCy8cPHFRxLc1IGNGDMqrYDO96YF0MFGMLp37/M06MsyvnHoFDREdvdsA2qYjKEOe12qmO/eik2vlAmmFtixYB+4VWqJ9N1qUkWtFPDffQEKfDlDRjlw1dD1IQwhB0D2zcv72C8d7ft8+vnZWR6C6++/ks3JMRmYJxJ0YItReks6YkbcGL8rX497lrt+Azf47TPP9iC0YRe3WVQHCfm1AqHHVMpsZrZl5iqntQL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRdUsNtJNiE0T3X7ALE1gMZxNXa1qEsqTeqqKuRhA1E=;
 b=MtFjF5Wc+3dNMaYogKgKJP1I0RFb1IMs3igy/95yoZ2n4SgI7bmK1Bd877AQBb59fSFglnOIp6DZGr1ZCWM4qmGbFX5+VraAE97gfqZByknqgd05s8gofwOverJwOpsuWC06jUYWTSUkErRlX2Cyz8xiRuGYsiL20hAnH2Ef6luRUxtCra6PAKMeBEYN6PaysgabMzlkeVEP8W06JUsGh9bQxcZfhikzHhDwDbb4PyJCoosuK4mG3xQ1BHjbhjxOE5/ADRK1OxjiRrJB25HyL8HTQY73D62Y7jn2bXQ1lV2SMzQhh+1rdRfgF3DTNjWxvJCDbKsoiUV9FwOYtDb/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) by
 SN6PR12MB2831.namprd12.prod.outlook.com (20.177.251.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:29:21 +0000
Received: from SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b]) by SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 09:29:21 +0000
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
Subject: RE: [PATCH 02/14] serial: tegra: add support to ignore read
Thread-Topic: [PATCH 02/14] serial: tegra: add support to ignore read
Thread-Index: AQHVUQEgJm8szYaGP0iCFvSf5iMeOKb41LwAgAFRxjA=
Date:   Tue, 27 Aug 2019 09:29:21 +0000
Message-ID: <SN6PR12MB2734D67C01A97D87D1735EDBC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-3-git-send-email-kyarlagadda@nvidia.com>
 <20190813094208.GG1137@ulmo>
In-Reply-To: <20190813094208.GG1137@ulmo>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kyarlagadda@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-27T09:29:17.7939215Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=00d1f8b6-0abb-42f9-916e-ed23295f9292;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kyarlagadda@nvidia.com; 
x-originating-ip: [115.114.118.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12cad3fc-49a7-4525-9077-08d72ad10aaf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2831;
x-ms-traffictypediagnostic: SN6PR12MB2831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2831D9C07408C0DD9B72A2B4C3A00@SN6PR12MB2831.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39850400004)(136003)(199004)(189003)(13464003)(486006)(86362001)(55016002)(76116006)(66476007)(66556008)(64756008)(66446008)(26005)(186003)(66946007)(229853002)(66066001)(478600001)(54906003)(81156014)(81166006)(8676002)(8936002)(102836004)(71200400001)(53546011)(7736002)(3846002)(14454004)(6116002)(305945005)(74316002)(71190400001)(25786009)(52536014)(4326008)(446003)(5660300002)(11346002)(6246003)(55236004)(107886003)(76176011)(6916009)(316002)(256004)(9686003)(2906002)(476003)(53936002)(7696005)(14444005)(6436002)(99286004)(6506007)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2831;H:SN6PR12MB2734.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Gj8G7Gk46Cy5E+Rt+rXlzdZEmby5WSyz6KATF41e5JQ1c1Bln6mBF1auluMEMFCJFwfBTlv6XKLUm5XRzD2jJweTnjJHKrEYnHzZq5sqem4TB6GsNXS4IDLR/JLSZl2eI5Q5zXrZLx5Q/h2si46hFfQGi7B6x8iB62eYx3v1WqddHnIwmEloEL+ExCP0o/5CktrjK89+35mS3ofs/c+Ga0bEWDtvKvZIjcCKzyWgj+j/n9BHFvcmp5jKchIRsgTzAykImlLgqCwf8HgALd3zwsjMXXV6sm2ztB6w3KTejGr/I1NAvKk7z0e2k/UzyZkG4b/hpigwPRyOKpPfEV1bUVQB9eidVbYyBvYTYrsFv/wJ/aqRKfEgBk37HRHvEsQcdkY7RvyXAoXuDBau/rmHhSlfgv1FdTXIut1QhNAEFg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cad3fc-49a7-4525-9077-08d72ad10aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:29:21.0654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHykuBD4vyEZsFZBP5nBPhBuMH1THFZlaZwkcPCRiiPc+BD1EJKacx2u9ORnjkdjLsWCsP0MDrNaOicnEf4nBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566898164; bh=YRdUsNtJNiE0T3X7ALE1gMZxNXa1qEsqTeqqKuRhA1E=;
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
        b=gfV2hkVCiDICWcBNi22TuccdKVIYin7mVx06JCkyIeFC1QWu88pmtm485qK64T6ao
         FF1rDTD6ErkqCFYE9yKo0ybuggN1hvTqCAr4grYINKqdpllzJX6ipHpBVURNZngDUJ
         3PeU4OrBeearV212XGw4HuUmfLleYlPCgOn8/yFNlxVJwBFblumiFkmjuGbecTMgno
         FbupFmKd5EucCMzbSOLwxXczleV1xaCZqgfv1jZbn7RH91RgbjRyLDwPHm+BR+4VMB
         fNBSwEIEStUWwKHMQ3DFsupeoDuhI22QN74U8ZNCxxWFOEOGQTvzsslSb08l8xGyTd
         CWhKUelf+sd+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-tegra-owner@vger.kernel.org <linux-tegra-
> owner@vger.kernel.org> On Behalf Of Thierry Reding
> Sent: Tuesday, August 13, 2019 3:12 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Shardar Mohammed
> <smohammed@nvidia.com>
> Subject: Re: [PATCH 02/14] serial: tegra: add support to ignore read
>=20
> On Mon, Aug 12, 2019 at 04:58:11PM +0530, Krishna Yarlagadda wrote:
> > From: Shardar Shariff Md <smohammed@nvidia.com>
> >
> > Add support to ignore read characters if CREAD flag is not set.
> >
> > Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index 19f4c24..93d299e 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -542,6 +542,9 @@ static void tegra_uart_handle_rx_pio(struct
> tegra_uart_port *tup,
> >  		ch =3D (unsigned char) tegra_uart_read(tup, UART_RX);
> >  		tup->uport.icount.rx++;
> >
> > +		if (tup->uport.ignore_status_mask & UART_LSR_DR)
> > +			continue;
> > +
> >  		if (!uart_handle_sysrq_char(&tup->uport, ch) && tty)
> >  			tty_insert_flip_char(tty, ch, flag);
>=20
> Is it a good idea to ignore even sysrq characters if CREAD is not set?
> According to termios, CREAD enables the receiver, so technically if it is=
n't set
> you can't even receive sysrq characters. But I don't know if there are an=
y
> rules regarding this.
>=20
> Is this the same way that other drivers work?
>=20
> Thierry
>=20
Looked into few drivers and sysrq characters are not ignored. This driver d=
oes
not support console driver. So this might not be needed.

KY
> >  	} while (1);
> > @@ -562,6 +565,10 @@ static void tegra_uart_copy_rx_to_tty(struct
> tegra_uart_port *tup,
> >  		dev_err(tup->uport.dev, "No tty port\n");
> >  		return;
> >  	}
> > +
> > +	if (tup->uport.ignore_status_mask & UART_LSR_DR)
> > +		return;
> > +
> >  	dma_sync_single_for_cpu(tup->uport.dev, tup->rx_dma_buf_phys,
> >  				TEGRA_UART_RX_DMA_BUFFER_SIZE,
> DMA_FROM_DEVICE);
> >  	copied =3D tty_insert_flip_string(tty, @@ -1190,6 +1197,11 @@ static
> > void tegra_uart_set_termios(struct uart_port *u,
> >  	tegra_uart_write(tup, tup->ier_shadow, UART_IER);
> >  	tegra_uart_read(tup, UART_IER);
> >
> > +	tup->uport.ignore_status_mask =3D 0;
> > +	/* Ignore all characters if CREAD is not set */
> > +	if ((termios->c_cflag & CREAD) =3D=3D 0)
> > +		tup->uport.ignore_status_mask |=3D UART_LSR_DR;
> > +
> >  	spin_unlock_irqrestore(&u->lock, flags);  }
> >
> > --
> > 2.7.4
> >
