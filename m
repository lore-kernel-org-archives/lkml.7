Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0051ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73F4218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="jc4afxqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437609AbfJQCSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:18:52 -0400
Received: from mail-eopbgr1410111.outbound.protection.outlook.com ([40.107.141.111]:43403
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729268AbfJQCSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:18:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTvfHNFKZ6slUgRa/SgPDCP900u2bxZC7uSuA+utt+ORc4bjclKveRaB7KjrinVim0m+MV9rIf7r4KjRbgpbZfWLBgTA6leJ82/7LVaQ7sFpktzqUswTuzQ4GDIRbvRO64odKRlmzPgTOJckdr9QUpSAt8L2Kr/QI41Nv+MIflOTRnc93dU9OxMeBV9IlV2mtPUuVg9sfhozzubvqIG1OC3Zljk3zLWgzBYV5GMp8BqOcwKzVAafM5v06svKWT1k0GFjOmVRTVzbQIm9K4T/gqmYs6nXMP5/uaevK8MD4P2Hsra4Jsp2ENKqBQqklO2uT5gz43wVIePsSiTcLUPvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7K8JUzNCsIlrCLSWrn6zcIqZ/rsDhaLTwEYuZsx+sc=;
 b=oLxXuYy1HO3ORPzMHBXAzfOk3/C+QNMv97eYcUvsa2ATcH+Q8hlOwcP3FRRJ8ij/UfvTBoYd7GxFCR4lPrxmmQoF5UkM6FEdK7CnPo+OMC9d9sN7TW3hV9aaKunmI/RZCUpcsvBRK1ZBut6ECIG9w7f0/vp2tu2CB+TKjBFbz9ALBOKxKeckvPuxLClWk3+RvAGNV2iKLMagNfOaTCr8AkRe5V4z4LY0pq7BRXgaoWLXg2QgEplx9M6yMpd5GT2yQEE10l1kFjDKqBIvfD1YRrohumNlj8543GnXL7Qjod2yrRuY1a3cqN7rWnlD7oaP22Wcwvvqz5c/XGuOepznzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7K8JUzNCsIlrCLSWrn6zcIqZ/rsDhaLTwEYuZsx+sc=;
 b=jc4afxqYno/wz8o64LlmGSTPgESyUymMCBjoMKOU4M/jebOYmVKkxwjYjV2WCUxiGsvAdkXNgije05JCo+NCdgwj++hDCxRsn3Dz+/lZnwqxtGdWUROkH4rp0lcqqAAu7/chjJyJsGNohSPdmNkO/WaCr3LPkIJzl8YNR8BIcJ4=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3664.jpnprd01.prod.outlook.com (20.178.137.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 17 Oct 2019 02:18:47 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 02:18:47 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     "linux-kernel@lists.codethink.co.uk" 
        <linux-kernel@lists.codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Subject: RE: [PATCH] usb: renesas_usbhs: fix __le16 warnings
Thread-Topic: [PATCH] usb: renesas_usbhs: fix __le16 warnings
Thread-Index: AQHVg3BX7WaejZzh5Uuo1PfP1tSBgKddMx4AgADnaMA=
Date:   Thu, 17 Oct 2019 02:18:47 +0000
Message-ID: <TYAPR01MB45440369B72F2C994CF8C85FD86D0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191015155044.11858-1-ben.dooks@codethink.co.uk>
 <20191016122656.3jpmes4rnz47u5wc@verge.net.au>
In-Reply-To: <20191016122656.3jpmes4rnz47u5wc@verge.net.au>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8dded65-8466-47ce-f294-08d752a8577d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB3664:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <TYAPR01MB366448B5893101792AC4CA88D86D0@TYAPR01MB3664.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(189003)(199004)(256004)(99286004)(6306002)(102836004)(4326008)(33656002)(76176011)(2906002)(6436002)(478600001)(9686003)(305945005)(66066001)(966005)(7736002)(229853002)(86362001)(7696005)(55016002)(25786009)(71190400001)(14454004)(74316002)(6246003)(476003)(52536014)(6506007)(486006)(71200400001)(11346002)(446003)(6916009)(6116002)(3846002)(66556008)(66946007)(316002)(66476007)(8676002)(8936002)(66446008)(64756008)(76116006)(81166006)(81156014)(186003)(54906003)(5660300002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3664;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /QukEE4bZ1lNoCqT0ULIykjMQ5Ncusx1G8vYYWIhA2uPFjkkC2eK/NuIscagx5wJkZp/g6UCk6YRqwRL7kxl63IDtSGqo3G88k83hzcmj0C+c0XcQmsT42TUYIjpk8BSOfSEqbwDs9lYJB8I1g2eU+9lmiSNpfblqpXyN1YYWSKKjv6rdv8ZfJyqfCyc02dP8CSmjmVfULoN05k8mTI5xxedcWR7h+6ksOgx9JMVk7TTgXpmjkTv8OVq37eo2jDzicY4ltm8qKUweK9nztxM4K+MVRksdyzVkzpXtmXolCKyeQB6F60zPq5ZnYIOfkgfPIbFOUiJX7qhSOvBP5pXDVQLGQztG5lhfk9Q6heJ+nIlBA9++c8cTKl0rE2TqnVM8YYc/Njl1nzkk6DfJZ3xxlNGMeJXROvvJBxa7jcQ2Dl/J1ypo1v45OmyFc3qPQySnEQc/ElicXm4DvC9AaxNcQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dded65-8466-47ce-f294-08d752a8577d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 02:18:47.0600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umWYp1oHE2jyPWmndTpf82Eq4TlO3XjfPiTgRkcP1M+jNn3ijMsUJxv2a3mqHGXcHtQUixFMTdGRf+HzbhWWbNw+pVswzHc9SlOPngTfOrhDi71fndYetNop06+OmHBu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon-san,

> From: Simon Horman, Sent: Wednesday, October 16, 2019 9:27 PM
<snip>
> > diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_u=
sbhs/common.c
> > index 4c3de777ef6c..a3c30b609433 100644
> > --- a/drivers/usb/renesas_usbhs/common.c
> > +++ b/drivers/usb/renesas_usbhs/common.c
> > @@ -162,17 +162,17 @@ void usbhs_usbreq_get_val(struct usbhs_priv *priv=
, struct usb_ctrlrequest *req)
> >  	req->bRequest		=3D (val >> 8) & 0xFF;
> >  	req->bRequestType	=3D (val >> 0) & 0xFF;
> >
> > -	req->wValue	=3D usbhs_read(priv, USBVAL);
> > -	req->wIndex	=3D usbhs_read(priv, USBINDX);
> > -	req->wLength	=3D usbhs_read(priv, USBLENG);
> > +	req->wValue	=3D cpu_to_le16(usbhs_read(priv, USBVAL));
> > +	req->wIndex	=3D cpu_to_le16(usbhs_read(priv, USBINDX));
> > +	req->wLength	=3D cpu_to_le16(usbhs_read(priv, USBLENG));
>=20
> usbhs_read is backed by readl which performs
> a le->cpu conversion. Rather than have a double conversion
> perhaps it would be nicer to introduce usbhs_read_le.
> Likewise for write.

I'm afraid but, I could not understand these comments.
At the moment, the usbhs_{read,write}() call io{read,write}16(),
not {read,write}l().

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/usb/renesas_usbhs/common.c?h=3Dv5.4-rc3#n62

Best regards,
Yoshihiro Shimoda

>=20
> >  }
> >
> >  void usbhs_usbreq_set_val(struct usbhs_priv *priv, struct usb_ctrlrequ=
est *req)
> >  {
> >  	usbhs_write(priv, USBREQ,  (req->bRequest << 8) | req->bRequestType);
> > -	usbhs_write(priv, USBVAL,  req->wValue);
> > -	usbhs_write(priv, USBINDX, req->wIndex);
> > -	usbhs_write(priv, USBLENG, req->wLength);
> > +	usbhs_write(priv, USBVAL,  le16_to_cpu(req->wValue));
> > +	usbhs_write(priv, USBINDX, le16_to_cpu(req->wIndex));
> > +	usbhs_write(priv, USBLENG, le16_to_cpu(req->wLength));
> >
> >  	usbhs_bset(priv, DCPCTR, SUREQ, SUREQ);
> >  }
> > --
> > 2.23.0
> >
