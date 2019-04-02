Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F33C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB9A20830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="NqygnWHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfDBIBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:01:30 -0400
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:21091
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727280AbfDBIB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlAdU1BqMmTI7++2JLak0dAfwdTETsRUF0zwq9+RdBg=;
 b=NqygnWHCeUnR0vwK8CKa0M8IOr03TaEITrxsu72QQlXThfg3P24PwSo5rzciVH42yFKlQhzPDyYp1t/8EQBGqyzuwecVPUSrzY5/mmSdAASd9LNJT/bXGUHJzYDMJMaGtfBJhQnlKhYfshyP92jf2JfIStyS5F8dTbcHOP1A+30=
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com (20.178.104.212) by
 DB7PR06MB5467.eurprd06.prod.outlook.com (20.178.84.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 08:01:22 +0000
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478]) by DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478%5]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 08:01:22 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [RFC PATCH 0/1] Verify if register is writeable before a write
 operation
Thread-Topic: [RFC PATCH 0/1] Verify if register is writeable before a write
 operation
Thread-Index: AQHU6SpCH+elfRTYxUC2yBnpz2K3ww==
Date:   Tue, 2 Apr 2019 08:01:21 +0000
Message-ID: <20190402080100.4875-1-nandor.han@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0046.eurprd04.prod.outlook.com
 (2603:10a6:3:19::14) To DB7PR06MB5563.eurprd06.prod.outlook.com
 (2603:10a6:10:83::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a2297b3-f41d-4733-a90c-08d6b7416517
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR06MB5467;
x-ms-traffictypediagnostic: DB7PR06MB5467:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <DB7PR06MB5467BDAA15FF7B0F3E8021C085560@DB7PR06MB5467.eurprd06.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39850400004)(366004)(189003)(199004)(6506007)(2616005)(97736004)(106356001)(71190400001)(256004)(6436002)(50226002)(81166006)(476003)(2501003)(14454004)(105586002)(186003)(71200400001)(8936002)(53936002)(386003)(486006)(6512007)(6116002)(3846002)(52116002)(25786009)(15650500001)(2906002)(305945005)(102836004)(4326008)(2201001)(86362001)(99286004)(68736007)(66066001)(107886003)(7736002)(1076003)(478600001)(8676002)(316002)(26005)(5660300002)(14444005)(36756003)(81156014)(6486002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB5467;H:DB7PR06MB5563.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pOMfUd6Pwk523t7O3gMBQspUFQS35dy6oFLfUwnIXw2eAoH13FhDM/kNAgjcvR4In6LNgLmVSUQx0yKIdogdG5msekNs1eWsE6o/h5ZSHty/uq+ufKFdNoClD5UqE1Mr+JzQAJPQkefO9H+68NWqeJbC2DG4CyJVsycR2CZKSaLej8B39rlt/tAeBzxU4UVSmAyZ565+dEuFXe4MMKJy3B8WydePKkRTiPZpKiBOu9kSsAfsUrc/v3TznqkId0sIt06QZfs7owsubTbfV93cWHmEdNzFgmAwOA0B52kgsi1op1HqPfzMON+OOm60A1IWmd31laBQXuKtOTQmTkwXoUp1U4JO6pp87fgNn3kxqXEDOu2DSS11aPUaohBY/jwCS7rxJgzPMLbCKWr/Od+lZdOxqqQmJYlyKFUWtafIt0M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2297b3-f41d-4733-a90c-08d6b7416517
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 08:01:21.9222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5467
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Description
-----------
This is an RFC because I don't know if this is a bug or a normal use
case. It seems that the function `_regmap_raw_write_impl` from the regmap
framework verifies that a register is writable only using
the callback function, ignoring the other two (max allowed register,
register ranges)

Note: As a left right look I did check also `_regmap_raw_read` function,
and it seems that is missing this checks completely.
Is this a problem as well?

Device/Subsystems Impacted
-------------------------
This will impact drivers that end up using raw writes (firmware
download, ...)


Testing
-------
Test configuration:
- Kernel Version: 4.14.60 (just for clarification, the patch is rebased on =
master)
- The testing was done using a driver that has NVMEM support and is
  using `regmap_bulk_write` method to write data to registers.
- The valid register range is 0x00->0xFF.

1. Configure a nvcell (4 bytes long) in DT which is outside the valid regis=
ter range.
2. Write data to NVMEM using the nvcell
3. Verify the result:
3.1 Without the patch the data write in registers is successful with
no error displayed.
3.2 With the patch the data write is denied and an error is displayed.

Nandor Han (1):
  regmap: verify if register is writeable before writing operations

 drivers/base/regmap/regmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--=20
2.17.2

