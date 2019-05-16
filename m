Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C6C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2606E2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ggFBjkGi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="XWvtEmS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfEPRo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:44:57 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:38680 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726441AbfEPRo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:44:56 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D013DC0B97;
        Thu, 16 May 2019 17:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558028701; bh=crxjKHxEpieoI+cLpdzkqh0oUiM/l9M6CXzyCwZkdhI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ggFBjkGijkfoJM5Ozcqz40PK3kEr8j+yzWnHuC55qsD6vDzi/hT2NIIyUgppm8OXn
         vIrQpfK2DP9FCWYPunx1l3yVkmVP69SYIt6XD8IizAnZCYc6xy3itGglXaOLAh43X9
         ykRA44Z9qWCp1vTmJpESTbB93gwrIREsUnJBorpKtKLziSL9P6rPDM3BdPV+yQfFSC
         GawVZCKT9GZOEp0y3L7sM+of+QdCTsYojJFSdJmAx12F2v340uNvkVOcEC9epD2Rwa
         /G0Sbsoixy3akafk9pC9KywwdH6tN6hUEPpg+C8bzIlmbBTHsQoRhRmdHnDvedr279
         s+MiWI0dfO/Zw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C0B1CA009B;
        Thu, 16 May 2019 17:44:50 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 16 May 2019 10:44:48 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 16 May 2019 10:44:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmN+AYK9mAKfOlO6Te8/lSQdYymNXwo+lfd4hh7gwRo=;
 b=XWvtEmS/5T+96RkA7s6+z+Mvcii4oqrb+kQ3YYdxhfj2iBc03PUvegQwG9nzcRnb2iS1EVazfGx+G4ktzkrQUYiMcOxAJhTcaPLr+qvLf1sYq85oe6ExfLU1O20b+mIWGVtPuTkviMYnH4Q/tH+iIdlwjA8O7aeaFkStDjkxbVo=
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com (10.172.78.14) by
 CY4PR1201MB0024.namprd12.prod.outlook.com (10.172.77.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 16 May 2019 17:44:45 +0000
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::d536:9377:4e1c:75ad]) by CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::d536:9377:4e1c:75ad%4]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 17:44:45 +0000
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "paltsev@snyopsys.com" <paltsev@snyopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: RE: [PATCH 4/9] ARC: mm: do_page_fault refactor #3: tidyup vma access
 permission code
Thread-Topic: [PATCH 4/9] ARC: mm: do_page_fault refactor #3: tidyup vma
 access permission code
Thread-Index: AQHVCrVzPLg+oAEwCUOQqcYrmCMW8aZuCFmg
Date:   Thu, 16 May 2019 17:44:44 +0000
Message-ID: <CY4PR1201MB0120A3C58405DD60FF6B4359A10A0@CY4PR1201MB0120.namprd12.prod.outlook.com>
References: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
 <1557880176-24964-5-git-send-email-vgupta@synopsys.com>
 <1558027448.2682.11.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A2517B16@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2517B16@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abrodkin@synopsys.com; 
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1077b586-acf5-412c-092c-08d6da262ee8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR1201MB0024;
x-ms-traffictypediagnostic: CY4PR1201MB0024:
x-microsoft-antispam-prvs: <CY4PR1201MB002463280129A553DFE80501A10A0@CY4PR1201MB0024.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(376002)(346002)(39860400002)(13464003)(189003)(199004)(256004)(14454004)(14444005)(66066001)(7696005)(66946007)(76176011)(73956011)(66476007)(66556008)(64756008)(66446008)(476003)(71200400001)(11346002)(446003)(71190400001)(486006)(6636002)(4326008)(316002)(99286004)(86362001)(54906003)(68736007)(478600001)(76116006)(26005)(186003)(53936002)(6246003)(4744005)(3846002)(6116002)(33656002)(2906002)(102836004)(6506007)(53546011)(55016002)(25786009)(9686003)(305945005)(7736002)(107886003)(74316002)(6436002)(229853002)(6862004)(81166006)(5660300002)(52536014)(8676002)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB0024;H:CY4PR1201MB0120.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pdL7VN2asrODAZs1KAZmRuYYW1bxsPnqamB6kHGgDhZpjNHzS1qpVvD+oebPpQLvSM+mehomemiXO2c/NuC4Ja/b6WK50TwOuzDPn5DVQto2qWB59/wfYVF4kTeRkYNm1T6tsfWgiJtdny/4YuTuu6C6T9DpBtHildij8kogUF3IG9sgEOomWwgqmnv5hWlWipCEMjvHib5HzyzA6H+vsiVuVawXOCH6wtPqXryAxCGrG78kNGLAq8z5b6olRYPJr6tdmzaWxP4/QB4hfICPw4HHauaAO/64c+H7S13K9uAbXj3e1MUZokXsRWnN34e6xWL+48tRfRIakjxiNZVEmpIA8u2tPFS+0H511mD54+rojAEIOLj2lmyXhduNhhrgQWF+YELc987tgVUZzKloOdyTF8Q4VaqIsW7b1hQhjZo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1077b586-acf5-412c-092c-08d6da262ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 17:44:44.9274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0024
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

> -----Original Message-----
> From: Vineet Gupta <vgupta@synopsys.com>
> Sent: Thursday, May 16, 2019 8:38 PM
> To: Eugeniy Paltsev <paltsev@synopsys.com>
> Cc: paltsev@snyopsys.com; linux-kernel@vger.kernel.org; Alexey Brodkin <a=
brodkin@synopsys.com>; linux-
> snps-arc@lists.infradead.org
> Subject: Re: [PATCH 4/9] ARC: mm: do_page_fault refactor #3: tidyup vma a=
ccess permission code
>=20
> On 5/16/19 10:24 AM, Eugeniy Paltsev wrote:
> >> +	unsigned int write =3D 0, exec =3D 0, mask;
> > Probably it's better to use 'bool' type for 'write' and 'exec' as we re=
ally use them as a boolean
> variables.
>=20
> Right those are semantics, but the generated code for "bool" is not ideal=
 - given
> it is inherently a "char" it is promoted first to an int with an addition=
al EXTB
> which I really dislike.
> Guess it is more of a style thing.

In that sense maybe think about re-definition of "bool" type to 32-bit one
for entire architecture and get that benefit across the entire source tree?

-Alexey
