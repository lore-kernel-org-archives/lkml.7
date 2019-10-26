Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF04CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6575620684
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 15:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XJ8vQZt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfJZPML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 11:12:11 -0400
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:24834
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbfJZPMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 11:12:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7lLn+kUtushUtWUpZZWx8EhIKyWQo+En2hef6x0p2X7i7QUfE1Sggi6YAENhYOt3LrtWne44QpQtN+AzGrYlGQF10JKDRLNar8TzKFxkdQU2gs9MLsy/UY8HAUcMJFVdJ/eVRdDokxdgcxf64npxtM4IEfC85bUKXVjLFXR9Z29LCtNC+Z4EvklxnxZTqwZiZPiNO/Y8r2GOwewjKApoTo2npkdvmimwzdI3nJGrlwv0Z+mnDoOWjOeQFda9x99Iw+rU4LqlaSh2VFbxQvUnwyJxW7N5Pyeqgo7fUuVJJOyniVPdc2sm+LcQJ0fPKdLnYkEmBTGO9e0kSXSKrqh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCGbLO7M6fnOvT13Ot9PQtWTiv8UzSSO1FBMKLX37h8=;
 b=Z+MFUA+xtWfBW1VTQ8rdU2jwXfCaMGKqTX/Pu7piqzrqn3mHjUXVDOlrFWNghpTmix/w+WO5KoECdeYypj/mARRuo9QYUQeZHCREToeWm70M5HgRgMtOJUsIKqeRtcnK/zWydG5LiooJl98kf/BXPePSuZrQMyCLXpSfOC6PZo/QWuoH2MiHOcoCOdeDav2YTsKHsCPf/wV853nQN9cM0oOPCUhe2L61cfrVloAn4S9u4gzRkRQPZxitNG0aWEa3ZYcNzW652JE/OxdL6OQspYqyA0eMHE6tLpKX2PwaqF5XNzcbEHDS9B/oYZzOvYzhEvcI/mJDiHufATBp3nFLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCGbLO7M6fnOvT13Ot9PQtWTiv8UzSSO1FBMKLX37h8=;
 b=XJ8vQZt9CRDOuKhSXGT7vn7pUk4tmggLgjN20myXmMzNLwn9FuSDbnHGpvZOqM076PT5JFV2OjwpQBeiGCJEbWSrKJWQyUZVZpxU8xOzn96jxf42QLxGRHqTed94w+mZ7t8MR1KMQfo2CRHRIhNkHWx38lBzeSTGOlsxmLPiZmo=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3518.eurprd04.prod.outlook.com (52.134.2.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Sat, 26 Oct 2019 15:12:05 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::d0fc:54d4:86f4:b1d2]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::d0fc:54d4:86f4:b1d2%7]) with mapi id 15.20.2367.031; Sat, 26 Oct 2019
 15:12:05 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 0/5] Add initial support for S32V234-EVB
Thread-Topic: [PATCH v7 0/5] Add initial support for S32V234-EVB
Thread-Index: AQHVjA+6DRrQT5jBKkWqimjcJbupCg==
Date:   Sat, 26 Oct 2019 15:12:05 +0000
Message-ID: <VI1PR0402MB2863F1A4B2C0A389429BB50ADF640@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
 <20191016131728.GA56859@kroah.com>
 <VI1PR0402MB28630943CC0820644D26919CDF920@VI1PR0402MB2863.eurprd04.prod.outlook.com>
 <20191026132657.GO14401@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [188.25.212.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: debecda2-60ef-4446-bb89-08d75a26dcef
x-ms-traffictypediagnostic: VI1PR0402MB3518:|VI1PR0402MB3518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB35184F26A9A0598324CC79FCDF640@VI1PR0402MB3518.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0202D21D2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(199004)(189003)(86362001)(76176011)(102836004)(7696005)(186003)(76116006)(66066001)(66476007)(6506007)(53546011)(25786009)(3846002)(6116002)(81166006)(81156014)(446003)(486006)(476003)(66946007)(256004)(14454004)(8936002)(8676002)(26005)(64756008)(66446008)(478600001)(305945005)(7736002)(74316002)(6246003)(7416002)(55016002)(54906003)(99286004)(6436002)(33656002)(229853002)(66556008)(316002)(6916009)(52536014)(5660300002)(2906002)(71190400001)(71200400001)(9686003)(14444005)(4326008)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3518;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wamUzJ5DhxLcyprgtoCemlklTFvMU0yzIEDwDfVzXUcOcOGCRsIlGG0+Ua4a5hIgGsQpcbQoQfOVKIZm6uP8JgxLub5i/vtwbw3rYxgrHE4+IoWtiGTch3ujc25Qs72ikOe1KMZB/CegoLcvLzOhG8vxhhr5UY12kHkxYlwgxbmoEGG3aKfLY726uRjvhnFAXl4QQ7gAmI2hROiIgPqovoxxhEBULnu1xFtkHtCbiCHjuz+Nd9g2/+EI3mXsf+v97JUHjlWoLQA8yOVyOpW45AOBy8MRCfJAjR/3bmAAH0JMBSc1k2GCWlvv94774xDwpmcGLGCfHb/ldqnydNdRKDkotbJCzQTtcOusPbgnUxVKmH2RSeqwxc/r3Wmb0cvDV1qXOs0VDXBS6W0cf6p8zmg/uEayzs9mk0Jn3UQC1UTOcXs7q9LNbqCPQXFawcDK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debecda2-60ef-4446-bb89-08d75a26dcef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2019 15:12:05.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /51MeCl4L0wAAFwRwqAjBKAlg/qBsA4OGnk42yRKpqSnGSzHF4W2we9DOUMOOZ/wQo/GiCYI0bfRHrh38EOpNl9MlLClaTe5YjkUo0rMEog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,=0A=
=0A=
On 10/26/2019 4:27 PM, Shawn Guo wrote:=0A=
> =0A=
> Sorry, no.  It happens occasionally that non-fixing patches are merged=0A=
> during -rc time, mostly because they are supposed to land mainline=0A=
> during merge window, but missed the window for some reason, like=0A=
> subsystem maintainers did not send pull request to Linus in time.=0A=
> Also the patches are only taken in early -rc like rc2.=0A=
> =0A=
=0A=
Okay, thank you for your clarification!=0A=
=0A=
Regards,=0A=
Stefan=0A=
