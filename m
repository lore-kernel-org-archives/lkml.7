Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719A2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA7B233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jsUUxeis";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="ZDIGq3Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfH2OJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:09:14 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:43464 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727417AbfH2OJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:09:11 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0E580C0390;
        Thu, 29 Aug 2019 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567087751; bh=Layv2dt5riqfJOLGDz3cvqpfNNT1XqASYgyV14nGNnA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jsUUxeisjka1mye0hORR8vTYt4BL3andOJgpfbWLVlI9ubQ57RMNNgfkhBzsjnRiL
         jXDKTd4zsocvGgT8t+9yijUfPLf/qmUyX/FwDPH7+Km495bgHXaA3jassXVfxHWyjQ
         92dw5IEvSLfUiMpDMXXb5lqAPERR3p8tjbWDRl9aGFaJy4kzBJPxXQMSMtJ581UX3o
         gLB2heVplCCq3LANi8wp90q+/+b0TNZ/wpS2f2zCeJRpWcRPB9seAQj6IrU/YWjv/i
         crHDeXqg1dDBhdE8p13S98LmtQJ1Jy/yZuLSqeDQqODFmpgeIG5oL23yWsu02uOhmj
         9bXkPyhHngBgg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E0C28A023B;
        Thu, 29 Aug 2019 14:09:10 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Aug 2019 07:09:09 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 29 Aug 2019 07:09:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjEWvHtDw/CWc/ng4JaL6p8Or7imQvSQLbbRNe+CMgd1NQotewzG6kjHbtE2AW+x3jqhj/g17E9Dj2i2NfRSsAJMduXxHGxcOohK2D7SOBu32pdzUQZBgDuzPjjwP9TDhesN/6Ww1BsTDGVJDm31XD4fSDiJp5TSiueYkAeg4eUW1S4TGguOYca5e6BzAdvnTOATLlake/Byv3stod3fRaEpPZXh1EirEH8WZWv0kJjnXIlf//9oVaYf9ceo2ru1+scX8xo/fr/N2mgqF1kLkN+ViGqOpERWPV3wIAUwK5NfGhUqtSFcePiIrHj1YY8XC2VbuxUnvQLLa8qkl5zx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzRhcCAWxUTgsw7qcL2abvwSlBoD4LUcNanOtUu80kQ=;
 b=CidKY3amkFmL9OHlQpwuyMXezu59lJ6XmoyCIbIPR8eeSclPstJ7nmKAb4083pGD+d0JgAtI7nePSoqU5qv3veWHRCqtfZj6HuLrgjCkl4NmFLropye6KeKhXRRFNqKu9TwSb2oLd67usm1st/XuniPuR75mLr+dxlttKdyTtYUy2n+5pWILw7Kq8zNr73Y5fTW7SV+1t6wXUFlyzfF02s+j9iApgN+VcCANljeOuiG8lv952i6V1IBoWowWgWsVMVfGF5ANtwMqxUtWo94oFPRCt6qKYEGd9rvJqSXTiZ1PZpZCWq2PZWNJPl71okkLHK08j8skbuygNm0yNGMyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzRhcCAWxUTgsw7qcL2abvwSlBoD4LUcNanOtUu80kQ=;
 b=ZDIGq3Ee+lD/n2HRKpP4YZ7KfcSvyvjcHiiWt5QRap7obsds3V5nM5GHJL5T5bfQ4uDoLosiHYeVtbNS1Aq+NDPXrNFJoc/rQX3XIQBpdO4ErfXx1DqV0UfQEvV6qSn65oJIbYufHO1UbGR0994CXCAGrSS/68LYsljWOwbxIK0=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 29 Aug 2019 14:09:09 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6%4]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 14:09:09 +0000
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
Subject: RE: [PATCH 4/4] i3c: master: dw: reattach device on first available
 location of address table
Thread-Topic: [PATCH 4/4] i3c: master: dw: reattach device on first available
 location of address table
Thread-Index: AQHVXlJtIp4F4pXufkmtQ4ohVfCkbKcR+XCAgAAvvRA=
Date:   Thu, 29 Aug 2019 14:09:08 +0000
Message-ID: <SN6PR12MB265539D98E3B4571C1705799AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
        <e03fb41054a8431b27cc84c3d83ada9464172ef7.1567071213.git.vitor.soares@synopsys.com>
 <20190829131519.3f420c64@collabora.com>
