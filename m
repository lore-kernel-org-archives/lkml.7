Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87173C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6046D20673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aXpYfPjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfJHIp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:45:26 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:13895
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729767AbfJHIp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:45:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe9t2g0SoiJeCwk4mxpQZoQFbWZVLVhhOKt0hsqfJb7KBVubxBeXU3x3/sTOGb01TRVxEdzSl7kpa1QzSRcdqe95c6/oXVtFLXm1+NQff2U/xg2egVW3bu9/Z7kQEEXVcevZMDlEPLCp3BZhkk9IlHeXVDsD1PQph4B1+ueKGg95en+0W3jVGLKiVh4FtbvnuXsxnEhxJW2OxkaK4fInZNGHLv/bSccMkknsERE7bIuRiOMTAKlQJRvgmcOCj2LW2A9b7f5gaVaXjqdWGStXwz7sjKu7tbkiyFA+wvS34P9tgOLDMnMa66IO9IJJDF5yK5ef5ti3V5XrCa02PWX6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pbBEoyCEzYlaAXecwd1cMZnPKNei/aAFkMBKWEHLlQ=;
 b=S6rzv8Zgv6Kc/8gLQGfs/cJBA2JMDmVS8Os2emuZdXB00E083G9gertUMtnCY3059HqcM/qqu4KxX1fWfJlnHxrKQtRf3s/Mkcx6YG9QB5LSQKJZto5o023PAmDhKlQpJ6s3wfRabFRJ6FLA3JePwPpLtzEh0lG/h2YlaPrUd8gUk2R0EyY7B0RT9PE+x/ew2SaHZpr/ojcKpWwcaswYKGt1Vqd2xDFOztir1xBGWxtquBr6xnw1uT9kDFGdkAE8DVDX9FD3ggW+4dIoNs3MywAE2VEAkkUO/2zkCZxwk+GA2OtQ3tByOorT8BSguv4RxqkkZDYuIaSKKB9SQhRxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pbBEoyCEzYlaAXecwd1cMZnPKNei/aAFkMBKWEHLlQ=;
 b=aXpYfPjT4PUs1mGX+3vPjGqa+kYw6rUQPqdwwJpBX5UrE82sblTD8bSQQd53SwdZfWK/I8dYhMOEjNYisPQ9ClIqd6bPFm+doC0RuAE9SQL7did8dOuK+zTzqgFSXxKm8T6ffdKC9AgbB/ONHBdsMheRETxRcXoJUmHPXYGR/NA=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB7101.eurprd04.prod.outlook.com (10.186.159.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 08:44:43 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0%3]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 08:44:43 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
Thread-Topic: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
Thread-Index: AQHVfNoJ++ECtmBATUSOETiOVkdrz6dQUUWAgAARBwCAAAhcsA==
Date:   Tue, 8 Oct 2019 08:44:42 +0000
Message-ID: <VI1PR04MB53276319AB49C454A7A0318B8B9A0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1570430355-26118-1-git-send-email-pawell@cadence.com>
 <20191008065619.GE5670@b29397-desktop>
 <BN7PR07MB47056F9852550657E9651DD7DD9A0@BN7PR07MB4705.namprd07.prod.outlook.com>
