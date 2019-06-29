Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4C9C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF9E2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F47D4IZz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="EZCYyz6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfF2AMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 20:12:19 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:57120 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbfF2AMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 20:12:19 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A73FEC01DE;
        Sat, 29 Jun 2019 00:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561767138; bh=nOlAlWpNo01BWL56qYLMRy80e2bYa0D0wpfdGRMV7G8=;
        h=From:To:CC:Subject:Date:From;
        b=F47D4IZz6ipwsUFiak2SpylEpfUTjycO708TCpwoU+MgdciAOnNJb/fRtx/cmV2n9
         XQYJ7SfHrHacbvH5KJ8mwAabMh349e+4LMmEj8NoBYyJmrgmiHp/NVIMFE/ltoYMJD
         PIhBhEmV6TFdrG8jmTQsppKEefdjrVCSaS5wPpg3txXvolA54x66rF3FAIvsrWt65O
         LDmzg+RAlM6CcAXZDCugawNtuS2ZQVy+SA7M4/kzq5RQUFzNufioFTOk3B+A6DetFz
         jzKWZTfFxR9qB9rTx0x8oAoiw/RWcS3W93tRAH37hQV4YPAo4MUUreqORqb9Wu6jmd
         5AwPVjz6NpsHg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A45F9A023B;
        Sat, 29 Jun 2019 00:12:12 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 28 Jun 2019 17:12:11 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 28 Jun 2019 17:12:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=wF9late9MJGgkaCXOFYzlzzxaMvamPmBLdFnE/V4+elRpFy58NxnAlmxez8tfNYI/Hc6ZRV2Idh2ZCL5+pvkRA9cWCRMb1IFgwHPZ6T0zaE6S6HVcrxQof5Gp7CiX9WHIk/cxMxpuctDhyHbiPshTmQFr77xcAJKFw/ghK5RbSY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOlAlWpNo01BWL56qYLMRy80e2bYa0D0wpfdGRMV7G8=;
 b=CWx0lls2tmRN3HN3LbnM8+xAgNXoKvGX+SqsU2r9uGARi6xNb9jAMao/fNQ5najTkUnaoRXuP0hWz3Hpd3uxGVu89s/ZUrMCCzEsXgfTI+v0rZI6UoXPahxsCepXxhBcOOHcbZnUCk8Cj3ncZfwODzT08CYiRqZtyzlxV7R8d5A=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOlAlWpNo01BWL56qYLMRy80e2bYa0D0wpfdGRMV7G8=;
 b=EZCYyz6Y2ZFpP/QAuOFxINz7SrdoV5crWAvLkVNObQlK9A8SWuEL5VTeApfcSmPPrnPwjWiPrxlWK/ix7UrF0lVk7Gld8uIVZxm3kYmKE2gCO5fGEQnd6x/rYtS/dYEffEH9QLTyT65a9Jq7xZooWa4ZGpxYOJLmvDpHm2wnKo4=
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com (10.174.238.140) by
 BN6PR1201MB0114.namprd12.prod.outlook.com (10.174.238.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Sat, 29 Jun 2019 00:12:09 +0000
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::c4ec:41a0:dfb5:767f]) by BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::c4ec:41a0:dfb5:767f%10]) with mapi id 15.20.2032.019; Sat, 29 Jun
 2019 00:12:09 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [GIT PULL] ARC fixes for 5.2-rc7
