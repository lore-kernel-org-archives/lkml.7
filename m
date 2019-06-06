Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694E7C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F1C20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sclCZ8jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfFFPce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:32:34 -0400
Received: from mail-eopbgr760057.outbound.protection.outlook.com ([40.107.76.57]:6083
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729300AbfFFPcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYl/CbMfK8hFh2jQmGfgzfeKvhGxljMbptGVZV3ik2w=;
 b=sclCZ8jwVcY49ijr1dUKcf5aefdK55Vd5icOsMYZRXSQlFJTRUULilFhsBPFIjJuHnHTcDoVWPN18BcHP6foZoSv4LUbbPGbOhZF053l2O4Y3tyCgmFV9vxYF/ZYmKgXnWC/CcRn7sPPSjNBM2/CKAd6+NL2eeTg163mZDTQsU0=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.177.230.89) by
 BYAPR02MB4582.namprd02.prod.outlook.com (52.135.239.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 6 Jun 2019 15:32:27 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::2c0d:4fbd:2c4:31b6]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::2c0d:4fbd:2c4:31b6%5]) with mapi id 15.20.1943.023; Thu, 6 Jun 2019
 15:32:27 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: RE: [PATCH] usb: dwc3: gadget: Correct the logic for finding last SG
 entry
Thread-Topic: [PATCH] usb: dwc3: gadget: Correct the logic for finding last SG
 entry
Thread-Index: AQHVFi8wapUkz2GgO0KPkbPlYU1PoKaMvgMAgAH+Z2A=
Date:   Thu, 6 Jun 2019 15:32:26 +0000
Message-ID: <BYAPR02MB559181C009B74446A797838DA7170@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1559141985-17104-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <87y32gcvc1.fsf@linux.intel.com>
In-Reply-To: <87y32gcvc1.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1100a4a-327e-474c-00c8-08d6ea942e4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB4582;
x-ms-traffictypediagnostic: BYAPR02MB4582:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB458274ABE81F848F7539B6F4A7170@BYAPR02MB4582.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(366004)(51444003)(189003)(199004)(13464003)(5660300002)(52536014)(14454004)(478600001)(54906003)(81166006)(81156014)(86362001)(8676002)(110136005)(316002)(476003)(6246003)(66946007)(99286004)(256004)(33656002)(305945005)(14444005)(76176011)(7696005)(446003)(11346002)(73956011)(76116006)(25786009)(486006)(68736007)(7736002)(6506007)(186003)(6436002)(71190400001)(71200400001)(74316002)(26005)(9686003)(53936002)(4326008)(6116002)(3846002)(8936002)(55016002)(2906002)(229853002)(102836004)(66066001)(66446008)(66556008)(66476007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4582;H:BYAPR02MB5591.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rFS78Zut16j9aMJlFtq3KtBNGF+c5mu0+z5VdJiLunH2nY95UvrQW+OQ4aE94j7sNIcGPww2wYFcRO6z3mCqwHakZBkWrOelLQGqrDYWWGOGxD8OKkDlwmp+LNFr7JBLWnw8MoIWTzG76aqic/+vc6uBB8z4fcGDOu3unW980Sj4XosS1w9pZawWdfNkKYS57WFi16sfoDSo4uzDEWZ696Eve4Wnp0iMUMv3+emJD3qgEjEbXPB6nEFIWbKUowKcw8MKhgoOvu/hmLFF9Cf7XtBsihadUBOwcGDnS/I6wJFtM5uc1LxfnGoMiRzYF5CFWYZIdx/lUCgkIRDDv3QIwmYoAo7l28Yt+hjDmYTXhYYfaabCPxmP6zliTFOJAPdXTn1dsl4hE7wIQqE2V34peaEAi1ih5Pynqch9egBvUwc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1100a4a-327e-474c-00c8-08d6ea942e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 15:32:27.0406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anuragku@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Wednesday, June 5, 2019 1:34 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>
>Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
>v.anuragkumar@gmail.com; Anurag Kumar Vulisha <anuragku@xilinx.com>
>Subject: Re: [PATCH] usb: dwc3: gadget: Correct the logic for finding last=
 SG
>entry
>
>
>Hi,
>
>Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
>> As a process of preparing TRBs usb_gadget_map_request_by_dev() is
>> called from dwc3_prepare_trbs() for mapping the request. This will
>> call dma_map_sg() if req->num_sgs are greater than 0. dma_map_sg()
>> will map the sg entries in sglist and return the number of mapped SGs.
>> As a part of mapping, some sg entries having contigous memory may be
>> merged together into a single sg (when IOMMU used). So, the number of
>> mapped sg entries may not be equal to the number of orginal sg entries
>> in the request (req->num_sgs).
>>
>> As a part of preparing the TRBs, dwc3_prepare_one_trb_sg() iterates
>> over the sg entries present in the sglist and calls sg_is_last() to
>> identify whether the sg entry is last and set IOC bit for the last sg
>> entry. The
>> sg_is_last() determines last sg if SG_END is set in sg->page_link.
>> When IOMMU used, dma_map_sg() merges 2 or more sgs into a single sg
>> and it doesn't retain the page_link properties. Because of this reason
>> the
>> sg_is_last() may not find SG_END and thus resulting in IOC bit never
>> getting set.
>>
>> For example:
>>
>> Consider a request having 8 sg entries with each entry having a length
>> of
>> 4096 bytes. Assume that sg1 & sg2, sg3 & sg4, sg5 & sg6, sg7 & sg8 are
>> having contigous memory regions.
>>
>> Before calling dma_map_sg():
>>             sg1-->sg2-->sg3-->sg4-->sg6-->sg7-->sg8
>> dma_length: 4K    4K    4K    4K    4K    4K    4K
>> SG_END:     False False False False False False True
>> num_sgs =3D 8
>> num_mapped_sgs =3D 0
>>
>> The dma_map_sg() merges sg1 & sg2 memory regions into sg1-
>>dma_address.
>> Similarly sg3 & sg4 into sg2->dma_address, sg5 & sg6 into the
>> sg3->dma_address and sg6 & sg8 into sg4->dma_address. Here the
>memory
>> regions are merged but the page_link properties like SG_END are not
>> retained into the merged sgs.
>
>isn't this a bug in the scatterlist mapping code? Why doesn't it keep
>SG_END?
>

Thanks for providing your comment.
I don't think it is a bug, instead I feel some enhancement needs to be done=
 in
dma-mapping code. SG_END represents the last sg entry in the sglist and it =
is
correctly getting set to the last sg entry. The issue happens only when 2 o=
r more
sg entry pages are merged into contiguous dma-able address and sg_is_last()
is used to find the last sg entry with valid dma address. I think that alon=
g with
sg_is_last() a new flag (SG_DMA_END) and function (something like sg_dma_is=
_last() )
needs to be added into dma-mapping code for identifying the last valid sg e=
ntry
with valid dma address. So that we can make use of that function instead of=
 sg_is_last().

Thanks,
Anurag Kumar Vulisha
