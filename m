Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EEEC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F9B2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="P6mSqAR7";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="P6mSqAR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfKOLhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 06:37:47 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:20038
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfKOLhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR+mCBVoEXYMR5caJFazifjABIyzTpEYqwKWy8LvLso=;
 b=P6mSqAR7h0sEVdfhj000j77pzaE68R/ksN75ljN8kAb3mMWoYClb07tYrH+FJ2w8mYUcP4qeV13Z7emMXRsOIWr+IRgYIC4NY58CgTCY/fPZMwX5JJ6cZFm1DCVds+nUi+r9ZfdbfowuHPPBWw3yVe17lhMD7f9OYEwrHg6bIsc=
Received: from DB6PR0802CA0031.eurprd08.prod.outlook.com (2603:10a6:4:a3::17)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26; Fri, 15 Nov
 2019 11:37:37 +0000
Received: from VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by DB6PR0802CA0031.outlook.office365.com
 (2603:10a6:4:a3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Fri, 15 Nov 2019 11:37:37 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT033.mail.protection.outlook.com (10.152.18.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2451.23 via Frontend Transport; Fri, 15 Nov 2019 11:37:36 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Fri, 15 Nov 2019 11:37:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 64a12b55daa398a4
X-CR-MTA-TID: 64aa7808
Received: from da242f583ab4.1 (cr-mta-lb-1.cr-mta-net [104.47.8.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BCF7FD68-7477-4648-BE2F-2B1476273020.1;
        Fri, 15 Nov 2019 11:37:31 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2052.outbound.protection.outlook.com [104.47.8.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id da242f583ab4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 15 Nov 2019 11:37:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecNOfXDeqK89wW01QZFOVQkS9uMQg45nJcBloSoWmnvtnVYaNnLzq//K63OXW8k1xA0wPsNg07rF3UvBP93J5abO/TycIYIWeHryp9ggVSb+UreuqtFhth4wvzxbWOjqjST8xlX0sE9bAX55o/NhpQyOtc+usmmhJ+0ZRnR6BBofUzthb4pMn4+/pXT3zCEDbMe6T1IFI8n/D9eHyDO4rCPsA4OvqRsdxJqW5z60eHhtq27CCZj2N6I1SqqOsZvceI6KgwWzwfEShSqtEk8Lw3+dPDr+6IKuodhJDn81tpENZPMJKxIxfSQnm0LclDvcOr2gmyy/9UjdAr7XNEoqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR+mCBVoEXYMR5caJFazifjABIyzTpEYqwKWy8LvLso=;
 b=a/RwDoy97nnCQeKoLTnW4v3y90VrIOt+O7GXMevvEwi/HtE6+VOqLPVuvmxQh2p1oO688fgP9A2QxE133ChZwUIKe7z22LOEll2f+bfApzDG8/DWggUqq+8gQ6YJuA3Cbz07Wos3cN4zRT4qm317K7uKlQ7mVD5BZyA1uFH1xpyKQlniqA3eAlX5Pn5L609sSG/XYZBSujBGwcF+lO8peen+UpBD0TUe+aE7csLiKLfmkHI6hxKRLXPKpJ3YvzljKFnCDi7Bzcks1hh/nuUKv0fc4AITQ3XNN7xgJfIUfAxaWuLHhWzz1mo4rC5+Tmnimz77TMC1mtM5JAeChran6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR+mCBVoEXYMR5caJFazifjABIyzTpEYqwKWy8LvLso=;
 b=P6mSqAR7h0sEVdfhj000j77pzaE68R/ksN75ljN8kAb3mMWoYClb07tYrH+FJ2w8mYUcP4qeV13Z7emMXRsOIWr+IRgYIC4NY58CgTCY/fPZMwX5JJ6cZFm1DCVds+nUi+r9ZfdbfowuHPPBWw3yVe17lhMD7f9OYEwrHg6bIsc=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2354.eurprd08.prod.outlook.com (10.172.220.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 11:37:29 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::2019:b825:f77c:a99]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::2019:b825:f77c:a99%2]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 11:37:29 +0000
From:   James Clark <James.Clark@arm.com>
To:     Tan Xiaojun <tanxiaojun@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [RFC v2 4/4] perf tools: Support "branch-misses:pp" on arm64
Thread-Topic: [RFC v2 4/4] perf tools: Support "branch-misses:pp" on arm64
Thread-Index: AQHVinOCdAafC6cxzk2KUX39BmOYH6dp9Ys9gACxWACAHqbBgIACXusAgACQpoA=
Date:   Fri, 15 Nov 2019 11:37:29 +0000
Message-ID: <b89f09fd-e9c4-9112-6a6a-16f9632ccbe3@arm.com>
References: <20191024144830.16534-1-tanxiaojun@huawei.com>
 <20191024144830.16534-5-tanxiaojun@huawei.com>
 <AM4PR0802MB224263700592195B3BAE9D5AE26A0@AM4PR0802MB2242.eurprd08.prod.outlook.com>
 <38c18a3e-1b9a-05fe-63f6-920af2f53fc7@huawei.com>
 <609eb078-7998-9e4a-ca04-6c40a8a47f84@arm.com>
 <7137fecb-a0bd-6dee-14c9-5753e56d39a1@huawei.com>
In-Reply-To: <7137fecb-a0bd-6dee-14c9-5753e56d39a1@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: CWLP265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::32) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b781b49-fffc-4f8d-319e-08d769c036b9
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2354:|AM7PR08MB5336:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53369409977D13229D466169E2700@AM7PR08MB5336.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 02229A4115
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(189003)(199004)(54094003)(256004)(7736002)(36756003)(14454004)(229853002)(5660300002)(6512007)(11346002)(99286004)(31686004)(478600001)(8936002)(446003)(71200400001)(71190400001)(8676002)(66066001)(4326008)(2906002)(64756008)(66476007)(66446008)(66556008)(305945005)(86362001)(53546011)(486006)(386003)(66946007)(44832011)(25786009)(102836004)(6916009)(31696002)(6506007)(6436002)(76176011)(316002)(476003)(26005)(186003)(54906003)(3846002)(6116002)(2616005)(52116002)(6486002)(6246003)(14444005)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2354;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: E99mHW8LhrIzscnBlgLpMpGosCZa6x2oRF/hTlCcTtFwcq1gl5wYmQcoKLy7xkrNPEydWo1gtJclTrMwGgmy82wL/UOiio2D3+Gg1hPOnBPvgrPptsaM/w/z9kZgPQKPBy834X3JktbKQFPMS3/I37XfET3KwcXlMXqhdv6KIrAKFAkpTw7RiUCfQX2Mshd3BEZBCX9SzccaYju7ldIGZhQ0gOq7BsPyWNbI7c/wxcbjpTnMWIZbeQIAONyYnHq0wCeUh0qUt6DKmrfRnvBVowNGNeEAS2diAuT/OM6ERB3XJe1gJOZlN3vkSIpoJ/nBud/Mz3Orgd0X77tOBsC7kirjyqSmSuyY4yUmHV1g6AReezTsKwTrkuHy8J956NzPH/o7D+PCRM2YlVtbIHzUiAYS5w+HRLM9xHcUWbyBykhnM9FjKbTpKUPiDtoGbrRy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <557841CF9956344A84480EC539120181@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2354
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(1110001)(339900001)(54094003)(199004)(189003)(14454004)(86362001)(2906002)(23676004)(3846002)(6116002)(2486003)(66066001)(31696002)(47776003)(7736002)(99286004)(305945005)(14444005)(76176011)(6512007)(356004)(50466002)(6862004)(6246003)(105606002)(22756006)(229853002)(6486002)(31686004)(316002)(26826003)(478600001)(446003)(54906003)(102836004)(336012)(36906005)(386003)(6506007)(53546011)(26005)(436003)(186003)(11346002)(8936002)(25786009)(486006)(4326008)(5660300002)(450100002)(8676002)(81156014)(81166006)(476003)(126002)(2616005)(70206006)(76130400001)(70586007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5336;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f0459f96-5450-433a-643f-08d769c03227
NoDisclaimer: True
X-Forefront-PRVS: 02229A4115
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGvtrqW7nXk+cDK9gW7bNFh9VlOkxMRZu5Yw/VAA1HFHmHA6bnque3gab4dQRgM7Yj2E1CJSTyhpJxzHHkhGg9GDbu9eZ1u9CtZoFfHXqcmAbZRKpcpU2wPiUhRT4pAIwvBfsmlllOk3tmWQvECDP4lmqIhUlhLKPGPqRVbfaM83UaiWdcDypkZ6iPozQ9NRJYWpx+XiJDOKXAMiuAGypmdEmqA2Ntoz8fupjUbi51NHvTuEulWrS+z6PIwxVErBbGQ+tckSR5l/d90NDw2msO6J2+08UlHF9jwa81EjAcRJYIK9WWVpVdlRE3FriZeew3SBdHfXd1FVPxRZMVF6/QqAP9KPVLt3oJoiHxDr1nJOHMPOsKg65Q4ZxE36C+M8GxszKnPeDXD+MAbgVeKz5QafHg4JXzSJr5bu5Dc856QNU587LFHTo2FCKqW7KbB8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 11:37:36.7086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b781b49-fffc-4f8d-319e-08d769c036b9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWGlhb2p1biwNCg0KSWYgdGhlIGRpZmZlcmVuY2UgaXMgbm90IG5vdGljZWFibGUgSSB0aGlu
ayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gbGVhdmUgaXQgZGlzYWJsZWQuIFByZXN1bWFibHkgaWYg
dGhlIHVzZXINCnN1cHBsaWVzIHRoZSAiOnAiIGFyZ3VtZW50IHRoZXkgYXJlIGludGVyZXN0ZWQg
aW4gdGhlIGRhdGEgYmVpbmcgYXMgcHJlY2lzZSBhcyBwb3NzaWJsZS4NCg0KSWYgdGhleSB3YW50
IHRvIGVuYWJsZSBqaXR0ZXIsIHRoZW4gY2FuIGFsd2F5cyBjb25maWd1cmUgdGhlIFNQRSBldmVu
dCBtYW51YWxseS4NCg0KSSBoYXZlIGEgcXVlc3Rpb24gYWJvdXQgd2hhdCBraW5kIG9mIGFwcHJv
YWNoIHlvdSB0aGluayB3ZSBzaG91bGQgdGFrZSBmb3IgbXVsdGlwbGUgZXZlbnRzIHRoYXQgYXJl
IHByb3ZpZGVkIHdpdGggOnAuDQpGb3IgZXhhbXBsZSAicGVyZiByZWNvcmQgLWUgYnJhbmNoLW1p
c3NlczpwIC1lIGNhY2hlLW1pc3NlczpwIC4uLiIuIEluIHlvdXIgY3VycmVudCBpbXBsZW1lbnRh
dGlvbiB0aGlzIHdpbGwNCmdpdmUgdGhlIGVycm9yICJUaGVyZSBtYXkgYmUgb25seSBvbmUgU1BF
IGV2ZW50Ii4gSSB0aGluayB0aGlzIGlzIGZpbmUgZm9yIGEgZmlyc3QgaW1wbGVtZW50YXRpb24u
IEJ1dCBJIHdvbmRlciBpZiB0aGVyZQ0KaXMgYSB3YXkgb2Ygc3VwcG9ydGluZyBtdWx0aXBsZSBT
UEUgZXZlbnRzPw0KDQpGcm9tIHRoZSBkb2N1bWVudGF0aW9uIGl0IHNlZW1zIGxpa2UgdGhlIGZp
bHRlciBldmVudHMgYXJlIEFORGVkIHRvZ2V0aGVyOg0KDQoJUE1TRVZGUl9FTDEuDQoJQ29udHJv
bHMgc2FtcGxlIGZpbHRlcmluZyBieSBldmVudHMuIFRoZSBvdmVyYWxsIGZpbHRlciBpcyB0aGUg
bG9naWNhbCBBTkQgb2YgdGhlc2UgZmlsdGVycy4gRm9yIGV4YW1wbGUsIGlmIEVbM10gYW5kIEVb
NV0gYXJlIGJvdGggc2V0IHRvIDEsDQoJb25seSBzYW1wbGVzIHRoYXQgaGF2ZSBib3RoIGV2ZW50
IDMgKExldmVsIDEgdW5pZmllZCBvciBkYXRhIGNhY2hlIHJlZmlsbCkgYW5kIGV2ZW50IDUgc2V0
IChUTEIgd2FsaykgYXJlIHJlY29yZGVkDQoNCldoaWNoIG1lYW5zIHRoYXQgaWYgd2Uga2VwdCBh
ZGRpbmcgZmlsdGVycyBmb3IgbmV3IGV2ZW50IHR5cGVzLCB0aGVyZSB3b3VsZCBiZSBubyBldmVu
dHMgcmVjZWl2ZWQgYmVjYXVzZSB0aGV5IHdvdWxkbid0IHNhdGlzZnkgdGhlIGZpbHRlciByZXF1
aXJlbWVudHMNCm9mIGJlaW5nIGNhdXNlZCBieSBhIGJyYW5jaCBtaXNzIEFORCBhIGNhY2hlIG1p
c3MgZm9yIGV4YW1wbGUuIEkgaGF2ZSBhc2tlZCBpbnRlcm5hbGx5IGFib3V0IHdoZXRoZXIgdGhp
cyBpcyBhIG1pc3Rha2Ugb3Igbm90Lg0KDQoNClRoYW5rcw0KSmFtZXMNCg0KT24gMTUvMTEvMjAx
OSAwMjo1OSwgVGFuIFhpYW9qdW4gd3JvdGU6DQo+IE9uIDIwMTkvMTEvMTMgMjI6NDcsIEphbWVz
IENsYXJrIHdyb3RlOg0KPj4gSGkgWGlhb2p1biwNCj4+DQo+Pj4gSSBjYW4ndCByZXByb2R1Y2Ug
dGhpcyBwcm9ibGVtLiBJZiB0aGUgY3VycmVudCBzeXN0ZW0gZG9lc24ndCBzdXBwb3J0IHNwZSwg
aXQgc2hvdWxkbid0IHJlcG9ydCBhbiBlcnJvci4gSSB1c2UgdGhlIGxhdGVzdCBjb2RlcyBvZiB0
aGUgbWFpbmxpbmU6DQo+Pg0KPj4gSSB0aGluayB0aGUgcHJvYmxlbSBpcyByZWxhdGVkIHRvIHRo
ZSAndHlwZScgYXR0cmlidXRlIG9mIHRoZSBldmVudC4gVG8gb3BlbiB0aGUgU1BFIFBNVSB0aGUg
ZXZlbnQgdHlwZSBvbiB0aGUgcGxhdGZvcm0gSSdtIHVzaW5nIGlzICc3Jy4gSWYgSSBjaGFuZ2UN
Cj4+IHRoZSBjb2RlIGxpa2UgdGhpcywgdGhlIHByb2JsZW0gaXMgZml4ZWQ6DQo+Pg0KPj4gQEAg
LTkxNCwxMyArOTE0LDI3IEBAIHZvaWQgYXJtX3NwZV9wcmVjaXNlX2lwX3N1cHBvcnQoc3RydWN0
IGV2bGlzdCAqZXZsaXN0LCBzdHJ1Y3QgZXZzZWwgKmV2c2VsKQ0KPj4gICAgICAgICAgICAgICAg
IHBtdSA9IHBlcmZfcG11X19maW5kKCJhcm1fc3BlXzAiKTsNCj4+ICAgICAgICAgICAgICAgICBp
ZiAocG11KSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBldnNlbC0+cG11X25hbWUgPSBw
bXUtPm5hbWU7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBldnNlbC0+Y29yZS5hdHRyLnR5
cGUgPSBQRVJGX1JFQ09SRF9BVVhUUkFDRTsNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGV2
c2VsLT5jb3JlLmF0dHIuY29uZmlnID0gU1BFX0FUVFJfVFNfRU5BQkxFDQo+PiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IFNQRV9BVFRSX1BBX0VOQUJM
RQ0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBT
UEVfQVRUUl9KSVRURVINCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGV2c2VsLT5jb3JlLmF0
dHIudHlwZSA9IHBtdS0+dHlwZTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGV2c2VsLT5j
b3JlLmF0dHIuY29uZmlnIHw9IFNQRV9BVFRSX1RTX0VOQUJMRQ0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBTUEVfQVRUUl9CUkFOQ0hfRklMVEVS
Ow0KPj4NCj4gDQo+IEhpLCBKYW1lcywNCj4gT0suIFRoYW5rIHlvdSBmb3IgeW91ciBmaXguDQo+
IA0KPj4gQWxzbyBkbyB5b3UgdGhpbmsgaml0dGVyIHNob3VsZCBiZSBlbmFibGVkIGJ5IGRlZmF1
bHQ/IEkgdGhvdWdodCB0aGF0IGl0IG1pZ2h0IG1ha2UgdGhlIGRhdGEgbGVzcyBwcmVjaXNlLCBz
byBJIHJlbW92ZWQgaXQgaGVyZS4NCj4gDQo+IFNpbmNlIHRoZSBpbnRlcnZhbCBmb3Igc2FtcGxp
bmcgd2l0aG91dCAiaml0dGVyIiBpcyBmaXhlZCAoZGVmYXVsdCAxMDI0IG9uIG91ciBzZXJ2ZXIp
LCBJIHdhcyB3b3JyaWVkIHRoYXQgbm90IGFkZGluZyBpdCB3b3VsZCByZXN1bHQgaW4gdGhlIHNh
bWUgcmVzdWx0IGZvciBlYWNoIHJlY29yZCwgYW5kIHNvbWUgaW5zdHJ1Y3Rpb25zIGNvdWxkIG5v
dCBiZSBjb2xsZWN0ZWQgZWFjaCB0aW1lLg0KPiANCj4gSG93ZXZlciwgYWZ0ZXIgbWFueSB0ZXN0
cywgaXQgaXMgbm90IGNsZWFyIGZyb20gdGhlIHJlc3VsdHMgdGhhdCB0aGVyZSBpcyBhIHNpZ25p
ZmljYW50IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGVtIChlbmFibGUgaXQgb3Igbm90KS4NCj4gDQo+
IFNvIEkgYW0gY29uZnVzZWQsIHdoZXRoZXIgdG8gZW5hYmxlIGl0IG9yIG5vdC4NCj4gDQo+IFRo
YW5rcy4NCj4gWGlhb2p1bi4NCj4gDQo+Pg0KPj4gLUphbWVzDQo+Pg0KPj4+DQo+Pj4gY29tbWl0
IGYxMTZiOTY2ODVhMDQ2YTg5YzI1ZDRhNmJhMmRhNDg5MTQ1Yzg4ODggKG1haW5saW5lL21hc3Rl
cikNCj4+PiBNZXJnZTogZjYzMmJmYWEzM2VkIDYwM2Q5Mjk5ZGEzMg0KPj4+IEF1dGhvcjogTGlu
dXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPj4+IERhdGU6ICAg
VGh1IE9jdCAyNCAwNjoxMzo0NSAyMDE5IC0wNDAwDQo+Pj4NCj4+PiAgICAgTWVyZ2UgdGFnICdt
ZmQtZml4ZXMtNS40JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvbGVlL21mZA0KPj4+DQo+Pj4gSSB3aWxsIGdvIGFuZCBzZWUgd2h5IHRoaXMgd2lsbCBi
ZSByZXBvcnRlZC4NCj4+Pg0KPj4+Pg0KPj4+Pg0KPj4+PiBJIHdvdWxkIGhhdmUgZXhwZWN0ZWQg
dG8gdXNlIHRoZSBldmVudCBuYW1lIHRoYXQgaXMgbGlzdGVkIGluIHRoZSBTUEUgZG9jdW1lbnRh
dGlvbiBmb3IgYnJhbmNoIG1pc3NlcyB3aGljaCBpcyBicl9taXNfcHJlZCBvciBicl9taXNfcHJl
ZF9yZXRpcmVkOg0KPj4+Pg0KPj4+PiDCoMKgwqAgRVs3XSwgYnl0ZSAwIGJpdCBbN10NCj4+Pj4g
wqDCoMKgIE1pc3ByZWRpY3RlZC4gVGhlIGRlZmluZWQgdmFsdWVzIG9mIHRoaXMgYml0IGFyZToN
Cj4+Pj4gwqDCoMKgIDAgRGlkIG5vdCBjYXVzZSBjb3JyZWN0aW9uIHRvIHRoZSBwcmVkaWN0ZWQg
cHJvZ3JhbSBmbG93Lg0KPj4+PiDCoMKgwqAgMSBBIGJyYW5jaCB0aGF0IGNhdXNlZCBhIGNvcnJl
Y3Rpb24gdG8gdGhlIHByZWRpY3RlZCBwcm9ncmFtIGZsb3cuDQo+Pj4+DQo+Pj4+IMKgwqDCoCBJ
ZiBQTVV2MyBpcyBpbXBsZW1lbnRlZCB0aGlzIEV2ZW50IGlzIHJlcXVpcmVkIHRvIGJlIGltcGxl
bWVudGVkIGNvbnNpc3RlbnRseSB3aXRoIGVpdGhlciBCUl9NSVNfUFJFRCBvciBCUl9NSVNfUFJF
RF9SRVRJUkVELg0KPj4+Pg0KPj4+DQo+Pj4gRG8geW91IG1lYW4gdGhhdCBJIGNhbiBhZGQgdGhl
c2UgYXMgbmV3IGV2ZW50cyB0byBwZXJmPyBJZiB3ZSB0aGluayBvZiB0aGVtIGFzIG5ldyBldmVu
dHMsIHdoYXQgc2hvdWxkIHdlIGRvIGlmIHRoZSB1c2VyIGRvZXMgbm90IGFkZCA6cHAgZm9yIHRo
ZW0/DQo+Pj4gKE9yIGZvciB0aGVzZSBldmVudHMsIHVzZXJzIGNhbiBvbmx5IGFkZCA6cHAgdG8g
dXNlIHRoZW0/KQ0KPj4+DQo+Pj4+DQo+Pj4+ICvCoMKgwqDCoMKgwqAgaWYgKCFzdHJjbXAocGVy
Zl9lbnZfX2FyY2goZXZsaXN0LT5lbnYpLCAiYXJtNjQiKQ0KPj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJiYgZXZzZWwtPmNvcmUuYXR0ci5jb25maWcg
PT0gUEVSRl9DT1VOVF9IV19CUkFOQ0hfTUlTU0VTDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmJiBldnNlbC0+Y29yZS5hdHRyLnByZWNpc2VfaXAp
IHsNCj4+Pj4NCj4+Pj4gQXMgSSBtZW50aW9uZWQgYWJvdmUgUEVSRl9DT1VOVF9IV19CUkFOQ0hf
TUlTU0VTZG9lc24ndCBzZWVtIHRvIG1hdGNoIHVwIHdpdGggdGhlIGFjdHVhbCBldmVudCBjb3Vu
dGVyIHRoYXQgaXMgYXNzb2NpYXRlZCB3aXRoIHRoaXMgU1BFIGV2ZW50IChCUl9NSVNfUFJFRCku
IFRoZSBmaXggZm9yIHRoaXMgaXMgcHJvYmFibHkgYXMgc2ltcGxlIGFzIGFkZGluZyBhbiBPUiBm
b3IgdGhlIG90aGVyIGFsaWFzZXMgZm9yIGJyYW5jaCBtaXNwcmVkaWN0cy4NCj4+Pg0KPj4+IFdo
YXQgeW91IG1lYW4gaXMgdGhhdCB3ZSBjYW4gZmlsdGVyIHdpdGggc3BlIGV2ZW50cyhsaWtlIEJS
X01JU19QUkVEKSBmaXJzdCwgYW5kIGlmIHdlIGhhdmUgb3RoZXIgZXZlbnRzIHRoYXQgYXJlIGV4
YWN0bHkgdGhlIHNhbWUobm8gbW9yZSBmb3Igbm93KSwgdGhlbiB3ZSBjYW4gaGFuZGxlIHRoZW0g
YnkgYWRkaW5nIE9SIGluIHRoZSBmdXR1cmU/DQo+Pj4NCj4+Pj4NCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcG11ID0gcGVyZl9wbXVfX2ZpbmQoImFybV9zcGVfMCIpOw0KPj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocG11KSB7DQo+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBldnNlbC0+cG11X25hbWUgPSBw
bXUtPm5hbWU7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBldnNlbC0+Y29yZS5hdHRyLnR5cGUgPSBQRVJGX1JFQ09SRF9BVVhUUkFDRTsNCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV2c2VsLT5jb3Jl
LmF0dHIuY29uZmlnID0gU1BFX0FUVFJfVFNfRU5BQkxFDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IFNQRV9BVFRSX1BBX0VOQUJMRQ0KPj4+Pg0KPj4+PiBJIHdv
dWxkbid0IHNldCBwaHlzaWNhbCBhZGRyZXNzZXMgYnkgZGVmYXVsdCBhcyB0aGlzIHJlcXVpcmVz
IHJvb3QuIEkgd291bGQgbGVhdmUgdGhhdCB0byB0aGUgdXNlciBpZiB0aGV5IHdhbnQgdG8gbWFu
dWFsbHkgY29uZmlndXJlIFNQRS4NCj4+Pg0KPj4+IFllcy4gWW91IGFyZSByaWdodC4gSSBnb3Qg
YSBlcnJvciBmb3IgdGhpcyBjYXNlLiBJIHdpbGwgZml4IGl0Lg0KPj4+DQo+Pj4gLS0tLS0tLS0t
LS0tLS0tLS0tDQo+Pj4gLi9wZXJmIHJlY29yZCAtZSBicmFuY2gtbWlzc2VzOnAgbHMNCj4+PiBF
cnJvcjoNCj4+PiBZb3UgbWF5IG5vdCBoYXZlIHBlcm1pc3Npb24gdG8gY29sbGVjdCBzdGF0cy4N
Cj4+PiAuLi4NCj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pg0KPj4+IFRoYW5rcy4NCj4+PiBY
aWFvanVuLg0KPj4+DQo+Pj4+DQo+Pj4+IEkgaGF2ZSBvbmx5IGxvb2tlZCBicmllZmx5IGFuZCBJ
IHdpbGwgZG8gc29tZSBtb3JlIHRlc3RpbmcuDQo+Pj4+DQo+Pj4+DQo+Pj4+IFRoYW5rcw0KPj4+
PiBKYW1lcw0KPj4+Pg0KPj4+Pg0KPj4+DQo+Pj4NCj4gDQo+IA0K
