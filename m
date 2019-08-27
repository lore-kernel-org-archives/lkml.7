Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B649DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6657B22CBB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rDrXTRNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfH0Je5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:34:57 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:45626 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfH0Je5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:34:57 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 05:34:51 EDT
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d64f80c0000>; Tue, 27 Aug 2019 17:29:48 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 02:29:48 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 27 Aug 2019 02:29:48 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:29:48 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.58) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Aug 2019 09:29:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITgeWmea3NloFzhOiJbE7K/lrQMDGZ0J8SU5qgSBbWRAES3dyMyWxRDxSHwZWAI4Nhr/uLsEQlCYnvRfDBd46nynce9LXTklH7eQIO1d4pbpYYA/Cp08LK0Pq/+p/LtB3m5BpdKXnzWrTe1isselbh33z5/cFbbuc//ZnszX5vusnqPIKOGyMur1pPCdfHzHX+KTbjO3M8r9YGWP9U3otGwQhi2b+IOt0+pQ3BIfOsH2U6NgMCtYQYw87BWUXQ9GwdjGEwJmSGItq8xGp3ikpPh30kAmR3mW/2xN58xbyrKu1CKpWV940/V0+h2mA44NlIN3Vqx3ltyUAbDJJ2n/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlc7MWw9TYCcSMnSZFcl6BE+8L3SABKiXC4xbsUR20c=;
 b=CDjAy+Hzx4RnLBJCrl4Dhv+QAaBKzm0cmpHXUbtbkcybBJixuvGFFVQW9UH5PeGYy3DdCvaoEnObUIz6m/ftk6RtyjgLS1beNVXIMIZH6c29KxnVu5VMKusZ+lth8JTStJJQZfVN/zxF9v0teLOYLTheyd03gDnaPedoATul+vru8zFfPvD2JP/7CgJWx1J29P/NphPEIFY1j8YTmQWIXqOnG2xNUIZHnogHh0C990DcWWPIyYZeqFvvXA0oLaHzi9cR1BRGpcZZzlthsvmcubsTPDn7IjrSGYE+ugBD4AuIonxgFisNhyCmq6PxjKpwzdT94jBZ+fk9eOn82klgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) by
 SN6PR12MB2735.namprd12.prod.outlook.com (52.135.107.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:29:45 +0000
Received: from SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b]) by SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 09:29:45 +0000
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
Subject: RE: [PATCH 06/14] serial: tegra: report error to upper tty layer
Thread-Topic: [PATCH 06/14] serial: tegra: report error to upper tty layer
Thread-Index: AQHVUQEqfTTbSTW4q0arX4dnR5PFJab415WAgBR90GA=
Date:   Tue, 27 Aug 2019 09:29:44 +0000
Message-ID: <SN6PR12MB273439430F80C358B6DB663DC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-7-git-send-email-kyarlagadda@nvidia.com>
 <20190813095219.GK1137@ulmo>
