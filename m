Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB36C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40D3206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="U1uGURxb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="sbDCywKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgAIG1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:27:15 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:1698 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726541AbgAIG1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:27:14 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0096Ootb019923;
        Wed, 8 Jan 2020 22:27:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=8mKiQwlViSZhuGifvbafOj9oeNz64MzmieNyq72Ep28=;
 b=U1uGURxbPmBg8CzSkVt2b+obMptc+B8I1YYitaJqIpfMGqdB2M0Zz6a8L6un4i9mZQyJ
 9qUyzFkF6LQ4OB87fini5smS59fKCM/e9mjKTGCmbb07ZXOjKcpXmAsY0AaBwT2izz0b
 2zOvhkI9xmObsARid+p+2QQPVCn/XL3Uwc+rp3Zkn/7svm0OwnZtXo8L3pxEIdVhg/XF
 dG36I1hqO8rvsLRRMrXd5YuljtgAVzs3qsXnv3GEjTM9MnODHcpqIvZ5a+mlom6limUw
 DAcinuiPjiLP6mIkL9tw0wkJamday6wWvvlj5oMCSYms2DmpZ0nh7S4NKQpQddK2Syeo Ag== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xaq620s01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jan 2020 22:27:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjIB6utvoA2W6X5ODVtjVTsCN5FM/qsJqfpKdSrkFQxBvgryp5l6RZr/4nSfF/Qg/U02Y5+3Jc9320Q4CLXk2Fe5Vbdy2BZvhPTcqqXTwZmmnrnTwWRcQFgPqCXN1s4Rsf9su6cOhUjMjnEALMdD5Wd7XZCPcDACZzFSFwOWWfuREaUoa0g/Uh3P2QpArbWP9pnnLr+8pLViXdLx7TVQPhcBxBi8HiYGd2wFH4NQhz6UoYntMd+pU6QU9k7XDavBF9Jt6en7qmCtJnqMdiIZODBvdxaGQoImj6wOIY4b+sO2l3P7VaAafXTBHBGpQgPuD8enYVtlcFrsSJ1U/+d98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mKiQwlViSZhuGifvbafOj9oeNz64MzmieNyq72Ep28=;
 b=cp44sANlVMwOBINZ4+RMPTNdbazif2yrxtoELi6Pdbj/5E2zqAypvgi6DtFav0HWrArqkTQqVZxjqrMOpzJUZDhGVbEe4CPutZpvBCsYlStYMz9EIMik1SfeSu4FC7Nx/Byg82HzAoonKyn89E2o6Rjw0nx8qcvOjERhY93irzmwVtr7mqTazwfUX43OCdQjub3j9HNFL/9IEUxYfHCtFdJCjIfY8R98jGB8+uUbFv4vvPIYjW+ZvU5vNNYqFaguD5IqqmkjWq6s0czjgEU5neLCcdh2Nliu+Oqm9ItUAHJRJ/k/OYkaX0Bn0x2E3N2jHeuHArfCEkhEiwdEplPH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mKiQwlViSZhuGifvbafOj9oeNz64MzmieNyq72Ep28=;
 b=sbDCywKBTkXlxB24h6sKjRlmNvoR3ML1wWLI9gtMTOlps/4PeOusNZdzR39qRvU508c3CPfjbi9IPncMpUOeQWz+0Wx24YFT/Tuy8NQ0MuO24mHLUxEL1ZJezSOP2gSvIuSvfKAP8fZnbTpguGgoeYowi35fZFKv0Ofx6LZC9BQ=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5862.namprd07.prod.outlook.com (20.179.91.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 06:27:02 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d01d:9089:7310:db3a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d01d:9089:7310:db3a%6]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 06:27:02 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Peter Chan <peter.chan@nxp.com>
