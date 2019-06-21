Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A66C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A22221655
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pxCASNjk";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="tKn1C+xU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfFUOKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:10:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfFUOKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:10:10 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LE7gC0014544;
        Fri, 21 Jun 2019 07:09:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OqjnU2VkCUT/RL7ii7MyB3NxIyF6Mv4Ttfz3Y59kmuU=;
 b=pxCASNjkw1/mHsNKYLU/01vXdr0hatlJzhxT/UNYcPtJdQjFgSiBtBSkaw5RfjuDUNwn
 JLwdPZRPkUaF9msyEt/NP7Egl51UAywLW3aGW498f3QREGW1h5o+0Y10nKzMAahCH545
 cFvpea3lTNgRMkM0ElMIgVwme27kEdVieoI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t90esr2kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 07:09:04 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 21 Jun 2019 07:09:03 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Jun 2019 07:09:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqjnU2VkCUT/RL7ii7MyB3NxIyF6Mv4Ttfz3Y59kmuU=;
 b=tKn1C+xUoPXZ5YKFrDw4/XMeerHQbVK+9sKt5MP04sniSn7QDnRvzls4HMgAdK0UfIET7oLvGzbtgoZVBCWj5MFcbtdE7Me7sJ/W/X5kCmyezOSdrUyfnGK1hyxs5w7Ah9B/yqYahFf5eQRhTVOsdk04vMh988C17t6e4noJUhY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1373.namprd15.prod.outlook.com (10.173.233.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 14:08:44 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Fri, 21 Jun 2019
 14:08:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v4 3/5] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Topic: [PATCH v4 3/5] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Index: AQHVIhGahpwtXNAKfka+bawgVMaQOKamGd4AgAAXqYA=
Date:   Fri, 21 Jun 2019 14:08:44 +0000
Message-ID: <6D00E9F1-A81D-44B8-9504-3B7B440CF093@fb.com>
References: <20190613175747.1964753-1-songliubraving@fb.com>
 <20190613175747.1964753-4-songliubraving@fb.com>
 <20190621124402.z4l67ck4vr5g7xe3@box>
In-Reply-To: <20190621124402.z4l67ck4vr5g7xe3@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:ed23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ede19af-12c0-47b3-ac9e-08d6f651f8b0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1373;
x-ms-traffictypediagnostic: MWHPR15MB1373:
x-microsoft-antispam-prvs: <MWHPR15MB137352A7B854ABB8A7412BE8B3E70@MWHPR15MB1373.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(50226002)(476003)(53546011)(6506007)(11346002)(446003)(486006)(102836004)(186003)(64756008)(14454004)(66476007)(76116006)(76176011)(46003)(25786009)(66556008)(66446008)(2616005)(316002)(8936002)(36756003)(478600001)(6246003)(73956011)(86362001)(4326008)(5660300002)(99286004)(6436002)(229853002)(66946007)(6512007)(6486002)(81166006)(81156014)(8676002)(256004)(33656002)(14444005)(4744005)(6916009)(53936002)(6116002)(54906003)(68736007)(305945005)(57306001)(7736002)(2906002)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1373;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yFcG8VFYpoeh1scsxtFjPMyNxBDkkzIuM3W568+JvDBmCmVe4DJM5XOGBxDVpl2hVjW8f54RMoAQ9aPrrx3VU17YYBT0XjSUOq1mRd3KAm4ZaaKDWFipSfowzsBGeVIQ177W1fL5uVGWhIO9cjMVBCFBdKXFbhNisiwW2viTGlns3l2OicExzW2lhiV5B+P8/EZcg3pewgiQ6WAV4MFxXN3Ub0BYjJpGg+irn58ZhG4lRov21ITRnBxPRamlb4s5XAw4Kp+Qf9yUw15qycxIaol9WJrRlxCOmiS8+7RJrBycs9IvRvoqL1k8owN8GGCl8ehZv3PZ8RBYJMctwWbOE/c16BfFqAqIh8VyG/m5u5sOCteIzJCnUPOi1MZaA0vt+NIAbFkCArbchuQxu/bMWie6r4Jm0zmGKltYVTEdCLU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C7F22507F1F2648A13AD376EE5EF553@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ede19af-12c0-47b3-ac9e-08d6f651f8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 14:08:44.3364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1373
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=657 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210118
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 21, 2019, at 5:44 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Thu, Jun 13, 2019 at 10:57:45AM -0700, Song Liu wrote:
>> @@ -419,6 +419,11 @@ static struct page *follow_pmd_mask(struct vm_area_=
struct *vma,
>> 			put_page(page);
>> 			if (pmd_none(*pmd))
>> 				return no_page_table(vma, flags);
>> +		} else {  /* flags & FOLL_SPLIT_PMD */
>> +			spin_unlock(ptl);
>> +			ret =3D 0;
>> +			split_huge_pmd(vma, pmd, address);
>> +			pte_alloc(mm, pmd);
>=20
> pte_alloc() can fail and the failure should be propogated to the caller.

Good catch! Fixing it now.=20

Thanks,
Song=
