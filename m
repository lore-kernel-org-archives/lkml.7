Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71C3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5A221845
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WIuQfLWe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="laVvfxxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfKTPLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:11:42 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:33792 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728196AbfKTPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:11:41 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4BE29C2EE2;
        Wed, 20 Nov 2019 15:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1574262699; bh=1ENhUp8lTQ/s1kQGZibLhu5YZ//AFmMiJTIvxy+kJHw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WIuQfLWekwKpi00QqEO+nfWofbyQEAjLLtwqy8uTv6Lme/Z3BxVHqo6wybMI3take
         RoG9HlKF6eKxStax18lJ40vZC8CBQziLMk1GYZHKMMt6WxBJzydg3oDmmrVOSJKiIr
         +G+Dvv1dIRL0Z7jiQZqPCxGx17zlCUlaA51W1eU+dRoJqaMxE3KRiiVJxodzoIQWUR
         O7npbBdbO3IF6XPMjLyS4230uzJt565BbtJR9yEBmaN3PyuEelFuC5Sb0XA2g3WPDk
         FlUgyFMhNzRjcEF76tmtcLXLu0tmLjq2CZyI8S1VXEnzvJRd1JQtyfFPuKNPtuqfXO
         lRfTLPdDgfUxQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 694F5A0066;
        Wed, 20 Nov 2019 15:11:38 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.13.188.44) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 20 Nov 2019 07:11:06 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.13.177.249)
 by mrs.synopsys.com (10.13.188.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 20 Nov 2019 07:11:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYa+YpOhV1JtisG7oDi9mMl7lA4ll2ySbmfzkOZyqjIU+13qsu6AW4oD9wdwbgM1dbmzHxsM1hVeVwUdkKRIrVUddiKqZWDrEISwM5jHo+2g/2gpfOR/r9siWl59u4FuGGnPXCDkGMdnk5pyI2lLxk64IT+J4IbkL9ICGoOXtp/ZiRMvnl/UZ8sWh2ax6WDPQqxzmwM7v24ZmX49lhypo5v5IdbKIK+5qXJ8EWzEMcZdZja24Riek2QmF+ETzlY1Dkhao6lytVVLP+GayyI4shdX86pR8rwxubf2SEc4XXfWwpS6WTGEYcV1coqokv3pK83P4UhbjwmukB1s+rxebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ENhUp8lTQ/s1kQGZibLhu5YZ//AFmMiJTIvxy+kJHw=;
 b=kpVAJsjcnnvtFZF0p6cu2Xos00aS6yOsExAfrfr14mhbEfRPE9Y9KCprTj6/d6KGT5MEF+kCoXRLqQRYY7R3NHVonO75ZwQ0nCIq4KKl7v/ZcHLyi0DWe0+anHXAzeX58RVp7XbDkGAqRD98Ew5DJkiy9qMMEKhC/s3yV1bqwicAWnbGi9++uC9lXiLzblKaEFOkWP0eRCtWGFYeA/QBydFCR5twvBJKAHuYlPpUYBQdEs7r/hat8x+b7tt/HJSkB1zvlB/0JoWlHQFdUNCvFLhdSsmya9Z8mSKJZxsDyxFT1UsZ7lma1NO8xaYFZvuSo0Kmv4WuJdBKEmgoY7JXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ENhUp8lTQ/s1kQGZibLhu5YZ//AFmMiJTIvxy+kJHw=;
 b=laVvfxxWRDx8z7vNuR0v63gdzFVaqSeIslg6X0sGQUH9BZIvhh7Cx9UnBxTNaUJKbGFe6tNG6KdmGaOqUwhh5VELuNf1MNW6rHhhpD2+C2NXw9RfsdAQkKkd84/k9NYhdxZ3fK/qrB1Vz/da5Q4Tt/p5ur/wdSF4v+0+eKrzQHU=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 15:11:04 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::b0c9:8724:cdaf:10b1]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::b0c9:8724:cdaf:10b1%2]) with mapi id 15.20.2474.015; Wed, 20 Nov 2019
 15:11:03 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Anvesh Salveru <anvesh.s@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "pankaj.dubey@samsung.com" <pankaj.dubey@samsung.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: RE: [PATCH v3 0/2] Add support to handle ZRX-DC Compliant PHYs
Thread-Topic: [PATCH v3 0/2] Add support to handle ZRX-DC Compliant PHYs
Thread-Index: AQHVn6ZHxYrMzBpN+kWkuE+ujwJWYaeUKbsw
Date:   Wed, 20 Nov 2019 15:11:03 +0000
Message-ID: <DM6PR12MB40104F3F6D5ACE478F0ACEB3DA4F0@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <CGME20191120132645epcas5p29da16b1881e3da52fac0516a32e277d5@epcas5p2.samsung.com>
 <1574256371-617-1-git-send-email-anvesh.s@samsung.com>
