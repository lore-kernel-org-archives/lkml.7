Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA31CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A7E207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DyrCEJE2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="O/G+cT+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbfJVSYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:24:48 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:47926 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727226AbfJVSYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:24:47 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8D0F8C0CD9;
        Tue, 22 Oct 2019 18:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571768687; bh=sH+Q4l+BTVpSsoGKeBHryxl+mw/F3DNXdrJGB3EzmKc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DyrCEJE2k3sIG8paemExmI4rk6QvV97yiXsKeNOHHQ1ioAN1NcBYmzOOKYFZt1PV9
         xXn77KQMV/tp9KfWllajC6Z4UqqCdRRD4OicsJUIyJeRhL2R6hvmriwpn0pzbL+ABN
         tkUPW2fPsAwa2GTpCo3IkkXHMvQeYZ5Mgw0oWYi7yfnqZYe+i5BZYFuZI1jjzCvZrE
         MaSEGMyjpuCPTFh5qussf9qGgdXkwfETAGs1fsm+AhlDSfSnrKzKrYSglkmaj65aW1
         P1CzLL8F/vAQUmoZFQHMA7W1zc8BxIMdawQFXxTvocFHLEenouxMlk3laOJg8UX2nP
         nVyV9t1aYj6Tw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 43953A007F;
        Tue, 22 Oct 2019 18:24:47 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 22 Oct 2019 11:24:28 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 22 Oct 2019 11:24:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRuhvq+ewspQr4LJYJ6GK98AopafIT8S7tHipMPo0ItJEDB0BgzLBGILbsbUVbKD8CGeb/OUd3k3AvLYkPKqnyJXDDyyD122VKxg4jn4nZK2727q9ePt48Fd0ui5bxlOKC9fE2I0yknksnHO7f/s4tUN3rcE6aZfNs9KXq7Ecv/ETK0O3nqeU5k6fR94Ilnjm6pa5Ip+tp47ZfAs2YuxbPo/tFF3rE+3qejnCJnvSoLxHQYJK0sH+IFYgNcGiX5zxNtaKP6aYREz/+Mare8QH7ROG5LHvzxiqRFkpkGecJ7ArDRu9mFnIod6ZSlo7ruh0n3n/9DTfuo5JFiU1MLJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elz2uWhhcPiq/dk2d1O+z0rCVEeAKeIjFizwxBRnkpM=;
 b=SHPNwvLUTDBf0OkBokMQsK5KLpANCTDFGQD8d6MTTQ92x+Z8EvOlempALHxY4Xf6suIOtpkg0u40gHETL7uDCDA/Kh75bNOQ8rzvKv4cI4KdIz+DuL1UgSyrY7tn/fbgrr6u7flpfm7mipROg5kU7ToLaKqYt/kMPCbm9ixyd7gEqLpMcLYardkaVxtj06XSYMW+2mP4+s6BkeN15oFVtbip+p9KYwOHYRyNn9ovN1nwWP/an647a7esIx0+ZisyqMWWsvqKlxL+iUe6Fjel1v1Vb13EnsuhRB+L+5BzSYJzXYdzcBOsMnj2wfDe230KyHq/uZ7stTW/gVPe2qPhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elz2uWhhcPiq/dk2d1O+z0rCVEeAKeIjFizwxBRnkpM=;
 b=O/G+cT+fPyI2Jd8mslHnbO5qq0kI6I4H5/hfFJVV4WH+BKpQQ6o0I2edp3qj/pPykUigqw7bgDuIeT4M6tDjF2C+d+HzvhaSU+bc8LJHLg12wh85gxUgeAMmlk4X4sXoUcpghzSFCWAnSnOWYz9ogrmvz4LmLa7Epzj//jmBOrU=
