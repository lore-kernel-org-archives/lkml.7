Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C1CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508492070D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="V5/JDSJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDPCcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:32:06 -0400
Received: from mail-eopbgr710107.outbound.protection.outlook.com ([40.107.71.107]:26304
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfDPCcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMn1BBi8NOtyqLwi829bqgHOfCpb4Hp6ozwjwqqCGR0=;
 b=V5/JDSJ5sinFcTD6bTjq6EJ41VLxMMcLxj8+vMSfNxY4bguLRoBlLlu9xmOmN7HO3EET+TyDJIEvGEkYZWaXiM4r6mzpz5AxH5AjG+qJZzvad/edpJ8R5GBkH0vQb6JucBoKwtRaSagAW4pGxadbpaTPWhERfDAE0DFIjEz8+pQ=
Received: from BN6PR13CA0052.namprd13.prod.outlook.com (10.168.221.142) by
 DM5PR13MB1467.namprd13.prod.outlook.com (10.175.110.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.9; Tue, 16 Apr 2019 02:32:03 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR13CA0052.outlook.office365.com
 (2603:10b6:404:11::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.9 via Frontend
 Transport; Tue, 16 Apr 2019 02:32:02 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.42)
 smtp.mailfrom=sony.com; lists.one-eyed-alien.net; dkim=none (message not
 signed) header.d=none;lists.one-eyed-alien.net; dmarc=bestguesspass
 action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.42 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.42; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.42) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Tue, 16 Apr 2019 02:32:02 +0000
Received: from JPYOKXHT111.jp.sony.com (117.103.191.58) by
 JPYOKXEG102.jp.sony.com (117.103.190.42) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 16 Apr 2019 02:31:58 +0000
Received: from JPYOKXMS103.jp.sony.com ([169.254.3.121]) by
 JPYOKXHT111.jp.sony.com ([117.103.191.58]) with mapi id 14.03.0439.000; Tue,
 16 Apr 2019 02:31:57 +0000
From:   <Kento.A.Kobayashi@sony.com>
To:     <stern@rowland.harvard.edu>
CC:     <bvanassche@acm.org>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>, <oneukum@suse.com>,
        <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>, <Jacky.Cao@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Topic: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Index: AdTVjvFIkAhaIt3DQTSj1OrTHxvrsgAQFLsAAIWEBcAAQQqsgAB7RvcAAgdcBTAAAJSpAACOr4UQABH/lYAA3G8Q4AAdt7kAAE4ci4AAIMlyAADXFiz8ABpB6wAAASSCgAADHJ6AAQuMo2AAHyW3AAAAfZ6AABbW+uA=
Date:   Tue, 16 Apr 2019 02:31:57 +0000
Message-ID: <AE5419EAB4965843B3C0C1FE29F1FFE58A9BEA@JPYOKXMS103.jp.sony.com>
References: <Pine.LNX.4.44L0.1904151107350.1575-100000@iolanthe.rowland.org>
 <Pine.LNX.4.44L0.1904151129550.1575-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904151129550.1575-100000@iolanthe.rowland.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:cf8:1:539:0:dddd:1bac:d758]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.42;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(7416002)(72206003)(486006)(46406003)(476003)(478600001)(77096007)(55846006)(37786003)(5660300002)(356004)(86362001)(6246003)(126002)(186003)(2876002)(11346002)(102836004)(446003)(305945005)(54906003)(97756001)(4326008)(50466002)(336012)(86152003)(16586007)(7736002)(26005)(246002)(8676002)(229853002)(7636002)(47776003)(2351001)(4744005)(2171002)(7696005)(426003)(76176011)(106466001)(2906002)(33656002)(55016002)(106002)(6916009)(23726003)(8936002)(6116002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1467;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg102.jp.sony.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 010cebd3-9b4a-4611-0b6c-08d6c213b5ba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1467;
X-MS-TrafficTypeDiagnostic: DM5PR13MB1467:
X-Microsoft-Antispam-PRVS: <DM5PR13MB1467E77B40ECD7AE1C1928F6C9240@DM5PR13MB1467.namprd13.prod.outlook.com>
X-Forefront-PRVS: 000947967F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PNfAo8gYqtlU1s3hYTchuTWuQ3ykAPV4wDxmPdEyGGk3/xEE0L1cSdXWDRJ9OnqoyiTR/EbWJIFoD/bLDHhiU9qFFW2QcQt+V4Yg2850Z9+6907SOlbpPxwvnpoEhL6uye44OjC+wL4bvkrfR8RPKWARnXO/hBttbdB+g3QbSoceOq9fgivJZei7SycneiJti8NbNwBe1OLet39TzvAuqCvepeouPxFokP/PfMKPrTuHOQcgUxAhjwOdx4iouYWQNoIGnbDCxbrBCq9G/B7x7kXudo21ST6+gCx/0xrvB8/FKN+3UgSQLbT035Icp/yuw+Wk5dhm/onQWJyKFWTzlBMeDnkRdMNpFXZ8zK95AhCG0+b5WtVuTR+ydDdUruB0i94HnBAuLnH1KFNTKwm3uP6hj+50/kTIfErUpi3NJJA=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2019 02:32:02.3795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010cebd3-9b4a-4611-0b6c-08d6c213b5ba
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.42];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1467
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>On Mon, 15 Apr 2019, Alan Stern wrote:
>
>> On Mon, 15 Apr 2019 Kento.A.Kobayashi@sony.com wrote:
>> 
>> > Hi
>> > 
>> > >The unbind happens from inside the SCSI EH callback.  If that really is not allowed, we'll need to change it.  Or we can just change it regardless, since the effort required is pretty small.
>> > >
>> > >Kento, please try the patch below.  Does it help with your problem?
>> > 
>> > Thank you for suggestion about this problem.
>> > I confirmed your patch fixes this problem.
>> 
>> Good; I will submit it.

Thank you for allowing submit about fixing this problem.

>
>I forgot to ask: Is it okay to add
>
>	Tested-by: Kento Kobayashi <Kento.A.Kobayashi@sony.com>
>
>along with the patch?

Sure.
In addition, if you can, could you please add member who contribute to this problem fixing?
Cao, Jacky <Jacky.Cao@sony.com>

Regards,
Kento Kobayashi
