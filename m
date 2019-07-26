Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB1C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823992238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="Evrxeprz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGZCmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 22:42:04 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:16888 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbfGZCmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:42:03 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6Q2Zjht029147;
        Thu, 25 Jul 2019 21:42:02 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2054.outbound.protection.outlook.com [104.47.38.54])
        by mx0a-00010702.pphosted.com with ESMTP id 2tx62hje76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 25 Jul 2019 21:42:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGeQ8vu6CfII3jURehLVlkd+VdLVvCNV4YT97Hcbvo8V9caFOxWeNcXAFxtzs2//W75ghCVxrW4gj8UWMtwB8Q5nr0i6/0v0eIx3sxfne61aXTqrsQlRWRLnWqJEMDpFHy3O2eZJF5NwfuKIwdN39SdCGhlPKkG2BkE/89dxUoJf8Ko6NX2/WZEXUFfETYHWZyC/dLMF12eTSMySlNmDccPe0X5aabw+aXubK4y8g5z8rNCcldbZovD4PO9JBrEGoy3dhG95SJWxFOXvpnQpFMjAEqey7Cfrrx8YY878yNzaCxZDEFdBUB/KgbXTyu3cw0F6zgLJ3Sp02s01Rw2MNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJbNOsrgQUL0paUTaMZ7mDSfeJbekc2sl+2GjIX5mqo=;
 b=HswTj1uwVTaR6yFsT3nTbrRRWeK8PlIl8me86KEjHAwelW8oX9M+jqLyegmUpCqtqQrT8DHPtkSrhFh3eVYyNrHCMuTsjo7yuX7ch1xDYdreBIrERqe4Z/76QsxKhYqTz6bWNo/f1bkKKqpVC+OiwDJekTplI7drWDjPMGDylbFxSfXS+WlUmmH3JBKond992pfGcrwbRfs1FO8wjO2x8sP5FnwXr5DyV0bHHFIcSIuXUTUR5j9Zb6OLIcHBgrelKoRM0BhxGsi2RbjtUDqCWMgJd9WBXw1ic8trmOM8KfqPLOIQ+Vz+11zn7HOKW9LX+iQGwUoNEilDWskdiadyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=ni.com;dmarc=pass action=none header.from=ni.com;dkim=pass
 header.d=ni.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJbNOsrgQUL0paUTaMZ7mDSfeJbekc2sl+2GjIX5mqo=;
 b=EvrxeprzrlaI3m/r7tHpi+U5JjcqcNZ5Mu6NU1h8C3QFWQJUO2vXC7Sn2A2rbwjjfgLhZAQGBNWdgqGm9toDR++kHqn3GR71w2bttQpclDPDt09NeI6d4PaokYzh5Np8NlZ/elpMqoG1lOgExlGBQZQzxJsEIqKYNh28aaCWV9I=
Received: from MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) by
 MN2PR04MB6926.namprd04.prod.outlook.com (10.186.146.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 02:41:58 +0000
Received: from MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::584f:77e7:16ee:ba8]) by MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::584f:77e7:16ee:ba8%7]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 02:41:58 +0000
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Thread-Index: AQHVMzO7Nq0dMI06ekypHaVreXXzVqbbPIwAgAEIImA=
Date:   Fri, 26 Jul 2019 02:41:58 +0000
Message-ID: <MN2PR04MB59204DF262EBDD75E9216F51B7C00@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190705131528.60752-1-je.yen.tam@ni.com>
 <20190725101234.GA7550@kroah.com>
