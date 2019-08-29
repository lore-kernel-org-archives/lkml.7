Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF0C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFEE20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wfspnsjq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="pKkkZxz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfH2QXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:23:34 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:45042 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbfH2QXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:23:33 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 850ABC0373;
        Thu, 29 Aug 2019 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567095812; bh=OkfUEA4fDCL5D15Qo86PJvPEp1kPkGDkxp7ICce3/mc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Wfspnsjqo1zfST4bJ7NP5ySJooXRi1SVO+0v8HWa+tRbqtT2QIdO1N1HhPx0f5Yf+
         K8nN1yJYvKynT2GvL81ChI9v8Im1tjJwTtEuVeCHgM8ReQi9Gv3BcDqmySOKkkMlmn
         m2MBNbrPUoeUAJ1bC39y5hk/5TmyDcsxsX6Yg1Wm6xFsOosYOoxR6er0LoyoBQznLt
         PnUIO/PjjGsIfP0B277wu4e/7VhLTBXl7f5s4ImOrQm+LVYlPw0OMXhoAXJXGiVoYX
         sABdyFCgfBScpbKbeyGztzvkaaZhErBBukQHyYX3i1IqI0MnOs3VsW77wsfsZywpg5
         nh/M0LAqLR6QQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5CBBBA005A;
        Thu, 29 Aug 2019 16:23:31 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Aug 2019 09:23:31 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 29 Aug 2019 09:23:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhfgltRHO4fvsZQqMZ3xTlxeyrSlDuDDPhIVVMviNvVKjK6tTGA4mSE2FVM9gshmjiVAf8AJ57tGi6EGVmJVbR6j1QR9upa+j8uWEMTx2V4hypdNCURb4OALeVEbHRbJjK0dduYpZ78Cf6T7dwVGYVN4btfb1rwtevrsswT09ZepXc7l0QES0pixy1AiXHCR00emrdErQK1wMR2Olxz9f6rme00BvUg5fEZsnFU473N9atQC133JoRUOwbggp/Fd7j7a36H/hp5uF6nvLK3BxhkdLKjfS1dgNqIhKTXlPED0821r1r478g3JvpznSLv3hLJcrvm+XFPa0BgmW92vNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7urgcOueMLPQl49eWJgRD4/DYmQKYL5VwZIViZoh1M=;
 b=SByeA2I31uA7bqX0vgtiku2EcCPGHPSpM8Qyz8AcEjHZ+ZDCnp2DsBuMhU/T25HdWlJD2vCCqgygQaQqFJr+vTSS4xrZQQtbNIHLUI8HzFOLFvxB9k5rw4iHYR7Mf+GIyBGaylVodAeN7voT9h9d9Ac61Iyw5yfD3XQtNietmUT2qwqooOeCIOei9vLj8cmeMDhuCeZuhMtMXTwyBz6XaJr248VO77HrDPzuLYnVyrtQFfxLNSMG2yarXBbTsV87zCPIDWC36lx4uokobYwDa6AALLvjYVdBp38oFoyNo+ZHwOt7Ul3oyH+qpqQGOpAknU9BvAcRst32r40/6ezJCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7urgcOueMLPQl49eWJgRD4/DYmQKYL5VwZIViZoh1M=;
 b=pKkkZxz52e/I9/y++ia8L3tNvvpBJZcdv4M+NGqUCARVMXwWvym3M9mgdxhT96py1j7JgdVqvF3Rxyl/nPGjMfLf1p8S2SpJihANnjSEP3FCx78Z0AueljFPdqpF0c+W5EsUtkUB9/moKfG/f5WT7y3X+Iyf8aZiYA2/4p/4E5Y=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2781.namprd12.prod.outlook.com (52.135.107.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 29 Aug 2019 16:23:29 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6%4]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 16:23:29 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: RE: [PATCH 1/4] i3c: master: detach and free device if
 pre_assign_dyn_addr() fails
Thread-Topic: [PATCH 1/4] i3c: master: detach and free device if
 pre_assign_dyn_addr() fails
Thread-Index: AQHVXlJs0CsMPtNc5UG5qMD4ebbBaKcR7+uAgAAtCrCAABRdAIAACbBQgAAHloCAAAhj0A==
Date:   Thu, 29 Aug 2019 16:23:29 +0000
Message-ID: <SN6PR12MB2655F2C2851DA16E2C624998AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
        <e26948eaaf765f683d8fe0618a31a98e2ecc0e65.1567071213.git.vitor.soares@synopsys.com>
        <20190829124115.482cd8ec@collabora.com>
        <SN6PR12MB26551F172804D039F3EAA991AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
        <20190829163520.126d42d6@collabora.com>
        <SN6PR12MB2655E9E544D7E96323BAC796AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
 <20190829173709.79c093dd@collabora.com>
