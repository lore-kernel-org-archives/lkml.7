Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EDFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44A82339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="itn6Mwb1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="GAqXdhEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfH2Qds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:33:48 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:49284 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726973AbfH2Qds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:33:48 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0B1C9C03A1;
        Thu, 29 Aug 2019 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567096427; bh=A6Y7qBqe4I8d/uOirN2sy0TPo43XByU9LfEm62mQbpw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=itn6Mwb1Q1qhTpe8fp2Vb5Z4zSNAfWkS36Euk9tKbggpheN2bQpMN4VR5AkECJ67X
         YyTLv2NGZ6KMCdOZ7ergJ+ZA8FyJH5pAp2c0Lx/wsZOYRQy3Mr70iZLLkDSffZMznu
         NJTVbw5qrodwkp+3ZufEzDYjdJgOhxpeoDF4fisBy0cxU6hLs7/igFl5wyC+nVEJVM
         pMmyv/aUQKG3dT/Ncqltn7KTRWu0eyWIWJhjaGqije5HVceLHHsxAOdTfSmft91E5h
         5JhiJoIv3KaelXq3/x4vtx+trP66a4kO+rNbtgQPKXPAlBazUGw3Js2JSd6WYubw0y
         f1QchFKfgI0gw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 19FC9A008B;
        Thu, 29 Aug 2019 16:33:44 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Aug 2019 09:33:44 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 29 Aug 2019 09:33:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGs32egnXbk6VlkDKMp00xc9p7s/IXwCbjApSoTOXQffY5EChItTjNz/tkQCPFKvRnvyNAEjfWKd+qV+UlUXXAkOEOj6uROqgrjuupgovqAGCHEY+2SiJ8FrXq8gxc77SPnNl9XkC9Ykz15MMPcbfZ9hZHmWaQ/v/G9l3KiItn3IabmjZ8WRNGWF9+hTjqp7np48vNx2hGLPTUquXKcrOso6o7IFAt93vx0zcGGM6yJbjoYV72+lWsdcWoE4mWE3RUm56Z2WNqBEIfHU/Tg9fiLxiQ29dtEGhDZLj0ldMqpjOLv7Ao7lE1w134twQ8fozPoxqxh4fPp1nOE35xTCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWs7cfWg4hkniNPXJb19tMyAuNxzZ3J82dJoy3DkLkU=;
 b=j130a7bcsp0Z+IH+sd3rhT4pS/KgZ6s50SUuumMs9tmss5iidDqMioOR0F11gf2KIQVG7lVvOVx02GZbGLhXxQrDb6jnC98aDg44Ai/q7NIDcyZ68WM4ZUT7lYLyrR0R2ms5hKmYUwUBNzeAip88rxPSTB8NNgPwU61qDfBhbS9YKxGPHMN+cpKDBykNfJoPhIwS2HmJOEykb8P9PTKv7jBNeqRbCtzHP3oo+2uFWqki9VgRT0E21SXdl4grNGVvkWXPykf8WFknt/bUSK6Cxh8F3AIVEStZ50NlYBHNaZ0ojMBuqscPgWHfgnVkqoiKU2WiDD0aToGdkqcLSdPzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWs7cfWg4hkniNPXJb19tMyAuNxzZ3J82dJoy3DkLkU=;
 b=GAqXdhEFyAP58K0NPUs9tLmoEnmpVG6ckp3g8fTQxmiJwXtjcd0PSS2yTxUBthUAdnSzrid9HL110QvDhrWx8wS4ae8kdgfphZlcGhfQ1H4JuZuMkzXka5Vrmjja4SwFjEnIv3iosiQpCOo3Dh2Ne3pHOoDy/Gtauah3/CgWJ7Y=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2720.namprd12.prod.outlook.com (52.135.103.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Thu, 29 Aug 2019 16:33:43 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6%4]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 16:33:43 +0000
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
Thread-Index: AQHVXlJtbJoJFO7ydka+l2zwcEQXe6cR8PSAgAA0rSCAAAzNAIAAABuAgAAGkYCAAAYCgIAACQgwgAAFHwCAAAJM4A==
Date:   Thu, 29 Aug 2019 16:33:43 +0000
Message-ID: <SN6PR12MB26550ABF84AD52C52DE801CFAEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
        <3e21481ddf53ea58f5899df6ec542b79b8cbcd68.1567071213.git.vitor.soares@synopsys.com>
        <20190829124457.3a750932@collabora.com>
        <SN6PR12MB265551F73B9B516CACB5B807AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
        <20190829163918.571fd0d8@collabora.com>
        <20190829163941.45380b19@collabora.com>
        <SN6PR12MB2655B08176E14BE9DF2BACA2AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
        <20190829172441.3a76385e@collabora.com>
        <SN6PR12MB26553867412178B3F7190F0CAEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
 <20190829181520.0b33b642@collabora.com>
