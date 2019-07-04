Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3321AC06516
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013F7218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="mHQvHY69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfGDIH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:07:59 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:11728 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726679AbfGDIH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:07:58 -0400
X-Greylist: delayed 740 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jul 2019 04:07:56 EDT
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x647pTNW031251;
        Thu, 4 Jul 2019 02:55:35 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2052.outbound.protection.outlook.com [104.47.44.52])
        by mx0b-00010702.pphosted.com with ESMTP id 2tg8maen38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 02:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTScymKrbZuyQJKBBmmZcGw8tVtId9VZiPFd4x3NYto=;
 b=mHQvHY69drauef6Z9OGz6wj1s636oqj9GfVl0JFvdDv3ZML2n8in6rg5ma+4Tb2iXJ7PtxGhHb91XL21RY6TTXidZKdZwOEGEFuxAHJ6pGdAJKnq0/rfJYYc0CKGzP+FlRR7g5m3eUZ/vPzh1YUj6SIIPkHo9WIJr37Co7fwbrk=
Received: from MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) by
 MN2PR04MB6334.namprd04.prod.outlook.com (52.132.168.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.16; Thu, 4 Jul 2019 07:55:34 +0000
Received: from MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7]) by MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7%5]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 07:55:33 +0000
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH V2 1/2] serial/8250: Add support for
 NI-Serial PXI/PXIe+485 devices
Thread-Index: AQHVMXBj7eo/fZvhYE2S6PzURXggyqa4k5MAgAFlzOA=
Date:   Thu, 4 Jul 2019 07:55:33 +0000
Message-ID: <MN2PR04MB59207BEC9DBAB5E69656DD42B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <20190703084220.GD8996@kroah.com>
In-Reply-To: <20190703084220.GD8996@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.75.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f34922a8-ac03-4326-0146-08d70054fe4e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB6334;
x-ms-traffictypediagnostic: MN2PR04MB6334:
x-microsoft-antispam-prvs: <MN2PR04MB63349A2D527C1FC5395462F0B7FA0@MN2PR04MB6334.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(33656002)(25786009)(4326008)(6916009)(316002)(6116002)(71200400001)(71190400001)(73956011)(66946007)(76116006)(66556008)(64756008)(66446008)(66066001)(66476007)(3846002)(7736002)(86362001)(305945005)(74316002)(2906002)(81156014)(446003)(11346002)(5660300002)(8676002)(76176011)(99286004)(256004)(68736007)(14444005)(54906003)(478600001)(486006)(8936002)(52536014)(476003)(81166006)(55016002)(229853002)(102836004)(186003)(26005)(9686003)(6506007)(7696005)(53936002)(6436002)(14454004)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6334;H:MN2PR04MB5920.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +R7cjd0SjsPBXSqwAi7HxXOnSmeUA1QT0sJ8NYE04m7SC/WuR3kwJTAPHzLp9Xa9vtRp+TXSAQToXseNisYRxd2oqtjgbSR6Dfhgr5uJVjZzFKHst0p4iuqLD9p2W7Qzy50hM0qe9ZqOI4Nydl5Ug4d9RLVaSTyaO17AQbOo0BerIsEusZAZjUqcMHGUWcMc6bx6dAoksSIIHb0oDsgMTI50Vk40a2MOtTJPXF8CyJxQCNp3KavpU2SP/n3fdzvd/yagi5or6atVzxo+HjOksBRkjvjx1Dsaquk68yIKCeEH8bAWt/ikimlfKtwGXMZWiZpuZG5OFQ6G68kj8oMibSFFt/17Cy/67XmZy99QjXpYCqm03gvzUa0ZXQKNUt2+8gBlzsO/nrCwFe0sFfNsnc4SgaYFz4xlnA+nK9KbZ2I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34922a8-ac03-4326-0146-08d70054fe4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 07:55:33.7453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je.yen.tam@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6334
Subject: RE: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jul 03, 2019 at 12:24:35AM -0700, jeyentam wrote:
> > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> >
> > Signed-off-by: jeyentam <je.yen.tam@ni.com>
>=20
> I need a "full" name here please.

Ok, will do so.

