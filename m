Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3915ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852C3207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="4mJg6S6f";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="4mJg6S6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfJNJIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:08:53 -0400
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:4066
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730641AbfJNJIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjdDfb2ZFQ9iD52Ik3iojUa2NvjUXapar9HY1cG5/8M=;
 b=4mJg6S6fwApZQNjvZND1dGyczNYmf0KcvA7QLW0+aSaV/f4Y4ZAcBUoEc1kKxWgMOIL/ILiZZO8cI9xZtYTPQA72doVQy+Cd7rWY2QRoaKO6QHfSg24USXgGaxIqskf/50OP3hUu6pGJM72ZZ5lrbd6JT+m8ZZapw1owBuJuGPE=
Received: from VI1PR08CA0249.eurprd08.prod.outlook.com (2603:10a6:803:dc::22)
 by AM6PR08MB3511.eurprd08.prod.outlook.com (2603:10a6:20b:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Mon, 14 Oct
 2019 09:07:43 +0000
Received: from AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR08CA0249.outlook.office365.com
 (2603:10a6:803:dc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Mon, 14 Oct 2019 09:07:43 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT040.mail.protection.outlook.com (10.152.17.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 14 Oct 2019 09:07:41 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Mon, 14 Oct 2019 09:07:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6893c55ad21ed4d0
X-CR-MTA-TID: 64aa7808
Received: from f1d0f99d31f6.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6051C042-7D77-45B3-9722-36AB93295E73.1;
        Mon, 14 Oct 2019 09:07:31 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2055.outbound.protection.outlook.com [104.47.0.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f1d0f99d31f6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 14 Oct 2019 09:07:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIPfekzQwOqXLDHOKcGbOfxzjMdRtyjsue0rFoRWH5ydnxcZm4aeYgWb8HA5jCz/ttN+nsFVkAeEw2g7KNItFbtUSQ5NT7Ma0iDz+AymTLWXHKe+Hg9CfPVk7tFK/fJtfEI3g56YpZgGu8B1JDu+8TRn9OsJRjlR79dnHebOD/xPoYzrnE7pMdf5TDq3s1JF5XhUS8O3UO0qAMLqTsRJudjYSjrRX6hPQKRVqnYATZH71f/d15tWaF24SeEh1PS893YIdezylxR1s4Q503kknL8nhx4ytlmSbgAwrhUA+F8Emz5Xh/jUd1oPrmH3ChiY1RrRcKIfF8ldbTu/Y7+y2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjdDfb2ZFQ9iD52Ik3iojUa2NvjUXapar9HY1cG5/8M=;
 b=NknVqJaew47OpKod+6emI7lS8rUSSCktqlTFzHWiaW7cQbThJgaj+r9bBFw/xu5vWgtxmzPuVN8IOcmT0BFG7RM9gb9Z6e/wSkDej4fmAHS+wA2T+06YFNCL4dnd7T0hYYMOXQOZxN8miKkn8jVwBE2F9zpaQ12/JzMSbJ9uCZ+YOn5lUUXGkEQL4lCo12yNFWwcq0EcNCxvki2S4UyJu3gBpuHbo476nxJmc+hazV7t28193EkjguIopCqZ9vUzDMGKSKMLX6ed2NSHiSgk+3xm8pTfuwwP2LujBFz930Pe9EmOq9Q/z8IpKJCCQZ/gN5gdhjJuBs2n9BBG67a3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjdDfb2ZFQ9iD52Ik3iojUa2NvjUXapar9HY1cG5/8M=;
 b=4mJg6S6fwApZQNjvZND1dGyczNYmf0KcvA7QLW0+aSaV/f4Y4ZAcBUoEc1kKxWgMOIL/ILiZZO8cI9xZtYTPQA72doVQy+Cd7rWY2QRoaKO6QHfSg24USXgGaxIqskf/50OP3hUu6pGJM72ZZ5lrbd6JT+m8ZZapw1owBuJuGPE=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB4914.eurprd08.prod.outlook.com (10.255.99.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 14 Oct 2019 09:07:29 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2347.023; Mon, 14 Oct 2019
 09:07:29 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
CC:     Ayan Halder <Ayan.Halder@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>, nd <nd@arm.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
Thread-Topic: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
Thread-Index: AQHVZOOE06vVhxy1kU6dQZ4T2LR+pw==
Date:   Mon, 14 Oct 2019 09:07:29 +0000
Message-ID: <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
 <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com>
In-Reply-To: <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0462.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::18) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 31d30c37-35e4-46f4-31f0-08d75085f7f8
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB4914:|AM6PR08MB4914:|AM6PR08MB3511:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3511755FDE15B8A2590F42B2F0900@AM6PR08MB3511.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01901B3451
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(189003)(199004)(3846002)(6246003)(256004)(4326008)(6436002)(6486002)(229853002)(6116002)(8676002)(4744005)(6306002)(6512007)(9686003)(81156014)(81166006)(8936002)(1076003)(66066001)(476003)(44832011)(486006)(86362001)(66446008)(64756008)(66556008)(66476007)(66946007)(25786009)(478600001)(966005)(14454004)(71200400001)(71190400001)(99286004)(316002)(7416002)(5660300002)(58126008)(6916009)(54906003)(446003)(386003)(102836004)(305945005)(186003)(26005)(7736002)(2906002)(52116002)(76176011)(6506007)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4914;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fe8atxKmxTrtkdKdXSGFMSA08UDia2T9xUjCq3y8Ii4ZO7GAKK0KVXIoFdCSCZ02/EmeLbclx1Nf+raA4LP8s09fLaetnZ3XOnxVGfybi3PChZZOA94kXv9wUtL/O9CwvccdpiWWlP3yZWwOEjhds5KKxlvs1jNDOTKcfwcBEtlmDXiuIrj5FCEToW6oQfTEKVxoeJz27DX9v+kImrTreQULikC4Ek0PjFD5geY+FD8bFh73zU4Qii1Lp/RHBjphRfbncHmo2joqfprb2meLMvZrHDaK1NPhlC+LKTkj0SBafT5Fd6HMBetGfjhAleOgbU7g9g2bb0D8W7bJKklOY9YX25nqrgeusW1fNaSXkHXMx/UTDeUX5Uc8X7x800pCpS7jdY+FRPR72MacoUGo0aoK0q5DVWQJZLq8DVefAkNEzV3DfYu4YbtvzfRadJBQHT6zRocftwQne9vpzDor2w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C42850FCE9C80E459D13CAF63C20B26B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4914
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(199004)(189003)(50466002)(36906005)(99286004)(47776003)(1076003)(25786009)(5660300002)(8746002)(6506007)(8936002)(81166006)(81156014)(8676002)(186003)(76176011)(46406003)(76130400001)(966005)(66066001)(102836004)(14454004)(58126008)(54906003)(386003)(26005)(86362001)(4744005)(26826003)(356004)(498600001)(7736002)(6116002)(305945005)(3846002)(476003)(126002)(2906002)(23726003)(63350400001)(486006)(446003)(97756001)(11346002)(336012)(4326008)(6862004)(70206006)(70586007)(6486002)(6246003)(107886003)(9686003)(6512007)(22756006)(6306002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3511;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 079c6380-2cea-43ac-f456-08d75085f066
NoDisclaimer: True
X-Forefront-PRVS: 01901B3451
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TV2RPelcaFYTW44tOK0p+mghIghtseJomFQyRs3LuJln0zl3BigTqqGH4EAHZln9r4xz+tlkJVBGJcmv0YTryqbcb+G0B59ui9KGXtpstZbAwdmr0Qfa++mli8t+ZnooQGj7A1a41UhqZJvoICwF83WzI8iGSTGitwihNN9sJCiJiXa4wpcl6cy/BkenAvOI8eRTrsqkG11qJWT/czDIUjkiOgLQwjk9OkKFVXowet2K+khl87VM6VXXNSpI0FgSQl9frRvAbISPKDKhQhkPUrEjPcK515JJTYBRcLHj66poHjsbc7WgkcLcaj4mMubOKfpSIjCzK6VMdk5bEXgNZg8cOw/UPY3ZRG5v1LRppDAoij/5oLkvocznV95y2Bj+wKqZgahpscciGUA4FsklHn2RF9Tf/J8ViNMfNI29Nj99eGN1Lumq6XLjAnNGTmxlNLf+Z6JcCHofeQ1c1bKDdA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2019 09:07:41.6764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d30c37-35e4-46f4-31f0-08d75085f7f8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Oct 09, 2019 at 02:27:15PM -0400, Andrew F. Davis wrote:
> The CMA driver that registers these nodes will have to be expanded to
> export them using this framework as needed. We do something similar to
> export SRAM nodes:
>=20
> https://lkml.org/lkml/2019/3/21/575
>=20
> Unlike the system/default-cma driver which can be centralized in the
> tree, these extra exporters will probably live out in other subsystems
> and so are added in later steps.
>=20
> Andrew

I was under the impression that the "cma_for_each_area" loop in patch
4 would do that (add_cma_heaps). Is it not the case?

Thanks,
-Brian

