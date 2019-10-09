Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5A5C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA22621721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VhA2ThUt";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VhA2ThUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfJIJtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:49:16 -0400
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:19589
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726734AbfJIJtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw3ABvoEB+jJrfcwA4QmDnr6M0B5dRE2qbIrDgxAcFc=;
 b=VhA2ThUt4avyuP3BPmcf0DaFDtQrchxRMiOVO8b/13JSqRQg4ZivuveRJNNO4pXo9nvykGKMIPQAc1w7jyrtgD0BO26rJe984gXt1BAFB/r31VGmJCUljiq1U0fIlrYht2fvFHyKQzCCNxrFdIImXCli1Gt363jZYuyibDMHErI=
Received: from AM4PR08CA0049.eurprd08.prod.outlook.com (2603:10a6:205:2::20)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Wed, 9 Oct
 2019 09:49:05 +0000
Received: from AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by AM4PR08CA0049.outlook.office365.com
 (2603:10a6:205:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 9 Oct 2019 09:49:05 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT049.mail.protection.outlook.com (10.152.17.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 9 Oct 2019 09:49:04 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Wed, 09 Oct 2019 09:49:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 502c432d839232da
X-CR-MTA-TID: 64aa7808
Received: from 1faad6563759.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3B32AD7E-77E4-4464-B5A3-61938B36C143.1;
        Wed, 09 Oct 2019 09:48:58 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1faad6563759.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 09 Oct 2019 09:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObMMzwgCY9Yu80x+aNUDIiCGuczeiIEmOkQaBEgdjcxL6bQQgvwwCrFhdHjuNztcEOzN0i3H3mJ8he9LZ7Bg4r7Gqw77Cfi7cSVihbp2oSmOviKjKv2ytr+MB8jnDKSt5hRmhkqegl9e3mAZ/uPESD0Uzxo/qYLfMthK/Bt/KtTu1HMdvXrDRqkFhUSm3SAFslg1v1Uxs42ccbqug8UGfStGgYzB0z2c516l4wzu6j2v/H8SzI3nLiFnnX7WGC2u2aKT1i/mGJ9bmJ1N00gdr3Y2btKBUUlBVESQitWvkOW2nNu+3NtPltVaLYL90YLphaunBhzJ9J/ug/wn4H/Ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw3ABvoEB+jJrfcwA4QmDnr6M0B5dRE2qbIrDgxAcFc=;
 b=D8tyTSWRqEg14czEbOYBp2zVZAbeqfimL/vhQriLACDVyBmp70kfrmzOexhpxhr0NfPLZ9BP/DGsb7Ty8YwkiMIc5E6T8phUegSq6JLs17sLEvALTwsTQm4Xpw2+Mrt2OxjcWd1cS2x2uQf6gBqpDCcVQAX620lObIZ8PCG/D8C2iXCJRSVNKPQz0N2QIUAJBf/xVSCt5K2qSzNn8dnbBVGsKXzBN6w2aII20yb4qZuQBtWch0XAOWYSbVwt4liuJm5nidjVBxeh9X+8PYHRpsc3hAF7NcRsJMNA6b03plkNCYc7Vl4LW7om0HT35v4aYXvGXS5hSucqKrWSdFh/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw3ABvoEB+jJrfcwA4QmDnr6M0B5dRE2qbIrDgxAcFc=;
 b=VhA2ThUt4avyuP3BPmcf0DaFDtQrchxRMiOVO8b/13JSqRQg4ZivuveRJNNO4pXo9nvykGKMIPQAc1w7jyrtgD0BO26rJe984gXt1BAFB/r31VGmJCUljiq1U0fIlrYht2fvFHyKQzCCNxrFdIImXCli1Gt363jZYuyibDMHErI=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2148.eurprd08.prod.outlook.com (10.172.216.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 09:48:55 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89%12]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 09:48:55 +0000
From:   James Clark <James.Clark@arm.com>
To:     Tan Xiaojun <tanxiaojun@huawei.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Kim Phillips <Kim.Phillips@amd.com>
CC:     "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Al Grant <Al.Grant@arm.com>, nd <nd@arm.com>
Subject: Re: [RFC PATCH 2/3] perf tools: Add support for "report" for some spe
 events
Thread-Topic: [RFC PATCH 2/3] perf tools: Add support for "report" for some
 spe events
Thread-Index: AQHVSRBYwzSrk8h9+0+uZFn2bs0fiabxxmkAgACaVACAWJIigIAFtiSAgAHSXoA=
Date:   Wed, 9 Oct 2019 09:48:55 +0000
Message-ID: <b7e5ca2d-8c6c-8ab8-637e-a9aaebaf62a5@arm.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-3-git-send-email-tanxiaojun@huawei.com>
 <0ac06995-273c-034d-52a3-921ea0337be2@arm.com>
 <016c1ce8-7220-75a2-43fa-0efe150f897c@huawei.com>
 <805660ca-1cf3-4c7f-3aa2-61fed59afa8b@arm.com>
 <637836d6-c884-1a55-7730-eeb45b590d39@huawei.com>
In-Reply-To: <637836d6-c884-1a55-7730-eeb45b590d39@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.96.140]
x-clientproxiedby: LNXP265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::14) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 56b399ea-dcf8-46eb-1a6f-08d74c9deba6
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2148:|AM4PR0802MB2148:|AM6PR08MB4472:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44727AAC18ACD06259BB4F91E2950@AM6PR08MB4472.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 018577E36E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(199004)(189003)(99286004)(2201001)(2616005)(86362001)(31696002)(52116002)(25786009)(14454004)(66946007)(66476007)(66556008)(64756008)(66446008)(6246003)(71200400001)(71190400001)(6512007)(486006)(31686004)(478600001)(44832011)(5660300002)(2906002)(4326008)(476003)(54906003)(66066001)(6506007)(110136005)(386003)(229853002)(76176011)(6486002)(6116002)(3846002)(36756003)(26005)(6436002)(316002)(446003)(11346002)(8676002)(8936002)(81166006)(81156014)(2501003)(7416002)(186003)(256004)(7736002)(102836004)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2148;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: U/GhUXnaA9WCz7CJww/xe+2LCHTobhlFxXi86w1RCAWMQYCpUv6rbp2gEDZafYptjrQgDgzCjJQCxXsmms6m5MQupz/Pk+sD6WlO8HUu0iUfK1B+WbFUOZN/S8gWFn8cg6SnNdlXMpbbNdx9cWU9eEWhqOmpbQsCCoKtWsh/4Qata1dKLh91dM8RNyHIpRb1J1UNKzT1dtX7kZ2ty9rWBy4kKSwCufgpRfLi3f4i4+Az6BGbEDCZypzgMYPPDedUI2sJT6k/d/aaWmqvijQO2BfejUAoBzxZC4G22MG7pfFso9YsrxvMjGOLh+I+iqzKRDxluza54eAAu3WTEHhtoxqjjDeLNMNI6lSZQhhpF9R3EEpK44TND7gO8F6tJ+kl4b71dCpBAIyDC7J8ZmSOxY/iYKcH1XlqR53PdreneQ0=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9E4071F694BA7A45891EB1DFAFE7DC78@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2148
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(316002)(36906005)(14454004)(36756003)(186003)(31686004)(25786009)(110136005)(8676002)(2201001)(81166006)(81156014)(305945005)(7736002)(86362001)(229853002)(6486002)(8936002)(6512007)(26005)(8746002)(76176011)(6116002)(3846002)(99286004)(23746002)(26826003)(478600001)(126002)(6506007)(446003)(11346002)(70586007)(2501003)(6246003)(450100002)(66066001)(47776003)(2616005)(5660300002)(50466002)(476003)(22756006)(356004)(2906002)(54906003)(31696002)(102836004)(76130400001)(63350400001)(336012)(386003)(486006)(4326008)(70206006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4472;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: dbf12311-a892-4c07-4530-08d74c9de61d
NoDisclaimer: True
X-Forefront-PRVS: 018577E36E
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6KkBz24wPBoCKO+npsd1iOxDgo9pFj/MNFPsTf+BbEHp68gyPp9KH6BNK1trKkufHXOUT1CCkvlrqJMyvz+2269e8MZghuNrk44MV7WpxZV4onw8bFGg5DY1AEvxoHBSqAh2EJluxnm5ZzxoPOootDbebjoqHFzS4eGXknmba50vtQKOLPeAOnXoWwFKT4deZO4LPLcHDEG7IY2BdB1KWN5PWsu5F0iFvVfxZ5hc+W/x6n7oghyYPmU+f2CuwBqudHkWb+qvq8Sk9CaEdFvtsmXwuqtL5q61a5sn5k2Ztxd+DQG/oZ4+S4lPezOoMUv5ghCdzKGx3hGT1nNg9xV/kyqOD9VtQ470CuI/fEAAQxEgJMhves9KBGRgYzpyn59lQ6cjNQZvD6Gp3wBG6WHPqcTw+1znbrGBhYGefK1NUCU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2019 09:49:04.2611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b399ea-dcf8-46eb-1a6f-08d74c9deba6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaojun,

> By the way, you mentioned before that you want the spe event to be in the=
 form of "event:pp" like pebs. Is that the whole framework should be made s=
imilar to pebs? Or is it just a modification to the command format?=20

We're currently still investigating if it makes sense to modify the Perf ev=
ent open syscall to use SPE when the "precise_ip" attribute is set. And the=
n synthesize samples using the SPE data when available. This would keep the=
 syscall interface more consistent between architectures.

And if tools other than Perf want more precise data, they don't have to be =
aware of SPE or any of the implementation defined details of it. For exampl=
e the 'data source' encoding can be different from one micro architecture t=
o the next. The kernel is probably the best place to handle this.

At the moment, every tool that wants to use the Perf syscall to get precise=
 data on ARM would have to be aware of SPE and implement their own decoding=
.

> For the former, this may be a bit difficult. For the latter, there is cur=
rently no modification to the record part, so "-c -F, etc." is only for ins=
tructions rather than events, so it may be misunderstood by users.
>=20
> So I haven't figured out how to do. What do you think of this?

I think the patch at the moment is a good start to make SPE more accessible=
. And the changes I mentioned above wouldn't change the fact that the raw S=
PE data would still be available via the SPE PMU. So I think continuing wit=
h the patch as-is for now is the best idea.


James
