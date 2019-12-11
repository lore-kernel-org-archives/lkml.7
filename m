Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C85C2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC2D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitdefender.onmicrosoft.com header.i=@bitdefender.onmicrosoft.com header.b="f/rLSy80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfLKJ3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:29:23 -0500
Received: from mail-eopbgr50133.outbound.protection.outlook.com ([40.107.5.133]:63327
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728398AbfLKJ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:29:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksdSjE29AvW3Ui14zMPQXzFmU7itHQ75XYKZhXJbcSFNG/fI2+VascdSo905RwEXHrofp0TU27GM5FTDMu7f12K5231oiTJL9BgceH6df7UN49Siv9iikmNrgNuRzF/B4Ditmi1OpgInEJ4uQlgNZTXA+i4HKlgbnntx5shN13cvlgQwqqdHc9gm7VDgcRk1jlre+2nJCH5T/vHSlH3pkQnoSFexFW9qqPyPTD26IMN5O0WjQwM0eTBrSIAErbkmda4g7K74WsqjQWLP/4NJ2ZoAbh9Ai7sRgv/yEmj2t1FW9aWrJOZfByAyQ1PdMAOu6Xagp9VT8MKIvwmG8xeHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHfQOaN8333zLLb4pLlKG7B07hj9xdZKMp+SmMKXR4A=;
 b=fs8LtUkNA+5IScVUrNGp0imBJWjTXl1mQUmk7vUh8Arc3uCLpmrwopOQtOH0tiM9s07svW/ueIoO3f7uKFXQxYcxwVl1C3rhOSHWTS8BZk+vi3Gn0Qwu6LKb3RD440Zc+X1Fq0bnBNtVmMtyIfwVMlE0YmbChJ7HYWrSYbo48ImfVFcHq9S47ujbJkqnCRaZ8d7Ugd2ha820oSzCw9AiQ3N9sDUtmriESlliJUO8xpk6gW+dVubJ2KLCc78YasU2zrOceiO/yBMPTiZ8cuPuun+RiuTZOFbjGcaiYlKkjlJCnV+0gAA0543jvZh6McNFAMVt9+tHFGkPpOr6LkjFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHfQOaN8333zLLb4pLlKG7B07hj9xdZKMp+SmMKXR4A=;
 b=f/rLSy80gnF2b6g4kz8Na3zL6eEfzp0c4LNNhYoiY4wm3mCA/l6QGHH1WzkX7Rx999OgISRebD2tpOrWQyIztB/X6gfhzkjgFHnXbmP5esQarT7EMrV41MBHsmUtJwwrmf4LWlat+2rW/YwhIh5jCfQNxcjQLN6SJFup7AAx95A=
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com (20.177.121.157) by
 DB7PR02MB3915.eurprd02.prod.outlook.com (20.176.239.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 11 Dec 2019 09:29:19 +0000
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06]) by DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06%2]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 09:29:19 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: [RFC PATCH v1 4/4] mm/gup: flag to limit follow_page() to transhuge
 pages
Thread-Topic: [RFC PATCH v1 4/4] mm/gup: flag to limit follow_page() to
 transhuge pages
