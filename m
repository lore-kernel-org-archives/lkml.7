Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35753C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26252064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gmGKxRcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408740AbfIXDX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 23:23:59 -0400
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:37030
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394621AbfIXDX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 23:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaOK/pfn5WMateuB4W8ADTT7otX+J2FREiphYNhiJRPGc/QYgWUEFJhdXIJxWZTD1CrYPbn7x7JV4H3Mb3X6WO8vBgJYgYAN5BWCq/E5evf/phRacBGv2wlz8AJgDWdwTabFPbP/ZTUGUDuA5G/cbFaXT9+wNB/RZ7F0sBCG8EfP9HgoWvDKpr0GZBf1YUA2oQRq09X6TrMNUHQyfopacfAO9skNtakEU7vsX4IOp6SEE82g8WcgRTA3TzbpbQP248hMHYk0qhuvP0RE+rTUeEjCyROW3NRJm8ffuBjByJWuth7u4i7DwJkASu5f2KajayE0l9gb7e7eXLlsBMA/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDOkap794uzwx9brTUvVXJ6oeO0I1t42s4rN4C2Nuzg=;
 b=ZUbxG/OBbSSZHiKXBiJhPNtGDTaPlaRb5JaqoqfqODQJljY0oEGMs7iM3ofjnhnJ59afehFVo1sNmjN+b/77KAbETk+unywULzQwL4uLaOkD539F0zwYoHyGc50ay6c+c+Sq60kvF4An2i2MRejuykfGqfTdSeqlszSXgkpqR2j2pZwDIGqGOLH6OITo1se+oE+4+x/ipinRGwsAQdzfLC5mn+k+g5lyCAVSAt0ac44h31u8/LdT7inb4wZ2Ha2ktteyXIMhQw73+eCmrei4/nuY5KgBuGUIKytIXw188PaO/aqQYEzL2qjOwQcAUrcv4MD9bRaccyldI9OxLDxmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDOkap794uzwx9brTUvVXJ6oeO0I1t42s4rN4C2Nuzg=;
 b=gmGKxRcslq3+bdbB98HxGtSMBW85EJI/86vuK99ai/MKlpUUiUzH7VnrjLSfcCfTvepkrDPt9EP0rWLlu1TG35WcbCU+viP14N/CimsXDR0Pjw3jMWGT0B60OVtGeqntLwXbhX+mvePtehVvGZc+D0ntSi5QU0+c6MNhD4dtOcU=
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com (52.133.240.82) by
 DB8PR04MB7097.eurprd04.prod.outlook.com (52.135.62.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 03:23:52 +0000
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::906f:1414:8cb:f7ee]) by DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::906f:1414:8cb:f7ee%2]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 03:23:52 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hub add filter for device with specific VID&PID
Thread-Topic: [PATCH] usb: hub add filter for device with specific VID&PID
Thread-Index: AQHVcfycJPrHn/IcK0qf/xic1GWPZ6c5GiAAgAEI5+A=
Date:   Tue, 24 Sep 2019 03:23:52 +0000
Message-ID: <DB8PR04MB682649CA98B0704FAF037A40F1840@DB8PR04MB6826.eurprd04.prod.outlook.com>
References: <20190923105102.37413-1-ran.wang_1@nxp.com>
 <20190923110712.GA2796979@kroah.com>
