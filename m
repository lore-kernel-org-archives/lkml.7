Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620B5C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5922332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eNz9goSM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lltjjhyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfHURgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:36:45 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42449 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfHURgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566409004; x=1597945004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B+0NsIVRJ2doDRYMsxNuGKhsZan7npRyH3nPkIOHjTc=;
  b=eNz9goSMVk64Xq9fNRssLokIbmXhAjmDOrZLJcxJ8TkYvGgqFhcmwEPT
   yvJZBAbcbcf4tLTztfSXAIGyHD0zxJirGOrOOWvsMtv7ryngxN0kMmvV7
   WVlJey3q3DLRcL94jSexL1ZP++nBHhClvwiKxek60DucQg59ogiaK6h7U
   UGfGTiL4f/aY3LNC1Oy5E4MxLuS8oEVyOZZGfwbeAaRnsQe+IbK+QpN2u
   N+M1FpRDOlWOE0SpF5UZZwARkWE7HaKgyhLywjQwO++TCCt2KX4oxLlPP
   ZtAeetFv/KrdpJnh/G2mp5UTAXox10dyUofwyg7dpLlJfi0M+78i/CJE6
   g==;
IronPort-SDR: JW2giqcwh7gMKYkXGRkG+iYD4dHicyUBti1quWMxRTDzzLh8lcaQ5590uFSiOa2xfeTSOsnu1A
 qyx62ym6IiKriRNk2dAl7XywifrIqJvfZmigqD1RuvPDqiKoLHCNFPeHDCb9gOVxct8/Z75w42
 ovhV5YG/nWO5CKcjd02SMsyfTXMpENiRxzAIjWMAXl1wUDfdugY/6am9AnuVwPw6TK5SlOSV8Q
 +sDQW+71Wo3gR8gz2GZhtHTmzLMVfMHRGE2q+HDAleyXy8ydISaUOhs3k234cbPM0vVnz+Ba0Y
 1WY=
