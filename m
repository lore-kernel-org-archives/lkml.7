Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDD0C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C86122CEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CVXIwvFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbfIELcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:32:13 -0400
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:3631
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388500AbfIELcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:32:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkGXp3y3Q/2OwyTxRmfjJxI6T0S0wkIKiBujUfZOJdbM1WjJaT21vLU/xpExsGqakI8MXjIJ9oWiZk/rjzu8r1+FReokXGjoaK2tvVb6Bty5iwXOQm+5RPne/Z9q7H8NhaPuhTS+F74MyERO73lKLo6w1XxdsujxwWRyD7JBT8A1oOW7W1Ft6FdBY5WwvGo0fWO9QKPQTMO5cZoMbT/X5ErlshNEirZgN1mdBsSY6Z6KHOAVyhORyMvdtqnZTxPYYBlhmQSIIagfMTJSWpH62iFoJYGUTYWvm0A4UMV7U0q7VdnuJiALPXyHYO+W7HcCLTWy10ox2ppg9Pjqc1Cq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBI+FYX1KFSBz1ie9G32vFr88YGL2wi8tUzmwVkl/Ts=;
 b=nioxZGrDqGAsHbpXXixBMVtqrH0PTNUdrRk1JH3IOItMhdwCBZJxJMFJuMHnpk5K02kw4ORcxvMqjRc1gNEZIN5gGCwMbkx1UMcKhaxzx1B+YIpIZLycSy/ZLF2CJbLmU4pT3nAvgiZ4X8ReohpfXc7c0bYRtTyv2uUz8Bl+sEKxHS+8nwM80uXb4ez15LLe6A+hbOiojD5FaLC4HQi+MNECu7owYui9lSs4fQBnZkr/ZrOrB4MkKy7Lyw6HYWKJOkN2Gp0Gn6rT5A3YxldtwiGxcWJKNZJmAL9OZKxNz0KZEHb4iTiYBpn1jk4KYqKqO9M800TEEiSEMcl2Cofcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBI+FYX1KFSBz1ie9G32vFr88YGL2wi8tUzmwVkl/Ts=;
 b=CVXIwvFz/vhR4PeSfuIT9NX/9uv5rzNL+2WAZG2Evu3yXXZWzqyjIgdMFyzzYfSlUbjCmjxgm2CxN0B+8CiRxJSSmGclpuJqyhM0wKVAH+AAUF3qWQioFneLIKVAOwhu1ivxqEKm0qFjOdUzHZNFqur9UoSpZCfruIy95vqeqno=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3549.eurprd04.prod.outlook.com (52.134.4.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Thu, 5 Sep 2019 11:32:06 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb%8]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 11:32:06 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
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
Subject: Re: [PATCH v3 4/7] serial: fsl_linflexuart: Be consistent with the
 name
Thread-Topic: [PATCH v3 4/7] serial: fsl_linflexuart: Be consistent with the
 name
Thread-Index: AQHVY92MysyPIFyCEEuEgtvcGJKDEQ==
Date:   Thu, 5 Sep 2019 11:32:06 +0000
Message-ID: <VI1PR0402MB2863B0A0D1D12FA9CC2515E2DFBB0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
 <20190823191115.18490-5-stefan-gabriel.mirea@nxp.com>
 <20190904075259.GA10983@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47e1512b-c3a7-4c74-72b6-08d731f4ae9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3549;
x-ms-traffictypediagnostic: VI1PR0402MB3549:|VI1PR0402MB3549:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB35498FA3B82BAE402303654CDFBB0@VI1PR0402MB3549.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(2351001)(53936002)(99286004)(76176011)(52536014)(81156014)(102836004)(74316002)(6506007)(53546011)(54906003)(7416002)(4744005)(81166006)(316002)(66066001)(305945005)(71200400001)(6436002)(26005)(71190400001)(7736002)(1730700003)(8936002)(256004)(6916009)(8676002)(5640700003)(186003)(478600001)(7696005)(229853002)(2501003)(66446008)(2906002)(486006)(64756008)(66476007)(66556008)(91956017)(33656002)(6246003)(5660300002)(76116006)(9686003)(86362001)(14454004)(476003)(3846002)(25786009)(446003)(55016002)(4326008)(66946007)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3549;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YScnS9d/ZqGpteTPFTnJ+IzbzrwEDgKzXgySvYv4RMTxgv9MtIym1wole8sfgfEAOarYF79Gl59+FY+HUuXzN0XaHUZacm3DrrOJEBiGKyXZVNapLHCBOI33W4p7xpLIm7f6dmWJbgfM5Ezg9e2xMG8a4AqIkLFwdCU1jrHqbzLIC3PLW5/T7LQSN2TWjmmk3uh62AsrdoXf+cclF/n30nyy6UpzkB5jR7jZYnb78CrH75SwwgMMK04ccT/qtNWrC6TrvC0f51+KxJiX0+Zcx1Kvlh4S9LliC85GI9aOqKPa8Vs7nJi2IutqPVeJYaKtKNLf872vdpG2As9XV+/lirlwhdtVomFSbqL9ZSmY4XAy5jdB/0/OiT1B6D/Ggt6ccpFWxZpRU/TP+t2g4jF/VltV8kmTyAH5XRtzBeW49eE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e1512b-c3a7-4c74-72b6-08d731f4ae9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 11:32:06.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVesSTo2T03B86FCNLPE1Z7ckD0QO5MOIpe0AMvV8z3bvoAi6RWegT3nUl0xPtXkutwBqOKMF+K7xKxyj/D5jo0yh6py+zRFKWUKCSXvDRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,=0A=
=0A=
On 9/4/2019 10:53 AM, gregkh@linuxfoundation.org wrote:=0A=
> On Fri, Aug 23, 2019 at 07:11:37PM +0000, Stefan-gabriel Mirea wrote:=0A=
>> For consistency reasons, spell the controller name as "LINFlexD" in=0A=
>> comments and documentation.=0A=
>>=0A=
>> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>=0A=
>> ---=0A=
>>  Documentation/admin-guide/kernel-parameters.txt | 2 +-=0A=
>>  drivers/tty/serial/Kconfig                      | 8 ++++----=0A=
>>  drivers/tty/serial/fsl_linflexuart.c            | 4 ++--=0A=
>>  include/uapi/linux/serial_core.h                | 4 ++--=0A=
>>  4 files changed, 9 insertions(+), 9 deletions(-)=0A=
> =0A=
> Doesn't apply to my tty-next tree :(=0A=
=0A=
Thanks for letting me know; I will fix this in v4.=0A=
=0A=
Regards,=0A=
Stefan=0A=