In-Reply-To: <20190813095219.GK1137@ulmo>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kyarlagadda@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-27T09:29:42.6676231Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=00648074-c093-4c87-af86-2c5fc4022455;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kyarlagadda@nvidia.com; 
x-originating-ip: [115.114.118.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d25bbb03-4173-4e25-dfe5-08d72ad11933
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2735;
x-ms-traffictypediagnostic: SN6PR12MB2735:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2735D2981E327CE514521EA0C3A00@SN6PR12MB2735.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(13464003)(66066001)(316002)(81156014)(53546011)(6506007)(81166006)(8936002)(55236004)(6436002)(76116006)(107886003)(8676002)(33656002)(6246003)(55016002)(7736002)(305945005)(76176011)(52536014)(71200400001)(4326008)(53936002)(66446008)(64756008)(66556008)(66476007)(7696005)(6116002)(3846002)(66946007)(2906002)(486006)(476003)(9686003)(446003)(229853002)(14454004)(26005)(102836004)(14444005)(256004)(86362001)(11346002)(99286004)(25786009)(71190400001)(6916009)(54906003)(74316002)(186003)(5660300002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2735;H:SN6PR12MB2734.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7PH32JIlQUcw5wMXaArGkAYTU6xm/0gpWUGp3dabdr4Nw0ndMT9e0LYWcS+Vc6xgeJA086uD5hyc2q+WeDzybRYGnw0n9ioPn7Cm5a5E0//DM/4AjHiAKo7At/Dja6PHwB3u+CIuW9/n4/KM1Qy32964QctY0oajs4GtJUwu+pNNFLUYTzgfSIJCJKPDJwRUCZULzcS6o7sY5Y/SmubE+vLqdH62bdikS6Lrl255tPq0yuhVyYm+dzLupH+FaQ0+4tZrwy3gcR5wGRMAdGsdP38SeUjVfnSpM+KPy0cDQ/LmMCxm4CMWZU+kSsNHS5JsBwNnsflPnQXyfsO77AVBwuPmqzm1XZoy1BQnB3/ptWOGmCZwwKYuiBj0BhQco19Zn19VGi1ueQ8n0lfSRWA8Pj4uJjFAPDzgboq9oviaVTM=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d25bbb03-4173-4e25-dfe5-08d72ad11933
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:29:45.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqNt0XMWK25zxMA7HXy9ffuT/ztNV3beEMJKUS01ycolANlgGmSdtF/4z+0kYBsPRCu57v5jnLNSkv5zbs7OGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2735
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566898188; bh=wlc7MWw9TYCcSMnSZFcl6BE+8L3SABKiXC4xbsUR20c=;
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
        b=rDrXTRNs/vog1LyUBKopDLeQsj9r7aAV6ZGGlZuxqLSH8LEzvxsSTujzz7pFFW3gk
         6G0n//FAI7xyxE854Ukm+9ceAALj7kxcCl/Tg5KMNcqzXka7N0luUSzKAK8BvDbx6x
         qnXlAUyCt6lahx4Y7nTHeJjU/nbCTWs1FHfPMnU56cahNMDSwPZ2lBuHYKGh9dNZGY
         aW/wjkaaQiPYZUn5LQPFg58TwqhMm46KJAJUmogxDKlu1CFIJn561vuIwzybpsGRmU
         ZdmzIq0n7K0SDMQknaVEqb1F8GvKXS2pFy00IJf4lR0M6N10PaZQnPuYUg1YNin0bn
         z+/SdxqIamWAQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Tuesday, August 13, 2019 3:22 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;=20
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman=20
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-=20
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-=20
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Shardar Mohammed=20
> <smohammed@nvidia.com>
> Subject: Re: [PATCH 06/14] serial: tegra: report error to upper tty=20
> layer
>=20
> On Mon, Aug 12, 2019 at 04:58:15PM +0530, Krishna Yarlagadda wrote:
> > Report overrun/parity/frame/break errors to top tty layer. Add=20
> > support to ignore break character if IGNBRK is set.
> >
> > Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index f6a3f4e..7ab81bb 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -374,13 +374,21 @@ static char tegra_uart_decode_rx_error(struct
> tegra_uart_port *tup,
> >  			tup->uport.icount.frame++;
> >  			dev_err(tup->uport.dev, "Got frame errors\n");
> >  		} else if (lsr & UART_LSR_BI) {
> > -			dev_err(tup->uport.dev, "Got Break\n");
> > -			tup->uport.icount.brk++;
> > -			/* If FIFO read error without any data, reset Rx FIFO
> */
> > +			/*
> > +			 * Break error
> > +			 * If FIFO read error without any data, reset Rx FIFO
> > +			 */
> >  			if (!(lsr & UART_LSR_DR) && (lsr & UART_LSR_FIFOE))
> >  				tegra_uart_fifo_reset(tup,
> UART_FCR_CLEAR_RCVR);
> > +			if (tup->uport.ignore_status_mask & UART_LSR_BI)
> > +				return TTY_BREAK;
> > +			flag =3D TTY_BREAK;
> > +			tup->uport.icount.brk++;
> > +			dev_err(tup->uport.dev, "Got Break\n");
>=20
> I know this is preexisting, but why do we want to output an error=20
> message in these cases. Isn't it perfectly legal for this to happen?
>=20
> Thierry
>=20
It is valid to have breaks for sysrq requests. But they also indicate possi=
ble mismatch in baud rate. So warning user as this could be potential issue=
. I will change this to dev_dbg to avoid spamming user in valid cases.

KY
> >  		}
> > +		uart_insert_char(&tup->uport, lsr, UART_LSR_OE, 0, flag);
> >  	}
> > +
> >  	return flag;
> >  }
> >
> > @@ -562,6 +570,9 @@ static void tegra_uart_handle_rx_pio(struct
> tegra_uart_port *tup,
> >  			break;
> >
> >  		flag =3D tegra_uart_decode_rx_error(tup, lsr);
> > +		if (flag !=3D TTY_NORMAL)
> > +			continue;
> > +
> >  		ch =3D (unsigned char) tegra_uart_read(tup, UART_RX);
> >  		tup->uport.icount.rx++;
> >
> > @@ -1224,6 +1235,8 @@ static void tegra_uart_set_termios(struct
> uart_port *u,
> >  	/* Ignore all characters if CREAD is not set */
> >  	if ((termios->c_cflag & CREAD) =3D=3D 0)
> >  		tup->uport.ignore_status_mask |=3D UART_LSR_DR;
> > +	if (termios->c_iflag & IGNBRK)
> > +		tup->uport.ignore_status_mask |=3D UART_LSR_BI;
> >
> >  	spin_unlock_irqrestore(&u->lock, flags);  }
> > --
> > 2.7.4
> >