In-Reply-To: <20190725101234.GA7550@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.74.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea8d6a8b-d8c9-424c-237e-08d71172d4ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB6926;
x-ms-traffictypediagnostic: MN2PR04MB6926:
x-microsoft-antispam-prvs: <MN2PR04MB6926C9C4254D057E96D55D3BB7C00@MN2PR04MB6926.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(14444005)(71200400001)(66556008)(5660300002)(66946007)(66476007)(14454004)(4326008)(229853002)(6506007)(102836004)(8936002)(26005)(71190400001)(6116002)(76116006)(52536014)(186003)(256004)(66446008)(54906003)(6916009)(64756008)(55016002)(316002)(81166006)(81156014)(76176011)(11346002)(68736007)(53936002)(7696005)(2906002)(7736002)(305945005)(8676002)(6246003)(74316002)(25786009)(6436002)(486006)(478600001)(446003)(33656002)(99286004)(66066001)(476003)(86362001)(9686003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6926;H:MN2PR04MB5920.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lGsQbM4yIxc38KdVsIQAzprAf1BHMRZEJa/HE+P5qSlrL5tnm4PHL1GCaE48cnW1JMbisctYBz1rOD2GhhhDQRMbkNLeY4gWBY63l+dzg+s91KYCLHqAg4BWmMAmaFwDThE9Vvh5LP1oiXcBWmN6Cxu5VHNw6+h5VYHxfQWB/YmcUOUCaqiNVMR10dcc5RnorCIat+0vIoyHazBQ8bDRH9xjWgHX5mlnqoWbUsa+EBMr3pBfKRPYuEBcGmhSeM4p7JHG1oIFNaQQg3DdlDly+VdwqY76JO7Me+9riCLj4KldlmBi2e15VezZ1Tz+cYIP7xykoY6y762mLOQspcRVA2wxEFTzQw+y0pFiyus8o5M05WCPvryjAfYSe2XO+onzWR/YSAGDFI3AgcrBEf9RSHmTSVKOb35qLHcTgvamjfU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8d6a8b-d8c9-424c-237e-08d71172d4ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 02:41:58.7090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je.yen.tam@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6926
Subject: RE: Re: [PATCH v4] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_01:2019-07-26,2019-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 clxscore=1015
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1907260033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [EXTERNAL] Re: [PATCH v4] serial/8250: Add support for NI-Serial
> PXI/PXIe+485 devices
>=20
> On Fri, Jul 05, 2019 at 06:15:28AM -0700, jeyentam wrote:
> > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> >
> > Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
> > ---
> > v3 -> v4:
> > - Add changes description.
> >
> > v2 -> v3:
> > - Add "full" name for author
> > - Use BIT() macro for bits definition
> > - Remove unnecessary WARN_ON()
> > - Change debugging interface to ftrace
> > - Fix indentation
> > - Add NI PXIe-RS232 and PXI/PXIe-RS485 device IDs #defines
> >
> > v1 -> v2:
> > - Fix unintended indentation
> >
> > v1:
> > - Add and rename #defines for 16550 UART Port Control Register
> > - Add configuration for RS485 port.
> > - Add device setup for NI PXI/PXIe-RS485 family.
> > - Add PCI board attributes for NI PXIe-RS232 and PXI/PXIe-RS485 devices=
.
> >
> >  drivers/tty/serial/8250/8250_pci.c | 298 ++++++++++++++++++++++++++++-
> >  1 file changed, 294 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
> > index df41397de478..23fe3b7197ad 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -730,8 +730,16 @@ static int pci_ni8430_init(struct pci_dev *dev)
> >  }
> >
> >  /* UART Port Control Register */
> > -#define NI8430_PORTCON	0x0f
> > -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
> > +#define NI16550_PCR_OFFSET	0x0f
> > +#define NI16550_PCR_RS422	0x00
> > +#define NI16550_PCR_ECHO_RS485	0x01
> > +#define NI16550_PCR_DTR_RS485	0x02
> > +#define NI16550_PCR_AUTO_RS485	0x03
> > +#define NI16550_PCR_WIRE_MODE_MASK	0x03
> > +#define NI16550_PCR_TXVR_ENABLE_BIT	BIT(3)
> > +#define NI16550_PCR_RS485_TERMINATION_BIT	BIT(6)
> > +#define NI16550_ACR_DTR_AUTO_DTR	(0x2 << 3)
> > +#define NI16550_ACR_DTR_MANUAL_DTR	(0x0 << 3)
> >
> >  static int
> >  pci_ni8430_setup(struct serial_private *priv,
> > @@ -753,14 +761,123 @@ pci_ni8430_setup(struct serial_private *priv,
> >  		return -ENOMEM;
> >
> >  	/* enable the transceiver */
> > -	writeb(readb(p + offset + NI8430_PORTCON) |
> NI8430_PORTCON_TXVR_ENABLE,
> > -	       p + offset + NI8430_PORTCON);
> > +	writeb(readb(p + offset + NI16550_PCR_OFFSET) |
> NI16550_PCR_TXVR_ENABLE_BIT,
> > +	       p + offset + NI16550_PCR_OFFSET);
> >
> >  	iounmap(p);
> >
> >  	return setup_port(priv, port, bar, offset, board->reg_shift);
> >  }
> >
> > +static int pci_ni8431_config_rs485(struct uart_port *port,
> > +	struct serial_rs485 *rs485)
> > +{
> > +	u8 pcr, acr;
> > +
> > +	struct uart_8250_port *up;
>=20
> No blank lines between variable definitions please.

Removed those lines in v5.

>=20
> > +
> > +	up =3D container_of(port, struct uart_8250_port, port);
> > +
> > +	acr =3D up->acr;
> > +
> > +	trace_printk("start ni16550_config_rs485\n");
>=20
> This line is not needed, right?

Removed in v5.

>=20
> > +
> > +	pcr =3D port->serial_in(port, NI16550_PCR_OFFSET);
> > +	pcr &=3D ~NI16550_PCR_WIRE_MODE_MASK;
> > +
> > +	if (rs485->flags & SER_RS485_ENABLED) {
> > +		/* RS-485 */
> > +		if ((rs485->flags & SER_RS485_RX_DURING_TX) &&
> > +			(rs485->flags & SER_RS485_RTS_ON_SEND)) {
> > +			dev_dbg(port->dev, "Invalid 2-wire mode\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (rs485->flags & SER_RS485_RX_DURING_TX) {
> > +			/* Echo */
> > +			dev_vdbg(port->dev, "2-wire DTR with echo\n");
> > +			pcr |=3D NI16550_PCR_ECHO_RS485;
> > +			acr |=3D NI16550_ACR_DTR_MANUAL_DTR;
> > +		} else {
> > +			/* Auto or DTR */
> > +			if (rs485->flags & SER_RS485_RTS_ON_SEND) {
> > +				/* Auto */
> > +				dev_vdbg(port->dev, "2-wire Auto\n");
> > +				pcr |=3D NI16550_PCR_AUTO_RS485;
> > +				acr |=3D NI16550_ACR_DTR_AUTO_DTR;
> > +			} else {
> > +				/* DTR-controlled */
> > +				/* No Echo */
> > +				dev_vdbg(port->dev, "2-wire DTR no echo\n");
> > +				pcr |=3D NI16550_PCR_DTR_RS485;
> > +				acr |=3D NI16550_ACR_DTR_MANUAL_DTR;
> > +			}
> > +		}
> > +	} else {
> > +		/* RS-422 */
> > +		dev_vdbg(port->dev, "4-wire\n");
> > +		pcr |=3D NI16550_PCR_RS422;
> > +		acr |=3D NI16550_ACR_DTR_MANUAL_DTR;
> > +	}
> > +
> > +	dev_dbg(port->dev, "write pcr: 0x%08x\n", pcr);
> > +	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
> > +
> > +	up->acr =3D acr;
> > +	port->serial_out(port, UART_SCR, UART_ACR);
> > +	port->serial_out(port, UART_ICR, up->acr);
> > +
> > +	/* Update the cache. */
> > +	port->rs485 =3D *rs485;
> > +
> > +	trace_printk("end ni16550_config_rs485\n");
>=20
> Also drop this.

Removed this too.

>=20
> thanks,
>=20
> greg k-h
