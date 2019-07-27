Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BAFC7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 00:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1F322C7E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 00:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EZCazKsx";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="beBS7MBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfG0AR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 20:17:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52386 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbfG0AR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 20:17:56 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6R0CoU1017736;
        Fri, 26 Jul 2019 17:16:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rt6B+DBxORlj6FwRT70Rv+VZlbcGTPg/sc4I7VXPmGg=;
 b=EZCazKsxF9BtmYKVZUK5VSQhTFmS2IVaVNZfN5EZtw4tSpVtc6cdbe+U+DG7EmjH/7tt
 IoTNPDkWsJO72CUMzx9IItZ8LqA4utLEzrsN4ijMHC5PeZMI1r5EBBPEvLpF4l//Uwal
 1rBi+gIEkcjMP4xW32rFWTcgaItMvLf0Q/s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2u031at34s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Jul 2019 17:16:13 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Jul 2019 17:16:10 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Jul 2019 17:16:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrKmipwo8OKZPW66P/tM/q2cUysaeSdxx1okAzwFozDF6hPTEAv4D+4SY5yWWGKoq8kaJUnboZzCiflUSsnVkSVtlF2j514Ae9/yA6lOFoj8VsPnS5w33/0qX6bKV91p81sfUlZaWk8rEvfLvdW15bSn8B2v+v59cFZZ0xsWjMCE0RR106DLEyebBIsBQgbxP2Ci3BZSt30VYSgCsyF3Jg/minkYoT+CUaYSWPcahmnM4aVNcIObqaOZaE7zMiT7AKM/Gs/JkOtoQNM+cGlEqyONSBMjcAnBTTr2UxdpqlgdKXnVgAK5UbnUkKBA/SwxUqvH29uYlECB0UF8BP4yRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt6B+DBxORlj6FwRT70Rv+VZlbcGTPg/sc4I7VXPmGg=;
 b=gT2yEPahcnC+7YB1q/7973096hH1FIaMMCDOHbffKxA2eAwQ5L2goH0PN2w86rId6vtYOP7yaXjVJN2cyvfPCYjT0he41mXXidYnfS7oTbdGOKGIU5JfFjG6quu+OHhLz6SdVOf9tYx8PeeKPO5z63g/6JVKPMkyw6LSZ+CYsipzEds9R5jL178Gs0c9Zv113GhKdPhQHCwQnQOq68cAkQJPO3WEF9xLWJVR9DyRN4Z/BGNx17GOejWBTIsKuieIR4CyJFqiu8oIuoKAozIjKz1EVKzDxr4ESmXQv3F26DHCrw5bhp0oxWTDiW1pALJKGbukgK4eT9qMp2/gfwIPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt6B+DBxORlj6FwRT70Rv+VZlbcGTPg/sc4I7VXPmGg=;
 b=beBS7MBygEp/lwDFflPWg7xr4Sh7rzeZflSJgFWq7XED5SB9M+f03WpDgY0HjzGAdSfoakUodhH73180mUdBS+0Vlfgh8VjWaDnsJjrzOPoBz5B/PO+nwVfDjPthMlTBDJDXhUr3y8j9OR7Xl3qQ3//ZNQB9QLy973L9WNiP6Cs=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1504.namprd15.prod.outlook.com (10.173.233.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Sat, 27 Jul 2019 00:16:08 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7%7]) with mapi id 15.20.2094.013; Sat, 27 Jul 2019
 00:16:08 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 4/4] uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT
Thread-Topic: [PATCH v9 4/4] uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT
Thread-Index: AQHVQ3ZlmP2L+/3PqE2yConlr9Gmr6bdhYSAgAALtYCAAAI0AIAABp6A
Date:   Sat, 27 Jul 2019 00:16:07 +0000
Message-ID: <5334A4F8-9DD6-402C-B09A-97671EFCC950@fb.com>
References: <20190726054654.1623433-1-songliubraving@fb.com>
 <20190726054654.1623433-5-songliubraving@fb.com>
 <20190726160239.68f538a79913df343308b473@linux-foundation.org>
 <509AB060-6E17-40AB-A773-DF3FB8EBDB62@fb.com>
 <20190726165226.7068704eb54a0104aaead703@linux-foundation.org>
