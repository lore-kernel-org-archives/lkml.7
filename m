Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE7EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B695820644
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bVyH6FKf";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dloUOH+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfH1RvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:51:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64386 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbfH1RvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:51:06 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7SHnHZC023664;
        Wed, 28 Aug 2019 10:49:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CVW4QWPO9RPkeojdAb/58KzrB2b63BhgxGQJ+d0kI4g=;
 b=bVyH6FKfGwDXtsgpunAjkPb/mQssaKEd99jT7GQyedgvZ2NYWS4m87JK9cWIAsclxNbu
 0Lj26b5mU/P91QeLHGh5sG1ykuhSYJv9umGdSU0C01Uyiy8pjtmFzMmJsHZlqcGB4wD/
 kzvEU+YaA6KFrCvKcLb4oAyk80nPUuu3Bno= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2unvfygntr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 10:49:36 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 28 Aug 2019 10:49:31 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 28 Aug 2019 10:49:30 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 28 Aug 2019 10:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBjHxMNXHpOUDoX0Ic4nibjTKpFLdDCxtJzzoXD4s4CxleRk3ooV7Md79X8eSQ318EUaicML/KJ6s6zNaJJrMtYZHK0DtyC/OY0QsQfGzr1fKUw+FlIa3A1lnDGNCrg6sdzdlbRdp7BDjt4TW5Lrjmfacg06wRKxDsiL4CRYFFUlCd/NpMtxNEp08wmXCePX3xZSsuQqP8+TkQIrNA4UYiy9YhRYzw1Cp3WVg/vjMr8sKv1d/yPFFaViEmI27/AHmylZFvjSnrJD0Oj1M1Tp264DQZMCFx/NqjPffFtmvj8NbIDcTBCgAiVrYoz+D0Okck/cOG+fbgMDv3V1W5Q0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVW4QWPO9RPkeojdAb/58KzrB2b63BhgxGQJ+d0kI4g=;
 b=hixCcak+o1u13f5F3PA3ZuHBk4chJ2HmP+VEmQ/EHhD8RONeM77SMnXbVO87ljYSuzhi6+mXjj7oW/cofbr5W8V6sMtAnMdUnGa9ymI1+RH88NTiFkaIut1W4wlOa4uOsSpePYBpUs21CNXaVnIbVkVVmUAuCRbA3wlkk3eWx1y9PT0Rid2sYRJyBaHAzwyUcxA/nwcDJdFLe1WUbSxrsHQEJ4MybkjXnC7pQYENDnRs1L4kfMlXpAWsKHmPjsAC4wYBt535g8p+GHEgHcZnOc85Qynp2LRudfewmmAk+KeStHgiLqXYDKGsoK2yvaGVsJGo4eFnXjzzk0xnlQwHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVW4QWPO9RPkeojdAb/58KzrB2b63BhgxGQJ+d0kI4g=;
 b=dloUOH+EleAbypL226NjUyoWNQ8UqwcBus2dMddYDGnFw76HplsMLRD0xPyYnqXZTe7jZruW66wpPr3NvNQfcIG/Cwg45WNAPS/sqOzBth0oH1N+IpP0009COBRtry8E/gA0oZi3ELcJC5J3jl8vhdjQw6Gy9/jRT/OVCpqPXA4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1854.namprd15.prod.outlook.com (10.174.96.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Wed, 28 Aug 2019 17:49:24 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 17:49:24 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch 2/2] x86/mm/pti: Do not invoke PTI functions when PTI is
 disabled
Thread-Topic: [patch 2/2] x86/mm/pti: Do not invoke PTI functions when PTI is
 disabled
Thread-Index: AQHVXa1fwgQObosxIkSWxQONTHvWuqcQ1n+A
Date:   Wed, 28 Aug 2019 17:49:24 +0000
Message-ID: <34AA7007-F41C-4EBB-8EF4-C9476078E03D@fb.com>
References: <20190828142445.454151604@linutronix.de>
 <20190828143124.063353972@linutronix.de>
In-Reply-To: <20190828143124.063353972@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::cae3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3382f82d-3ab9-406f-bc63-08d72be01078
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1854;
x-ms-traffictypediagnostic: MWHPR15MB1854:
x-microsoft-antispam-prvs: <MWHPR15MB1854E9D5D5141F48023066D0B3A30@MWHPR15MB1854.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(39860400002)(396003)(199004)(189003)(6512007)(11346002)(25786009)(7736002)(57306001)(102836004)(6436002)(305945005)(53936002)(4744005)(46003)(2906002)(5660300002)(8936002)(76116006)(8676002)(81156014)(81166006)(50226002)(478600001)(14454004)(66476007)(66556008)(64756008)(66446008)(66946007)(186003)(36756003)(6486002)(6116002)(33656002)(6246003)(6916009)(446003)(86362001)(316002)(2616005)(99286004)(4326008)(486006)(476003)(76176011)(71200400001)(54906003)(71190400001)(229853002)(256004)(6506007)(14444005)(53546011)(3714002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1854;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2UmSrjU1EfaNteMP7iZc/6BW1LipBmr397hqoPrugqjF/mDpFkDnQLGDJjlhUrFupAD0Gwxylsp8S1ZNXbYoFVyQej6jw6djLzDYlg4C4Tm/y4u6nmaJjvkDZ7rbOdqh5iGdNZ2CBfMFYhZzG/MvbQlyg/ob9N9OFRO5eb4sWAaNfggC4EdnjvPVjMwY0PQSl0zkfZ90ZJv7trd6vPNK7vTtjcyxdhFezx3T4exXUyKGQ+deRRf+BE7B387ttBttAXxe5VV06I8usAaEaOOkzvpCeHdqZicLoCyb7oTM5boB0jd3LvxTdEOvge6JUuv3i201GHiMr0UXC2KMoP+ZEGxXYA4/x64CpFb16AXzrSNcZhcFaOIX0SIm7BkGl65RX81zpDZ93MW7dE4dHeIGhoWD/7JXlCfwmGlpZ78iMIo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCE9FC2B5240504FA28E34827C186403@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3382f82d-3ab9-406f-bc63-08d72be01078
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 17:49:24.4101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FqGmoFCVH/b7nzUdBd2IuhmAHKpGSLMZ4fY2f1a2SXm535Y4RbOWuVBJw0ld1g28UN/Zt9Niim9jyuxikbXJxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1854
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-28_08:2019-08-28,2019-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=827 clxscore=1015 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908280174
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 28, 2019, at 7:24 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> When PTI is disabled at boot time either because the CPU is not affected =
or
> PTI has been disabled on the command line, the boot code still calls into
> pti_finalize() which then unconditionally invokes:
>=20
>     pti_clone_entry_text()
>     pti_clone_kernel_text()
>=20
> pti_clone_kernel_text() was called unconditionally before the 32bit suppo=
rt
> was added and 32bit added the call to pti_clone_entry_text().
>=20
> The call has no side effects as cloning the page tables into the availabl=
e
> second one, which was allocated for PTI does not create damage. But it do=
es
> not make sense either and in case that this functionality would be extend=
ed
> later this might actually lead to hard to diagnose issue.
>=20
> Neither function should be called when PTI is runtime disabled. Make the
> invocation conditional.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Song Liu <songliubraving@fb.com>

