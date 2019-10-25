Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2DFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A06721929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VQ7bRN8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504097AbfJYMCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:02:39 -0400
Received: from mail-eopbgr810053.outbound.protection.outlook.com ([40.107.81.53]:19482
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfJYMCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:02:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNS91Qgiow8S2Yi5j78QWI336LtUcf7jpdjnWOZAOvzsczji2e6x+W8HdVKlvpSIu2CPxmpvjIlJDzI1m5J7BrZ1OwHheVwH4L0my2nppmiPv33JS3jVFSpYymc5OR0WfinE3J3PI/k31/+wK0prpl0L/7mhlvkS4fmJruzyv1Vv/j086LpgTZixSOgCUAKGOxfEoXojDUKiQFbTpochs39Bgz7yUQMv+fUV7oiMbGA8leJeBz3/gsJLLFFgyKwZ9u+6SNQZlXON7FrK8i5rSlyDErq8SXCdsUWnuACQx55vWejbCDtwTBDIjwpp69T2Of02JsPIgChIAZAzYE+B8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEtw73Pj30IMlGn/H9mHF0GC4ROHu6+pTJAAqtQoHlw=;
 b=aAHgRnc8DhqIEL/12VnSmsOTItFPiKjMTJnRStqRqTtYv8ydE3YZ2Zshkbsssdqbt4rCt0aHFe1sU7CBA4wGm6wOA8XgfpQFVszW1XgSKcE8tunhDW5u5703I4s9DjI3cQgId08D/EG7RXN546DLn2xHdomLv1RW4t853MIkqnHiAJ46mFdmuu7bzvj+wnbMAMXuQdiULSnwYVUYJJFY8bXdEtNY8evGZyMroMLLuoZmSuQhSl0Fz+6qSnXOi/DXLma1dDd6Gmw9/I7JkE/hn+ywNOsajkTWgUZnhFcZbcgUy805CvslTVLVSqhYLre3f/mwy1VOpRaGZNrxbfUjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEtw73Pj30IMlGn/H9mHF0GC4ROHu6+pTJAAqtQoHlw=;
 b=VQ7bRN8v/rMgsywtmyl04w+4AS76MJI/9dRSuhBf7gvhUvGIBzOr5ZPMvKCVB02S9sPQAwua2uCWmRKMs3Pmhf89xJOPX84DChtuQ7g8WupCFK3/PtbmK8/mLkeABTK6W7bye8H/AivZUZo0ChNqnMzoSGWn6IPSAIiMHhLFP2k=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.178.1.29) by
 BYAPR02MB5655.namprd02.prod.outlook.com (20.177.231.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Fri, 25 Oct 2019 12:01:51 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::f13b:8984:42b7:26ed]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::f13b:8984:42b7:26ed%5]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 12:01:50 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Jack Pham <jackp@codeaurora.org>, Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: RE: [PATCH] usb: dwc3: gadget: Correct the logic for finding last SG
 entry
Thread-Topic: [PATCH] usb: dwc3: gadget: Correct the logic for finding last SG
 entry
Thread-Index: AQHVFi8wapUkz2GgO0KPkbPlYU1PoKaMvgMAgAH+Z2CAARGqgIDZi58AgALQ1iA=
Date:   Fri, 25 Oct 2019 12:01:50 +0000
Message-ID: <BYAPR02MB5591EFB659784B6A017B446EA7650@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1559141985-17104-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <87y32gcvc1.fsf@linux.intel.com>
 <BYAPR02MB559181C009B74446A797838DA7170@BYAPR02MB5591.namprd02.prod.outlook.com>
 <87ftoldh48.fsf@linux.intel.com>
 <20191023165804.GD9754@jackp-linux.qualcomm.com>
