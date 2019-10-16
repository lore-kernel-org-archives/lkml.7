Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14232FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E230520854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eavAjY99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392581AbfJPLCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:02:02 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:48286
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbfJPLCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:02:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz7torD2zd4MvCR6wU7lK2u9zdqG3isApDfog6wHBjJuHnoW7m8THfXJ92vImUwcFxL1bb+Iw5f9zg7bKvn6Occ8v6KJ7SvR6mIPQ269en2fnVLXs+SM2jzg/eZKhT7y6mgFadyitkp1IxZ6LBp1lJqYhTTo59ao9z7d3nctXJecFWNloQ/MmwP9mdigwxtZRCPW367yrH9N9ihTxQtUhIDue9ZhLjwjvV/m+PdIjk/c+AkoKrWJGWQByNTMWGiXbrLalelAN9gAQssMkjAfbltIhDzdFamZiTtEtZyV6m+fOSx/Mo3t0Nd3OQ+JBDk+kcesX7LUktKyUNrtCGauxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC0s8H2jNEl7qNSIrVIkOcb7mNC+168VZoIPI+EBrkk=;
 b=EHhLUbpKlg5DXobSTQ5ZVN5/KF8TdOcHi7LMfaifY3W+h4JLBQGdq+0GyP8UXrwnvncERuow7D1gewEwuNxetidd0FNUusDcB/wa0duIY04/ewKgp57JYH6p7liYNY8f6VB3jGmH6QyqCurfipiKbFAu2mV/na0oYbKcN1kwVuWj07jv0K80aQhgPoWsrJ3gTq0xmMWY0MONOYQPNc7QAH0Wk3R47ZRVc4Ie/VibT+xEHmgNAlQX7jdo/gIE2GFztSR4Lz8JW0kRt3gdHEENzGOMhrU2pFP7K3I2BRSBdaTkNKnOlEToi8d6IGqS75Esw6+unwURF+Ro4Ctbe2A51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC0s8H2jNEl7qNSIrVIkOcb7mNC+168VZoIPI+EBrkk=;
 b=eavAjY99AxUSXE6kan8codSvCp/JoG73hOZntQU2q7fMn6AyhyhvIBtNVFeWsWxFMfHDfBUjxPTe+XfDtsJdk+0RYE80VMGy1N3buVK8OrrUTsik2VKtDD0L0H5XhUdteJbX/xMBjn1tUSOOK13cGAow1U3XT9OYmtklD9SqXpk=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3679.eurprd04.prod.outlook.com (52.134.13.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 11:01:57 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::d0fc:54d4:86f4:b1d2]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::d0fc:54d4:86f4:b1d2%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 11:01:57 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 3/5] serial: fsl_linflexuart: Be consistent with the
 name
Thread-Topic: [PATCH v6 3/5] serial: fsl_linflexuart: Be consistent with the
 name
Thread-Index: AQHVhBEget+54Njm0Um0wC+XV9FxYQ==
Date:   Wed, 16 Oct 2019 11:01:57 +0000
Message-ID: <VI1PR0402MB2863EC2DF6464234DE4E0A16DF920@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <1570726348-6420-1-git-send-email-stefan-gabriel.mirea@nxp.com>
 <1570726348-6420-4-git-send-email-stefan-gabriel.mirea@nxp.com>
 <20191015190155.GA1140159@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40bad12d-7fad-47df-9b09-08d752284326
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0402MB3679:|VI1PR0402MB3679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3679BD349F27ADED558DBF84DF920@VI1PR0402MB3679.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(53546011)(316002)(102836004)(74316002)(486006)(305945005)(81156014)(7736002)(446003)(86362001)(54906003)(476003)(8676002)(55016002)(6436002)(52536014)(2906002)(9686003)(229853002)(81166006)(186003)(5660300002)(26005)(8936002)(6506007)(4326008)(64756008)(558084003)(33656002)(71200400001)(71190400001)(66946007)(76116006)(91956017)(66476007)(256004)(66446008)(66556008)(7416002)(7696005)(25786009)(76176011)(6916009)(14454004)(66066001)(478600001)(99286004)(6246003)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3679;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UuN6y66MLXQQjBy69LXejFCBemQkk7g0WqIioDyg4k9YaqNYQDh2wDKzUF3Itph1AeFZDcNR/Ofmk56IUyAllHxIRR+C8ojvoqjfb9FnmUcbGQdMthYxmgm+zxYYHZWUCHC3qhq7LpgoQoC3h25y42UqsZD4HuOlZjOG3I0yepo2qhcuL5ER8WXRPkosQ18jK8PWZNHMuY9cLIvtmgB3vs3WBPZfIcYlDzVVQanaKMwIHDI0FCRBwwPXIowqRKCOlGsZWNAcgW2dbPmHY2tkjgWduI9HBJ9+eKmfsV2adIFrPDgizxI6NaWkPimckuKpNWcrMCvZicnZINu7MymMt8hwsG+/+qn3znFcUCkkfTN+UXuD+/3GqE059ulFhm6IA5QQDNL777afv7XIstZk3TlCYanhsolhy+E0X9XbgT4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bad12d-7fad-47df-9b09-08d752284326
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 11:01:57.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1s8TCWGOPefbN/x1X+R1jkW/j+qHJYPZob1EPJ5ZuTzmPYMWKpkvsvN094+NQ0qd9Ok/W5wCOGGWxMXHRMzrlXOpUxLVduXf64YPbyLKbFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,=0A=
=0A=
On 10/15/2019 10:05 PM, Greg KH wrote:=0A=
> =0A=
> This patch does not apply to my tree :(=0A=
> =0A=
=0A=
Thanks for letting me know; I will rebase it in v7.=0A=
=0A=
Regards,=0A=
Stefan=0A=
