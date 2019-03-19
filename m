Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5967C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9685620854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UubPae+1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nUjRuYVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCSXtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:49:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51526 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfCSXtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553039362; x=1584575362;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aSIfXEjGr+H+yJEQhoeWLmWUOlmMPv13fo9lQzK/6W0=;
  b=UubPae+1wnjza5vCOQf4aD7vSN3fu0HQ+YiDU/GWbFoyZFfvYM1XF5DL
   1N5GYzxOIU2rGGQUKWbdWGltgqwDxzlwr4IQhJ46a9f8+eNZFHLr7OsNH
   Yc0XHEiuY6SpkkyUWhlHGh1ymeIt9L+Mfk15ol9jvxQcVza2sBWSilmVi
   4VEUYl8x6J05pjtzl1DJXcloB5d72ia3i53NCDMyl+iq5/gzE0EnIAndZ
   GDoU2kEHz8dbM4PLhfHP8ldl8CyvLI7QWWm5ZNP4H6QQP42V6xslG5i7d
   JEqYVHOsQGAgqKLIFfdEMiN5tahkd8y6Avsamz6Rb7g6XgQSAHN67VhpD
   w==;
X-IronPort-AV: E=Sophos;i="5.60,246,1549900800"; 
   d="scan'208";a="103783037"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2019 07:49:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb0oJ4+6O+X4GKuk2gVDGAqBmr+WPM1aLBad9M7raF8=;
 b=nUjRuYVIcO0gDmXcTFwsSfjRTDBznatFZyg9HGccBEEdkBckv0C+Qkat9XtjTNrfkhch+1JkILTIa3SpnGCnsKOVlgt6sGbYtASPpc7L06ZPrTWHWdUKxEgxOuMd2pqxmDZzPU9qU2uTNYfIqVQzDW5QHgTjxcnuiYN60sI4MtU=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3949.namprd04.prod.outlook.com (52.135.82.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 23:49:16 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::7db4:149f:d1a5:e3fd]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::7db4:149f:d1a5:e3fd%4]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 23:49:16 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
CC:     Fam Zheng <fam@euphon.net>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney " <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>, Christoph Hellwig <hch@lst.de>,
        John Ferlan <jferlan@redhat.com>
Subject: Re: your mail
Thread-Topic: your mail
Thread-Index: AQHU3mHuoIn8Kh/6t06bcOG9+hP0nA==
Date:   Tue, 19 Mar 2019 23:49:16 +0000
Message-ID: <SN6PR04MB4527810F605C8ADE388E958286400@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319152212.GC24176@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 426e0a2f-4b6b-4692-e544-08d6acc57f7d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB3949;
x-ms-traffictypediagnostic: SN6PR04MB3949:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3949C300B686B892F1F0E9EA86400@SN6PR04MB3949.namprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(8936002)(186003)(71190400001)(71200400001)(9686003)(81166006)(81156014)(2906002)(102836004)(5660300002)(66066001)(221733001)(305945005)(53936002)(6246003)(110136005)(7116003)(26005)(86362001)(97736004)(105586002)(8676002)(76176011)(74316002)(52536014)(6306002)(7736002)(53546011)(99286004)(7696005)(106356001)(3480700005)(54906003)(7416002)(478600001)(4326008)(68736007)(25786009)(229853002)(55016002)(72206003)(316002)(6506007)(446003)(6116002)(3846002)(6436002)(966005)(33656002)(476003)(256004)(14444005)(486006)(14454004)(111123002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3949;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RgqfyMTT7d8URDCbLGFQ6e/huMCd9ofHDOTq7SQ2fc8iWmHBWfHoE7ZgScVEmbfdwkDz0wh8Q5vrRTXG8dInZFUlKStGq2JEg7v6Bzai2fuPRhe0YxIj1iLup6+hUmt5XY3MPyPAESLSPr3gTT9I2i6f9RzpzHVL0fQuFy0wOyTu1zPrYr7DZNA/vqiOut2amwj2b24tz4WXlA2dOBM1xPV0AtWP7O0eeZCwKKpHT+Vvxq3sxUyeQ1skIjxjcQKWJNqQGeJXKtscasskfFywkl82f5P7RarT768T2hUp/0338ORcSsor3E70Biv8hGkRt4yaxfHUpaFthmjofZFTqVkmtuwjRxcVcXtMjgsayo/lXQmq9QM2+G4yv5JzpjjVrH6ieT+MTuiGV+m4LS0aqUaaYuYt4Sxd+BdpIeaVYHs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426e0a2f-4b6b-4692-e544-08d6acc57f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 23:49:16.4754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,=0A=
On 03/19/2019 08:21 AM, Keith Busch wrote:=0A=
> On Tue, Mar 19, 2019 at 04:41:07PM +0200, Maxim Levitsky wrote:=0A=
>>    -> Share the NVMe device between host and guest.=0A=
>>       Even in fully virtualized configurations,=0A=
>>       some partitions of nvme device could be used by guests as block de=
vices=0A=
>>       while others passed through with nvme-mdev to achieve balance betw=
een=0A=
>>       all features of full IO stack emulation and performance.=0A=
>>=0A=
>>    -> NVME-MDEV is a bit faster due to the fact that in-kernel driver=0A=
>>       can send interrupts to the guest directly without a context=0A=
>>       switch that can be expensive due to meltdown mitigation.=0A=
>>=0A=
>>    -> Is able to utilize interrupts to get reasonable performance.=0A=
>>       This is only implemented=0A=
>>       as a proof of concept and not included in the patches,=0A=
>>       but interrupt driven mode shows reasonable performance=0A=
>>=0A=
>>    -> This is a framework that later can be used to support NVMe devices=
=0A=
>>       with more of the IO virtualization built-in=0A=
>>       (IOMMU with PASID support coupled with device that supports it)=0A=
>=0A=
> Would be very interested to see the PASID support. You wouldn't even=0A=
> need to mediate the IO doorbells or translations if assigning entire=0A=
> namespaces, and should be much faster than the shadow doorbells.=0A=
>=0A=
> I think you should send 6/9 "nvme/pci: init shadow doorbell after each=0A=
> reset" separately for immediate inclusion.=0A=
>=0A=
> I like the idea in principle, but it will take me a little time to get=0A=
> through reviewing your implementation. I would have guessed we could=0A=
> have leveraged something from the existing nvme/target for the mediating=
=0A=
> controller register access and admin commands. Maybe even start with=0A=
> implementing an nvme passthrough namespace target type (we currently=0A=
> have block and file).=0A=
=0A=
I have the code for the NVMeOf target passthru-ctrl, I think we can use =0A=
that as it is if you are looking for the passthru for NVMeOF.=0A=
=0A=
I'll post patch-series based on the latest code base soon.=0A=
>=0A=
> _______________________________________________=0A=
> Linux-nvme mailing list=0A=
> Linux-nvme@lists.infradead.org=0A=
> http://lists.infradead.org/mailman/listinfo/linux-nvme=0A=
>=0A=
=0A=