Subject: RE: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Thread-Topic: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Thread-Index: AQHVxhgd/L7cK1vWyke0JuU/54YkXqfg05qAgADt7MA=
Date:   Thu, 9 Jan 2020 06:27:02 +0000
Message-ID: <BYAPR07MB4709983A2DF70AA0058C737FDD390@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20200108113719.21551-1-pawell@cadence.com>
 <20200108142829.GB2383861@kroah.com>
In-Reply-To: <20200108142829.GB2383861@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: {51BD6E37-66BD-4186-8AFE-835F952BA4E6}
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMDliMjA0NGEtMzJhOS0xMWVhLTg3NTItMWM0ZDcw?=
 =?us-ascii?Q?MWRmYmE0XGFtZS10ZXN0XDA5YjIwNDRiLTMyYTktMTFlYS04NzUyLTFjNGQ3?=
 =?us-ascii?Q?MDFkZmJhNGJvZHkudHh0IiBzej0iNjQwMSIgdD0iMTMyMjMwMjQ4MTkyMjI4?=
 =?us-ascii?Q?MTE5IiBoPSJvbDZ1YTRoSEEva3MxOVpZeGd4c0lFcWh6K1E9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFQUUxBQUFB?=
 =?us-ascii?Q?TXlQcDI2alZBWStYc3VFV1ZKZzVqNWV5NFJaVW1Ea09BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFGQWtBQU9BQ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQSs1UWJnUUFBQUFBQUFBQUFBQUFBQUo0QUFBQmpBR0VBWkFC?=
 =?us-ascii?Q?bEFHNEFZd0JsQUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQVlRQmtBR1VBYmdCakFHVUFYd0Jr?=
 =?us-ascii?Q?QUdVQWN3QnBBR2NBYmdCZkFITUFlUUJ6QUhRQVpRQnRBSE1BQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0JoQUdRQVpRQnVBR01BWlFCZkFIQUFjZ0J2QUdRQWRRQmpB?=
 =?us-ascii?Q?SFFBY3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCekFHOEFk?=
 =?us-ascii?Q?UUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZUUJ6QUcwQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3?=
 =?us-ascii?Q?QmtBR1VBWHdCakFHOEFZZ0J2QUd3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR01BY0FC?=
 =?us-ascii?Q?d0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUdBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUc4?=
 =?us-ascii?Q?QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVl3QnpBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFid0IxQUhJQVl3QmxBR01B?=
 =?us-ascii?Q?YndCa0FHVUFYd0JsQUhVQWNBQm9BRzhBY2dCcEFHRUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFHWUFi?=
 =?us-ascii?Q?d0J5QUhRQWNnQmhBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?RzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBYWdCaEFIWUFZUUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQWJ3QjFBSElBWXdCbEFH?=
 =?us-ascii?Q?TUFid0JrQUdVQVh3QndBSGtBZEFCb0FHOEFiZ0FBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUhJ?=
 =?us-ascii?Q?QWRRQmlBSGtBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjd0IwQUd3QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BYndCMUFISUFZd0Js?=
 =?us-ascii?Q?QUdNQWJ3QmtBR1VBWHdCMkFHSUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQURnQWdBQUFBQUFBQndBQUFBQkFBQUFBUUFBQURkUFF3MUVj?=
 =?us-ascii?Q?WGROdG5oVlEyUTcxT1VjQUFBQUFRQUFBQUVBQUFDeTNCY3dORGJ0UzVianJu?=
 =?us-ascii?Q?QzJsN2hLU0FBQUFBRUFBQUJBQUFBQUFRQUFBR01BWkFCdUFGOEFjd0J2QUhV?=
 =?us-ascii?Q?QWNnQmpBR1VBWXdCdkFHUUFaUUJmQUdNQWJ3QnVBR1lBYVFCa0FHVUFiZ0Iw?=
 =?us-ascii?Q?QUdrQVlRQnNBQUFBV0FJQUFBNEFBQUF5QUFBQUFBQUFBR01BWVFCa0FHVUFi?=
 =?us-ascii?Q?Z0JqQUdVQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VBYkFBQUFE?=
 =?us-ascii?Q?WUFBQUFCQUFBQVl3QmhBR1FBWlFCdUFHTUFaUUJmQUdRQVpRQnpBR2tBWndC?=
 =?us-ascii?Q?dUFGOEFjd0I1QUhNQWRBQmxBRzBBY3dBQUFDb0FBQUFBQUFBQVl3QmhBR1FB?=
 =?us-ascii?Q?WlFCdUFHTUFaUUJmQUhBQWNnQnZBR1FBZFFCakFIUUFjd0FBQUNZQUFBQUFB?=
 =?us-ascii?Q?QUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFHRUFjd0J0QUFBQUtn?=
 =?us-ascii?Q?QUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZd0J2QUdJ?=
 =?us-ascii?Q?QWJ3QnNBQUFBSmdBQUFBWUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJs?=
 =?us-ascii?Q?QUY4QVl3QndBSEFBQUFBa0FBQUFBQUFBQUhNQWJ3QjFBSElBWXdCbEFHTUFi?=
 =?us-ascii?Q?d0JrQUdVQVh3QmpBSE1BQUFBd0FBQUFBQUFBQUhNQWJ3QjFBSElBWXdCbEFH?=
 =?us-ascii?Q?TUFid0JrQUdVQVh3QmxBSFVBY0FCb0FHOEFjZ0JwQUdFQUFBQXVBQUFBQUFB?=
 =?us-ascii?Q?QUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JtQUc4QWNnQjBBSElB?=
 =?us-ascii?Q?WVFCdUFBQUFLQUFBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxB?=
 =?us-ascii?Q?RjhBYWdCaEFIWUFZUUFBQUN3QUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3?=
 =?us-ascii?Q?QnZBR1FBWlFCZkFIQUFlUUIwQUdnQWJ3QnVBQUFBS0FBQUFBQUFBQUJ6QUc4?=
 =?us-ascii?Q?QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWNnQjFBR0lBZVFBQUFDWUFBQUFB?=
 =?us-ascii?Q?QUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSE1BZEFCc0FBQUFK?=
 =?us-ascii?Q?QUFBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBZGdCaUFB?=
 =?us-ascii?Q?QUEiLz48L21ldGE+?=
