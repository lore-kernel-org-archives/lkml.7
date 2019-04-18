Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5CAC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0401B214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Awz5R5rX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbfDRLMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:12:49 -0400
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:43488
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388369AbfDRLMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSEUJ46M1pijH/DYhfV1pBizlvBW+L9xh5vAyoiiYp4=;
 b=Awz5R5rXfMvtNQUQKpGnctR8pqLsZRzHGOdDKhRDWLFHE9gBmAaKbFgGqIKqw1+t5RbQDeXd6QKYo7ANep61DiBPR++bnyFVM7JbJCuUeU3LBmeZH9i48RoZZNJsTahGYkocLd6/6jkMd/Lfb73BHn+MiHHnBR4aH03UtYHNKjM=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6383.eurprd04.prod.outlook.com (20.179.232.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Thu, 18 Apr 2019 11:12:45 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019
 11:12:45 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Nicolin Chen <nicoleotsuka@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Thread-Topic: [PATCH] ASoC: fsl_esai: Add pm runtime function
Thread-Index: AdT115NXaHh4QUXfTQKmQnqsBIdDWA==
Date:   Thu, 18 Apr 2019 11:12:45 +0000
Message-ID: <VE1PR04MB6479999444FBBCF81E37E630E3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d085946b-0772-4680-b21f-08d6c3eec899
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6383;
x-ms-traffictypediagnostic: VE1PR04MB6383:
x-microsoft-antispam-prvs: <VE1PR04MB63833D75A4E4C3030AC6AA15E3260@VE1PR04MB6383.eurprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(99286004)(7696005)(8676002)(81156014)(81166006)(97736004)(8936002)(256004)(14444005)(229853002)(486006)(6916009)(6116002)(3846002)(6436002)(5660300002)(52536014)(33656002)(102836004)(186003)(26005)(476003)(6506007)(6246003)(66066001)(71200400001)(54906003)(71190400001)(316002)(53936002)(9686003)(55016002)(4326008)(25786009)(68736007)(305945005)(86362001)(7736002)(14454004)(478600001)(2906002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6383;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CQA8sZrmcyFgYZSyFFinR1aAvdFJ0pbXOVpbv8MG7RHMOO2QLqVAmelwOpOezv6LM/znkCMDCOV51TSRqiXqLaMVmc2Kz3sALW8S3UQocb50p8VErCW1+GGmeMzPKCpfwyf0lHrswM7dED4yXwPnzS/xHviTK5DGFB+t1cvrISGqO4lS/kFq9yWDyOj7nVQsQ9VtSyD5JYfuHCvzC0rYP3L2NjDMZgCEcM//DbIc6LFji3PPL73kXPMKR8F+lc4NFTQ47g898iuWI4XGXcsy68pOHzkWfAC+zEvrHqpJjLozVIBLYLWDqVab4nfnFvaW7rgThivjBiU7AIa8JopDZg+h0Hq/qLwD35r+rgT3Z2Fq5T5Cvv2KdPpO8a8/WOkW4qyDt/9tGZMbMI6xNoagY3xvXMVrdGEdv8nIbi5rRX4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d085946b-0772-4680-b21f-08d6c3eec899
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 11:12:45.3291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> On Thu, Apr 18, 2019 at 10:15:24AM +0000, S.j. Wang wrote:
> > > On Thu, Apr 18, 2019 at 02:00:12AM -0700, Nicolin Chen wrote:
> > > > On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:
>=20
> > > > Just for curiosity, we had similar situation on imx6sx, so we
> > > > added suspend/resume with regcache. Why will the clock enable
> > > > state be lost too? Does CCM on imx8 (might not be called CCM
> > > > though) have any difference? What about clock rate settings?
>=20
> > > That sounds like a bug somewhere else - I'd expect that after resume
> > > the clocking would be restored to the state it was in before suspend.
>=20
> > There is limitation in our internal design. That is in imx8 the power
> > of subsystem will be disabled at suspend, include the clock state , clo=
ck
> rate.
>=20
> Right, that's fairly normal but usually it'd be restored as part of the r=
esume
> process?
>=20
> > This patch is to enable the pm runtime,  so I think it is better to
> > move the clock operation to pm runtime,  and close the clock at
> > suspend to reduce the power.
>=20
> It's definitely good to turn the clock off as much as possible, yes.

Thanks, will send v2.

Best regards
Wang shengjiu
