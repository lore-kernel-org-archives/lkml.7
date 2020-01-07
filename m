Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC95C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA8C20715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hJODXGP6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="pV8ZDXNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgAGBaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:30:21 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:54148 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727295AbgAGBaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:30:21 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3FFDDC04F7;
        Tue,  7 Jan 2020 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578360620; bh=HRQSsQ4ZABx5njFb/HyohwEh5TMY/G+AOqZDPr46LXE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hJODXGP6SOizmVzPwpHFVfCq3DQ9l4fC4BEQX4WZQY5q7DIu2QX9XX5mHI6cP7lct
         I1Sie8wm1YLNuMBA1WImJAOg89reR5KUle0UNxpO4nH9dgqDumxYIl1HvLA+jxDsOi
         xXT/b0h4EFKq/X0Wm07QXIUuKW71R/P/cfTjab3SjphTLA5Dxe4ontC1RuJhDnfch3
         ylOpBaG0FRZ+hKjo7d2alwgDwnWsmW9woPHsX0TB1drILrCpKAKJXGUwxKygOTeMgO
         I50KJeFIkMjR1p91NlA37IHidkWJ44Bva1sv4ewj2YWQ88IVZhZl4vi+TnfUdjdCp8
         +udI+BEtcTxnA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 13872A006B;
        Tue,  7 Jan 2020 01:30:20 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 6 Jan 2020 17:30:19 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 6 Jan 2020 17:30:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8VfppnGgKDTX8fdyrck8U5MjNhGVPE6ZXYLUvTHR4FO6se9q/KwtcWZ/Ejg/WwZ920ktyt5+R2/Vr86e8AObnw8HLTVt83aeCDUIiQ3z8CZ3H84c3sBdUjz3z+/FC1tu+5ZzPod6tDliPfREHU49yAFNP8g8kfukpAsEENhpLpXStb5E6euTAF+tCVmA9QYyOCZw9buOs0TetNAGzDQlRK4W1n9RSx3i+8WTgS2/gcmAbjwLxMFw0aqoUsLyxu3wc8SltD9lG9uHiEbPnLYJg0FT8BG933XdALQ9rDhDlR1tFNdaWUGRXngOhES/DMUgJnsl5gbdtS7mCur8heQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRQSsQ4ZABx5njFb/HyohwEh5TMY/G+AOqZDPr46LXE=;
 b=OgkLf5E+hDnPHjNvV8J7o2gKsC5Z2AvgeIKZrb9kzeUyPdaSTZskNsKXH/8h3B9K4gTij2gdijihndUnw4yWU6llKjnCpCra2saf7wpxZEcp+L8GGzflpoNQIzHHjMGA554IPCqJyebnWDyma720sSCoffl7c9+ZDuj7LRQSCHxM7TIIJ0TjFMO4tCXw681+7bAwGMClBpLVCUi4NHSC0i04taezY/XXBAble/iiLc9QhwJnhwGcT+33dut/FK0NyuUofAw4NcGt4O4pJ8hx3IFuXPbnLXA4GULzMgcM+QbOax8enTFMOMo+zb1lMb7dahsoxfCpquCJxwxJ9fx1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRQSsQ4ZABx5njFb/HyohwEh5TMY/G+AOqZDPr46LXE=;
 b=pV8ZDXNw/KkT2SX1vy16Bcx5hD8e8jO8LzqcWOLTsiozvVahiS7c4OTenVDVTViJHSjTwrtnFWgO7GxoU06eTbtQlw/EIPaJlXWPLzLXmfzUKrxVoJ5v0nJhQYLo61pWgFEIC4uxJU4sqXwAbLJ5Jv7QHmZxymf5dbaJhjRI47g=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB3175.namprd12.prod.outlook.com (20.179.94.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Tue, 7 Jan 2020 01:30:18 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 01:30:18 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] ARC: handle DSP presence in HW