>=20
> Also, this patch breaks the build, which is not allowed, and makes me won=
der how
> you tested it :(

I've tested my changes with the steps as follows, it did not break.

1. Clone the Linux repo, check out the source and work on my project.
2. Compile the kernel source with "make j4".
3. Build the kernel modules with "make modules_install".
4. Install the kernel with "make install".
5. Reboot into the newly built kernel.
6. The kernel worked well and able to fit my needs.

Noted that my source is checked out from the latest Linux kernel 5.2.0-rc6.

Also, I checked my patch using checkpatch.pl, it did not show any errors an=
d=20
warnings too.

May I know what do you mean by breaking the build?

>=20
> Please fix up properly and resend.
>=20
> Also, some comments below:
>=20
> > ---
> >  drivers/tty/serial/8250/8250_pci.c | 293
> > ++++++++++++++++++++++++++++-
> >  1 file changed, 289 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci.c
> > b/drivers/tty/serial/8250/8250_pci.c
> > index df41397de478..ac8138adea9c 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -730,8 +730,16 @@ static int pci_ni8430_init(struct pci_dev *dev)
> > }
> >
> >  /* UART Port Control Register */
> > -#define NI8430_PORTCON	0x0f
> > -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
>=20
> Why are you renaming these #defines?

NI8430 device is using standard 16550 UART chip so I standardize all the 16=
550=20
UART related #defines to UART chip specific name rather than device specifi=
c.

>=20
> > +#define NI16550_PCR_OFFSET	0x0f
> > +#define NI16550_PCR_RS422	0x00
> > +#define NI16550_PCR_ECHO_RS485	0x01
> > +#define NI16550_PCR_DTR_RS485	0x02
> > +#define NI16550_PCR_AUTO_RS485	0x03
> > +#define NI16550_PCR_WIRE_MODE_MASK	0x03
> > +#define NI16550_PCR_TXVR_ENABLE_BIT	(1 << 3)
>=20
> BIT(3)?

Ok, will change to this style.

>=20
> > +#define NI16550_PCR_RS485_TERMINATION_BIT	(1 << 6)
>=20
> BIT(6)?

Also, will change this.

>=20
> > +#define NI16550_ACR_DTR_AUTO_DTR	(0x2 << 3)
> > +#define NI16550_ACR_DTR_MANUAL_DTR	(0x0 << 3)
> >
> >  static int
> >  pci_ni8430_setup(struct serial_private *priv, @@ -753,14 +761,127 @@
> > pci_ni8430_setup(struct serial_private *priv,
> >  		return -ENOMEM;
> >
> >  	/* enable the transceiver */
> > -	writeb(readb(p + offset + NI8430_PORTCON) |
> NI8430_PORTCON_TXVR_ENABLE,
> > -	       p + offset + NI8430_PORTCON);
> > +	writeb(readb(p + offset + NI16550_PCR_OFFSET) |
> > +			NI16550_PCR_TXVR_ENABLE_BIT,
> > +			p + offset + NI16550_PCR_OFFSET);
>=20
> Why indent like this?  Please follow the indentation that used to be ther=
e.

I moved the indentation because it complained this line exceeded 80 charact=
ers=20
when I check the patch. I will change back to original indentation.

>=20
> >
> >  	iounmap(p);
> >
> >  	return setup_port(priv, port, bar, offset, board->reg_shift);  }
> >
> > +static int pci_ni8431_config_rs485(struct uart_port *port,
> > +	struct serial_rs485 *rs485)
> > +{
> > +	u8 pcr, acr;
> > +
> > +	struct uart_8250_port *up;
> > +
> > +	up =3D container_of(port, struct uart_8250_port, port);
> > +
> > +	acr =3D up->acr;
> > +
> > +	dev_dbg(port->dev, "ni16550_config_rs485\n");
>=20
> No need for debugging lines like this, use ftrace please.

Ok, will update this.

>=20
> > +
> > +	/* "rs485" should be given to us non-NULL. */
> > +	WARN_ON(rs485 =3D=3D NULL);
>=20
> Don't crash people's machines, if this can never happen, then no need for=
 this line.  If
> it can happen, test and properly return an error.

This is more like a fail safe approach, it should never happen, will remove=
 this line.

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
> > +	dev_dbg(port->dev, "ni16550_config_rs485\n");
>=20
> Again, use ftrace, not dev_dbg() for stuff like this.

Will do so.

>=20
> thanks,
>=20
> greg k-h


Thank you.
Regards,
Je Yen Tam
Staff Software Engineer
National Instruments=A0
o=A0=A0 604-3776397
e=A0=A0 je.yen.tam@ni.com

