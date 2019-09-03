Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428FFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0473422D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jwYiFMSk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="pwQPVZEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfICLK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:10:58 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:58302 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728838AbfICLKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:10:55 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EE5F0C0C29;
        Tue,  3 Sep 2019 11:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567509055; bh=ZTWUHGXC0Yc3Ya74zJbp7Nv/Ws2PB5d5DZXJ4Rw3nSY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jwYiFMSkqlXap/iEiFoR0bdLesp00uM8jYz00dvFh3a2gt6tTE/kS0O7nREbYf3fg
         2rrPbMDPfGKB2y+FuakpdVDmXJPDRd6FV2B+aSI/6C55rU+ysCObB3p+ZDP4nVMGaz
         UDQUbFcMICySHaJuRi8IqggQ8Eym8YLnl31It9jLDLwxAsMvUjvmx7vw/ByoJZZJ37
         a+nxW01tgPdBibykjf+Kwimz/NZESB9Q2cIsrFEhzxDHWYZbRUTE8XsdT06D0VsO6Y
         NM7z20RjgFWWqXGGBvjwTjQmU7wiF81jyC67lF74QF19+mgTNrHdzgPX/UaMCZ3MWa
         OZW68owNIxN8w==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BA620A0070;
        Tue,  3 Sep 2019 11:10:54 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 3 Sep 2019 04:10:54 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 3 Sep 2019 04:10:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6UGr8AT0EfZ/TqnIyTllLQtPnwmQqhbCh2X8i9OvoyY3dhspKvdr/PRbbQQRADuc8R3DrOY5xhZtHZwp7eDFvyeENUXSE6GC7M6H3HYj1ycQum2no8ehZ935gp73FmmDjaOw/YddZfQMvfWrqVqpe2VPo8sEBSVF0RDJem0cKFJf2sdGpZwVoolvBslHMTree7N/F59zWTi2VsrSdedzrTH8hOhxhRELTxFvLpr/uvjrVxGzv8yRW74wP+b7oYBPBfla06uDHUXSQ2agrobGBm6biHSY0BG48AqkRNuEjcAIwacc0QT/BznJEJBZ2OwDXgDhHkGH4A6VyqkEunUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjF0BqedSjhBmc5wt236m2GPu948Ho6CXDk7Xa7oiCQ=;
 b=ble6ABCyVqx8BST1vyvLh7JRNPYO6ioOR14Nzc47vmQwynDnl1BeLrmaffh1hJ/BrQOpoVhIyJnZi9fgQ+Fpqolp6e0Im9Mg8FRgCFsLroeMAP89g7pEQ8hQ2LnIFN/ubzk9H+WDi9qAgEg5zhO7IHzEA83f4lukkZA4e09SAn4AwDdqcA9amJXY5/nghLWikH90q0pAdEZ2gaxzhOZZ4o4UNK4yjcdHy08GAfX061QAR/0a3iA+/JAYg1mdCT+bwfL/Q/YdM5CLXtteDQy06BOLZM1ej661Lv7HtPNjh80k02rwBxahpHHJ600cUuypAbnplHVR7vbtydnZopnmkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjF0BqedSjhBmc5wt236m2GPu948Ho6CXDk7Xa7oiCQ=;
 b=pwQPVZEZhiCbZgNuMWnqvGN3tnNG/6nLEjwze/j0oLpqUs8jvQ/dRvo1TSFVldJnln6uU5UFlKAhx3wBAq8N5YZGH370i//tCozhqnOCGJc92YNMto1zrr4P46QybDc1k2DKEwKkokjxgJ0hYE1Kf5lH35lDXUhSeG/BVLhWU1M=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2799.namprd12.prod.outlook.com (52.135.107.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Tue, 3 Sep 2019 11:10:52 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::c4b9:6813:9c58:3fb9]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::c4b9:6813:9c58:3fb9%7]) with mapi id 15.20.2220.021; Tue, 3 Sep 2019
 11:10:52 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pgaj@cadence.com" <pgaj@cadence.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH v2 1/5] i3c: master: detach and free device if
 pre_assign_dyn_addr() fails
Thread-Topic: [PATCH v2 1/5] i3c: master: detach and free device if
 pre_assign_dyn_addr() fails
Thread-Index: AQHVYkN4BGZU9s68oUmgIxnYHrVJiKcZxt6AgAAAe2A=
Date:   Tue, 3 Sep 2019 11:10:52 +0000
Message-ID: <SN6PR12MB2655676567F5A9EFF7619DCDAEB90@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1567437955.git.vitor.soares@synopsys.com>
        <105a3ac1653e9ae658056a5ec9ddc2a084a61669.1567437955.git.vitor.soares@synopsys.com>
 <20190903125237.13a382b2@collabora.com>