In-Reply-To: <1574256371-617-1-git-send-email-anvesh.s@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWjNWemRHRjJiMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MV1kxWTJSaE9ETTRMVEJpWVRjdE1URmxZUzA1T0RrNUxXWTRPVFJq?=
 =?utf-8?B?TWpjek9EQTBNbHhoYldVdGRHVnpkRnhtTldOa1lUZ3pZUzB3WW1FM0xURXha?=
 =?utf-8?B?V0V0T1RnNU9TMW1PRGswWXpJM016Z3dOREppYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?SXdPRFFpSUhROUlqRXpNakU0TnpNMk1qWXdPVGMxTURjM015SWdhRDBpTm14?=
 =?utf-8?B?RWRrcEtVRzUzYVN0bGVIRTVTMjlwTlhBNFFraDVUVUozUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlFsRktRVUZFTVZscFlUUjBTaTlXUVdKcVVVZGFiWFpWUkZORWRV?=
 =?utf-8?B?NUJXbTFoT1ZGT1NVMVBRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUTJ0RFFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGRlIwbFplbEZCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKdFFVZHJRV0puUW1oQlJ6UkJXWGRDYkVGR09FRmpRVUp6UVVkRlFX?=
 =?utf-8?B?Sm5RblZCUjJ0QlltZENia0ZHT0VGa2QwSm9RVWhSUVZwUlFubEJSekJCV1ZG?=
 =?utf-8?B?Q2VVRkhjMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhXVUZpZDBJeFFVYzBRVnBCUW5sQlNHdEJXSGRD?=
 =?utf-8?B?ZDBGSFJVRmpaMEl3UVVjMFFWcFJRbmxCU0UxQldIZENia0ZIV1VGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV21kQ2RrRklWVUZpWjBKclFV?=
 =?utf-8?B?aEpRV1ZSUW1aQlNFRkJXVkZDZVVGSVVVRmlaMEpzUVVoSlFXTjNRbVpCU0Ux?=
 =?utf-8?B?QldWRkNkRUZJVFVGa1VVSjFRVWRqUVZoM1FtcEJSemhCWW1kQ2JVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVW8wUVVGQlFtMUJSemhC?=
 =?utf-8?B?WkZGQ2RVRkhVVUZqWjBJMVFVWTRRV05CUW1oQlNFbEJaRUZDZFVGSFZVRmpa?=
 =?utf-8?B?MEo2UVVZNFFXTjNRbWhCUnpCQlkzZENNVUZITkVGYWQwSm1RVWhKUVZwUlFu?=
 =?utf-8?B?cEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGRlFVRkJRVUZCUVVGQlFXZEJRVUZCUVVGdVow?=
 =?utf-8?B?RkJRVWRaUVdKM1FqRkJSelJCV2tGQ2VVRklhMEZZZDBKM1FVZEZRV05uUWpC?=
 =?utf-8?B?QlJ6UkJXbEZDZVVGSVRVRllkMEo2UVVjd1FXRlJRbXBCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJVVUZCUVVGQlFVRkJRVU5C?=
 =?utf-8?B?UVVGQlFVRkRaVUZCUVVGYVowSjJRVWhWUVdKblFtdEJTRWxCWlZGQ1prRklR?=
 =?utf-8?B?VUZaVVVKNVFVaFJRV0puUW14QlNFbEJZM2RDWmtGSVRVRmtRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUWtGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGSlFVRkJRVUZCU2pSQlFVRkNiVUZIT0VGa1VVSjFRVWRSUVdO?=
 =?utf-8?B?blFqVkJSamhCWTBGQ2FFRklTVUZrUVVKMVFVZFZRV05uUW5wQlJqaEJaRUZD?=
 =?utf-8?B?ZWtGSE1FRlpkMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVUZCUVVGQlFVRkJaMEZCUVVGQlFXNW5RVUZCUjFsQlluZENN?=
 =?utf-8?B?VUZITkVGYVFVSjVRVWhyUVZoM1FuZEJSMFZCWTJkQ01FRkhORUZhVVVKNVFV?=
 =?utf-8?B?aE5RVmgzUWpGQlJ6QkJXWGRCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZSUVVGQlFVRkJRVUZCUTBGQlFVRkJRVU5sUVVG?=
 =?utf-8?B?QlFWcDNRakJCU0UxQldIZENkMEZJU1VGaWQwSnJRVWhWUVZsM1FqQkJSamhC?=
 =?utf-8?B?WkVGQ2VVRkhSVUZoVVVKMVFVZHJRV0puUW01QlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQ1FVRkJRVUZCUVVGQlFVbEJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUo2UVVkRlFXSkJRbXhCU0UxQldIZENhRUZIVFVGWmQw?=
 =?utf-8?B?SjJRVWhWUVdKblFqQkJSamhCWTBGQ2MwRkhSVUZpWjBGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSVRVRlpVVUp6UVVkVlFXTjNRbVpC?=
 =?utf-8?B?U0VWQlpGRkNka0ZJVVVGYVVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJZM2RDZFVGSVFV?=
 =?utf-8?B?RmpkMEptUVVkM1FXRlJRbXBCUjFWQlltZENla0ZIVlVGWWQwSXdRVWRWUVdO?=
 =?utf-8?B?blFuUkJSamhCVFZGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVbzBRVUZC?=
 =?utf-8?B?UW5wQlJ6UkJZMEZDZWtGR09FRmlRVUp3UVVkTlFWcFJRblZCU0UxQldsRkNa?=
 =?utf-8?B?a0ZJVVVGYVVVSjVRVWN3UVZoM1FucEJTRkZCWkZGQ2EwRkhWVUZpWjBJd1FV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdkQlFV?=
 =?utf-8?B?RkJRVUZ1WjBGQlFVaFpRVnAzUW1aQlIzTkJXbEZDTlVGSVkwRmlkMEo1UVVk?=
 =?utf-8?B?UlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJRVUZC?=
 =?utf-8?Q?QUFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gustavo@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 682fa742-7b31-4ae2-4a8e-08d76dcbdc66
