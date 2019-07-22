Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49939C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1203E21985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KUIOyI0f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="LDYAMe8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfGVSmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:42:43 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:50032 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728798AbfGVSmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:42:43 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8397AC005A;
        Mon, 22 Jul 2019 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563820962; bh=tNH5tsaR0JmqmukXVonlPiuQ8hHf3cN1HhJigsjU7Fc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KUIOyI0fzcpVLgdwlZ1nuAzzJlD1yxgNHbBBH4yWknUMdJ2NVvljosLcgqKlQSpmF
         gQ9hFoSR4OLFhdJ6FY7l1jxi1epNIhvx2ZlzGAdjEhAVOilpowFFqsgUWspNtpUK6W
         VNuVn3omw7PzFcb0C0YMd8JNmv1o99/izKQUdhDehwfpRdw8ZAsrRUuV/xJAI/vbMm
         CHWLV1MdN7ZENmeu3Whp27h2hS5/UP5NVxU1fzDsLlIyDaiWueHep2eaU++QU+2udc
         4HFE2zQ7hB+Bju6mFZ/CRLUlasqWQzS6eEXWirBQGzBInLD8kZvAmaHxsXZfC6sJHN
         FJL/kvnMa6x3w==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E7C4CA0093;
        Mon, 22 Jul 2019 18:42:41 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 22 Jul 2019 11:42:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 22 Jul 2019 11:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2EGvnMazxF19CeLhxEJp9Tfn0H78H0Rna/mW7n2mZOqSKvaWWwu82gJqGyHWmfve74dve0qnjWfpxP5rZrbSbc+rizog8T6Q5n6YWZKajOjVDc+1YzFs1oL/pwV5fIXi0hY/FlS83yj5uzIUKVqyDZ34J7fkAsuCp4n67n/zXYZilTb3G4u4+iRNB/tYO70uXc3Yn2i9PuXRb+E4Kzl/nLmbSAcIXctTq3GOBtCDhk6Yvg5Mw7oplQr4A9vR4aZ/Y+oT5Y6eeE4YydAFILGZ/vFWyrp0XxZnUgXRjX4NosxME7BoftE6HbUbk+PA8t6oVoDeLcrRuv/s1h1pavQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXinc1RdWr5khGfJW8P09VjRcK/tUHmeMf7gmc9nDFc=;
 b=Or5IiKDkRLNn7duHB4KDNyzJXBiSu9UQo6xoAAAfu5rr/d8ICoW0uCdpqEGOOlXI6CseqqSVaficZGTAau3rbZEAXf1uxZWqsCHifnf+XRykpTCEsfKPO8MF/8fcPiVUcR1301otu1M79umi6bEf69ceMq/eIu7T3/dDs6FFVD9LDJZmoM8aAOr0BxqhKzZwhyMgaAUHiWLbNioZHsI/B85Fk9bdOxLm+b9/SKP7BrgctI3lLYX9GZtnx4tytZu15//gkuNYCmJClKMYWVaZUlmrPtgS0192fthqBsch3eIj7HqxdlZsCc0gSSM3Fo4EqfkTyg2OjOIxWk0BC+qcaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXinc1RdWr5khGfJW8P09VjRcK/tUHmeMf7gmc9nDFc=;
 b=LDYAMe8JMSWE0G3whaKW1W7gIisIVJKWuj5tYc0N2lqZD6JAcOOwCBxszkcWVPVryPivTQfWyVvX/oZXOm4MirGk6F8DuwP3Uofm6UVRlLfhf38cNVt0uSTXUqcYuwsiY4XSwhREy8DvbFhxbMcWenwXpruN3b4men3ekqQ4JWw=
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com (10.172.78.14) by
 CY4PR1201MB0023.namprd12.prod.outlook.com (10.172.79.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 18:42:38 +0000
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::1c8d:9b3c:7538:477b]) by CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::1c8d:9b3c:7538:477b%4]) with mapi id 15.20.2094.017; Mon, 22 Jul 2019
 18:42:38 +0000
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vineet Gupta" <Vineet.Gupta1@synopsys.com>
Subject: RE: [PATCH v2] ARC: [plat-hsdk]: allow to switch between AXI DMAC
 port configurations
