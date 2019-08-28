Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DAAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145B022CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Gofb3zpq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AO4Np6jZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfH1Udg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:33:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64124 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbfH1Udf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:33:35 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x7SKWa5X006609;
        Wed, 28 Aug 2019 13:32:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=eg8uKao73Su5GWi2dwKstvWKvPQI2MaFov3khEMgkDs=;
 b=Gofb3zpqgA7w3foTmXK/Dve+DMPyq3ffhHTCQtIn04rWP6VjopK1/RiXObnN/fJvkf33
 kQb8WAebc3mDXn/Ml/gyyX/nSvkHOm/06EOzTU4WQbPRTT4IfUdr/H/xwG5NI9693AZh
 OjVepDrTqRJB0kEJ2PdHsmosM+pfhQM7064= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2unuwq9m0v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Aug 2019 13:32:55 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Aug 2019 13:32:54 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 28 Aug 2019 13:32:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqf0NVRISpDe6OHrL4c6bbc0lsh06oPY5chbeLxrF9ylchEm96jZ4d/5cDfd8ZXPs6BtMY2WpU8JFVI0B3/C6o+X5meQqwaKglBcYoa193UJ2JLAqA8E2/q/ysumpel8/hCvGo9j1riaDpr43+oU3U7aH/9nePjxlEGculZrO9l7iBs9jZ6fIMkjmrrOXhTdQ/f9CNNGKtXZq2EO7uOl8X8yXs0jWt+0O+eqGdLHfFilGMGGvFyzFTIztXV5Z2i+JxCVJdSMBOUvSAsNsV5CctgKp4MNJuvklcVpwupgziX86lTAVBkrnF3ZGRDcxdNfVFpcsKuvISdqJJguY/cLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg8uKao73Su5GWi2dwKstvWKvPQI2MaFov3khEMgkDs=;
 b=hAxfNbG7GvoO5k9u4dhUBCCQMLcdAxmPZnO1noLU2OUOEfmFiBicZCsHGx8j5pCiz/LRaMVooSry8z0Bya8gHLrcsld5WXEoq/ihapDg4MShs0XRgZU29DNxGLlKDr5L7KX7aJlMhSWAEgVhFnvG8wIC00eC33dJh1BIjdh8/a0gaNm73EFzYe5iBwb454nvApakWl9yvYw0N5hpk6F5Q6Z6znVWaCdVsf5rqgrjt+sEX6GeaGkLgeIWyhryELn+B5m/1nnU+MaK6UXFKLwn5bH3K9w22g3K3eT4siE6t2M2igusMyZ6EpSzcDpEhxeUtK5vxlKK6pKMgvlYtdc6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg8uKao73Su5GWi2dwKstvWKvPQI2MaFov3khEMgkDs=;
 b=AO4Np6jZ/2VBGYTHsdHFgSSY+WcFDia/S7W5uxqt0K/WVLpJe8IDsxi32NqO5pJ6uw4r8iFMPEd8Xr8vV00DVlE1nsDGBnmMkeprRLrBXfWXYSNj0u6O4Y+gC3szUaYNyrKdTtM0RGx5UF4GbDdPgkug+Eg3wAcGTjsCChke5bw=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1680.namprd15.prod.outlook.com (10.175.141.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 20:32:54 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 20:32:54 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rik van Riel" <riel@surriel.com>
Subject: Re: [patch 1/2] x86/mm/pti: Handle unaligned address gracefully in
 pti_clone_pagetable()
Thread-Topic: [patch 1/2] x86/mm/pti: Handle unaligned address gracefully in
 pti_clone_pagetable()
Thread-Index: AQHVXa1SnM+Gh7oAvk+r6MnSURCjbqcQtC2AgAABSwCAACOGgIAAI5IAgAAHnYA=
Date:   Wed, 28 Aug 2019 20:32:54 +0000
Message-ID: <9B34E971-20ED-4A58-B086-AB94990B5A26@fb.com>
References: <20190828142445.454151604@linutronix.de>
 <20190828143123.971884723@linutronix.de>
 <55bb026c-5d54-6ebf-608f-3f376fbec4e5@intel.com>
 <alpine.DEB.2.21.1908281750410.1938@nanos.tec.linutronix.de>
 <309E5006-E869-4761-ADE2-ADB7A1A63FF1@fb.com>
 <alpine.DEB.2.21.1908282029550.1938@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908282029550.1938@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::cae3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8d2d0e8-2346-4010-d979-08d72bf6e77f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1680;
x-ms-traffictypediagnostic: MWHPR15MB1680:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB168014F63099ECB773320F51B3A30@MWHPR15MB1680.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(366004)(39860400002)(54534003)(189003)(199004)(53936002)(6506007)(14444005)(53546011)(4326008)(478600001)(102836004)(186003)(71200400001)(50226002)(76176011)(71190400001)(6916009)(99286004)(256004)(305945005)(229853002)(81166006)(81156014)(6306002)(54906003)(7736002)(66946007)(8676002)(25786009)(33656002)(6116002)(6436002)(966005)(57306001)(86362001)(6486002)(486006)(476003)(2616005)(14454004)(36756003)(5660300002)(46003)(316002)(8936002)(66446008)(2906002)(64756008)(76116006)(66476007)(446003)(66556008)(6512007)(6246003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1680;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V/VvpF2zBbswliPsotJZGhwTAbck7LYkbeHQMUNwgN7zIdbuDUu2Bqs0/HAtNrhABICftBJQzgX9skdZ2veVhlLiuehr9TPe4XlNgnXPjKBqWziTiWV72llO/wepKC9urnlTm+3s8mjT167/klpm0KtFN5+85jrNBEGo9WAjHWQTMgsdts2uT62VRebY98HQCG0BRffWauRSfXQeqeASd7vZJnyx6G+gvWoQkQ3wrUSj8bAXUy8OuVTRkNQMC9F3gWSufeDVbEC15FKeB/XfCI+tMfzBud2cDwbxJUdxd3FRRPifVCbebvau8y7BsA1Jz+YXkRNbR1K7iqTpJ++bZEZI5rLjS8ahHK6TbPfzgwiZazkQUDYEi5kH23sGpkO8E6Cch6vJJv2zmj3Ogm0AeJM4u9Zevx23XkrpLOPl3Wc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFDEBCF37323BA46B5E8877AE7E95798@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d2d0e8-2346-4010-d979-08d72bf6e77f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 20:32:54.0859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgIDyfthePOkY1IvmW0utijjtHa7JFe2HNfl6B0HwhGXMqtfTDh737sgHsT90NFeqZhVvzOnXkfatY+F6PjPTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1680
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-28_10:2019-08-28,2019-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908280202
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 28, 2019, at 1:05 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> On Wed, 28 Aug 2019, Song Liu wrote:
>>> On Aug 28, 2019, at 8:51 AM, Thomas Gleixner <tglx@linutronix.de> wrote=
:
>>>=20
>>> On Wed, 28 Aug 2019, Dave Hansen wrote:
>>>> On 8/28/19 7:24 AM, Thomas Gleixner wrote:
>>>>> From: Song Liu <songliubraving@fb.com>
>>>>>=20
>>>>> pti_clone_pmds() assumes that the supplied address is either:
>>>>>=20
>>>>> - properly PUD/PMD aligned
>>>>> or
>>>>> - the address is actually mapped which means that independent
>>>>>  of the mapping level (PUD/PMD/PTE) the next higher mapping
>>>>>  exist.
>>>>>=20
>>>>> If that's not the case the unaligned address can be incremented by PU=
D or
>>>>> PMD size wrongly. All callers supply mapped and/or aligned addresses,=
 but
>>>>> for robustness sake, it's better to handle that case proper and to em=
it a
>>>>> warning.
>>>>=20
>>>> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
>>>>=20
>>>> Song, did you ever root-cause the performance regression?  I thought
>>>> there were still some mysteries there.
>>>=20
>>> See Peter's series to rework the ftrace code patching ...
>>=20
>> Thanks Thomas.=20
>>=20
>> Yes, in summary, enabling ftrace or kprobe-on-ftrace causes the kernel
>> to split PMDs in kernel text mapping.=20
>>=20
>> Related question: while Peter's patches fix it for 5.3 kernel, they don'=
t=20
>> apply cleanly over 5.2 kernel (which we are using). So I wonder what is
>> the best solution for 5.2 kernel. May patch also fixes the issue:
>>=20
>> https://lore.kernel.org/lkml/20190823052335.572133-1-songliubraving@fb.c=
om/
>>=20
>> How about we apply this patch to upstream 5.2 kernel?
>=20
> That's not how it works. We fix stuff upstream and it gets backported to
> all affected kernels not just to the one you care about.

Agreed. I am trying to back port Peter's patch set to 5.2 kernel. There=20
are 9 dependencies and some manual changes.=20

>=20
> Aside of that I really disagree with that hack. You completely fail to
> explain why that commit in question broke it and instead of fixing the
> underlying issue you create a horrible workaround.
>=20
> It took me ~10 minutes to analyze the root cause and I'm just booting the
> test box with a proper fix which can be actually tagged for stable and ca=
n
> be removed from upstream again once ftrace got moved over to text poke.
>=20
> I'll post it once it's confirmed to work and I wrote a comprehensible
> changelog.

This sounds great. Thanks!

Song