In-Reply-To: <20190829181520.0b33b642@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYzE5Mzk4OWMtY2E3YS0xMWU5LTgyNTUtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XGMxOTM5ODlkLWNhN2EtMTFlOS04MjU1LWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMzU1NyIgdD0iMTMyMTE1NzAwMjExMzk5?=
 =?us-ascii?Q?MTU0IiBoPSJYaHhJZC9mRGdKOG9naUlUc0Ivc2Rpd21JbHM9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUR5?=
 =?us-ascii?Q?T1ZxRWgxN1ZBUmd1Z0M0N3JxYjdHQzZBTGp1dXB2c09BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: e2248aa1-04ed-4904-12fa-08d72c9ea821
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2720;
x-ms-traffictypediagnostic: SN6PR12MB2720:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2720CBC430989FE8D1D1A07FAEA20@SN6PR12MB2720.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(396003)(39860400002)(366004)(13464003)(189003)(199004)(53546011)(76176011)(316002)(6506007)(6636002)(446003)(11346002)(486006)(186003)(14444005)(5024004)(256004)(476003)(66066001)(102836004)(76116006)(66946007)(66476007)(66556008)(478600001)(71200400001)(71190400001)(7696005)(64756008)(7736002)(305945005)(8936002)(54906003)(2906002)(6306002)(33656002)(110136005)(8676002)(74316002)(5660300002)(52536014)(66446008)(26005)(6436002)(81156014)(25786009)(4326008)(3846002)(6116002)(14454004)(55016002)(6246003)(107886003)(81166006)(86362001)(99286004)(53936002)(229853002)(9686003)(70780200001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2720;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m2LB6845PoZir8cLLL66IfhFz7n7uctjzKMbgfMhGHksvg3B8/+krn7SY1Y5vxTHG2bfK2PD8ISZmBGYOrJP/QO9XXunP1jcVEDY4QnQKThF1/PSNwu1h0jrw3aJ4CjZDySemQUnBZdjkJTtKCPuQUDBNkndpM4EYknYegH87QuaDDyxZxzer8irj2pny9M2PI9NVDWTdsEspd1JqVb7EJFYsMU2UshL376sJRFfTVxeSShBVsMf2pqd6a3ZaYptjNrdh1dzhLXGwQShsivlgzmWlBnfQZhc30EfD7DNbO6NeudqiWSLDEH7bMdEeZdI9EYck8vZRWttaS9dPUO43eKWy2cjUL/AlYhv4gM0geuopqT2fpilwMfVfOsiDBKRjwv3XVyGK3Robtoj3hLdSuMgjKMba3029blO1vOab00=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e2248aa1-04ed-4904-12fa-08d72c9ea821
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 16:33:43.2509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eDa8lj5HlxkKyF6XYozSm4zhtRJh1dquFGyBV2VBbZQnPMd960VEnJvETKAfvdHEVkjxwU6AcsnCBMIKCQ1AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2720
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, Aug 29, 2019 at 17:15:20

> On Thu, 29 Aug 2019 15:57:32 +0000
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > -----Original Message-----
> > From: Boris Brezillon=20
> > <boris.brezillon@collabora.com>=20
> > Sent: Thursday, August 29, 2019 4:25=20
> > PM
> > To: Vitor Soares <Vitor.Soares@synopsys.com>
> > Cc:=20
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;=20
> > linux-i3c@lists.infradead.org; bbrezillon@kernel.org; robh+dt@kernel.or=
g;=20
> > mark.rutland@arm.com; Joao.Pinto@synopsys.com
> > Subject: Re: [PATCH 2/4]=20
> > i3c: master: Check if devices have i3c_dev_boardinfo on=20
> > i3c_master_add_i3c_dev_locked()
> >=20
> > On Thu, 29 Aug 2019 15:07:08 +0000
> > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> >=20
> > > From: Boris Brezillon  =20
> > <boris.brezillon@collabora.com>
> > > Date: Thu, Aug 29, 2019 at 15:39:41
> > >  =20
> >=20
> > > > On Thu, 29 Aug 2019 16:39:18 +0200
> > > > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > > >    =20
> > > > > On Thu, 29 Aug 2019 14:00:44 +0000
> > > > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > > > >    =20
> > > > > > Hi Boris,
> > > > > >=20
> > > > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > > > Date: Thu, Aug 29, 2019 at 11:44:57
> > > > > >      =20
> > > > > > > On Thu, 29 Aug 2019 12:19:33 +0200
> > > > > > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > > > > > >        =20
> > > > > > > > The I3C devices described in DT might not be attached to th=
e master which
> > > > > > > > doesn't allow to assign a specific dynamic address.       =
=20
> > > > > > >=20
> > > > > > > I remember testing this when developing the framework, so, un=
less
> > > > > > > another patch regressed it, it should already work. I suspect=
 patch 1
> > > > > > > is actually the regressing this use case.       =20
> > > > > >=20
> > > > > > For today it doesn't address the case where the device is descr=
ibed with=20
> > > > > > static address =3D 0, which isn't attached to the controller.  =
   =20
> > > > >=20
> > > > > Hm, I'm pretty sure I had designed the code to support that case =
(see
> > > > > [1]). It might be buggy, but nothing we can't fix I guess.
> > > > >    =20
> > > >=20
> > > > [1]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__elixir.bo=
otlin.com_linux_v5.3-2Drc6_source_drivers_i3c_master.c-23L1898&d=3DDwICAg&c=
=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DqVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=
=3DIXS1ygIgEo5vwajk0iwd5aBDVBzRnVTjO3cg4iBmGNc&s=3DHC-AcYm-AZPrUBoALioej_BD=
nqOtJHltr39Z2yPkuU4&e=3D    =20
> > >=20
> > > That is only valid if you have olddev which will only exist if static=
=20
> > > address !=3D 0. =20
> >=20
> > Hm, if you revert patch 1 (and assuming the device is properly defined
> > in the DT), you should have olddev !=3D NULL when reaching that point. =
If
> > that's not the case there's a bug somewhere that should be fixed.
> >=20
> > No, because the device is not attached.
>=20
> Oh, my bad, I see what you mean now. This is definitely a bug and should
> have the Fixes tags. I mean, even if we don't care about dynamic
> address assignment, I3C drivers might care about the ->of_node that's
> attached to the device.

I didn't consider a bug because in dt-bindings says to not use 'assigned=20
address' if SA =3D 0.
Do you think there is a better way to solve it?

Best regards,
Vitor Soares
