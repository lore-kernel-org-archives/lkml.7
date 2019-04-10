Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1592083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="HAVP9Azw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfDJMTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:19:54 -0400
Received: from mail-eopbgr150100.outbound.protection.outlook.com ([40.107.15.100]:6340
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbfDJMTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzIn9mo32GpnUbwp4vQ1zR6bHmaEGPetJzTiCB3uaQw=;
 b=HAVP9Azwx5jAxXl43HcPMXFOr7av2Kx7yVr4hpgEIh5GzsR5Y4BBBKk5gvJKvDIWwzWeugj921LSiIXIsdPtJ7nD+TCcW4dof3bn9DuhicrLIfL/bB6oklvZ53axGuJvFMUGKJhlSfsVsctqyxbjknn/c8pdWRYpAMHUF5pwrzA=
Received: from AM0PR07MB6019.eurprd07.prod.outlook.com (20.178.112.14) by
 AM0PR07MB4420.eurprd07.prod.outlook.com (52.133.52.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.9; Wed, 10 Apr 2019 12:19:50 +0000
Received: from AM0PR07MB6019.eurprd07.prod.outlook.com
 ([fe80::8538:2f6b:1fad:e3e7]) by AM0PR07MB6019.eurprd07.prod.outlook.com
 ([fe80::8538:2f6b:1fad:e3e7%2]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 12:19:50 +0000
From:   "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     "saiprakash.ranjan@codeaurora.org" <saiprakash.ranjan@codeaurora.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drivers: firmware: psci: add support for warm reset
Thread-Topic: [PATCH v2] drivers: firmware: psci: add support for warm reset
Thread-Index: AQHU6k5S07yjvmv7O0aTX3KVdclzwqYs6qoAgABojoCAB/0JgIAACeW2
Date:   Wed, 10 Apr 2019 12:19:50 +0000
Message-ID: <AM0PR07MB601905FDE62061AC5B0B6712F42E0@AM0PR07MB6019.eurprd07.prod.outlook.com>
References: <20190403185123.15873-1-aaro.koskinen@iki.fi>
 <39242b1d62b639f8fdc92029d737b5e0@codeaurora.org>
 <20190405094242.GB17115@darkstar.musicnaut.iki.fi>,<20190410114211.GA31173@e107155-lin>
In-Reply-To: <20190410114211.GA31173@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
x-originating-ip: [131.228.2.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bec30856-d8b7-4938-e853-08d6bdaed468
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR07MB4420;
x-ms-traffictypediagnostic: AM0PR07MB4420:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR07MB4420D72FCEDB223AC468F0EFF42E0@AM0PR07MB4420.eurprd07.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(305945005)(7736002)(14454004)(6506007)(86362001)(11346002)(446003)(66066001)(68736007)(52536014)(74316002)(5660300002)(476003)(478600001)(81156014)(97736004)(486006)(2906002)(81166006)(105586002)(8676002)(966005)(76176011)(55016002)(8936002)(102836004)(99286004)(316002)(110136005)(71190400001)(71200400001)(3846002)(6116002)(4326008)(6246003)(9686003)(53936002)(256004)(25786009)(186003)(6436002)(229853002)(26005)(93886005)(33656002)(7696005)(6306002)(106356001)(4744005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR07MB4420;H:AM0PR07MB6019.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZOYVshku3ZhTn4Iwv2wljHmotVy4idxNEG9glTSdY2d0MBKsoqH6uil55HnXxhg4qk4RlVYmQcRAPlSn11LH51YB/IwUAsZnyunhrvjbqC8W8Sxhu2QHYkBjV5ZowxEJvxvGVWZacep+brHDJXISktHr3VjCXX/dtumBhOW0ou3khq8YEpa6gWFDgldgpNRfyquYsQmwF/MDLVuvt9s7airEaTmhtfeuGCBbpweRbuyd7QaF6SxVUQJLgtWbtOiZuIRGSDGAnySUuPwz2ZJgzfHaAMsjVqamsJ1VaZP85OgK2kFVxCjCisZP0vx43CTiaGsZyi2I7vZtDUK8SK8JbZo3cwZ+nstvzv2lUXsSfOh6Nn2nTavlEZxZ/4kySQcBHVAVe8UXtII+PSaGTU7d9I9UANZpJF3K+LkPgdVzTEg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec30856-d8b7-4938-e853-08d6bdaed468
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 12:19:50.4108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4420
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Sudeep Holla [sudeep.holla@arm.com]:
> On Fri, Apr 05, 2019 at 12:42:43PM +0300, Aaro Koskinen wrote:
> > On Fri, Apr 05, 2019 at 08:58:30AM +0530, saiprakash.ranjan@codeaurora.=
org wrote:
> > > There is already a patch sent by Sudeep for this support.
> > >
> > > - https://lore.kernel.org/lkml/1525257003-8608-1-git-send-email-sudee=
p.holla@arm.com/
> >
> > OK, I have missed that. Sudeep, are you planning to send a new version
> > of this patch? Looks like the last was sent almost a year ago.
> >
>
> Sure I can, if there's a requirement and someone can test it.

Yes, I use this feature.

A.
