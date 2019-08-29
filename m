Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7587C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AA2215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WS8pZLwo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Wi2qBgen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfH2OGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:06:09 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:43354 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbfH2OGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:06:08 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 23945C03A5;
        Thu, 29 Aug 2019 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567087568; bh=qGeCbyiA0vw0RMQwU9Wfe7tWiDvDlI1yeXrp7Gjw/xU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WS8pZLwoRkL4NoUDpXtSSDE78M9YPIk0LwSPyI4v9sKA6XE33N+9rhmaGnOVetojh
         tIzcDXxXoMNGHdnIQ0wTINjA4uezW4v1AN/HWtLygdDIPHiIZBKqIOktkGuKl/dXPf
         5wEJbWJDzyui550+VFqNZ9X1mJH+Moi5QPwl+h3Zt6bgcG1W0K9w/tK3Xl3ZssktVN
         +YYAUt0faDdF7Fnyd953Dmb1CeNlvi4uFJ+kVmiozywLFcft3iZZeRgp82yH/l5TTS
         oXMy6hehKWfXOW15hnhETT6OyclXpON6/uUjJKES2NzwpSpS84bvzcZdNvCWmD/6G3
         a9qXy9mPMLgYg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 934F3A0091;
        Thu, 29 Aug 2019 14:06:02 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Aug 2019 07:06:01 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 29 Aug 2019 07:06:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7FKMWx8yCSKdVhnTXoTwn1LCmu1K9tG68ud8Y1smf5cjOiOBzMisHMp6Sw8aocB9JNKaltnIFSqf3eHZcAeHBudTXWB2cDCSoHwKCrNAUxHwgLj1EikaBXtuGlsW3lk79hOIAMHGWnjFb0AGX8tFVZ+uqIk8FVUT+i46JOU5Hjdz/5VeCW8jLIRRTh/M7r0Cb/AM7MeJSFk3Uqiz5nbwpH8M9F3fIuZofhgW2Od2fzaBosSRH2syQXBAOB0uHPHNQaQyMn82pxNg+JqF3swWPXvSi5DWX2ZOuHkCFkgyowZ9OK5+cfLF98JCyL5a0iqcXIgL3Rdvp1WXmKLqoeRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuYJVvTkFQcD6HgAAhIwpcR3yXEnaMkfvFkLW2t2+8E=;
 b=B3XZ1PBmY7AwRHRQzcJOWQG3hcCEFKVzUXyoNciDPNj1DkkzZd9663QUDq1goS+6B7Q0/AvuyN8bFs2jW5dG4hX0ndyk3zEXtNxZb1xs8L1N9EV6KdR0l3PPSctxKPP2NYVsT7msG54mqKXloznyH/aS/dy8eUV0wr89EZl4zBtwLdx9sUJlE+3z18sTxfDtgBjEorJMnRQfJusRZPBcKaaP7CDnhaNeocX8tn3lH9Su14cklLQiGWg1F/6VY/goMGkEVe2MwkghOAT/kdiuAWc+o1AbLTb3UpgSLWXf4jMSfQ80VPxW0ZZRM2koRRfx2yLAzh2CYtgailT0b3siyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuYJVvTkFQcD6HgAAhIwpcR3yXEnaMkfvFkLW2t2+8E=;
 b=Wi2qBgen3UE/nLYjsbSPBt4VqLMVuUOkxTeev2OtzGJJ1DKmk8H1BkoMXmIY2Cw1+z38V5MUkFzl+YXINu+cdG/YQqKDSB1rVmm0ydqKoepYnDjH6ps61PznK5hJV96fu+Ul0p87bWSJozpKE9pkNQHXrBtEeZJDH2BKRpDJRxY=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 29 Aug 2019 14:06:00 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::89a7:a50:147b:52c6%4]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 14:06:00 +0000
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
Subject: RE: [PATCH 3/4] dt-bindings: i3c: Make 'assigned-address' valid if
 static address != 0
Thread-Topic: [PATCH 3/4] dt-bindings: i3c: Make 'assigned-address' valid if
 static address != 0
Thread-Index: AQHVXlJtqpSoyJg8pkCEOIHWVr8BrqcR8tIAgAA02zA=
Date:   Thu, 29 Aug 2019 14:06:00 +0000
Message-ID: <SN6PR12MB2655528456BB8E6661A5F962AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
        <9d69c83c7193e377bbc77bea7f1812fc17dafaee.1567071213.git.vitor.soares@synopsys.com>
 <20190829125138.4b36b8f6@collabora.com>
