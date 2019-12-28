Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E0AC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 21:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9943420838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 21:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eJg66eWV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="KgtLC5Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfL1VHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 16:07:16 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:44250 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbfL1VHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 16:07:15 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 10F99C008A;
        Sat, 28 Dec 2019 21:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1577567234; bh=3iMv889kndr+/3F2T7kQRZSErBW64bq+cekMWkDIOLE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=eJg66eWVz2m37MwSCvBDKAJZ/RvPZTRaBeMnOO7LYbSeey3TFh0OGN6cJU17PyIOr
         G65Mj2QBKTyApECQRgSH9Sjg9UEJ3IPJvLWsoySLEhl9dUft854Af6HRZ+PE0w9o9t
         y8ONGlnLjUqQX31HUlFT8AC9DEHF9Q/nNIVKN6NgAxyv3pswYhRi9IigEDmRkOG7RI
         NSJGzKqScGWd3M7hrvswV53gATI5qj3fXa8a3zwu0dgUYsS2Au3DMemgUG8H7QQFNN
         nPAlXjx+Wbeqedl1r/UK6sHl8sGJEHp2Amy2k1ESn5dXRwv6n3DOYRQLSL+wRZCkRY
         RdgJlCzPHHJXA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 36DB1A0079;
        Sat, 28 Dec 2019 21:07:08 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 28 Dec 2019 13:07:02 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Sat, 28 Dec 2019 13:07:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsekYjelbcs854BFJR9GS7oujNZaTf6UbdzotMJaCAloPZkTRYDAayp7uU7k+8DeqiSxnN7AuOn4JFt95ESQ88B0JLg21ntG31xRPIue8K2dJNHwYSJvpuT/uFHx3e5UmjFBz05K6P4E9sF9atUqxDcN7SWsMnxZfymSbZT4Lqgp6DcLfQfIZkwOHm8GJUQz6lYF+/HB4732E2w1K37BhVnBnGZGZbnnvM+5O3x8NZM65TAO6vSDw6bJSqd3OgIIOMppds3z/9OYj1O2f2iQcrUsujwASgd1kK8kSEdkewfFmQtEboLKKUnpV38sGcCKCH947ba3gvQoCvK9dz4k1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iMv889kndr+/3F2T7kQRZSErBW64bq+cekMWkDIOLE=;
 b=S2heahAK/UNnpQr3jw2JWBpxRgL6ZLssiXAAXj6R2ZrX5scj7U24ipcDunnU2T3nnOsxFPObRj9zXI7L4BbrBPz/LL0Eo4jEaQUbXLPod3S6bj8w/wNpImp1Ju+bWdp7EqgHUEwa1XHlKVFgON/bV8Q41s6nwkxGx/MqLANdWiNby+UvHdxqDSnBnC+5HYQJ70Jlb7rWvDQsF0mlJuZkNvO+Xr0skN0rfVVnalPp/7bMSVOIjXlCvCSVK3aM21slv0FFk3Z2200Pk87sBl8k5RmULIHriIMin15jUKMpoqA0xvHDdpAFuT1+h3RxYNX/MVKNxhjD1vXlwS9Y2ImQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iMv889kndr+/3F2T7kQRZSErBW64bq+cekMWkDIOLE=;
 b=KgtLC5FsUmml4zk4VMxP4w+H9/WoXrKgi1/4kB8BfeL0vJcSXK87INmoP8onNr6gVfghHfuRYLFI/meeIsViaP+jyfPHNqP5KYsxGxsOiHdXFQYTNWCSC6san7QxqWXyP2x7juyk1vIVsHDwELoWwdDvK3qiKlMlRPPoVvFdUMY=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB3301.namprd12.prod.outlook.com (20.179.91.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Sat, 28 Dec 2019 21:07:00 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2581.007; Sat, 28 Dec 2019
 21:06:59 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 1/5] ARC: pt_regs: remove hardcoded registers offset
Thread-Topic: [PATCH 1/5] ARC: pt_regs: remove hardcoded registers offset
Thread-Index: AQHVvOAN1qgZJPSLVkKGs6eqTaXacafQC7sA
Date:   Sat, 28 Dec 2019 21:06:59 +0000
Message-ID: <a7a7e4a1-7be0-0cfc-15be-ae462b407b85@synopsys.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
 <20191227180347.3579-2-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20191227180347.3579-2-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [2601:641:c100:83a0:e088:294b:f4bb:3dd9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c946352f-c397-4226-15d4-08d78bd9e13b
x-ms-traffictypediagnostic: BYAPR12MB3301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB330100C4BC251046A0368F00B6250@BYAPR12MB3301.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 02652BD10A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(136003)(376002)(396003)(366004)(189003)(199004)(66946007)(64756008)(76116006)(478600001)(558084003)(66446008)(31686004)(4326008)(36756003)(66476007)(107886003)(6512007)(316002)(86362001)(186003)(31696002)(110136005)(2616005)(66556008)(2906002)(81166006)(81156014)(71200400001)(5660300002)(6486002)(6506007)(53546011)(8936002)(8676002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3301;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jlKBpaSQ7gShbj9/9mYbNIGxWwfWbWLth6U4onOJ4E8RqSIDBT4pnGXBnpH1kIxNL09eRpxkT/BzxCxV+8mL0DrkfLs3tWZY5VzIeEeXp2CyPOmDg+BcAwo0xa3Gzx8w1mIUaxNjq3y7dxTqrfuSuTKGYW/kflszc9Rr4d8EB/8NlheslhPHqutgtpTFwPugt+UO/5vNVktu/bsQ9VsebC2YePE1XrOV/tNDwktO7Sg+TyNXQ2ypaxeutiSg4YBO7S8zUG/npzRIBzc6OwR5rvZnGjTFLIPpE2rWAQ4wwobBTukJ4z+GP9yOScFfHrzdxqGdIynnOLAMlicNmviER9qRlNSaSd7Y6nBb22EZJ705xgHz8Lg9SfoxXDYKWb2KnrDFIIeAD3owbKz5ZNPkgQaqiDyykPkS5+TRg0vXWlEHZCWgN1Fq17a5DsOgNabK
Content-Type: text/plain; charset="utf-8"
Content-ID: <043ED1F3F840B643A151166F2EC38CA0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c946352f-c397-4226-15d4-08d78bd9e13b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2019 21:06:59.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+wAkxYFGEnHVW19Z5kbhaLJ30wWq+7NuLWrMxN3YOxviE9wsXeCC4U6jYiKuuCHzEae4yRS5wuKbWrE4yW7Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3301
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjcvMTkgMTA6MDMgQU0sIEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gUmVwbGFjZSBo
YXJkY29kZWQgcmVnaXN0ZXJzIG9mZnNldCBudW1iZXJzIGJ5IGNhbGN1bGF0ZWQgdmlhDQo+IG9m
ZnNldG9mLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5IFBhbHRzZXYgPEV1Z2VuaXkuUGFs
dHNldkBzeW5vcHN5cy5jb20+DQoNCkxHVE0uIFRoaXMgc2VlbXMgbGlrZSBhbiBpbmRlcGVuZGVu
dCBjbGVhbnVwIHNvIGFkZGVkIHRvIGZvci1jdXJyDQoNClRoeCwNCi1WaW5lZXQNCg0KDQo=
