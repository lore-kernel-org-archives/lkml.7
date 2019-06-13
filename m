Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BF1C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F6F21744
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="g0xeQuZe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="A1CnMk2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733106AbfFMPEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:04:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46852 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732498AbfFMPEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:04:47 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5DEupAd005322;
        Thu, 13 Jun 2019 08:03:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JyFkfLFkRnd8Yiq3ysXjo4ywRZ3t9U1FA6dvbY1wjbo=;
 b=g0xeQuZeguyEVU4i9clT7ywYv7mmkMsQ/0KhsdMwscVGwhUD3kVV7CqQg1Bsv+fjXpRk
 gJkL9eFuAvKWb57fA/fKY1qwbfv2i0bbkt1qy7t6eyyPNkPYLDQ/fILz9yvbGqhk4DDd
 pGEmnxgcqekG8ARc4FHsPjnm7SU2NtwxbCo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2t353y3puc-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 08:03:25 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 13 Jun 2019 08:03:02 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 13 Jun 2019 08:03:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyFkfLFkRnd8Yiq3ysXjo4ywRZ3t9U1FA6dvbY1wjbo=;
 b=A1CnMk2I7vIWKO0iom3mzFrtWn5UqRSLhM+fuG3nLZ6EFk6Ni5mlLVeWUJy3ZRGmsAGY5rqLNPRjP2E4y0Fy8EgM48PJaOnE0kdqtAebPwJo0TMsvBaijrgQhk8H9TSqitOBQJRT+RGIcgodbtL8zAUBwU5dL6tdkxXMyxBhQaY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1630.namprd15.prod.outlook.com (10.175.135.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 15:03:01 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 15:03:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "namit@vmware.com" <namit@vmware.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 3/5] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Topic: [PATCH v3 3/5] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Index: AQHVIWtWTe7ps5z8rEO6sAR2s+F9WKaZjDkAgAAQ0ICAAAU/gIAADRAA
Date:   Thu, 13 Jun 2019 15:03:01 +0000
Message-ID: <32E15B93-24B9-4DBB-BDD4-DDD8537C7CE0@fb.com>
References: <20190612220320.2223898-1-songliubraving@fb.com>
 <20190612220320.2223898-4-songliubraving@fb.com>
 <20190613125718.tgplv5iqkbfhn6vh@box>
 <5A80A2B9-51C3-49C4-97B6-33889CC47F08@fb.com>
 <20190613141615.yvmckzi3fac4qjag@box>
In-Reply-To: <20190613141615.yvmckzi3fac4qjag@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:7078]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f576ebe-6f81-4065-b8d7-08d6f0103adf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1630;
x-ms-traffictypediagnostic: MWHPR15MB1630:
x-microsoft-antispam-prvs: <MWHPR15MB1630BEF5138F585FB6C9082FB3EF0@MWHPR15MB1630.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(8676002)(71190400001)(71200400001)(6246003)(50226002)(81156014)(6436002)(36756003)(6512007)(256004)(14444005)(7736002)(81166006)(6486002)(305945005)(6916009)(6116002)(2616005)(33656002)(14454004)(4326008)(478600001)(53546011)(68736007)(5660300002)(6506007)(86362001)(46003)(73956011)(99286004)(476003)(11346002)(486006)(446003)(186003)(66556008)(66446008)(64756008)(66476007)(66946007)(229853002)(57306001)(54906003)(25786009)(8936002)(2906002)(53936002)(76116006)(76176011)(102836004)(7416002)(316002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1630;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bjjob00XLttWK5NxStgDF1HcFz/UDKx7TIOTR059A2sylGI6WiRJv2ec97EMhutM0kYe+znKtNZ5pcUiVQZJ86sScrVFh9U+TckCQRGQ+mJiExUpxnrswy3k85XEQ7Wg0OyV5IKrK9ySxz8EjaNZXe1tKqycpTQjR8QLlXU0LxnDv1EmBRwgpraIKIQUo8t5kivuFe8byz3UUq/rQUkljsH9yqxQkirKtezaZCqm8x60fiasHqM9DqGwoHMO1GKp/eX7jDdP3bvHG0gNlkaX3csMJfAwyXfyOYoVM3rotdWI/moBeupVSOS8h3SkD+hlz8AFbmhigjGaQHGuJ5n4JYLZDnNTSR1kKOu51Xx1f9D+MQmSsXkNCX04cQNHP22Jqcpt9elXWeK4OkJIhr1Mf6I2MaPr+1dIGbwnzS7ZETA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0004B78413CCF43ACADA1D1BE0BD9B5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f576ebe-6f81-4065-b8d7-08d6f0103adf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 15:03:01.5685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1630
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=975 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130112
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 13, 2019, at 7:16 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Thu, Jun 13, 2019 at 01:57:30PM +0000, Song Liu wrote:
>>> And I'm not convinced that it belongs here at all. User requested PMD
>>> split and it is done after split_huge_pmd(). The rest can be handled by
>>> the caller as needed.
>>=20
>> I put this part here because split_huge_pmd() for file-backed THP is
>> not really done after split_huge_pmd(). And I would like it done before
>> calling follow_page_pte() below. Maybe we can still do them here, just=20
>> for file-backed THPs?
>>=20
>> If we would move it, shall we move to callers of follow_page_mask()?=20
>> In that case, we will probably end up with similar code in two places:
>> __get_user_pages() and follow_page().=20
>>=20
>> Did I get this right?
>=20
> Would it be enough to replace pte_offset_map_lock() in follow_page_pte()
> with pte_alloc_map_lock()?

This is similar to my previous version:

+		} else {  /* flags & FOLL_SPLIT_PMD */
+			pte_t *pte;
+			spin_unlock(ptl);
+			split_huge_pmd(vma, pmd, address);
+			pte =3D get_locked_pte(mm, address, &ptl);
+			if (!pte)
+				return no_page_table(vma, flags);
+			spin_unlock(ptl);
+			ret =3D 0;
+		}

I think this is cleaner than use pte_alloc_map_lock() in follow_page_pte().=
=20
What's your thought on these two versions (^^^ vs. pte_alloc_map_lock)?


> This will leave bunch not populated PTE entries, but it is fine: they wil=
l
> be populated on the next access to them.

We need to handle page fault during next access, right? Since we already
allocated everything, we can just populate the PTE entries and saves a
lot of page faults (assuming we will access them later).=20

Thanks,
Song

>=20
> --=20
> Kirill A. Shutemov