In-Reply-To: <20190829125138.4b36b8f6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMWU5M2NlMzctY2E2Ni0xMWU5LTgyNTQtYjU5ZDc5?=
 =?us-ascii?Q?N2QzNzhiXGFtZS10ZXN0XDFlOTNjZTM5LWNhNjYtMTFlOS04MjU0LWI1OWQ3?=
 =?us-ascii?Q?OTdkMzc4YmJvZHkudHh0IiBzej0iMjc3NiIgdD0iMTMyMTE1NjExNTcwMTcx?=
 =?us-ascii?Q?ODU0IiBoPSJzdlJqWEk3aUVYcko3aStMUXk1WkZreWNROUE9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQURP?=
 =?us-ascii?Q?Yit6Z2NsN1ZBVlVmU2RYb3hLYkNWUjlKMWVqRXBzSU9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 54466226-9e80-4c7c-0163-08d72c8a05ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2734;
x-ms-traffictypediagnostic: SN6PR12MB2734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27346AB7DE40FD66197AF480AEA20@SN6PR12MB2734.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(396003)(136003)(199004)(189003)(14444005)(478600001)(316002)(4326008)(2906002)(6636002)(8936002)(81166006)(81156014)(8676002)(305945005)(74316002)(25786009)(6246003)(107886003)(7736002)(6436002)(14454004)(99286004)(55016002)(53936002)(110136005)(54906003)(9686003)(52536014)(7696005)(76176011)(71190400001)(71200400001)(102836004)(26005)(6506007)(86362001)(33656002)(476003)(486006)(446003)(11346002)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(186003)(66066001)(5660300002)(229853002)(3846002)(256004)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2734;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YBUP0+4SddD5JQIzFH71iqk+xq2vxTw9S4Z7+LL0zko0wNXErpNa4SXslFXZgovwTXWv/880KKqkZWpFgprz7TQeJjHpaPa6SP0FKaAzlaaSBqG52g1n5PZSsWrxyhePhLSStnldL9wkwCxHVe2zHeBW9DiZLKlY6EhWigua86h1y5zO/x/BCB+O6tUutK1RarAbBVFkJ9NsIiQ0WAjik33YgOFUO3sk8m2t7i5fgTz8QZ9REWn0JNougAlGf7eMl5oP7Ccusr0Oq3lIbN/DrwAnZpKHQVxfzBSpFnre1xcuWRL1w8LzJqntZEHnUMuZgFC+KsxDLsjF2aUxJHA+9cHYxEqALG/OVmQP+4tSR3y/rDmFbd2fL9K4/qutinjIaQpeMayWwC8Uzg1mEJqP5vNxJENeXR8hILvyQ+iLurU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54466226-9e80-4c7c-0163-08d72c8a05ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 14:06:00.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JHQ6MeVk+bpGWFYkzqIa3EoZRic5KkmmPilwPrUqjvZbCG7u8lnuNURSRHc4SVNgrdC8KeuJbbI7IJ3mlU64tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2734
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, Aug 29, 2019 at 11:51:38

> On Thu, 29 Aug 2019 12:19:34 +0200
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > The I3C devices without a static address can require a specific dynamic
> > address for priority reasons.
> >=20
> > Let's update the binding document to make the 'assigned-address' proper=
ty
> > valid if static address !=3D 0 and add an example with this use case.
>=20
>            ^ you mean static address =3D=3D 0, right?

Indeed.

>=20
> Yes, it makes sense to support that case and do our best to assign the
> requested address after DAA has taken place by explicitly executing
> SETDA.
>=20
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > ---
> >  Documentation/devicetree/bindings/i3c/i3c.txt | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/i3c/i3c.txt b/Documentat=
ion/devicetree/bindings/i3c/i3c.txt
> > index ab729a0..c851e75 100644
> > --- a/Documentation/devicetree/bindings/i3c/i3c.txt
> > +++ b/Documentation/devicetree/bindings/i3c/i3c.txt
> > @@ -98,9 +98,7 @@ Required properties
> > =20
> >  Optional properties
> >  -------------------
> > -- assigned-address: dynamic address to be assigned to this device. Thi=
s
> > -		    property is only valid if the I3C device has a static
> > -		    address (first cell of the reg property !=3D 0).
> > +- assigned-address: dynamic address to be assigned to this device.
>=20
> We should probably mention that we don't provide strong guarantees
> here. We will try to assign this dynamic address to the device, but if
> something fails (like another device owning the address and refusing to
> give it up), the actual dynamic address will be different.
> This clarification can be done in a separate patch.

So, another patch on top of this one explaining that, right?

I would suggest to use a dynamic address, like 0x40 (mid priority), on=20
ENTDAA so lowers addresses (High Priority) can be used in DT or another=20
method.

What do you think about this?=20

>=20
> > =20
> > =20
> >  Example:
> > @@ -129,6 +127,15 @@ Example:
> > =20
> >  		/*
> >  		 * I3C device without a static I2C address but requiring
> > +		 * specific dynamic address.
> > +		 */
> > +		sensor@0,39200154004 {
> > +			reg =3D <0x0 0x6072 0x303904d2>;
> > +			assigned-address =3D <0xb>;
> > +		};
> > +
> > +		/*
> > +		 * I3C device without a static I2C address but requiring
> >  		 * resources described in the DT.
> >  		 */
> >  		sensor@0,39200154004 {

Best regards,
Vitor Soares
