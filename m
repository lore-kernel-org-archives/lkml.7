Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2042DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26C42077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HfPoq6hI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Rh9Kfaso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfH2PIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:08:02 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:45628 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbfH2PIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:08:02 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AE0FDC0159;
        Thu, 29 Aug 2019 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567091281; bh=lVKxLBK22OS5q7XtxnGLlD9KZTzgWtGXi2O5B839MCg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HfPoq6hIPvFe5weECPLU+DYpx784d8KmoobzR5Qp7ov7jw6JpXoDPs0xOp7JC1zUR
         rModEXvhexz26x2qfSW+uu4U9DSljJsbMVKioNQw5uBZF1JPyz41803JmEjh1KBKqM
         Iy+lp3OBeNiKv/aINVRvLWe82CCBWwuHfxGp18yyeAEI2+vPrrL4Q9jFHRRAVJilpb
         3WGpxqOUpZa6CTLuTO3W1FYudIiaPrA8ymCS5uypNae9mJdZrsNEt+4MJUjKGyIIF6
         BLu0CzUt0YNM18N4lMAPqcShjUltNR1navY4n7rtjddlq582qaAf8y0vSCq8m8duhq
         i8D+IxhdLjgog==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 44C97A0083;
        Thu, 29 Aug 2019 15:08:00 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Aug 2019 08:07:11 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 29 Aug 2019 08:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI9gZwzymSWWE6Mc7wW+UPLCKHtq9kbpoVeAlRPScdxIzqqymo/Yh35rFTWec6v7xyvM2MqYiLoI+/fYD1eYDCbgGSeYNFHCYmPe9MIH8fN6rL27JljaOpZks4sSQpVFwRGBzTuNWK+xDJ2Xbu2QxkU2nq12FH/6saAgbW/lRSNVwLaMkGoZQb1sINVliDGsLZFlWNLrFVeaj4/Y10p0O8NHnv8bEDmH5RJqGWKFx4WV77D/AO7BdjCluHZc1S0OooSGwfBx+TKFP1PZn/o0vjNRvu1YoIsvjG6F82CdW6el4/sFlxL73OZ25J3djljQs6Ce5LhfGSByw4mz1kGasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdv5iGp6cVvOosx7YhTRwmoYbQSdowbbugqoWaj0Snc=;
 b=bDlcW31ZIlcqUf7QtLQXPyDHkyHBACFkA2cU3Y3ejMdlVKBcXVuwckyp3g9n0hVmAMezQu2Kdx22kTkjcjEBuoXDOF+icCPnFnqLZi8iS18X8WleQh/JAwXlDaRZc0nDAl2QDlwx7bWfvI0uh2RuddYOc8wdelMtiEpuC5o7j9B+xN5PFduFPs6QNfz8dxlf9DhA1ifR1dSUHDs9vgEKGE4KManQpmX42yrw+vIBaXsyzKydQecIYSwAD7NfsovkhQ3drVbAeLqnjZNvAmvcRsrHEOR921J/k4pe3sFOGIdxhJIGCZqWphXpnGt6oXVfhAkIPVXUzXXefk7Z3DYuDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdv5iGp6cVvOosx7YhTRwmoYbQSdowbbugqoWaj0Snc=;
 b=Rh9KfasoIZwu1eKoqcz74ucw/7IydmQrl5SFinNE8a/juQQq4bHi0xWVYgZYwsQb0FezpUfoTq0DWtInmpKgOp79reDl90x+pqv2v8UAURTAAmsrHgCirRUu2KkVIN3+w3UBCq7GSDRCr3wGNbxKFGCcg9zgl3e9J/dyUaZ0HlY=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2782.namprd12.prod.outlook.com (52.135.107.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 29 Aug 2019 15:07:09 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6%4]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:07:08 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH 2/4] i3c: master: Check if devices have i3c_dev_boardinfo
 on i3c_master_add_i3c_dev_locked()
Thread-Topic: [PATCH 2/4] i3c: master: Check if devices have i3c_dev_boardinfo
 on i3c_master_add_i3c_dev_locked()
Thread-Index: AQHVXlJtbJoJFO7ydka+l2zwcEQXe6cR8PSAgAA0rSCAAAzNAIAAABuAgAAGkYA=
Date:   Thu, 29 Aug 2019 15:07:08 +0000
Message-ID: <SN6PR12MB2655B08176E14BE9DF2BACA2AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
        <3e21481ddf53ea58f5899df6ec542b79b8cbcd68.1567071213.git.vitor.soares@synopsys.com>
        <20190829124457.3a750932@collabora.com>
        <SN6PR12MB265551F73B9B516CACB5B807AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
        <20190829163918.571fd0d8@collabora.com>
 <20190829163941.45380b19@collabora.com>
