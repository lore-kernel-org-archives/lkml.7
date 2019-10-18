Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891FDCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EB5222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QJ6HTaeX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="MfCiQAY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410400AbfJRNkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:40:15 -0400
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:39674 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728150AbfJRNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:40:14 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4BE79C04E0;
        Fri, 18 Oct 2019 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571406013; bh=eSjSarEYqzCudYdliRE65eV9ZdFRaJInICEnVW/D12Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QJ6HTaeXJREclPsSeGJx8iCTfPn6RCCEnuVAlA1ubSclWAp5nJQeaEBysAvK0TGRs
         mLz0t3NW+VWWN0q25yeiFRs1YzAmltsiqDCu/4FRi0WjYOYFEJhxHdQUpFIYF6l+Oe
         aJ80FnEPVQWKXk42FJ0JPAT2cAWROd6PPuqDOa3DF4/oZmcsII1AsDA1DPHV1PlMbt
         w1q5dR7y77SlVShrZE2y1JXdxfCdbgjuQtuy5mzajk3xDXQXg7uccCWYpXwCkGPBoF
         bA7YUSAHpxxXPUVldoe7+mBcXJNKRYvJq65he4ydq9kI0dA/77I49pTx6Q591zoiK1
         Kus2osDlChbvQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 90AA6A00B1;
        Fri, 18 Oct 2019 13:40:10 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 18 Oct 2019 06:39:59 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 18 Oct 2019 06:39:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpIDJ39vSqB0Mib2DDyRBKBPDwoUjWfSzMJFt90nFy3IvC4GJiEpHy3Hw2YVGUfhKAyNqLY71CNdtKIK8I0THo7NN2Wly3scgomX4IkDk1LQq6D2wBayC+Ag7Tr60/PGLui41Vpt9PcB+R0T1J6BjpabfkPzY3g67x9neCZYbQVOndtfn8vsclrch62vfz1vDXsF/u63q9ihuwnZyjKQk75NSbeMAFEmMjZg6nXPr3sU3q19e0Y9ngRb2vXfxXmYdqnfFuOZAH0CFoerlh+ZLogQOFgbmdPGhwaI4sRQv4bH0d2uNNYPkR9CFhM8vKxjXRdPnnKxjxOK8CXO34il8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nzy07Sl5No2tfxlRmRiJzntBM8Euj38wUaxODsFYSWg=;
 b=cJrHucRKzRbAT0E23WyuB8iHnIUUwk1DgJIuJqXJ+JluQOY7Z/Lxrs4adp9ELTCBQRS6lVx7L5WEIiUZaXY69zbXePHfvCrcOgeXqGdh+ADPPCvXsa+nQxX3Gaog7VeQ5Km3IJ3cdFLxLq7V0VzWmV+6SLB/TX3r88zw6RNyP5Ui5vc29em47EN4q80lCv5OhfEHrlOVUy/k2yYO6xR7WWOflB08RxKVoFyugDxKn/tEjv2T0XH9Nh1Sna3Vc9ro+pt1byQVjt4eeKym/SCdw27SdWJXUBezdx811BDliGclU115JLuMrAwCA1UZwLL2KKfeg0bKQj/WZrKOOL6++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nzy07Sl5No2tfxlRmRiJzntBM8Euj38wUaxODsFYSWg=;
 b=MfCiQAY7sBIpMHv+zlqlq6zUQlidY764tp8jyFKzOHTaoj49k0R6VofPo1eITFZ0NxZgHuZpldlHYSCJu8tAftTUHoineD76HDT+sURlcWwysea68TmR7U84Cl1Bz4QplxXLFpgZQi36b4IDz95PF7IJNsLa1m7yrGKLsppZM5Q=
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com (10.172.78.14) by
 CY4PR1201MB2502.namprd12.prod.outlook.com (10.172.121.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 18 Oct 2019 13:39:57 +0000
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::1487:2d87:9871:3e4]) by CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::1487:2d87:9871:3e4%11]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 13:39:57 +0000
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: RE: [PATCH 0/2] ARC: [plat-hsdk]: enable on-board SPI peripherals
Thread-Topic: [PATCH 0/2] ARC: [plat-hsdk]: enable on-board SPI peripherals
Thread-Index: AQHVhaTg8279/2eeKkqnMTlyr8U2/adgZkNA
Date:   Fri, 18 Oct 2019 13:39:56 +0000
Message-ID: <CY4PR1201MB01202F391AB9CEE0768C1679A16C0@CY4PR1201MB0120.namprd12.prod.outlook.com>
References: <20191018111126.5246-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20191018111126.5246-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abrodkin@synopsys.com; 
x-originating-ip: [188.243.7.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c815f853-0ce3-4f31-ff9e-08d753d0aa45
x-ms-traffictypediagnostic: CY4PR1201MB2502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB2502E91134F5FD055A77E772A16C0@CY4PR1201MB2502.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(366004)(396003)(376002)(13464003)(189003)(199004)(76116006)(74316002)(33656002)(107886003)(9686003)(229853002)(66066001)(7736002)(6436002)(305945005)(6246003)(55016002)(6636002)(54906003)(14454004)(478600001)(316002)(26005)(256004)(5660300002)(66446008)(66946007)(446003)(3846002)(64756008)(8676002)(86362001)(7696005)(186003)(71190400001)(76176011)(4744005)(6506007)(25786009)(476003)(99286004)(53546011)(11346002)(6862004)(8936002)(66476007)(4326008)(102836004)(52536014)(81166006)(81156014)(71200400001)(2906002)(486006)(66556008)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB2502;H:CY4PR1201MB0120.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xt/TJmcstQ7Rds7Scjatw2hq4Fz58grvhrECwTowODS9XM/P+Uifrz1o9Ydx5grqa/xaBqzGyBhZeF+LM9wPiaERJoZm9e6On+/y3OFAh6EZjkICWcv+k1j68TPfvoA//Xn2AsICQ280evrdlNVnWcYfO8ayAHN+OJ92k4m7jaq7TUp7ux9M6h2P1cmp6BkK0HaNVXDIgqu6LzK8NJ4Ou3npXBR0Gq9WYt1hODW6JfO9mU7JHhPdItHHyrWBo1amfjoJ3ZhjpP2l87qdpLaFT8YwtuGTuUkOgqG+hU7HzIFEK6Fo55NvqqArxkzPIjYbYNGPGtlxFlQeKHj9MMY/+opVlsD2XJQqpvFkxPrqUlVSpCAuQYIT5VsCThxKD/Ex+EfvQM5JeJkhhLsvMBWuuPl3FZIn5l56TzLTY0Pt6m8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c815f853-0ce3-4f31-ff9e-08d753d0aa45
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 13:39:56.9512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pu+wDPn/GX7a0eWCKZBgIWYyQYts5sr4PY9AB4CA7XYZcUjUGXu9JLUYN3OYc9JJOdn5+T1/DihBvXkrBk2PGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2502
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniy,

> -----Original Message-----
> From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Sent: Friday, October 18, 2019 2:11 PM
> To: linux-snps-arc@lists.infradead.org; Vineet Gupta <vgupta@synopsys.com=
>
> Cc: linux-kernel@vger.kernel.org; Alexey Brodkin <abrodkin@synopsys.com>;=
 Rob Herring
> <robh+dt@kernel.org>; devicetree@vger.kernel.org; Eugeniy Paltsev <Eugeni=
y.Paltsev@synopsys.com>
> Subject: [PATCH 0/2] ARC: [plat-hsdk]: enable on-board SPI peripherals
>=20
> HSDK board has SPI flash IC and SPI ADC IC. As all SPI-related
> blocking changes/fixes are finally applied we can enable them.
>=20
> Eugeniy Paltsev (2):
>   ARC: [plat-hsdk]: Enable on-board SPI NOR flash IC
>   ARC: [plat-hsdk]: Enable on-boardi SPI ADC IC

For both patches in the series

Acked-by: Alexey Brodkin <abrodkin@synopsys.com>

