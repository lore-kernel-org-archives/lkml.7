Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B09C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D02206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DJ0oUUC2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Un0tomMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfFEQbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:31:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726421AbfFEQbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:31:14 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x55GRgn3031455;
        Wed, 5 Jun 2019 09:29:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1rfsUUFZSCNJ7nuLOUjdlYppiD9fqGCzCGbgwZ6tV7Y=;
 b=DJ0oUUC2yKaZSiPT+kVByg9Zuasimc1cwwbmBaV8kwl7SVFuDB4MBrIvQ2Rdilk84bel
 28jeqTBOvpqLXYf4ZCVdlELUS0B6hCg6RYKE3/N6Ic5tCS/Eq7aZlsyVTDrtXvYEwe+R
 hf2slRzqF34A0G4QBId/E4thEub91j/yst0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2swycbb388-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Jun 2019 09:29:55 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Jun 2019 09:29:55 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Jun 2019 09:29:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rfsUUFZSCNJ7nuLOUjdlYppiD9fqGCzCGbgwZ6tV7Y=;
 b=Un0tomMaBxPyF7SOB+fvHE3FJ2JDid87ddln1kco07iCRDGqRpXgqcOLzRFQ5mt7nKOzGpM5VtBC5FcLvMf+q4tmwiDU2ga1m7x5srtZMVgetZhXX7TUg+pFRNIsm44LVVzfKPei0tnJVCWUI+zIFavj0MYfNyt6pjd2I2YXgfY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1485.namprd15.prod.outlook.com (10.173.234.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.13; Wed, 5 Jun 2019 16:29:36 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.1965.011; Wed, 5 Jun 2019
 16:29:36 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>
Subject: Re: [PATCH uprobe, thp v2 2/5] uprobe: use original page when all
 uprobes are removed
Thread-Topic: [PATCH uprobe, thp v2 2/5] uprobe: use original page when all
 uprobes are removed
Thread-Index: AQHVGvXYP1uNbtmlEkOH++FxJqf1WKaM1YuAgABsQoA=
Date:   Wed, 5 Jun 2019 16:29:36 +0000
Message-ID: <0B1DEAD9-DB1E-46C5-9F5C-1049D0DC043F@fb.com>
References: <20190604165138.1520916-1-songliubraving@fb.com>
 <20190604165138.1520916-3-songliubraving@fb.com>
 <20190605100207.GD32406@redhat.com>
In-Reply-To: <20190605100207.GD32406@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:34a6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b387e601-a04d-42da-1b9b-08d6e9d3000e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1485;
x-ms-traffictypediagnostic: MWHPR15MB1485:
x-microsoft-antispam-prvs: <MWHPR15MB14853D5C37ACC521E2828B87B3160@MWHPR15MB1485.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(11346002)(256004)(25786009)(2616005)(476003)(54906003)(14454004)(486006)(478600001)(14444005)(446003)(76116006)(99286004)(33656002)(46003)(73956011)(66946007)(57306001)(66476007)(6436002)(66556008)(64756008)(66446008)(6116002)(6246003)(53936002)(229853002)(4326008)(6512007)(6486002)(50226002)(36756003)(6916009)(8676002)(81166006)(81156014)(8936002)(68736007)(316002)(186003)(7736002)(305945005)(86362001)(83716004)(102836004)(76176011)(71190400001)(71200400001)(82746002)(2906002)(5660300002)(6506007)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1485;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3cgaycaRqKeuUTuyH+mPkC/EPIhfqVXoah2kEefN4wL3lNzI7SxJx5dUIl8fU3Z4bGO+waD+Lxxutrqx17ufz3p+OWKdskXdpdNRX36T5GhKXqSDltnPH6xo+uZHcho9/d5DvGS0iTWG7/sOAENGa3PYJI9jrj80RbFdtBn9TphpvC0ZMqQZG8SmStpQ4HvO4QGFNbQcyQnyeUg+J6VxDjJTJMOVAI/zz4jbobvrWjfyN6F+09OaUxLyUHQoOcbKDDjBnLtNqzXQdmceZJA601aeTLfKF3y4X0bpzjHmP03BjjPrn1FSwIlbedEDJzqvUJXp6h1iiXK71a0gq/tWaw6vK+SxDZ9636lhldeEFRAD3v6FMW0hwu/PJ+qdY/qm6g66rl75LxMGay/XEYYXPIGKL5RZlV/Gc3R/qUYPXNI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2E7A7264E573F46B6EB66C308A4E80F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b387e601-a04d-42da-1b9b-08d6e9d3000e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 16:29:36.6298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1485
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050103
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

Thanks for your kind review!

> On Jun 5, 2019, at 3:02 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 06/04, Song Liu wrote:
>>=20
>> Currently, uprobe swaps the target page with a anonymous page in both
>> install_breakpoint() and remove_breakpoint(). When all uprobes on a page
>> are removed, the given mm is still using an anonymous page (not the
>> original page).
>=20
> Agreed, it would be nice to avoid this,
>=20
>> @@ -461,9 +471,10 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe=
, struct mm_struct *mm,
>> 			unsigned long vaddr, uprobe_opcode_t opcode)
>> {
>> 	struct uprobe *uprobe;
>> -	struct page *old_page, *new_page;
>> +	struct page *old_page, *new_page, *orig_page =3D NULL;
>> 	struct vm_area_struct *vma;
>> 	int ret, is_register, ref_ctr_updated =3D 0;
>> +	pgoff_t index;
>>=20
>> 	is_register =3D is_swbp_insn(&opcode);
>> 	uprobe =3D container_of(auprobe, struct uprobe, arch);
>> @@ -501,6 +512,19 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe=
, struct mm_struct *mm,
>> 	copy_highpage(new_page, old_page);
>> 	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
>>=20
>> +	index =3D vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
>> +	orig_page =3D find_get_page(vma->vm_file->f_inode->i_mapping, index);
>=20
> I think you should take is_register into account, if it is true we are go=
ing
> to install the breakpoint so we can avoid find_get_page/pages_identical.

Good idea! I will add this to v3.=20

>=20
>> +	if (orig_page) {
>> +		if (pages_identical(new_page, orig_page)) {
>> +			/* if new_page matches orig_page, use orig_page */
>> +			put_page(new_page);
>> +			new_page =3D orig_page;
>=20
> Hmm. can't we simply unmap the page in this case?

I haven't found an easier way here. I tried with zap_vma_ptes() and=20
unmap_page_range(). But neither of them works well here.=20

Also, we need to deal with *_mm_counter, rmap, etc. So I guess reusing
__replace_page() (as current patch) is probably the easiest solution.=20

Did I miss anything?=20

Thanks again,
Song




