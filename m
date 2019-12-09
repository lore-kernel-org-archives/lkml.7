Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB82FC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67787205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GgZum5aS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="d3tfsAmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLISl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:41:26 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:51202 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbfLISl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:41:26 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 88483417FB;
        Mon,  9 Dec 2019 18:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1575916885; bh=q8MezLNvf2MF9Eh3NX+jiib3UeVtgON3GRa7V4x8Y/Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GgZum5aS4rUAAeInVUJX5A86Lqb5tppK3adNqFF3Urscjxr/hD4lQuZZDAc6M2Aqe
         5wI0YrasNuthOaEDJHPzwNxwPnhfmGHgfJsTBWwhR15Z+YURbnYmXXWbmap8ieQTvt
         6tkVPXrPc/1AoCKT99MfkvlHAtbY7MJ/3ybLseuOEg7hU3Tx6IfpMIGMQK0nn4zgCk
         WBQEgOk3yH35y5Gl2QfiqjzTbfFtiE9jqwS/VVfOgdf56Pd0X7aDGw6oc6cekJANII
         GlhxITiwFRHMmH1rp1AM1WVfi6t9/VAwIjH7IjeMPdbJxeM0scLbzDOrAI9WhiCitz
         I1P/EYn5kmlDg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DB235A008A;
        Mon,  9 Dec 2019 18:41:17 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.13.188.44) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Dec 2019 10:41:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.13.188.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 9 Dec 2019 10:41:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhHiFmpuF1dnlb5ATB/7PmjyLD/PIENqpO4XLKOeH7ZReekob9gCWBUSU+vGXsA9ysnmE8awBRiqkzXFt+Hbytf+WWgq7eHcvI8eAroM2IfUecHfXTj9/2XlLTKv2yfq1NXPPccm8fWzq8IEdDQGn9batoRr/iqekY+VZKY6lckzaKrWTUats470JLicAF7+WR/nHw0SWQdq9uGPhxU93tABcsZAgjM6g1nuTSfxx692nEkk5FGMOkBbeRZSyPiUOdTLgqTFIu7TknCH1PDJQdOV/0YqTk8Dl0ZLQ2Lg+pS9tDIX0uvu7GyUzRpuyQE49cQcBNnvcQrim3mJDF2xDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8MezLNvf2MF9Eh3NX+jiib3UeVtgON3GRa7V4x8Y/Y=;
 b=aEtefpqh9Vq0mUIYdFkysBJ8fq4sbMPHzgM92E+XEIWoAtIWXTr72txx4zAJdVV4S19TA04yn3iSIjji8Ysu6OvkfJaWvg7PBeJU7IhN8wAo+Z8kzUWoajEVytHNhL14wzZAcNWYmT3ila66tgSkp+o/pUf6oFNrm0TvEYGoEDnymNfP0zhsWITk4981YaIQcNKpEj/Vp46OVso9AImtCfxt7WicvlRtoYHAN8iTfkNvdmmgobhiX/V2kcV9zYx+s9Pcu69bWdproIFoSchY/9pr2/wQOFH1tZfhUvraQ/XbBxEyCOMD6LHcz0xUVKoBQgq6epl5bdWMGliy8XAWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8MezLNvf2MF9Eh3NX+jiib3UeVtgON3GRa7V4x8Y/Y=;
 b=d3tfsAmrdSbwjNlfTefoZl9gtuNs5YSTyxownVXRAZUC6bgJP6r2uLOAdubAj4jmzvUsD/lLXsHt+g+Zokbek4vD9l4nnFMpi2D7SSI7gWew6fBka+3og+Sz1GRsnN1K4MnBgw5e2Sx75OvKiM6J2yWsbSYbc5GEbXzc3ken2LM=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB3206.namprd12.prod.outlook.com (20.179.91.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 18:41:14 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::19d8:78d:d881:c8ef]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::19d8:78d:d881:c8ef%5]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 18:41:14 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] ARC: mm: drop stale define of __ARCH_USE_5LEVEL_HACK