x-dg-paste: 
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18ed0f36-a779-4fe4-256b-08d794ccf06c
x-ms-traffictypediagnostic: BYAPR07MB5862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB586252135EE919990ED7539DDD390@BYAPR07MB5862.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39840400004)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(36092001)(316002)(2906002)(8676002)(66476007)(66446008)(64756008)(5660300002)(9686003)(81156014)(8936002)(81166006)(52536014)(55016002)(54906003)(86362001)(66946007)(76116006)(66556008)(186003)(26005)(6916009)(33656002)(478600001)(7696005)(6506007)(4326008)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5862;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oSeEALbVFhdBQIvIHRAAIhwyZ0/eq7Z6LC9RXL13DnUn28PTjLLKEEcoPekPanDydIEn+0tbWpJz/AQB6itM5A5+8VYtGER+fGbRWrj/ppeqcphHEYGKnbEJe7lvznMFpWhP0Y6C4bytR92oi9VK3qXZVzFKzQcWGU0Gv6jaIPQPSnjw244i4RasNWUe8pze4tMUVfaVGUx9p8UvGISyjE/tFvUSQB8DYmIoKHebWqA7M5oc5s/06OFY0EeGuWZ5lg9Lfsy+5CL5kv9A0SrmFpB70OgN6UR4u/E5d97tvH3YtY67OPm4KxBnhGjoKcFbuzW0AWs7FCpDv6tPIs/WT642NNmoKFrkdL15Zl+UwVyYuho2X/b5V4LUepqpwELjCfTm4PhGo4vONE1xTJ55Ktn6TPhOdBISqZ3hpOzOis/5lsVGhpqk3rRr80DZYrL5qNhclCwJpxYY4oNAcNqQ9sPc189m4UiSP98pUtkxnAnmg6JZSTD5U2fwhM9jQ7xh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ed0f36-a779-4fe4-256b-08d794ccf06c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 06:27:02.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3PbRLqRonvGFS28OzG8GfwNO5LjFyhQ6a7HoH2jeGpJkN9cCZ6Djs0t3qK666rQcRJqbuNRXSbXeoY8x1pgwJOtKZJzVD6e1dIEXp3BQ6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5862
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_01:2020-01-08,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

