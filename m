Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ACBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536752133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="UDFk/BWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfCSNly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:41:54 -0400
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:62471
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfCSNlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyWV+WhronLy+/fsyjMe3KuckwTlpedZzw4AMSR2Y5U=;
 b=UDFk/BWM3YBU5Dw1jUcRLQ4zuHtNPIK1bX7qDqEZMl4vy96hKIbYhM04p7HrYSYeOnnrC+y9MGUuTE/v8uvBvCS0KHa5BlA6O0XxOJHse2Aw9nrfT17xMROgmKmvlH3O2uX1AFno7uhnKNVdYeeJ7bq5AyiAnc8+K8pS341FT2Q=
Received: from AM6PR05MB5460.eurprd05.prod.outlook.com (20.177.118.158) by
 AM6PR05MB5523.eurprd05.prod.outlook.com (20.177.189.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 13:41:50 +0000
Received: from AM6PR05MB5460.eurprd05.prod.outlook.com
 ([fe80::b042:d31:cd7a:ffe0]) by AM6PR05MB5460.eurprd05.prod.outlook.com
 ([fe80::b042:d31:cd7a:ffe0%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 13:41:50 +0000
From:   Boris Pismenny <borisp@mellanox.com>
To:     Aditya Pakki <pakki001@umn.edu>
CC:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mlx5: Add a missing check on idr_find
Thread-Topic: [PATCH] net: mlx5: Add a missing check on idr_find
Thread-Index: AQHU3diqD2Ywsc2P2ka/ROXZNxhZkaYS90qA
Date:   Tue, 19 Mar 2019 13:41:49 +0000
Message-ID: <e48d6cc9-9bb2-47fc-ec04-eceecbe6d91e@mellanox.com>
References: <20190318221924.7034-1-pakki001@umn.edu>
In-Reply-To: <20190318221924.7034-1-pakki001@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:206:1::25) To AM6PR05MB5460.eurprd05.prod.outlook.com
 (2603:10a6:20b:5b::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=borisp@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.39.71.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e747105e-b355-4629-58ac-08d6ac70a36a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5523;
x-ms-traffictypediagnostic: AM6PR05MB5523:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <AM6PR05MB55238AED1FDD69F31EA03E33B0400@AM6PR05MB5523.eurprd05.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(81156014)(486006)(106356001)(25786009)(6246003)(8676002)(105586002)(81166006)(8936002)(4326008)(6916009)(36756003)(7736002)(476003)(2171002)(53936002)(31686004)(6512007)(305945005)(14454004)(478600001)(256004)(6436002)(54906003)(229853002)(3846002)(97736004)(71200400001)(316002)(71190400001)(86362001)(5660300002)(186003)(2906002)(26005)(68736007)(52116002)(66066001)(6116002)(2616005)(31696002)(11346002)(6486002)(6506007)(386003)(446003)(76176011)(53546011)(102836004)(4744005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5523;H:AM6PR05MB5460.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hrgyDRcIdc2PE392CEMNlvvteCQsn2G0eUKuuNcK1/RhNk7j3W8ptEX2qZtS0jt2cfXzfVpykyZBeBd/xBYoLBOsmRzSaPhWtoE/wi7NhwwMKZDhb7+OW+vbNFwFcQA43wBx9BxUba6hx3wgsjw7nCjHe5X18FpGxtiRi/ZpJjmQk4TbA9417Rk7uYOZbi0c+Pn7fLVGFDDto+olRNQNRdZr5i0wN/EzvF4MlmKDkvewDUAaPsdNm9o7jVvLvgtoIjfKtjZU9TNtreJcNeKarZesxNNlOB2xfwEixalkFaO+8DV/9/GwrqUGeOV8Hd+F1SAMqGeUyHvw9eMaYuwTtGiGl48haIRKXf1OPz3SglTWJtXW06YlPVBfHwyHTC5QzD2NcHGEel0K0EMmQl6naOtQYE8rRkso4rsvqeW8u64=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C7771F4E6E8F547976CE5F5F1E93F30@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e747105e-b355-4629-58ac-08d6ac70a36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 13:41:50.0086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMTkvMjAxOSAxMjoxOCBBTSwgQWRpdHlhIFBha2tpIHdyb3RlOg0KPiBpZHJfZmlu
ZCgpIGNhbiByZXR1cm4gYSBOVUxMIHZhbHVlIHRvICdmbG93JyB3aGljaCBpcyB1c2VkIHdpdGhv
dXQgYSBjaGVjay4NCj4gVGhlIHBhdGNoIGFkZHMgYSBjaGVjayB0byBhdm9pZCBwb3RlbnRpYWwg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLg0KDQpEaWQgeW91IGVuY291bnRlciB0aGlzIGluIHBy
YWN0aWNlPw0KVGhpcyBmbG93IHlvdSBhcmUgc3VnZ2VzdGluZyBzaG91bGRuJ3QgYmUgcG9zc2li
bGUsIGJlY2F1c2UgdGhlIGhhbmRsZSANCmlzIGFsd2F5cyB0aGVyZSB1bnRpbCB0aGUgc29ja2V0
IGlzIGRlc3Ryb3llZCBpbiBza19kZXN0cnVjdC4NCg0KQnV0LCBJIHdvdWxkbid0IG1pbmQgc29t
ZSBkZWZlbnNpdmUgY29kaW5nIGhlcmUuDQpNYXliZSBhbHNvIGEgV0FSTl9PTkNFIDopDQoNCkNv
dWxkIHlvdSBhbHNvIHJlbGVhc2UgYnVmIGluIGNhc2Ugb2YgYW4gZXJyb3IgcmV0dXJuZWQgZnJv
bSANCm1seDVfZnBnYV9zYnVfY29ubl9zZW5kbXNnIGJlbG93Pw0KT3RoZXJ3aXNlLCBJIGNvdWxk
IHN1Ym1pdCBhIHBhdGNoIGZvciB0aGlzLg0K
