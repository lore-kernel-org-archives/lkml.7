Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60863C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF0825E46
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dPPRkci1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Qupa5ciZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfE3RVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:21:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58610 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725961AbfE3RVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:21:07 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4UH97i7016413;
        Thu, 30 May 2019 10:18:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3T6nroDY3DinVVOxA+4sYA7U+RaGiCglnLDagGHPffg=;
 b=dPPRkci17U3M4aLXAZfBtx+bzM0plzsNtVF/gEvKoyZJT0Wivyj2r2c3uTDTz0ZTN5FT
 q1F3Qc/Pe0WKCmakZzEQaXNjlYTVaGdrAm6haVtkZac6I4AX6Wjsd9WOMqLXZ3Dx5stY
 yn04aw1srzoiIwTMQCfAwyvhykmgNRY7sIo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2stftprtsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 May 2019 10:18:47 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 May 2019 10:18:45 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 May 2019 10:18:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T6nroDY3DinVVOxA+4sYA7U+RaGiCglnLDagGHPffg=;
 b=Qupa5ciZYj3rSUffCPX4e5i8sAHT5I+Q4pGZQvCmvnkkBgEFtf9WdM6H11FUBaPFG9uBPToFMjdiUOR/LPLPhbRKrXBjWbk3qVXi+1SdFlfr7zaAusATn0eWz6M7QyYhS6vDxRlTVNu5/VSkEt7w0egiucvtbURA69JYq1kEZ4s=
Received: from BN6PR15MB1154.namprd15.prod.outlook.com (10.172.208.137) by
 BN6PR15MB1793.namprd15.prod.outlook.com (10.174.115.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.16; Thu, 30 May 2019 17:18:44 +0000
Received: from BN6PR15MB1154.namprd15.prod.outlook.com
 ([fe80::adc0:9bbf:9292:27bd]) by BN6PR15MB1154.namprd15.prod.outlook.com
 ([fe80::adc0:9bbf:9292:27bd%2]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 17:18:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Subject: Re: [PATCH uprobe, thp 2/4] uprobe: use original page when all
 uprobes are removed
Thread-Topic: [PATCH uprobe, thp 2/4] uprobe: use original page when all
 uprobes are removed
Thread-Index: AQHVFmapFXZ5K+77uUK6eWDD22eshaaDhceAgABk4oA=
Date:   Thu, 30 May 2019 17:18:43 +0000
Message-ID: <F97FB4EB-3416-4BE7-9539-E58A3AD86874@fb.com>
References: <20190529212049.2413886-1-songliubraving@fb.com>
 <20190529212049.2413886-3-songliubraving@fb.com>
 <20190530111739.r6b2hpzjadep4xr5@box>
In-Reply-To: <20190530111739.r6b2hpzjadep4xr5@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:bc80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4ef1874-a86e-4f28-2153-08d6e522de56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR15MB1793;
x-ms-traffictypediagnostic: BN6PR15MB1793:
x-microsoft-antispam-prvs: <BN6PR15MB17939E8756F938742D54EFEAB3180@BN6PR15MB1793.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(33656002)(6246003)(7416002)(2906002)(36756003)(99286004)(5660300002)(229853002)(57306001)(6506007)(53936002)(446003)(82746002)(54906003)(486006)(316002)(76176011)(102836004)(81166006)(11346002)(256004)(68736007)(53546011)(7736002)(476003)(2616005)(305945005)(6916009)(25786009)(186003)(14454004)(71190400001)(71200400001)(83716004)(8676002)(46003)(478600001)(4744005)(66556008)(8936002)(50226002)(6436002)(4326008)(6116002)(64756008)(66946007)(66446008)(6512007)(6486002)(66476007)(86362001)(91956017)(81156014)(73956011)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1793;H:BN6PR15MB1154.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YhyDiPd3FP7X/qv3flvqEQjFex8nNdD9A3heognhhMiFB2SV1afcTFgbkI4PYbvv9kckOE5GXLKVSkGAj2CW6XpuJTdg7QKb3ldHj8ctUBBPRDU1sPU/trj3R/xkwJLKsblVFNXNDx+IEBfXSa9fuVPkuezUq5MV5UV5HPQbOw5e56lh5vWHo3yWaE8C6ruG/QRIg0JUxPzbH8Qw3SBIkKdlnyaNieIokXi0+WTrj56HdsAM04gNilwY5aD66BCqliYmWcvgOxKlsjsw7JaRt/WICYfI8DufghQpG8DwBQ3Eqbiu+A7TtwM+Xp5krq1A+spN2ahlxyjCx/TdMRK6YjuL/PAOpfIg7xxQxTCgfT5+EYpyWrfCwamQxI77BtHP3dtH354VGPBd6Cv9hQZ35Hm9rV14tLEwTAbqBRtuW1Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A65156D150C53842A08DD92CCC6D94A7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ef1874-a86e-4f28-2153-08d6e522de56
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 17:18:43.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1793
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=960 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300121
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 30, 2019, at 4:17 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Wed, May 29, 2019 at 02:20:47PM -0700, Song Liu wrote:
>> @@ -501,6 +512,20 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe=
, struct mm_struct *mm,
>> 	copy_highpage(new_page, old_page);
>> 	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
>>=20
>> +	index =3D vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
>> +	orig_page =3D find_get_page(vma->vm_file->f_inode->i_mapping, index);
>> +	if (orig_page) {
>> +		if (memcmp(page_address(orig_page),
>> +			   page_address(new_page), PAGE_SIZE) =3D=3D 0) {
>=20
> Does it work for highmem?

Good catch! I will fix it in v2.=20

Thanks!
Song

>=20
>=20
> --=20
> Kirill A. Shutemov

