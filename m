Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40080C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138532082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="fG4ln40X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392842AbfIFJET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:04:19 -0400
Received: from mail-eopbgr790095.outbound.protection.outlook.com ([40.107.79.95]:12928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732970AbfIFJES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:04:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4iNd4aVKn0u+bVNchhMqFUWm8q3afM7/GqaP8jy4SWPS6VwEQhoRSGNVyggU/BANDGh7FJQmNJfS0w28P+4zkRw1R5JEJSZa+w6TBLDBMGxHeUTKTqwlTG2u1ddKfGRLk+rqMmKRoZwqi40bknwzKOaYSLFaofnd8dexzR/EuyrGOiZTn2dhozPYMyOLGPWQVVrxJTovjERgS9ZpfXp2JMHvhv5+W2c5S+uovOsbCWkcRlt8/nmXc6FHkS2axMCoz5Lx/yI2rKEMN9doqy2i308aXeWg3lGGl4zRWJwXZrqVeKguPe6FW6KU+JAQZ9lmGtEnZo/c8d8DGIOfiVyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdamTeRair1aglxz7uQ3c0QzGDJQS6W1bPl3Vb2yp00=;
 b=MVolaatN/I47AhkzT38PQ821NYEsYQdxLILIG1qsHCFLTShVrcNOALuTVA3THmn5hZo6t+UYBCQ5SaZftywoF0riV3l+b4xa0nfTgNYv6vE85OI6DG3w35MviHNeFkrnLoI0kdJrNSc+iK5Aoy5dF/AlG2FYYci5eIVYIlQMjxENWYmIK7+MbszDwGbE0bulhMa7z89BrdZYDeyhCGi8mNPFEXjOp3KqJcHtlmD4mG5ifLt0ezIkD3nan5/R/Qe4gm7IDJglQgqKfbKLny6Nrhy1XiQ6XcIlT0DZ44fniFyuXZT6U3g5Ni0yybcJUErLYrLsvCECUmX+2T0s9kPfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 117.103.190.106) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdamTeRair1aglxz7uQ3c0QzGDJQS6W1bPl3Vb2yp00=;
 b=fG4ln40X6xKbYiBa4TQFoiBuHHHEt9BNGszpBC8hhsO01E9bJeC9xOqpp3Mmo7kbIbOHQHvZZBWrDkzN0u3wiQhuKFepxM6kRm7cXSArKGPcG2AHC4hYv9V4MjjdEAQSiCzUc4rWnA5kG+Af5GVs0yBh3WsLjm73PrGAsWLl8Ok=
Received: from MWHPR13CA0047.namprd13.prod.outlook.com (2603:10b6:300:95::33)
 by DM5PR13MB1836.namprd13.prod.outlook.com (2603:10b6:3:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.14; Fri, 6 Sep
 2019 09:04:16 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by MWHPR13CA0047.outlook.office365.com
 (2603:10b6:300:95::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.7 via Frontend
 Transport; Fri, 6 Sep 2019 09:04:16 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.106)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.106 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.106; helo=ap.sony.com;
Received: from ap.sony.com (117.103.190.106) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2241.14 via Frontend Transport; Fri, 6 Sep 2019 09:04:15 +0000
Received: from APYOKXHT201.ap.sony.com (117.103.191.228) by
 APYOKXEG102.ap.sony.com (117.103.190.106) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Fri, 6 Sep 2019 09:04:07 +0000
Received: from APYOKXMS108.ap.sony.com ([169.254.3.47]) by
 APYOKXHT201.ap.sony.com ([180.12.183.216]) with mapi id 14.03.0468.000; Fri,
 6 Sep 2019 09:04:07 +0000
From:   <Jacky.Cao@sony.com>
To:     <gregkh@linuxfoundation.org>
CC:     <balbi@kernel.org>, <stern@rowland.harvard.edu>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kento.A.Kobayashi@sony.com>, <Jacky.Cao@sony.com>
Subject: RE: [PATCH v3] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Topic: [PATCH v3] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Index: AdVjnzygYGk1oEEuTFussd4DlSzUEgAjPt8AABiZ/yA=
Date:   Fri, 6 Sep 2019 09:04:06 +0000
Message-ID: <16EA1F625E922C43B00B9D82250220500871DA91@APYOKXMS108.ap.sony.com>
References: <16EA1F625E922C43B00B9D82250220500871CDE5@APYOKXMS108.ap.sony.com>
 <20190905205516.GA25749@kroah.com>
In-Reply-To: <20190905205516.GA25749@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [43.82.17.73]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.106;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(189003)(199004)(5660300002)(8676002)(23726003)(6116002)(33656002)(106002)(4744005)(37786003)(3846002)(16586007)(316002)(2906002)(7636002)(6916009)(246002)(7736002)(305945005)(46406003)(70206006)(2876002)(76176011)(26005)(102836004)(54906003)(446003)(97756001)(8936002)(186003)(70586007)(476003)(478600001)(11346002)(486006)(126002)(2351001)(426003)(50466002)(4326008)(55016002)(7696005)(86362001)(356004)(107886003)(66066001)(229853002)(47776003)(55846006)(6246003)(336012);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1836;H:ap.sony.com;FPR:;SPF:Pass;LANG:en;PTR:APYOKXEG102.ap.sony.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f6730e1-3ecb-4aec-cbbd-08d732a931a5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR13MB1836;
X-MS-TrafficTypeDiagnostic: DM5PR13MB1836:
X-Microsoft-Antispam-PRVS: <DM5PR13MB1836C14C1756D3F09EAADAC587BA0@DM5PR13MB1836.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:276;
X-Forefront-PRVS: 0152EBA40F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XO1xl1BScFYzTZPOX4Y0tGDK+Y5kpSW2jvktpEbj4UbkHb3klTphVYG7DDffgk1oIKrKVxCy1atlTZ3J32rtxwMPgWr58bnXjb98zbu9HVKtMUO3OQKa3xj43tH6Jh7gLiJI8O0dLWMW3zXp4CZ89E40XYmsSiAsccmpdWr5c07N5GbMWRciU3kZaJ0+MByesTcQe+sFcRVhJSVQJ2UuBIaIGcVQXmj48b+oLTOCwTfLl39ajiiBGNUonE2oFIk0+kBfnT3yMwSJlgXGCnwSRxNChrUPrqM3hcc58jz6/DSoUj3Ss5eNN0vCDU+OPxKUk72FDghMw/6GtnSEXb373Y6t9BdCqrJ3bRgQBlvj6x/YrE2Sggo0G/uG2N6Cunlz47iC1HppZfeasn47zJfUGyW1EsgjPxAki+ggbs24C8I=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2019 09:04:15.5221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6730e1-3ecb-4aec-cbbd-08d732a931a5
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.106];Helo=[ap.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> 
> Does this "fix" a specific commit in the tree, and if so, what is the commit id of
> that?  Also, should this go to the stable kernel(s)?
> 
> thanks,
> 
> greg k-h

No, this fix is not for specific commit since the POWER_BUDGET(500mA) is used for 
SuperSpeed mode when dummy hcd added SuperSpeed support in commit(1cd8fd2887).

And I think it should be imported to stable kernel(s) considering the "insufficient
available bus power error" mentioned in commit message really happens. We reproduced
this issue with linux-3.10, linux-4.9 which we use and confirmed it can be solved by
this modification.

Regards
Jacky
