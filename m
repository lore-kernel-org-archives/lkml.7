Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B9AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C89A20818
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QL/DqE5C";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Pe9G4XEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfEMPXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:23:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23602 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfEMPXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557761016; x=1589297016;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qOMlTtORDfEtXowtpsmMV4k9pulCLZtn0Ih/k7hdTaE=;
  b=QL/DqE5C3tC+tDGp5rQhvPA7vHZ91LwtD0BlYHnoRdw6nJz6n69YGnbx
   pGVm9L2F3N6AfZbr9dV1bXYIC4H2uBxrb0Sdxw19X3ejfPDgCoxK6lvL5
   8cpaUoRSfeLK9/rNN/NXDapzJErefrBj42D7XKC53d4VQD2ZQSv/hAYpl
   gQjbaTiFYx8KSGQ93u7eQ7jLJv6Wcp4kd6kHRLuhWuQ4G/F1Jv3pB1gee
   iCet9fk37SSUx/WAdhsf2SsYuFVxca9n8YKJelK/zpdm1Ovg0PfTLpSgu
   0LFepuwUual4eSL2Pa3r0hkle0QBZRcTEHCCiVDBy/y9INUvOTLl0K6sR
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,465,1549900800"; 
   d="scan'208";a="214222742"
Received: from mail-co1nam03lp2058.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.58])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2019 23:23:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaPm5V1BnOM41I7mPlHmTbZTWTom/NXNGwav3sHgddI=;
 b=Pe9G4XEE655HylhpyIHdI5gHGY2RCjNDYve0sfPAnJGE+78pCUc9UnZuLae7lYAWnFXyFQl8RCve9ZZE3D5eI0fY/4lRbAz8v0tmNZYActxdftzgF9KbOcZAP9gU4ZmtA0WkISnLZHe4DkoDL/5VhtrIbK28bd0/a3H/texnFMk=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4944.namprd04.prod.outlook.com (52.135.114.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 15:23:32 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 15:23:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jens Axboe <axboe@fb.com>, Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
Thread-Topic: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
Thread-Index: AQHVCNsnTq1EcjR34keOomYpqyVeRw==
Date:   Mon, 13 May 2019 15:23:32 +0000
Message-ID: <SN6PR04MB4527DFC75838C3236F5D05B2860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <CGME20190512155540epcas4p14c15eb86b08dcd281e9a93a4fc190800@epcms2p1>
 <20190513074601epcms2p12c0a32730a16be3b69b68e3c9d4d0b92@epcms2p1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c22052b7-3352-4936-2d36-08d6d7b6f5c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4944;
x-ms-traffictypediagnostic: SN6PR04MB4944:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB49443CE1CE7BE3B6A7A0DEED860F0@SN6PR04MB4944.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(486006)(186003)(54906003)(110136005)(66066001)(476003)(446003)(6436002)(26005)(305945005)(7736002)(33656002)(9686003)(99286004)(55016002)(6306002)(2906002)(316002)(68736007)(7416002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(53936002)(91956017)(76116006)(2501003)(229853002)(71200400001)(6246003)(81156014)(14454004)(5660300002)(72206003)(966005)(71190400001)(52536014)(81166006)(8676002)(76176011)(86362001)(4326008)(8936002)(25786009)(74316002)(7696005)(3846002)(6116002)(6506007)(256004)(53546011)(478600001)(102836004)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4944;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lYaBlD+EQT1U6gK8Ey8NrcPX1dG0nHy0HQNIXzOwilYf6+fzohnAE0ViIAJOeas6lKmBWXg6zGvAb3BtiUwigvTpjh1MmpBNolLmGArCAXGBjTt6DxRzQfbekMpBcfkMkl9+uxYP4C9n/ow/JQXhZy34ZV3LKkfJ70P+uVuw0MtKIzVKtwNPj0cR71xtBKwV+Dk73rAMQYTWm8UW5gMYWMgj4SO6xKfDU6dSm9eab3fBK+IRLrMHPNvU3bOFxt9j97Rena6bPAa2/cbtgFJd4GWKSAlizpQb9rmZ1WCaR8/aGNlxr9dugpqOK7czCXL9yrg9IMdQxHkV2B/cAFSut38AtpgHoxm/YWUETyo/UadLgF7rqEndeoiInMDMpJN138hyTJcrWeUDjmgvTYPdwq5QFxwv8p4pVfSx+Mu3vaI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22052b7-3352-4936-2d36-08d6d7b6f5c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 15:23:32.5348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/2019 12:46 AM, Minwoo Im wrote:=0A=
>> +static int nvme_get_telemetry_log_blocks(struct nvme_ctrl *ctrl, void *=
buf,=0A=
>> +					 size_t bytes, loff_t offset)=0A=
>> +{=0A=
>> +	loff_t pos =3D 0;=0A=
>> +	u32 chunk_size;=0A=
>> +=0A=
>> +	if (check_mul_overflow(ctrl->max_hw_sectors, 512u, &chunk_size))=0A=
>> +		chunk_size =3D UINT_MAX;=0A=
>> +=0A=
>> +	while (pos < bytes) {=0A=
>> +		size_t size =3D min_t(size_t, bytes - pos, chunk_size);=0A=
>> +		int ret;=0A=
>> +=0A=
>> +		ret =3D nvme_get_log(ctrl, NVME_NSID_ALL,=0A=
>> NVME_LOG_TELEMETRY_CTRL,=0A=
>> +				   0, buf + pos, size, offset + pos);=0A=
>> +		if (ret)=0A=
>> +			return ret;=0A=
>> +=0A=
>> +		pos +=3D size;=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static int nvme_get_telemetry_log(struct nvme_ctrl *ctrl,=0A=
>> +				  struct sg_table *table, size_t bytes)=0A=
>> +{=0A=
>> +	int n =3D sg_nents(table->sgl);=0A=
>> +	struct scatterlist *sg;=0A=
>> +	size_t offset =3D 0;=0A=
>> +	int i;=0A=
>> +=0A=
A little comment would be nice if you are using sg operations.=0A=
>> +	for_each_sg(table->sgl, sg, n, i) {=0A=
>> +		struct page *page =3D sg_page(sg);=0A=
>> +		size_t size =3D min_t(int, bytes - offset, sg->length);=0A=
>> +		int ret;=0A=
>> +=0A=
>> +		ret =3D nvme_get_telemetry_log_blocks(ctrl,=0A=
>> page_address(page),=0A=
>> +						    size, offset);=0A=
>> +		if (ret)=0A=
>> +			return ret;=0A=
>> +=0A=
>> +		offset +=3D size;=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>=0A=
> Can we have those two in nvme-core module instead of being in pci module?=
=0A=
=0A=
Since they are based on the controller they should be moved next to =0A=
nvme_get_log() in the ${KERN_DIR}/drivers/nvme/host/core.c.=0A=
=0A=
>=0A=
> _______________________________________________=0A=
> Linux-nvme mailing list=0A=
> Linux-nvme@lists.infradead.org=0A=
> http://lists.infradead.org/mailman/listinfo/linux-nvme=0A=
>=0A=
=0A=
