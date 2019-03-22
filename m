Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DA2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EF02075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bK1iFDPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfCVIEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:04:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:34074 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbfCVIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:04:48 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Mar 2019 04:04:47 EDT
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2M7o2Da026410;
        Fri, 22 Mar 2019 00:54:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=EZ8R9BC3frBOI3ZSptX3fGBZLYT12HH3RyVo/XixI5k=;
 b=bK1iFDPNpQzGPKYe6nApHOlSZMnxg8W3of+ONZ47DdkINSMheUwhZsO1GNoPFqWncImc
 WiPbkRLPC53h1+qSdS/JkUcqsv8UJez94OZzAUYWh43GyA9U87Vmm4sfiFn8vylvMAS6
 XsGgaXoLrr86JMBjkMIkkd3v/D1/nr1czig0JI25XXorMmn5gRTaZAy0IKU37BnWvo7e
 KMoj0JU/K+NWO8rUPXYAup7HavIEREI87WOvpmw7aTTNwS5a8vDJbHs0imTKxVSenIQo
 7kSPCfemwTrJwavbjdM5Ckugd8pJcAGfKvuv3snRGh8blNKrWs7aJHSwslHK+gfzGoPD 7Q== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2rceta16t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Mar 2019 00:54:52 -0700
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.18) by
 MWHPR02MB2480.namprd02.prod.outlook.com (10.168.204.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Fri, 22 Mar 2019 07:54:50 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::21ac:e2b1:ea12:2266]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::21ac:e2b1:ea12:2266%10]) with mapi id 15.20.1730.017; Fri, 22 Mar
 2019 07:54:50 +0000
From:   Felipe Franciosi <felipe@nutanix.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
CC:     Keith Busch <kbusch@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
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
Thread-Index: AQHU4ISGDFUGO+4rpUu49Zh8vFOt4Q==
Date:   Fri, 22 Mar 2019 07:54:50 +0000
Message-ID: <0E8918CB-F679-4A5C-92AD-239E9CEC260C@nutanix.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
 <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
 <20190321161239.GH31434@stefanha-x1.localdomain>
 <20190321162140.GA29342@localhost.localdomain>
 <E217011E-C273-442D-AF99-84D3CD63FE77@nutanix.com>
 <8698ad583b1cfe86afc3d5440be630fc3e8e0680.camel@redhat.com>
In-Reply-To: <8698ad583b1cfe86afc3d5440be630fc3e8e0680.camel@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c6106c6-8b74-44ee-205c-08d6ae9ba94c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2480;
x-ms-traffictypediagnostic: MWHPR02MB2480:
x-proofpoint-crosstenant: true
x-microsoft-antispam-prvs: <MWHPR02MB2480285E86E1B4C6E7BDA384D7430@MWHPR02MB2480.namprd02.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(6916009)(229853002)(99286004)(6116002)(3846002)(76176011)(7736002)(305945005)(7116003)(7416002)(106356001)(105586002)(3480700005)(33656002)(2906002)(14454004)(5660300002)(478600001)(446003)(81166006)(86362001)(8676002)(6436002)(81156014)(6486002)(4326008)(486006)(2616005)(476003)(11346002)(25786009)(66066001)(221173001)(6512007)(6246003)(53936002)(8936002)(97736004)(102836004)(316002)(68736007)(82746002)(93886005)(256004)(14444005)(186003)(36756003)(26005)(54906003)(83716004)(71190400001)(71200400001)(53546011)(6506007)(4743002)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR02MB2480;H:MWHPR02MB2656.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gxi3CCu2iEHt7ELJfJmKevLBj7N325WqhQ0o1Giwzbkv7GstO6WxgdN685mL9B9YzlRqwE4S1xz3KsbfkhwrBsxgXYYyOMav2J8Tl8ycmNpdu5k/oFSar4Vihkkok+2Z/GSaSWw3S8yZ/cZOXEJFfKtqa5Aq0+6ET9RL4rLCEysHRUEfa2AzCO2UQ6ivwivqGFcqSaoVAUMDW6sr2wR+yFqAchkYSzJBhZ6RGd4tO7PDuSwWMXCUmhcG91BeHt4zGtbZkn9wyxRKcC/liubN/MyKxZdTpTfaAu4Yj4rj/qflFka0AAjlsuNAIfxgK7NgifYZPPL+jBi0x5x9m5Z+0fqKSJm9kxaXwx/LPDNTrl9GPlFDxl4HpGsZB4lId9Y2uNzz9JSJ4ObpeQiCikCHSL+4WrMGEZAPrAwf/n2D86M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06727B797CBF14419894608A12BEBB3F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6106c6-8b74-44ee-205c-08d6ae9ba94c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 07:54:50.1424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2480
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 21, 2019, at 5:04 PM, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>=20
> On Thu, 2019-03-21 at 16:41 +0000, Felipe Franciosi wrote:
>>> On Mar 21, 2019, at 4:21 PM, Keith Busch <kbusch@kernel.org> wrote:
>>>=20
>>> On Thu, Mar 21, 2019 at 04:12:39PM +0000, Stefan Hajnoczi wrote:
>>>> mdev-nvme seems like a duplication of SPDK.  The performance is not
>>>> better and the features are more limited, so why focus on this approac=
h?
>>>>=20
>>>> One argument might be that the kernel NVMe subsystem wants to offer th=
is
>>>> functionality and loading the kernel module is more convenient than
>>>> managing SPDK to some users.
>>>>=20
>>>> Thoughts?
>>>=20
>>> Doesn't SPDK bind a controller to a single process? mdev binds to
>>> namespaces (or their partitions), so you could have many mdev's assigne=
d
>>> to many VMs accessing a single controller.
>>=20
>> Yes, it binds to a single process which can drive the datapath of multip=
le
>> virtual controllers for multiple VMs (similar to what you described for =
mdev).
>> You can therefore efficiently poll multiple VM submission queues (and mu=
ltiple
>> device completion queues) from a single physical CPU.
>>=20
>> The same could be done in the kernel, but the code gets complicated as y=
ou add
>> more functionality to it. As this is a direct interface with an untruste=
d
>> front-end (the guest), it's also arguably safer to do in userspace.
>>=20
>> Worth noting: you can eventually have a single physical core polling all=
 sorts
>> of virtual devices (eg. virtual storage or network controllers) very
>> efficiently. And this is quite configurable, too. In the interest of fai=
rness,
>> performance or efficiency, you can choose to dynamically add or remove q=
ueues
>> to the poll thread or spawn more threads and redistribute the work.
>>=20
>> F.
>=20
> Note though that SPDK doesn't support sharing the device between host and=
 the
> guests, it takes over the nvme device, thus it makes the kernel nvme driv=
er
> unbind from it.

That is absolutely true. However, I find it not to be a problem in practice=
.

Hypervisor products, specially those caring about performance, efficiency a=
nd fairness, will dedicate NVMe devices for a particular purpose (eg. vDisk=
 storage, cache, metadata) and will not share these devices for other use c=
ases. That's because these products want to deterministically control the p=
erformance aspects of the device, which you just cannot do if you are shari=
ng the device with a subsystem you do not control.

For scenarios where the device must be shared and such fine grained control=
 is not required, it looks like using the kernel driver with io_uring offer=
s very good performance with flexibility.

Cheers,
Felipe=
