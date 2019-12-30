Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A838C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202D3206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WWlF3jji";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="k7ib2ezW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfL3NkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 08:40:18 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36818 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727445AbfL3NkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 08:40:17 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 396C7C09CF;
        Mon, 30 Dec 2019 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1577713215; bh=lIm1jiTnyuIxfH82eST42EyfV/j1+5QcxafCVSv/KBI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WWlF3jjingcsAoZWgleapFEYZ+Qt1Ee6tY54e5MibPTqlgv6bmBXgCbUixTPRnCNx
         oe4LSFIT0rcZGHIuJy/loOhkbaEyY+ZFslyH9A8d5QMbWS4i7bATB380mYRJMYrVWT
         pS2kgckc5sOa6XWcuInIpvgjfd1GzEnMQ19aCl/2QiWqmeQfpldau4c8cfkqP0m0Z6
         CsMnXygnTucn8PS8TTQJgTjwS/kp56ZSCKQJzmU5MXyGtKQVyhLKwNkUmmAgOzfgRC
         Iyx7haNsX6EEewhmhYlzaL1IWHlcZySwFZ+JnsjVkJmwRukM3VRRiLggk2a//wVRZG
         PRP3Ftht1NE2w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 86B1AA0083;
        Mon, 30 Dec 2019 13:40:13 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 30 Dec 2019 05:40:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 30 Dec 2019 05:40:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4xUE2s1s8aLH5wgr/ZC3KfqAWSJ9gLMEUVYu18PHS1Cq4BSQLOias42LaFbivLkcI+qAcmIMyKsPOrrRnzBbmym46DclpHSwwg2T+uVEQeWfdb/8YYv1vysD3goWxphE15BNkfbVZK7BnZ07z1CyIM7C7EvbCA2ZL9nZvyW8pKEQF6M8PMi62vqlsL9SLGZv8DurWldFhWinUrHtrq2dwb2rqzelv3g755BKxsf7V/f1k8F7Ki5PveWMcOA6nuCkypuP+xPUsJmEhFrQ37MhB+dX5ZLxYQrEcX9NV1ZnREeg8UGGiADttZtlgtAtgkNMEv1bE6n/za5FL0ZW1h70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kttlO1gSQq9hW2auOhVRMZ9j4TQ236cZ0LqDwtU4I3U=;
 b=m2vns4pSwOY6tJwPM463ppav474Dqyd1Z3B6dUpd3nnjEd7RNmCgxFRjwUaBUbL5Opd90dwWoDDO/9X6cY968GgAuFKxIwDsVh7TZ0UJR+jD99SdLDV+XIVq2uEagtVTQzgNB0msV5ZEuVaNUfFo8Ro5q07UpT1jfBczunzR4/klddr+35jSTLyDGZRDkE4r8zfz8RJrkJP+Pc/6AAm1iXuWBOF4TBAVHCWZ+WkDqJdu92//xfBVA60S8Fp0Fq4/8ChOF/B37G/9laXx3ow9+X+xli9ChNQbLQ7AChyQWtfAf1ILqEJO/9XZd8jlM18RExwrONqdpzoGxIJTeb12Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kttlO1gSQq9hW2auOhVRMZ9j4TQ236cZ0LqDwtU4I3U=;
 b=k7ib2ezW6RKKGatcTugREBIGCs7uiuu8z4/cpGhHKBDSEaGSzUzCs3THJbI1vNK3x/fY5INbVSAvYpuz9ND/pjTEKuvLZ8R6+sxEPM87qyQxlLHeBI6HHdFbs4lkkklz8F0Oolh3W47uTtv1GXUTP2swoT2pfMX6xc5Qm4U5/2Y=
