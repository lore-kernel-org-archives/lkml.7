Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D58C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CD521882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="W/KOgsMC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Q92BeAbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfKHD7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:59:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15350 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726281AbfKHD7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:59:01 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA83wPUq013892;
        Thu, 7 Nov 2019 19:58:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=PMJkFvfdxAbc44iWcknGwJK1YPCnbByEspL9fg4ie2w=;
 b=W/KOgsMCP7karFM2Nx7PaVPkNNNviUouyfYgeOa8nBvoKPqRgTH8oqvEBYao6xFrQ+G0
 VMlk4GMzSIw3lRRHGOwPDdDLrCR/TW086iv8My5J0eQ+Jp3ETwiROLZQktD4Xv/NQzOL
 6HVCsTiZCIU0TaAkmN0EhCCTBiKjbOcF+xI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41w716pd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Nov 2019 19:58:48 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 7 Nov 2019 19:58:46 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 7 Nov 2019 19:58:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xx5Hx+rRMf/tOtozeiRKo/Qv4ElUoNUtEf1butHw16SPM8a9K8z27GKMolD7uGVrWtwPsiRAVrYglkJvRb8CC6uKZLUUIZqroSPgaeQ988TcRx275xOd5HBUCImQNrN9AvH6ZOoKrsGxOpMZEeBiGZclU/zd2wpRatKhGMoGuQrAdDCjZb9JWCWGdurCqbXfNjlAZ9OjEbYHAkhMw2zd3AIrtilgZvoxsT0Tk+PIZ6ztfHZZMzqPn0jKXxzwSg3+wOZKZO15ZdmSRBe7alaO7MSyXpjmhv7uk4DfSIKmQBT3JgocsndQpugWeINccbStQO/z+E+pgq7+wYMY653PEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMJkFvfdxAbc44iWcknGwJK1YPCnbByEspL9fg4ie2w=;
 b=Mqhen6Uv7l3kOsu95tL+5H5uOkKrBTFkDfNb/VagD2BBaZXBKkshPUO9ncyrR0Hd7kOD/td9tbMvkZUjZNTgppOH+v4HgSvGWRYCltmdwnkyVLiz8fsy8H2S4dvEXVtndF4Vh69MYlf1sKGopdzRoFwULC1Xn/nrKGyxzz/3iiM7G4mx3dr3lgE/Wxpj1jvryjMYAydtKYRwDpo0M6Hp8A9vgJ1KvaPcirHZdQBJMm82x5oGSfWmBGWuOzDqQ5qIHVXQwKgH8XMxae3JmC/euZRhRu7qyKE0kklFYTL5CF2ux5WdNDsiZdaWcbE5iwnSToK+RGUANY1YZ6KU+PYukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMJkFvfdxAbc44iWcknGwJK1YPCnbByEspL9fg4ie2w=;
 b=Q92BeAbt2EzeopWiJxrhNGs0ppNZ/g6sph0azbUsV+zf53507BRuknopA4wJ+0AJEULPUeA2pCsju7+XZv5jWHcRQA7oJGwNz1HMsLu8ifosUcQneyoKlpAXaLv72Azdns6ZFYmMT0zAnY70AkdpvlcEH9X/Ndxa+0jXJe+CIto=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1568.namprd15.prod.outlook.com (10.173.234.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Fri, 8 Nov 2019 03:58:45 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2430.020; Fri, 8 Nov 2019
 03:58:45 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v5 1/2] mm,thp: recheck each page before collapsing file
 THP
Thread-Topic: [PATCH v5 1/2] mm,thp: recheck each page before collapsing file
 THP
Thread-Index: AQHVlGjXjTBN2suIgEyiHRjQ3h6QAaeAp1YAgAABeQA=
Date:   Fri, 8 Nov 2019 03:58:44 +0000
Message-ID: <47A1A0C0-8E38-4F4E-B7D6-7B390E7F7813@fb.com>
References: <20191106060930.2571389-1-songliubraving@fb.com>
 <20191106060930.2571389-2-songliubraving@fb.com>
 <20191107195328.600f302bbde69cf9c1089500@linux-foundation.org>
