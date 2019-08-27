Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4EBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF92921872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q1UgZvdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfH0J3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:29:36 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8256 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0J3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:29:36 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d64f7ff0000>; Tue, 27 Aug 2019 02:29:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 02:29:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 27 Aug 2019 02:29:33 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:29:33 +0000
Received: from HQMAIL110.nvidia.com (172.18.146.15) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:29:33 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 HQMAIL110.nvidia.com (172.18.146.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Aug 2019 09:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+k6lK+iUuAwrVPA2knAbADNoE6PAd7YGJlVGNGiJatBvr+krTr0bBTiBs597C3MJOMVMi1HjYjiFrme7OV756TCIAICOv+AK4FUGmbwzEKQPvgrIvz394jJ9tyZ645GDJDEgp+k1rKvGDAdhtqc26aDXROS73Zd0YoOYyyTgLvWtRAn8uGCpFxCxn+JuJpkY2Fz+0L+Ujv2HN8zKZNX3vd42Zop2ggSZOQK7zOWfY4YidvtlNXksh/TnMLEI/MdSkWV/5ems9Kfgd5eqmrXcFwxHIbU/6OwzpA1arfG+0bJn9FedpoqrirRfDeEikv1ZuU1Rq/xYaFwVQCS5R+KfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLOz2gFlQelo20KM8Qz7RIw9KX7/ORHYu+5eJbF9HkE=;
 b=FrpJZ4ksLqj5tCrhJJTupP566JC9Qh/qvyMxcl8APTADwtdS8qMzbNlWHclomJIv9CWlGqlTjAGcuZr5z1KP0qIo61zNXnc4MbqvjHm8QlRPFIKzCNujpDk/LD+66t0kXYa95J3mRlumut2FcHM40IlB8mqd8WzLknbwzJ8l2fgoK/MCSLd6NQ976Rj9D9KKkEoZwRWTrWZ/NWQd5yoIb2nH2gkq7+GRKT6JjmkskPtSt6x+7I6nPMzf/3P+VvqBKXykik9ek1Kq0/A5jhJAzqMer06Or3ZlGqVCVLm7wTng1Js1I+kdQaiYR5EprajtYcW2Bz4Q10RM4DPDOkRA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) by
 SN6PR12MB2735.namprd12.prod.outlook.com (52.135.107.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:29:31 +0000
Received: from SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b]) by SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 09:29:31 +0000
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
        Ahung Cheng <ahcheng@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>
Subject: RE: [PATCH 03/14] serial: tegra: avoid reg access when clk disabled
Thread-Topic: [PATCH 03/14] serial: tegra: avoid reg access when clk disabled
Thread-Index: AQHVUQEjJb7cbjvyq0SMWcw2NtXAS6b41cwAgBR+wGA=
Date:   Tue, 27 Aug 2019 09:29:31 +0000
Message-ID: <SN6PR12MB2734315A9D5DEB8EDE008D2DC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-4-git-send-email-kyarlagadda@nvidia.com>
 <20190813094556.GH1137@ulmo>
