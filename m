Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DB5C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CBA21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DYMREVS7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="RkVyNXjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfLLOtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:49:12 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:36074 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729640AbfLLOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:49:12 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 763E5C00C6;
        Thu, 12 Dec 2019 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1576162150; bh=J+4517qcqBaymE6yCV6qNc8cqPBywGiYHuuAkHR0kFo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DYMREVS7htJl4nJFe6s0VLCilSoZyccrZ7zuy/vbLpEwi0wJQswEUGsq+91SeZVzw
         FU37hBnE/Y1yo6SUY8K0evhSorvq6grQFU7TWBfSdGHvjf9A3II06pgjl6QSf+CIqX
         WJuK7VKhsLSaEixo474BN3piWdlmjIfbnRz3F+9R1n07mECaVpob9OIhEdZOPneCkp
         iJDTx9qDL++elOhJxXhu3xZbWh4hLLx1YTer/5EYLvY7HhMOKvTaaxBNIUFXJnkRR0
         S1lMt89a3ilympk/LBy2Zl4kIkHMfFq/ps0IvnX3CFaljDOt+52sR/G+wL2fvxvqoi
         CpZ5d0Tjr8GqA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 284A2A0087;
        Thu, 12 Dec 2019 14:49:06 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 12 Dec 2019 06:48:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 12 Dec 2019 06:48:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI63fJ2MLUlLipBKuJsvl9+7+wIJYhXD/9wEhiVy63MVtUDuzsv9KrE14lvx29hMf3R23iiO35BjlL+1YR1KJ7nt0f5RGnMRQlF1dBliVHo626pN0SaQDrNZatFYxPOynEtuLIhjyGJXuAWQSDnBA7yfI+eYq4x3EGCEpqR+uPLfYetSA/fLibLuakz2w6ATNZBX6eHXHBvMyQJ4JZSCN1EoNt9JVoaAOH2zkFYFCacPq6cOdHfeVqQjweOGxeP/CoulMuhIyPclcSZ/6T+FK9T0Wgwk7fROwMv8rjevae5wfxp6UGRvKC4c2cfJbjBS0ZwCM7c7rd7ZKPmsvG1Z6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtpYoHuXaQO0Jeb5taM9Urax/gHOFpPzglpCUQo/3P0=;
 b=AOc+b2IWOmHEIZKpH2UF32CrSQSqaxJL/mAg/Rgkkv8HWn1kS2fz/5zMtpczpsTleYQKI95tFuQMOQAfgEoasZ/hQQc8hxzP2q4OLRQ6me6h7eQEAzZ0qafYe3tv0EO6pbipwiBbYeDY/YqLykYtqKfMd0QOJ/aM3YX9igyfd92e18lsWZdUpM3tbx42l9C8g4+Woa0v4pU565M8G1nSzx/5BVuQq35+26lbzCv9SAQxxfI7fCstuVKqfqV7+3yCO7UmkYEGZQr3R2KQlUlWVOdQnueedm1VAE4bx0LTprIbKozbg93cVIAsQA55AtT6gXMf50gUS1QOcPP5LIQvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtpYoHuXaQO0Jeb5taM9Urax/gHOFpPzglpCUQo/3P0=;
 b=RkVyNXjW9G0X87LuQrcpKThkQo9akvhR/iVDjpjV0ErphiRA4D4IOTk7AERzkh3NdjDNUA6+dU8doclh9OWdJR1/MKkh8jeDS8ET4P+WHYq4LxRSfARCDOLnmZBYmbGbY1d9hdMbIB7QKtvgT/pN9TdSIjdQj9GzVQpc9roO+uI=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (20.180.6.151) by
 CH2PR12MB3733.namprd12.prod.outlook.com (52.132.247.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 14:48:58 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::81fc:ad3e:6315:c6ff]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::81fc:ad3e:6315:c6ff%7]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 14:48:57 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [RFC 3/5] i3c: device: expose transfer strutures to uapi
Thread-Topic: [RFC 3/5] i3c: device: expose transfer strutures to uapi
Thread-Index: AQHVr2/iHsu4jOchCU+9H34Yn/scM6e2leaAgAABKzA=
Date:   Thu, 12 Dec 2019 14:48:57 +0000
Message-ID: <CH2PR12MB4216295D1763BF4C0E5FEC85AE550@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
 <fcc51a2758fd7920e1c0163a818fe7c12bd33765.1575977795.git.vitor.soares@synopsys.com>
 <20191212144233.GA1668196@kroah.com>
In-Reply-To: <20191212144233.GA1668196@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctODNkMzdkZDctMWNlZS0xMWVhLTgyNzQtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDgzZDM3ZGQ5LTFjZWUtMTFlYS04Mjc0LWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMjY2NiIgdD0iMTMyMjA2MzU3MzM3OTkw?=
 =?us-ascii?Q?NDQ5IiBoPSJQMXIxVHI0OGJrNHRac3ZRWGhOYzJYWGZybjA9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUF4?=
 =?us-ascii?Q?NVMxRys3RFZBWEZmdDV1dFJLeVNjViszbTYxRXJKSU9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 667c3637-5af6-4e88-7691-08d77f126b22