In-Reply-To: <BN7PR07MB47056F9852550657E9651DD7DD9A0@BN7PR07MB4705.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 005f7745-b84b-4559-2f87-08d74bcbc3c6
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB7101:
x-microsoft-antispam-prvs: <VI1PR04MB7101909E7D4B7E137A558DB28B9A0@VI1PR04MB7101.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(189003)(199004)(6246003)(76176011)(186003)(6506007)(102836004)(3846002)(7696005)(26005)(6116002)(33656002)(14454004)(9686003)(55016002)(8936002)(4326008)(478600001)(8676002)(486006)(81156014)(81166006)(2906002)(446003)(6436002)(99286004)(11346002)(476003)(54906003)(71190400001)(25786009)(316002)(66066001)(229853002)(86362001)(71200400001)(52536014)(6916009)(7416002)(76116006)(5660300002)(64756008)(256004)(66476007)(66556008)(44832011)(7736002)(14444005)(66446008)(305945005)(66946007)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7101;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FBpq6TSOSuFsRmIXcKWwl1CiNrGa/yWS4X7VdRrco5E/siLfHns9cD0JrMQC+yxefFpB+8TY7wUJfQfO4sZImDfkFw6M+FWLQJ98sBK0uMBLhYXPVK6TdbK5+GsnSPEBho8ri9GIXivdD+Cg7MHpvmPRXrIpFLb0Yc2+12bV4833o/kouGHcWLu+pPiFvgzsunOX0PWyupX/UX2l+hBTobXn0ScbZ30CY3M25eS85tPu5tnKMRUi6OhhU71VENschgEp0/rcwAntnhcsHTevZy4sre3VmEcy7nk//No3ycODiRWotwqfjqpFh64/zFCDjW+FeuEJPnxF4X1KaBMYgIBF+A+bAVHTn6YK8DZ1hm/uoaXdGTpG7ma+cjXQBiie3xCnfvXtjxVaI7ZSToSduUFQb9dSC5BAqWW2Ks8/X0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005f7745-b84b-4559-2f87-08d74bcbc3c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 08:44:43.0074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIGPELhPvseSBKSNyvnJMEmXkzYTs6yNHin5O9y27nqBSLUwgpJ8eHZRweevVSPVk1K+7oG5ZgDoDCf77bDYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> >> Endpoint can defer transition to Halted state if endpoint has pending
> >> requests.
> >
> >The implementation of halt handling is a little complicated, you may
> >consider return -EAGAIN for functional stall through usb_ep_set_halt
> >from function driver if the requests are pending, it doesn't need to
> >defer such kinds of functional stall.
>=20
> Yes, I remember your suggestion regarding using EAGAIN, but f_mass_storag=
e
> Driver simple check the status and try to stall endpoint again after 100 =
ms.
>=20
> What if Command Verifier ask for endpoint status before this time, or if =
the transfer
> will not be finished on time ? Then the CV test may fail.
>=20
> So solution from this patch should be more certain.
>=20

Your description is reasonable, since I have not met this issue, I would li=
ke
to know more about it:=20
It occurs at CV9 or MSC test? For CV9 test, it may not try to stall non-ep0=
.
Which test case was failed?

Peter

> >
> >Peter
> >> Patch add additional condition that allows to return correct endpoint
> >> status during Get Endpoint Status request even if the halting
> >> endpoint is in progress.
> >>
> >> Reported-by: Rahul Kumar <kurahul@cadence.com>
> >> Signed-off-by: Rahul Kumar <kurahul@cadence.com>
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> >> ---
> >>  drivers/usb/cdns3/ep0.c | 10 ++++++++--
> >>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c index
> >> 44f652e8b5a2..10ae03430f34 100644
> >> --- a/drivers/usb/cdns3/ep0.c
> >> +++ b/drivers/usb/cdns3/ep0.c
> >> @@ -234,9 +234,11 @@ static int cdns3_req_ep0_set_address(struct
> >> cdns3_device *priv_dev,  static int cdns3_req_ep0_get_status(struct
> cdns3_device *priv_dev,
> >>  				    struct usb_ctrlrequest *ctrl)  {
> >> +	struct cdns3_endpoint *priv_ep;
> >>  	__le16 *response_pkt;
> >>  	u16 usb_status =3D 0;
> >>  	u32 recip;
> >> +	u8 index;
> >>
> >>  	recip =3D ctrl->bRequestType & USB_RECIP_MASK;
> >>
> >> @@ -262,9 +264,13 @@ static int cdns3_req_ep0_get_status(struct
> cdns3_device *priv_dev,
> >>  	case USB_RECIP_INTERFACE:
> >>  		return cdns3_ep0_delegate_req(priv_dev, ctrl);
> >>  	case USB_RECIP_ENDPOINT:
> >> -		/* check if endpoint is stalled */
> >> +		index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
> >> +		priv_ep =3D priv_dev->eps[index];
> >> +
> >> +		/* check if endpoint is stalled or stall is pending */
> >>  		cdns3_select_ep(priv_dev, ctrl->wIndex);
> >> -		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)))
> >> +		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)) ||
> >> +		    (priv_ep->flags & EP_STALL_PENDING))
> >>  			usb_status =3D  BIT(USB_ENDPOINT_HALT);
> >>  		break;
> >>  	default:
> >> --
> >> 2.17.1
> >>
> >
> >--
> >
> >Thanks,
> >Peter Chen
>=20
> Regards,
> Pawel
