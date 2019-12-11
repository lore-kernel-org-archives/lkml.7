Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DA8C2D0C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3123921D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitdefender.onmicrosoft.com header.i=@bitdefender.onmicrosoft.com header.b="b9H66msa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfLKJ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:29:28 -0500
Received: from mail-eopbgr50133.outbound.protection.outlook.com ([40.107.5.133]:63327
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728420AbfLKJ3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:29:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCNmxrlAuseo2aeUS4FAd8UqxXp0mDZ60JkUyUGj+5ZMRncGKYsAIz3txzbSFvuqd2NCCl1K1RBeWUvTVlA0mGwY37Swkitr5CKKVOfqaX08bDYeaGcWTuaifdXY1UJvclDKr5dBMMtTkYGM65Ch5MaotGN8zLCULG6rUV9m/W5hbYmTw0tg7gye1VauuQXc1knvlFU5OfJUDwpYI6EzFyABizOtea3YSfsF/k7KQlP9G5l5TVEYcXa6gH/mKy6nmqPA8wK+33/Pux/OP/RiqzMhTvHnhW6Sp6e9bGeCqlLYO8pNH61yS8UiN1pB081ahpuCq1zkb5LF6F7K0dPrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDEOIp/sAyFdlZrj/GO/ouorop1i74oV3BWpvZkNoLM=;
 b=fX/NplO9N7sEE1mDAjWrNInq+8jyZaJHRfdsUdINwrzgmtzot4Yn+T38yRiwPfEd2RymKAiIU+urEq+12CdzCA0d/Z+sGn+q/hrHsqLq/XoEWkoUszHV0jYrLnqP/QW0++zdFW59Vbaj6uCWs43b3CRFYMOHNQ6j/PVoFeidEk0NjAHbXUJIyDmRLoqFVN/t4Ilb598um2a1xDuF4PZOQDdHjkQpc3hR3Pw/auV52OpFzYSQ9+hM7OhyX1TOTj0QytvkEA7ithUtTBfGQ9GmHOrjtIJDVbtZBxD0M2V0oh+zZP1SF1TPjcHITgpmnbdgp5iz1omGb4/aJOc3lZbCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDEOIp/sAyFdlZrj/GO/ouorop1i74oV3BWpvZkNoLM=;
 b=b9H66msanuL6QZ30A1Dt78K/rlKNeGKrp49egpnBrBCwjZxeN+a6JnG9Y0nrVWH7ffeTA5oCvZR9+ZlNfqwAHaZRgdntoGaSshMbvYpKpYEBtBpDqQ8cM5kYzh1QEnFuUAqZ0+c4ibL6LHEP8rqMm4RBsR6N8u6ahC9p/VsMrnk=
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com (20.177.121.157) by
 DB7PR02MB3915.eurprd02.prod.outlook.com (20.176.239.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 11 Dec 2019 09:29:20 +0000
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06]) by DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06%2]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 09:29:20 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: [RFC PATCH v1 3/4] thp: fix huge page zapping for special PMDs
Thread-Topic: [RFC PATCH v1 3/4] thp: fix huge page zapping for special PMDs
Thread-Index: AdWwBRVdoL1dw8xpR1utr5q5yXwQBw==
Date:   Wed, 11 Dec 2019 09:29:20 +0000
Message-ID: <DB7PR02MB3979BC324920A783BD5BB721BB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mcirjaliu@bitdefender.com; 
x-originating-ip: [91.199.104.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19eee9f0-ebe8-4a64-4adf-08d77e1c9a25
x-ms-traffictypediagnostic: DB7PR02MB3915:|DB7PR02MB3915:|DB7PR02MB3915:
x-microsoft-antispam-prvs: <DB7PR02MB391518008D1817A6F9574E47BB5A0@DB7PR02MB3915.eurprd02.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(66446008)(64756008)(66946007)(8676002)(2906002)(4744005)(66556008)(76116006)(6506007)(26005)(66476007)(33656002)(5660300002)(52536014)(316002)(9686003)(86362001)(7696005)(81166006)(81156014)(8936002)(186003)(71200400001)(110136005)(478600001)(55016002)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB3915;H:DB7PR02MB3979.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bitdefender.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lZHJspytERe4/WY8paLVlSfrM3DrGwskGVmBuVdPnh9sFzY10ikT45xTZJhtYPxJzZjKH+iV2gg6y7lJfqZbkLFo/WIohDXnUFAw74FjFk+XH3c8wVF1vRoD3zX1isrUf0uWUwKaf/sUNwxJo5cMumkFnm7JAQpnzeB/2QMu0b6YzeJD5Awx0wWyGqRaJwCTzkNN8Rr7rkrEEtt1bt+ujhzvsXGBa4vuK8IgDz7SGCY2hW6vX4gv7PTxa+GxYtxHbu+kNnwRZPd83Q9jpNL5SDxcoiua4MgAIiv4Ncp3tTxHXrjsS6XI3Eqh9adoPbzH2dP+BvHgKONrHqtnU2Z6S6So9BkwZzC+Le32qz83CM3ZBh89fvrteegDIYQW5MqlsvoSYp+fDpITmuUnD2DP4QSRgYrpQ5xqDCGjUJdZ1kgwUKBhkG5xpVlBM6A18ABCru53iAoOxxtnk1FKqDZ1V3Ti4U9KNurMnDzZRkVXpYrV1os1R+NmFR0LNTtl3zl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19eee9f0-ebe8-4a64-4adf-08d77e1c9a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 09:29:20.5374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4HzDgtjH9J2+9n/AFNYK2AWrgwtrXQkM5SFVgZZ8APGUQ5ZSlMkbrTkCjwqLzFgsB+esdFlJp/WMi2VYr/CuYdCOn3XwKr645ZJmRU+3EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling zap_vma_ptes() on VM_PFNMAP VMAs involving huge mappings,
pmd_page() will return an invalid page, causing trouble. Use instead
vm_normal_page_pmd() and test for returned page like zap_pte_range().

Signed-off-by: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
---
 mm/huge_memory.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 41a0fbd..92ce487 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1804,7 +1804,11 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_a=
rea_struct *vma,
 		int flush_needed =3D 1;
=20
 		if (pmd_present(orig_pmd)) {
-			page =3D pmd_page(orig_pmd);
+			page =3D vm_normal_page_pmd(vma, addr, orig_pmd);
+			if (unlikely(!page)) {
+				spin_unlock(ptl);
+				return 1;
+			}
 			page_remove_rmap(page, true);
 			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