+ linux-usb@vger.kernel.org

>
>On Wed, Jan 08, 2020 at 12:37:18PM +0100, Pawel Laszczak wrote:
>> The ARM core hang when access USB register after tens of thousands
>> connect/disconnect operation.
>>
>> The issue was observed on platform with android system and is not easy
>> to reproduce. During test controller works at HS device mode with host
>> connected.
>>
>> The test is based on continuous disabling/enabling USB device function
>> what cause continuous setting DEVDS/DEVEN bit in USB_CONF register.
>>
>> For testing was used composite device consisting from ADP and RNDIS
>> function.
>>
>> Presumably the problem was caused by DMA transfer made after setting
>> DEVDS bit. To resolve this issue fix stops all DMA transfer before
>> setting DEVDS bit.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> Signed-off-by: Peter Chan <peter.chan@nxp.com>
>> Reported-by: Peter Chan <peter.chan@nxp.com>
>> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>
>As this is in the 5.4 kernel release, you should have a "Cc: stable..."
>line in here, right?

Ok,

>
>> ---
>>  drivers/usb/cdns3/gadget.c | 84 ++++++++++++++++++++++++++------------
>>  drivers/usb/cdns3/gadget.h |  1 +
>>  2 files changed, 58 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>> index 4c1e75509303..277ed8484032 100644
>> --- a/drivers/usb/cdns3/gadget.c
>> +++ b/drivers/usb/cdns3/gadget.c
>> @@ -1516,6 +1516,49 @@ static int cdns3_ep_onchip_buffer_reserve(struct =
cdns3_device *priv_dev,
>>  	return 0;
>>  }
>>
>> +static int cdns3_disable_reset_ep(struct cdns3_device *priv_dev,
>> +				  struct cdns3_endpoint *priv_ep)
>> +{
>> +	unsigned long flags;
>> +	u32 val;
>> +	int ret;
>> +
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>> +
>> +	if (priv_ep->flags & EP_HW_RESETED) {
>
>Is "reseted" a word?  :)
>
>> +		spin_unlock_irqrestore(&priv_dev->lock, flags);
>> +		return 0;
>> +	}
>> +
>> +	cdns3_select_ep(priv_dev, priv_ep->endpoint.desc->bEndpointAddress);
>> +
>> +	val =3D readl(&priv_dev->regs->ep_cfg);
>> +	val &=3D ~EP_CFG_ENABLE;
>> +	writel(val, &priv_dev->regs->ep_cfg);
>> +
>> +	/**
>
>No need for kernel-doc comment style please.
>
>> +	 * Driver needs some time before resetting endpoint.
>> +	 * It need waits for clearing DBUSY bit or for timeout expired.
>> +	 * 10us is enough time for controller to stop transfer.
>> +	 */
>> +	readl_poll_timeout_atomic(&priv_dev->regs->ep_sts, val,
>> +				  !(val & EP_STS_DBUSY), 1, 10);
>
>You don't care if you time out?
I don't need care of it. The next timeout is critical.
>
>> +	writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
>> +
>> +	ret =3D readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
>> +					!(val & (EP_CMD_CSTALL | EP_CMD_EPRST)),
>> +					1, 1000);
>> +
>> +	if (unlikely(ret))
>
>Unless you can measure the difference of using/not using a
>unlikely/likely mark, NEVER use it.  The compiler and cpu can almost
>always do better than you can, we have the tests to prove it.
>

