Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEA6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51897205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IQ0E1lzm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Sm5UU91t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfH2P5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:57:37 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:47770 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726973AbfH2P5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:57:36 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5D1D0C03A1;
        Thu, 29 Aug 2019 15:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567094256; bh=OnXX76kgUMC/ulpjzDP0C9w9K0v+XAwTva8ZSTGW3Mc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IQ0E1lzmkvhDZepyQmvkAaNjlBsyX0FkKqU5DwLUqtNCCVmPQngwWzXakoI/nVvEW
         tDlxYQ2M7cpNUAkHzUnoJjg6haToTpat3VZzuq0XccKtrxZw+46F7iCSHFEdA/tylq
         564s19pGGGTxsqq8ugEMKOkGyg4gfbImX2enpS4CNKk1eJhqmYRdG6GOgVVR7mbAlN
         yJvtoQbXug01gHVeaYPsdbqBsV6f+njUjSJfW+HFWV1VQctXxJPo7TVVDyB+u44e5h
         REaVmznRXm5mKZwSukYfeznT8LoQbk0fuWQQ398xt0iERL64ImMW+22fgP6b95mikt
         zT+5ygjTcwS/g==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E3E10A005A;
        Thu, 29 Aug 2019 15:57:35 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Aug 2019 08:57:35 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 29 Aug 2019 08:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjzAUwAOxvLeyPy+JxvJ3h6dbcu49ItJ7WJAPd7aTZ22LdKqSmGSMRbFmjZmmwBlmwknkVqdOOZLA3EKXJg0rBaAYdLLMHqAXcM5Fm2mP9oIyqauMow44qGXCiOcNthgY4jMAwstYUzI53bLc5Whsm89QGwTi5iah513uudlgEkC2wIo/jb7/uIqyU+4TEJLbn8Xz1kXXPQBJ46A83xwx4MCOckrJEa9pu4lhR0GjnrZESL54j4g+0GCKdL8BvucxW2gSuGo/1KMn3QPUZIkGs+iPwYembZIOP8bumppEnLMor6EYOoC0+7SOvDifJhMcmJxs9Z4ZHsEKW6HgSD4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKYIB47aSV1KWayBDqlhI0JOGMi8v+xWXDSkOg70D3U=;
 b=Iwxgt1hFbwMKwTaXayYBEjCuRznWfeyBQMxjqv75Ua2dEsSseTX5/EUTQevbBusKnWWP25BZmBv3iWM4VP3peXS86KsgPC8pJJn4ianr4TWy0wfRXgRDhM9K/TdOnPmo1xFE3AS0U25Em5EwsQZxwxjlf6yzfY/FQN3BI6kT+XILlBpLuGo9Exa8wnnzYn7XrrTdb61mbw4PYhStK1leGC91Svbtn5RIXA+EkOrnmaC0SEgajElmC4Cx8xbSc43zUnzqYkW6oFzijM1QqjWLN4bjKUuTFpkyY3v2iNagRrsMKL+1sMwnuCnMt3X9nCFQwu+B04DwbN1umORFE9MQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKYIB47aSV1KWayBDqlhI0JOGMi8v+xWXDSkOg70D3U=;
 b=Sm5UU91tJyAwS9NwkLIpTuXy6iTqsNA9g3L3eLO3buYOTIrTGhRF8PbvWtuSqH+OHWi/sgeYKutDqSur5QOmKn5J9Qs2ZwSXXGUI3SrdCN7GxzkTsfJuZMQYyRxxvRAUGnWyAmyZcWgU6MHSfNcKWRTTKJdvR1uYTAmH5v7tAX0=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2717.namprd12.prod.outlook.com (52.135.103.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Thu, 29 Aug 2019 15:57:32 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6%4]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:57:32 +0000
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
Thread-Index: AQHVXlJtbJoJFO7ydka+l2zwcEQXe6cR8PSAgAA0rSCAAAzNAIAAABuAgAAGkYCAAAYCgIAACQgw
Date:   Thu, 29 Aug 2019 15:57:32 +0000
Message-ID: <SN6PR12MB26553867412178B3F7190F0CAEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
        <3e21481ddf53ea58f5899df6ec542b79b8cbcd68.1567071213.git.vitor.soares@synopsys.com>
        <20190829124457.3a750932@collabora.com>
        <SN6PR12MB265551F73B9B516CACB5B807AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
        <20190829163918.571fd0d8@collabora.com>
        <20190829163941.45380b19@collabora.com>
        <SN6PR12MB2655B08176E14BE9DF2BACA2AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
 <20190829172441.3a76385e@collabora.com>
In-Reply-To: <20190829172441.3a76385e@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYjM5MTYwNGQtY2E3NS0xMWU5LTgyNTQtYjU5ZDc5?=
 =?us-ascii?Q?N2QzNzhiXGFtZS10ZXN0XGIzOTE2MDRmLWNhNzUtMTFlOS04MjU0LWI1OWQ3?=
 =?us-ascii?Q?OTdkMzc4YmJvZHkudHh0IiBzej0iMjY2NiIgdD0iMTMyMTE1Njc4NDk0Mzg4?=
 =?us-ascii?Q?MDEzIiBoPSJHcDlpWG81eWZnaEJWVFdzbWduRzVPcEVYdHM9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUF0?=
 =?us-ascii?Q?NytwMWdsN1ZBUm4xd2xySkxFajlHZlhDV3Nrc1NQME9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: ab7a619a-d955-451c-b65a-08d72c999a6e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2717;
