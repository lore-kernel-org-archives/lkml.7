Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313DDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C1F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="PAsqPkLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfCSPAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:00:50 -0400
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:19067
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727427AbfCSPAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3gXZVzw8u7eb7sDy3X3WguMWxTHfEIU0rAXm+ndmgg=;
 b=PAsqPkLOkU59GQBjDfVstDJUIBgppCfU7xYXJxqFYXB6Xfe0Ya4r3phYjwgr0ce2dLA9tmiP+vqYTs2NpIKO133ESykCC3EZT3dH5PHaEGBmTPn0PpWhv18Z0tcY5h0IiDYYGDLESkE7H9jKFKoyUslYm02bhpfR4T5gtF+XrhQ=
Received: from AM6PR05MB5460.eurprd05.prod.outlook.com (20.177.118.158) by
 AM6PR05MB4134.eurprd05.prod.outlook.com (52.135.161.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 15:00:45 +0000
Received: from AM6PR05MB5460.eurprd05.prod.outlook.com
 ([fe80::b042:d31:cd7a:ffe0]) by AM6PR05MB5460.eurprd05.prod.outlook.com
 ([fe80::b042:d31:cd7a:ffe0%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 15:00:45 +0000
From:   Boris Pismenny <borisp@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Aditya Pakki <pakki001@umn.edu>, "kjlu@umn.edu" <kjlu@umn.edu>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mlx5: Add a missing check on idr_find
Thread-Topic: [PATCH] net: mlx5: Add a missing check on idr_find
Thread-Index: AQHU3diqD2Ywsc2P2ka/ROXZNxhZkaYTGNGA///tYoCAAAcegA==
Date:   Tue, 19 Mar 2019 15:00:45 +0000
Message-ID: <e5610b7a-2aa8-be54-a559-16106b4c3cca@mellanox.com>
References: <20190318221924.7034-1-pakki001@umn.edu>
 <e48d6cc9-9bb2-47fc-ec04-eceecbe6d91e@mellanox.com>
 <20190319143507.GO4823@mtr-leonro.mtl.com>
In-Reply-To: <20190319143507.GO4823@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::27) To AM6PR05MB5460.eurprd05.prod.outlook.com
 (2603:10a6:20b:5b::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=borisp@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.39.71.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4252c31-962b-4f03-05c2-08d6ac7ba9df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4134;
x-ms-traffictypediagnostic: AM6PR05MB4134:
x-ms-exchange-purlcount: 1
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <AM6PR05MB413402C7890F328A936E8F64B0400@AM6PR05MB4134.eurprd05.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(136003)(346002)(189003)(199004)(76176011)(52116002)(86362001)(25786009)(4326008)(68736007)(99286004)(6436002)(8936002)(6246003)(14454004)(26005)(71190400001)(71200400001)(446003)(2906002)(2616005)(476003)(5660300002)(478600001)(53546011)(186003)(102836004)(11346002)(486006)(6506007)(386003)(36756003)(966005)(6486002)(53936002)(305945005)(6306002)(6512007)(7736002)(97736004)(6116002)(105586002)(31686004)(3846002)(8676002)(54906003)(81156014)(316002)(256004)(6916009)(31696002)(81166006)(229853002)(106356001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4134;H:AM6PR05MB5460.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bJyCBL8suNkN4vIycgiSxz1bpTxCtApOHafb6H9aGvZ8h/21xzUHLu1b9F5T3IWS0WtvVvpU5rJ1R05hq7dPfhV1eYM74UmtIF1FBWhi7rd4yO/o0IYN6CigMfZXFdOGSsmlo0GTtynhzLsBEq+NZ//8EpLqAyLDaN7DTDhGre51/T+6sppOSHfDsKDIqVPnzM+oLWz89u8Nf/eIB8u/zNRg/dewhkQiHP0vF20JhN73meG/xuePCu7U2JET6e7nC40mYlDkBOQxJA0SACTFjVGrcij/U5l+IkB8vjte+CL8eGjRUiN3y6lDV9d8TwNid6llFI8nDXaq1y0dyRqnpFJbUM/8HC7bruRIvjyWbwdj59rDuLIViUuyABZ4dpMHxC5oTxiYt8xfj+A7WXuEps5GYQCGY4TlxuLgeKHj5wI=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <12252F3B82AAD142A7066BB416C5C6C0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4252c31-962b-4f03-05c2-08d6ac7ba9df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 15:00:45.3516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leon,


On 3/19/2019 4:35 PM, Leon Romanovsky wrote:
> On Tue, Mar 19, 2019 at 01:41:49PM +0000, Boris Pismenny wrote:
>>
>>
>> On 3/19/2019 12:18 AM, Aditya Pakki wrote:
>>> idr_find() can return a NULL value to 'flow' which is used without a ch=
eck.
>>> The patch adds a check to avoid potential NULL pointer dereference.
>>
>> Did you encounter this in practice?
>> This flow you are suggesting shouldn't be possible, because the handle
>> is always there until the socket is destroyed in sk_destruct.
>>
>> But, I wouldn't mind some defensive coding here.
>> Maybe also a WARN_ONCE :)
>>
>> Could you also release buf in case of an error returned from
>> mlx5_fpga_sbu_conn_sendmsg below?
>> Otherwise, I could submit a patch for this.
>=20
> Boris,
>=20
> Can you please invest ten seconds to read previous emails prior to answer=
ing?
> https://lkml.org/lkml/2019/3/19/36
>=20
The fix you suggested is valid and should be addressed as well.

I didn't comment on your reply, but it doesn't mean that I disagree.