In-Reply-To: <20190829173709.79c093dd@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNTM2ZjEwOGUtY2E3OS0xMWU5LTgyNTUtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDUzNmYxMDhmLWNhNzktMTFlOS04MjU1LWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iNTYyNCIgdD0iMTMyMTE1Njk0MDcyMjcw?=
 =?us-ascii?Q?OTc0IiBoPSJRZUlvdzRBVm9xM0FwclpoNVNJaElNZTFpTms9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUIr?=
 =?us-ascii?Q?a0c0V2hsN1ZBUUFoTnJxRFFCL0JBQ0UydW9OQUg4RU9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 279b384f-86ad-4d85-11ae-08d72c9d3a6c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2781;
x-ms-traffictypediagnostic: SN6PR12MB2781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB278185011111F62D52D7FA0EAEA20@SN6PR12MB2781.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(52314003)(99286004)(53936002)(9686003)(2906002)(8936002)(3846002)(6116002)(55016002)(54906003)(5660300002)(52536014)(14454004)(229853002)(478600001)(256004)(5024004)(316002)(14444005)(86362001)(6436002)(110136005)(186003)(25786009)(102836004)(8676002)(446003)(26005)(33656002)(76176011)(11346002)(6506007)(71200400001)(4326008)(71190400001)(7696005)(476003)(486006)(6246003)(64756008)(7736002)(74316002)(66556008)(66446008)(305945005)(81156014)(81166006)(66476007)(76116006)(66946007)(66066001)(6636002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2781;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vWsWzNkeI9xBxKnFxf/DsMErKvm0R2Qk9gIYKmK3ek/XZWNhaY3uNABNoGt+aiqCnK7vtepRAH29zWOvZ9bFaj05H4vO660OwkSq5dUfO/ZWA9Q5GG5Yv//hvSvN+vEERX9vTeogm5N2cQH+wnEod2iWeDziP1Zr21X6GegoKEqa7A1cbo9rHsncOJJpsdwJXN9JYitCIRZgk3fGXpeQZmmZB6kMJiAM7EHd4CkV+Tp/hY+K4WYPjEfSom+jbM/Y8EZ9W0CazIIMLz7R9E0UwQ1mA1jUxBFJbm36zEn8GUXuox+3EM0zx67/m1U0ZRo122vknNpDscIABs2NMJBlbeZ4ECjhG8PZt/5OwirbxoEk344heA2ZPpwBmd9GQAbT3efgE7B1KXPJnSQyWFJxNI0Wn83Np36RnBqXMoFkuKo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 279b384f-86ad-4d85-11ae-08d72c9d3a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 16:23:29.6723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+ELVMnot42rEvzr6wgs2Gf+HjjinGtROKVvscG1AzACbmPm9Ep5CZDMVlunBFkSOO4jcy6vjsZq2O+27W99YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, Aug 29, 2019 at 16:37:09

> On Thu, 29 Aug 2019 15:23:30 +0000
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> > Date: Thu, Aug 29, 2019 at 15:35:20
> >=20
> > > On Thu, 29 Aug 2019 13:53:24 +0000
> > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > >  =20
> > > > Hi Boris,
> > > >=20
> > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Date: Thu, Aug 29, 2019 at 11:41:15
> > > >  =20
> > > > > +Przemek
> > > > >=20
> > > > > Please try to Cc active I3C contributors so they get a chance to
> > > > > comment on your patches.   =20
> > > >=20
> > > > I can do that next time.
> > > >  =20
> > > > >=20
> > > > > On Thu, 29 Aug 2019 12:19:32 +0200
> > > > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > > > >    =20
> > > > > > On pre_assing_dyn_addr() the devices that fail:
> > > > > >   i3c_master_setdasa_locked()
> > > > > >   i3c_master_reattach_i3c_dev()
> > > > > >   i3c_master_retrieve_dev_info()
> > > > > >=20
> > > > > > are kept in memory and master->bus.devs list. This makes the i3=
c devices
> > > > > > without a dynamic address are sent on DEFSLVS CCC command. Fix =
this by
> > > > > > detaching and freeing the devices that fail on pre_assign_dyn_a=
ddr().   =20
> > > > >=20
> > > > > I don't think removing those entries is a good strategy, as one m=
ight
> > > > > want to try to use a different dynamic address if the requested o=
ne
> > > > > is not available.   =20
> > > >=20
> > > > Do you mean same 'assigned-address' attribute in DT? =20
> > >=20
> > > Yes, or say it's another device that got the address we want and this
> > > device doesn't want to release the address (I'm assuming the !SA case=
).
> > >  =20
> > > >=20
> > > > If so, it is checked here:
> > > >=20
> > > > static int i3c_master_bus_init(struct i3c_master_controller *master=
)
> > > > ...
> > > > 	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
> > > > 		struct i3c_device_info info =3D {
> > > > 			.static_addr =3D i3cboardinfo->static_addr,
> > > > 		};
> > > >=20
> > > > 		if (i3cboardinfo->init_dyn_addr) {
> > > > 			status =3D i3c_bus_get_addr_slot_status(&master->bus,
> > > > 			^
> > > > 						i3cboardinfo->init_dyn_addr);
> > > > 			if (status !=3D I3C_ADDR_SLOT_FREE) {
> > > > 				ret =3D -EBUSY;
> > > > 				goto err_detach_devs;
> > > > 			}
> > > > 		}
> > > >=20
> > > > 		i3cdev =3D i3c_master_alloc_i3c_dev(master, &info);
> > > > 		if (IS_ERR(i3cdev)) {
> > > > 			ret =3D PTR_ERR(i3cdev);
> > > > 			goto err_detach_devs;
> > > > 		}
> > > >=20
> > > > 		i3cdev->boardinfo =3D i3cboardinfo;
> > > >=20
> > > > 		ret =3D i3c_master_attach_i3c_dev(master, i3cdev);
> > > > 		if (ret) {
> > > > 			i3c_master_free_i3c_dev(i3cdev);
> > > > 			goto err_detach_devs;
> > > > 		}
> > > > 	}
> > > > ...
> > > >=20
> > > > and later if it fails i3c_master_pre_assign_dyn_addr(), the device =
can=20
> > > > participate in Enter Dynamic Address Assignment process.
> > > > I may need to check the boardinfo->init_dyn_addr status on=20
> > > > i3c_master_add_i3c_dev_locked before i3c_master_setnewda_locked(). =
=20
> > >=20
> > > I need to double check but I thought we were already handling that ca=
se
> > > properly. =20
> >=20
> > Yes, it is handled in the code above.
>=20
> No, I meant the 'assign init_dyn_addr even if !SA', and the code I
> pointed in my other reply tends to confirm that this is something we
> already take into account (maybe not correctly, but the code is here).

