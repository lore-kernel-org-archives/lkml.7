Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4222EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0823420692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fAoa6MSv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DFzj/EzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfIIKLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:11:07 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:30434
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbfIIKLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84PA4Bt4ArcrM7FjZ3jHI2t99k2VS+7YLStwDVRuhxY=;
 b=fAoa6MSv6RbrKsWL9ldRYCkVErclTIZkGqQgqEhWKXKUUTEhY35+8j4jvPuv1EMf+W9DhoR5U6qhbm7F/EFAM1dPl2IAMH1DduRPEK+KwMDlmtUw+jgjshuf1cxKdFccPgYJKOkDOzasS7AOaDcb3XMW1h0xwjR3asXD2lFbmcw=
Received: from VI1PR0802CA0041.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::27) by VE1PR08MB5246.eurprd08.prod.outlook.com
 (2603:10a6:803:10b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15; Mon, 9 Sep
 2019 10:10:58 +0000
Received: from DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR0802CA0041.outlook.office365.com
 (2603:10a6:800:a9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18 via Frontend
 Transport; Mon, 9 Sep 2019 10:10:58 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT041.mail.protection.outlook.com (10.152.21.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14 via Frontend Transport; Mon, 9 Sep 2019 10:10:57 +0000
Received: ("Tessian outbound 24b6d28e5e38:v28"); Mon, 09 Sep 2019 10:10:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 28c7622b2606119e
X-CR-MTA-TID: 64aa7808
Received: from 3158179f340e.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0AB599FD-87ED-4D74-9129-B956DF9E1876.1;
        Mon, 09 Sep 2019 10:10:51 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2052.outbound.protection.outlook.com [104.47.8.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3158179f340e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 09 Sep 2019 10:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8i3udBqHSiGabLbyYFMgigY74+3nNrsf5urpNja8zjVHdMqQCGRjP2lxAa9AjoXePc+6solNN9E7HRcqX2QxKt/+dma2dc3R5qJKu73NQ+1W9dC70oPPipbrs+j+ph5FEgR5UQc5c2TtJfz8FLhi/zUpQgNyrNUMcsG1eQo0gwG5/RZhi1t/3JZgqG+IW+mrKXGdLLbntZ5y+bpy/mn/oyZtHz+EPTmJlhUORLgmkRRmou2ARyIVLFtiZ14uYPSABPeg6LjE4ynikizFrJga9mBgNDSL5jfPjbmttyX1I9HMKNUDYynn37ScvvK5yq5UuRiEEmi/nWFyqO+xmn3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awk3C/nj1nEtBZ+oiyDQiHMUmkGn++l+3JEK1SEVvJY=;
 b=OecTgMRYsnfR/hn5odQnJZDmBo2ZFvMgOew2IF9GXx4PrQZ7SXK4s2QeJ07t3hM45ot9s8Z2nyO2F8Vr/ON4TFVr5M1tSSu2OMvjulNOhldPj87TQw/tNXT92pwS3xbV7cyLWgJhjpdhQE93kL3qktibNHLLd/WY7mzIoS7eAbVy7xmOI9s8LW4ELp+Umaq3cKoQl/U9M+bgbXnQ0YgQspGGWV9ZmItd66oVQPyi8r3C9Nfs/N524DRlLfs+2KePho+THNMY2m0MhJk2Pn/47Ml3s4W8Rx1dPLM6K6NrZYTeNjbxJzmibuCr6d6THQ/fNM/9Ls+nBI2EllswiKD52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awk3C/nj1nEtBZ+oiyDQiHMUmkGn++l+3JEK1SEVvJY=;
 b=DFzj/EzFVOtm2STlQeMQluo0V+PEUBd1o8MqO68WlRULAQKxF7/cCOFCNn2rZ0ODI4EIuVgKRRYG6q2bOmxx3KhDwa0k3m8WYFqeX/kdi2qZ+IvwO3GffIqnWZc0MuY2P0XHaqTpG91aJbqa8VgsPyqjYgIzERP1l6yr7v9TiOc=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.172.255.7) by
 VI1PR0802MB2463.eurprd08.prod.outlook.com (10.175.26.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 10:10:50 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::c111:a196:e33b:a90f]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::c111:a196:e33b:a90f%7]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 10:10:50 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     Anatoly Pugachev <matorola@gmail.com>,
        Sparc kernel list <sparclinux@vger.kernel.org>
CC:     Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [sparc64] Kernel unaligned access at TPC lzo1x_1_do_compress
Thread-Topic: [sparc64] Kernel unaligned access at TPC lzo1x_1_do_compress
Thread-Index: AQHVZjRVATYRQqakFUO5bQSp6NYr4acjIRGv
Date:   Mon, 9 Sep 2019 10:10:50 +0000
Message-ID: <VI1PR0802MB252826995ECEA2578C1B5C878FB70@VI1PR0802MB2528.eurprd08.prod.outlook.com>
References: <CADxRZqxmvfE9gYoT+1oLV6-o_BbUsay_U45qmMEYL3vErTCCLA@mail.gmail.com>
In-Reply-To: <CADxRZqxmvfE9gYoT+1oLV6-o_BbUsay_U45qmMEYL3vErTCCLA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c36d672b-a2cc-484a-50e8-08d7350e01d8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0802MB2463;
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2463:|VE1PR08MB5246:
X-Microsoft-Antispam-PRVS: <VE1PR08MB5246C2E53B99C58F9A4CA8598FB70@VE1PR08MB5246.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 01559F388D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(199004)(189003)(5660300002)(33656002)(6506007)(6116002)(66066001)(478600001)(486006)(71190400001)(71200400001)(229853002)(44832011)(26005)(186003)(476003)(11346002)(446003)(256004)(52536014)(102836004)(86362001)(99286004)(2906002)(25786009)(14454004)(316002)(53546011)(76176011)(110136005)(7696005)(305945005)(14444005)(6246003)(55016002)(7736002)(9686003)(53936002)(76116006)(3846002)(66446008)(64756008)(66556008)(66476007)(74316002)(66946007)(8936002)(4326008)(81156014)(6436002)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2463;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: XjfYD7RgvoWD1lGwVuSFgkO9NWaLDKJ0UGI3Z+YLnJ2T6VuIqie8NhC9pWPc+s6B9ysyLqQv7TO13KQcISXi2Wv945X6Ear2bHX5v/WNO5vWQqtvJBZ/ETuk0eWdhNq22GD9fao/EhHxymUD96DB7zyr47rv8MgckIN/mhzP2T7qnprFeeEZf0qQGnVirR8r5y1I1HgObzVopMD3gzatw/5qteyxvYeMe6pndOgKC6iMKLIF673Isxti3TolnTstlMSOwkjgLC4Zw3RfBAks3NddEJqlclQwgyzRxp05PC0WhExpIPL94DG7vGaP4/3UXfSZCIV00LUG2Yb09E0d6a6BPxP8sq6weEGeJeMUVv19jAZGNkwiQyVCmq2d3xI1I55UOMjq0VJ5ob4x6D+zbmZBHcKENP3QE+3JE8B1K0o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2463
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(189003)(199004)(40434004)(356004)(7696005)(9686003)(336012)(99286004)(229853002)(53546011)(6506007)(14454004)(70206006)(76176011)(26826003)(74316002)(70586007)(478600001)(63350400001)(11346002)(63370400001)(446003)(305945005)(476003)(102836004)(22756006)(81156014)(5024004)(81166006)(14444005)(126002)(186003)(486006)(26005)(8676002)(110136005)(7736002)(8936002)(8746002)(55016002)(52536014)(86362001)(66066001)(2906002)(76130400001)(23726003)(6116002)(316002)(44832011)(50466002)(25786009)(3846002)(46406003)(5660300002)(33656002)(47776003)(4326008)(450100002)(6246003)(97756001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5246;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9d774346-ceb5-4574-b9ca-08d7350dfdb1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5246;
X-Forefront-PRVS: 01559F388D
X-Microsoft-Antispam-Message-Info: 3uiqY8uG/kNniHSdEZgya2NWhPeQcmCOp+jAqbKgil5GTjFRQwA84KnR7X3znOAIE7jIDkDfngVHlByMaAcbviZ0ckBo0BKy4942gBivcNwmXqgxiMOVirlipZsby+kkOBsLgYZpImz9akkjfg6Jo6ZWVSUT18bbz38U6eH7mSgrtRM3yKqGeQvWfImIhiF02dMMcX6gf3c7Mq2K0D02wkShq5bJv8Q/UeawQ02FXwTsS/ah+CfTHC2HP8Mg7Tjr5kMADRhmcHtKOjYQxz3Jn4swddvqRd+K71IE22jFi1zmjALq1nrG5vrSqiJdFQCYNbuQYLdgRBvobmzQbJEQ3BC1CW76fryVzPV5H3Nh2BA13a7pdt5m3Z95LUZuiCD6xwgheV7MhmwUgzQ7KMrVq4VqN11jWLExlo/Fq3mmex8=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2019 10:10:57.1951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36d672b-a2cc-484a-50e8-08d7350e01d8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Anatoly, I'll take a look at this. Could you please let me know the =
exact hardware you're running on?

thanks

Dave

________________________________________
From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.or=
g> on behalf of Anatoly Pugachev <matorola@gmail.com>
Sent: 08 September 2019 11:58:08
To: Sparc kernel list
Cc: Linux Kernel list
Subject: [sparc64] Kernel unaligned access at TPC lzo1x_1_do_compress

Hello!

trying to use zram block device, shows the following:

# zramctl -f -s 16g
# cat /sys/block/zram0/comp_algorithm
lzo [lzo-rle] lz4 lz4hc 842 zstd
# zramctl
NAME       ALGORITHM DISKSIZE  DATA COMPR TOTAL STREAMS MOUNTPOINT
/dev/zram0 lzo-rle        16G 10.4M    4K  112K      32

# mkfs.xfs /dev/zram0
...

[   71.095998] zram: Added device: zram0
[   71.765591] zram0: detected capacity change from 0 to 17179869184
[   80.058772] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.073832] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.073866] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.074709] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.074923] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820


all other tested compression algorithms (lzo, lz4, lz4hc, deflate,
842) work without producing kernel TPC.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