Received: from MN2PR12MB4223.namprd12.prod.outlook.com (52.135.48.146) by
 MN2PR12MB3773.namprd12.prod.outlook.com (10.255.236.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 13:40:11 +0000
Received: from MN2PR12MB4223.namprd12.prod.outlook.com
 ([fe80::9904:67ba:929a:eca0]) by MN2PR12MB4223.namprd12.prod.outlook.com
 ([fe80::9904:67ba:929a:eca0%5]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 13:40:11 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "pgaj@cadence.com" <pgaj@cadence.com>
CC:     "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] i3c: dw: convert to devm_platform_ioremap_resource
Thread-Topic: [PATCH 1/2] i3c: dw: convert to devm_platform_ioremap_resource
Thread-Index: AQHVvbA5eAuj0awaTkuHsl9XvZifT6fSll7g
Date:   Mon, 30 Dec 2019 13:40:11 +0000
Message-ID: <MN2PR12MB4223E00D8862033751A7DEFFAE270@MN2PR12MB4223.namprd12.prod.outlook.com>
References: <20191228185406.26551-1-tiny.windzz@gmail.com>
In-Reply-To: <20191228185406.26551-1-tiny.windzz@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZTQzNzc5OTUtMmIwOS0xMWVhLTgyN2EtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XGU0Mzc3OTk2LTJiMDktMTFlYS04MjdhLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMTM3NSIgdD0iMTMyMjIxODY4MDkwMDE2?=
 =?us-ascii?Q?MDE4IiBoPSI1ZTFzYVlDOGpqSHpSc3ZRNDJMeFRxZmZRaVk9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUFT?=
 =?us-ascii?Q?UVF1bkZyL1ZBZFJ4blBsSGxRd24xSEdjK1VlVkRDY09BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQWt4V29sUUFBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
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
x-ms-office365-filtering-correlation-id: 943c6744-c4d7-4179-869f-08d78d2dcb1a
x-ms-traffictypediagnostic: MN2PR12MB3773:
x-microsoft-antispam-prvs: <MN2PR12MB37737156AC64DF4CBE235AF0AE270@MN2PR12MB3773.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0267E514F9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(5660300002)(110136005)(54906003)(55016002)(86362001)(2906002)(316002)(186003)(9686003)(478600001)(52536014)(81166006)(76116006)(7696005)(66946007)(4326008)(66476007)(26005)(64756008)(81156014)(33656002)(6506007)(8936002)(71200400001)(66446008)(66556008)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR12MB3773;H:MN2PR12MB4223.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XqePxCW4DVafL3mVLYwviMChACYPpUxIoW2UUj6YCZN9Jga37jTD4m3VnOVgpgCwpqM+43pV1vqbGJMQtKbwkr5sDT+jxDCRmJbzR+UntFT0wiWwJmm0TIuqEakWz+mhCH/tNR+waZttCOVRsp125UVwLSKNnNuzwXt+WMXexraMYvhfY8r7RsZy2YoUPUBQO7FwMMbaxx6GsaidxmEvRFg0Tei1luybaBDtYb8AABRY7Sj5uThxRhvmkYlQtovPK0vogDq2iBBMZJca08azLftSXLYXqkoAiGSs9OyLDzDi2nBJpbPUF7zKDx71CwvX+dOQxCX+85sfqgynPin+L3bhxcyKIR48t4xAvUXNT/sl+wZFUAJWM2eCMgNeK6Wlye6j9zqgTzP1F1Ld0CN0cnsMC7CWBVsov69/3cU5BO9RQ72Bjda6b0hNAPCz37jX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 943c6744-c4d7-4179-869f-08d78d2dcb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2019 13:40:11.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7b+Qb5Xsp27QJUFbxGEVp+UTK9zEItPDa7U1mx3BsvZ2QEK9VTtjTy3H+gfCQGwtYVX0sgG23HPnEKg/nAz7AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3773
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

Thanks for your patch.

From: Yangtao Li <tiny.windzz@gmail.com>
Date: Sat, Dec 28, 2019 at 18:54:05

> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i=
3c-master.c
> index b0ff0e12d84c..7b941e93337f 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1100,15 +1100,13 @@ static const struct i3c_master_controller_ops dw_=
mipi_i3c_ops =3D {
>  static int dw_i3c_probe(struct platform_device *pdev)
>  {
>  	struct dw_i3c_master *master;
> -	struct resource *res;
>  	int ret, irq;
> =20
>  	master =3D devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
>  	if (!master)
>  		return -ENOMEM;
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	master->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +	master->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(master->regs))
>  		return PTR_ERR(master->regs);
> =20
> --=20
> 2.17.1

Acked-by: Vitor Soares <vitor.soares@synopsys.com>

Best regards,
Vitor=20
Soares