Thread-Topic: [PATCH v2] ARC: [plat-hsdk]: allow to switch between AXI DMAC
 port configurations
Thread-Index: AQHVQHBc5olcQ9vPUE+JBpQJPWk7tqbW+VQw
Date:   Mon, 22 Jul 2019 18:42:38 +0000
Message-ID: <CY4PR1201MB012020E6C3416DC9F4A5AF19A1C40@CY4PR1201MB0120.namprd12.prod.outlook.com>
References: <20190722093145.4626-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20190722093145.4626-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abrodkin@synopsys.com; 
x-originating-ip: [188.243.7.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d44eb7be-75df-4b2a-1ac5-08d70ed45f33
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR1201MB0023;
x-ms-traffictypediagnostic: CY4PR1201MB0023:
x-microsoft-antispam-prvs: <CY4PR1201MB0023D42BF00AF4E4AB3408CCA1C40@CY4PR1201MB0023.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(346002)(39860400002)(396003)(13464003)(189003)(199004)(66476007)(64756008)(66556008)(66446008)(81166006)(66946007)(81156014)(76116006)(8936002)(25786009)(256004)(107886003)(4326008)(14444005)(86362001)(478600001)(66066001)(99286004)(14454004)(54906003)(110136005)(486006)(316002)(76176011)(26005)(476003)(6246003)(7696005)(2906002)(6436002)(5660300002)(186003)(53936002)(229853002)(102836004)(6506007)(53546011)(33656002)(52536014)(74316002)(2501003)(71190400001)(71200400001)(8676002)(305945005)(3846002)(7736002)(6116002)(446003)(11346002)(9686003)(55016002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB0023;H:CY4PR1201MB0120.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZcuAKdmcZCmwdAtTvx5Q4dU+JF2rHogtIpflWGCT0ayIOQHgLZmYqw5HM/qfcv7kcR5rMUydO6N3adjZfBGxYWREAh5qHTDLyuGzm1KlpJCQJjAm3EH3R2IKa2veKbj8+yAKELLD640zaSzxDEu0UKudWkps6/HgyHeOOm/6Q942dYjN1UxU3MbdIXHfm7ytKhHsVj5/tcZ5ZE6RP41JVVCLMbZDnXU1yZwivKNiQL21L0TfqwbL1XlezGnwbJUVbv/ayYXJcELN8VzyumLDYuWEPqCoU1il0S/OVRRTz82jxlK6cAMY7IV1GYQa5AD368lKleePX3USIAcxSSecchBUOGH5Nvlum9sHEHm/EcD+4fmus9UaY7FI+O8ZfcmifLy2WYMrB7J5tyhUni97f0LLYFQcnIqnTAmxr6D9UT8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d44eb7be-75df-4b2a-1ac5-08d70ed45f33
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 18:42:38.7915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abrodkin@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0023
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniy,

> -----Original Message-----
> From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Sent: Monday, July 22, 2019 12:32 PM
> To: linux-snps-arc@lists.infradead.org; Vineet Gupta <vgupta@synopsys.com=
>
> Cc: linux-kernel@vger.kernel.org; Alexey Brodkin <abrodkin@synopsys.com>;=
 Eugeniy Paltsev
> <Eugeniy.Paltsev@synopsys.com>
> Subject: [PATCH v2] ARC: [plat-hsdk]: allow to switch between AXI DMAC po=
rt configurations
>=20
> We want to use DW AXI DMAC on HSDK board in our automated verification
> to test cache & dma kernel code changes. This is perfect candidate
> as we don't depend on any external peripherals like MMC card / USB
> storage / etc.
> To increase test coverage we want to test both options:
>  * DW AXI DMAC is connected through IOC port & dma direct ops used
>  * DW AXI DMAC is connected to DDR port & dma noncoherent ops used
>=20
> Introduce 'arc_hsdk_axi_dmac_coherent' global variable which can be
> modified by debugger (same way as we patch 'ioc_enable') to switch
> between these options without recompiling the kernel.
> Depend on this value we tweak memory bridge configuration and
> "dma-coherent" DTS property of DW AXI DMAC.

Looks good to me.

Acked-by: Alexey Brodkin <abrodkin@synopsys.com>

-Thanks