In-Reply-To: <20190829131519.3f420c64@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctOGY3N2UzMmMtY2E2Ni0xMWU5LTgyNTQtYjU5ZDc5?=
 =?us-ascii?Q?N2QzNzhiXGFtZS10ZXN0XDhmNzdlMzJlLWNhNjYtMTFlOS04MjU0LWI1OWQ3?=
 =?us-ascii?Q?OTdkMzc4YmJvZHkudHh0IiBzej0iMjI0OCIgdD0iMTMyMTE1NjEzNDY0MjU0?=
 =?us-ascii?Q?MDk2IiBoPSIyaU5tMXE5K2F2eXoyRUZ4WlJGc2NWWWRSVTA9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUNR?=
 =?us-ascii?Q?MXRGUmMxN1ZBZVZjOElRbUpzOWI1Vnp3aENZbXoxc09BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 810117fe-844c-4a17-d2de-08d72c8a75d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2734;
x-ms-traffictypediagnostic: SN6PR12MB2734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27343EEA41851C0108E40ECFAEA20@SN6PR12MB2734.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(199004)(189003)(11346002)(446003)(476003)(486006)(186003)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(71200400001)(71190400001)(6506007)(102836004)(26005)(7696005)(76176011)(86362001)(33656002)(3846002)(6116002)(256004)(229853002)(5660300002)(66066001)(52536014)(2906002)(4326008)(6636002)(74316002)(305945005)(8936002)(81166006)(8676002)(81156014)(14444005)(316002)(478600001)(9686003)(54906003)(110136005)(99286004)(53936002)(55016002)(7736002)(107886003)(6246003)(14454004)(6436002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2734;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nIG8ZvUnaTVqmTuM4PJ6TWBW0+paSYCyJh/k8JedD8q8C/j2w4dIMOVG3Abkl8WMhSFoZ3o4xYuvLKg1XB2eERHCQlOzvP+jh/CW3W1kIAG+hQu21bNul21+WgY5FznThlPNNbv5PJhgA8FLv69dVdJnQVKIe4DBruVR5qsWALhROBOdTvBvAgW6NK1F8P2DWXLlqDcIjFpmaO075fSXvu9STjmqbTuCUjGxT7TOPn0YQFkQxBsun8ljhEE8JnrTB6bpab/62lr0XEAFZgMiXRURSjKbSxTNpa1WDTjK9Q6XEjdkrpjk2G4LoQbCvCASb+aKQp6x0jk5xNYji6SfFKVvBzpeJvdEiGH0MR/XOV1NpXSP+eYDgkfQsjh4ECtht/Hy8lqc+K08LWyGuqsuhF9YQlTmV7GnJN/Gqoux5Aw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 810117fe-844c-4a17-d2de-08d72c8a75d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 14:09:08.8866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/UEr987AcGMFSR/DzKtR1IJFRwsxVw97VpJ3dysho5/fUyxN1CUAlEGt/V+if7eWSg/66pdCx8h/4SOsoX61Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2734
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, Aug 29, 2019 at 12:15:19

> On Thu, 29 Aug 2019 12:19:35 +0200
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > For today the reattach function only update the device address on the
> > controller.
> >=20
> > Update the location to the first available too, will optimize the
> > enumeration process avoiding additional checks to keep the available
> > positions on address table consecutive.
>=20
> Given the number of available slots I honestly don't think it makes a
> difference, but I also don't mind this change, so

The slots are HW dependent. The point is, I need to guarantee the=20
available slot are consecutives.
If you have any suggestion I appreciate.

>=20
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>=20
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > ---
> >  drivers/i3c/master/dw-i3c-master.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
> > diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw=
-i3c-master.c
> > index 1d83c97..62261ac 100644
> > --- a/drivers/i3c/master/dw-i3c-master.c
> > +++ b/drivers/i3c/master/dw-i3c-master.c
> > @@ -898,6 +898,22 @@ static int dw_i3c_master_reattach_i3c_dev(struct i=
3c_dev_desc *dev,
> >  	struct dw_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
> >  	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
> >  	struct dw_i3c_master *master =3D to_dw_i3c_master(m);
> > +	int pos;
> > +
> > +	pos =3D dw_i3c_master_get_free_pos(master);
> > +
> > +	if (data->index > pos && pos > 0) {
> > +		writel(0,
> > +		       master->regs +
> > +		       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
> > +
> > +		master->addrs[data->index] =3D 0;
> > +		master->free_pos |=3D BIT(data->index);
> > +
> > +		data->index =3D pos;
> > +		master->addrs[pos] =3D dev->info.dyn_addr;
> > +		master->free_pos &=3D ~BIT(pos);
> > +	}
> > =20
> >  	writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(dev->info.dyn_addr),
> >  	       master->regs +

Best regards,
Vitor Soares

