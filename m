Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A6EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BB1204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plantronics.onmicrosoft.com header.i=@plantronics.onmicrosoft.com header.b="eCT7orgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfC1A13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:27:29 -0400
Received: from mail-eopbgr760121.outbound.protection.outlook.com ([40.107.76.121]:21390
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfC1A13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=plantronics.onmicrosoft.com; s=selector1-plantronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBGHUc1ceKrcLu9Q/zqnx8NXn4Z6HPqw4NDULb3dH90=;
 b=eCT7orgg6bySoMQvbaR00IauuVaqCqhOUJqpnuS9YO48Cng8YyY/Z3TLFiM9Nwvmo2lkdHA5Q3+2Qyx9qNiaRf9xCSUHBFyHty6eNBMfqFqRCKZyVMNTM5CiPHHUySt8u+9LHZe45MmVbyHI2p+RqLJtgr3N2PqKyLlmmlmVQPc=
Received: from BYAPR02MB5607.namprd02.prod.outlook.com (20.177.230.93) by
 BYAPR02MB4408.namprd02.prod.outlook.com (52.135.237.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Thu, 28 Mar 2019 00:27:18 +0000
Received: from BYAPR02MB5607.namprd02.prod.outlook.com
 ([fe80::25a1:583a:a978:21fd]) by BYAPR02MB5607.namprd02.prod.outlook.com
 ([fe80::25a1:583a:a978:21fd%4]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 00:27:18 +0000
From:   "Junge, Terry" <terry.junge@poly.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     "oneukum@suse.de" <oneukum@suse.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] HID: core: move Usage Page concatenation to Main item
Thread-Topic: [PATCH v4] HID: core: move Usage Page concatenation to Main item
Thread-Index: AQHU5IZ+r6lyKkwtx02WiLHUpmG6x6YgME3g
Date:   Thu, 28 Mar 2019 00:27:18 +0000
Message-ID: <BYAPR02MB5607E9396127F67A9A2BEC948A590@BYAPR02MB5607.namprd02.prod.outlook.com>
References: <20190327101848.25477-1-nsaenzjulienne@suse.de>
In-Reply-To: <20190327101848.25477-1-nsaenzjulienne@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=terry.junge@poly.com; 
x-originating-ip: [198.231.9.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae522c19-a230-4507-e7a4-08d6b314231e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4408;
x-ms-traffictypediagnostic: BYAPR02MB4408:
x-microsoft-antispam-prvs: <BYAPR02MB440892414C71A60AAE5729C78A590@BYAPR02MB4408.namprd02.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(13464003)(256004)(486006)(186003)(25786009)(446003)(8936002)(99286004)(305945005)(6116002)(53936002)(11346002)(54906003)(110136005)(102836004)(316002)(66066001)(74316002)(6246003)(478600001)(3846002)(476003)(68736007)(6506007)(55016002)(14454004)(33656002)(9686003)(7736002)(4326008)(2906002)(558084003)(105586002)(106356001)(6436002)(5660300002)(81166006)(71200400001)(229853002)(86362001)(81156014)(71190400001)(52536014)(76176011)(97736004)(8676002)(26005)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR02MB4408;H:BYAPR02MB5607.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: poly.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i9+LSLXiTnmvGE42fRTtI6e4/iWOYNC9VonzzXHUjgSOp3MX3PrqU2pRXIv+0zjAiRADOSib/YJTVaIgpO3YfkAI75AdJnYG9mh7NiO0edC4mRnKihwRzOtuIG8rPNsCTW0wE377apWTYP3qOx+qmmXwsMqHNp2NZqgOT83eNI4zuFvOg8OnOzZcqqJ+Am0QDUpZMOC8fbvrbfajXZdIDArXlZGA97bMXopdAYNpEqANu7i3DgFv3a/m8o14KgcO0m6TwMlXbJopD2SoyVRtFxB4jKXLCmLaARjZnqhA7I6b6x+cLpuNTf+fStIgMQd3M5dzDmPOZrDjA/FDCEv35+JyyAW+CHppdpNr/u99dhG4lex8mux1Tl2h1V/s1rxSFYyAXkS54P1+TApAuyt6edbqtGFGYSVRHrElLQAUVXk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: poly.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae522c19-a230-4507-e7a4-08d6b314231e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 00:27:18.7998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc7c5f16-c55e-417d-aac0-ff6bbfc27f76
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4408
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

V4 looks good to me.

Thanks,
Terry

>-----Original Message-----
>Subject: [PATCH v4] HID: core: move Usage Page concatenation to Main item
>