Thread-Index: AdWwBRVo97ip28i7RLG6c8GTBoWkWg==
Date:   Wed, 11 Dec 2019 09:29:19 +0000
Message-ID: <DB7PR02MB3979ECF6271070E49D062EAFBB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mcirjaliu@bitdefender.com; 
x-originating-ip: [91.199.104.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3eea2438-ad6f-43d6-36fb-08d77e1c9991
x-ms-traffictypediagnostic: DB7PR02MB3915:|DB7PR02MB3915:|DB7PR02MB3915:
x-microsoft-antispam-prvs: <DB7PR02MB391530CD79A49CC25E5B0E31BB5A0@DB7PR02MB3915.eurprd02.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(66446008)(64756008)(66946007)(8676002)(2906002)(66556008)(76116006)(6506007)(26005)(66476007)(33656002)(5660300002)(52536014)(316002)(9686003)(86362001)(7696005)(81166006)(81156014)(8936002)(186003)(71200400001)(110136005)(478600001)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB3915;H:DB7PR02MB3979.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bitdefender.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6Tte8+OxnjtJpKs1baGqCor7Pzdsb3tZ2FgcxvVqODHMST0IXJqI43B7BS0+0dHqjb5To7wWc9xbEKzXEAq9D8/YgxFnah+lHMIpkoVPSJ8nq6cCRSEJ+84OljV8D+x+foHTj1CR7uaVWtglyoNKHQuM71hn+ajIwTUwX2lyLxhZ5Xun/Jq1VeSoQQEMkO6Gy1UcDsvjvA4wZfB0cdTZPMqH5pO/zWPvG4XbZdIbsnI1yt1ffcv8HW+JvaqNMzdQxbe8y8y9iBsQ8+poMoWcIfCdt4EAJkwLMShCxktjUIxoZepRHjuSRH5MapVeXcsxRQwimRoG4gx85PPEJQ+I5DqWQbmMWoWATCwBYiRE4yjx/IyJPJU84UU1yenthrSqDrJyq6UviaD5ePFpNB/OCnU/jJWU14gYlM6/HgzFyqYTnbX9YGE6q+8xyjqNMlV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eea2438-ad6f-43d6-36fb-08d77e1c9991
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 09:29:19.5580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4j4wK+QLDPF25NSJKWePu+BzBhtYYRwsiIt4k65y8ndRWB9amlbY7eNP5RtI1s9Gi/1emoZJA2wvmifsISyCZRRX96Dy99Yi/0gc3zMFR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the user needs to look up a transhuge page mapped at a given addr=
ess.
So instead of being given a normal page and having to test it, save some cy=
cles
by filtering out PTE mappings.

Signed-off-by: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c97ea3b..64bbf83 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2579,6 +2579,7 @@ struct page *follow_page(struct vm_area_struct *vma, =
unsigned long address,
 #define FOLL_ANON	0x8000	/* don't do file mappings */
 #define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below=
 */
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
+#define FOLL_HUGE	0x40000 /* only return huge mappings */
=20
 /*
  * NOTE on FOLL_LONGTERM:
diff --git a/mm/gup.c b/mm/gup.c
index 7646bf9..a776bdc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -361,9 +361,11 @@ static struct page *follow_pmd_mask(struct vm_area_str=
uct *vma,
 		if (page)
 			return page;
 	}
-	if (likely(!pmd_trans_huge(pmdval)))
+	if (likely(!pmd_trans_huge(pmdval))) {
+		if (flags & FOLL_HUGE)
+			return ERR_PTR(-EFAULT);
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
-
+	}
 	if ((flags & FOLL_NUMA) && pmd_protnone(pmdval))
 		return no_page_table(vma, flags);
=20
@@ -382,6 +384,8 @@ static struct page *follow_pmd_mask(struct vm_area_stru=
ct *vma,
 	}
 	if (unlikely(!pmd_trans_huge(*pmd))) {
 		spin_unlock(ptl);
+		if (flags & FOLL_HUGE)
+			return ERR_PTR(-EFAULT);
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
 	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
@@ -513,6 +517,8 @@ static struct page *follow_page_mask(struct vm_area_str=
uct *vma,
 	struct page *page;
 	struct mm_struct *mm =3D vma->vm_mm;
=20
+	VM_BUG_ON((flags & (FOLL_SPLIT | FOLL_HUGE)) =3D=3D (FOLL_SPLIT | FOLL_HU=
GE));
+
 	ctx->page_mask =3D 0;
=20
 	/* make this handle hugepd */
@@ -685,6 +691,9 @@ static int check_vma_flags(struct vm_area_struct *vma, =
unsigned long gup_flags)
 	if (gup_flags & FOLL_ANON && !vma_is_anonymous(vma))
 		return -EFAULT;
=20
+	if (gup_flags & FOLL_HUGE && !transparent_hugepage_enabled(vma))
+		return -EFAULT;
+
 	if (write) {
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))
