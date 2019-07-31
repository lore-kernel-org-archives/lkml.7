Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9F8C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D78206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="k8RDB25z";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dBcf4P9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfGaQjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:39:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58604 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbfGaQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:39:02 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VGXj6M008127;
        Wed, 31 Jul 2019 09:36:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NFw/zDmisntTVbRQ0jF9sR9rEnYH6pIAv4RjhFVHwho=;
 b=k8RDB25zIsmdyTNqcKo8QIg6Wm1N82fb3e4UGkxpBTp4x91rNvlunNaL75o1eIWy/Mfs
 0QtunZqsHwBDejWBH8dzuzmtHSG4IiqdB0RYAd0Pq72OT16rQ0KLbziF9bFgtJtn93dc
 EeIL587za36OfYgPOw1puEibSoOxbmSn37k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u369ess0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 31 Jul 2019 09:36:18 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 09:36:17 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 31 Jul 2019 09:36:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2k4xsWiEj+yAd4SSvGfI+juBKb1NuCmY2iofVciyS+rkQ2ie/PEgAwjKoKwcCgxr8KXvfn+B25CchKTX2apB0kQlOJp1IdFXktjZKnFxhgCLQb9OIOm9uRpumXwLP+Dz0ZyP/vAgK+N5eKqoJ+vHc7vKbMKx4k86xUzz08saG4J1+fhXE2U/x4MJT8Gj7dO387uZVsarI2XSKlQlcptl9glyVeDEK7pQDuEoRTTrdWhF9ePUJId0RdCUwElj2jVFDgsPwlMVEJU4Tz/kibDNyWCMl20t6d/aI6JBxUNeYn+tFuiKYoSF1g7ssu35e9WnEW9sn6gd0CqfLwFqIkayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFw/zDmisntTVbRQ0jF9sR9rEnYH6pIAv4RjhFVHwho=;
 b=E538Hx7cSJKjWXEMhnduzpJZjQ0gZiZKrzVT6sh+dqiiSCszsJEPWd4Uptqf2A9Zwz+f5lNUhIZ89FU63y0W59QLu08sFrSWTHbYz8KcHsEokVcNrmn5hXitKSHrghClRF9lTsj2hAk8kS5nShfomhw3Bg483l/DAXlvA995oPEMe8Wxn3BOdOEw5sRakK7pYtkA5uYOW2evJ/79b9CzDcZlrpGt1ImHMJJhY3QplHr48YZMIKZMUfH9d6cMsyzxYR4RcpyrvB7IGmvzoan7ohh6KCnz2h4sj+gXjY/HRwOT8//8VS7REdUYVlgclsniMQKQrURGP/f9AQqxBntzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFw/zDmisntTVbRQ0jF9sR9rEnYH6pIAv4RjhFVHwho=;
 b=dBcf4P9h6HX4a9zJh8Tn8o1jW6Y7wcxoNdQIliLza6COP7hRYUzvAnatM5kFCRQAfmz+r9RSW9VH6/7yTGJnEaijDXcQxDyYudlzW5eedbdbn4uChgpNJpDm5ZR1PJu2kVHxJJFHqg6aB5fzJgaOb2sFdfmSmpV1ndComQZbG4A=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1726.namprd15.prod.outlook.com (10.174.254.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 16:36:16 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 16:36:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "William Kucharski" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] uprobe: collapse THP pmd after removing all uprobes
Thread-Topic: [PATCH 2/2] uprobe: collapse THP pmd after removing all uprobes
Thread-Index: AQHVRdClSGoRT5gntEqzOPZk9S20/6bk6usAgAAFl4A=
Date:   Wed, 31 Jul 2019 16:36:15 +0000
Message-ID: <CA691086-51F2-47AD-B280-8A9F9CF91804@fb.com>
References: <20190729054335.3241150-1-songliubraving@fb.com>
 <20190729054335.3241150-3-songliubraving@fb.com>
 <20190731161614.GC25078@redhat.com>
In-Reply-To: <20190731161614.GC25078@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:70cb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e489b10a-c12f-4f33-649d-08d715d5353d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1726;
x-ms-traffictypediagnostic: MWHPR15MB1726:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1726AF17EF5EDAE22CBEDCB6B3DF0@MWHPR15MB1726.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(76176011)(316002)(102836004)(66476007)(66556008)(8676002)(6506007)(186003)(64756008)(66446008)(6512007)(4744005)(66946007)(86362001)(446003)(46003)(8936002)(53546011)(91956017)(76116006)(57306001)(229853002)(6486002)(6436002)(50226002)(2616005)(81166006)(11346002)(71200400001)(7736002)(486006)(81156014)(53936002)(71190400001)(5660300002)(6916009)(2906002)(256004)(305945005)(966005)(476003)(6306002)(54906003)(36756003)(478600001)(4326008)(25786009)(33656002)(68736007)(6116002)(99286004)(14454004)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1726;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ko/EtCh66+qmxxP6dF+XQc6m3YATduTf4Ip8QYppRjbiN+hcTSvPXmvzYdsm2AwEplmhc+hTWJV81LYBOXFiY/DbyrjGSwYZn6MpqMTEqqqcBASNOT2ETiA03Ra7bS70J39EVZ4XPodjnThJQo7QPg5+T1mpI9OYACefqOBTCzemA6EKUWDc1jqIBFKn4cf6sPsEsdWxxr+kJvmY2IJzNf+wGufOZ/0saZktxQ90TafSOfi/r71Fgg5O3s3g1rMhME6r1J1h4qL3qLvmKI8VD3myOMqz/mX9LevQQM0/QMl4xuZTz6zSscK7GvyITDftxSi0x/YR+H4d/HGGwtyQCT19CBgbM5jso5YiwhKSGZtscFME2NmlOdImHkS95ZFnEyLb2SNOVE6ohkq1sgReABPbGFLkVkvTFuDUrgk46D8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BDDAC0566BD0C4C928820B5E2AA7D16@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e489b10a-c12f-4f33-649d-08d715d5353d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 16:36:15.8995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1726
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=788 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310165
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 31, 2019, at 9:16 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 07/28, Song Liu wrote:
>>=20
>> @@ -525,6 +527,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe,=
 struct mm_struct *mm,
>>=20
>> 				/* dec_mm_counter for old_page */
>> 				dec_mm_counter(mm, MM_ANONPAGES);
>> +
>> +				if (PageCompound(orig_page))
>> +					orig_page_huge =3D true;
>=20
> I am wondering how find_get_page() can return a PageCompound() page...
>=20
> IIUC, this is only possible if shmem_file(), right?

Yes, this is the case at the moment. We will be able to do it for other
file systems when this set gets in:=20

	https://lkml.org/lkml/2019/6/24/1531

Thanks,
Song=
