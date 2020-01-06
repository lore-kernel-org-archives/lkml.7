Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE87C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94622072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GqGQM3dg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="mfVWvSRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgAFWsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:48:04 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:39238 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbgAFWsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:48:03 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BFCE74061E;
        Mon,  6 Jan 2020 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578350882; bh=I34Vuj0QRIGbKPL0pKOMwcUltMxx9AXBZE5wSUt/oYk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GqGQM3dgFhnfKsq26G8neiumCQAIhOa9wTBUMqTkDGRaDZb5iIEhx9GjgRFGp4WyB
         PJizy8Cx0lyhUuD8x4tPusCGGXOWvxL50iAehHfA+YSyKam8/lBdPRRxCmDg711rVT
         6/0DITXFUluITyEtgecz8Ysi+wJvpaQ5V7e3LjTDzf2TMyDXcgto3Ky09ehw5vyvR0
         caIcx7vJDbQpfYI0CT8PEeX4YBuPU8Ln/zndpvNe+t0SH0J3xZKxyslR7dLZyTOcQc
         u/jf9JZkYapVTgdKKturOcmhXVcdI5uyuuJfQoSdEinDic1KN5caeiMGXNDa2CeWGF
         XgvrJ4lQmjNOA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F39F1A0079;
        Mon,  6 Jan 2020 22:47:56 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 6 Jan 2020 14:47:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 6 Jan 2020 14:47:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXMYZBkLMxMwXOiX13Rh8LBl5FQ3D/t9fs6Ws37srAq06SSMRDJivE4rlCO/88Uvlm5Xb2hzzG/8v73M8ugxfkzMfI7iOhFslGSTa8DZa3iWuaqRMzdqvlF0752ymA4Ymwfki3SgRedK6N5clQCOOpfkmJy90ehMU9hNf6ex2QvMGa2aLvGaj1rOuODBx2jOilt3Xz2rRH6THOV6fOt3977aQOTpg7KhHB/oGJAbuFNI2Rq3v3LyezMxMuHXkqy5rqK/woIYFRkBzvb0bcMphBn8RP142P38bZbcAhf7Plf8yuxd6QNwx/CsZO5BD1BGFM6ULNK0tHvCVjg2SabYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I34Vuj0QRIGbKPL0pKOMwcUltMxx9AXBZE5wSUt/oYk=;
 b=bFiig2IYnh03SQZPlwQTatyWqGCRbU68W3rCQ+iFgZLA7EESvBc1JPI5dCzphTgDkzEPsW2AYOFICLhIisRAAuUCFkrtfVKhPc3ll7kue/hC2fcbPkK6of+6+pait4vH/8KuPZD3MJNqapP68rfyMq/Yan52GXbxTm0xyTtrr+gX3vtvh2p6y69D0tCIve5qe750BsOvf0Uu7mBtuhXHNFWbYCAQhBSTTdLwiromWFx5TXpBAQJnAyfAs3NoCTN6O1qV8ARZ3fE+ccI3IpCwZDfi7u7IPSuP1x+x0O1tVhyvUIEOwZUCllnVj/JXkMSO03J68tVWteLAkRz2MZxxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I34Vuj0QRIGbKPL0pKOMwcUltMxx9AXBZE5wSUt/oYk=;
 b=mfVWvSRgyFBm11mtaMRyCeKvjHr5s2frSpO+AZ1lDSYP5xcobes8jNwSEk2581kAPUOue9Z6W+nhawPSYHd7ENUk9Qg9fnFkACElAyTvDiKKUvgMFnXF5uyGbproF/kq3WA2c6QTcajjMHTODJMUt/Fdwubo9B78F64IG4zfyC0=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB3447.namprd12.prod.outlook.com (20.178.55.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 22:47:53 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2602.016; Mon, 6 Jan 2020
 22:47:52 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 2/5] ARC: add helpers to sanitize config options
Thread-Topic: [PATCH 2/5] ARC: add helpers to sanitize config options
Thread-Index: AQHVvOAO7wf+wPt3UEi3VhODY5PjP6feTOiA
Date:   Mon, 6 Jan 2020 22:47:52 +0000
Message-ID: <4767e2c5-b93e-d672-35f3-917bd009aa2f@synopsys.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
 <20191227180347.3579-3-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20191227180347.3579-3-Eugeniy.Paltsev@synopsys.com>
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
x-ms-office365-filtering-correlation-id: ae1f3314-fd06-4a26-2ccf-08d792fa76db
x-ms-traffictypediagnostic: BYAPR12MB3447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34476EB17FE261DAC3C6F9EAB63C0@BYAPR12MB3447.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(8676002)(81156014)(316002)(81166006)(6486002)(6506007)(53546011)(478600001)(558084003)(31686004)(5660300002)(110136005)(54906003)(2616005)(31696002)(6512007)(26005)(76116006)(36756003)(2906002)(71200400001)(8936002)(107886003)(66446008)(66556008)(4326008)(64756008)(186003)(66946007)(66476007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3447;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yb/7soGg7YvtX+rgNkzErIxQraOGI5TokQ3eEIpCWm0DI+kXe6++QuvZldCHOFasU2KBdxSGsVxIicee45arYL9lbgL4NV7SKrRL2oSJ8NmRDfeH3V/ach0D2Vo5ctGDFblYk/nSrvvXkvC6htWDBNz3iqF8dIL+ggjcZQf+8sZyaB+wdQei0pNfrR3ASrJt3s0E6FiHzswXFGICwZlme+bXo4LDTpmJ33GjYHghZddRewT5eYSV0wsggsHWtykzieHQ7pgjsZZpgHJpt/RyjuRqsnUelAOHt4gZnqhKYkNxA6UCws/y/eaf8M6wW6+WLVy2KW00TGsjFjbMngcHxcZqxUyyR4JEz8twwd38gT5w8PybTlFyF7uMVQK1k48xVQ/Agq4hohLLLX0FDrC3rxYKRI6UGltlJF3sPYZ/i28q6ChH2xrGmeq/sQM2ZlYi
Content-Type: text/plain; charset="utf-8"
Content-ID: <F37888D55DEAFE44BDCCB3F6B0CAF14A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1f3314-fd06-4a26-2ccf-08d792fa76db
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 22:47:52.6251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWoIXGAXU15XvlrYlf2P7DhZeLHMRA+FpZh/zGQddqOAJqEGoLu2CLLs+T5ecveN9RQLL1ZE7Hn2J43gE2E9RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3447
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjcvMTkgMTA6MDMgQU0sIEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gV2UnbGwgdXNl
IHRoaXMgbWFjcm8gaW4gY29taW5nIHBhdGNoZXMgZXh0ZW5zaXZlbHkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBFdWdlbml5IFBhbHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5vcHN5cy5jb20+DQoN
CkxHVE0uDQoNCi1WaW5lZXQNCg==
