Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484E1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF852067D
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="XsAqJuu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfHAJxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:53:13 -0400
Received: from mail-eopbgr20066.outbound.protection.outlook.com ([40.107.2.66]:13837
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726407AbfHAJxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:53:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwuKD+nOYoyNaahTa/LFv0syidf98Oo2Gh9Hk3YKxqmlbVkI7J/IDnTsTaAcyCZZDbHGUt25WlKsm0JUzAEttg7crKWSsjiUXnHh0AJOE1PvC2oDlo7R1ynpMRIOK9J6MLF2lK7/31HyQ8Y7SSRLqBK+u/Na2MKOG2rQSYaYbjUcbVQKqXsVa0x10X4cglrf1iQKQ301aluwkkO6XLbsn8ESpL43arIqG/+CoESTV/JR2CpxQoeZ0HH4vNGIa3gAUUbW8jja2ggPm/PAlbP8nTsFxlz7Lq4wMP0Dj15r5pOJZeTwwmChxflfrXTysrTt3n5tahFWwBHX6aNcweBLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OZxqOGVrQj75rZP5NM5vawD6+osHFZdVF652tz/5ek=;
 b=KaE9ety2UrvmK59O1z0qzjVvbMI/P88K8W1c2sKpt4hU87gRFEhDbEzKQqSMUgf87V0+7rnluZQwD98R9GjEmcBhv+clstHGTIFZ6OUHcpDFoeL/CLIb7lrKrOdsWQxciwD5WPiykDPKu6KLYnVq6dolpdoTK5xe6Inm+ujxNoIYdqXoxoVWEUO9sl69kJ0YuiY/x25AN7NZzGfx2O7xavOyO1Gppi9jATFy7Ipup028TujtXv81vuXNrprT9g0euDeLPmpuAGkBydzCcVdK1VpcZ6h9CoknshDkUFXb7d2xrJiKzTwqqh4HDdUHco/b1Bqp7dL5OjIiR58EmWwirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 188.184.36.50) smtp.rcpttodomain=lwn.net
 smtp.mailfrom=cern.ch;dmarc=bestguesspass action=none
 header.from=cern.ch;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OZxqOGVrQj75rZP5NM5vawD6+osHFZdVF652tz/5ek=;
 b=XsAqJuu9L5yVdLL/TsvxcoeUwkJpc9+IWuMvWn4aaQD06q0fEvMJzrYN3XZcHv4TS6q4S69pLaP8L3deQ5zoTxfrDPQ8rGduH+ZG482G6OrTzWdggvGHn0VUEDDXmsGu8/o3ftLVH8yCfW3B6hrjml+xE5MLE7AyddoHYay8Juo=
Received: from AM0PR06CA0050.eurprd06.prod.outlook.com (2603:10a6:208:aa::27)
 by HE1PR0602MB3305.eurprd06.prod.outlook.com (2603:10a6:7:1b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.12; Thu, 1 Aug
 2019 09:53:08 +0000
Received: from VE1EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::208) by AM0PR06CA0050.outlook.office365.com
 (2603:10a6:208:aa::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.15 via Frontend
 Transport; Thu, 1 Aug 2019 09:53:08 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=bestguesspass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT028.mail.protection.outlook.com (10.152.12.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2136.14 via Frontend Transport; Thu, 1 Aug 2019 09:53:07 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 1 Aug
 2019 11:53:06 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Thu, 1 Aug 2019 11:53:07 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Jonathan Corbet <corbet@lwn.net>
Reply-To: <federico.vaga@cern.ch>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alessia Mantegazza" <amantegazza@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: translations for documents in process/
Date:   Thu, 1 Aug 2019 11:53:06 +0200
Message-ID: <1695846.t893fQQLz3@pcbe13614>
In-Reply-To: <20864529.Q1CKeA7GMu@pcbe13614>
References: <20190728092054.1183-1-federico.vaga@vaga.pv.it> <20190731125124.46e06ab6@lwn.net> <20864529.Q1CKeA7GMu@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(2980300002)(199004)(189003)(2906002)(478600001)(5660300002)(50466002)(23726003)(47776003)(6916009)(6246003)(70586007)(70206006)(6116002)(230700001)(126002)(9686003)(43066004)(86362001)(53546011)(97756001)(26005)(7636002)(316002)(46406003)(76176011)(446003)(8676002)(11346002)(9576002)(8936002)(356004)(305945005)(7736002)(33716001)(229853002)(4326008)(3450700001)(336012)(44832011)(106002)(246002)(476003)(426003)(186003)(486006)(16526019)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0602MB3305;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e7f692f-3b38-4d15-a54f-08d716660e71
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:HE1PR0602MB3305;
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3305:
X-Microsoft-Antispam-PRVS: <HE1PR0602MB33051F3AA3447D827872EBE4EFDE0@HE1PR0602MB3305.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 01165471DB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: LeSGVg0uN7NVonfT+9TlP6hhWolpCKm/fm1J/NUFuBnsL4YKDr8mICSgacJXruf8B2AZoB+kHJRINddNYvmjjtMx2bHC43IAnJficoJDe7vx52jP/Uv8Wrk+Mzf5aH5OlTAGkMsOhHWCHgwvIJyFhxE2MpFap+i+16QLmpum5vUIQJPljpmW8GDXrBA9VfZHObSfWJeF1g/TYgamZIxV35+/xz6CXDqM6D3a+HgJmpN5+CUe3dWh6xnjAxPsKOsekCaahtgS/d/2mN6BBnw/l0lxRBKqCFaLX8lG4QXCGtM1FL0BvCFCaM89b41OeNld81/7wt8/Cop8j5IipBHf3/IxZTTDCWNNfKvOg61HvTtGyhHAAKLjs+RiiHtpEP99hMTqPEbFdlAvnpFoqBOVdUXxSR1RaXL4uBNY5w0eXq4=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 09:53:07.8336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7f692f-3b38-4d15-a54f-08d716660e71
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3305
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 1, 2019 11:37:58 AM CEST Federico Vaga wrote:
> On Wednesday, July 31, 2019 8:51:24 PM CEST Jonathan Corbet wrote:
> > On Sun, 28 Jul 2019 11:20:54 +0200
> > 
> > Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > > From: Alessia Mantegazza <amantegazza@vaga.pv.it>
> > > 
> > > Translations for the following documents in process/:
> > >     - email-clients
> > >     - management-style
> > > 
> > > Signed-off-by: Alessia Mantegazza <amantegazza@vaga.pv.it>
> > > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> > 
> > This looks generally good, but I have to ask...
> > 
> > > +Se la patch che avete inserito dev'essere modificata usato la finestra
> > > di
> > > +scrittura di Claws, allora assicuratevi che l'"auto-interruzione" sia
> > > +disabilitata
> > > 
> > > :menuselection:`Configurazione-->Preferenze-->Composizione-->Interruzion
> > > :e
> > > 
> > > riga`.
> > 
> > Have you actually verified that the translations used in these mail
> > clients matches what you have here?
> 
> Yep, I've installed all of them and gone through all menus.

P.S.
Of course, I checked on the version available on my distribution. I did not 
look for translation changes on different version of the same email client @_@ 
But even if I do it, there is no "nice" solution to the problem

> But I just noticed a typo in the quoted statement, I will send a new patch:
> 
> "modificata usato" -> "modificata usando"
> 
> > Thanks,
> > 
> > jon




