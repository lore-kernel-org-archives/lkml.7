Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529DBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D28F20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="m7SYWm44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCHJNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:13:14 -0500
Received: from mail-eopbgr790100.outbound.protection.outlook.com ([40.107.79.100]:5594
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbfCHJNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgG044q/luIMsUbNKkRppdnbdoVcu99wrWbqT9UFuWI=;
 b=m7SYWm44PfWhFgskDLTS6SgsyN5x7zrdPFGXMj588WloHQWjSacEGAReO91SKoCLZkXrgdbHunQzY3DUXUlXeMWzXtXhZHQe/6OCcDN4QBevMoQNLKSmRDP+9y2cXQdUScXXEiuLktOENuzm9Zo3wFP9boq/5eR+P/zDhqIpuxg=
Received: from MWHPR1301CA0019.namprd13.prod.outlook.com
 (2603:10b6:301:29::32) by MWHPR13MB1470.namprd13.prod.outlook.com
 (2603:10b6:300:124::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.12; Fri, 8 Mar
 2019 09:13:10 +0000
Received: from CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MWHPR1301CA0019.outlook.office365.com
 (2603:10b6:301:29::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.8 via Frontend
 Transport; Fri, 8 Mar 2019 09:13:10 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.43)
 smtp.mailfrom=sony.com; lists.one-eyed-alien.net; dkim=none (message not
 signed) header.d=none;lists.one-eyed-alien.net; dmarc=bestguesspass
 action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.43; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.43) by
 CY1NAM02FT021.mail.protection.outlook.com (10.152.75.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.11 via Frontend Transport; Fri, 8 Mar 2019 09:13:09 +0000
Received: from JPYOKXHT202.jp.sony.com (117.103.191.80) by
 JPYOKXEG103.jp.sony.com (117.103.190.43) with Microsoft SMTP Server (TLS) id
 14.3.435.0; Fri, 8 Mar 2019 09:13:07 +0000
Received: from JPYOKXMS103.jp.sony.com ([169.254.3.233]) by
 JPYOKXHT202.jp.sony.com ([180.12.183.210]) with mapi id 14.03.0435.000; Fri,
 8 Mar 2019 09:13:06 +0000
From:   <Kento.A.Kobayashi@sony.com>
To:     <oneukum@suse.com>, <stern@rowland.harvard.edu>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: uas: fix usb subsystem hang after power off hub port
Thread-Topic: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Index: AdTVjvFIkAhaIt3DQTSj1OrTHxvrsg==
Date:   Fri, 8 Mar 2019 09:13:05 +0000
Message-ID: <AE5419EAB4965843B3C0C1FE29F1FFE5872241@JPYOKXMS103.jp.sony.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:cf8:1:539:0:dddd:1bac:d758]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.43;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(189003)(199004)(7696005)(55846006)(50466002)(46406003)(55016002)(478600001)(2876002)(86362001)(2906002)(86152003)(4326008)(126002)(106002)(110136005)(336012)(356004)(486006)(316002)(14444005)(54906003)(2201001)(426003)(476003)(33656002)(26005)(186003)(7736002)(2171002)(77096007)(23726003)(16586007)(102836004)(5660300002)(8936002)(305945005)(72206003)(246002)(97756001)(8676002)(37786003)(6116002)(106466001)(47776003)(7636002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1470;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:JPYOKXEG103.jp.sony.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f768d706-67d2-494c-2f7d-08d6a3a6490e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR13MB1470;
X-MS-TrafficTypeDiagnostic: MWHPR13MB1470:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1470;20:S46EsV8rGyiWFcq1wdQsThSHxCl35JSOkkEc9QRQVVQZvMFhiDT8KwfdIEDlgxhF+NvnVgyiZAxz5oNbBdjkg1lictV6lMUGzWDbOL570AEPkyGp6XQLmVZy8SXa1DF4auxDKHACuTlnvszzioBtrS81Gi7z7TiRO+VOMbRXmI/lA9vLAsY80hYToyjKIswZqq9W1zMo+mUt/lg2WAX0rxDVjEhmcFH/hu74M4ZIu9z1n9/o5guMjfEXfxhr3JDCY/N+uWVBaRdogE+Y+wQsWONpCXdv3wdJvAHI9f9J+/tBkvT75KqA2Tpiow/HYI0oL/qZtGgNGdnxi7r4cukcoTk4/j3zSw9aqjg2KP+7BKr2kjzeWWZbcLB09m8yTYi1ZJauCsI5+I7GOaa9v58pZ4l+AixYOWmeZG+bqCwLt4TgAv63VGd1blsTt0Xu7TDpscDnUgeRE54umqcOT4v8xODGVwpYEg2ZQ/fNj54hAI0eNL66Str+xGGqrjQyQt2E
X-Microsoft-Antispam-PRVS: <MWHPR13MB147076FA067C169C73B7D210C94D0@MWHPR13MB1470.namprd13.prod.outlook.com>
X-Forefront-PRVS: 0970508454
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR13MB1470;23:UIb5tAJMY4VX0VPRwDERQDxZSw8xWqYJ+5rCz86st?=
 =?us-ascii?Q?WDOCcea8FSOrokiGFQ9Y1C1eQGjXE7i6gmyDDrBLM7Pau4U5heL24YPN+Nrw?=
 =?us-ascii?Q?geC5CU7NDNinZFMH0QhfgDkt71yA43pWlJFq5EeHkv+1xJNwhxJNsTyn5BzU?=
 =?us-ascii?Q?ntVUe/mXKGt4nx5wgltu5noprKScvXCJStzvejIEEQwK9LXOuvW9ySYwaxSP?=
 =?us-ascii?Q?EUtXtnvvHWXhHVXb+f7J6VsfOAkrg5MIZ6ZbGyAdRdHrl+Pm3qQ/Tz0umKm5?=
 =?us-ascii?Q?QuWeuEYFOCUJfMj7bDUaHmgeD63mYZtgipsphODwpbrrAVFA1dzxDSLRgjpq?=
 =?us-ascii?Q?beqOhCmE2RH8FQrznBCjBhDyqUzBt7v/tapRLS2Z3djXtSVLn7kj08JT44Hs?=
 =?us-ascii?Q?HUedST1MPAO3nKbMKsbSXK/briwzmEjInQNkizutkQ6fbLH8+iRvGypqsjZ9?=
 =?us-ascii?Q?a/v5THCVSgMGjCSWgHwwHkg2ExaWaU4yU/f6tpNzDWLKPvD69Lq1dLkJ0vCy?=
 =?us-ascii?Q?7E9N3zK8/+5uCz3haRTCElhtFt8kCUqh3ncB62aFzPxp5NGQ1qkQE7QvaBXy?=
 =?us-ascii?Q?JPLRoZVQd9d87cu1Rt6JogbBIWRx81pjWcFUIPCI9ti1ytKRhCV7ztnftieN?=
 =?us-ascii?Q?GwWRY5OXIRomdy0kwL9TbNXQN98jFiV+hmMW1dDt8adPEb3wVEupPcpVX3wn?=
 =?us-ascii?Q?TEcwqLYiFa7Vl+W6JUSSuydtPd3/8L39v5sXMPmcj4JDIwDK0Kwo0TW/wsdM?=
 =?us-ascii?Q?pCrCFPEfPk3xrQDWwwckuWm09GTF9CxpBoMaJ1A95XOVnK3QYqpkWmCb+tf4?=
 =?us-ascii?Q?/ltP2oW9ueF5ExSveu3yHfc09/yA9+y7QGkp5mxPmoBI6ll1pGbmQ5nmUKY+?=
 =?us-ascii?Q?NxIZYBsJLR8eTIYLaVHLI4jzD9KjPTQz6N6qbIbVagyxKGGhAXOo7kBRCbQs?=
 =?us-ascii?Q?2QDpgRSrIJ5mxUbgT7YJglAwDne101Lg7Fp7AcwvNlBVpeRX1BZ5oiI45vTK?=
 =?us-ascii?Q?R3U7MLoNAJzLcZI2qjC3OIhWyv54ndSXvcDfJcLbcohkcNwgRkSCU4vQSgcQ?=
 =?us-ascii?Q?6rUHQrLaeEYPNceQVxN2wZvd46AkALIzL6cnj1mJHIMyuXbbJb0w/dHTzWYY?=
 =?us-ascii?Q?IbT8FQ+qDSHCdpJM8HKKxVG7S0YAU17?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cpU18vkKhks1VqHQ9CB4pg0oPBnCjWsMDRLVOqWLmO9jbcE3dV6NhM/wZZaYgey+Pa/jrLAm/0juRxIwgbUEKi1vbhot1BHwkJ2oIgnWB2W7VxmPJp5CGkIjOTyiYBol5eTrxZpb1Il2oiWXllN0JXVEyK5W2HZmwiajT1HYgLIxY10L0EqjlTV6W/Xs0nvvrebDHEGLnIxh6ih0xG31vuXLt8D6/zTbmi8QNbDkBjL1JiWNXAkaCOsJdKjFeN1mmIY0vSs69kc84nwhyGvWmcTyZqMh6PDzArFb7RxfwRgzYdsGBdmZ1i6YJbf6SEkSk9mAesJ71oNrOYbOnUkfSw3Ybvhfod6rdO6tr/0OHkwl4xV4QNeQ7reocl2tSnny0g7eyBJThHKXlHDp6H6UxUwup7jXKbyS0RqQhdMy3Uk=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2019 09:13:09.9924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f768d706-67d2-494c-2f7d-08d6a3a6490e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.43];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue happens with following steps:
Access usb3.0/3.1 device that uses uas driver.
Power off hub port connecting device by ioctl(USBDEVFS_CONTROL).
Wait longer than 30s(scsi layer timeout period is 30s).
Execute commands like lsusb, no response and usb subsytem hangs.

After scsi layer timeout, uas_eh_bus_reset_handler works and enter
usb_reset_device. During reset, current uas_post_reset returns 1 if
uas_configure_endpoints fails with -ENODEV, then it tries to rebind
uas driver. The unbind request cannot complete because program goes
to host_not_ready in scsi_request_fn. As result, it stops at device
reset process and the lock took before reset will not be released.

The usb_reset_and_verify_device included in usb_reset_device fails
with -ENODEV after power off hub port, and the -ENODEV error will
be reported to uas_eh_bus_reset_handler and upper layer, so it
doesn't need to do rebind if -ENODEV happens.

Signed-off-by: Kento Kobayashi <Kento.A.Kobayashi@sony.com>
---
drivers/usb/storage/uas.c | 3 +++
1 file changed, 3 insertions(+)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 36742e8..24b09fd 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -1116,6 +1116,9 @@ static int uas_post_reset(struct usb_interface *intf)

        scsi_unblock_requests(shost);

+       if (err == -ENODEV)
+               return 0;
+
        return err ? 1 : 0;
 }

-- 
2.7.4
