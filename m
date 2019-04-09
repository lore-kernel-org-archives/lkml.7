Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8630C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE76220833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AWwOlQtK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="eFigtgMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfDIJbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:31:36 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:53842 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDIJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:31:36 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 50BD810C107C;
        Tue,  9 Apr 2019 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554802295; bh=5hwFAhpxGZPjHQGX1Ebn62fhQP85DVGiW0dTehL0dfE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AWwOlQtK8sSEKmAYhewf4P3uZAVRiGrq/hB/+uC+9X/FrfwIX+c3qGNVTazDaxgGC
         eGx2gNB/wbPkEgMsgqEe++daC0PUTj3KDliFdp/5DNHQwmLCQeGlyDU0odyXnH467t
         X47101oi+XZ592glCrm7vrvDzCj7q3+qX4zZJz4pSls3Iu9k5b+oEGVY/Utq/wDbNY
         iMRTmFmozQsgYTe7kgOE2kue1u0FrpHP2bPxL+/SeKgiTRQ2wjamXrq923enKm3YBQ
         idT8zWgArPhwQgGdVanemmOE+LpNS6MBeNlP8QSwPocKSwTWyvBM9duSeddlXbEYgf
         Hw4sBEIhoTpzA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0C3CFA0065;
        Tue,  9 Apr 2019 09:31:34 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 9 Apr 2019 02:31:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 9 Apr 2019 02:31:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUz4rzsuKdJzY0d6xJMJSPm4VCKhdAA8LgJG9IyG49g=;
 b=eFigtgMlLQGuLoV5vwINHpsiH8yZClJIrH04HtfkR1FroxqFHgSR0Kw8qHrwKMVwB219nncfdWAU3FfRWyXrvoXxnn4/G4nYKl2pa1GiA4MtCt4EWerUTZs2UnUl/Poj8wXDcx32da0zN64TCbQSlVxKaFDiQ8aFS/SaFJeWSYw=