x-ms-traffictypediagnostic: DM6PR12MB3947:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3947D3E6B6C8CAE626BB5B78DA4F0@DM6PR12MB3947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(136003)(366004)(189003)(199004)(256004)(26005)(305945005)(66066001)(229853002)(2906002)(7416002)(478600001)(54906003)(33656002)(52536014)(110136005)(7736002)(4326008)(14454004)(5660300002)(55016002)(11346002)(446003)(476003)(25786009)(86362001)(7696005)(53546011)(6506007)(71200400001)(71190400001)(9686003)(316002)(6436002)(76176011)(8936002)(99286004)(186003)(3846002)(6116002)(102836004)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(74316002)(2501003)(8676002)(81166006)(81156014)(486006)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3947;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q39PYB+9KAcASPm6M4Mi81vtsq4mvTtePwzb6nTw7IeSqRHXcMCIR3Gbn9m7syEOga93IHLBIVI4Trwk+LWvqbUqge6tRyGAbneH3ChWpgJiOWUMjWqxFKwAm1oGbmvybpceUNtg4OHJmwS24d+QLMORbJScMBVduQZmaUcItVmzEAVlOT4hI1UXu/SH0vvMLiNnNHQJK1QbGxO2cNoEmHD8pQyc7M2isMPZaz73btGv2c98NJV4RdSYg47GBISKdX2Z5W9FoF/3iaiKcgFLJX0iZoywQp8f2hIeY8JI0P+J0Nfp2Z7WMlYFUiraJdHBYwybCwE2r82DwOEKEAjqp8/rzZZ4f7kQmWooeCPj525dpNLJnfd5ffa2JOnxEg43ToiHvO/hkYoPJkOdLZCN7xPGEdjuJoDpZt9y4mHRq+AgUZ3MC+n6qcPbvpd/hBml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 682fa742-7b31-4ae2-4a8e-08d76dcbdc66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 15:11:03.7795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U31z1jvAT107NffbjfEgVGM7g3YljDEltmQld1P33IctyNv3xintLlhsOhqHtZA/v1zdKIW3TP6YQl0CNmS+og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3947
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCllvdSBtaXNzZWQgdG8gc2VuZGluZyB0aGlzIHBhdGNoIHNlcmllcyB0byBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnLg0KDQpSZWdhcmRzLA0KR3VzdGF2bw0KDQpPbiBXZWQsIE5vdiAy
MCwgMjAxOSBhdCAxMzoyNjo5LCBBbnZlc2ggU2FsdmVydSA8YW52ZXNoLnNAc2Ftc3VuZy5jb20+
IA0Kd3JvdGU6DQoNCj4gQWNjb3JkaW5nIHRoZSBQQ0kgRXhwcmVzcyBiYXNlIHNwZWNpZmljYXRp
b24gd2hlbiBQSFkgZG9lcyBub3QgbWVldA0KPiBaUlgtREMgc3BlY2lmaWNhdGlvbiwgYWZ0ZXIg
ZXZlcnkgMTAwbXMgdGltZW91dCB0aGUgbGluayBzaG91bGQNCj4gdHJhbnNpdGlvbiB0byByZWNv
dmVyeSBzdGF0ZSB3aGVuIHRoZSBsaW5rIGlzIGluIGxvdyBwb3dlciBzdGF0ZXMuIA0KPiANCj4g
UG9ydHMgdGhhdCBtZWV0IHRoZSBaUlgtREMgc3BlY2lmaWNhdGlvbiBmb3IgMi41IEdUL3Mgd2hp
bGUgaW4gdGhlDQo+IEwxLklkbGUgc3RhdGUgYW5kIGFyZSB0aGVyZWZvcmUgbm90IHJlcXVpcmVk
IHRvIGltcGxlbWVudCB0aGUgMTAwIG1zDQo+IHRpbWVvdXQgYW5kIHRyYW5zaXRpb24gdG8gUmVj
b3Zlcnkgc2hvdWxkIGF2b2lkIGltcGxlbWVudGluZyBpdCwgc2luY2UNCj4gaXQgd2lsbCByZWR1
Y2UgdGhlIHBvd2VyIHNhdmluZ3MgZXhwZWN0ZWQgZnJvbSB0aGUgTDEgc3RhdGUuDQo+IA0KPiBE
ZXNpZ25XYXJlIGNvbnRyb2xsZXIgcHJvdmlkZXMgR0VOM19aUlhEQ19OT05DT01QTCBmaWVsZCBp
bg0KPiBHRU4zX1JFTEFURURfT0ZGIHRvIHNwZWNpZnkgYWJvdXQgWlJYLURDIGNvbXBsaWFudCBQ
SFkuDQo+IA0KPiBXZSBuZWVkIHRvIGdldCB0aGUgUEhZIHByb3BlcnR5IGluIGNvbnRyb2xsZXIg
ZHJpdmVyLiBTbywgd2UgYXJlDQo+IHByb3Bvc2luZyBhIG5ldyBtZXRob2QgcGh5X3Byb3BlcnR5
X3ByZXNlbnQoKSBpbiB0aGUgcGh5IGRyaXZlci4NCj4gDQo+IFBsYXRmb3JtIHNwZWNpZmljIHBo
eSBkcml2ZXJzIHNob3VsZCBpbXBsZW1lbnQgdGhlIGNhbGxiYWNrIGZvcg0KPiBwcm9wZXJ0eV9w
cmVzZW50IHdoaWNoIHdpbGwgcmV0dXJuIHRydWUgaWYgdGhlIHByb3BlcnR5IGV4aXN0cyBpbg0K
PiB0aGUgUEhZLg0KPiANCj4gc3RhdGljIGJvb2wgeHh4eF9waHlfcHJvcGVydHlfcHJlc2VudChz
dHJ1Y3QgcGh5ICpwaHksIGNvbnN0IGNoYXIgKnByb3BlcnR5KQ0KPiB7DQo+ICAgICAgICBzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGh5LT5kZXY7DQo+IA0KPiAgICAgICAgcmV0dXJuIG9mX3Byb3Bl
cnR5X3JlYWRfYm9vbChkZXYtPm9mX25vZGUsIHByb3BlcnR5KTsNCj4gfQ0KPiANCj4gQW5kIGNv
bnRyb2xsZXIgcGxhdGZvcm0gZHJpdmVyIHNob3VsZCBwb3B1bGF0ZSB0aGUgcGh5X3pyeGRjX2Nv
bXBsaWFudA0KPiBmbGFnLCB3aGljaCB3aWxsIGJlIHVzZWQgYnkgZ2VuZXJpYyBEZXNpZ25XYXJl
IGRyaXZlci4NCj4gDQo+IHBjaS0+cGh5X3pyeGRjX2NvbXBsaWFudCA9IHBoeV9wcm9wZXJ0eV9w
cmVzZW50KHh4eHhfY3RybC0+cGh5LCAicGh5LXpyeGRjLWNvbXBsaWFudCIpOw0KPiANCj4gQW52
ZXNoIFNhbHZlcnUgKDIpOg0KPiAgIHBoeTogY29yZTogYWRkIHBoeV9wcm9wZXJ0eV9wcmVzZW50
IG1ldGhvZA0KPiAgIFBDSTogZHdjOiBhZGQgc3VwcG9ydCB0byBoYW5kbGUgWlJYLURDIENvbXBs
aWFudCBQSFlzDQo+IA0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLmMgfCAgNiArKysrKysNCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVz
aWdud2FyZS5oIHwgIDQgKysrKw0KPiAgZHJpdmVycy9waHkvcGh5LWNvcmUuYyAgICAgICAgICAg
ICAgICAgICAgICAgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgaW5jbHVkZS9s
aW51eC9waHkvcGh5LmggICAgICAgICAgICAgICAgICAgICAgfCAgOCArKysrKysrKw0KPiAgNCBm
aWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspDQo+IA0KPiAtLSANCj4gMi43LjQNCg0KDQo=
