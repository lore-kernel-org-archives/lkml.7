Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39DBC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA7A21881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="h6VeJ4VC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="lSpPhTaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfIQKDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:03:20 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:37682 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbfIQKDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:03:20 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7135AC0E0B;
        Tue, 17 Sep 2019 10:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1568714598; bh=surh/H/yvKorjvOXHP4YiDr62kVl/pQn+BviV+7LozU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=h6VeJ4VCRRSdkGIXTQMlwVauYr+ksU1TFPzC9zkFfeY4HzIj852RrZs8IaxdR/80l
         mh0dClalmlOmoGOcSh4mRuR9Zragx8cVHaBeK4cjIU7goIVturiYpA0dhO73sV6mRg
         mlHyDNOPwQLCOXgUU4PtaUvhQcmBYH1skIEY/UcK4Tpml67rnCwp1II8SiTBOTUXL9
         lP0Hbm1A932XXBhsgYPzbSogylYmbPU3aJot8GfrTKr3yoNYOyCFh2cJk249tCphK/
         mjfZMY0ULMvW8Qi4zHnvhxJYuIKXZqqA0inIKbNIk8MEgT5zdJqKVtnenA5cm8OxYD
         XZ5JEKj82TsCw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D566FA005A;
        Tue, 17 Sep 2019 10:03:08 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 17 Sep 2019 03:03:07 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 17 Sep 2019 03:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzGahz6A38vRA5ZYh7nhBvTOyEZNMaqTG1R6Cl6z5RF5tavM3XM1Q90y98i0TxB6kWqtLzA14qlrVmIvFYe4yOYL+FRRYDJ5N6/MfED1KfdBwwUuLIQ/j/E/xjM0PI4M595Sn2dqfFEd2Zuuf4VsoM5xVYA317TQl2ts2dYP+tPhg/Yf9AZeUXbKVKVjn2f9VirshMP/SHwrftI3RUSFkpTEKZ9nY7NDU3ykQx5nvWnCsX138GfaBuvLcExqQ+blBDjUxFj8Kf2tBKQrFSNPDfz4ilwTRuZ6GWeHUxsCE8kQ0Zp5QpNNYLwJQJKW36fKphx9RK1zu/V8xCKd68qAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogxdiieH+kDtDiHj5HMtKHopzvCzb0h066DZHTOxNSM=;
 b=S+IuBL7SxCtynj6G+M8yCyUfqdS2ccaHEUL/8ztDOQirG3dFCI1HUAmGDvlX7OV96ZxP6+6QjYBO3hxu84MMmrODvl1gvox9I1zIZ/nL+pLHBLiSS3vtouC1AZACdIvOL8ZS+Mbsrsg5w6LtQo6wJpY5aZ4XUmejQEM9HXcdBVfsII6IIExA0f6yOewAAeXjMxVI2d2gy9NyQ70svPcMgwHVlV+kl9bXg3dc7lhlUru6o0/pqBtgzZfT3+mg24VOdV3Q8ClcG66ydLzgiHBimOb2J6DlQTKb8mIuPtoGtnXaIbmXuiAe8ZM+T1ky3weJzu8B2waDOvGpRCGomgwUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogxdiieH+kDtDiHj5HMtKHopzvCzb0h066DZHTOxNSM=;
 b=lSpPhTaTzfWs3gz5NsLRlzz59BbVX12VfSge09+QLBa8svqZovAlykQJqhy3fvo0KrKYLepomf0DLdFYGotUx9HANTBbGzJXpPHC/zT40w/6EUjG/X8zl3I4g9RF8e24mJuNNsr8ePdsvMb2DkqmC0CaWbAGUKz+703kRRQR/cg=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2816.namprd12.prod.outlook.com (52.135.107.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Tue, 17 Sep 2019 10:02:35 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::c4b9:6813:9c58:3fb9]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::c4b9:6813:9c58:3fb9%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 10:02:35 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pgaj@cadence.com" <pgaj@cadence.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH v3 1/5] i3c: master: detach/free devices fail on
 pre_assign_dyn_addr()
Thread-Topic: [PATCH v3 1/5] i3c: master: detach/free devices fail on
 pre_assign_dyn_addr()
Thread-Index: AQHVY0hlgS4HVQdOUk+p1+/PaaUrZacvt3pg
Date:   Tue, 17 Sep 2019 10:02:34 +0000
Message-ID: <SN6PR12MB26553AEDB14A6B6275AA98CCAE8F0@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1567608245.git.vitor.soares@synopsys.com>
 <d16914bbe06cf82cdbf9a0480310bd9cc2e4d8a9.1567608245.git.vitor.soares@synopsys.com>
In-Reply-To: <d16914bbe06cf82cdbf9a0480310bd9cc2e4d8a9.1567608245.git.vitor.soares@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNDIzYzMzZWUtZDkzMi0xMWU5LTgyNTktYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDQyM2MzM2VmLWQ5MzItMTFlOS04MjU5LWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMzcxNyIgdD0iMTMyMTMxODgxNTE4ODUw?=
 =?us-ascii?Q?NjI1IiBoPSJxQ0dnbjNZQTQ1YkdFNlFVT3hyajVLYkdSbnc9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUJC?=
 =?us-ascii?Q?WW04RlAyM1ZBWnpyYXoyYTFnY1luT3RyUFpyV0J4Z09BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 72eadc19-fb1b-4538-1bd0-08d73b5629eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2816;