In-Reply-To: <20190903125237.13a382b2@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctN2I2NWFlOWItY2UzYi0xMWU5LTgyNTctYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDdiNjVhZTljLWNlM2ItMTFlOS04MjU3LWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMTg3MyIgdD0iMTMyMTE5ODI2NDk3ODg0?=
 =?us-ascii?Q?MTQ5IiBoPSJpUGE2OUVsZjczVnJvT2EzdEkzVldJUGtDRUk9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUQx?=
 =?us-ascii?Q?VHpFK1NHTFZBUzdOMjdQRDF0cENMczNiczhQVzJrSU9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 5c4a2593-9123-4658-34ae-08d7305f6271
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2799;
x-ms-traffictypediagnostic: SN6PR12MB2799:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27994874BDE43E977C3ACD29AEB90@SN6PR12MB2799.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(52314003)(25786009)(14454004)(71190400001)(102836004)(2906002)(478600001)(86362001)(6116002)(3846002)(5660300002)(52536014)(7696005)(76176011)(71200400001)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(6506007)(6436002)(4326008)(7736002)(81156014)(305945005)(476003)(107886003)(55016002)(11346002)(9686003)(81166006)(446003)(74316002)(26005)(33656002)(8676002)(316002)(8936002)(66066001)(6636002)(99286004)(256004)(186003)(486006)(110136005)(53936002)(54906003)(6246003)(229853002)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2799;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ICy87Rss8P5u9DM1ljBGkWzRVdBFbhE5ULn1ZKQx6Y59ys/rFM46674oLS4ne1pdAP+DWyi08GznlPpLL+uLR6eOeE/rAnqmb7+nAO/anMDFfaJTf4/Luz/Uo2W/TvypuHe34y1DS/JFSwIjeNZrLC4J8jjpUPpgDrzm4A9QT7J9YgQdFGwc1lF8v7zwEkxE54CyWue0kMjuqYoA/hiF6qZWVjG6m7ekxMG+XI6viq1aDNopk2BJGYrX443WgAs/h5ehL1FMpauH7D2dhfOP1MvBweMI49ax6XnLOy4RAX9mUHvZnrzqh0iWN3yrWAp5iQ3VEVLgY6ZLQn0+740CmFBZrux5U+yQTadB5ec1h+EIjFZT//d7xOy1eQe7DvoScyKLvCYVhm6crOY09GQv+4YShuOJUBPj9sEJcNt/+C8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4a2593-9123-4658-34ae-08d7305f6271
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 11:10:52.6357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nnKEor21mXA0zgTr59iGU7etoHwYpIIdt+DoI9aLDoWInbnhC7AwVu6/LNtAWJVruQTN8soFFcTd86hUYBQ1Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2799
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, Sep 03, 2019 at 11:52:37

> On Tue,  3 Sep 2019 12:35:50 +0200
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > On pre_assing_dyn_addr() the devices that fail:
> >   i3c_master_setdasa_locked()
> >   i3c_master_reattach_i3c_dev()
> >   i3c_master_retrieve_dev_info()
> >=20
> > are kept in memory and master->bus.devs list. This makes the i3c device=
s
> > without a dynamic address are sent on DEFSLVS CCC command. Fix this by
> > detaching and freeing the devices that fail on pre_assign_dyn_addr().
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > ---
> > Changes in v2:
> >   - Move out detach/free the i3c_dev_desc from pre_assign_dyn_addr()
>=20
> So, you decided to ignore my comment about leaving the i3c_dev_desc
> allocated and skipping entries that don't have a dynamic address when
> forging the DEFSLVS frame instead of doing this
> allocate/free/re-allocate dance, and more importantly, you didn't even
> bother explaining why.
>=20
> I'm not willing to accept this patch unless you come up with solid
> reasons.

I think I already give a strong reason for my decision. Let say that my=20
controller only has space for 4 devices and one of them is offline during=20
pre_assign_dyn_addr() and hence it fails. When device tries to do the HJ=20
I won't be able to do the enumeration because there is no space left.=20
Anyway, you are right and I need to add this to commit message.

BTW, It is not clear to me why should we keep non addressed devices=20
allocated when we have i3c_dev_boardinfo list with ->of_node information=20
and what is the problem with allocate/free/re-allocate dance?

Best regards,
Vitor Soares
