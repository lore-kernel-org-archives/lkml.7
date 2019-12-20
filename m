Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14F8C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7C221655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fqJxaL03";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Pbq8x1JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLTTc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:32:26 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:60440 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbfLTTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:32:26 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 92E4DC000E;
        Fri, 20 Dec 2019 19:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1576870344; bh=B+LKqbCq7gDzphZwSEMb4QaDDAlhmhzab+vucMT/icM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fqJxaL03rahUfRB95dkF+VmTHONDqloVMVgsZKDnTbyS1UEIO6QvjrxUlEOaW557n
         fWPWuudce0bsLlvKh+RX3bP6DNAsxoJMO2EDGhIdWNGoOpfU8zLMJdkRY/ubA8pWn5
         B2PWM0V7WI579wPt2Wzun2AIe/2w+m1roJ6zBYGZx9PFcKJas9rgL7hwIiy1V5VmDK
         LswBjm5piy+spQEYGwgHngo6O5RJZGVDOOjPvj6FqAYGMlx0okyZbgcplRdZMRVgvW
         nLXeHVsfKEBJoNWkG/qvZIng8wNn2HVJFYYnMErkTjn4WumlU5nQ+Wobq4uWlc2zzm
         Q3+lxsdx7LmSg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 593BDA008A;
        Fri, 20 Dec 2019 19:32:21 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 20 Dec 2019 11:32:18 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 20 Dec 2019 11:32:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/M5sV31PsARxjjRPv7694C82uiKUobXzEvgd0Uvq3tb50CuVtfmCYiEDLRQEaqtRcFqyzFdB5ZajkPaiqAarxT3gStxmaEe5SqqiOoPXyNb07KEz1lreAE0NesP6N48a0H54hiQEigxq2RBr6gP5Fs0wTOunwY+XCukFEclxqQiQn1X88ltX9KRt3UmeSsa5XRufb1Gd/LFjwtzoPYJs2kC7kfgZRt4RvGBIBchVYn2qPfBmMt9LvWvYw3bTy/8fgQPdYJRr/hgpYvYJbfHZios3VLXg7Hl96S58v4mCxsEG1oN15oG4GlDTg8KBxpyROIfhTsFjN42aTaho0OJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+LKqbCq7gDzphZwSEMb4QaDDAlhmhzab+vucMT/icM=;
 b=OIY4Nrpsfkvo63rf2Whj0JweznldNa/Cw85EjENgHHSNsSSpNfATFchAK9mcmmMAXPt12FY8GV91h6adRuykRH/pvNMxs82eFtvq86zQ+MoZ3d1Hd+SRfk5GeSVofv1K3qXKhaZ67eyW+N3d6fXfJidzHRPRIk3oKiE2PvVex+0XcuxVSRCyyaE7K4FLilpMUCOLAgbjxYj+rHQWNiYcqPNycszla8vY1sSfnKSXUOkRtHeX2eCKI+FZdRvPFu+2BGg140uK0vqsRV63q273cg4/dQvrS6GoQ6nIuYqrj/4fyzyJzqzezyfAsi5T0aMWTTW2g0TuzwBxuT1Yx1GoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+LKqbCq7gDzphZwSEMb4QaDDAlhmhzab+vucMT/icM=;
 b=Pbq8x1JY8VrNp6pRzI5uBRp2aUru6CVnIY46zVHatuczogNqRQRfIkXRIyRcpit7FFly1STvh9MFCOxNwjiIKznzSRY1i6CRXQTszLu2Mu40awRT/0J97KNHoKY/AailZHs1JUTIhJf8NnaUPnpkAOXOjzeoPM742fkys3064Ts=
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com (10.172.78.14) by
 CY4PR1201MB2503.namprd12.prod.outlook.com (10.172.116.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 19:32:16 +0000
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::3977:e2ba:ce57:f79a]) by CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::3977:e2ba:ce57:f79a%5]) with mapi id 15.20.2538.019; Fri, 20 Dec 2019
 19:32:16 +0000
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: RE: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
Thread-Topic: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
Thread-Index: AQHVtO8W17bjcgXck0Krmyf4Y6chj6fC1AyAgAA/joCAAA8ggIAASORA
Date:   Fri, 20 Dec 2019 19:32:16 +0000
Message-ID: <CY4PR1201MB012011E554FC69F7B074B7E2A12D0@CY4PR1201MB0120.namprd12.prod.outlook.com>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
 <20191220140655.GN2827@hirez.programming.kicks-ass.net>
 <9be1d523-e92c-836b-b79d-37e880d092a0@arm.com>
