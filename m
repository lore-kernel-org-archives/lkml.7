Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C56C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B2A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="xUuyqFNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfFQRK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:10:56 -0400
Received: from mail-eopbgr800057.outbound.protection.outlook.com ([40.107.80.57]:31044
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfFQRK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6/9bMpjkr8GCHmWokXiRqaa2q6skbMX+oqFQL+bWW8=;
 b=xUuyqFNWEZDAduMvAJIwEin1lellkZ13+pqRJJKkpDT9njzPB5exZSoHGp9LctkTlNwtefH8ZvJT1MkyRHA0RcYNyiN6iqYPaEhhYi1+EfUOL6UKriSYWt/+iMduqZgM/jkOc2YrwB7UbmYjedQnYDCPs3T45tZz8PbrinjrvIE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6231.namprd05.prod.outlook.com (20.178.55.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.7; Mon, 17 Jun 2019 17:10:53 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2008.007; Mon, 17 Jun 2019
 17:10:53 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 8/9] x86/tlb: Privatize cpu_tlbstate
Thread-Topic: [PATCH 8/9] x86/tlb: Privatize cpu_tlbstate
Thread-Index: AQHVIbQreKn7WfxntEmYeeU24A7ls6abUKYAgATLLQA=
Date:   Mon, 17 Jun 2019 17:10:52 +0000
Message-ID: <267BA011-6230-42F3-9A44-67336EDB5A0E@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
 <20190613064813.8102-9-namit@vmware.com>
 <20190614155838.GD12191@linux.intel.com>
In-Reply-To: <20190614155838.GD12191@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb1c8363-7911-4bd0-0e23-08d6f346c100
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6231;
x-ms-traffictypediagnostic: BYAPR05MB6231:
x-microsoft-antispam-prvs: <BYAPR05MB6231D4B918CF1B7D2C42AAE5D0EB0@BYAPR05MB6231.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(102836004)(316002)(5660300002)(71190400001)(2616005)(11346002)(256004)(446003)(6916009)(66946007)(4744005)(6116002)(3846002)(36756003)(86362001)(66476007)(54906003)(73956011)(66446008)(64756008)(76116006)(6506007)(14454004)(4326008)(66066001)(486006)(76176011)(8936002)(6246003)(33656002)(8676002)(26005)(53936002)(6512007)(6486002)(6436002)(25786009)(71200400001)(99286004)(7736002)(229853002)(53546011)(305945005)(186003)(81156014)(81166006)(478600001)(68736007)(2906002)(476003)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6231;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qcj7jh2iZ90YoWDTeoOFsF2LTrxgSYOjnlKOie00M9Z+PaWeYgvfpGwUErpb1XNqzvcxTHM/Eu/zvXRYgo/ft+lQVYwWE2Z1Z9OhrLqN4OQSWEZ2vaotkYa9ZFX2AWTsMQPLbOtJV2YtL2WmV11l7eJ2We0FJZm9tJwG6GU7hjeNOKMbjRPijOl17rkWV2fxEzbf+4uK/4mGV7JrKZlZg8B1XVx4QuuyDlIvF7UaryvrIHl1cABXHBPPShEgpHlfp4SgQZxzIcJ5Ky5lX25vD6SWRQQRt5SnTsbShWsCxq+9BWozJX4GDuP4YySZ8yhw5m0Qz2XHeLcfNazcI3lhEL79Nso47r3l5jAS0rsq7QnrQeLzLmN9wQYowdK5G6Q0sf8X47mCS9+PZgGN/UFT1YM/1UHvszw6ankrT6fVXWs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EFE7AB0D75561447A56AB2355C6D9562@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1c8363-7911-4bd0-0e23-08d6f346c100
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 17:10:52.9551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jun 14, 2019, at 8:58 AM, Sean Christopherson <sean.j.christopherson@i=
ntel.com> wrote:
>=20
> On Wed, Jun 12, 2019 at 11:48:12PM -0700, Nadav Amit wrote:
>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbf=
lush.h
>> index 79272938cf79..a1fea36d5292 100644
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>=20
> ...
>=20
>> @@ -439,6 +442,7 @@ static inline void __native_flush_tlb_one_user(unsig=
ned long addr)
>> {
>> 	u32 loaded_mm_asid =3D this_cpu_read(cpu_tlbstate.loaded_mm_asid);
>>=20
>> +	//invpcid_flush_one(kern_pcid(loaded_mm_asid), addr);
>=20
> Leftover debug/testing code.

Indeed, thanks. I will fix on v2 (once I get some more feedback).