Received: from BN6PR1201MB0082.namprd12.prod.outlook.com (10.174.113.147) by
 BN6PR1201MB0258.namprd12.prod.outlook.com (10.174.115.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 09:31:32 +0000
Received: from BN6PR1201MB0082.namprd12.prod.outlook.com
 ([fe80::4d0f:ceb2:da99:6777]) by BN6PR1201MB0082.namprd12.prod.outlook.com
 ([fe80::4d0f:ceb2:da99:6777%9]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 09:31:32 +0000
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "minas.harutyunyan@synopsys.com" <minas.harutyunyan@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>
CC:     "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/8] usb: dwc2: Add Amlogic G12A DWC2 Params
Thread-Topic: [PATCH 7/8] usb: dwc2: Add Amlogic G12A DWC2 Params
Thread-Index: AQHUwuWpmqoBwjaA1k+eTm2Z7hASYKYz6BkA
Date:   Tue, 9 Apr 2019 09:31:32 +0000
Message-ID: <BN6PR1201MB0082A4A0ACAEB63F6E6F37DDA72D0@BN6PR1201MB0082.namprd12.prod.outlook.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-8-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-8-narmstrong@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaG1pbmFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNDAyOTg0MGEtNWFhYS0xMWU5LWFmMGEtMTA2NTMw?=
 =?us-ascii?Q?YTFkYTJkXGFtZS10ZXN0XDQwMjk4NDBjLTVhYWEtMTFlOS1hZjBhLTEwNjUz?=
 =?us-ascii?Q?MGExZGEyZGJvZHkudHh0IiBzej0iMTcxNyIgdD0iMTMxOTkyNzU4ODkwNjEz?=
 =?us-ascii?Q?NjM5IiBoPSJIU2FDRm1HcUtQSXpISjQzUjFoU1FwWUg0N289IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUNI?=
 =?us-ascii?Q?UzVrQ3QrN1VBZGc4VXNjei9BMTIyRHhTeHpQOERYWU9BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQTNKRHlJd0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
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
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [92.123.244.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82a69614-a081-4834-e7d3-08d6bcce2714
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BN6PR1201MB0258;
x-ms-traffictypediagnostic: BN6PR1201MB0258:
x-microsoft-antispam-prvs: <BN6PR1201MB0258F3BCC88E0D62E8F7728AA72D0@BN6PR1201MB0258.namprd12.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39850400004)(376002)(396003)(189003)(199004)(9686003)(476003)(6116002)(316002)(486006)(110136005)(55016002)(33656002)(256004)(74316002)(54906003)(53936002)(11346002)(6246003)(66066001)(446003)(76176011)(478600001)(102836004)(2501003)(99286004)(97736004)(7696005)(6506007)(14454004)(26005)(186003)(105586002)(3846002)(4326008)(8676002)(229853002)(71190400001)(2906002)(52536014)(71200400001)(7736002)(106356001)(2201001)(5660300002)(81156014)(81166006)(6436002)(8936002)(25786009)(305945005)(68736007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1201MB0258;H:BN6PR1201MB0082.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TQ+0cGvwMbi7LcM5l3M98dg/Df7wRiO3bw9SfGHOuRr/cYPlAhrwSNlBD+FzBz5qu6WYp+beOpatDu/pjrwmR5fVHrO1rP1Ndk7UPcv9iTEuwTsZQnpID0WltVQAi02bT+N+rVrf+5MulW1H4nMGc65FBmtZ0UGax8xlwcMPsFOloQrjbIOxc7VzzFM8PWqrsAOL7+lIqTex9kFlH8hGtpeSkg9YomEjHBNnhlL+xoVt/88UIqAvyuDFEQmOcE4CqjgiBcMtMpEIZyTUypWF+iq08ZW0YalFACW6bI80tABZSP2ks/vJ6gkAhVK0srKEjQf65ZbJJ604UUmdG+vfqaQLf0D9QH2IiDGdJFOO3X5QyRYsv8rg0CmEzhROrpiCtS3k499vAR7oqmCQwjAdSYNZ10883AiRVcjhQ5RxThs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a69614-a081-4834-e7d3-08d6bcce2714
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 09:31:32.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0258
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This patchs sets the params for the DWC2 Controller found in the Amlogic =
G12A SoC family.
>=20
> It mainly sets the settings reported incorrect by the driver, leaving the=
 remaining detected automatically by the driver and provided by the DT node=
.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Minas Harutyunyan <hminas@synopsys.com>

> ---
>  drivers/usb/dwc2/params.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c index =
24ff5f21cb25..442113246cba 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -121,6 +121,16 @@ static void dwc2_set_amlogic_params(struct dwc2_hsot=
g *hsotg)
>  	p->power_down =3D DWC2_POWER_DOWN_PARAM_NONE;  }
> =20
> +static void dwc2_set_amlogic_g12a_params(struct dwc2_hsotg *hsotg) {
> +	struct dwc2_core_params *p =3D &hsotg->params;
> +
> +	p->lpm =3D false;
> +	p->lpm_clock_gating =3D false;
> +	p->besl =3D false;
> +	p->hird_threshold_en =3D false;
> +}
> +
>  static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)  {
>  	struct dwc2_core_params *p =3D &hsotg->params; @@ -167,6 +177,8 @@ cons=
t struct of_device_id dwc2_of_match_table[] =3D {
>  	  .data =3D dwc2_set_amlogic_params },
>  	{ .compatible =3D "amlogic,meson-gxbb-usb",
>  	  .data =3D dwc2_set_amlogic_params },
> +	{ .compatible =3D "amlogic,meson-g12a-usb",
> +	  .data =3D dwc2_set_amlogic_g12a_params },
>  	{ .compatible =3D "amcc,dwc-otg", .data =3D dwc2_set_amcc_params },
>  	{ .compatible =3D "st,stm32f4x9-fsotg",
>  	  .data =3D dwc2_set_stm32f4x9_fsotg_params },
> --
> 2.20.1
>
