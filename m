Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB60C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EE222CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="rFTf2tCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfIDIwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:52:23 -0400
Received: from mail-eopbgr690121.outbound.protection.outlook.com ([40.107.69.121]:55203
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729045AbfIDIwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:52:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+QJ8gwuyDUKi8BDt3W9L/RevU54XelPV35tzL94on1XQAJ9enaRABX5G0VZaAkgVPc+HRbZMOOjVI6sqLcqPMiPxffzvUwLD1koi/xTfb8UFEpNeLiJadiJfKXpAW8zcVhGf7Sb/1eQbL4gt4wd4x2hzWDe5hVRRCzUoPbbln9xgnb1vF44d+t3TmPKYhBo7s/SIuG12+FjYnMXgfIpXvT0SsPdXjb4yWoFJSc3C+jiq54/1iK3uvSPdZ557cjguW/cvYxO5mYf/cKl0I1u7f1rTxdwNe7tm84i85Tbj+aXzBCDkSCnISA1rYAOeUU7grwgx8BlHzmfcpqWnb6cww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq2wALwUZMjFidryExAqg4OBakuRJaOAp8F1zLi5uFA=;
 b=DIZyD+k+sm1qcuMiVi2elg1Xwq24oV6Xh1r4aXXRM4LDZjiSB1dJVtyWcfF2hPh8nZ0mgb9bR2LZhSW/UGGuefSYmp2Xnstw48FkdyLCQFf8r7D3ZPjYVA27Ng0rjadcdxNgT8VJoDZL1KN+1MLS5l7dhxy+gHsaCg3h0ogEVg/6i58A2rQIzUbGvk98ECiQGf61+Lcm4kq9GoXGErDdqE8SwR6Qc9aEDsl5g98+kUfkZq/6NuyY1CfhCFtNj/psIXEDgsz4CtlBGOZu4+HzqYQIHydueWn2f1DpcJRVRDsOVmBBXN19+JG+hWv1KTdn8s5jbN/Y+ptZcUeZnWUHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 117.103.190.106) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq2wALwUZMjFidryExAqg4OBakuRJaOAp8F1zLi5uFA=;
 b=rFTf2tCWvYgPtoIVqRbeCkarYmypc7okgo7YS+z/UJCC7lE2EMCaGS0vnDdPHrZqMnOXuiIaqH/7zxDhwrEOKN2zmikzdFCdUBPtrLVnb3E3EZYgPmz9oYQtjg+VcujCYvehyBgfYaXyefxJ4751AA9yncyH1rYO20/WDj38OQ0=
Received: from DM5PR1301CA0001.namprd13.prod.outlook.com (2603:10b6:4:2a::14)
 by DM5PR13MB1433.namprd13.prod.outlook.com (2603:10b6:3:123::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.11; Wed, 4 Sep
 2019 08:52:19 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by DM5PR1301CA0001.outlook.office365.com
 (2603:10b6:4:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2241.10 via Frontend
 Transport; Wed, 4 Sep 2019 08:52:18 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.106)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.106 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.106; helo=ap.sony.com;
Received: from ap.sony.com (117.103.190.106) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Wed, 4 Sep 2019 08:52:18 +0000
Received: from APYOKXHT102.ap.sony.com (117.103.191.215) by
 APYOKXEG102.ap.sony.com (117.103.190.106) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 4 Sep 2019 08:52:13 +0000
Received: from APYOKXMS108.ap.sony.com ([169.254.3.47]) by
 APYOKXHT102.ap.sony.com ([117.103.191.215]) with mapi id 14.03.0468.000; Wed,
 4 Sep 2019 08:52:13 +0000
From:   <Jacky.Cao@sony.com>
To:     <gregkh@linuxfoundation.org>, <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stern@rowland.harvard.edu>, <Kento.A.Kobayashi@sony.com>,
        <Jacky.Cao@sony.com>
Subject: RE: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Topic: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Index: AdVi9W5+0ODcBoGLQOCjqUMWZobPywAAIucAAAAlZ4AAAcHL0A==
Date:   Wed, 4 Sep 2019 08:52:12 +0000
Message-ID: <16EA1F625E922C43B00B9D82250220500871C90C@APYOKXMS108.ap.sony.com>
References: <16EA1F625E922C43B00B9D82250220500871C862@APYOKXMS108.ap.sony.com>
 <87sgpcmr7v.fsf@gmail.com> <20190904075839.GA28042@kroah.com>
In-Reply-To: <20190904075839.GA28042@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [43.82.17.73]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.106;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(199004)(189003)(16586007)(106002)(110136005)(558084003)(76176011)(7736002)(86362001)(46406003)(4326008)(8936002)(316002)(7636002)(126002)(426003)(14444005)(7696005)(336012)(356004)(54906003)(246002)(186003)(305945005)(8676002)(229853002)(47776003)(478600001)(23726003)(26005)(5660300002)(2906002)(3846002)(6116002)(97756001)(102836004)(2876002)(55846006)(33656002)(50466002)(107886003)(486006)(70206006)(70586007)(6246003)(446003)(37786003)(11346002)(55016002)(476003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1433;H:ap.sony.com;FPR:;SPF:Pass;LANG:en;PTR:apyokxeg102.ap.sony.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ce5bdc8-be3b-4c0d-4967-08d731153151
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR13MB1433;
X-MS-TrafficTypeDiagnostic: DM5PR13MB1433:
X-Microsoft-Antispam-PRVS: <DM5PR13MB1433B899D2488B4B774133D587B80@DM5PR13MB1433.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0150F3F97D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4/HEJ+WKWz/Y75qzWIU+nVOR7iZtNpWo1iq+BBtVsiQ1qg/TybywV9yy+YhABNX6lT/NAotiT/zjdYnnWmAs8bZiri+dkDhvYw3CfmdXps6x3lZ5b+blfkIUTOJBEiBwzuOY8aBZqZICoPLP7qyh3BKM6LZDvN88Ke3fxbvnVdT3WmsUZMhj2/S9sUtsroKL7A+AqXjvJElxxuKmbhuzQrh4uNPL2YdRAA2RW1LHsHsSNg9xER1YlDMcHs18qnvxlGywvSzPPq4FJuFgqhCTb5bHk6Wcbn72hQLI/HQfGeWb5DowfADR8s7fJgHbkIsrYs8Q7H2XN7nA/fSd/hbMagBFgMGXlXKug5fBe9cmZ0umzZpi9timdcmB8repwMX1IEeOceuDp4BcFrpVPo+rnjLgHgxSHrvPzcAjbnOfoCI=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2019 08:52:18.3115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce5bdc8-be3b-4c0d-4967-08d731153151
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.106];Helo=[ap.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1433
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> I'm not ok with the whitespace damage making this patch impossible to apply :)

Sorry for the whitespace damage issue I didn't notice when I copied the content.
Just now I submitted v2 for this patch with whitespace damage issue fix.
Please help to confirm, thank you.

Regards
Jacky