Thread-Topic: [GIT PULL] ARC fixes for 5.2-rc7
Thread-Index: AQHVLg9KYUZa5XxzYUiJYcdcibUv0w==
Date:   Sat, 29 Jun 2019 00:12:09 +0000
Message-ID: <b799ad4e-cafb-bf1f-3d92-34a5035ea7b5@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [198.182.56.5]
x-clientproxiedby: BYAPR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:40::40) To BN6PR1201MB0035.namprd12.prod.outlook.com
 (2603:10b6:405:4d::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mozilla-news-host: news://gmane.comp.lib.uclibc.buildroot:119
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3e07468-810c-4901-ad5f-08d6fc266d0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR1201MB0114;
x-ms-traffictypediagnostic: BN6PR1201MB0114:
x-microsoft-antispam-prvs: <BN6PR1201MB0114F098419DA8216203FF4BB6FF0@BN6PR1201MB0114.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 0083A7F08A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(6512007)(31696002)(186003)(65806001)(31686004)(14454004)(65826007)(54906003)(6916009)(316002)(64756008)(65956001)(4326008)(66946007)(66446008)(66066001)(73956011)(66476007)(6116002)(3846002)(5660300002)(58126008)(4744005)(53936002)(36756003)(25786009)(2906002)(256004)(6436002)(66556008)(71200400001)(64126003)(52116002)(478600001)(486006)(71190400001)(99286004)(6486002)(7736002)(476003)(68736007)(102836004)(107886003)(8936002)(26005)(81166006)(6506007)(386003)(8676002)(81156014)(2616005)(86362001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1201MB0114;H:BN6PR1201MB0035.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jymTKMSDMDxr2QDS32ROYqH/h/fj4S1qb8LSQDAQF8EwxV28oMGVoPCzK6Td0xysawtkp1IYwHcQfVrWDNzqgjabmQvA0UE2SCIotA4lZXQFnUO/WIij3mNjK8YeMpRwkeL6p4s0EaIgCrWvJW0vP4GlLOVaEB0Vzf5lRgD9y0+t5P1ltFs/t7g5qaED82fNugUhef3MJMpDXuJDiTXWOXOLC58+ylgk8lsUKC8f1umyr4vdqcxteafGxdqePdogu7bPEW/gY/qGvXaq6BNeVURcrqqGJOqMg7qS9K4Jgneod68YeWcRT8TAsiA+mf4bihIO0Qzy1iV9dl/KjKvTUXT2B91hXoZR86TSGuiMvX2pxmgj5zN2+vjqVJLh3ANKCsZAh9mx6R0A6T0V6VhLRMnvsqDOjFs90EMevBexsIc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6C99DB56E21B64FB46A4FCDC12B094C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e07468-810c-4901-ad5f-08d6fc266d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2019 00:12:09.2010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgupta@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0114
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClBsZWFzZSBwdWxsIHNvbWUgZml4ZXMgZm9yIEFSQy4NCg0KVGh4LA0KLVZp
bmVldA0KDQotLS0tLS0tLS0tLS0tPg0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1p
dCBkMWZkYjZkOGY2YTQxMDlhNDI2MzE3NmM4NGI4OTkwNzZhNWY4MDA4Og0KDQogIExpbnV4IDUu
Mi1yYzQgKDIwMTktMDYtMDggMjA6MjQ6NDYgLTA3MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhl
IGdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC92Z3VwdGEvYXJjLmdpdC8gdGFncy9hcmMtNS4yLXJjNw0KDQpmb3IgeW91
IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZWM5YjRmZWIxZTQxNTg3YzE1ZDQzZDIzNzg0NDE5MzMx
ODM4OWRjMzoNCg0KICBBUkM6IFtwbGF0LWhzZGtdOiB1bmlmeSBtZW1vcnkgYXBlcnR1cmVzIGNv
bmZpZ3VyYXRpb24gKDIwMTktMDYtMTEgMTE6NDg6MzQgLTA3MDApDQoNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkFSQyBm
aXhlcyBmb3IgNS4yLXJjNw0KDQogLSBoc2RrIHBsYXRmb3JtIHVuaWZ5aW5nIGFwZXJ0dXJlcw0K
DQogLSBidWlsZCBzeXN0ZW0gQ1JPU1NfQ09NUElMRSBwcmVmaXgNCg0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQWxleGV5
IEJyb2RraW4gKDEpOg0KICAgICAgQVJDOiBidWlsZDogVHJ5IHRvIGd1ZXNzIENST1NTX0NPTVBJ
TEUgd2l0aCBjYy1jcm9zcy1wcmVmaXgNCg0KRXVnZW5peSBQYWx0c2V2ICgxKToNCiAgICAgIEFS
QzogW3BsYXQtaHNka106IHVuaWZ5IG1lbW9yeSBhcGVydHVyZXMgY29uZmlndXJhdGlvbg0KDQog
YXJjaC9hcmMvTWFrZWZpbGUgICAgICAgICAgICAgfCAgIDQgKysNCiBhcmNoL2FyYy9wbGF0LWhz
ZGsvcGxhdGZvcm0uYyB8IDE2MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDE1NyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0K
