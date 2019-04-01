Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27678C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC30120880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nQQvKeDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfDATJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:09:07 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:3182
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728678AbfDATJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaTrmAwRCRAXQsYNj6xzz7xfyfHTVdXmEpOEIdwocSI=;
 b=nQQvKeDkGummM/Y6WqdHIRWrMqxAzFmI7NVAD3EIJCgQZjBqLjXEitlJ50SReEXwWDWjla0GjDlQZvvQDzS8lZt/bQ5KRjDG+1iqCmV/CdPBTaHBGbUtd55lvNEmB2O0iVFOUKbe+7EV2Bjf7rW+59/0uwy5aofRHO8OMHryjAE=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2903.eurprd04.prod.outlook.com (10.172.248.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Mon, 1 Apr 2019 19:09:02 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::18a2:3eae:e7c:4d42]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::18a2:3eae:e7c:4d42%5]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 19:09:02 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: of_reserved_mem()/kexec interaction
Thread-Topic: of_reserved_mem()/kexec interaction
Thread-Index: AQHU6L5dIZhcR9BYE0+OQzOMKiwx4Q==
Date:   Mon, 1 Apr 2019 19:09:02 +0000
Message-ID: <DB6PR0402MB2727C7111A5BDBB07F05E29886550@DB6PR0402MB2727.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e77674b4-d860-4a86-a72e-08d6b6d580e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB6PR0402MB2903;
x-ms-traffictypediagnostic: DB6PR0402MB2903:
x-microsoft-antispam-prvs: <DB6PR0402MB2903FC1773EB61FFFF0C17E186550@DB6PR0402MB2903.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(105586002)(54906003)(4326008)(6436002)(186003)(97736004)(7736002)(74316002)(305945005)(99286004)(4744005)(9686003)(6116002)(86362001)(3846002)(53936002)(25786009)(316002)(8936002)(55016002)(2906002)(81156014)(68736007)(52536014)(6506007)(8676002)(7696005)(102836004)(71200400001)(71190400001)(66066001)(256004)(6916009)(5660300002)(81166006)(14454004)(478600001)(476003)(486006)(33656002)(26005)(106356001)(44832011)(340984004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2903;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5Gf16vTfE82VHrhAYvpAe33/U5qIUsgvtsogcNzbAQBYRhLbYfuDS/0T1IvtwRTtM/mMlTcUDole0qA+oL6ku0ZIRMX/ZjXmvZ03pmX+F1GHYsOWUmRuq4so1Q4C0LC9l1uIFH9qNGWpBi8QS9ef4pnfXIpijDgg1aQG/QMklIGJ+TCw7mGEnE0lLKoo6QeR6G18fyDD+ZvinJEFUnuOqLJqWav4t5CblN2kb2NgyyH32/fnDZGo6Aqpu2/pAuNxLAm4eOPPlH9THihbm96ISRqkcOGxrz/TWyhoak+o+VUkr4LYQV5xJtmyGpXIDzlxGpPrw0kvnclXPtTDnLE16GDbGCZx+AomGqjIbdVjdRucyVq0Lf7T5yKvdOhEVzEVbw6X5cl190x6hV4vFFNSFaU13lv9fphqMggaJ03EsgQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77674b4-d860-4a86-a72e-08d6b6d580e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 19:09:02.5424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,=0A=
=0A=
Not sure if you're the right person to address this to but if not=0A=
hopefully someone on the list can assist me.=0A=
=0A=
I'm trying to understand if memory reserved in the device tree via the=0A=
"reserved-memory" facility is preserved during a kexec system call,=0A=
i.e., is the memory at the same location with the contents undisturbed=0A=
when the new kernel starts?=0A=
=0A=
Thanks=0A=
=0A=
Roy=0A=
=0A=
