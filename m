Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBACC04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7745E205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kGRIbIfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfEQClN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 22:41:13 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:9782
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfEQClN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PTwfMgy7lO3Fjrv6jCWVtWw3kNzvBbT0MIAdKWY6GQ=;
 b=kGRIbIfbuO9XjcGSAvjSjo1rF34dDLRQafnack72fm005ThyCt1MEtxEUP1v1FX9AiStaJ4g8b4yNt7U36QHiCvvVfPKUDFglecA/9UgJO/uwmxmvdyqbrekUt/MumUCYkoS3n6BD7o9T3T8Cy3llKIVhuMlcFLzL+tEYzOHMzk=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6349.eurprd04.prod.outlook.com (10.255.118.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 02:41:10 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30%7]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 02:41:10 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: Fixes tag needs some work in the sound-asoc tree
Thread-Topic: linux-next: Fixes tag needs some work in the sound-asoc tree
Thread-Index: AdUMWOUgW4w1G7LAQNer7u1oxDjcrA==
Date:   Fri, 17 May 2019 02:41:10 +0000
Message-ID: <VE1PR04MB64798F450C1128243C83FC4BE30B0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a81c9728-c6ce-4829-aa71-08d6da711ecf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6349;
x-ms-traffictypediagnostic: VE1PR04MB6349:
x-microsoft-antispam-prvs: <VE1PR04MB6349B6CC5C21A80FA7C125A2E30B0@VE1PR04MB6349.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(189003)(199004)(66066001)(316002)(74316002)(5660300002)(9686003)(53936002)(110136005)(54906003)(81156014)(8676002)(7736002)(305945005)(2906002)(6436002)(81166006)(8936002)(52536014)(4744005)(55016002)(229853002)(68736007)(71190400001)(71200400001)(256004)(86362001)(73956011)(66476007)(4326008)(76116006)(66946007)(66446008)(33656002)(476003)(3846002)(486006)(6116002)(64756008)(26005)(7696005)(6506007)(186003)(66556008)(99286004)(25786009)(6246003)(478600001)(102836004)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6349;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KVTVxQCLOCG+x9vAktdlDJMxNtZwOHdZFmwha5i8UsSDK8Xk3TAYFAClMjyXPf/d7R/jXmpq6cfqyawgLnhWRTkb5LOHiu8UX7gG7bSlxnC0zy0+o0MevClm/XlThXV2FRsWWQSlll+9ccVyo5d0AnX7fz3NkJft/4j+UHEqZZrh8fe2tLULCVW0wtTiSexOQ/ASeqnZ3TaOHF+6yHXerLRcnz10loot7yahwoJ2lT1DVMD+jv/vmtRhgjFFe0uC4WyU9H9H+nq3NaACCQvo0nk3/AFN/BHTtW0pQCPmJPsqF9iJ0OqKQc3u7xili1eLhmF6lqCgJLKtV+0ffCb7TSmjNtk26cqoQCdHDpEb92IlzXyL47mVsbk1SvXXKGKS7DngvLYMRGbZoDUzkgQYwAcHQRtd7IBNpKhvzMJAP1g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81c9728-c6ce-4829-aa71-08d6da711ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 02:41:10.2019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=20

   Do I need to resend the patch?

Best regards
Wang shengjiu
>=20
> In commit
>=20
>   b06c58c2a1ee ("ASoC: fsl_asrc: Fix the issue about unsupported rate")
>=20
> Fixes tag
>=20
>   Fixes: fff6e03c7b65 ("ASoC: fsl_asrc: add support for 8-30kHz
>=20
> has these problem(s):
>=20
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>=20
> Please do not split fixes tags over more that one line.
>=20
> --
> Cheers,
> Stephen Rothwell