x-ms-traffictypediagnostic: SN6PR12MB2816:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB28167213632A2DF3734C6FA9AE8F0@SN6PR12MB2816.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(7696005)(81156014)(81166006)(8936002)(99286004)(6116002)(6246003)(66946007)(64756008)(52536014)(66446008)(66066001)(66476007)(76116006)(33656002)(2906002)(107886003)(110136005)(229853002)(316002)(9686003)(54906003)(55016002)(6436002)(76176011)(4326008)(2501003)(2201001)(71200400001)(8676002)(256004)(561944003)(3846002)(26005)(186003)(6506007)(86362001)(25786009)(102836004)(71190400001)(14454004)(7736002)(478600001)(476003)(66556008)(74316002)(11346002)(446003)(5660300002)(486006)(305945005)(14444005)(5024004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2816;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TBBLA6j8V8pSXkIKWix1gELwr7wtqBz1pwiXxPoI2kqr+0+FUOYYYtthNzeHVfdt97C5YPK2coGTcKFFjuGnvRxbL7gAMkfIxirLtBIvEKMXQVd4jFVdLCJOAzQ6qlYcKsZu5JoPyTM8C239XVPoKPs9MZVMcJN9C2OrB/Fw659e55xZYLWG5eufcJVXvePRGIXKf2p2NQx5tTN2jFRbHNhiH3ZE9OPfOYfphrCpmvV6H5tBSJMfKTIDGmDkDyvgLUFHrC46xyajBqlvnQcchnOgEcogEE8POdZoJF2NuaVrB26NLim4OAfir95grWvfQvHFWPWP2IUUTJfs1GMy/0emBErkMk4QHRH9CvrEXpgtsLkF2ZLCNeS4z9nou68Xeq6IWDtrDaq16GmEVw2/UCPLj3a5lTFzZtIoC9waFJw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72eadc19-fb1b-4538-1bd0-08d73b5629eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 10:02:34.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGLom1cbalPf8UZ9Fu7151VlzTKgxeTEWKY4SP3DXtviHySxk5DLGCaAYIppR5UR+Rg2Ow/DkDYAborI8XVZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2816
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

From: Vitor Soares <vitor.soares@synopsys.com>
Date: Thu, Sep 05, 2019 at 11:00:34

> As for today, the I3C framework is keeping in memory and master->bus.devs
> list the devices that fail during pre_assign_dyn_addr() and send them on
> DEFSLVS command.
>=20
> According to MIPI I3C Bus spec the DEFSLVS command is used to inform any
> Secondary Master about the Dynamic Addresses that were assigned to I3C
> devices and the I2C devices present on the bus.
>=20
> This issue could be fixed by changing i3c_master_defslvs_locked() to
> ignore unaddressed i3c devices but the i3c_dev_desc would be allocated an=
d
> attached to HC unnecessarily. This can cause that some HC aren't able to
> do DAA for HJ capable devices due to lack of space in controller.
>=20
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
> Changes in v3:
>   - Change commit message
>=20
> Changes in v2:
>   - Move out detach/free the i3c_dev_desc from pre_assign_dyn_addr()
>   - Convert i3c_master_pre_assign_dyn_addr() to return an int
>=20
>  drivers/i3c/master.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 5f4bd52..586e34f 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1426,19 +1426,19 @@ static void i3c_master_detach_i2c_dev(struct i2c_=
dev_desc *dev)
>  		master->ops->detach_i2c_dev(dev);
>  }
> =20
> -static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
> +static int i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
>  {
>  	struct i3c_master_controller *master =3D i3c_dev_get_master(dev);
>  	int ret;
> =20
>  	if (!dev->boardinfo || !dev->boardinfo->init_dyn_addr ||
>  	    !dev->boardinfo->static_addr)
> -		return;
> +		return 0;
> =20
>  	ret =3D i3c_master_setdasa_locked(master, dev->info.static_addr,
>  					dev->boardinfo->init_dyn_addr);
>  	if (ret)
> -		return;
> +		return ret;
> =20
>  	dev->info.dyn_addr =3D dev->boardinfo->init_dyn_addr;
>  	ret =3D i3c_master_reattach_i3c_dev(dev, 0);
> @@ -1449,10 +1449,12 @@ static void i3c_master_pre_assign_dyn_addr(struct=
 i3c_dev_desc *dev)
>  	if (ret)
>  		goto err_rstdaa;
> =20
> -	return;
> +	return 0;
> =20
>  err_rstdaa:
>  	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
> +
> +	return ret;
>  }
> =20
>  static void
> @@ -1647,7 +1649,7 @@ static int i3c_master_bus_init(struct i3c_master_co=
ntroller *master)
>  	enum i3c_addr_slot_status status;
>  	struct i2c_dev_boardinfo *i2cboardinfo;
>  	struct i3c_dev_boardinfo *i3cboardinfo;
> -	struct i3c_dev_desc *i3cdev;
> +	struct i3c_dev_desc *i3cdev, *i3ctmp;
>  	struct i2c_dev_desc *i2cdev;
>  	int ret;
> =20
> @@ -1746,8 +1748,14 @@ static int i3c_master_bus_init(struct i3c_master_c=
ontroller *master)
>  	 * Pre-assign dynamic address and retrieve device information if
>  	 * needed.
>  	 */
> -	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
> -		i3c_master_pre_assign_dyn_addr(i3cdev);
> +	list_for_each_entry_safe(i3cdev, i3ctmp, &master->bus.devs.i3c,
> +				 common.node) {
> +		ret =3D i3c_master_pre_assign_dyn_addr(i3cdev);
> +		if (ret) {
> +			i3c_master_detach_i3c_dev(i3cdev);
> +			i3c_master_free_i3c_dev(i3cdev);
> +		}
> +	}
> =20
>  	ret =3D i3c_master_do_daa(master);
>  	if (ret)
> --=20
> 2.7.4

I think I clearly explain why the current solution is problematic and my=20
choices for the proposal solution.
Please let me know if there is anything else that I can improve in this=20
patch.

Best regards,
Vitor Soares
