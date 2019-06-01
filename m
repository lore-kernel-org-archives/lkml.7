Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F412C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 04:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4F227116
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 04:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="U0QSsqFg";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="N1FnC6Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfFAEZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 00:25:42 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:44086 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbfFAEZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 00:25:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x514PSvl028979
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 21:25:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=nuKr3htPJhdii8ANK1usteKgh3OCu7nJ6JaST00moT0=;
 b=U0QSsqFgoX3gJE3Roe27IZAA2k2cHp+YaCgDLjKJ9SeqSLU8cKLPLwVzYbBNq69mE0bZ
 Rcw6avv94kN1ajdB7JEJZw6/H3/JwR+yfMxdAyiV12VItk8L9gEDcSytKD2NaV7BRyFA
 QJWTSsFmZ44MAmj/FLbgkLJ4oTgpy5ERAb6xykbZ5OF/wFeBFEPjSBXqubm4LElpI7uW
 +WnlK4LPXZrSTulpLkdYNoJWlusKOcMIgr/IWey2xhbKit5iGrhoJRbl25j2nSD8nqqy
 HwV/nqfz3EgWRrfkdwa4vkrBb+a0s0UVUC5bShpdxMMfZcJzpkJvnN2qq6HD5DbreHtp Vg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2su5xh2s40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 21:25:40 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 31 May
 2019 21:25:38 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.52) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 31 May 2019 21:25:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuKr3htPJhdii8ANK1usteKgh3OCu7nJ6JaST00moT0=;
 b=N1FnC6FsGL8GptvC1DHbSG26pOSNW3iIR2ZcBco/7CrfTwinZ4WQfiiEgTz7by7JgR1yAeJAusR7rvMiSOEFlodsxdiCDDqqy+Ims/LTG+Z7VW6WeXD2BARl8R3abEShb+WHzvy+LEiB5VKcTvzbtEzNyAQ2v7qEk67TS79h59Y=
Received: from BN6PR1801MB2065.namprd18.prod.outlook.com (10.161.157.12) by
 BN6PR1801MB2050.namprd18.prod.outlook.com (10.161.153.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.21; Sat, 1 Jun 2019 04:25:35 +0000
Received: from BN6PR1801MB2065.namprd18.prod.outlook.com
 ([fe80::dcb8:35bc:5639:1942]) by BN6PR1801MB2065.namprd18.prod.outlook.com
 ([fe80::dcb8:35bc:5639:1942%5]) with mapi id 15.20.1922.021; Sat, 1 Jun 2019
 04:25:35 +0000
From:   Yuri Norov <ynorov@marvell.com>
To:     Qian Cai <cai@lca.pw>, Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>
CC:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Dexuan Cui <decui@microsoft.com>,
        "v-lide@microsoft.com" <v-lide@microsoft.com>,
        "Yury Norov" <yury.norov@gmail.com>
Subject: Re: [PATCH -mm] mm, swap: Fix bad swap file entry warning
Thread-Topic: [PATCH -mm] mm, swap: Fix bad swap file entry warning
Thread-Index: AQHVGDIGV2zQWjMkJ0mLcCoMq5uXRw==
Date:   Sat, 1 Jun 2019 04:25:35 +0000
Message-ID: <ba248cf9f2344d0db6d029ae82a32c52BN6PR1801MB2065F9E5FF6F9E8928879290CB190@BN6PR1801MB2065.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-originating-ip: [2601:648:8300:77e8:50ea:80dc:e366:5a32]
x-ms-office365-filtering-correlation-id: a8f68b22-c0a0-4486-2e11-08d6e64931a3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR1801MB2050;
x-ms-traffictypediagnostic: BN6PR1801MB2050:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BN6PR1801MB2050ADCAA80DDDBA507CC231CB1A0@BN6PR1801MB2050.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00550ABE1F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(366004)(346002)(39860400002)(189003)(199004)(102836004)(5660300002)(8676002)(81156014)(6506007)(8936002)(25786009)(476003)(478600001)(7696005)(86362001)(71200400001)(71190400001)(4326008)(14454004)(81166006)(966005)(68736007)(2906002)(7736002)(45080400002)(66446008)(305945005)(64756008)(74316002)(66556008)(6436002)(107886003)(66476007)(66946007)(316002)(73956011)(486006)(6246003)(53936002)(76116006)(55016002)(256004)(6306002)(118296001)(99286004)(229853002)(186003)(6116002)(46003)(110136005)(9686003)(54906003)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1801MB2050;H:BN6PR1801MB2065.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FBHiHz4YKP6Dh8svuuTm0cuD73CxRQ15plCpCUgrDuQTyqfwTW5CGXnTQycuxnegHehfn1G5O1sXD251M2kE+GH2PcXlFCPVXKIrOhSRszq8uAsk5NmuKLjUyZbdoyDVnPAXsDMdeozMBkGZZG7HEnZ2J8rr6h2Z/AbvwH9hYmnJjtYcB8OplDNq8RwaXPuK6xAqEr8PTbaiTdDjq0RXlXhlbDq4p1YPYOmCfOLgukDZXjfsIKrYda8P07UGsLiXgsKhbqwQXzJzy51Lxrwuv4O8Y6Khpak75M1xQy7zhgEIo1s/iB+B1BwMrR845Ba6EH3wW3xKvoCuln8GcLHxRofO0kmPaxG3DAZvw2qRmch12zKAo1rMRly/Fbk9ein8z38ibjoUrwG14CyuNurfdqAoZSPysnhOjaf2wdajDZk=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <563594FB5DAE5E42842E3221D7217725@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f68b22-c0a0-4486-2e11-08d6e64931a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2019 04:25:35.7600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynorov@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1801MB2050
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-01_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend as LKML didn't take outlook settings.)

> On Fri, 2019-05-31 at 11:27 -0700, Dexuan-Linux Cui wrote:
> > Hi,
> > Did you know about the panic reported here:
> >  https://marc.info/?t=3D155930773000003&r=3D1&w=3D2
> >=20
> > "Kernel panic - not syncing: stack-protector: Kernel stack is
> > corrupted in: write_irq_affinity.isra> "
> >=20
> > This panic is reported on PowerPC and x86.
> >=20
> > In the case of x86, we see a lot of "get_swap_device: Bad swap file ent=
ry"
> > errors before the panic:
> >=20
> > ...
> > [=A0=A0=A024.404693] get_swap_device: Bad swap file entry 5800000000000=
001
> > [=A0=A0=A024.408702] get_swap_device: Bad swap file entry 5c00000000000=
001
> > [=A0=A0=A024.412510] get_swap_device: Bad swap file entry 6000000000000=
001
> > [=A0=A0=A024.416519] get_swap_device: Bad swap file entry 6400000000000=
001
> > [=A0=A0=A024.420217] get_swap_device: Bad swap file entry 6800000000000=
001
> > [=A0=A0=A024.423921] get_swap_device: Bad swap file entry 6c00000000000=
001

[..]

I don't have a panic, but I observe many lines like this.

> Looks familiar,
>
> https://lore.kernel.org/lkml/1559242868.6132.35.camel@lca.pw/
>
> I suppose Andrew might be better of reverting the whole series first befo=
re Yury
> came up with a right fix, so that other people who is testing linux-next =
don't
> need to waste time for the same problem.

I didn't observe any problems with this series on top of 5.1, and there's a=
 fix for swap\
that eliminates the problem on top of current next for me:
https://lkml.org/lkml/2019/5/30/1630

Could you please test my series with the patch above?

Thanks,
Yury

     =