X-IronPort-AV: E=Sophos;i="5.64,412,1559491200"; 
   d="scan'208";a="117952154"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 01:36:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adFkrXdZKpwOwQaLVueRHc45kpimiMUkZVCuarcKX68GZ/ivurt7Egum10mMOQT2tyItGnF5Jx547Cb8bZJfPST5+RVQf/qhD1CGInVi2YDjgiUYIO4PR6VYHlFVkr2agicqPEn3YNxbs7EO1WQdgOnMtL9UAjcEYauun2Sr3AWxE52S70BgO1oVOHkQN4U87T8Jl/YVjE18OWnI6RgJhrYnXYyNZ6V0Yo5Qgva8F8CA8GjOSru5+LdUW9mSaJ1fE1kDDb5ehpm4NvfEbfaCJN3q8A6BfTOPKK3VoonySAqj8hE0Mir0b+ngDVrFwZbOYlDyilXRwHEPJFePZeD77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+0NsIVRJ2doDRYMsxNuGKhsZan7npRyH3nPkIOHjTc=;
 b=V6Ay0L+704ETIvnaPpjKPKeEc9Vy7HBuYU/ehbUFPOcx0syoHAEC4PfkSWsvpLZ72GGEaw6aKiJ7rCVh0a1LIPnnztnGvnP3R0HU6oq6Bu8gKdgl6h2WR7HEaTVlrGHgWrxDsTUO9bX0YMo7F1KTAZL13yOvzF+n4wVlgpzFP09sfP0HcM919AIVJW1yXIwWy2mWREm9IK5ZptYH1isjViUp8WtcfvVFoB+LcKeGev8QGuj7HWn5oi47xzuQOBBoiRpDRqrCFohy48KVG27Qwt+lzg6LjEZUIc/wGpR2V/A+MAfZHrY/X2kKSul59X7XyLzaqAGNcaAUck5ZFMkI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+0NsIVRJ2doDRYMsxNuGKhsZan7npRyH3nPkIOHjTc=;
 b=lltjjhyPpWQtvh7IMLM/a/XzrTJWmzX3qyzq3mOmb4I1MG79wcOq403YxE1kt0TfiKakkTos1VRZuaza3xezn8/ZGhdKOX1qEjdux4dge8wNIMafbpQ+d0jgVAIuEYJa4/tqAppZP+9+YxiAYDEFEGyeeV9fnp5LPgHkG6aBcyw=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5575.namprd04.prod.outlook.com (20.178.232.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 17:36:42 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 17:36:42 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Thread-Topic: [v2 PATCH] RISC-V: Optimize tlb flush path.
Thread-Index: AQHVVvDfUBJCIAOoL0y7jXfLdcYugacFsGAAgAAvuoA=
Date:   Wed, 21 Aug 2019 17:36:41 +0000
Message-ID: <fc023b76c2d7685c067660d298613379c95b27e3.camel@wdc.com>
References: <20190820004735.18518-1-atish.patra@wdc.com>
         <20190821144552.GB4925@infradead.org>
In-Reply-To: <20190821144552.GB4925@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 164c4931-1993-4450-0c7e-08d7265e2126
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5575;
x-ms-traffictypediagnostic: BYAPR04MB5575:
x-microsoft-antispam-prvs: <BYAPR04MB55752AC02FD0DFFA43457819FAAA0@BYAPR04MB5575.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(36756003)(476003)(66066001)(3846002)(25786009)(186003)(6486002)(6916009)(1730700003)(256004)(11346002)(6506007)(2616005)(2351001)(81156014)(86362001)(8676002)(446003)(53936002)(71200400001)(486006)(81166006)(478600001)(102836004)(4326008)(316002)(2906002)(26005)(71190400001)(66556008)(6512007)(305945005)(8936002)(4744005)(7736002)(6116002)(6246003)(99286004)(76176011)(14454004)(76116006)(66946007)(5640700003)(66446008)(64756008)(66476007)(54906003)(118296001)(6436002)(229853002)(2501003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5575;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8DzVnHzqhdzLs+q4oHnRFj+A9teR1HXgCmhHl1BivXOjCi0DI7FJctkuMXezbZiztzBfkK04lqTgh/TVv4Z0kQ7UzqyRVxGW5DZBKET9JPMkJdxkNVKXXX89uLbwt6486AbEu7cN1X8tudxtC3IYmuZX5jKMntztbkdUMe75bG3sO3xumak4ouhY0ay+lOPFln/h+bT3X3apIbXCfEpDje/JmnX+yReAf8IDFOCp8oZVsM0WmU43IMxWjR3gxdCoWRQyWxhgr91XQaTS5VLvuH6B+1Xt+WSUkx3aENRUyETKOiu/GI/Kr/izn3XM8E9AyLFcaUKrsejaTLRcYfg2fke0Ot5DEh3kyqCHEh6Vk2v9coIZnlio1hPcIaCL2OoxlBn8PZ3//MDG+tgz0tcjNgnwrVZudgGKb3PdLIrM6os=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <446A4B7D7611124C9F33A40FA32D4225@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164c4931-1993-4450-0c7e-08d7265e2126
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 17:36:41.9748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqcqpCiYyfOAnIyfXzgFgR9Jw8PxFfoyz7LWx26tuCVrhnuSRV6rHHXooNVeGlDG4pTMzM+Mgprrny5L0Xvogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTIxIGF0IDA3OjQ1IC0wNzAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gQnR3LCBmb3IgdGhlIG5leHQgdmVyc2lvbiBpdCBhbHNvIG1pZ2h0IG1ha2Ugc2Vuc2Ug
dG8gZG8gb25lDQo+IG9wdGltaXphdGlvbiBhdCBhIHRpbWUuICBFLmcuIHRoZSBlbXB0eSBjcHVt
YXNrIG9uZSBhcyB0aGUNCj4gZmlyc3QgcGF0Y2gsIHRoZSBsb2NhbCBjcHUgZGlyZWN0bHkgb25l
IG5leHQsIGFuZCB0aGUgdGhyZXNob2xkDQo+IGJhc2VkIGZ1bGwgZmx1c2ggYXMgYSB0aGlyZC4N
Cg0Kb2sgc3VyZS4gSSB3aWxsIHJlZmFjdG9yIG15IG9wdGltaXphdGlvbiBwYXRjaCBhbmQgcmVt
b3ZlIHRoZSBiYXNlDQpwYXRjaChtb3ZpbmcgdGhlIGZ1bmN0aW9ucyBmcm9tIGhlYWRlciB0byB0
bGJmbHVzaC5jKSBhcyB5b3UgaGF2ZQ0KYWxyZWFkeSBzZW50IGl0IG91dC4NCg0KLS0gDQpSZWdh
cmRzLA0KQXRpc2gNCg==
