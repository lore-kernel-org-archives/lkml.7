Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C73C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683D7206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BO8Kso9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbfJICcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 22:32:02 -0400
Received: from mail-eopbgr130070.outbound.protection.outlook.com ([40.107.13.70]:30191
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbfJICcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 22:32:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Udq2wPSzOxPthZJ9BgQOddRSwcMNFRMquCTwt8Taj3hMywNnU/AmSuZ6XdMinZMEkeFOyutGBve6f4vyl7GaJaSJ16K9oC0HMHU+8RyqPfdXDo93c/P9cF7aiF/FEDYAnD3WUwzGBXPKJofPQImoDQrhVpEMnNkbkS+ehRPs4UarfIMhF1K+XxuMdLQXX3sN+liiSkUKEsAEXRYCq8eGOvulKHsQ/dvmcBxdzxe6I3hBYKVK2kAyqETg/EsCqPJTmdwuGpnxw5dOl7n/I4SP7sOyemUPUlTp2T96XG0rq3MoGue83OLKhDA3+jwFKeBEq3hykMsaOljdWLwT8RDb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqpdCui/LVKUkjeY4C5s0U6tVWoNO9R6r1aX1MkioqI=;
 b=ZKsca9zDeuur47MSasM3vCqr3Jy+xa8teCcpAC7RRpvTWjH1MGnJeTelCSANUyxE3q8K0T+KcUIaSZ/SIsqBXXBz2vju9NdK3valnCfdc9a3p9/Icv6vSis4IFalCWiPdD6tHff/rmtzodGH6kCuKuo2qbIXXbi686b96766X2APML9zR1lNhK2hbsQgrHrjbeVLYWwuiwuBlkImUfN0l20fliSk/GR+2tWPJaGhra8UPJJr6MegQzvKeC8GQgu3VaR8xaGXcLj9CUfujRtYmooJ4/O/V+us2DxuBjFxecUIDxj6ek085DrJFjsuyUKKL79DOjAfcvGXSmSolTm7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqpdCui/LVKUkjeY4C5s0U6tVWoNO9R6r1aX1MkioqI=;
 b=BO8Kso9wGVW0QlcyRKxRUQ6i9oRt8v5ubxIzw4TTH5xOZge9FiuwmIPysZbpng+irTRS/yZWz7F35rckgRv2H2/hsDRWTm8d144qJE2Aga05QX7giL3INhdyoJioPRXVL9rLFfx0N3C3PwKzt72u47XRqjaxTpXTqs4sHORP0Zc=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB3198.eurprd04.prod.outlook.com (10.170.228.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 02:31:57 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0%3]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 02:31:57 +0000
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
Subject: Re: [PATCH] usb: cdns3: Fix dequeue implementation.
Thread-Topic: [PATCH] usb: cdns3: Fix dequeue implementation.
Thread-Index: AQHVfQepqrRDdKh5qUCiZNqhRPzBa6dQW3eAgAAHm4CAATY8gA==
Date:   Wed, 9 Oct 2019 02:31:57 +0000
Message-ID: <20191009023141.GJ5670@b29397-desktop>
References: <1570449978-19145-1-git-send-email-pawell@cadence.com>
 <20191008073405.GF5670@b29397-desktop>
 <BN7PR07MB4705E02D18AE939D16BDDBC0DD9A0@BN7PR07MB4705.namprd07.prod.outlook.com>
In-Reply-To: <BN7PR07MB4705E02D18AE939D16BDDBC0DD9A0@BN7PR07MB4705.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b39ac17-8e79-4e57-6735-08d74c60db43
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB3198:
x-microsoft-antispam-prvs: <VI1PR04MB3198A6AE762CC8FC319473598B950@VI1PR04MB3198.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(81156014)(53546011)(71190400001)(25786009)(71200400001)(14454004)(6916009)(1076003)(33716001)(8936002)(478600001)(3846002)(6116002)(81166006)(8676002)(99286004)(256004)(14444005)(76176011)(7416002)(6506007)(305945005)(102836004)(86362001)(476003)(6512007)(9686003)(6436002)(7736002)(6486002)(66066001)(66446008)(64756008)(66556008)(54906003)(66476007)(5660300002)(66946007)(186003)(33656002)(2906002)(229853002)(76116006)(26005)(4326008)(44832011)(11346002)(446003)(486006)(316002)(6246003)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3198;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sfn+7WTYVyo+920xTVRk+jszuZMPSpUP99TQFCaTk67NMNo9iw5oFiCadhP0oxwggUvPbPKOu3VV9qqNCjrk9ElTkYAaJQiO6VYlaNc4v9u7BNZfHBCCbw381m/dWgGsqRqhgcuhWfNOPN1iSVH2DIsZMqoRj9x0AnUVElEvaYtX3zp3sX2zfxgOl5ISFpE6Zvn07/6qeDzA0ljxh649kqtd9r2feHDmCfzcUbkP5JQSWkzE4wajKCIXcqM5U5vpOPFg0XsMh807+T09Q3VZ1R4bTda5UXIuPkgb/pIVDGDRxY0hju0r7yZyqq3Qb/oNgINdAkvJR17XiObkEOe7dOPZeZRU5GcknkrwPMDwWNTHktjjNLxKUfbCO9IwFXsGZ38Yz+eZiCe2fSSTAz7y0AqJiNAk8jlQq2/JDMdhpGI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E954E9D3A050454A8092B538DB911804@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b39ac17-8e79-4e57-6735-08d74c60db43
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 02:31:57.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkppQ784euqlHpBolN+6/kx+/NKDbDDx+mC6/v+iVZeF+S4lTFVyIKgmaqcn8iS0w3LjaJWGxaGhpWd4ToB/XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-08 08:01:19, Pawel Laszczak wrote:
> >>
> >> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> >> index 2ca280f4c054..9050b380ab83 100644
> >> --- a/drivers/usb/cdns3/gadget.c
> >> +++ b/drivers/usb/cdns3/gadget.c
> >> @@ -1145,6 +1145,14 @@ static void cdns3_transfer_completed(struct cdn=
s3_device *priv_dev,
> >>  		request =3D cdns3_next_request(&priv_ep->pending_req_list);
> >>  		priv_req =3D to_cdns3_request(request);
> >>
> >> +		trb =3D priv_ep->trb_pool + priv_ep->dequeue;
> >> +
> >> +		/* Request was dequeued and TRB was changed to TRB_LINK. */
> >> +		if (TRB_FIELD_TO_TYPE(trb->control) =3D=3D TRB_LINK) {
> >> +			trace_cdns3_complete_trb(priv_ep, trb);
> >> +			cdns3_move_deq_to_next_trb(priv_req);
> >> +		}
> >
> >If the request was dequeued, it should not be at request list, isn't it?
>=20
> Yes
> The dequeued request was removed from pending list but TRB associated wit=
h it=20
> was changed to Link TRB so it should be ignored in cdns3_transfer_complet=
ed function.=20
>=20

I see, you are right. Except for the typo, otherwise:

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter


> Pawel
>=20
> >
> >Peter
> >> +
> >>  		/* Re-select endpoint. It could be changed by other CPU during
> >>  		 * handling usb_gadget_giveback_request.
> >>  		 */
> >> @@ -2067,6 +2075,7 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
> >>  	struct usb_request *req, *req_temp;
> >>  	struct cdns3_request *priv_req;
> >>  	struct cdns3_trb *link_trb;
> >> +	u8 req_on_hw_ring =3D 0;
> >>  	unsigned long flags;
> >>  	int ret =3D 0;
> >>
> >> @@ -2083,8 +2092,10 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
> >>
> >>  	list_for_each_entry_safe(req, req_temp, &priv_ep->pending_req_list,
> >>  				 list) {
> >> -		if (request =3D=3D req)
> >> +		if (request =3D=3D req) {
> >> +			req_on_hw_ring =3D 1;
> >>  			goto found;
> >> +		}
> >>  	}
> >>
> >>  	list_for_each_entry_safe(req, req_temp, &priv_ep->deferred_req_list,
> >> @@ -2096,27 +2107,21 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
> >>  	goto not_found;
> >>
> >>  found:
> >> -
> >> -	if (priv_ep->wa1_trb =3D=3D priv_req->trb)
> >> -		cdns3_wa1_restore_cycle_bit(priv_ep);
> >> -
> >>  	link_trb =3D priv_req->trb;
> >> -	cdns3_move_deq_to_next_trb(priv_req);
> >> -	cdns3_gadget_giveback(priv_ep, priv_req, -ECONNRESET);
> >> -
> >> -	/* Update ring */
> >> -	request =3D cdns3_next_request(&priv_ep->deferred_req_list);
> >> -	if (request) {
> >> -		priv_req =3D to_cdns3_request(request);
> >>
> >> +	/* Update ring only if removed request is on pending_req_list list *=
/
> >> +	if (req_on_hw_ring) {
> >>  		link_trb->buffer =3D TRB_BUFFER(priv_ep->trb_pool_dma +
> >>  					      (priv_req->start_trb * TRB_SIZE));
> >>  		link_trb->control =3D (link_trb->control & TRB_CYCLE) |
> >> -				    TRB_TYPE(TRB_LINK) | TRB_CHAIN | TRB_TOGGLE;
> >> -	} else {
> >> -		priv_ep->flags |=3D EP_UPDATE_EP_TRBADDR;
> >> +				    TRB_TYPE(TRB_LINK) | TRB_CHAIN;
> >> +
> >> +		if (priv_ep->wa1_trb =3D=3D priv_req->trb)
> >> +			cdns3_wa1_restore_cycle_bit(priv_ep);
> >>  	}
> >>
> >> +	cdns3_gadget_giveback(priv_ep, priv_req, -ECONNRESET);
> >> +
> >>  not_found:
> >>  	spin_unlock_irqrestore(&priv_dev->lock, flags);
> >>  	return ret;
> >
> >--
> >
> >Thanks,
> >Peter Chen

--=20

Thanks,
Peter Chen=
