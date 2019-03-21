Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F29EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572832175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="rSYYYQZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfCUQmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:42:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:49964 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728606AbfCUQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:42:10 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LGe0Uo006546;
        Thu, 21 Mar 2019 09:41:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=8Pvf8oHg82niFGYJXh/VjxZJoKamalCo1i/NzMEPTBg=;
 b=rSYYYQZ4vjVW2Atuq2/nKxB2bDIGDzqBapD4VYya/rKwGBxLsfyk5IqbUKX8JJVNwf+z
 McknAqy29QaaY3VW+m+B7P2QGeroEMTdybylREUkCB8rA8TjohsALJozzYVeO1gcIegj
 0XIRea+B4LVz2fH0Bz577HKv6AMsEo/1YM0/22OwGNsVAwxy6Q6xwvPl18ej5Ts7cy8B
 DXnr55VocxhDJEgEnlCFxH0bOxliJwh7Y8UVRTb1tesWgqhMxKso/Wi1ADp9SJ/IGI6u
 B7+Qlh0/hrXocqd/RtthctjsKWZkgscjHGgYyrxkB+gdqTHWC/EBuYJ1nivQmrrZ4s6w Mg== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2raymgcy0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Mar 2019 09:41:28 -0700
Received: from BN6PR02MB2643.namprd02.prod.outlook.com (10.173.145.9) by
 BN6PR02MB2626.namprd02.prod.outlook.com (10.173.145.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 16:41:22 +0000
Received: from BN6PR02MB2643.namprd02.prod.outlook.com
 ([fe80::dc2f:537e:217c:eeae]) by BN6PR02MB2643.namprd02.prod.outlook.com
 ([fe80::dc2f:537e:217c:eeae%5]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 16:41:22 +0000
From:   Felipe Franciosi <felipe@nutanix.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Stefan Hajnoczi <stefanha@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Fam Zheng <fam@euphon.net>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Harris, James R" <james.r.harris@intel.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thanos Makatos <thanos.makatos@nutanix.com>,
        John Ferlan <jferlan@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Amnon Ilan <ailan@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: 
Thread-Index: AQHU4ADuKvHuIYUDfEGa4EL50z9kgaYWRFIAgAAFfgA=
Date:   Thu, 21 Mar 2019 16:41:22 +0000
Message-ID: <E217011E-C273-442D-AF99-84D3CD63FE77@nutanix.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
 <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
 <20190321161239.GH31434@stefanha-x1.localdomain>
 <20190321162140.GA29342@localhost.localdomain>
In-Reply-To: <20190321162140.GA29342@localhost.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acf1d576-a519-4c70-c1a5-08d6ae1c0d22
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB2626;
x-ms-traffictypediagnostic: BN6PR02MB2626:
x-proofpoint-crosstenant: true
x-microsoft-antispam-prvs: <BN6PR02MB262629C331BCAC187E91BBA1D7420@BN6PR02MB2626.namprd02.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(136003)(346002)(199004)(189003)(99286004)(6512007)(4743002)(14444005)(486006)(6436002)(305945005)(86362001)(7416002)(82746002)(81156014)(97736004)(93886005)(2616005)(7736002)(53546011)(8676002)(25786009)(105586002)(76176011)(4326008)(7116003)(6506007)(5660300002)(106356001)(6116002)(81166006)(3846002)(446003)(54906003)(11346002)(2906002)(229853002)(186003)(102836004)(6916009)(8936002)(316002)(14454004)(66066001)(26005)(33656002)(256004)(476003)(6246003)(221173001)(478600001)(68736007)(3480700005)(6486002)(71190400001)(83716004)(36756003)(71200400001)(53936002)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR02MB2626;H:BN6PR02MB2643.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HZdvC2PH/WLaRGOt71Q8ROY7zd6DIYqen3bTuv3Cjt5Gxoa/6VjmUX+Z/+0rxeff5uChQhpmvbBZ5Yb632oS2q+lDa8R57rkSQvRdJfvrmCYq0ZRBIEB4NSV+2J1V3vzhs12sZM8i0rGZug9/9rdQPD5quCFwvjNL8Ch2eHh3aUCCgnh62FssfpL+t1hSbggCU5u88sgh4mgN8ZOLqcGvEMZ1qvR8kzL98Xs48zAqWmtufWPimmo3NBMdkoEV+zvnia/ax6llXkt2fYE3MNZ5DydcLh+SWY27XnVqx2sp+VDCZ4hQl69F+bbExWLOa+OYw09lEGjZjY3I9IUz9eIVEC699XL44C0M46Kp78zpk9m9LXWV1pPnB8r51iK+TAcUVA6sdRGEnubCT3hwDjjMAkyRY5s1lpCvkvmE7ljyng=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <511DDC8BA63D0F45BDECD92378A6DAC5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf1d576-a519-4c70-c1a5-08d6ae1c0d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 16:41:22.1121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2626
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 21, 2019, at 4:21 PM, Keith Busch <kbusch@kernel.org> wrote:
>=20
> On Thu, Mar 21, 2019 at 04:12:39PM +0000, Stefan Hajnoczi wrote:
>> mdev-nvme seems like a duplication of SPDK.  The performance is not
>> better and the features are more limited, so why focus on this approach?
>>=20
>> One argument might be that the kernel NVMe subsystem wants to offer this
>> functionality and loading the kernel module is more convenient than
>> managing SPDK to some users.
>>=20
>> Thoughts?
>=20
> Doesn't SPDK bind a controller to a single process? mdev binds to
> namespaces (or their partitions), so you could have many mdev's assigned
> to many VMs accessing a single controller.

Yes, it binds to a single process which can drive the datapath of multiple =
virtual controllers for multiple VMs (similar to what you described for mde=
v). You can therefore efficiently poll multiple VM submission queues (and m=
ultiple device completion queues) from a single physical CPU.

The same could be done in the kernel, but the code gets complicated as you =
add more functionality to it. As this is a direct interface with an untrust=
ed front-end (the guest), it's also arguably safer to do in userspace.

Worth noting: you can eventually have a single physical core polling all so=
rts of virtual devices (eg. virtual storage or network controllers) very ef=
ficiently. And this is quite configurable, too. In the interest of fairness=
, performance or efficiency, you can choose to dynamically add or remove qu=
eues to the poll thread or spawn more threads and redistribute the work.

F.=