In-Reply-To: <20190726165226.7068704eb54a0104aaead703@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:bb04]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aed5b72c-afe5-4f5e-a7f7-08d712279f31
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1504;
x-ms-traffictypediagnostic: MWHPR15MB1504:
x-microsoft-antispam-prvs: <MWHPR15MB1504675A32AA324CC45DF479B3C30@MWHPR15MB1504.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01110342A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(346002)(396003)(366004)(54534003)(189003)(199004)(2906002)(6436002)(6116002)(86362001)(36756003)(6916009)(76116006)(14454004)(33656002)(7416002)(229853002)(64756008)(6486002)(66446008)(66556008)(5660300002)(4326008)(66476007)(305945005)(478600001)(54906003)(81156014)(6246003)(25786009)(8936002)(6512007)(68736007)(71200400001)(71190400001)(486006)(99286004)(446003)(11346002)(102836004)(50226002)(76176011)(57306001)(14444005)(256004)(186003)(6506007)(8676002)(53546011)(2616005)(7736002)(476003)(46003)(316002)(66946007)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1504;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YDQJXrKrOmqahzIcX1x6Kxoh8mhzGJ+yU80AXDF/Jm4YGLORJFwUq9v+D2lfLUjsjxy23JSmozZeunz/Lvw+qCRvGEqCa2AvnlHBmUrKtnPIehDiRElmo0fYD5+w54O1g1Yrc0Bfo+QRYZrLy8kdwFerVA0MiXkyOUphPNjxQXCU7HsGT+27on4vWZkJjbSC4AkXLw1l25Y/HB2mvPEyfIXiNjEf5DaJthh8DjerQJ3GGngMJr/uaTK8AUkC1w3+0by49s6KVevkt81Cae9RgU1N571jUyNHoYyiWyf7i9lZ5hG3UtZDUysFtu1MuYDAkn9P3fSixhk8DSBigVzthqTCHETF2KYoDw3CakpwaHGU3pyFnk9A8nRq46jgfNpKNsPA1cV6EsjqfANw4aLH2tSNF3b03CEXWDgVV8iNevo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B61236F6CC720641A259C1371805522A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aed5b72c-afe5-4f5e-a7f7-08d712279f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2019 00:16:07.7398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=990 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907270001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 26, 2019, at 4:52 PM, Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>=20
> On Fri, 26 Jul 2019 23:44:34 +0000 Song Liu <songliubraving@fb.com> wrote=
:
>=20
>>=20
>>=20
>>> On Jul 26, 2019, at 4:02 PM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>>>=20
>>> On Thu, 25 Jul 2019 22:46:54 -0700 Song Liu <songliubraving@fb.com> wro=
te:
>>>=20
>>>> This patches uses newly added FOLL_SPLIT_PMD in uprobe. This enables e=
asy
>>>> regroup of huge pmd after the uprobe is disabled (in next patch).
>>>=20
>>> Confused.  There is no "next patch".
>>=20
>> That was the patch 5, which was in earlier versions. I am working on=20
>> addressing Kirill's feedback for it.=20
>>=20
>> Do I need to resubmit 4/4 with modified change log?=20
>=20
> Please just send new changelog text now.  I assume this [4/4] patch is
> useful without patch #5, but a description of why it is useful is
> appropriate.

Yes, 4/4 is useful with #5. Please find the updated change log.=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This patch uses newly added FOLL_SPLIT_PMD in uprobe. This preserves the=20
huge page when the uprobe is enabled. When the uprobe is disabled, newer=20
instances of the same application could still benefit from huge page.=20

For the next step, we will enable khugepaged to regroup the pmd, so that=20
existing instances of the application could also benefit from huge page=20
after the uprobe is disabled.=20

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Song Liu <songliubraving@fb.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>=20
> I trust the fifth patch is to be sent soon?

Yes, I am working on it.=20

Thanks,
Song=
