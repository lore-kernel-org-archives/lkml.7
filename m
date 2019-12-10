Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B735C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C672053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="CGiNp8RY";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="bj0GRcnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLJKbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:31:19 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:13700 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727107AbfLJKbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:31:19 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAAU1px023958;
        Tue, 10 Dec 2019 02:30:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=e3oL3iyM1feMduZa+VhOSzreuKNhqxoAGMCNUOQXB6M=;
 b=CGiNp8RYR8klGCCkwPFjJcNpvgn20MJO3fvs9d788QoakWfsPDGQ3ozN4frk1YQhvz9G
 v4kT5oRjj3MtTpOa8skOfCrrc+szw7IsC9Dyleq9aDIw4t2pTvbycl3dW+weRBen7KId
 wHIjbR5G3+LGHpdas7O5y+TbIhyV3jrYLQfbVUw2Jjwx0KVSaGsJFUU+mdOb2hby8z3l
 F+fSLIpO25UjRN7Jtbf33ukY9b5c1umrX0cNBAqtYkDTpK19AaAWI0ORgMX5vCCmlAdo
 Ti2oGR54DtWzPeZMz3k5cGP/hPWno9CLlekZBp6m6uOfePvxkQd6Z285FMDo2veBm+/x 6A== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfhekp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 02:30:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPBzfeeN6oyo3KMZJmZbRLRUVMTFPsDDdbE+gMyRVwYPWJyu1r3VjyfSBEfvMQ6mQnF8/pe1eYGyU8gbKnWNngUuw931HQPB5y9jDSMURd5kTo/1zKih+l+/AX/kDJBfbydWIbSNtWt0oiT3GaqMhM41gYmwLwHYEOy3MIzRzt1qon64uKm+Ao8jNP4W0uJd8VdeKMl/cOoykcLwK2tdkk/1yiT+TA1m5/TUzy7ybucR0NfQSiruAexl/rOSPmldC7NndHuHCd8vHeaJjSNwa7nS99wwfQodAIO9kTvDyaqppLlZWf42Y9pGRSxqshQgNe/xndzD/ey6sa2P7IgJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3oL3iyM1feMduZa+VhOSzreuKNhqxoAGMCNUOQXB6M=;
 b=YSWqrqR7WDSG0BnACtDshr5FDpsrYOS4Ekxqyhhmb8d7/nC4SNBqgGtH/9L9mlwjoU+CMS31zyxr7sAJQjYhG1oIx7zGMlZnBftD11c57LNJpAmITYQo/kQtLHSMWlpgivy3Da4B7lNy9jA53JfAk5ppOHR7GuibDME+ayz/nuLVy2MRzIZe4Nu2qLWdpAKqNB98Cw1wrj8pI5QrJr3PC9bdBXJ8kuTig8KRYo0si8c+KUCS6Ls1DqlvXs70JX6zLiI3V/itumAa9HnZeDmymeoQt9XEDZB1FEZaXD34Uw2S7NaLwybt9gMpAoveUJQB2DGgPrcpQOSGv3TajGfyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3oL3iyM1feMduZa+VhOSzreuKNhqxoAGMCNUOQXB6M=;
 b=bj0GRcnvikTOU9RE7Ps+84HhSJLWX2aYJ2rLx1ibXF9D9ExbSi7xLfon14OxuSSMzJVSWoU5zdFedXO7XPUosD0QDuqQHzgu7ZgFGgSWVEXBq1KszJT2YQaIOG/n+HcMyBawL4/CBSRG5I3ExohE1WCjPwUQ/XnOM96FKn7hMfo=