Please check my last comment in patch 2/4.

>=20
> >=20
> > >  =20
> > > >  =20
> > > > > Why not simply skipping entries that have ->dyn_addr
> > > > > set to 0 when preparing a DEFSLVS frame   =20
> > > >=20
> > > > I considered that solution too but if the device isn't enumerated w=
hy=20
> > > > should it be attached and kept in memory? =20
> > >=20
> > > Might be a device that supports HJ, and in that case we might want th=
e
> > > controller to reserve a slot in its device table for that device.
> > > Anyway, it doesn't hurt to have it around as long as we don't pass th=
e
> > > device through DEFSLVS if it doesn't have a dynamic address. I really
> > > prefer to keep the logic unchanged and fix it if it needs to be fixed=
. =20
> >=20
> > Well, we aren't reserving a slot because we need another one to attach=
=20
> > the device when it is enumerated and hence a device may be using 2 slot=
s=20
> > in the controller.
>=20
> Right, you shouldn't reserve a slot when ->static_address =3D=3D 0 &&
> ->dynamic_address =3D=3D 0, but I still don't see where the problem is wi=
th
> the solution we have right now, sorry. Note that even if you reserve a
> slot in that case, the device only occupies 2 slots for a short amount
> of time, because the add_i3c_dev() logic will detect that the descriptor
> already exists and reattach the device with its new address.

I understand that but if we have limited resources it is a problem.

>=20
> > It may cause problems in HC with reduced slots and it is another reason=
=20
> > why I think we should detach device without dynamic address after the=20
> > enumeration phase.
>=20
> Can you please try the approach I suggest? =3D> fix the existing logic to
> make it work without this "free undiscovered dev desc, reallocate later"
> dance.

I can do that but we still have the issue above to solve and figure how=20
to set a dynamic address for devices without static address.