In-Reply-To: <20190813094556.GH1137@ulmo>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kyarlagadda@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-27T09:29:29.3630589Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=829eaedc-c73b-4585-b6be-42c0409cda47;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kyarlagadda@nvidia.com; 
x-originating-ip: [115.114.118.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68fe7563-5d0d-4a3e-74b1-08d72ad110f8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2735;
x-ms-traffictypediagnostic: SN6PR12MB2735:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2735FC8DAD992932DFC45ECAC3A00@SN6PR12MB2735.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(13464003)(66066001)(316002)(81156014)(53546011)(6506007)(81166006)(8936002)(55236004)(6436002)(76116006)(107886003)(8676002)(33656002)(6246003)(55016002)(7736002)(305945005)(76176011)(52536014)(71200400001)(4326008)(53936002)(66446008)(64756008)(66556008)(66476007)(7696005)(6116002)(3846002)(66946007)(2906002)(486006)(476003)(9686003)(446003)(229853002)(14454004)(26005)(102836004)(14444005)(256004)(86362001)(11346002)(99286004)(25786009)(71190400001)(6916009)(54906003)(74316002)(186003)(5660300002)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2735;H:SN6PR12MB2734.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qm+1Zxnc04DVmL4/SRuHKeigmbFo2VW+baZ0jPZcvNCnB0lrUGqj5ic7NsIcjAtr1jIs/diPQgeZ4cMlFpVMWEntY5qtNQta7yEmYwlewdW7Ju6djZh4nu5+wQ4DALXpJzlQX6bv3m78NcsTT/JFDl4ikjPDFYgDS4GEtvaU0/JEWoLhAxNxM77sB0Ab4+XHfV+7O/jlFCZ6lZXldku4bn8rDsjnE/sqKMuYqQ0/u6UaIwUh2jX/hvsPk/MIy5xnTexk5mdd59e51+k43+5tmiP/91N6GJJ7UN2HQgvlQkOPy491761sBFOMrOisVuia1gD95ysU4sna/mK5g8SQfkVgrUNi6kOYe9kXuOPxd44CflkpcwCbjWlOqzB+N55E3TS7x4pz8+/MeZntbFfB11ZolKnk7I/ATLX4Yrg1EEE=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fe7563-5d0d-4a3e-74b1-08d72ad110f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:29:31.6424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jr+2ilB43lCGztT3dPpubkH0ESTZAncSGSbK3+JJnQfz4ADROi4dy0KPNvs4GNI5Un6P/R9VV1Scf9/G6V8q4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2735
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566898175; bh=WLOz2gFlQelo20KM8Qz7RIw9KX7/ORHYu+5eJbF9HkE=;
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
        b=Q1UgZvdmIu3Q3PfAgLW7nIbFgDiLIur+5y68V+pEm9A+dHQ3qu/CFaXuY1mJXI8JZ
         wgWf4k+Z11M3K8BXWf9QliP91HIcbpiyiiMxAkw1Z8FcKxQckuBCL+PkKuuuqjHcUs
         X6RbbTEAYoTZd732AVOWEUTZSqBdKaFGsrl6mUlf7Uk5u+sSDk/QIu+fiA3l5gl5z+
         na5lTCcbx1+8fhGB2V8rN2K9F06qUOlNZtCo/I5ZEtMjywUKT362wAfXU/2Q6W5Pvw
         OQpjSk4PkKRxNZhBJBtUoP0Z4XBE+TrUOGiY1P0vMjnZKG0RfkkYPHkIff2xsPXLIk
         S/mAvB6JI4Npw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-tegra-owner@vger.kernel.org <linux-tegra-=20
> owner@vger.kernel.org> On Behalf Of Thierry Reding
> Sent: Tuesday, August 13, 2019 3:16 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;=20
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman=20
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-=20
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-=20
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Ahung Cheng=20
> <ahcheng@nvidia.com>; Shardar Mohammed <smohammed@nvidia.com>
> Subject: Re: [PATCH 03/14] serial: tegra: avoid reg access when clk=20
> disabled
>=20
> On Mon, Aug 12, 2019 at 04:58:12PM +0530, Krishna Yarlagadda wrote:
> > From: Ahung Cheng <ahcheng@nvidia.com>
> >
> > This avoids two race conditions from the UART shutdown sequence both=20
> > leading to 'Machine check error in AXI2APB' and kernel oops.
> >
> > One was that the clock was disabled before the DMA was terminated=20
> > making it possible for the DMA callbacks to be called after the=20
> > clock was disabled. These callbacks could write to the UART=20
> > registers causing timeout.
> >
> > The second was that the clock was disabled before the UART was=20
> > completely flagged as closed. This is done after the shutdown is=20
> > called and a new write could be started after the clock was disabled.
> > tegra_uart_start_pio_tx could be called causing timeout.
> >
> > Given that the baud rate is reset at the end of shutdown sequence,=20
> > this fix is to examine the baud rate to avoid register access from=20
> > both race conditions.
> >
> > Besides, terminate the DMA before disabling the clock.
> >
> > Signed-off-by: Ahung Cheng <ahcheng@nvidia.com>
> > Signed-off-by: Shardar Mohammed <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index 93d299e..d908465 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -126,6 +126,8 @@ struct tegra_uart_port {
> >
> >  static void tegra_uart_start_next_tx(struct tegra_uart_port *tup);=20
> > static int tegra_uart_start_rx_dma(struct tegra_uart_port *tup);
> > +static void tegra_uart_dma_channel_free(struct tegra_uart_port *tup,
> > +					bool dma_to_memory);
> >
> >  static inline unsigned long tegra_uart_read(struct tegra_uart_port *tu=
p,
> >  		unsigned long reg)
> > @@ -458,6 +460,9 @@ static void tegra_uart_start_next_tx(struct
> tegra_uart_port *tup)
> >  	unsigned long count;
> >  	struct circ_buf *xmit =3D &tup->uport.state->xmit;
> >
> > +	if (WARN_ON(!tup->current_baud))
> > +		return;
>=20
> Are the race conditions that you are describing something which can be=20
> triggered by the user? If so, it's not a good idea to use a WARN_ON,=20
> because that could lead to some userspace spamming the log with these,=20
> potentially on purpose.
>=20
> Thierry
>=20
These are triggered by user events. I will remove WARN_ON

 KY
> > +
> >  	tail =3D (unsigned long)&xmit->buf[xmit->tail];
> >  	count =3D CIRC_CNT_TO_END(xmit->head, xmit->tail,
> UART_XMIT_SIZE);
> >  	if (!count)
> > @@ -829,6 +834,12 @@ static void tegra_uart_hw_deinit(struct
> tegra_uart_port *tup)
> >  	tup->current_baud =3D 0;
> >  	spin_unlock_irqrestore(&tup->uport.lock, flags);
> >
> > +	tup->rx_in_progress =3D 0;
> > +	tup->tx_in_progress =3D 0;
> > +
> > +	tegra_uart_dma_channel_free(tup, true);
> > +	tegra_uart_dma_channel_free(tup, false);
> > +
> >  	clk_disable_unprepare(tup->uart_clk);
> >  }
> >
> > @@ -1066,12 +1077,6 @@ static void tegra_uart_shutdown(struct
> uart_port *u)
> >  	struct tegra_uart_port *tup =3D to_tegra_uport(u);
> >
> >  	tegra_uart_hw_deinit(tup);
> > -
> > -	tup->rx_in_progress =3D 0;
> > -	tup->tx_in_progress =3D 0;
> > -
> > -	tegra_uart_dma_channel_free(tup, true);
> > -	tegra_uart_dma_channel_free(tup, false);
> >  	free_irq(u->irq, tup);
> >  }
> >
> > --
> > 2.7.4
> >
