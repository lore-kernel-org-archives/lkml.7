Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81442C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A57520896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="xsPr91Hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfCYPpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:45:50 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:40964 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfCYPpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:45:49 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PFeIQH009617;
        Mon, 25 Mar 2019 08:45:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=dlxo+YcKiRqA3+aVsJu27ZzrlbiDLV0K5ZzhgW4PSfw=;
 b=xsPr91HsPl+d/9fgu5dFwwvZ061bAfKzhbeH2zMfJ3+O18AMGrDhOqhnSB7Od9PS1xqv
 35owAA67a6xZ/SD3/3UIXcOnH2rqD0wZNN60bTSV9WHm782OZMgCUQJAb6sTCoXfUvLx
 d2ZTnCSq7Efikd+aCiS46ElHKqv/v9/9+hZNvj4m3qUiRsVpswGbrr1VRTCaE31pEcGR
 uO2/XdsyiHGXgKzqLZyD4F9RKmBNKdSub2bApntnyLFU+FlNDlbFS7bTzhbOsHmXEdOM
 rojOSafo65ULLoNJaivqA6CduHF9oR5rSFh2fRiqdCypSvqa8pC1jk1FW8XAA2xxysr1 /g== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2056.outbound.protection.outlook.com [104.47.34.56])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2rdm4dtvrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Mar 2019 08:45:05 -0700
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.18) by
 MWHPR02MB2352.namprd02.prod.outlook.com (10.168.244.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 15:44:56 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::21ac:e2b1:ea12:2266]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::21ac:e2b1:ea12:2266%10]) with mapi id 15.20.1730.019; Mon, 25 Mar
 2019 15:44:56 +0000
From:   Felipe Franciosi <felipe@nutanix.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Maxim Levitsky <mlevitsk@redhat.com>,
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
Thread-Index: AQHU4ISH1RctgniOY0qVd01TvSu+tqYXx06AgAS7C4A=
Date:   Mon, 25 Mar 2019 15:44:56 +0000
Message-ID: <0C3E7CCF-DD56-4129-A6F6-4A181AA2D102@nutanix.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
 <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
 <20190321161239.GH31434@stefanha-x1.localdomain>
 <20190321162140.GA29342@localhost.localdomain>
 <E217011E-C273-442D-AF99-84D3CD63FE77@nutanix.com>
 <8698ad583b1cfe86afc3d5440be630fc3e8e0680.camel@redhat.com>
 <0E8918CB-F679-4A5C-92AD-239E9CEC260C@nutanix.com>
 <20190322153025.GA31194@localhost.localdomain>
In-Reply-To: <20190322153025.GA31194@localhost.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c21e09ee-a518-47b5-bab8-08d6b138d4fd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2352;
x-ms-traffictypediagnostic: MWHPR02MB2352:
x-proofpoint-crosstenant: true
x-microsoft-antispam-prvs: <MWHPR02MB23521AE0F101152033947439D75E0@MWHPR02MB2352.namprd02.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(66066001)(81156014)(478600001)(8676002)(7736002)(221173001)(71200400001)(71190400001)(81166006)(486006)(2616005)(86362001)(476003)(106356001)(14444005)(186003)(446003)(11346002)(256004)(14454004)(3480700005)(6116002)(6246003)(25786009)(3846002)(2906002)(4743002)(6436002)(53936002)(6506007)(33656002)(102836004)(53546011)(36756003)(26005)(82746002)(105586002)(5660300002)(76176011)(93886005)(99286004)(8936002)(7416002)(316002)(4326008)(83716004)(68736007)(305945005)(7116003)(54906003)(6486002)(6512007)(6916009)(229853002)(97736004)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR02MB2352;H:MWHPR02MB2656.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xnmmCuUJCbiS4h3ds1Oc4OFLQquQfJVTP7iKYFM98d0DFf+lqF0MjPMERJ4uSyRD5halPpZqVujrmLA5lyjSIZaC5ebjqaNb871kxQkeoKDSE9cOdvN/wrtst7oP0Gk2tg2KYACR+PZH9947gnUZrDSvCTL7ntwdiH6X2bDOAe58yTSNAhoj7w8W1te6gVO40+PJCjCfD4rqzQOj1mlCoHmr+zpZmsV4lQLO0+A2EeWwQ3pmzuu8VhM+g1H8WAGDR+QACo13iHJSParQrNbs5P8PLOj2HDPnQ1BYlhscEtPMZGAjpfka/Z5lfCstHQNmpBuHWq1jp5SeKW2J4Cd/HaXiuP7I85TGeG2FwqKedFo7IvS5Lk6uCYflfdeij40d14/+w1PmP8nbHdhZr+v6Hwh7CMh8115wo5MYJQw2VFg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C029EFDA5CC8DA4BB5BD01D3E2BA1ED9@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21e09ee-a518-47b5-bab8-08d6b138d4fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 15:44:56.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2352
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

> On Mar 22, 2019, at 3:30 PM, Keith Busch <kbusch@kernel.org> wrote:
>=20
> On Fri, Mar 22, 2019 at 07:54:50AM +0000, Felipe Franciosi wrote:
>>>=20
>>> Note though that SPDK doesn't support sharing the device between host a=
nd the
>>> guests, it takes over the nvme device, thus it makes the kernel nvme dr=
iver
>>> unbind from it.
>>=20
>> That is absolutely true. However, I find it not to be a problem in pract=
ice.
>>=20
>> Hypervisor products, specially those caring about performance, efficienc=
y and fairness, will dedicate NVMe devices for a particular purpose (eg. vD=
isk storage, cache, metadata) and will not share these devices for other us=
e cases. That's because these products want to deterministically control th=
e performance aspects of the device, which you just cannot do if you are sh=
aring the device with a subsystem you do not control.
>=20
> I don't know, it sounds like you've traded kernel syscalls for IPC,
> and I don't think one performs better than the other.

Sorry, I'm not sure I understand. My point is that if you are packaging a d=
istro to be a hypervisor and you want to use a storage device for VM data, =
you _most likely_ won't be using that device for anything else. To that end=
, driving the device directly from your application definitely gives you mo=
re deterministic control.

>=20
>> For scenarios where the device must be shared and such fine grained cont=
rol is not required, it looks like using the kernel driver with io_uring of=
fers very good performance with flexibility.
>=20
> NVMe's IO Determinism features provide fine grained control for shared
> devices. It's still uncommon to find hardware supporting that, though.

Sure, but then your hypervisor needs to certify devices that support that. =
This will limit your HCL. Moreover, unless the feature is solid, well-estab=
lished and works reliably on all devices you support, it's arguably prefera=
ble to have an architecture which gives you that control in software.

Cheers,
Felipe=