In-Reply-To: <9be1d523-e92c-836b-b79d-37e880d092a0@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVdKeWIyUnJhVzVjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAyWXpNeE4yVXlZUzB5TXpWbUxURXhaV0V0WW1abVlTMDRPR0l4?=
 =?utf-8?B?TVRGalpHVXlNVGRjWVcxbExYUmxjM1JjTm1Nek1UZGxNbUl0TWpNMVppMHhN?=
 =?utf-8?B?V1ZoTFdKbVptRXRPRGhpTVRFeFkyUmxNakUzWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlORFE1SWlCMFBTSXhNekl5TVRNME16a3pORFEzTnpFeE5UVWlJR2c5SWpG?=
 =?utf-8?B?U1FXeEdRMDh2VkVOSU0weHFTVTlUUWxJek1WZGpNV2hwWXowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVSlJTa0ZCUWxSblN6QjFZa3htVmtGU1RrZFBLM0pqVDBsNldr?=
 =?utf-8?B?VXdXVGMyZEhjMGFrNXJUMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVOclEwRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlVsZ3lhekZCUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2JVRkhhMEZpWjBKb1FVYzBRVmwzUW14QlJqaEJZMEZDYzBGSFJV?=
 =?utf-8?B?RmlaMEoxUVVkclFXSm5RbTVCUmpoQlpIZENhRUZJVVVGYVVVSjVRVWN3UVZs?=
 =?utf-8?B?UlFubEJSM05CUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMWxCWW5kQ01VRkhORUZhUVVKNVFVaHJRVmgz?=
 =?utf-8?B?UW5kQlIwVkJZMmRDTUVGSE5FRmFVVUo1UVVoTlFWaDNRbTVCUjFsQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZwblFuWkJTRlZCWW1kQ2Ew?=
 =?utf-8?B?RklTVUZsVVVKbVFVaEJRVmxSUW5sQlNGRkJZbWRDYkVGSVNVRmpkMEptUVVo?=
 =?utf-8?B?TlFWbFJRblJCU0UxQlpGRkNkVUZIWTBGWWQwSnFRVWM0UVdKblFtMUJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZLTkVGQlFVSnRRVWM0?=
 =?utf-8?B?UVdSUlFuVkJSMUZCWTJkQ05VRkdPRUZqUVVKb1FVaEpRV1JCUW5WQlIxVkJZ?=
 =?utf-8?B?MmRDZWtGR09FRmpkMEpvUVVjd1FXTjNRakZCUnpSQlduZENaa0ZJU1VGYVVV?=
 =?utf-8?B?SjZRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJt?=
 =?utf-8?B?ZEJRVUZIV1VGaWQwSXhRVWMwUVZwQlFubEJTR3RCV0hkQ2QwRkhSVUZqWjBJ?=
 =?utf-8?B?d1FVYzBRVnBSUW5sQlNFMUJXSGRDZWtGSE1FRmhVVUpxUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZE?=
 =?utf-8?B?UVVGQlFVRkJRMlZCUVVGQldtZENka0ZJVlVGaVowSnJRVWhKUVdWUlFtWkJT?=
 =?utf-8?B?RUZCV1ZGQ2VVRklVVUZpWjBKc1FVaEpRV04zUW1aQlNFMUJaRUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVKQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlNVRkJRVUZCUVVvMFFVRkJRbTFCUnpoQlpGRkNkVUZIVVVG?=
 =?utf-8?B?alowSTFRVVk0UVdOQlFtaEJTRWxCWkVGQ2RVRkhWVUZqWjBKNlFVWTRRV1JC?=
 =?utf-8?B?UW5wQlJ6QkJXWGRCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVGQlFVRnVaMEZCUVVkWlFXSjNR?=
 =?utf-8?B?akZCUnpSQldrRkNlVUZJYTBGWWQwSjNRVWRGUVdOblFqQkJSelJCV2xGQ2VV?=
 =?utf-8?B?RklUVUZZZDBJeFFVY3dRVmwzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJRVUZCUVVOQlFVRkJRVUZEWlVG?=
 =?utf-8?B?QlFVRmFkMEl3UVVoTlFWaDNRbmRCU0VsQlluZENhMEZJVlVGWmQwSXdRVVk0?=
 =?utf-8?B?UVdSQlFubEJSMFZCWVZGQ2RVRkhhMEZpWjBKdVFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFrRkJRVUZCUVVGQlFVRkpR?=
 =?utf-8?B?VUZCUVVGQlNqUkJRVUZDZWtGSFJVRmlRVUpzUVVoTlFWaDNRbWhCUjAxQldY?=
 =?utf-8?B?ZENka0ZJVlVGaVowSXdRVVk0UVdOQlFuTkJSMFZCWW1kQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlNFMUJXVkZDYzBGSFZVRmpkMEpt?=
 =?utf-8?B?UVVoRlFXUlJRblpCU0ZGQldsRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZCUVVObFFVRkJRV04zUW5WQlNF?=
 =?utf-8?B?RkJZM2RDWmtGSGQwRmhVVUpxUVVkVlFXSm5RbnBCUjFWQldIZENNRUZIVlVG?=
 =?utf-8?B?alowSjBRVVk0UVUxUlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkNRVUZCUVVGQlFVRkJRVWxCUVVGQlFVRktORUZC?=
 =?utf-8?B?UVVKNlFVYzBRV05CUW5wQlJqaEJZa0ZDY0VGSFRVRmFVVUoxUVVoTlFWcFJR?=
 =?utf-8?B?bVpCU0ZGQldsRkNlVUZITUVGWWQwSjZRVWhSUVdSUlFtdEJSMVZCWW1kQ01F?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVGblFV?=
 =?utf-8?B?RkJRVUZCYm1kQlFVRklXVUZhZDBKbVFVZHpRVnBSUWpWQlNHTkJZbmRDZVVG?=
 =?utf-8?B?SFVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJRVUZC?=
 =?utf-8?Q?QUFBQUFDQUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abrodkin@synopsys.com; 
