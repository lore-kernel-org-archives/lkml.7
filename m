Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC96C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D0B2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="pFZ/8kEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfHMJlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:41:23 -0400
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:60526
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfHMJlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:41:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OITJarHp0yA3cG7HCnOkNnCdCcvsiq/k2XXewJB+eI55kQbO80sKhW8QGY6KBzm8D0H0dv3sr84SYYzecrKiRcWCUAS6kzGS1cYU54mdgBCvhLZPCI4exjYPDFUNVQGhw3k/m+6ZH5LIi+8jvvypEjrdWCt7h+t/d64xquRu7UGijLxlGSgMVoVMrDgsvOIZtWaGm+OA4Nn/TtnmMNWd7PUVGeFm4fNteDnBu5IqnUrCOKg1fKjvss5/dQzYfaTmCCNA9gom6KTKuco5zXXH5YvmGJLoWb+jmn4u6j2MUxrrrF+k3Llh5EneY0V3Mr1+oKli95G2eisuMXADu3n/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwnmDVrL1ic0O5KfDixxo9AlEi4DdAspdGfXkfJw5Ac=;
 b=VV/YnkxEhCLEZEhEf85TpwGH03CnXzs4SHk1JlUU2hyKTWtWm+TCHEfwpHWLrUKMQK2iDm/nj0oisyg+iZoTTOjoshl5E2Oma54LzxOGwRI6+KIqk60Zhwz2S/2HZKF8G5BkWEq196ccdoPyVjGJP5DP9PUApJhIXQZJmT+W+V8A2h1ZaY8NfxzyLrOvmVCMyL7Uk1g6mISm8SaqoxfFIvh16+QKJmFafcxoKK2DWvinPpjqr+hk7JIiRaTQ1fT8RsBgr6exx1p4371auagAHaqXx1tbkuluMoZgnwKIfwSiAeRAr42ZcFkpK9cUg5dvMnE5C2vJ1oZcNckBA3ODWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.50) smtp.rcpttodomain=linux.com smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwnmDVrL1ic0O5KfDixxo9AlEi4DdAspdGfXkfJw5Ac=;
 b=pFZ/8kEVu4MbDUOZWdzoHPSkzVMvIokg9szMci2CDW6lSApXrqEdfZA7G8LRkFTa7P35OUYOEFhan99cffc+gmCvyzJ2QsKSW47ZCb5yQJyshoE96z3QcWW6eBC8ImmpNFWkRmZBQANoz0UjgiSKa4rY3tTiiv0fNA/wAaQjrHA=
Received: from AM5PR0601CA0046.eurprd06.prod.outlook.com
 (2603:10a6:203:68::32) by DB6PR0602MB3301.eurprd06.prod.outlook.com
 (2603:10a6:6:5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.21; Tue, 13 Aug
 2019 09:41:19 +0000
Received: from VE1EUR02FT014.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::205) by AM5PR0601CA0046.outlook.office365.com
 (2603:10a6:203:68::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18 via Frontend
 Transport; Tue, 13 Aug 2019 09:41:19 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=bestguesspass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT014.mail.protection.outlook.com (10.152.12.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2157.15 via Frontend Transport; Tue, 13 Aug 2019 09:41:17 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 11:41:14 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Tue, 13 Aug 2019 11:41:14 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Denis Efremov <efremov@linux.com>
Reply-To: <federico.vaga@cern.ch>
CC:     <linux-kernel@vger.kernel.org>, <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pat Riehecky <riehecky@fnal.gov>
Subject: Re: [PATCH] MAINTAINERS: Remove FMC subsystem
Date:   Tue, 13 Aug 2019 11:41:15 +0200
Message-ID: <2325538.becYRJFCFO@pcbe13614>
In-Reply-To: <20190813061547.17847-1-efremov@linux.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com> <20190813061547.17847-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(189003)(199004)(426003)(11346002)(186003)(305945005)(230700001)(16526019)(8676002)(26005)(6916009)(7736002)(478600001)(2906002)(246002)(33716001)(336012)(53546011)(7636002)(229853002)(3450700001)(44832011)(76176011)(54906003)(4744005)(47776003)(43066004)(4326008)(8936002)(446003)(46406003)(9576002)(14444005)(5660300002)(106002)(70586007)(316002)(9686003)(50466002)(6116002)(486006)(97756001)(476003)(23726003)(6246003)(86362001)(126002)(70206006)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0602MB3301;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1c57b75-5c9b-4dfa-e3bf-08d71fd263d6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DB6PR0602MB3301;
X-MS-TrafficTypeDiagnostic: DB6PR0602MB3301:
X-Microsoft-Antispam-PRVS: <DB6PR0602MB330139D79FC65EEAA3970DA8EFD20@DB6PR0602MB3301.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-Forefront-PRVS: 01283822F8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: E0CETaOYqTufZFK9+uh5Fc7jSQm9lL44fx07jceBwr44vT24BKBvuSmaanac1XkzMsEkU/RP20XPhB2oC0zZhqhrAzUbOn1blIrR5KNlf0THn0XJxKZmvkZxBUTVZm71cEjk3k9qRCmJeRVq13fi6e3to2lGpCfwfoEXKAimZjuOYt8SHecuBx2/4yPBXmsJcWT5XgVTSbxr+Uj4v7CBAmX30+AxDLE3POFP0qpmSjcKWTBdUjkZs4dUmezhp79YKB8ze3CnEkBfOYCfn2LfopRrWhdcfYvnZz328rNm1XDFLBJFzIIjcbqReIAHFNYD62hy+AUZ7B1PH4dZVMKJM2V15aqJjVugipqe7TH2tIwKMT9yEueRawRSlcG3Vf/wTlaCEWSReMIEPUZQ17L74PypMxi7eYhV0u9Qjv4zlDk=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 09:41:17.2242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c57b75-5c9b-4dfa-e3bf-08d71fd263d6
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0602MB3301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 13, 2019 8:15:47 AM CEST Denis Efremov wrote:
> Cleanup MAINTAINERS from FMC record since the subsystem was removed.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Federico Vaga <federico.vaga@cern.ch>
> Cc: Pat Riehecky <riehecky@fnal.gov>
> Fixes: 6a80b30086b8 ("fmc: Delete the FMC subsystem")
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Federico Vaga <federico.vaga@cern.ch>