Thread-Topic: [PATCH 3/5] ARC: handle DSP presence in HW
Thread-Index: AQHVvOAPR1zSenMpqUm+DVM4mBlrGafecrQAgAAHlQA=
Date:   Tue, 7 Jan 2020 01:30:18 +0000
Message-ID: <c261aa64-d15c-ce5b-4202-beeaca80f7b9@synopsys.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
 <20191227180347.3579-4-Eugeniy.Paltsev@synopsys.com>
 <6b80df9d-d0f2-d1e1-8e4b-b65531b938d9@synopsys.com>
In-Reply-To: <6b80df9d-d0f2-d1e1-8e4b-b65531b938d9@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cb74c68-d576-4250-bd61-08d793112793
x-ms-traffictypediagnostic: BYAPR12MB3175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31750538BB6441C5E5E38183B63F0@BYAPR12MB3175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(316002)(4744005)(54906003)(110136005)(2616005)(2906002)(76116006)(66946007)(4326008)(66476007)(66556008)(64756008)(66446008)(6512007)(26005)(86362001)(71200400001)(8936002)(31696002)(53546011)(36756003)(6506007)(6486002)(31686004)(8676002)(478600001)(5660300002)(186003)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3175;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CY+Cn0mHQTOyCjraM3fwu/71WB1yalgamICQiiHrQFAoeqq6QtnTl/dAW3ZHt0JEYRP/1CEykkN1RdZO3yjjF7xUqZMxwCHeqJADzImuN/L6MtmPqma+OTB9U0Wu8F6iwO0QizHvvKjDiaDhKVScDuooq7fCbvwJHY5XfRF8UJNOvI1CBM/QnUq3SeaGxLm6B22G0xNV/zmx1IQMsWUdXMuV445/awsP5GfDl5lPbCGD3Vy22OXoo56OTIDEfQxVA94ruJ/XZzdPwNupRQHc2gReD5UxrwH2dTziR5ZRBujz3JqUCws9emKQkxyQfG0Xz/homZI4OGCiWp132d7qFF25gOOB0nFNUq0Sa318GmUrEJlQjTsbPyep3sN4otmOa2M+P6QnykHjK+vWp7/g31pmLxYGZ5RWbNt2HabhG2zGYMhIkDftot/aDq9iVWCh
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D16D6E9874D514182E877A597D14352@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb74c68-d576-4250-bd61-08d793112793
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 01:30:18.2426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoPijTLbcT/8bj5DHLfHIjU5N3boZR22jB6p5NrZDMMF+H9IXB6tarDU+6LfDpnssp/rFszQvyWHqBSgc6fH6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3175
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS82LzIwIDU6MDMgUE0sIFZpbmVldCBHdXB0YSB3cm90ZToNCj4NCj4+ICsubWFjcm8gRFNQ
X1NBVkVfUkVHRklMRV9JUlENCj4+ICsjaWYgZGVmaW5lZChDT05GSUdfQVJDX0RTUF9LRVJORUwp
DQo+PiArCS8qIERyb3AgYW55IGNoYW5nZXMgdG8gRFNQX0NUUkwgbWFkZSBieSB1c2Vyc3BhY2Ug
c28gdXNlcnNwYWNlIHdvbid0IGJlDQo+PiArCSAqIGFibGUgdG8gYnJlYWsga2VybmVsICovDQo+
PiArCW1vdglyNTgsIERTUF9DVFJMX0RJU0FCTEVEX0FMTA0KPj4gKwlzcglyNTgsIFtBUkNfQVVY
X0RTUF9DVFJMXQ0KPg0KDQpUaGlzIGFsc28gY2xlYXJzIHRoZSBzdGlja3kgZmxhZyBEU1BfQ1RS
TC5TQVQsIGNhbiB5b3UgY2hlY2sgd2l0aCBEU1AgbGliIGZvbGtzIGlmDQp0aGV5IHJlbHkgb24g
dGhpcyBiaXQgaW4gYW55IHdheSB3aGF0c29ldmVyICENCg0K
