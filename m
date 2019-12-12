Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD5C206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZcdDaRfU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="hPmVIuSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfLLO5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:57:05 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:36486 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728992AbfLLO5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:57:05 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6F7A7C00C7;
        Thu, 12 Dec 2019 14:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1576162623; bh=4RDIewSHGGc4VPKeG8VxfXCXCndT4eEv+G+nqJEV0gw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZcdDaRfUBp1tE8KOQftXfwp5zd60H/ggd7uuRIMP7FR9zxOsrlofLoPXeaph373ym
         L7AZB4zh81ugoxmZy1e5GZGqlWu/Xx+BbhvzjDqCtqR8AKfyHcmR2Mv1CHGVv+Cga8
         MLXxeqwYSuzkbgl2NWXvZc/c7UTt4xFb3+qstCMlvbbI9kqL0K6U7t8afloVVZ9XL4
         yCkQ/ZZbUNgSMYWo01ltVIHT8gZzDRnzJ9nz2Jyekl6unTjLhAFlucj7NLO5AGtjYG
         GeNoAodCJ2rjyhcv48jr84giUts0bvi7hZC6f+bhHvneV9ZOXO5MWHNRo+9rv/uIAO
         ez0vKf3HTsQxA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4248CA008D;
        Thu, 12 Dec 2019 14:57:03 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.13.188.44) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 12 Dec 2019 06:56:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.13.188.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 12 Dec 2019 06:56:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq0hJxGutyxl/ZdEeRD6EyhbllB6HRiWVunpBU3edohNRjrorLDueV9s/JX0wSZsu0ClL9T/XNzVeITAyGb3EqZw4xpuw8DNJ8/YvvP45VZh8OXpk8HL8QEVerGgf/YarsMgpW+5O7NKXMpqMzbhXJXdSErIW8FlVqDJlcMbxUhw5CXlNlmtQYcax4r9n4rjB7JFRoVV8UrcEmYuqTvQm57HucLRlsQj1aDczW746ajVBnivKOx5Lsr4uEW+cLtFZbPZC4HNoTm7hiJ48HrqhvYfy9zUVL4kvCc45sULvxxdiGCq5M85NHkBLkQboIyDurBUtSsm5n+G9ONCT+ytDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGzZy7F1LvTWB30jZIsBFr34QykTO+1e2xfOHyAelkA=;
 b=FdSt+4IkrR4pp1L3CDAea2Nud4OnlUZPQ1XYw50Z4quZSAwrE2uDvGbfV+9JJ5jAnZE5Vv0iWOk9jLRSNlOJ5HD1s+cKBBM+kJr8/EBnvw/ylqOeWsU0Ze5/HYr2qMpASkjjr0KJrD1Lv/inVIcAD7MGGwQbZvYeGT344/Ftl+53VtBy0830fNVYHxpmdixUK32CE4sFbXdyg+0I8VrjKnfOhx5b17zC+ScV8ZT72qJfBvbNJLN3HHzW5QImJcmjdTOtID0bblIvG3lec1WLE9TjaU8gGk65xTMlRtgWtKzal+paaldAu9BssssThrU0p2Ij6Q0pWWpDXi7MzAEiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGzZy7F1LvTWB30jZIsBFr34QykTO+1e2xfOHyAelkA=;
 b=hPmVIuSQ/5vdjz51cKGFBEszHOk37tdM9tZWb8LixF2DjTxT+EqHwbfzv4Cehi+fX/HSSXewvvCOK4SgbBRO8JGoVmkd66S1LkBp6OFnOY2yevEe/A90NV54jghZoQq1MI4Z7SbLGCNYXYJp6VVJYvkqpMGBddJEVkdRqf4aGBE=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (20.180.6.151) by
 CH2PR12MB4183.namprd12.prod.outlook.com (20.180.17.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 12 Dec 2019 14:56:56 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::81fc:ad3e:6315:c6ff]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::81fc:ad3e:6315:c6ff%7]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 14:56:56 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [RFC 5/5] i3c: add i3cdev module to expose i3c dev in /dev
Thread-Topic: [RFC 5/5] i3c: add i3cdev module to expose i3c dev in /dev
Thread-Index: AQHVr2/iKIpGMGLN70aN99S9k54hW6e2lpSAgAABfqA=
Date:   Thu, 12 Dec 2019 14:56:56 +0000
Message-ID: <CH2PR12MB421658E00DF331400728DB6CAE550@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
 <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
 <20191212144459.GB1668196@kroah.com>
