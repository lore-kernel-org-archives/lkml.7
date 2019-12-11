Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0DFC2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11CB21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitdefender.onmicrosoft.com header.i=@bitdefender.onmicrosoft.com header.b="KvuCHri7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfLKJ33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:29:29 -0500
Received: from mail-eopbgr50108.outbound.protection.outlook.com ([40.107.5.108]:9444
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727493AbfLKJ31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:29:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNDVyJ4jl+XNz4kHCz6DQGL7bzCEJx4g++DqaNJ4LZeW/1oVlvaDN1zVhEfCxDICI+LfE3LMKybssO9Zk29zcUSL7wa22jIdb43oHYZssFkax0CZkvF0s45GnvzQHME4/ArksEYvuwpN73k9nXJB9RXRsJgFeuuhvcUBQ2vTrMR0VXnN2eP86tp4pNV+kO9H/ltQ+2+EjLuHmKtD9/QCJLR0SJXGfOgLbR0iBWF0YrOkOw1qXbUatP4Vg/bcAtlqM8ZU4a7d/vlRRtDdrHw2Xr13CQ7wviLhsZoOQbZ5GRe3lPxr55RpjL3gF2geznBXB30EFTVDvVW5nffQmuCj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2/G2JI7OGvFmNlfq/NWtPv9WTChNoOLtjGPZqFQMsA=;
 b=GoptXlKExVGHl2JZRhMATig5J8XZIWjMHEFwU87o56qQtkUxMCxFstDyV+X9zFgGFkF+mnrcVkZNdBiCHLA9ZBTzbPKdRT99H1K4VqF/9TpNuZBZP6jmhDIL72iD+A3PUm8GvNxKnFc9pwxmWiljiuYzCCWkvJykHBInxHQWW/Gf1XY8XMbYWGgLXcRyQZD0tFj/TdjXqMI7ejVfOQn8RT0wdGQEDjNnGTi+gjdbw9HoIunxAfvYs3f9kCNIohoEhLtk9BmQ7VDe40sj+nyoHRHUjNQyrjoFV01ARbai8eDn9c1HSXhQr5Ptu3/EdPen42yOHpuR+cC2VXKupixOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2/G2JI7OGvFmNlfq/NWtPv9WTChNoOLtjGPZqFQMsA=;
 b=KvuCHri7Ui8RBYebOeB2+CxwfgsNWYILyP8R43Iywbhdllm91yKdau61Yw4/PmZhJtHN+7XnIYdBeSs22zYbE/BH0Gu8aPha5AXJi619Nfpw5twu7o+sMDW1+19FP56Z/oxeefkJlXnZ6dWoFVvWGmDIx9EXAj4iWk8SfgSAAPU=
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com (20.177.121.157) by
 DB7PR02MB3915.eurprd02.prod.outlook.com (20.176.239.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 11 Dec 2019 09:29:21 +0000
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06]) by DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06%2]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 09:29:21 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: [RFC PATCH v1 2/4] mm: also set VMA in khugepaged range invalidation
Thread-Topic: [RFC PATCH v1 2/4] mm: also set VMA in khugepaged range
 invalidation
Thread-Index: AdWwBEq3Z5BwlJ79QIOTA1r/KOTZSg==
Date:   Wed, 11 Dec 2019 09:29:21 +0000
Message-ID: <DB7PR02MB3979E79A7ADF7E7B2F397418BB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mcirjaliu@bitdefender.com; 
x-originating-ip: [91.199.104.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 377151f8-5c14-499a-88ff-08d77e1c9ac9
x-ms-traffictypediagnostic: DB7PR02MB3915:|DB7PR02MB3915:|DB7PR02MB3915:
x-microsoft-antispam-prvs: <DB7PR02MB3915962598252FA1F477D994BB5A0@DB7PR02MB3915.eurprd02.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(66446008)(64756008)(66946007)(8676002)(2906002)(4744005)(66556008)(76116006)(6506007)(26005)(66476007)(33656002)(5660300002)(52536014)(316002)(9686003)(86362001)(7696005)(81166006)(81156014)(8936002)(186003)(71200400001)(110136005)(478600001)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB3915;H:DB7PR02MB3979.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bitdefender.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iR2f6O2cAssgiIKmul9pVCayEp7JP7j/d+Wde660gdBfuVIHdylmtCSFXJ3vmOErlMNBYV9uiLToJqVX7sN2CX69987sYp/IIE4iVNontBMI83B4ylBV/7EhqgR78WI3ZfiXjaGl23y41CrsOiv6i7rWRMpIEf2fj8Pj1KBGmLF89rcZgE4pPE2L9jkv86i5pf4A264l1hPFZgtDKtfSNIQtDgo8YcKLEy3wmAXxKOjQz5Nuxud66W4uIRcZRfQzrIAozKYWnFhXsPDF6Y8wP1ykw5WLcgEUC+jC5+uHqEUZn5TzWpfFlDtW2e+ELJ1sccxHgeEcOuZd43UTTQJ3hSLQkUBOh8pTEuSeg4IOq27oNEdpQpuFKNMzAOtLVrbhRQynVSEZ32ze9Vpx7SJ+hpHL1VLifzNR5+LVEQ/sNRDnC95AiYNgj5vgsTnEWpih
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377151f8-5c14-499a-88ff-08d77e1c9ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 09:29:21.5878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvIiDXZlGSOw/I7W1wp/h21xpsSC47jAeetnJoMtnCXaFYIlNRFrmJGA0iVgIplbCFKtNpnaFodFqoPmmDnAG6rXxawYnl5ICG/4i/QaHEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU notifier client may need the VMA for extra info.
This change is needed by the remote mapping feature that inspects anon VMAs
with huge mappings.=20

Signed-off-by: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908..11c65f3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1028,7 +1028,7 @@ static void collapse_huge_page(struct mm_struct *mm,
=20
 	anon_vma_lock_write(vma->anon_vma);
=20
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
 				address, address + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);