In-Reply-To: <20191107195328.600f302bbde69cf9c1089500@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::f533]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e47cb15-7849-4258-fbff-08d763fff395
x-ms-traffictypediagnostic: MWHPR15MB1568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB15689EF51AAF46BB62734339B37B0@MWHPR15MB1568.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(46003)(25786009)(66946007)(66446008)(64756008)(316002)(54906003)(66556008)(2906002)(478600001)(14444005)(4326008)(256004)(8676002)(66476007)(8936002)(81166006)(81156014)(6436002)(5660300002)(33656002)(50226002)(36756003)(2616005)(476003)(99286004)(6506007)(86362001)(6246003)(486006)(229853002)(11346002)(53546011)(102836004)(446003)(6486002)(76176011)(6512007)(7736002)(6916009)(305945005)(6116002)(186003)(71200400001)(76116006)(14454004)(71190400001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1568;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3UwH+5QglJcQvAvI8UT1W6KuOAOp0rdi+xryWEoeA31Z0bpHCgiMUYgBmknLGcFTDuGkRYI8KUytZY+HA51GPdTdy4AA6bJxu0N6HD8WkU32orvQbIjz+Ue6/3gqz2TLmdJrG+Vv46evZu2SsnA9bIkBP/ay8ce8cpiN09cOGi7wm2HkFOjlmN4InatPe+O8wPn3vwkS8SCzJ8doLVb/iGWK29Ae1KI7R5CxvKOIWPDTDpR6bXriuP13IQT3ZUmFTLtkQHimmGsZ28UaaWkdETDxJD+vD1KGAclAn1E+kzqssFP5uX4chcwYUStieqY+JDiht+8yKo7NbsIyC/GuyO1uJfyd29fs7u5pmdxbrifEtMFznQ0zT1FfNX4CwDUEREzpJ+c+R1BllBuP3FgVnPRBURJPHKZzHUzlMBX6AARtDLfTsIWB0+Kin7x1QXOF
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E05F89ECFD3F4C4B8216801655D83AAA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e47cb15-7849-4258-fbff-08d763fff395
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 03:58:44.9018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLd68GMyul+JhkEr94Tp2L/wCAB5P3CBqcRe/LO8S0774tkUXWvG9nXT9QEJxN5hq0vlbs2GyYdYJ++a3bByFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1568
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_07:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911080037
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 7, 2019, at 7:53 PM, Andrew Morton <akpm@linux-foundation.org> wro=
te:
>=20
> On Tue, 5 Nov 2019 22:09:29 -0800 Song Liu <songliubraving@fb.com> wrote:
>=20
>> In collapse_file(), for !is_shmem case, current check cannot guarantee
>> the locked page is up-to-date.  Specifically, xas_unlock_irq() should
>> not be called before lock_page() and get_page(); and it is necessary to
>> recheck PageUptodate() after locking the page.
>>=20
>> With this bug and CONFIG_READ_ONLY_THP_FOR_FS=3Dy, madvise(HUGE)'ed .tex=
t
>> may contain corrupted data.  This is because khugepaged mistakenly
>> collapses some not up-to-date sub pages into a huge page, and assumes
>> the huge page is up-to-date.  This will NOT corrupt data in the disk,
>> because the page is read-only and never written back.  Fix this by
>> properly checking PageUptodate() after locking the page.  This check
>> replaces "VM_BUG_ON_PAGE(!PageUptodate(page), page);".
>>=20
>> Also, move PageDirty() check after locking the page.  Current
>> khugepaged should not try to collapse dirty file THP, because it is
>> limited to read-only .text. The only case we hit a dirty page here is
>> when the page hasn't been written since write. Bail out and retry when
>> this happens.
>=20
> Incorrect data is pretty serious.  Should we backport this into -stable
> kernels?
>=20
> (I suspect I already asked this in response to earier versions, sorry ;))

This is new feature (and new bug :( ) in 5.4. So no need to back port.

Thanks,
Song=
