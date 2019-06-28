Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA62C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B589208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hV3ru56E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="SSdCOZ39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfF1LZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:25:18 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:33212 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfF1LZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:25:17 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C1809C0AC0;
        Fri, 28 Jun 2019 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561721116; bh=CJzHkSDrF8Kpj68YL1xwyW0oHUDBTWZTxId0F40PXQY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hV3ru56Euo+TSGaDUt5aBdNIA/IIlRKs6Pd2bUGZQWQfyqOGN1TlNHTburnKuU3yq
         By6J1fUREKnK1rv/XlkiRvQWSU0M6bjYLuv4sxu0IUi0+sNQH5EU7FECkh8e7M7x5h
         fiGz9hN2O7mTpSJtAprBX7euCjeVEscDdUHVt3mZBiyQ0NvnGf8TO2vZtcgcTINv/D
         j2hhQx2GCcedZAhSDTHCfi2SDDi3KhP6zkCBKP7zgm3sR0ih9vWW1roPItxYteqFwZ
         DtWWODDge4ome5fGMwC+uGD+Cda0UWVbdYuddyMoP5jl6qvQ1OSYe/46NAZdklx0mG
         y8BmTLaf/spRw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1678EA0067;
        Fri, 28 Jun 2019 11:25:14 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 28 Jun 2019 04:25:13 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 28 Jun 2019 04:25:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBFcGJ/Npalg1Bcf4HTo7YDo6YRZTE5tJuwGbp59ME8=;
 b=SSdCOZ39IUiDy9RMpTZCKKVWmUG+IfWuDy3veemhp8Jdq6JD0PmmwX0SKS6XyCLELSrqUnpscqBRtg+0XsON1gIYMNnNw9JwkorPZDiuBHASaTfwG05QIsPtSEbLeuxxVv0zLaGxAGX59dX8jDZMrShwp+5cc4jvwOH/2Nm0+80=
Received: from MN2PR12MB3167.namprd12.prod.outlook.com (20.179.80.95) by
 MN2PR12MB3535.namprd12.prod.outlook.com (20.179.83.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Fri, 28 Jun 2019 11:25:12 +0000
Received: from MN2PR12MB3167.namprd12.prod.outlook.com
 ([fe80::24d8:6500:f338:d9b]) by MN2PR12MB3167.namprd12.prod.outlook.com
 ([fe80::24d8:6500:f338:d9b%7]) with mapi id 15.20.2032.018; Fri, 28 Jun 2019
 11:25:12 +0000
From:   Pedro Sousa <PedroM.Sousa@synopsys.com>
To:     Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pedro Sousa <PedroM.Sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
CC:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Subject: RE: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
Thread-Topic: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
Thread-Index: AQHVISOnerQGbjQwUky1tRLzfVuAmKaw/7JQ
Date:   Fri, 28 Jun 2019 11:25:12 +0000
Message-ID: <MN2PR12MB3167D6E742D06055FDCFB17ACCFC0@MN2PR12MB3167.namprd12.prod.outlook.com>
References: <1560346477-13944-1-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1560346477-13944-1-git-send-email-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc291c2FcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy02MzBlMmQyOC05OTk3LTExZTktOTlmYy1iODA4Y2Yz?=
 =?us-ascii?Q?YjJlNWVcYW1lLXRlc3RcNjMwZTJkMjktOTk5Ny0xMWU5LTk5ZmMtYjgwOGNm?=
 =?us-ascii?Q?M2IyZTVlYm9keS50eHQiIHN6PSIxMjAyIiB0PSIxMzIwNjE5NDcxMDczMzM0?=
 =?us-ascii?Q?NjkiIGg9IjRiTWlIaWh3VU5UaUFPVCtlMklxT3g0MURBUT0iIGlkPSIiIGJs?=
 =?us-ascii?Q?PSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFBQmQx?=
 =?us-ascii?Q?YTBscEMzVkFkalBrWHYvM0RuNTJNK1JlLy9jT2ZrT0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFRQUJBQUFBMUN5NExnQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0FiZ0Jo?=
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
 smtp.mailfrom=sousa@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cf7b665-72f4-427f-6896-08d6fbbb492a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB3535;
x-ms-traffictypediagnostic: MN2PR12MB3535:
x-microsoft-antispam-prvs: <MN2PR12MB3535E11FEFA83857CBE83938CCFC0@MN2PR12MB3535.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(376002)(346002)(189003)(199004)(476003)(4744005)(6246003)(8676002)(7696005)(2501003)(68736007)(486006)(11346002)(446003)(81156014)(81166006)(229853002)(52536014)(9686003)(6436002)(71190400001)(71200400001)(76116006)(73956011)(66556008)(64756008)(66446008)(66476007)(305945005)(74316002)(66946007)(55016002)(8936002)(3846002)(6116002)(53936002)(5660300002)(7736002)(14444005)(256004)(2906002)(33656002)(54906003)(110136005)(316002)(478600001)(14454004)(25786009)(66066001)(99286004)(76176011)(4326008)(6506007)(102836004)(26005)(86362001)(2201001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR12MB3535;H:MN2PR12MB3167.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iYunzla3nu9/EnXSA28aAngzKO3kfumaZhte1EazDz/AsWmCbaL5W2DjUl27wTb88FBH8ps5ZCcviI2D2cxddFtLnOpgHgrnNPI/RCXQxKNAARkwfseqMKLEk2yVF7Ezox7vBVBA0dtfRpqYhGx+P0TcwGpUHIvLTgP27B0/yGwMXzy785YF7e7zjIWAjL7YktB4+n85TTxQFIpuUsNCkImXppMMMqerRYgrkhdrvCdPsukudIB+5TiWPgdeJOKuqPng+GyTrX7vIGVhwDCuVenBPCeIJtwNqUnbIl3a4mXDlSpxOfaQslZe/nZIaqQO1GePifBlrOswhjnJUWhWyeOXtRqujhX1eHlSk1BlZyiMSrvMZ7nIYX0CvsCammKUaTS8KE8/dALfSP9sDeG8AOHWSAuVwH4aDPhwgGZXECo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf7b665-72f4-427f-6896-08d6fbbb492a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 11:25:12.2817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sousa@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3535
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avri Altman <avri.altman@wdc.com>
Date: Wed, Jun 12, 2019 at 14:34:37

> added 'WITH Linux-syscall-note' exception, which is the officially
> assigned exception identifier for the kernel syscall exception.
> This exception makes it possible to include GPL headers into non GPL
> code, without confusing license compliance tools.
>=20
> fixes: a851b2bd3632 (scsi: uapi: ufs: Make utp_upiu_req visible to user
> 		     space)
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  include/uapi/scsi/scsi_bsg_ufs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bs=
g_ufs.h
> index 17c7abd..9988db6 100644
> --- a/include/uapi/scsi/scsi_bsg_ufs.h
> +++ b/include/uapi/scsi/scsi_bsg_ufs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  /*
>   * UFS Transport SGIO v4 BSG Message Support
>   *
> --=20
> 1.9.1

Hi Avri,

I don't see any issue.=20

Thanks

Reviewed-by: Pedro Sousa <pedrom.sousa@synopsys.com>=20