x-ms-traffictypediagnostic: SN6PR12MB2717:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27175BDFA3F6EC06CF76057BAEA20@SN6PR12MB2717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(13464003)(81166006)(53936002)(14454004)(5660300002)(6636002)(2906002)(478600001)(8676002)(316002)(81156014)(52536014)(66946007)(76116006)(110136005)(66446008)(66556008)(8936002)(66476007)(229853002)(54906003)(64756008)(186003)(6306002)(9686003)(74316002)(71200400001)(71190400001)(107886003)(76176011)(7696005)(446003)(256004)(6436002)(5024004)(14444005)(55016002)(11346002)(486006)(3846002)(53546011)(66066001)(6116002)(26005)(6506007)(102836004)(6246003)(7736002)(25786009)(33656002)(86362001)(476003)(4326008)(305945005)(99286004)(70780200001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2717;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lrl08eRjjOIeH8jYYqZmNbyTZv0am7m/8SS1nV8IF2JobhVku9OaBNa42scuCsP6Jm3uUGc0ztb947sM7IKxvL76C7F6G3mlqmC4t/VkENTrkqEWQg8vUojJE02my3c+QhBK0Xp5u1ZzebJ3m7PE90Pt88y7fRylqhO3srDIB8KxgAIsB56uTxlJpw/oIkPOxJOzkjIPPFDEASVEFRAJqDsb+T6DhAKdHiW5lwL5Ga1da7nHiSgjq4kQ7Q2ag9Hbjzp3AkIFfCv8U1lSLSb+iE2ugrzo83qsNQpZQdAkN/2GtTcWFcOYwuxe/NlUbr8rW5nKf5WBocoQXaGzN4//eaty6oU+sqfk/VKQ4TizN88KkhdL6AxHHa5B3t8nUvcm5r3GRJW61AzCH2yykH0jbwSO0h+1e6YFeXd9vS+T5Oc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7a619a-d955-451c-b65a-08d72c999a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:57:32.7340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkUR7WRWPuuEVhZUe7VZ75PhKZLJQmX7P40NH3jzB4BEM1QRjpuKlThCA4P+vJ7diBmB8EGtHBKsOn7wo3xG4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Boris Brezillon=20
<boris.brezillon@collabora.com>=20
Sent: Thursday, August 29, 2019 4:25=20
PM
To: Vitor Soares <Vitor.Soares@synopsys.com>
Cc:=20
linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;=20
linux-i3c@lists.infradead.org; bbrezillon@kernel.org; robh+dt@kernel.org;=20
mark.rutland@arm.com; Joao.Pinto@synopsys.com
Subject: Re: [PATCH 2/4]=20
i3c: master: Check if devices have i3c_dev_boardinfo on=20
i3c_master_add_i3c_dev_locked()

On Thu, 29 Aug 2019 15:07:08 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> From: Boris Brezillon=20
<boris.brezillon@collabora.com>
> Date: Thu, Aug 29, 2019 at 15:39:41
>=20

> > On Thu, 29 Aug 2019 16:39:18 +0200
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >  =20
> > > On Thu, 29 Aug 2019 14:00:44 +0000
> > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > >  =20
> > > > Hi Boris,
> > > >=20
> > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Date: Thu, Aug 29, 2019 at 11:44:57
> > > >    =20
> > > > > On Thu, 29 Aug 2019 12:19:33 +0200
> > > > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > > > >      =20
> > > > > > The I3C devices described in DT might not be attached to the ma=
ster which
> > > > > > doesn't allow to assign a specific dynamic address.     =20
> > > > >=20
> > > > > I remember testing this when developing the framework, so, unless
> > > > > another patch regressed it, it should already work. I suspect pat=
ch 1
> > > > > is actually the regressing this use case.     =20
> > > >=20
> > > > For today it doesn't address the case where the device is described=
 with=20
> > > > static address =3D 0, which isn't attached to the controller.   =20
> > >=20
> > > Hm, I'm pretty sure I had designed the code to support that case (see
> > > [1]). It might be buggy, but nothing we can't fix I guess.
> > >  =20
> >=20
> > [1]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__elixir.bootli=
n.com_linux_v5.3-2Drc6_source_drivers_i3c_master.c-23L1898&d=3DDwICAg&c=3DD=
PL6_X_6JkXFx7AXWqB0tg&r=3DqVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=3DI=
XS1ygIgEo5vwajk0iwd5aBDVBzRnVTjO3cg4iBmGNc&s=3DHC-AcYm-AZPrUBoALioej_BDnqOt=
JHltr39Z2yPkuU4&e=3D  =20
>=20
> That is only valid if you have olddev which will only exist if static=20
> address !=3D 0.

Hm, if you revert patch 1 (and assuming the device is properly defined
in the DT), you should have olddev !=3D NULL when reaching that point. If
that's not the case there's a bug somewhere that should be fixed.

No, because the device is not attached.