In-Reply-To: <20190829163941.45380b19@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYWExNmU5NTMtY2E2ZS0xMWU5LTgyNTQtYjU5ZDc5?=
 =?us-ascii?Q?N2QzNzhiXGFtZS10ZXN0XGFhMTZlOTU0LWNhNmUtMTFlOS04MjU0LWI1OWQ3?=
 =?us-ascii?Q?OTdkMzc4YmJvZHkudHh0IiBzej0iMTc2MCIgdD0iMTMyMTE1NjQ4Mjc0NDk2?=
 =?us-ascii?Q?MTQ1IiBoPSJhS3lHemMrVCtLaVBvaExIaDdrT2V3K2JWUEk9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUNS?=
 =?us-ascii?Q?K3F0c2UxN1ZBVGlFd3F5QWdLVGtPSVRDcklDQXBPUU9BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQVZ6ZGhHZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCaEFH?=
 =?us-ascii?Q?MEFjd0IxQUc0QVp3QmZBSElBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpBRzBBYVFCakFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQWRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFkQUJ6?=
 =?us-ascii?Q?QUcwQVl3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCMUFHMEFZd0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWndCMEFITUFYd0J3QUhJQWJ3QmtBSFVBWXdCMEFGOEFk?=
 =?us-ascii?Q?QUJ5QUdFQWFRQnVBR2tBYmdCbkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?R0VBYkFCbEFITUFYd0JoQUdNQVl3QnZBSFVBYmdCMEFGOEFjQUJzQUdFQWJn?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQVlRQnNBR1VBY3dCZkFI?=
 =?us-ascii?Q?RUFkUUJ2QUhRQVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdV?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFGOEFNUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHNEFjQUJ6QUY4QWJBQnBBR01BWlFCdUFITUFaUUJmQUhRQVpRQnlBRzBB?=
 =?us-ascii?Q?WHdCekFIUUFkUUJrQUdVQWJnQjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSFlBWndCZkFHc0FaUUI1?=
 =?us-ascii?Q?QUhjQWJ3QnlBR1FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=soares@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed8ea862-958b-49c1-cbaa-08d72c929009
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2782;
x-ms-traffictypediagnostic: SN6PR12MB2782:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB278225DD9A24CFB399C3467AAEA20@SN6PR12MB2782.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(81166006)(71190400001)(6636002)(71200400001)(76116006)(7736002)(74316002)(76176011)(7696005)(86362001)(486006)(66066001)(446003)(11346002)(26005)(99286004)(102836004)(3846002)(186003)(305945005)(6306002)(66476007)(64756008)(55016002)(6506007)(66446008)(5024004)(9686003)(66946007)(66556008)(256004)(81156014)(2906002)(25786009)(54906003)(316002)(6246003)(53936002)(6436002)(8936002)(33656002)(14454004)(52536014)(6116002)(476003)(478600001)(229853002)(5660300002)(4326008)(110136005)(107886003)(8676002)(70780200001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2782;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O1YG/WEJUP1rom+IKKZD5RjyhX7FuuX/cL6J/b5rvzVvaP7E9twiFpnRe2XJ58BCou3RZ6j8NmRzyopYNMc4vufiTgl/DUjWP1lYufOarjQX6h24DGasHBgkEjkkbg8svC8gZrL//m6wyDclg5b7h8/QjCOQfxbqHVngn2r3BKrFCNCFQ9IPbQa0OdOIfxBHHq94D7f1cA6Jd+340A+3cQVFS0AMMM3rdOnvAZthI64HDKSjg7ApCGW44shwct8IBZgtXvM0shQzCsWtXz6v2g3pkJGpxH8tHiddkW4Mbi+VaFUbqWBJ2GiSvRn3DOzy58wjPFBTui7KiMyV7V0Zlxh0LbpElK9RdxUrrd+oNLTAU5uTad/gGms6tr4+UHzNIxfZbu610QcdV6YMd/reoh5B6+nrqsViv6tDmeQ57VQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8ea862-958b-49c1-cbaa-08d72c929009
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:07:08.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uroqubY11C/9XgxvMz8J7JXm19NWNppWUJVIDQIh8sO6dJqt3hB1sUWQY380If9JZwUXsYceRYaobpZVxrhUQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2782
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, Aug 29, 2019 at 15:39:41

> On Thu, 29 Aug 2019 16:39:18 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
>=20
> > On Thu, 29 Aug 2019 14:00:44 +0000
> > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> >=20
> > > Hi Boris,
> > >=20
> > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > Date: Thu, Aug 29, 2019 at 11:44:57
> > >  =20
> > > > On Thu, 29 Aug 2019 12:19:33 +0200
> > > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > > >    =20
> > > > > The I3C devices described in DT might not be attached to the mast=
er which
> > > > > doesn't allow to assign a specific dynamic address.   =20
> > > >=20
> > > > I remember testing this when developing the framework, so, unless
> > > > another patch regressed it, it should already work. I suspect patch=
 1
> > > > is actually the regressing this use case.   =20
> > >=20
> > > For today it doesn't address the case where the device is described w=
ith=20
> > > static address =3D 0, which isn't attached to the controller. =20
> >=20
> > Hm, I'm pretty sure I had designed the code to support that case (see
> > [1]). It might be buggy, but nothing we can't fix I guess.
> >=20
>=20
> [1]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__elixir.bootlin.=
com_linux_v5.3-2Drc6_source_drivers_i3c_master.c-23L1898&d=3DDwICAg&c=3DDPL=
6_X_6JkXFx7AXWqB0tg&r=3DqVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=3DIXS=
1ygIgEo5vwajk0iwd5aBDVBzRnVTjO3cg4iBmGNc&s=3DHC-AcYm-AZPrUBoALioej_BDnqOtJH=
ltr39Z2yPkuU4&e=3D=20

That is only valid if you have olddev which will only exist if static=20
address !=3D 0.