In-Reply-To: <20191212144459.GB1668196@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYTIxOWZjNWUtMWNlZi0xMWVhLTgyNzQtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XGEyMTlmYzVmLTFjZWYtMTFlYS04Mjc0LWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iODEyIiB0PSIxMzIyMDYzNjIxNDQ1Njk5?=
 =?us-ascii?Q?NzciIGg9ImlXcUxUcVhOcEJuVWRoZTBkeEZQaEtYdXkxWT0iIGlkPSIiIGJs?=
 =?us-ascii?Q?PSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFBQjVl?=
 =?us-ascii?Q?cXhrL0xEVkFWRFNlU1J4ZStsSFVOSjVKSEY3NlVjT0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFRQUJBQUFBa3hXb2xRQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0FiZ0Jo?=
 =?us-ascii?Q?QUc0QVl3QmxBRjhBY0FCc0FHRUFiZ0J1QUdrQWJnQm5BRjhBZHdCaEFIUUFa?=
 =?us-ascii?Q?UUJ5QUcwQVlRQnlBR3NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3QndB?=
 =?us-ascii?Q?R0VBY2dCMEFHNEFaUUJ5QUhNQVh3Qm5BR1lBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdCbEFI?=
 =?us-ascii?Q?SUFjd0JmQUhNQVlRQnRBSE1BZFFCdUFHY0FYd0JqQUc4QWJnQm1BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4QWRR?=
 =?us-ascii?Q?QnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFjd0JoQUcw?=
 =?us-ascii?Q?QWN3QjFBRzRBWndCZkFISUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCekFHMEFhUUJqQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BZEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWRBQnpB?=
 =?us-ascii?Q?RzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0IxQUcwQVl3QUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFad0IwQUhNQVh3QndBSElBYndCa0FIVUFZd0IwQUY4QWRB?=
 =?us-ascii?Q?QnlBR0VBYVFCdUFHa0FiZ0JuQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCekFH?=
 =?us-ascii?Q?RUFiQUJsQUhNQVh3QmhBR01BWXdCdkFIVUFiZ0IwQUY4QWNBQnNBR0VBYmdB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BWVFCc0FHVUFjd0JmQUhF?=
 =?us-ascii?Q?QWRRQnZBSFFBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQWN3QnVBSEFBY3dCZkFHd0FhUUJqQUdVQWJnQnpBR1VB?=
 =?us-ascii?Q?WHdCMEFHVUFjZ0J0QUY4QU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUc0QWNBQnpBRjhBYkFCcEFHTUFaUUJ1QUhNQVpRQmZBSFFBWlFCeUFHMEFY?=
 =?us-ascii?Q?d0J6QUhRQWRRQmtBR1VBYmdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFIWUFad0JmQUdzQVpRQjVB?=
 =?us-ascii?Q?SGNBYndCeUFHUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQT0iLz48L21ldGE+?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=soares@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c9b4286-ca2b-41c3-14ba-08d77f138831
x-ms-traffictypediagnostic: CH2PR12MB4183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4183FDA14AE6D421E0CB54D6AE550@CH2PR12MB4183.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(26005)(8936002)(54906003)(55016002)(2906002)(6916009)(9686003)(316002)(86362001)(186003)(4326008)(33656002)(81166006)(81156014)(52536014)(478600001)(6506007)(8676002)(5660300002)(76116006)(4744005)(71200400001)(66446008)(66946007)(66556008)(64756008)(66476007)(7696005)(42413003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB4183;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9QoolYsDI4yytAb0i66SGGdxZ7qTjc2ToNSqb0Zc0C22ggmXS0Pm2ExomZdJeWgKehdk9TCbzJrJnPqe8w+nUz0gtQdzVwRwJwQc5rb5HWqMwbMYLChmnkexxQqCrZRdb75PnzkPy1/KHDV2O4qa3Lno96NgQSa6BwrFyk+uQL4nmEh+Jy/TisZb8m3kG+FveNL3P/bRvyfN4jChMnFQhsN+buqxRXuRl4lI/w/6r89cQNT8X5lDPfBAZESGni59SpRJe9/lCwNUTtbB5o1wIxG7kjQMxa023NeDUbntGvV90oJ8arYm5Su50+6v3GWr9AYGeeTcqRfulm1LiYHSlrUTM5xnYNuwcNZOzF3ymaU3MGm3haSY834Unu4RhU3mdBzwLTAQesxTl6n6B0DSt8BmJ7cUNSHOMqk23z42VaO3i72pmLGkUorzB684vKmPMO1S2fE70RnfseXAiocqJ1/xlvTxnE7qyXdMiszgVHNGWmU5v3BU5d6JGVBj8KUije/R8cwRW7338omvv7kwYA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9b4286-ca2b-41c3-14ba-08d77f138831
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 14:56:56.1133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXINpWd0xSIitXUzLT2UO2tNTk/ccbtqboLS+gHTI6VJEIuwEFcYudiE3nlZpiKktp9Ln4RsmUN4Kdv9KSQNwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, Dec 12, 2019 at 14:44:59

> On Tue, Dec 10, 2019 at 04:37:33PM +0100, Vitor Soares wrote:
> > +static int __init i3cdev_init(void)
> > +{
> > +	int res;
> > +
> > +	pr_info("i3c /dev entries driver\n");
>=20
> Please remove debugging information, kernel code should be quiet unless
> something goes wrong.

I will remove it.

>=20
> > +	/* Dynamically request unused major number */
> > +	res =3D alloc_chrdev_region(&i3cdev_number, 0, N_I3C_MINORS, "i3c");
>=20
> Do you really need a whole major, or will a few minors work?
>=20
> thanks,
>=20
> greg k-h

I'm reserving one per device. What do you suggest?

Best regards,
Vitor Soares
