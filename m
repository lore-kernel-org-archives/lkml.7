Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E33C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B9320823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QjxMuIae";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="L3u7vkmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCDU7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:59:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52646 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbfCDU7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:59:52 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24Kr7vi022386;
        Mon, 4 Mar 2019 12:59:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8igHvu0nV4EvAZN8fURXO51CG5uLbRdKR8zJ2kZI9O8=;
 b=QjxMuIaeCDg/MWGmhfpf1P0UXjTyB4yFZRFGonT2qbNG7lVYSECsiXx6RdJlqIjr6da8
 J7YS/fRyjNgLEzc+1+oSjQAB7ItyR8Ng1u7PQ9lkuddp4yk3mpQdonRo6OGFrMlWthFb
 lKMX9Rs+gnuzQoQr4zhKNQiiX1MYpMiNbVY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r1bcg814x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 12:59:22 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 12:59:21 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 12:59:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8igHvu0nV4EvAZN8fURXO51CG5uLbRdKR8zJ2kZI9O8=;
 b=L3u7vkmyB9wGhjEUeUTZ0eSJBibJhwF8/qNoB73hGwVBRXOWBvh51NV1kTzanZWW6XBZNerHzPfZwxihX9ov8P18ZyLkEfRCY7pz3EExudnv5uy+HfSDzeDn+YsEuQel7nPY3RmBU7HH4SOop1j8spa6bPdhZ4wR/FkHXAibFQU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1822.namprd15.prod.outlook.com (10.174.255.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.17; Mon, 4 Mar 2019 20:59:00 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 20:59:00 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Christian Brauner <christian@brauner.io>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpf: fix sysctl.c warning
Thread-Topic: [PATCH] bpf: fix sysctl.c warning
Thread-Index: AQHU0sm+UeSSE6xtCkCep443A8dW2KX79B2AgAAAfIA=
Date:   Mon, 4 Mar 2019 20:58:59 +0000
Message-ID: <C94EB246-92FE-4A8D-AD60-C3D6F8292C0E@fb.com>
References: <20190304203443.1992942-1-arnd@arndb.de>
 <20190304205714.rhpgpp26rbaghs2i@brauner.io>
In-Reply-To: <20190304205714.rhpgpp26rbaghs2i@brauner.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:1d00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a91502ec-3858-47a0-d3c9-08d6a0e439bb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1822;
x-ms-traffictypediagnostic: MWHPR15MB1822:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1822;20:L5naOpr+qwGqb/88Fn9zrfAzc6JYrvy4PbJ327cr9/sCV4dUMDo5MEjqXABjcsb4gwWUJ67R7NSJSTihm7UC8SrYZ0uAQJX8SOlKPPkTLCFjEw0D2lqQWkiUAtozuzsbQ9FyAEEFSF4VnYd46JOZDRI5cRUSiXGcbNA7tXBdEhY=
x-microsoft-antispam-prvs: <MWHPR15MB1822BF5018C4FB25E3F7E590B3710@MWHPR15MB1822.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39860400002)(366004)(199004)(189003)(8676002)(82746002)(81166006)(68736007)(81156014)(57306001)(97736004)(50226002)(14454004)(4326008)(71200400001)(7416002)(33656002)(2616005)(2906002)(476003)(486006)(83716004)(229853002)(25786009)(186003)(53936002)(71190400001)(6512007)(54906003)(6506007)(102836004)(11346002)(105586002)(46003)(106356001)(6116002)(446003)(6486002)(6436002)(478600001)(7736002)(76176011)(86362001)(53546011)(99286004)(5660300002)(6246003)(256004)(316002)(8936002)(6916009)(14444005)(36756003)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1822;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xR4WUVecHAYBcso/70f4bUbJFewq5LygqcZx2J3RLxm0ec4GSrGsYDdWW/1OECcm6NUCiypakZS9Cgt/LWgPGR5e5UfjlZrtEYi/zxxGihCKYywe7RqpszjvxAczjpds12RMq859XaOA1nP2RRmD2EALt7xWdNs3YAMzjdSPKdQr0vgViAr1nIz3qxDMbIta4IC9eosyaUR6aZs6PXyUN9QRLjsGi+p3V1HY9dt9SyGSFKkWOS8XuRg8i/pA35XNzdL5OncR57JKYOqOuTYwBIy6z8a7XJvO29gLfDpRsj0leZg3BsQz346jaqkRXRgIvBKCb+rfImVJ4NFRvTV2sMfEaYq9o/qinfDVbdCAV+8Gwkmm7bOlEpMHISZSCj3Hl2jbvyo/a6Dyb85qLtXp7H6x6M5id3ywvFL544Chc6Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C1F0496849C3E4E80BAAE6BB9CE8DD3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a91502ec-3858-47a0-d3c9-08d6a0e439bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 20:58:59.9130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2019, at 12:57 PM, Christian Brauner <christian@brauner.io> wro=
te:
>=20
> On Mon, Mar 04, 2019 at 09:34:12PM +0100, Arnd Bergmann wrote:
>> When CONFIG_BPF_SYSCALL or CONFIG_SYSCTL is disabled, we get
>> a warning about an unused function:
>>=20
>> kernel/sysctl.c:3331:12: error: 'proc_dointvec_minmax_bpf_stats' defined=
 but not used [-Werror=3Dunused-function]
>> static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int w=
rite,
>>=20
>> The CONFIG_BPF_SYSCALL check was already handled, but the SYSCTL check
>> is needed on top.
>>=20
>> Fixes: 492ecee892c2 ("bpf: enable program stats")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Reviewed-by: Christian Brauner <christian@brauner.io>

Acked-by: Song Liu <songliubraving@fb.com>

>=20
>> ---
>> kernel/sysctl.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 46a0d0a14a66..b3df3ab7ac28 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -3330,7 +3330,7 @@ int proc_doulongvec_ms_jiffies_minmax(struct ctl_t=
able *table, int write,
>>=20
>> #endif /* CONFIG_PROC_SYSCTL */
>>=20
>> -#ifdef CONFIG_BPF_SYSCALL
>> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_SYSCTL)
>> static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int w=
rite,
>> 					  void __user *buffer, size_t *lenp,
>> 					  loff_t *ppos)
>> --=20
>> 2.20.0
>>=20