Received: from DM6PR12MB4089.namprd12.prod.outlook.com (10.141.184.211) by
 DM6PR12MB2763.namprd12.prod.outlook.com (20.176.118.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Tue, 22 Oct 2019 18:24:26 +0000
Received: from DM6PR12MB4089.namprd12.prod.outlook.com
 ([fe80::19df:560:b8d3:e1cd]) by DM6PR12MB4089.namprd12.prod.outlook.com
 ([fe80::19df:560:b8d3:e1cd%5]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 18:24:26 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vineetg76@gmail.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] ARC: merge HAPS-HS with nSIM-HS configs
Thread-Topic: [RFC 0/6] ARC: merge HAPS-HS with nSIM-HS configs
Thread-Index: AQHVha3ZXHlIwwLIZE2VERfslIAXqqdgvduAgAZA5wCAAABinQ==
Date:   Tue, 22 Oct 2019 18:24:26 +0000
Message-ID: <DM6PR12MB40897388883F4441C65E60B4B6680@DM6PR12MB4089.namprd12.prod.outlook.com>
References: <20191018121545.8907-1-Eugeniy.Paltsev@synopsys.com>,<8fd4f94b-c0e5-ed2c-ede3-5c4e77a5a0e4@gmail.com>,<BY5PR12MB4034AE62AA5C70794526A981DE680@BY5PR12MB4034.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4034AE62AA5C70794526A981DE680@BY5PR12MB4034.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fba49c46-c846-4a8e-e515-08d7571d11ed
x-ms-traffictypediagnostic: DM6PR12MB2763:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2763B09E8398A2992617E8F7B6680@DM6PR12MB2763.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(66556008)(229853002)(76116006)(3846002)(476003)(64756008)(54906003)(74316002)(71190400001)(71200400001)(6116002)(55016002)(478600001)(9686003)(33656002)(25786009)(66476007)(66946007)(110136005)(8936002)(446003)(305945005)(8676002)(76176011)(66446008)(316002)(6246003)(486006)(99286004)(7696005)(11346002)(4326008)(7736002)(81166006)(256004)(81156014)(6636002)(6506007)(14444005)(102836004)(86362001)(26005)(5660300002)(14454004)(2906002)(53546011)(2501003)(186003)(66066001)(6436002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB2763;H:DM6PR12MB4089.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dk5Jl4rdnMm+uLPSFlY51CkcIWJFdb93m58ogOb7TXZXpkvZy4ELMACNmNeiS88bUzkhM7alLJRq8c8egZH2OU2npRQ+l6toeDpkcIdFJml4gK72eO4e9wSnkM+robatMmb9lp4++6sY4PKmEErxb4XfMg379VzAq+HeexLr4iesoJOJCehS3CREeXcFmpU+xRTWg2AtZv+r5kqtb2k3WyWTB4V2NflELvuDJwB9V91ZJio+PEOqwzIYqpAOyhsUhLsd7fXhQ6SGegwWRopOm61056oToyjwt8lpnp4bCcZ9IXK/HfaALumnwcHSKt4ELlWAWyBvWOyvAPxDNJWIwV9i/en6oTepUaFA2d4mvwmwkJKl68jyi5Rj9FzKXq3THfHSXrtqB0dhL8jDET3uZE/PiSVAhDxkY5THtgNNsys=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fba49c46-c846-4a8e-e515-08d7571d11ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 18:24:26.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoiT6RjsPrFW8tXldIMeZJFCMP1N7EPJVf0oefE2PiKnXK83CjZSUWDLDA0V4RL52VOm4y52o8/bNDGSNjMMCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2763
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok but this if off topic and not directly related to patches - or am I miss=
ing something.

Indeed if we run UP only for nsim we should add pseudo SMP and also a true =
SMP.

For uClibc-ng regression, it doesn't matter what they use and not for us to=
 decide anyways - we just need to tell them (or point to wiki etc) that sta=
rting with 5.x kernel,any nsim uart config needs to change of they are usin=
g the defconfigs.

-Vineet

________________________________________
From: Eugeniy Paltsev <paltsev@synopsys.com>
Sent: Tuesday, October 22, 2019 11:18 AM
To: Vineet Gupta; Eugeniy Paltsev; linux-snps-arc@lists.infradead.org; Vine=
et Gupta
Cc: Alexey Brodkin; linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/6] ARC: merge HAPS-HS with nSIM-HS configs

Btw, about nSIM regression runs:
We are using UP configuration for all nSIM runs and I propose to use pseudo=
-SMP  configuration (SMP configuration with only one CPU online) instead as=
 our main target are SMP systems.

So -
run our verification jobs on both UP and pseudo-SMP nSIM
run uClibc-ng regression on pseudo-SMP only

 Any objections / thoughts?
---
 Eugeniy Paltsev


________________________________________
From: Vineet Gupta <vineetg76@gmail.com>
Sent: Friday, October 18, 2019 21:48
To: Eugeniy Paltsev; linux-snps-arc@lists.infradead.org; Vineet Gupta
Cc: Alexey Brodkin; linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/6] ARC: merge HAPS-HS with nSIM-HS configs

On 10/18/19 5:15 AM, Eugeniy Paltsev wrote:
> Starting from nSIM 2019.06 is possible to use DW UART
> instead of ARC UART. That allows us to merge
> "nsim_hs" with "haps_hs" and "nsim_hs_smp" with "haps_hs_smp"
> mith some minor changes.
>
> We eliminate nsim_hs_defconfig and nsim_hs_smp_defconfig
> and leave haps_hs_defconfig and haps_hs_smp_defconfig
> which can be used on HAPS / nSIM / ZEBU / QEMU platforms
> without additionall changes in Linux kernel.

Thx for doing this, I was planning to do this myself.

But remember that doing this will disturb existing nsim setups
- Our internal linux/gnu regression jobs one of which tracks my for-curr an=
d will
  fail immediately
- uClibc-ng maintainer who also seems to use nsim AFAIK for regression runs

So we need to notify parties involves (and it would be best that we align t=
his to
a kernel release which anyways will be next one.

Also go thru the github wiki pages and wherever applicable please add the c=
onfig
info for nsim (keep the old settings there for reference as well)

Thx,
-Vineet