Received: from MN2PR07MB6288.namprd07.prod.outlook.com (20.179.86.160) by
 MN2PR07MB7118.namprd07.prod.outlook.com (52.132.169.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 10 Dec 2019 10:30:04 +0000
Received: from MN2PR07MB6288.namprd07.prod.outlook.com
 ([fe80::f0d8:94b6:89b0:f07f]) by MN2PR07MB6288.namprd07.prod.outlook.com
 ([fe80::f0d8:94b6:89b0:f07f%3]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 10:30:04 +0000
From:   Jayshri Dajiram Pawar <jpawar@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [RFC PATCH] usb:gadget: Fixed issue with config_ep_by_speed
 function.
Thread-Topic: [RFC PATCH] usb:gadget: Fixed issue with config_ep_by_speed
 function.
Thread-Index: AQHVqQDStZPebdwhrkmS7zb9xh9876ezNXSAgAAAuUA=
Date:   Tue, 10 Dec 2019 10:30:04 +0000
Message-ID: <MN2PR07MB628834A5F09437CF742977D9C15B0@MN2PR07MB6288.namprd07.prod.outlook.com>
References: <1575284847-3388-1-git-send-email-jpawar@cadence.com>
 <20191210102231.GA3698263@kroah.com>
In-Reply-To: <20191210102231.GA3698263@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcanBhd2FyXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMDU3MTcyMDktMWIzOC0xMWVhLTg0ZmMtMDRkM2IwMjc3MWJiXGFtZS10ZXN0XDA1NzE3MjBhLTFiMzgtMTFlYS04NGZjLTA0ZDNiMDI3NzFiYmJvZHkudHh0IiBzej0iMTM2NyIgdD0iMTMyMjA0NDc0MDIyNTQ4MzYxIiBoPSJEbXowaityTnVVUDUvc2N6ajE4Z2RRdnl5K009IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a169c679-8863-4577-bed5-08d77d5bebb2
x-ms-traffictypediagnostic: MN2PR07MB7118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR07MB71187405525987D640B7A2EAC15B0@MN2PR07MB7118.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(36092001)(199004)(189003)(13464003)(316002)(6506007)(8936002)(53546011)(33656002)(5660300002)(478600001)(7696005)(66446008)(6916009)(8676002)(81156014)(81166006)(186003)(26005)(4326008)(55236004)(55016002)(7416002)(9686003)(2906002)(107886003)(76116006)(52536014)(71200400001)(66946007)(66476007)(66556008)(64756008)(54906003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB7118;H:MN2PR07MB6288.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCYnvhsjPAh+sWGRwrRRW28FfSQPSZEdrmDJ2X65peU2OK5OvVMRYck2MNSoD6oQ5zrgplXRDQqPktVtrMpPxELBA6K4SoRWDo7Br5EJ5mFHMCsKmTX/+e1JMoclCiv4yRM1ILKw4hnVh+BV7IAJnbHyy8vSkP7K5/RfULjlaQRhRQkMQeRLrJhXA15X8kfFasS+uf3nExj/Sq6PDAtH73AmLw/cHtmlKt8FDSbe/JkXWWwu8m6JN5vdHxXYx8DUkrjXIFj0Xh6vO5HmI2pfU2onI2mHoMoWeqpbZplqizSDvnoJp//LUPGJ4fWRlLLTW46aNOobCKjzSEFB44gyNQ+eA/gK4K5XoIvowYjhWmcEQfMl6kX0xpwH9PpvuyeMCBJFIkZTeDeYr2PjGHo5cAE95tcZugppm4ydtAX4dUV7T1AIeIWRaOQxDetlUY4mJZ1SPLMlJeg7fVLJbcx+QoxGqrqGTuIJDC8LfjSTDUUAvVoIPPG+gGgIWBQV8Qi8lJUA+ML8HgO4QE626xA45Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a169c679-8863-4577-bed5-08d77d5bebb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 10:30:04.5530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4+v9XquK4MQrx2lTwER3RB3wa+Htzil1Zw2is2IlktTA6dxiHYgCPtxbcqMrns5WUFl218y+GdTgFdUzP+ZNMVDWA/nG3alDJJItrC6+wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7118
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_01:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, December 10, 2019 3:53 PM
> To: Jayshri Dajiram Pawar <jpawar@cadence.com>
> Cc: linux-usb@vger.kernel.org; felipe.balbi@linux.intel.com;
> heikki.krogerus@linux.intel.com; rogerq@ti.com; linux-
> kernel@vger.kernel.org; jbergsagel@ti.com; nsekhar@ti.com; nm@ti.com;
> peter.chen@nxp.com; Rahul Kumar <kurahul@cadence.com>; Pawel
> Laszczak <pawell@cadence.com>; Sanket Parmar <sparmar@cadence.com>
> Subject: Re: [RFC PATCH] usb:gadget: Fixed issue with config_ep_by_speed
> function.
>=20
> EXTERNAL MAIL
>=20
>=20
> On Mon, Dec 02, 2019 at 12:07:27PM +0100, Jayshri Pawar wrote:
> >  /**
> >   * config_ep_by_speed() - configures the given endpoint @@ -144,9
> > +146,11 @@ next_ep_desc(struct usb_descriptor_header **t)
> >   */
> >  int config_ep_by_speed(struct usb_gadget *g,
> >  			struct usb_function *f,
> > -			struct usb_ep *_ep)
> > +			struct usb_ep *_ep,
> > +			unsigned alt)
>=20
> Why did you not document this new parameter?  It does not make sense to
> me, what does it do, and how is it supposed to be used?
Hi Greg,
New parameter is documented and updated in patch v2.

Thanks,
Jayshri


>=20
> thanks,
>=20
> greg k-h
