Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49304C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C7320843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t49uPvWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfDWJUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:20:51 -0400
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:7847
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfDWJUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI+QvS2mxCgQ+V9TP0dMlJkYVt5bZ0kUMQ9d36VXYDg=;
 b=t49uPvWp5PSD+AWQU7vbAZAhjJUO9IpNL6MKg/+IvEK4iDKjMd2thIHGuMb6m/YltfrL7jXGWW7NGAmgQthVRyJNuUM1TuVcipTeIQjVvcBUGh6XO3EFDg9IRf9nvSISca7lhJreH289Z9bshJZGwds0G+KVwNPr6QZCkDmeX90=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5235.eurprd04.prod.outlook.com (20.177.41.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Tue, 23 Apr 2019 09:20:47 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::a1d7:51b5:9893:dcee]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::a1d7:51b5:9893:dcee%2]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 09:20:47 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] scripts/gdb: Add hlist utilities
Thread-Topic: [PATCH 1/3] scripts/gdb: Add hlist utilities
Thread-Index: AQHU+OUlC64SkSXBmEOwbSCd/Y19Cw==
Date:   Tue, 23 Apr 2019 09:20:47 +0000
Message-ID: <AM0PR04MB64346AE2641AACD732C2EF9EEE230@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <cover.1555921081.git.leonard.crestez@nxp.com>
 <aede2c05c333fd599252a74e67904ff7847b0dcf.1555921081.git.leonard.crestez@nxp.com>
 <155596568158.15276.10057207756258850078@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 866f0e80-3d19-44cc-017d-08d6c7ccf877
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5235;
x-ms-traffictypediagnostic: AM0PR04MB5235:
x-microsoft-antispam-prvs: <AM0PR04MB52352B6F65D475FA74D5A21AEE230@AM0PR04MB5235.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(9686003)(4326008)(4744005)(53936002)(2906002)(55016002)(76176011)(6246003)(25786009)(81156014)(5660300002)(8676002)(478600001)(8936002)(81166006)(229853002)(66476007)(66556008)(76116006)(64756008)(66446008)(68736007)(6436002)(52536014)(91956017)(66946007)(73956011)(71200400001)(71190400001)(14454004)(26005)(316002)(97736004)(99286004)(3846002)(74316002)(6116002)(44832011)(446003)(7736002)(486006)(305945005)(256004)(66066001)(102836004)(186003)(6506007)(110136005)(86362001)(33656002)(476003)(54906003)(7696005)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5235;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iPzBM1JkNnuVjWIDqiCCpz96N2JQn1g0PXXKPyvKMoj/wT7JcHtd2jEhysI8R2uGKjpIYDc29PGuFcNfah4ef7I8U6folQHw6L9l5ISmk5B7i6RizxWcyk9/IVO97iTGPvzjJdjJvdD68K4DjbVTcrmDfpzPyqQUHh2ykmIUkj+Dtz5xYgTLcgISq8NF2rv5zZwtUq53diZjXi0bw3ijcQ84V2f27PMdd6583Fnt7xS88FZ4t2drH03MN/9IdQfeBaz71tMHNaDh/NEd0rZKf9ECrUGM3SsX2HwoqnWNmdmZENPqGpdqt7YRkjbCauPlIyF9dkYUijcLEhxbMlzVDH023ntKFKYv3IiOoYkXtavsCqb+7I0U12zO/TWbaJDOVnUGENydj0iVgYFhjQpaA8+PJ7tj8cRao9ARHluURs0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866f0e80-3d19-44cc-017d-08d6c7ccf877
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 09:20:47.3847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/2019 11:41 PM, Stephen Boyd wrote:=0A=
> Quoting Leonard Crestez (2019-04-22 01:26:56)=0A=
>> This allows easily examining kernel hlists in python.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
> =0A=
>> +def hlist_for_each_entry(head, gdbtype, member):=0A=
>> +    for node in hlist_for_each(head):=0A=
>> +        if node.type !=3D hlist_node.get_type().pointer():=0A=
>> +            raise TypeError("Type {} found. Expected struct hlist_head =
*."=0A=
> =0A=
> Maybe drop the full-stop? It looks weird to see struct list_head *.=0A=
=0A=
Makes sense, it was copy/pasted from list_for_each_entry. Since this =0A=
iterates over items from hlist_for_each the check is only useful as an=0A=
assertion anyway so I'll just drop it.=0A=
=0A=
The hlist_for_each/list_for_each raise gdb.GdbError on type mismatch; as =
=0A=
far as I understand the difference is that GdbError won't print a python =
=0A=
backtrace. However these are internal helpers so TypeError makes more sense=
.=0A=
