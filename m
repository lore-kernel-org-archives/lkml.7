Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC23AC28D1E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B332220868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aUbCbCIr";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="tVLHzGay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfFFK2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:28:53 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33754 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727225AbfFFK2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:28:52 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56AS0Qp020856;
        Thu, 6 Jun 2019 03:28:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=PJW5FCm4KNKc7kzRgtW87TanNY+ZKLlMA74V1Kk66qQ=;
 b=aUbCbCIrnPKvvB0QLPSshzwLGOHTGbEFNBCuyQkeRftsdpuBroHPAjC+OlfQvFRvAw4i
 RKQxwNR3De14bvatYaNsTKLnW7iD9odz/G6Hn+MPMFX/+TNIueFK2FSoQ3Qv/1TLpks9
 /REfa4IpMw4/nJqkoFVGKkLTuB+ojDMm/rNtT0yNYEBdik3X7CuecWUn3dEamNA14j5t
 Nju/7Er8nZgQNgyINileK9rp/Z2s0aGTTnaEnU+m+XnGJtKQulVDs4sGUSMkLc6fv652
 M80WO/KcOpipkV+7e8FI61/+2g6vvkY8rPolrBLVfvyutuqs6BlQLcmjYUM1yOzApMU5 6A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sxthehbv8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Jun 2019 03:28:44 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 6 Jun
 2019 03:28:15 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Jun 2019 03:28:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJW5FCm4KNKc7kzRgtW87TanNY+ZKLlMA74V1Kk66qQ=;
 b=tVLHzGayHBP2gDRB0Yxi+QRAk5+qBJ+dJ4U+nIc7NiMImIblpLi/X64rFBw0OpsI+oxmyn7ZwrR3Ana42EZAfIV3BFcDTa3Kpracxf2dogk+CEql+6Xsb433OHdFUlDL33DFk1uUs9vDx0SaVEqn4vjAY4eN2plSYAn+PxHefGM=
Received: from DM5PR18MB1578.namprd18.prod.outlook.com (10.175.224.136) by
 DM5PR18MB1306.namprd18.prod.outlook.com (10.173.214.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.21; Thu, 6 Jun 2019 10:28:12 +0000
Received: from DM5PR18MB1578.namprd18.prod.outlook.com
 ([fe80::e42c:8f1f:ac4d:c16e]) by DM5PR18MB1578.namprd18.prod.outlook.com
 ([fe80::e42c:8f1f:ac4d:c16e%6]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 10:28:12 +0000
From:   Jan Glauber <jglauber@marvell.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Glauber <jglauber@cavium.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Jayachandran Chandrasekharan Nair" <jnair@marvell.com>
Subject: Re: [PATCH] lockref: Limit number of cmpxchg loop retries
Thread-Topic: [PATCH] lockref: Limit number of cmpxchg loop retries
Thread-Index: AQHVHFKKV4nY33iz10+fZHwc2kb4SA==
Date:   Thu, 6 Jun 2019 10:28:12 +0000
Message-ID: <20190606102803.GA15499@hc>
References: <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190605134849.28108-1-jglauber@marvell.com>
 <CAHk-=whPbMBGWiTdC3wqXMGMaCCHQ4WQh5ObB5iwa9gk-nCtzA@mail.gmail.com>
 <20190606080317.GA10606@hc> <20190606094154.GB6795@fuggles.cambridge.arm.com>
In-Reply-To: <20190606094154.GB6795@fuggles.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0007.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::20) To DM5PR18MB1578.namprd18.prod.outlook.com
 (2603:10b6:3:14d::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.43.112.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b43f5648-0a2c-44fe-420a-08d6ea69ad38
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR18MB1306;
x-ms-traffictypediagnostic: DM5PR18MB1306:
x-microsoft-antispam-prvs: <DM5PR18MB1306536481A8409834F2E397D8170@DM5PR18MB1306.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(39860400002)(136003)(346002)(366004)(396003)(189003)(199004)(64756008)(8936002)(6486002)(66476007)(478600001)(73956011)(66446008)(107886003)(446003)(1076003)(11346002)(186003)(99286004)(486006)(386003)(76176011)(33716001)(81156014)(316002)(3846002)(52116002)(4326008)(6116002)(66066001)(6506007)(102836004)(66556008)(71200400001)(71190400001)(6246003)(14454004)(26005)(476003)(33656002)(305945005)(25786009)(53936002)(66946007)(53546011)(6512007)(14444005)(6916009)(9686003)(8676002)(81166006)(86362001)(7736002)(54906003)(68736007)(2906002)(5660300002)(229853002)(6436002)(256004)(40753002)(133343001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1306;H:DM5PR18MB1578.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6oJYmYwikHxdJVTdQCqMkIX3IAX0KEASVliUaaqaXWFPjx1SYuaB6XmvoSrML0nApj9jvQP/EXi7DlLxAqrwrUj765nQ7IrN0Jl6Mk3zIVj8o7PigYERPYFEsK+DsSjXRBMtGUIy+sWQrejtvS1J4qLANoTJ35QyJkSVRWMI8egV5Q9ELMUxiTCZPVocz9T9ZfjqUtB19bno8VrysLm7gz9P+W4e8+TEQrje+VV6Tko2yVgbCzjLVhWEJ5oqZ6uY1mfmvw8dMKVDWff3nx9Wn+VydHqAeRxBLUFH54wXxVb0s6eFpGDmhxLhfHlUN8Ab9DzstAbzhzhUC1n5ozjzvbX6DTt8Fo8o99xsqtEJxKjVphev9AgQxY8jNZ0Ths2JrjgmSKrbfDej6WuHcwTqbuBywFk9YSIvMgtAYCHbpe8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2CD44727C3FE914C978967DCAAB861D3@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b43f5648-0a2c-44fe-420a-08d6ea69ad38
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 10:28:12.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jglauber@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1306
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:41:54AM +0100, Will Deacon wrote:
> On Thu, Jun 06, 2019 at 08:03:27AM +0000, Jan Glauber wrote:
> > On Wed, Jun 05, 2019 at 01:16:46PM -0700, Linus Torvalds wrote:
> > > On Wed, Jun 5, 2019 at 6:49 AM Jan Glauber <jglauber@cavium.com> wrot=
e:
> > > >
> > > > Add an upper bound to the loop to force the fallback to spinlocks
> > > > after some time. A retry value of 100 should not impact any hardwar=
e
> > > > that does not have this issue.
> > > >
> > > > With the retry limit the performance of an open-close testcase
> > > > improved between 60-70% on ThunderX2.
> > >=20
> > > Btw, did you do any kind of performance analysis across different
> > > retry limit values?
> >=20
> > I tried 15/50/100/200/500, results were largely identical up to 100.
> > For SMT=3D4 a higher retry value might be better, but unless we can add=
 a
> > sysctl value 100 looked like a good compromise to me.
>=20
> Perhaps I'm just getting confused pre-morning-coffee, but I thought the
> original complaint (and the reason for this patch even existing) was that
> when many CPUs were hammering the lockref then performance tanked? In whi=
ch
> case, increasing the threshold as the number of CPUs increases seems
> counter-intuitive to me because it suggests that the larger the system,
> the harder we should try to make the cmpxchg work.

For SMT=3D4 the top hit I see is queued_spin_lock_slowpath(). Maybe this is=
 more
costly with more threads, so trying harder to use lockref-cmpxchg makes
the microbenchmark faster in that case?

--Jan
