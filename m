Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6DEC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57822186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kDPouRu+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZWgVr7RQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDLFve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 01:51:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53296 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfDLFve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 01:51:34 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3C5oQSx010064;
        Thu, 11 Apr 2019 22:51:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=viM7UP/jZR96L2gEBymlCuDmI8yPTep3h/oo/NAk0PY=;
 b=kDPouRu+2c6hTPnbiqBxwWkeCgVbd5twe5pP3V1VdQ2yRhE0yqLQUmYC90sZUgXxoPss
 gJgTlkJTZ8/eJpAbWWbNJNJ6V1nglHxhaB1cg7wlkYPT/yNGNX1Ht1K660Qv1o7iZWme
 p+ILUDaLzFlmwwZFDKkncyDyMCw5IeJIUNY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rtbgysfm9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Apr 2019 22:51:18 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 11 Apr 2019 22:51:16 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 11 Apr 2019 22:51:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viM7UP/jZR96L2gEBymlCuDmI8yPTep3h/oo/NAk0PY=;
 b=ZWgVr7RQUv8SFY4uoTIfAN+od0Wnu6mjzZRc1YL/KfUCjSkIUi3A2K+bIIhreYLAFBOzVmdfb2pxQnr7v1SNefe74OzWRIVPCBH+OH1duj9PYsEpKd4uKQFahRi3RNyXKu2LAMAiZWEExvh8kvCPIb5i4XIQNxtC3XXLVu/gGqg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1536.namprd15.prod.outlook.com (10.173.235.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Fri, 12 Apr 2019 05:51:01 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1771.019; Fri, 12 Apr 2019
 05:51:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     kernel test robot <rong.a.chen@intel.com>
CC:     Nigel Croxon <ncroxon@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Xiao Ni <xni@redhat.com>, David Jeffery <djeffery@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "lkp@01.org" <lkp@01.org>
Subject: Re: 4f4fd7c579: mdadm-selftests.10ddf-fail-two-spares.fail
Thread-Topic: 4f4fd7c579: mdadm-selftests.10ddf-fail-two-spares.fail
Thread-Index: AQHU8NjJ4OsJxR4QcUW7e2aNVYtJV6Y4BbmA
Date:   Fri, 12 Apr 2019 05:51:01 +0000
Message-ID: <09AFFAAC-F1D8-4854-9120-BE9DEFBBD89E@fb.com>
References: <20190412023814.GI17122@shao2-debian>
In-Reply-To: <20190412023814.GI17122@shao2-debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:180::b596]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1902a6a-9a4e-4cdd-34f0-08d6bf0ad845
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1536;
x-ms-traffictypediagnostic: MWHPR15MB1536:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MWHPR15MB15364B2B3C4840B5B4829AC0B3280@MWHPR15MB1536.namprd15.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(51914003)(6306002)(6512007)(53936002)(478600001)(33656002)(14454004)(2906002)(966005)(6116002)(36756003)(6246003)(4326008)(102836004)(14444005)(5024004)(99286004)(256004)(82746002)(6506007)(76176011)(25786009)(11346002)(54906003)(53546011)(316002)(105586002)(446003)(5660300002)(46003)(186003)(106356001)(229853002)(81166006)(8676002)(81156014)(50226002)(71200400001)(6486002)(71190400001)(97736004)(83716004)(6436002)(8936002)(68736007)(2616005)(57306001)(476003)(86362001)(6916009)(486006)(305945005)(7736002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1536;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IbdZ1YAw4VvSi6iiqyCDNr0TRc1TbeIgcRjPwp1SVSVWCYQKhoEw9CtnEShUD0hSsc77BT5vH7bGfi6GiYZPyMbgbitLpcR4opXMoOsfFybZQDkf5tR0PHiy1t4TkqT5XoTGclBwOtgd4I2Ei34GbV4ot+ssgQIToFmzbo5zNQO9HJPP79rKGCp++7OAi0UXmDpmf66ppOuwMobJLtIJqNS4mQn9+I6IGysyuA35v0NKgf7Qjmpe/KlqUi666kBWalodDQsppFwXJ73l5TltSz6QsWBUIvG6D5EvKbusCJ08FdgvQ5RZoXG1nqo6PD0GCVXDCYgvxppUuwFFecKOfwznhluhXGolUr1jIbKtvNwMXRELz0eLVGqDXXIgbTJLJsBXjWfoyKRaN2CdWel46Yuh3f4iesaa7Nh0b9GAx/c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F4DD4DCB646854298C6D5E529A4A2B3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1902a6a-9a4e-4cdd-34f0-08d6bf0ad845
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 05:51:01.7004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1536
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 11, 2019, at 7:38 PM, kernel test robot <rong.a.chen@intel.com> wr=
ote:
>=20
> FYI, we noticed the following commit (built with gcc-7):
>=20
> commit: 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef ("Don't jump to compute_=
result state from check_result state")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>=20
> in testcase: mdadm-selftests
> with following parameters:
>=20
> 	disk: 1HDD
> 	test_prefix: 10
>=20
>=20
>=20
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 4G
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
> +-------------------------------------------------+------------+---------=
---+
> |                                                 | 81ba6abd2b | 4f4fd7c5=
79 |
> +-------------------------------------------------+------------+---------=
---+
> | boot_successes                                  | 1          | 0       =
   |
> | boot_failures                                   | 3          | 4       =
   |
> | BUG:kernel_reboot-without-warning_in_test_stage | 3          | 4       =
   |
> | mdadm-selftests.10ddf-fail-two-spares.fail      | 0          | 4       =
   |
> +-------------------------------------------------+------------+---------=
---+
>=20
> [  165.841336 ] Testing on linux-5.1.0-rc3-00023-g4f4fd7c kernel
> [  165.841339 ]
> [  167.302289 ] md/raid:md126: not clean -- starting background reconstru=
ction
> [  167.304321 ] md/raid:md126: device loop13 operational as raid disk 3
> [  167.306055 ] md/raid:md126: device loop12 operational as raid disk 2
> [  167.308044 ] md/raid:md126: device loop11 operational as raid disk 1
> [  167.309522 ] md/raid:md126: device loop10 operational as raid disk 0
> [  167.320733 ] md/raid:md126: raid level 6 active with 4 out of 4 device=
s, algorithm 10
> [  167.327158 ] md126: detected capacity change from 0 to 33554432
> [  167.409736 ] md: resync of RAID array md126
> [  167.561148 ] md/raid10:md125: not clean -- starting background reconst=
ruction
> [  167.563142 ] md/raid10:md125: active with 4 out of 4 devices
> [  167.568822 ] md125: detected capacity change from 0 to 33554432
> [  167.588867 ] md: delaying resync of md125 until md126 has finished (th=
ey share one or more physical units)
> [  168.171556 ] md: md126: resync done.
> [  168.202995 ] md: resync of RAID array md125
> [  168.438884 ] md: md125: resync done.
> [  168.998162 ] md/raid10:md125: Disk failure on loop11, disabling device=
.
> [  168.998162 ] md/raid10:md125: Operation continuing on 3 devices.
> [  169.044560 ] md/raid:md126: Disk failure on loop11, disabling device.
> [  169.044560 ] md/raid:md126: Operation continuing on 3 devices.
> [  169.104982 ] md: recovery of RAID array md125
> [  169.129051 ] md: delaying recovery of md126 until md125 has finished (=
they share one or more physical units)
> [  170.016071 ] md/raid10:md125: Disk failure on loop12, disabling device=
.
> [  170.016071 ] md/raid10:md125: Operation continuing on 2 devices.
> [  170.031796 ] md/raid:md126: Disk failure on loop12, disabling device.
> [  170.031796 ] md/raid:md126: Operation continuing on 2 devices.
> [  170.123425 ] md: md125: recovery interrupted.
> [  170.127705 ] md: recovery of RAID array md126
> [  170.132003 ] md: delaying recovery of md125 until md126 has finished (=
they share one or more physical units)
> [  177.280292 ] md: md126: recovery done.
> [  177.286369 ] md: recovery of RAID array md125
> [  177.304563 ] md: delaying recovery of md126 until md125 has finished (=
they share one or more physical units)
> [  183.347549 ] md: md125: recovery done.
> [  183.350452 ] md: recovery of RAID array md126
> [  183.368340 ] md: delaying recovery of md125 until md126 has finished (=
they share one or more physical units)
> [  190.512654 ] md: md126: recovery done.
> [  190.519633 ] md: recovery of RAID array md125
> [  197.641803 ] md: md125: recovery done.
> [  198.039343 ] tests/10ddf-fail-two-spares... FAILED - see /var/tmp/log =
for details
>=20
>=20
> To reproduce:
>=20
>        # build kernel
> 	cd linux
> 	cp config-5.1.0-rc3-00023-g4f4fd7c .config
> 	make HOSTCC=3Dgcc-7 CC=3Dgcc-7 ARCH=3Dx86_64 olddefconfig
> 	make HOSTCC=3Dgcc-7 CC=3Dgcc-7 ARCH=3Dx86_64 prepare
> 	make HOSTCC=3Dgcc-7 CC=3Dgcc-7 ARCH=3Dx86_64 modules_prepare
> 	make HOSTCC=3Dgcc-7 CC=3Dgcc-7 ARCH=3Dx86_64 SHELL=3D/bin/bash
> 	make HOSTCC=3Dgcc-7 CC=3Dgcc-7 ARCH=3Dx86_64 bzImage
>=20
>=20
>        git clone https://github.com/intel/lkp-tests.git
>        cd lkp-tests
>        find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 	bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is atta=
ched in this email
>=20
>=20
>=20
>=20
> Thanks,
> Rong Chen
>=20
> <config-5.1.0-rc3-00023-g4f4fd7c><job-script.txt><dmesg.xz><mdadm-selftes=
ts.txt>

Thanks for the report. We are discussing this patch. We may
revert it.=20

Song

