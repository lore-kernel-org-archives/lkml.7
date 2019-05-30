Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595E4C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257DE218B8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RxGK/uFy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eDBovvm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfE3R1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:27:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46496 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbfE3R1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:27:36 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UHNH4H005940;
        Thu, 30 May 2019 10:27:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9U3qrZ3RryzWGHqSkFT9H2WatAYQxpSDV8ga1mgvl8c=;
 b=RxGK/uFyepKW2OcaM88QZjGOteO2TwGkKbUBcscndBF+gJjgqe2zHBqckpXAC0xHwAxz
 SEJKdWlF6/e05nRkgEMN3VwLDQdK/5xLWgGqdQH61q2iZHUJOKuG87AssGVr/cmZOXDw
 giFrG83h3hPmRN0x+ojy5tTn7yD+uV3VbMg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2stj9w8adh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 May 2019 10:27:01 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 May 2019 10:26:57 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 May 2019 10:26:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U3qrZ3RryzWGHqSkFT9H2WatAYQxpSDV8ga1mgvl8c=;
 b=eDBovvm1UNpINdHG75i95BFebOLVcIGUHKHpQZMWiWvJwgyxqmCXylBzfUSos18XBqPjHTQWeAdqz557qQjONxeG21HwKk18olJTO05F/AynWV+bVPpKp4tAQoULVz/qU0Hf0PUkzwxsYYlBlYqS7Yx+Q0C7Q1OmRrxtJ9dPiuo=
Received: from BN6PR15MB1154.namprd15.prod.outlook.com (10.172.208.137) by
 BN6PR15MB1857.namprd15.prod.outlook.com (10.174.113.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Thu, 30 May 2019 17:26:38 +0000
Received: from BN6PR15MB1154.namprd15.prod.outlook.com
 ([fe80::adc0:9bbf:9292:27bd]) by BN6PR15MB1154.namprd15.prod.outlook.com
 ([fe80::adc0:9bbf:9292:27bd%2]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 17:26:38 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "namit@vmware.com" <namit@vmware.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "chad.mynhier@oracle.com" <chad.mynhier@oracle.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>
Subject: Re: [PATCH uprobe, thp 4/4] uprobe: collapse THP pmd after removing
 all uprobes
Thread-Topic: [PATCH uprobe, thp 4/4] uprobe: collapse THP pmd after removing
 all uprobes
Thread-Index: AQHVFmai8W5Yq1+OvE6IJWAoNhoGxKaDl3SAgABVaoA=
Date:   Thu, 30 May 2019 17:26:38 +0000
Message-ID: <4E8A7A5E-D425-40EC-B40A-7DA21BA1866F@fb.com>
References: <20190529212049.2413886-1-songliubraving@fb.com>
 <20190529212049.2413886-5-songliubraving@fb.com>
 <20190530122055.xzlbo3wfpqtmo2fw@box>
In-Reply-To: <20190530122055.xzlbo3wfpqtmo2fw@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:bc80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87e47887-e2ce-48d5-6d68-08d6e523f91f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR15MB1857;
x-ms-traffictypediagnostic: BN6PR15MB1857:
x-microsoft-antispam-prvs: <BN6PR15MB185740D059C650658FB05523B3180@BN6PR15MB1857.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(64756008)(50226002)(46003)(81166006)(66446008)(4744005)(316002)(6506007)(53936002)(6246003)(14454004)(6512007)(8676002)(478600001)(4326008)(2906002)(91956017)(73956011)(66476007)(76116006)(66556008)(5660300002)(305945005)(7736002)(6116002)(25786009)(66946007)(14444005)(476003)(68736007)(71190400001)(54906003)(86362001)(99286004)(71200400001)(83716004)(229853002)(446003)(2616005)(53546011)(11346002)(256004)(6916009)(8936002)(486006)(102836004)(76176011)(33656002)(36756003)(57306001)(6486002)(81156014)(186003)(6436002)(7416002)(82746002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1857;H:BN6PR15MB1154.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cg38ktuGDSdnLQFnRRwOCu9VhGBUi85YIRwrbqiVzceEdEX+l+3ZTiWgOFb4Z2uyN5snafUqSPH0LzJIOj+rhttcHeobAYED0k+AqOqpM4oADMZSclCZvCSuFHJiaEzxH4TJLC3jdJEWZB5996OslEDQUYEy4vbKM9DHzUrGwUTOZX9oRiywyLHkQGkFVrkN0wZgvKHsYVxePRyHu9gLFmAv2MdA9ieJrLJZyS4ruHTk25nt1tmjeoL/mDcP7jLv6GgVAvlN8ej4pLQFAST0DdCNnBfn1Qi0ptdu0RskSmUzGZDG54cAFEaMFdoFFsWpT/tyZ1L8CQq1dhlD4xWHwJFHxu4mOgnUXK05a70DJrdgE7L5BcoKArWYVnAM6lVgxigCkaPuXuKIpX27j2+2RSZFk4Es7ulatm/rIfgWah0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <717A3B52E0DEBB468BE5462786ACC0C7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e47887-e2ce-48d5-6d68-08d6e523f91f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 17:26:38.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1857
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=659 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300122
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 30, 2019, at 5:20 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Wed, May 29, 2019 at 02:20:49PM -0700, Song Liu wrote:
>> After all uprobes are removed from the huge page (with PTE pgtable), it
>> is possible to collapse the pmd and benefit from THP again. This patch
>> does the collapse.
>=20
> I don't think it's right way to go. We should deferred it to khugepaged.
> We need to teach khugepaged to deal with PTE-mapped compound page.
> And uprobe should only kick khugepaged for a VMA. Maybe synchronously.
>=20

I guess that would be the same logic, but run in khugepaged? It doesn't
have to be done synchronously.=20

Let me try that

Thanks,
Song


> --=20
> Kirill A. Shutemov