Thread-Topic: [PATCH] ARC: mm: drop stale define of __ARCH_USE_5LEVEL_HACK
Thread-Index: AQHVrqXi8ZmxvbzK40K7w4J0GZAyJaeyIy2A
Date:   Mon, 9 Dec 2019 18:41:14 +0000
Message-ID: <e72526a5-e87d-ebd2-11f1-d639818f2417@synopsys.com>
References: <20191209153135.22475-1-rppt@kernel.org>
In-Reply-To: <20191209153135.22475-1-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 590371c8-89d1-4752-b8ba-08d77cd75ecd
x-ms-traffictypediagnostic: BYAPR12MB3206:
x-microsoft-antispam-prvs: <BYAPR12MB3206DC2F20B0777966CE49D6B6580@BYAPR12MB3206.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(136003)(366004)(376002)(189003)(199004)(76116006)(66446008)(66476007)(66946007)(5660300002)(66556008)(8936002)(305945005)(64756008)(2906002)(81156014)(86362001)(229853002)(26005)(81166006)(8676002)(6916009)(6486002)(53546011)(186003)(36756003)(6506007)(2616005)(71190400001)(71200400001)(31686004)(6512007)(4744005)(478600001)(31696002)(54906003)(316002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3206;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8w1PyRQEO0UYxYSIOu3tLf6fTtX68SOuVUW0cvvsv93105j+gDfZtSnwnMOHBslJX7aSqwrtSR8d0ljwJzNz/DKUpng/U42aUu0cZK3klJjAqDO3JJc66GhLl9APMMle0FkpOGnCq130dgY9gAkDR9Va6jMVHjVSRacr2m6S++E2EH8Bz/geGify/4d8Dt5Ope4i4COonJl4xIBHBxdRrTfktOWD07ybKpXk1pDVn6rEardvYYI3ZkQ2v80g1TZpuiFnSEBxEXwRIumJ6T1QQ9BTEvnDE3GluQVW+LQjAHdZVhywgYKAlHlScBZrQjj4HmuHgC40TOhUM6x/wEXlpeAWhCsf/9VXYS/i5JGdxdT+1rjtNdclmylhTFsxsXTEwRCBMPbwKDsLjLeQvGOIUi2v129QHdQve1k6ySB8SG66c7A8Iaw15drQvsNG9pPr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E02D01F74E6C9A46B9314A32F1F63FA0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 590371c8-89d1-4752-b8ba-08d77cd75ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 18:41:14.5578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPL36f/KaiXHoGHcvMYvA0y0ue/eXGsxtNxM6/W/mG/KeiGapLfry2CIZ6s8psnISYQMj6ItH4pX3tRpIu9YyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3206
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvOS8xOSA3OjMxIEFNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBGcm9tOiBNaWtlIFJh
cG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+IA0KPiBDb21taXQgNmFhZTM0MjVhYTljICgi
QVJDOiBtbTogcmVtb3ZlIF9fQVJDSF9VU0VfNUxFVkVMX0hBQ0siKSBtYWtlIEFSQw0KPiBwYWdp
bmcgY29kZSA1LWxldmVsIGNvbXBsaWFudCBidXQgbGVmdCBiZWhpbmQgYSBzdGFsZSBkZWZpbmUg
b2YNCj4gX19BUkNIX1VTRV81TEVWRUxfSEFDSyBpbiBhcmNoL2FyYy9pbmNsdWRlL2FzbS9odWdl
cGFnZS5oLg0KPiANCj4gUmVtb3ZlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWlrZSBSYXBv
cG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KDQpJbmRlZWQgSSBtaXNzZWQgaXQuIEFkZGVkIHRv
IGZvci1jdXJyLg0KDQpUaHgsDQotVmluZWV0DQo=
