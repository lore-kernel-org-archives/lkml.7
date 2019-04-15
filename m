Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34025C10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 00:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1392084E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 00:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="GuJpItaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfDOA1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:27:53 -0400
Received: from mail-eopbgr750123.outbound.protection.outlook.com ([40.107.75.123]:20703
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbfDOA1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 20:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgAwppD5yICrzY8xg8UsrGia/T63ZzUOT8OEF1JOhhc=;
 b=GuJpItaTOF1w2Ulo+QzbgmLSM+d9u3xrERsFLvjNi37wSScurHkn6fgZgQXkGIXHOvVeOaYmG5Dl4je17yBhSzmszKyo8zC2CVJ+tRvcvOn/jRV8Qkk4h5IWN1EvZ6TjkAaIhLxkTwHEyk4EiUlUWc7n1dS+5n+gVqSYoXL7e5E=
Received: from BN6PR1301CA0025.namprd13.prod.outlook.com
 (2603:10b6:405:29::38) by BN6PR13MB3121.namprd13.prod.outlook.com
 (2603:10b6:405:7e::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.9; Mon, 15 Apr
 2019 00:27:49 +0000
Received: from SN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN6PR1301CA0025.outlook.office365.com
 (2603:10b6:405:29::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.9 via Frontend
 Transport; Mon, 15 Apr 2019 00:27:48 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.44)
 smtp.mailfrom=sony.com; lists.one-eyed-alien.net; dkim=none (message not
 signed) header.d=none;lists.one-eyed-alien.net; dmarc=bestguesspass
 action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.44; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.44) by
 SN1NAM02FT059.mail.protection.outlook.com (10.152.72.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Mon, 15 Apr 2019 00:27:48 +0000
Received: from JPYOKXHT107.jp.sony.com (117.103.191.54) by
 JPYOKXEG104.jp.sony.com (117.103.190.44) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 15 Apr 2019 00:27:44 +0000
Received: from JPYOKXMS103.jp.sony.com ([169.254.3.121]) by
 JPYOKXHT107.jp.sony.com ([117.103.191.54]) with mapi id 14.03.0439.000; Mon,
 15 Apr 2019 00:27:44 +0000
From:   <Kento.A.Kobayashi@sony.com>
To:     <stern@rowland.harvard.edu>, <bvanassche@acm.org>
CC:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>, <Jacky.Cao@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Topic: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Index: AdTVjvFIkAhaIt3DQTSj1OrTHxvrsgAQFLsAAIWEBcAAQQqsgAB7RvcAAgdcBTAAAJSpAACOr4UQABH/lYAA3G8Q4AAdt7kAAE4ci4AAIMlyAADXFiz8ABpB6wAAASSCgAADHJ6AAQuMo2A=
Date:   Mon, 15 Apr 2019 00:27:43 +0000
Message-ID: <AE5419EAB4965843B3C0C1FE29F1FFE5899C80@JPYOKXMS103.jp.sony.com>
References: <1554823007.161891.6.camel@acm.org>
 <Pine.LNX.4.44L0.1904091232370.1599-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904091232370.1599-100000@iolanthe.rowland.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:cf8:1:539:0:dddd:1bac:d758]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.44;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(189003)(199004)(7416002)(37786003)(4744005)(5660300002)(23726003)(2906002)(72206003)(106466001)(14444005)(33656002)(55016002)(2876002)(478600001)(26005)(86152003)(97756001)(102836004)(55846006)(4326008)(6116002)(186003)(77096007)(16586007)(110136005)(54906003)(47776003)(316002)(50466002)(426003)(305945005)(8676002)(8936002)(76176011)(106002)(356004)(6246003)(7636002)(2171002)(86362001)(476003)(246002)(229853002)(336012)(46406003)(7696005)(7736002)(446003)(126002)(486006)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR13MB3121;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg104.jp.sony.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87ff734f-bcab-427d-afa7-08d6c1393045
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR13MB3121;
X-MS-TrafficTypeDiagnostic: BN6PR13MB3121:
X-Microsoft-Antispam-PRVS: <BN6PR13MB3121F32466B22BE8A165D03FC92B0@BN6PR13MB3121.namprd13.prod.outlook.com>
X-Forefront-PRVS: 000800954F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0JWlszs4Lfwpjw61pARfDEEb7cwiQXvJVAsAHjys3dSM/koOqVmqzxOoD080dhTarT0Ekk15VveWEMBQtiYXCM966vLm4ZUS7rPD9IeKDrBsxhUPQdg4FMvu2k5qroL68+G1oOJgURwLcTUGdYWf+1d2qXYTf3TZ/HRRBVN4Ny1thcFecc5RiJYMvw3XGfZfFKLfPuYIiGSwXe251HiPfocEuC/qhiEkref/JZyciHznmBAargDXgXqtAWWRlsCuBPzOMqtAr9JzCIx0NpXh5RFz7qDVM0e5TrnJ2RdP65udZqMZF8eoZqyBOexP1aLq9fhJ0d+G2+kMoMKcrJYKp6QcL8x/1CIPCJuk51dsrn6SMf2yx3qE1tLAXIdq+BXFAvGZpnpgah4uCaNqvbJoRwOuAVtJX6NH21gnoyDePSI=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2019 00:27:48.1629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ff734f-bcab-427d-afa7-08d6c1393045
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.44];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB3121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>The unbind happens from inside the SCSI EH callback.  If that really is not allowed, we'll need to change it.  Or we can just change it regardless, since the effort required is pretty small.
>
>Kento, please try the patch below.  Does it help with your problem?

Thank you for suggestion about this problem.
I confirmed your patch fixes this problem.
I think you change policy for error handler to not calling unbind, right?
In addition, I have a question about this patch.
Could you please tell me why it should not be allowed that the unbind is occurred from eh callback?

This patch will ignore all error which is returned from usb_reset_and_verify_device.
But my patch will ignore error only being returned ENODEV case.
I think side effect of your patch is bigger than my patch.
So I want to know why the unbind is occurred from eh callback should not be allowed.

Regards,
Kento Kobayashi