In-Reply-To: <20190923110712.GA2796979@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bff4d26-f463-4111-e937-08d7409e9fe9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB7097;
x-ms-traffictypediagnostic: DB8PR04MB7097:
x-microsoft-antispam-prvs: <DB8PR04MB70975DE133DEC5F843544D3FF1840@DB8PR04MB7097.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(199004)(189003)(71200400001)(6436002)(52536014)(55016002)(316002)(86362001)(478600001)(26005)(14454004)(229853002)(66476007)(74316002)(66946007)(66066001)(64756008)(66446008)(71190400001)(3846002)(76116006)(7736002)(305945005)(6116002)(14444005)(256004)(5024004)(53546011)(486006)(66556008)(9686003)(186003)(76176011)(11346002)(33656002)(99286004)(2906002)(6506007)(4326008)(8676002)(7696005)(102836004)(6916009)(54906003)(6246003)(81166006)(81156014)(25786009)(446003)(476003)(5660300002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7097;H:DB8PR04MB6826.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J9/tWFYXbPYjRGVYw51Zs9Ociec4VIZnZW55tKLkKBs114gOF+PQXyihQXrYHOmYTOgK3heR/ccS+JAJEA8bHTxiiRlJ4+6VFVIf7SExkS5aBPNOWa+RUptxH5QmfK+kt8rptPMrT4tXNtBrjJ3dszkBTjawmu+TN8GwMWRwZzJ5D0c7fsiGff64Xq9N4SmF72pdOhN3AcqQYz8hNlpRkLTOayjOf+c0Thj5NJkvc2rRJu1dIo7Q5a17GxIHf9/vKRERBo7xgpcTLmsYqux98+rov2UkzT3qen4wUqlk9tMpgoJLvmCrRh5jQxaWer/Mtt1Z2ZOq8TpvfRHThb3P6EOFU4GJg3fyn0xBfwNdG9n/QH5nDDkiA23VUUj5WMKZO0V1VTeXlL88umzj2o+W85MsZ75Zc3VSW6V+s/wNr78=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bff4d26-f463-4111-e937-08d7409e9fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 03:23:52.6790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BXMyfEy37DFBqBUcXSbWp4OJ+j7nOZiNM7ki/NVNoZ41Q7tT0xlSyrDJl3P7vMGKMqLbJNFkKEZAPR50oycQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Monday, September 23, 2019 19:07, Greg Kroah-Hartman wrote:
>=20
> On Mon, Sep 23, 2019 at 06:51:02PM +0800, Ran Wang wrote:
> > USB 2.0 Embedded Host PET Automated Test (CH6) 6.7.23 A-UUT
> > "Unsupported Device" Message require to stop enumerating device with
> > VID=3D0x1a0a PID=3D0x0201 and pop message to declare this device is not
> supported.
>=20
> Why is this a requirement?

This comes from <USB On-The-Go and Embedded Host Automated Compliance Plan
for the On-The-Go& Embedded Host Supplement Revision2.0>

Below is related description I quote from it:
6.7.23 A-UUT "Unsupported Device" Message
Purpose: This test verifies that an A-UUT produces a device non-supported e=
rror message
	when a device it doesn't recognize, and does not support HNP, connects to =
it.
Applies to: All Targeted Hosts
Description: Get VBUS turned on, and connect to the A-UUT. Get enumerated a=
nd respond
	as an unknown device not supporting HNP. Check that a suitable error messa=
ge is generated.
Pass Criteria: Message "Unsupported Device"or similar is displayed on UUT

6.7.23.1 Test Procedure
1. Start with cable still attached, PET applying 10=ECF capacitance and 10k=
=D9 pull-down
    resistance between VBUS and ground, data lines not pulled up.
2. Get VBUS turned on, using the method described in Section6.7.1.
3. Wait for almost TB_SVLD_BCON max (1s - 0.1s =3D 0.9s) from VBUS reaching=
 VOTG_SESS_VLD max.
4. Connect PET using D+ pull-up.
5. Allow A-UUT to enumerate PET, responding with a VID / PID combination no=
t on the TPL
    of the UUT and also with the OTG descriptor stating that it does not su=
pport HNP.
6. Start 30s timer when Device Descriptor is read.
7. Display Message "Click OK if 'Unsupported Device' indication displayed o=
n UUT".
8. If operator clicks OK before 30s timer expires, then UUT passes test.
9. If 30selapses first, then UUT fails test.
10. PET disconnects by removing any termination on the data lines, but leav=
es a capacitance of
    10=ECF and a pull-down resistance of 10k=D9 connected across VBUS.
11. Wait 2s to allow disconnection to be detected.
End of Test.

> And why those specific vid/pid values?  What do they refer to?

For step 5, we got the VID / PID number from USB IF certified lab(Allion.in=
c at Taiwang). Looks like
this is a reserved ID pair and will not be allocated to any vendor for thei=
r products. So it's hence used for this
case test (like saying: you should be able to pop a not-support message for=
 this reserved VID&PID).
=20
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/usb/core/hub.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c index
> > bbcfa63..3cda0da 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -4982,6 +4982,18 @@ static void hub_port_connect(struct usb_hub *hub=
,
> int port1, u16 portstatus,
> >  		if (status < 0)
> >  			goto loop;
> >
> > +		 /* USB 2.0 Embedded Host PET Automated Test (CH6)
> > +		 * 6.7.23 A-UUT "Unsupported Device" Message
> > +		 * require to filter out below device when enumeration
> > +		 */
>=20
> Nit, can you align your comment lines, to match the other multi-line comm=
ents
> in this file?  Otherwise it starts to look bad over time.

Yes, will update.

>=20
>=20
> > +		if ((udev->descriptor.idVendor =3D=3D 0x1a0a)
> > +		 && (udev->descriptor.idProduct =3D=3D 0x0201)) {
>=20
> Are you sure you don't have to convert this value into cpu endian before
> checking it?

Thanks for pointing out, how about this:
	if ((le16_to_cpu(udev->descriptor.idVendor) =3D=3D 0x1a0a)
	 && (le16_to_cpu(udev->descriptor.idProduct) =3D=3D 0x0201)) {

Regards,
Ran
