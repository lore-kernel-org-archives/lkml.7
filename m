Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8503C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7CB20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TPTvHgw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgAIPMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:12:39 -0500
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:55712
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729139AbgAIPMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:12:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUE7yiWIzWb6dS05WjcnMPYh9T3tAJRYBqxNjQaFgrECYGUddZitFIa9OH5a8s4ZcXmHpMVLJGf25OHWuMtPmBoGHXN0ZkbNXJsUDbJjAeWuXIh1qgXlOrI2fhPQN9D3e3qHX6alQdPCP9Y+7NpBX8BwkFbTLmWkg0vye6T+dSN4pzFUffSv/vEbqbWI/nF68jhpXbj+S1zdszc0Q1r0qxSGwQHSfHshKPIpOGm4zX587jrfFCRviZnB0OSyL/jZZiKCmwGXeIyRhzAT52wjOQxcPQvQA8eXNSEBVRcu17rvn/KURc1pFNsvhtUyYzXoLcWqqIPLwaaWEIELWHfUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FWBPxx5loObgE01b4wIxp0C88g/PK7Z1wwYhm0o/y0=;
 b=fAdH3usaRCWCA9WHxD3w3YamaMrAGgTKRFWEKvXthJ7VlK7cFjOlINr0B398gZtKY3hne4lf1ngGYLf6v4+QpZuWogPeV48/NQwlB7zZE+LWu7py5nD7vXNvAhKu3Ry5k8CwkKKQ+Gnj+W0nY3fZQBw+dFdY5IPMkwZfOf42s9GyHAb3xPAw18lAHe84r/iCHwQ2XrxRIXctm3vC3fUyDQonqEkwchHsnvSIxX79fLJyPgMRYIglADufo6LwUpxjMtbHP9KzP2biDpZNXOZ4QIsc3SrdzTnIN0kkvNR28aWpEXpPoLSbxjlRUAYEsQn0OFPW1JF6tGVsihVXytVr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FWBPxx5loObgE01b4wIxp0C88g/PK7Z1wwYhm0o/y0=;
 b=TPTvHgw1jRgnNGuRg7Hgc2y6zWCxWsip/VwOKuoGonDCIpSv5TJXkSzMSkGPYyFjxUY6BHkvYJG5UaoJo05lHBfO0O+AynLvo3EUQu0bPPpIHtycM74l9tpGejsSqSsX89Mf1HSqVyGK+iV9eTajRvWk8l2FpSdk7Lpa91BAbFQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1466.namprd12.prod.outlook.com (10.172.38.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Thu, 9 Jan 2020 15:12:34 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2623.011; Thu, 9 Jan 2020
 15:12:34 +0000
Subject: Re: Regression in 5.4 kernel on 32-bit Radeon IBM T40
To:     Christoph Hellwig <hch@lst.de>,
        Woody Suwalski <terraluna977@gmail.com>
Cc:     DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Pavel Machek <pavel@ucw.cz>
References: <400f6ce9-e360-0860-ca2a-fb8bccdcdc9b@gmail.com>
 <20200109141436.GA22111@lst.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9ad75215-3ff1-ee76-9985-12fd78d6aa5f@amd.com>
Date:   Thu, 9 Jan 2020 16:12:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200109141436.GA22111@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0038.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::18) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 15:12:31 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90a10d8a-eb5a-404d-3e5c-08d795165aca
X-MS-TrafficTypeDiagnostic: DM5PR12MB1466:|DM5PR12MB1466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14662793BDBAE0393439695883390@DM5PR12MB1466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(199004)(189003)(8936002)(6486002)(8676002)(81166006)(81156014)(4326008)(36756003)(31696002)(2906002)(478600001)(2616005)(54906003)(316002)(110136005)(66476007)(5660300002)(66556008)(66946007)(186003)(16526019)(86362001)(31686004)(6666004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1466;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0D2HXMVxHsR/Xk+yOK7CaF7jQnneGwVI+hHNLgZth8Nk79t3oGU7mXn8NwH3FbD2SC2BJJ6e61Fr6QOtdw3u+M+NQIrMguhYjQ9dccWlIifYSF1a74YNpqP4O07B0ADSVghz8tIo5T7QoRhdL63jaPQabTp2c/a3NWni9ZLiutSvjudmuMDYd/hnDFKKzBp+GsFUQlp+9XWUZm9EKjI8jwVbFQFteo4yl4CYlN2k84ZUAzGEzMUs3MEK93099iLMNF0umK4J3AyNo/lc/CHIJp8OKWC6axbY7LvzxVaXTIqMFPzAsglKZqYsn1dxORvRzRfPTsLKzna4n3BrcXPudV+IesdbEDcSx8X4Oa+zc4X8Fasi+QE0dO+6gHvKZFqvzv8yckyBOa+yL/uEXLCqxiZlINl58vkuX0+y6v44fGB+RwJsi2UA4UJ1Fm9oYxU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a10d8a-eb5a-404d-3e5c-08d795165aca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 15:12:34.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/2h+zoK6ovQohUFASd1AloX6mhrtJ6scK+esy2ZgV3Ozq6RdYSJWVeY0+lwfwGz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Am 09.01.20 um 15:14 schrieb Christoph Hellwig:
> Hi Woody,
>
> sorry for the late reply, I've been off to a vacation over the holidays.
>
> On Sat, Dec 14, 2019 at 10:17:15PM -0500, Woody Suwalski wrote:
>> Regression in 5.4 kernel on 32-bit Radeon IBM T40
>> triggered by
>> commit 33b3ad3788aba846fc8b9a065fe2685a0b64f713
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Thu Aug 15 09:27:00 2019 +0200
>>
>> Howdy,
>> The above patch has triggered a display problem on IBM Thinkpad T40, where
>> the screen is covered with a lots of random short black horizontal lines,
>> or distorted letters in X terms.
>>
>> The culprit seems to be that the dma_get_required_mask() is returning a
>> value 0x3fffffff
>> which is smaller than dma_get_mask()0xffffffff.That results in
>> dma_addressing_limited()==0 in ttm_bo_device(), and using 40-bits dma
>> instead of 32-bits.
> Which is the intended behavior assuming your system has 1GB of memory.
> Does it?

Assuming the system doesn't have the 1GB split up somehow crazy over the 
address space that should indeed work as intended.

>
>> If I hardcode "1" as the last parameter to ttm_bo_device_init() in place of
>> a call to dma_addressing_limited(),the problem goes away.
> I'll need some help from the drm / radeon / TTM maintainers if there are
> any other side effects from not passing the need_dma32 paramters.
> Obviously if the device doesn't have more than 32-bits worth of dram and
> no DMA offset we can't feed unaddressable memory to the device.
> Unfortunately I have a very hard time following the implementation of
> the TTM pool if it does anything else in this case.

The only other thing which comes to mind is using huge pages. Can you 
try a kernel with CONFIG_TRANSPARENT_HUGEPAGE disabled?

Thanks,
Christian.