x-originating-ip: [188.243.7.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6504e19e-d2db-4fcd-c1b9-08d78583526e
x-ms-traffictypediagnostic: CY4PR1201MB2503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB250338F7A0A87671C3A782F4A12D0@CY4PR1201MB2503.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(107886003)(55016002)(5660300002)(71200400001)(8676002)(4326008)(26005)(53546011)(316002)(8936002)(7416002)(6506007)(110136005)(81166006)(4001150100001)(86362001)(66556008)(64756008)(66446008)(66476007)(33656002)(76116006)(54906003)(81156014)(66946007)(52536014)(2906002)(186003)(7696005)(9686003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB2503;H:CY4PR1201MB0120.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHgJD6CCtlVJFEUH+IdOzyOdI/h/avMdQyFx9Ohgf34Y4W+TYLEO9eUZb/S6bOeyhy0Gw2JE9VFBKF2EZZVvdGJOOAc0I8l3vPWMN0t0E3tQ4JdPulcYk4jMHzSf6X5RuZhfsPdRfUFNJBkduRjHpEyVl64Rn4uyCNS8DnzzxmNwF92gXweG4RXSAhKQNaJSuIY5WQ8Fd8D0vFZqmxDrtnAMQuEEUzCmlaMq2ps4597bWha+xTERQawO27AAphh+p9uq3IjEIzF37WYMdj3xQPEFJGvkd6ztBKF2hcqq+200Wp6qneSn5FInGQU0RM8EdeeS/Va/EQDBrshi6Dm1N8u2vdt8nSncnJUT4FBk4yLAcZqxcxegF/hs96eI8+4nBaBMzgAde6B+UxnA1fKhC6b2ZNToMWG5J7ZLglBb6b4BsZ6t5XHO6Ce3oY69hd9p
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6504e19e-d2db-4fcd-c1b9-08d78583526e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 19:32:16.5065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JP/s+5ROgygBmWca6rNlDfF+J+bwKsEasEp8QTrqSr2azQrRvCgYY6i+hQUOIn7cOVNrAxWUUibDFtWwuzC2gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2503
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sIFBldGVyLCBhbGwsDQoNCltzbmlwXQ0KIA0KPiBPbiAyMDE5LTEyLTIwIDI6MDYg
cG0sIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiA+IE9uIEZyaSwgRGVjIDIwLCAyMDE5IGF0IDEx
OjE5OjI3QU0gKzAxMDAsIE1hcmMgR29uemFsZXogd3JvdGU6DQo+ID4+IFdvdWxkIGFueW9uZSBl
bHNlIGhhdmUgYW55IHN1Z2dlc3Rpb25zLCBjb21tZW50cywgaW5zaWdodHMsIHJlY29tbWVuZGF0
aW9ucywNCj4gPj4gaW1wcm92ZW1lbnRzLCBndWlkYW5jZSwgb3Igd2lzZG9tPyA6LSkNCj4gPg0K
PiA+IEZsaXAgZGV2cmVzIHVwc2lkZSBkb3duIQ0KPiANCj4gV2hpY2ggZG9lc24ndCByZWFsbHkg
aGVscCA6KA0KPiANCj4gPiAqKldBUk5JTkcsIHdlYXIgcHJvdGVjdGl2ZSBnbGFzc2VzIHdoZW4g
cmVhZGluZyB0aGUgYmVsb3cqKg0KPiA+DQo+ID4NCj4gPiBzdHJ1Y3QgZGV2cmVzIHsNCj4gPiAJ
c3RydWN0IGRldnJlc19ub2RlCW5vZGU7DQo+ID4gCXZvaWQJCQkqZGF0YTsNCj4gPiB9Ow0KPiA+
DQo+ID4gLyoNCj4gPiAgICogV2UgcGxhY2Ugc3RydWN0IGRldnJlcyBhdCB0aGUgdGFpbCBvZiB0
aGUgbWVtb3J5IGFsbG9jYXRpb24NCj4gPiAgICogc3VjaCB0aGF0IGRhdGEgcmV0YWlucyB0aGUg
QVJDSF9LTUFMTE9DX01JTkFMSUdOIGFsaWdubWVudC4NCj4gPiAgICogc3RydWN0IGRldnJlcyBp
dHNlbGYgaXMganVzdCA0IHBvaW50ZXJzIGFuZCBzaG91bGQgdGhlcmVmb3JlDQo+ID4gICAqIG9u
bHkgcmVxdWlyZSB0cml2aWFsIGFsaWdubWVudC4NCj4gPiAgICovDQo+ID4gc3RhdGljIGlubGlu
ZSBzdHJ1Y3QgZGV2cmVzICpkYXRhMmRldnJlcyh2b2lkICpkYXRhKQ0KPiA+IHsNCj4gPiAJcmV0
dXJuIChzdHJ1Y3QgZGV2cmVzICopKGRhdGEgKyBrc2l6ZShkYXRhKSAtIHNpemVvZihzdHJ1Y3Qg
ZGV2cmVzKSk7DQo+ID4gfQ0KPiA+DQo+ID4gdm9pZCAqYWxsb2NfZHIoLi4uKQ0KPiA+IHsNCj4g
PiAJc3RydWN0IGRldnJlcyAqZHI7DQo+ID4gCXZvaWQgKmRhdGE7DQo+ID4NCj4gPiAJZGF0YSA9
IGttYWxsb2Moc2l6ZSArIHNpemVvZihzdHJ1Y3QgZGV2cmVzKSwgR0ZQX0tFUk5FTCk7DQo+IA0K
PiBBdCB0aGlzIHBvaW50LCB5b3UnZCBzdGlsbCBuZWVkIHRvIHNwZWNpYWwtY2FzZSBkZXZtX2tt
YWxsb2MoKSB0byBlbnN1cmUNCj4gc2l6ZSBpcyByb3VuZGVkIHVwIHRvIHRoZSBuZXh0IEFSQ0hf
S01BTExPQ19NSU5BTElHTiBncmFudWxlLCBvciB5b3UnZA0KPiBnbyBiYWNrIHRvIHRoZSBvcmln
aW5hbCBwcm9ibGVtIG9mIHRoZSBzdHJ1Y3QgZGV2cmVzIGZpZWxkcyBwb3RlbnRpYWxseQ0KPiBz
aGFyaW5nIGEgY2FjaGUgbGluZSB3aXRoIHRoZSBkYXRhIGJ1ZmZlci4gVGhhdCBuZWVkcyB0byBi
ZSBhdm9pZGVkLA0KPiBiZWNhdXNlIGlmIHRoZSBkZXZyZXMgbGlzdCBpcyBtb2RpZmllZCB3aGls
ZSB0aGUgYnVmZmVyIGlzIG1hcHBlZCBmb3INCj4gbm9uY29oZXJlbnQgRE1BICh3aGljaCBjb3Vs
ZCBsZWdpdGltYXRlbHkgaGFwcGVuIGFzIHRoZXkgYXJlIG5vbWluYWxseQ0KPiBkaXN0aW5jdCBh
bGxvY2F0aW9ucyB3aXRoIGRpZmZlcmVudCBvd25lcnMpIHRoZXJlJ3MgbGlhYmxlIHRvIGJlIGRh
dGENCj4gY29ycnVwdGlvbiBvbmUgd2F5IG9yIHRoZSBvdGhlci4NCg0KV2VsbCBpdCBzb21laG93
IHVzZWQgdG8gd29yayBmb3IgcXVpdGUgc29tZSB0aW1lIG5vdyB3aXRoIHRoZSBkYXRhLWJ1ZmZl
cg0KYmVpbmcgYWxsb2NhdGVkIHdpdGggNCB3b3JkcyBvZmZzZXQgKHdoaWNoIGlzIDE2IGJ5dGVz
IGZvciAzMi1iaXQgcGxhdGZvcm0NCmFuZCAzMiBmb3IgNjQtYml0IHdoaWNoIGlzIHN0aWxsIG11
Y2ggbGVzcyB0aGFuIG1lbnRpb25lZCAxMjggYnl0ZXMpLg0KT3Igd2UganVzdCBuZXZlciBtYW5h
Z2VkIHRvIGlkZW50aWZ5IHRob3NlIHJhcmUgY2FzZXMgd2hlbiBkYXRhIGNvcnJ1cHRpb24NCnJl
YWxseSBoYXBwZW5lZD8NCg0KPiBObyBtYXR0ZXIgd2hpY2ggd2F5IHJvdW5kIHlvdSBhbGxvY2F0
ZSBkZXZyZXMgYW5kIGRhdGEsIGJ5IG5lY2Vzc2l0eQ0KPiB0aGV5J3JlIGFsd2F5cyBnb2luZyB0
byBjb25zdW1lIHRoZSBzYW1lIHRvdGFsIGFtb3VudCBvZiBtZW1vcnkuDQoNClNvIHRoZW4gdGhl
IG5leHQgb3B0aW9uIEkgZ3Vlc3MgaXMgdG8gc2VwYXJhdGUgbWV0YS1kYXRhIGZyb20gZGF0YSBi
dWZmZXJzDQpjb21wbGV0ZWx5LiBBcmUgdGhlcmUgYW55IHJlYXNvbnMgdG8gbm90IGRvIHRoYXQg
b3RoZXIgdGhhbiB0aGUgaGFjayB3ZSdyZQ0KZGlzY3Vzc2luZyBoZXJlIChtZXRhLWRhdGEgaW4g
dGhlIGJlZ2lubmluZyBvZiB0aGUgYnVmZmVyKSB1c2VkIHRvIHdvcmsgT0staXNoPw0KDQotQWxl
eGV5DQo=