In-Reply-To: <20191023165804.GD9754@jackp-linux.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 669c1913-0380-4293-f991-08d759431eb9
x-ms-traffictypediagnostic: BYAPR02MB5655:|BYAPR02MB5655:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5655940BA9B585E36C75935EA7650@BYAPR02MB5655.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(13464003)(51444003)(76116006)(66066001)(33656002)(64756008)(66556008)(66476007)(55016002)(446003)(66946007)(4326008)(6246003)(186003)(6436002)(26005)(25786009)(478600001)(66446008)(6116002)(11346002)(3846002)(14454004)(316002)(54906003)(229853002)(7736002)(305945005)(110136005)(9686003)(74316002)(476003)(6506007)(2906002)(256004)(486006)(7696005)(5660300002)(99286004)(71190400001)(71200400001)(76176011)(81166006)(81156014)(102836004)(52536014)(8676002)(8936002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5655;H:BYAPR02MB5591.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvtk1HmZMoj66nZJnJQv/cZFqJafMNFpWKBGcZB0RQFBED3MHfGIpD3My2Qso/mO0VRMCvnSsWwTAEVKaPqPALQPOba7NJkT1sk6vHVw9UiZLjsUbYxZHW4MKNeadJN99gg+9ex+THXcnehOK7Bc8u6JZ3kws7rIvsrh40/F1DTO0fXG0fFsK9V+CisTyejtwIWlJXwFFnBgC+rHSrk596cAMub6RqJV2PYTuGyfBaZ6gxZmbCvyBUDAp6viGgItTIQ1gG0gqzRnRfF/0rYmDTqOuH0RXHKoQU4aHFgRQVRmTg9MfuleFgTQdBAPuFFdYPLr+Bo9FBC0NDk4H0ubyYqZsfplaZNprOVMwCCk+OtXPk/CNl7VX5bT5UP43DuuAdmrtRHPk97x8TcJp6hPnR4xEJjrpnqyktGHEAm1zBLcujvaowxoKrhoFJYhUtP7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669c1913-0380-4293-f991-08d759431eb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 12:01:50.7770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5RY6QbWIPmUznlB0Mp5Y5npXu4S2eiON8uT+Wo7itvJLr8yHFZnYPXcsMAKPN1uQdhpOUOcpVIvCcX6RAZE2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5655
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jack,

>-----Original Message-----
>From: Jack Pham [mailto:jackp@codeaurora.org]
>Sent: Wednesday, October 23, 2019 10:28 PM
>To: Felipe Balbi <balbi@kernel.org>
>Cc: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; v.anuragkumar@gmail.com
>Subject: Re: [PATCH] usb: dwc3: gadget: Correct the logic for finding last=
 SG
>entry
>
>Hi Anurag,
>
>On Fri, Jun 07, 2019 at 09:49:59AM +0300, Felipe Balbi wrote:
>> Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>> >>> The dma_map_sg() merges sg1 & sg2 memory regions into sg1-
>> >>>dma_address.
>> >>> Similarly sg3 & sg4 into sg2->dma_address, sg5 & sg6 into the
>> >>> sg3->dma_address and sg6 & sg8 into sg4->dma_address. Here the
>> >>memory
>> >>> regions are merged but the page_link properties like SG_END are not
>> >>> retained into the merged sgs.
>> >>
>> >>isn't this a bug in the scatterlist mapping code? Why doesn't it keep
>> >>SG_END?
>> >>
>> >
>> > Thanks for providing your comment.
>> >
>> > I don't think it is a bug, instead I feel some enhancement needs to be=
 done
>in
>> > dma-mapping code.
>> >
>> > SG_END represents the last sg entry in the sglist and it is correctly =
getting
>> > set to the last sg entry.
>> >
>> > The issue happens only when 2 or more sg entry pages are merged into
>> > contiguous dma-able address and sg_is_last() is used to find the last =
sg
>entry
>> > with valid dma address.
>>
>> Right, and that's something that's bound to happen. I'm arguing that,
>perhaps,
>> dma API should move SG_END in case entries are merged.
>>
>> > I think that along with sg_is_last() a new flag (SG_DMA_END) and funct=
ion
>> > (something like sg_dma_is_last() ) needs to be added into dma-mapping
>code for
>> > identifying the last valid sg entry with valid dma address. So that we=
 can
>> > make use of that function instead of sg_is_last().
>>
>> Sure, propose a patch to DMA API.
>
>I'm curious if this was ever resolved. I just ran into this exact issue
>with Android ADB which uses 16KB buffers, along with f_fs supporting
>S/G since 5.0, combined with our IOMMU which performs this merging
>behavior, so it resulted in a single TRB getting queued with CHN=3D1 and
>LST=3D0 and thus the transfer never completes. Your initial patch resolves
>the issue for me, but upon revisiting this discussion I couldn't tell if
>you had attempted to patch DMA API instead as per Felipe's suggestion.
>

We were stuck with some internal priority tasks, so couldn't initiate the
discussion with IOMMU maintainers. Will work on preparing the patch
and  sending the same very soon.

Thanks,
Anurag Kumar Vulisha

>Thanks,
>Jack
>--
>The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