x-ms-traffictypediagnostic: CH2PR12MB3733:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3733A86485420121B09C3A22AE550@CH2PR12MB3733.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(81166006)(81156014)(66556008)(6506007)(66946007)(4326008)(478600001)(316002)(66476007)(66446008)(8676002)(71200400001)(186003)(64756008)(54906003)(26005)(8936002)(6916009)(52536014)(9686003)(86362001)(5660300002)(7696005)(2906002)(33656002)(76116006)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3733;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMex8i0OsDQMWVWETg4SMqcTjMSmPkeKQScq04o9bCUVp3ssTBAvEagFHaS/78WTFVDfsXGz96/FgMZGXXDONTnQUQe0B+fYIIl5FWKppOhSY5/KoxYQInEtKU6P7oGqMncavwCMZQT7CfNr90dxFsLm9qFUukPZaex/TJUTdJXVjiyPoD6W7NKxe9ixLubxpfUQHHlEM2ScSmq7ksUJaKSEnekS82NiHW89OOOQgMwI6iT9AB1Ll/OjD25IJTAMCS5ziGyWtRO7LI5zoAm0l7qsimeKXAnoJ9WmJhJJsfnxJCP9uEVAmRhNsiBWxYO4hayFL6onwqx4j6EJGAI9f2nuNr1QuoONpr7UHJePpFTJIzPCI/0hyFvnQVz8kkZingVxynxuwKk4d62saIv6tmlpxZ8IzJ2Cbgko+uO4k8gUaSZxJswc/ZrPXgKzkkJO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 667c3637-5af6-4e88-7691-08d77f126b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 14:48:57.9286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NC8Kgu9PyGKIKmNa0blqQAHKxwdGPvgbVax1G30VpHHCjFQvP2LcdJeGQW5KjbIL5YeE7maByntygAHi3iQBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3733
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Greg,

From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, Dec 12, 2019 at 14:42:33

> On Tue, Dec 10, 2019 at 04:37:31PM +0100, Vitor Soares wrote:
> > --- /dev/null
> > +++ b/include/uapi/linux/i3c/device.h
> > @@ -0,0 +1,66 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>=20
> Not a valid uapi SPDX license :(

Sorry, I missed that one. I already got the right SPDX.

>=20
>=20
> > +/*
> > + * Copyright (c) 2019 Synopsys, Inc. and/or its affiliates.
> > + *
> > + * Author: Vitor Soares <vitor.soares@synopsys.com>
> > + */
> > +
> > +#ifndef _UAPI_LINUX_I3C_DEVICE_H
> > +#define _UAPI_LINUX_I3C_DEVICE_H
> > +
> > +#include <linux/types.h>
> > +
> > +/**
> > + * enum i3c_error_code - I3C error codes
> > + *
> > + * These are the standard error codes as defined by the I3C specificat=
ion.
> > + * When -EIO is returned by the i3c_device_do_priv_xfers() or
> > + * i3c_device_send_hdr_cmds() one can check the error code in
> > + * &struct_i3c_priv_xfer.err or &struct i3c_hdr_cmd.err to get a bette=
r idea of
> > + * what went wrong.
> > + *
> > + * @I3C_ERROR_UNKNOWN: unknown error, usually means the error is not I=
3C
> > + *		       related
> > + * @I3C_ERROR_M0: M0 error
> > + * @I3C_ERROR_M1: M1 error
> > + * @I3C_ERROR_M2: M2 error
> > + */
> > +enum i3c_error_code {
> > +	I3C_ERROR_UNKNOWN =3D 0,
> > +	I3C_ERROR_M0 =3D 1,
> > +	I3C_ERROR_M1,
> > +	I3C_ERROR_M2,
>=20
> You have to specify all of these.
>=20
> > +};
> > +
> > +/**
> > + * enum i3c_hdr_mode - HDR mode ids
> > + * @I3C_HDR_DDR: DDR mode
> > + * @I3C_HDR_TSP: TSP mode
> > + * @I3C_HDR_TSL: TSL mode
> > + */
> > +enum i3c_hdr_mode {
> > +	I3C_HDR_DDR,
> > +	I3C_HDR_TSP,
> > +	I3C_HDR_TSL,
>=20
> same here.
>=20
>=20
> > +};
> > +
> > +/**
> > + * struct i3c_priv_xfer - I3C SDR private transfer
> > + * @rnw: encodes the transfer direction. true for a read, false for a =
write
> > + * @len: transfer length in bytes of the transfer
> > + * @data: input/output buffer
> > + * @data.in: input buffer. Must point to a DMA-able buffer
> > + * @data.out: output buffer. Must point to a DMA-able buffer
> > + * @err: I3C error code
> > + */
> > +struct i3c_priv_xfer {
> > +	u8 rnw;
> > +	u16 len;
> > +	union {
> > +		void *in;
> > +		const void *out;
> > +	} data;
> > +	enum i3c_error_code err;
>=20
> Ick, that's a horrid user/kernel api structure that will not work at
> all.
>=20
> Please fix.
>=20
> thanks,
>=20
> greg k-h

Thanks for your feedback, I will address it in next version.

Best regards,
Vitor Soares
