Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EDBC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAB8206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eybGyhAY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="cM6dS/Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfDLN0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:26:31 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:40840 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:26:31 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 3207410C29E6;
        Fri, 12 Apr 2019 06:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555075591; bh=AZzdsC6ppyPlPnImu1exntzOPuMZZo7Il7wmWHzLPn8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=eybGyhAYyd96nsuNlQ1uw7dVYmQyz4ZiE66OAOkbqyCgeX6FAgk3NooeBna3rgEcH
         TSJmV7pmZUeQG16+m+laGWQovZqx90tT+9Yr3oK0aqs4PO1QBPdzqbfs0FWw8EXYue
         RYDI1Zf4GIq3WDtTglloEYVrWzjGLk41jyjAXJ0hSA7/LVz8pQvK7xPSXAgzYXeZxu
         X2zifMljpg3p8UunZwurxA5JHxCcGkegkHkE5jPW9jey31/paOLLF+ZDqasMJrsEjW
         gRd6vnXEDLMuBEd6ZpzxBUCo9YeIjX0wtMG70yZa0FoaRfXf/AJ97hyEz4+/vwdqJ4
         kCZf8WRmCbG2w==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 98499A0259;
        Fri, 12 Apr 2019 13:26:30 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 12 Apr 2019 06:26:30 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 12 Apr 2019 06:26:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZzdsC6ppyPlPnImu1exntzOPuMZZo7Il7wmWHzLPn8=;
 b=cM6dS/LriaN9N+kHteE7fbgm4NezS9gwwiInmUOC+nhNJt6JN+zA9j+szoQ0stI4339DJ+bd7fcw5k6KppMf05grauPPNEb2mOxXrixJtib9KIgkCQ0KrhWtw7E1RCBv5q89oGKc9gVqv5FPGZWMXwT+eihLCbwhyu52zWf80Uo=
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com (10.172.116.10) by
 CY4PR1201MB0056.namprd12.prod.outlook.com (10.172.78.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Fri, 12 Apr 2019 13:26:26 +0000
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::1466:86ac:f4fd:6767]) by CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::1466:86ac:f4fd:6767%5]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 13:26:26 +0000
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jose Abreu <jose.abreu@synopsys.com>
CC:     Joao Pinto <joao.pinto@synopsys.com>,
        "nelson.costa@synopsys.com" <nelson.costa@synopsys.com>,
        Luis de Oliveira <luis.oliveira@synopsys.com>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        "eugeniy.Paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        "jose.abreu@synopsys.com" <jose.abreu@synopsys.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>
Subject: Re: [PATCH] reset: axs10x: Implement assert and deassert callbacks
Thread-Topic: [PATCH] reset: axs10x: Implement assert and deassert callbacks
Thread-Index: AQHU7fZSnbQvj+gxfk+DCceWR2xQe6YyHxCAgAZrqIA=
Date:   Fri, 12 Apr 2019 13:26:26 +0000
Message-ID: <1555075583.2668.20.camel@synopsys.com>
References: <33ed7b90da8439aecb3544c3ff7dcfb511e03b8e.1554457026.git.vitor.soares@synopsys.com>
         <78EB27739596EE489E55E81C33FEC33A0B44FBB5@DE02WEMBXB.internal.synopsys.com>
In-Reply-To: <78EB27739596EE489E55E81C33FEC33A0B44FBB5@DE02WEMBXB.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [5.18.205.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51d0ac42-bab7-4376-193f-08d6bf4a76f7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR1201MB0056;
x-ms-traffictypediagnostic: CY4PR1201MB0056:
x-microsoft-antispam-prvs: <CY4PR1201MB0056FDDEC277E2393904C695DE280@CY4PR1201MB0056.namprd12.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39850400004)(189003)(199004)(110136005)(102836004)(8676002)(81156014)(66066001)(106356001)(71200400001)(8936002)(256004)(7736002)(105586002)(5660300002)(71190400001)(4326008)(6116002)(97736004)(6512007)(3846002)(81166006)(14454004)(2906002)(316002)(4744005)(86362001)(103116003)(186003)(6506007)(26005)(478600001)(6486002)(53936002)(76176011)(71446004)(6246003)(476003)(68736007)(25786009)(99286004)(6436002)(54906003)(2501003)(446003)(486006)(36756003)(107886003)(6636002)(11346002)(229853002)(2616005)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB0056;H:CY4PR1201MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hb+/vxq0/1XiqKiE5CvmwgVVsm+5K+MvYEJncNgKB011UXFvG7bOavJR4NjVB1DQYUnuGTaYkJukJ2H8zs7Moj6xD89843exGgyAkMishQnrg9lA+qnGKEHKSui8ezO8N5P8Q83o36KBrWrIEcq1GTfCEWKq+oHGGjuC16plKzOcE+Y8F58/wz3a+TuB+GWcJvEduSVZ2a5gj/OSygS3yRby+h1+7gO51vXKmMUJ8+9JdID/TsAKCuQcK6JQwSxzhlUwx9akN4EMDnHfqtf9JUCQ+6BHCAmg0SvgBXGSYqlACYzEzU8+w7/zKebpYH3CMrAYDAn0ZLTv9BcOq3ppXsiOEAfde2XmGfUkdMMYdO5ArzADQ8jEhYZ/3fAwgkUpcU4FlNjKeTjpj03GWcKFKv15eD8/DUArEjNvgWT3UkM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <616D4A5CEB6BA2459E2D823B0222315A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d0ac42-bab7-4376-193f-08d6bf4a76f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 13:26:26.2673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0056
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9zZSwNCg0KT24gTW9uLCAyMDE5LTA0LTA4IGF0IDExOjIzICswMDAwLCBKb3NlIEFicmV1
IHdyb3RlOg0KPiBGcm9tOiBWaXRvciBTb2FyZXMgPHZpdG9yLnNvYXJlc0BzeW5vcHN5cy5jb20+
DQo+IERhdGU6IE1vbiwgQXByIDA4LCAyMDE5IGF0IDExOjMxOjIzDQo+IA0KPiA+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IHJlc2V0X2NvbnRyb2xfb3BzIGF4czEweF9yZXNldF9vcHMgPSB7DQo+ID4g
LQkucmVzZXQJPSBheHMxMHhfcmVzZXRfcmVzZXQsDQo+IA0KPiBFdWdlbml5LCBBbGV4ZXksDQo+
IA0KPiBJIHRoaW5rIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGlzIGNhbGxiYWNrIGlzIHdyb25n
OiB5b3Ugc2hvdWxkDQo+IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB1bnRpbCB0aGUgcmVz
ZXQgYml0IGlzIG5vdCBjbGVhcmVkLg0KDQpJIGRvbid0IHJlbWVtYmVyIGlmIHRoaXMgcmVnaXN0
ZXIgaXMgcmVhZC93cml0ZSBvciB3cml0ZS1vbmx5LiBJJ2xsIGNoZWNrIGl0Lg0KVGhhbmtzIGZv
ciByZXBvcnQuDQoNCj4gDQo+IFRoYW5rcywNCj4gSm9zZSBNaWd1ZWwgQWJyZXUNCi0tIA0KIEV1
Z2VuaXkgUGFsdHNldg==
