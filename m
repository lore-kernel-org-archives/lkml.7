Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0201C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7F920880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="Jsaj1HHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390716AbfGRPYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:24:11 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:36406 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727623AbfGRPYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:24:11 -0400
X-Greylist: delayed 1881 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2019 11:24:09 EDT
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6IEjhmR001012;
        Thu, 18 Jul 2019 09:50:50 -0500
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2054.outbound.protection.outlook.com [104.47.49.54])
        by mx0b-00010702.pphosted.com with ESMTP id 2ts0d2sdm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 09:50:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcGMZzYSkeWjW2zHrDf9y/IYd+bi5ygoGzt5gs7jH/JnzYe3Su2RJm6IVhsLpfMuTUj2kRfUQuORWsoEZ9z2nGmk7w/DDza/1ArgGd7U4YlPqFtb0NZg1BbFZdaEVm38Eht2UeY2aj60Pidubhu+xgHtyRtGUMhznRcPjKAoH2WmfLbzB7/ykqD0NvMOEgeRBBVqBdiQ3lXjyak6Kn10kx46AJ5jSfLk3uTAmhb6HBdsL0/RXIYOjhOEgwEnlhmbkVp5dRoJvxGNdAolNq2iV5AMGp6UYvDmOHx8pJ741F2tJIVmradkmcIy9P8mU9lnJNu0IEWv96DHJ7QA1Nqjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y73QpYDz2dbaOtgBZUW/QrhQX2seNr2ZOW22JP7A5c=;
 b=Ph9Myu+n40EYNPZ4DUPN7CT2ARIc4qDjENcXLr/UCa0fsloWxpQ93pBCCf8IUCBx6AEXtoajSPHEfw/DkoKhPWWBkl03VJmFpcQgEDRKjgEsG8d0j5n38WMgXGnPftr3lBOcPBz04l8LFNLnYtGYndv0jsGaeyTaoTKw92fa9AZj74I9Mplx4lvOgCBs5GbFji/atGDKsLOrNDQWtGiQtKQ2e+WVtlWSYXXXLiB/YYl9eoRB4wsEY0r4rE/jLlkYRDb949ZJbMRsVFzdKfP/ye7/J/Y12niDlwm+UNkULBFDitNEe4xAzDamE0KWs2k9aC6sT9xNakKMXa4cJTyfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=ni.com;dmarc=pass action=none header.from=ni.com;dkim=pass
 header.d=ni.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y73QpYDz2dbaOtgBZUW/QrhQX2seNr2ZOW22JP7A5c=;
 b=Jsaj1HHRUI1SSftzZqfav2k76PS1lmiYKlCrcJu9HrJLb3X62Ul3Vwtfkylz1W+y5vrr7mesQjmEwRpB4IVZwTOV+pc/6zvu1eqGpHl1tvuDRoxf2lbDYoX3kpcligoS0NrlZF95c57dZX2H1vZE7FrPmQLTEdSlVJRUzoMBKZo=
Received: from BN6PR04MB0963.namprd04.prod.outlook.com (10.174.233.163) by
 BN6PR04MB1235.namprd04.prod.outlook.com (10.174.234.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 14:50:46 +0000
Received: from BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c926:1efe:9535:239c]) by BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c926:1efe:9535:239c%5]) with mapi id 15.20.2073.015; Thu, 18 Jul 2019
 14:50:46 +0000
From:   Julia Cartwright <julia@ni.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Linus Torvalds <torvalds@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <clark.williams@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Gratian Crisan <gratian.crisan@ni.com>
Thread-Topic: [EXTERNAL] [patch V2 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
Thread-Index: AQHVPXguhdAZfomJW0CBjlgFAcO5Hg==
Date:   Thu, 18 Jul 2019 14:50:46 +0000
Message-ID: <20190718145045.GH29109@jcartwri.amer.corp.natinst.com>
References: <20190715150402.798499167@linutronix.de>
 <20190715150601.205143057@linutronix.de>
 <alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0023.namprd02.prod.outlook.com
 (2603:10b6:803:2b::33) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a8dd360-c988-4659-d2da-08d70b8f5114
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR04MB1235;
x-ms-traffictypediagnostic: BN6PR04MB1235:
x-microsoft-antispam-prvs: <BN6PR04MB1235C2A25D843148E8EC50F1F4C80@BN6PR04MB1235.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(66446008)(81166006)(4744005)(316002)(53936002)(186003)(2906002)(7736002)(446003)(6916009)(33656002)(54906003)(229853002)(81156014)(1076003)(102836004)(8936002)(305945005)(66556008)(11346002)(7416002)(14454004)(9686003)(6436002)(6486002)(8676002)(68736007)(71200400001)(52116002)(26005)(476003)(4326008)(6246003)(386003)(5660300002)(66476007)(99286004)(66066001)(71190400001)(6512007)(486006)(6116002)(6506007)(64756008)(478600001)(256004)(25786009)(76176011)(66946007)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB1235;H:BN6PR04MB0963.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gxHmfqglT05JscROU7LX5Mf3lR1Q6sGUEIzwxBGpkIOr5WUFh71J3RRgonUUrnE1tEQtOC2Z+ACgPBTF2ZaCHEQZ/CXv0ZvxZ8pMuOL14CWhq+eIZ7LhYtlVcBoxHI+ofu1oBl87HrnBmLG+wWLFCui3KByCC3UZCSfOZ8UmO59yhPrYk2OyEEBnk6P6uH7bBDZ/wN+o6D4fidB/7d6qXQcMrmjk5IAzvJAcu/+Il3dhtpaDb3kx1u9ITUQ/o73Qaye6hnbNj2NCounJxpILrWj5WRdQH15qof6bSWoIp9aFphEN4piW/zDOop7EOW9L1YZcvs/t1TidPhJ8mJfR2ysXA+E54Pn73QIr80DxLSZCst/alOhIe8IlgXYqWWHjdFl4yo+ifyrIto43eRNSRlf2pi6ZVQ/uIm0hy/nujpk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <205A59D371F27D41AC7157FB94F519EC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8dd360-c988-4659-d2da-08d70b8f5114
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 14:50:46.5971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: julia.cartwright@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1235
Subject: Re: [patch V2 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-18_07:2019-07-18,2019-07-18 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1011 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-1904300001
 definitions=main-1907180154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:01:49PM +0200, Thomas Gleixner wrote:
> Add a new entry to the preemption menu which enables the real-time suppor=
t
> for the kernel. The choice is only enabled when an architecture supports
> it.
>=20
> It selects PREEMPT as the RT features depend on it. To achieve that the
> existing PREEMPT choice is renamed to PREEMPT_LL which select PREEMPT as
> well.
>=20
> No functional change.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Clark Williams <williams@redhat.com>
> Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Daniel Wagner <wagi@monom.org>
> ---

I'm excited to see where this goes.

Acked-by: Julia Cartwright <julia@ni.com>

  Julia
