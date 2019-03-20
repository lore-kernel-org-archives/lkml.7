Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B21C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4591720685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="tuG10KjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCTLEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:04:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:59186 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbfCTLEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:04:13 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KAxfZe008189;
        Wed, 20 Mar 2019 04:03:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=/HzU8pshn152h6Ij9RuTO1qrkTeg6h1jyvyYw+9Y7Fo=;
 b=tuG10KjH25HHW8MSVAgT6X/DIDu8NAUSKoHLvm0M+P4CY3WelGi/rnDvISl33nuSRnJ8
 f8Ugot3wtQmxbgx4eU74c06w1DXhhzFB1fugeH0nprIMNugTmMfNmfoqJLzN9WL/NZxI
 hFlw2eWY7ulA2TCWA1B4IrT1vpTOFScFObjjD/wf4Dn9F6MmKuhNjwyowTDM3EMW6fuS
 FcZK0ABh5WX+A1v86XL0y465CrdOVHb4zffvSD5KucGCdUcIa4e4EdoYw9Ib/Alqr2zX
 6xDpJ/a/p+x5nMegNn2IlDjlIBMsxNUy5ME5W1xOuoxnojdIiUUn76uLlidEK3/FPeLO Sg== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2050.outbound.protection.outlook.com [104.47.33.50])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2rb8t28ybp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Mar 2019 04:03:33 -0700
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.18) by
 MWHPR02MB2461.namprd02.prod.outlook.com (10.168.204.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 20 Mar 2019 11:03:30 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::21ac:e2b1:ea12:2266]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::21ac:e2b1:ea12:2266%10]) with mapi id 15.20.1709.015; Wed, 20 Mar
 2019 11:03:29 +0000
From:   Felipe Franciosi <felipe@nutanix.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Fam Zheng <fam@euphon.net>, Amnon Ilan <ailan@redhat.com>,
        John Ferlan <jferlan@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Harris, James R" <james.r.harris@intel.com>,
        Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: 
Thread-Index: AQHU3mHspPIyohd9Hki2twTGbOWtfqYUXFKA
Date:   Wed, 20 Mar 2019 11:03:29 +0000
Message-ID: <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e791925-da6b-4202-3852-08d6ad23af87
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2461;
x-ms-traffictypediagnostic: MWHPR02MB2461:
x-proofpoint-crosstenant: true
x-microsoft-antispam-prvs: <MWHPR02MB246160642A8456203E7FEC98D7410@MWHPR02MB2461.namprd02.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(346002)(136003)(53754006)(189003)(199004)(7416002)(54906003)(446003)(476003)(99286004)(76176011)(86362001)(2616005)(8936002)(6506007)(6512007)(26005)(11346002)(8676002)(6436002)(186003)(486006)(2906002)(4743002)(7736002)(305945005)(316002)(68736007)(7116003)(6246003)(102836004)(81156014)(81166006)(14454004)(53936002)(53546011)(478600001)(6916009)(256004)(6486002)(229853002)(106356001)(3480700005)(4326008)(82746002)(105586002)(14444005)(97736004)(71190400001)(71200400001)(3846002)(5660300002)(66066001)(25786009)(107886003)(6116002)(33656002)(221173001)(36756003)(83716004)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR02MB2461;H:MWHPR02MB2656.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6UzcL7/PcQWnmHQ0j5wWH/tmZ/aPrgQNjEYw3t4Qy/pcFxqZKAOoOO4930VdHmew4+9ctEwT7se610Cciwoyynisf3MegQBZRljTnylJTWjIOO0tpsIJ+79sd7i9bPHD0f7/mgeyAG2HThHwxQa0JB9JxHnzIS2IqDqM7AmK3dfWCbGF9NaW871QP/jgjShGrBr9fVPKDPUMlEh4HuA/sNq/ACwWa1ZdLKzBOvPE8ylaLQ5dMA6PzQ7Lo9Le41X/foJHvUxOPMxDOpgMsuYqVCXYwqlIRyzPd0kAFfLBPCmgqg2wO29HnrV6YGafvSaQf7LJS7Xy2+FFxZ7VcssIRMPlxf7lk4WKDLJkQrKVvjROV6Yvrkh1l+yECaP13RvSgt6mW3eLwpCQeMMF/TxJWkmxhuqWbnLfvR1T60BuiNc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79FF31548612E948BCD6619797E7CB30@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e791925-da6b-4202-3852-08d6ad23af87
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 11:03:29.5935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2461
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 19, 2019, at 2:41 PM, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>=20
> Date: Tue, 19 Mar 2019 14:45:45 +0200
> Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
>=20
> Hi everyone!
>=20
> In this patch series, I would like to introduce my take on the problem of=
 doing=20
> as fast as possible virtualization of storage with emphasis on low latenc=
y.
>=20
> In this patch series I implemented a kernel vfio based, mediated device t=
hat=20
> allows the user to pass through a partition and/or whole namespace to a g=
uest.

Hey Maxim!

I'm really excited to see this series, as it aligns to some extent with wha=
t we discussed in last year's KVM Forum VFIO BoF.

There's no arguing that we need a better story to efficiently virtualise NV=
Me devices. So far, for Qemu-based VMs, Changpeng's vhost-user-nvme is the =
best attempt at that. However, I seem to recall there was some pushback fro=
m qemu-devel in the sense that they would rather see investment in virtio-b=
lk. I'm not sure what's the latest on that work and what are the next steps=
.

The pushback drove the discussion towards pursuing an mdev approach, which =
is why I'm excited to see your patches.

What I'm thinking is that passing through namespaces or partitions is very =
restrictive. It leaves no room to implement more elaborate virtualisation s=
tacks like replicating data across multiple devices (local or remote), stor=
age migration, software-managed thin provisioning, encryption, deduplicatio=
n, compression, etc. In summary, anything that requires software interventi=
on in the datapath. (Worth noting: vhost-user-nvme allows all of that to be=
 easily done in SPDK's bdev layer.)

These complicated stacks should probably not be implemented in the kernel, =
though. So I'm wondering whether we could talk about mechanisms to allow ef=
ficient and performant userspace datapath intervention  in your approach or=
 pursue a mechanism to completely offload the device emulation to userspace=
 (and align with what SPDK has to offer).

Thoughts welcome!
Felipe=