The both of the above timeout should never occur. If they occurred it would=
 be a=20
critical controller bug. In this case driver can only inform  about this ev=
ent.=20
For timeouts used in driver I've never see an errors. Because debugging the=
se=20
kind of errors is very hard I decided to leave dev_err in such case to info=
rm that
probably something is wrong in HW project.=20

I will remove unlikely. =20

>> +		dev_err(priv_dev->dev, "Timeout: %s resetting failed.\n",
>> +			priv_ep->name);
>> +
>> +	priv_ep->flags |=3D EP_HW_RESETED;
>
>So an error happens, but you still claim the device is reset?  What can
>a user do about this error?

The error should never occur.=20

>
>Yes, I know you copied this from other code in this driver, but it
>doesn't look right to me.

>
>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>
>Why print while a spinlock is held?  That's mean, you could have printed
>here, right?
>

Yes, it's true.=20

>> +
>> +	return ret;
>> +}
>> +
>>  void cdns3_configure_dmult(struct cdns3_device *priv_dev,
>>  			   struct cdns3_endpoint *priv_ep)
>>  {
>> @@ -1893,8 +1936,6 @@ static int cdns3_gadget_ep_disable(struct usb_ep *=
ep)
>>  	struct usb_request *request;
>>  	unsigned long flags;
>>  	int ret =3D 0;
>> -	u32 ep_cfg;
>> -	int val;
>>
>>  	if (!ep) {
>>  		pr_err("usbss: invalid parameters\n");
>> @@ -1908,32 +1949,11 @@ static int cdns3_gadget_ep_disable(struct usb_ep=
 *ep)
>>  			  "%s is already disabled\n", priv_ep->name))
>>  		return 0;
>>
>> -	spin_lock_irqsave(&priv_dev->lock, flags);
>> -
>>  	trace_cdns3_gadget_ep_disable(priv_ep);
>>
>> -	cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
>> -
>> -	ep_cfg =3D readl(&priv_dev->regs->ep_cfg);
>> -	ep_cfg &=3D ~EP_CFG_ENABLE;
>> -	writel(ep_cfg, &priv_dev->regs->ep_cfg);
>> -
>> -	/**
>> -	 * Driver needs some time before resetting endpoint.
>> -	 * It need waits for clearing DBUSY bit or for timeout expired.
>> -	 * 10us is enough time for controller to stop transfer.
>> -	 */
>> -	readl_poll_timeout_atomic(&priv_dev->regs->ep_sts, val,
>> -				  !(val & EP_STS_DBUSY), 1, 10);
>> -	writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
>> -
>> -	readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
>> -				  !(val & (EP_CMD_CSTALL | EP_CMD_EPRST)),
>> -				  1, 1000);
>> -	if (unlikely(ret))
>> -		dev_err(priv_dev->dev, "Timeout: %s resetting failed.\n",
>> -			priv_ep->name);
>> +	cdns3_disable_reset_ep(priv_dev, priv_ep);
>>
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>>  	while (!list_empty(&priv_ep->pending_req_list)) {
>>  		request =3D cdns3_next_request(&priv_ep->pending_req_list);
>>
>> @@ -1962,6 +1982,7 @@ static int cdns3_gadget_ep_disable(struct usb_ep *=
ep)
>>
>>  	ep->desc =3D NULL;
>>  	priv_ep->flags &=3D ~EP_ENABLED;
>> +	priv_ep->flags |=3D EP_CLAIMED | EP_HW_RESETED;
>
>Why do you now set EP_CLAIMED here when you never set that before?  Is
>this a different type of change?

My mistake. Thanks for letting me know. I merged two different patches fixi=
ng the same issue and=20
I missed it.=20

>
>thanks,
>
>greg k-h

Thanks,
Pawell=20
