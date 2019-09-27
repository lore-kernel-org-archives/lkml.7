Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1242C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921C8217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EOyGAmqM";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EOyGAmqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfI0JWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:22:19 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:56070
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfI0JWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktHVvdeE0AmLIusxxFngPXHQWytmcjQHpOTsyDE1emc=;
 b=EOyGAmqM+yuJwCEbNQ4PcFZIitOKg6uYMW0ZXmIb4+jYWuSQ2maGCY47B7G2SsMHXckhiful28i19fPpcDM4Mkx/pUrihHq1MbMRzTbBS9a1CWadRMvfIljHTsOh1Zwm7sOKuqEI9Vcd2QzDzNBIWen33wCQPh2PMCI71YClTzU=
Received: from VI1PR08CA0110.eurprd08.prod.outlook.com (2603:10a6:800:d4::12)
 by AM0PR08MB4305.eurprd08.prod.outlook.com (2603:10a6:208:140::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Fri, 27 Sep
 2019 09:20:32 +0000
Received: from AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VI1PR08CA0110.outlook.office365.com
 (2603:10a6:800:d4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15 via Frontend
 Transport; Fri, 27 Sep 2019 09:20:32 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT056.mail.protection.outlook.com (10.152.17.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 27 Sep 2019 09:20:30 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Fri, 27 Sep 2019 09:20:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 39f0fd96134313bf
X-CR-MTA-TID: 64aa7808
Received: from 33096bf300a0.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9914513C-3C8D-4776-92E3-90933EFED853.1;
        Fri, 27 Sep 2019 09:20:23 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 33096bf300a0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 27 Sep 2019 09:20:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpJ5If7u7S7Qsl2Kmwrk1aLiKvH8AVXrDpaSGtAEC2Ulm8XwT62XcQ8h6SUuw9XWlmMrbPsjXWiK4pZlU/sjRYVHjTwH1zdiNyRm8oGJhsq2BDnI8iNW1X5eEo+uR/MrXZRsqVJ5DGLQPZluY12hsmmv/UkZbLboq7c8Aw+atWgOEJSaGGfWANPLfWppjSLPjNsj1rvapULkCS0cD/NhUNuRr8WwhsGwuCdoHG8rpqxCrF5bzvDBjGkO/tP5TV3IRuQ2HxR3POJ7nkV06ipOm/330kupriNnciZ4axBrFcoZ3Qb9h5iZrlW1O6uZ4XDQZYkCY0wI9ojkiNqVJwMWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktHVvdeE0AmLIusxxFngPXHQWytmcjQHpOTsyDE1emc=;
 b=h2uS6+OmvWzES3TiFVM9uOz3aBSjnha2GAdIQrLU1RFzNJ3ItE6K4oBL7TzsnYQsFgwMM21MHNd/0D78OyPxd511nRGwxOFNxGQe7+anDVHLUiOvgXi/syqfjD1k1CIEhA5kiqTB4RAGbwqneDM8vW+0oaH4Cp/d2Y/mG21JJwiFavEt73bYDe+GpwC5LNSp1lChRBOk1tjtLiuT7RIGAsxyWDdCOmmJg3j6LrMysYubWxe/+guUUuIkAAz24JifXx2cL7tjsYmX+4Th8pmtPXZgEEn18HaUUUd19FZJ/O1LKUk0UqSAXgDHr/eWzlicgDIkN37VtLUkSPD6VLFPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktHVvdeE0AmLIusxxFngPXHQWytmcjQHpOTsyDE1emc=;
 b=EOyGAmqM+yuJwCEbNQ4PcFZIitOKg6uYMW0ZXmIb4+jYWuSQ2maGCY47B7G2SsMHXckhiful28i19fPpcDM4Mkx/pUrihHq1MbMRzTbBS9a1CWadRMvfIljHTsOh1Zwm7sOKuqEI9Vcd2QzDzNBIWen33wCQPh2PMCI71YClTzU=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB5110.eurprd08.prod.outlook.com (10.255.34.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Fri, 27 Sep 2019 09:20:21 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 09:20:21 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [RESEND][PATCH v8 5/5] kselftests: Add dma-heap test
Thread-Topic: [RESEND][PATCH v8 5/5] kselftests: Add dma-heap test
Thread-Index: AQHVZOOJZ3fRkDl+s0aCkKKSUkpz7qc57gQAgAStI4CAAMSfgA==
Date:   Fri, 27 Sep 2019 09:20:20 +0000
Message-ID: <20190927092017.zh2srpk3m4wxha4c@DESKTOP-E1NTVVP.localdomain>
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <20190906184712.91980-6-john.stultz@linaro.org>
 <20190923221150.lolc72yvuyazqhr6@DESKTOP-E1NTVVP.localdomain>
 <CALAqxLWyNiaf_Fxa76t9nA9Ea++O1Tcisq_XpH9e1yZJP1YujA@mail.gmail.com>
In-Reply-To: <CALAqxLWyNiaf_Fxa76t9nA9Ea++O1Tcisq_XpH9e1yZJP1YujA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LO2P265CA0324.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::24) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 537a0bd6-3908-4fa4-ae87-08d7432bf150
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB5110;
X-MS-TrafficTypeDiagnostic: AM6PR08MB5110:|AM6PR08MB5110:|AM0PR08MB4305:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4305A2C199DFF4A4CEC1E28FF0810@AM0PR08MB4305.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0173C6D4D5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(26005)(478600001)(8936002)(44832011)(6436002)(6116002)(2906002)(5660300002)(25786009)(3846002)(7736002)(476003)(64756008)(66446008)(66476007)(66556008)(4326008)(99286004)(71200400001)(71190400001)(102836004)(446003)(186003)(6486002)(6916009)(386003)(256004)(8676002)(66946007)(6506007)(76176011)(6246003)(11346002)(81156014)(7416002)(52116002)(53546011)(305945005)(81166006)(54906003)(58126008)(9686003)(6512007)(14454004)(316002)(66066001)(229853002)(1076003)(86362001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5110;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 90g0PTf721aVcc7knb+aZLl2troirLp9BFCDTDfulzW9/izWVPL4ow3bvKLYN9g+Gm0KbPNqVyvdviNVecIOtm2P8Xu8pLURhdfd4WURA9OVPLR9vPWf4TygHyaRWwor1DvB49PDhbfGRqve+gOLqvpGX5ss8hlLxtKR/cljNRvWzx4zEkPi9jQtV5v/01MPIsBrQ07PPstm/UuR0Ku5Gpa+9BpilfTJbIAVuRe3lU42g7IdWQOu3ZL4ly6/7igIrv4fBXCS3ayZLy+M9TFREOfPvX45AKQpogilQbJcSOZJ0PqvaHmoWFc2pZyFd6jDxfQD3JJTeDQN5XB/r8WbvfeSkOB3q+RLbrotX69+dfJGHpmFiXMEXznda77tJuBAp5rYe0eXfTfvMY2FVMeehGUgzxoWLjthJxBNIHPL5vM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A83649C0F316E04389BFB2A6370BCFA7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5110
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(4326008)(446003)(8676002)(26005)(70586007)(7736002)(58126008)(70206006)(81156014)(53546011)(76130400001)(6116002)(66066001)(3846002)(5660300002)(54906003)(2906002)(23726003)(46406003)(26826003)(11346002)(22756006)(81166006)(316002)(97756001)(50466002)(229853002)(36906005)(6246003)(25786009)(126002)(76176011)(486006)(99286004)(47776003)(14454004)(6486002)(1076003)(305945005)(336012)(9686003)(86362001)(6862004)(476003)(6512007)(386003)(356004)(8936002)(186003)(8746002)(63350400001)(102836004)(478600001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4305;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 41fb46c3-1a85-46fb-e910-08d7432beab5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR08MB4305;
NoDisclaimer: True
X-Forefront-PRVS: 0173C6D4D5
X-Microsoft-Antispam-Message-Info: XGHNeWxwxstIWsEzK0QfOlKD0/wqEHY7lc7C8sKuKTqiS3Js//iAbE6y5CFn+KyChuBHqg9udIHjaifwoTBojekL+or7xSGuXYkdrwMnPbWvJHLMm+6pzKAAqpACts6BEZEskTKaDTsKEYj8dcAto16oJUN8pOU/mJwHJmfpTOKP2msngJtJ5anbh06gwIurmGNqVC0du9rPPPMxtUDwTHudJiuS5p52KvUPNNgM4uzPW8QzteKcuMfFgy/5Rr6JbhwsTw1VFZ3vgolsO92hpzMP0GYmYuhW1/Tl14Sbh03nt2TLZI/RzXOxwXSQA/Bt40nuJlxOelcIpzd9olw7kazl/UhvW5r97a9HrZKxEwU3HkG3Nl8sNqCLaoNQ5Q/g/d62uStiBAcdRgRxmtaGwtpcvBPMKiiSZEQHWB2YMus=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2019 09:20:30.6935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537a0bd6-3908-4fa4-ae87-08d7432bf150
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4305
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Thu, Sep 26, 2019 at 02:36:33PM -0700, John Stultz wrote:
> On Mon, Sep 23, 2019 at 3:12 PM Brian Starkey <Brian.Starkey@arm.com> wro=
te:
> >
> > I didn't see any response about using the test harness. Did you decide
> > against it?
>=20
> Hey! Spent a little time looking at this bit and just wanted to reply
> to this point.  So first, apologies, I think I missed the suggestion
> earlier. That said, now that I've looked a little bit at the test
> harness, and at least at this point it feels like it makes it harder
> to reason with than standard c code.  Maybe I need to spend a bit more
> time on it, but I'm a little hesitant to swap over just yet.
>=20
> I'm not particularly passionate on this point, but are you?  Or was
> this just a recommendation to check it out and consider it?

No particular strong feelings. I was just poking around the kernel
docs for testing and the only info there is about the test harness, so
wanted to check if you'd seen/considered it.

A quick grep of tools/testing shows that it's obviously not that
popular... so if you don't fancy it I won't complain.

Thanks,
-Brian

>=20
> thanks
> -john
