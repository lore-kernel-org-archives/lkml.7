Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EB72186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3vuFZJ+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbfCAKv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:51:29 -0500
Received: from mail-eopbgr810083.outbound.protection.outlook.com ([40.107.81.83]:15180
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728232AbfCAKvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya7823S2T4kopAk6fi1HUDp757tba2wKlqsYFcm4rUs=;
 b=3vuFZJ+QAh5tYwZgERWqk3a53m7POzJ46PkDZfWDw5Eh+SffDa/tAWk/TPzM4ekZbUgxDLs7MwkCd9UIt5SMmMc2bbaDlkxoNZLRDfNhN5eGjPwjDPaBbfg2DIDO4kReRHREQ0oDdjj+IHOteXx2an4Wl2qkdOP3jee6zK6NwO8=
Received: from MWHPR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:301:74::24) by SN6PR02MB4927.namprd02.prod.outlook.com
 (2603:10b6:805:99::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.21; Fri, 1 Mar
 2019 10:50:56 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by MWHPR0201CA0011.outlook.office365.com
 (2603:10b6:301:74::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.18 via Frontend
 Transport; Fri, 1 Mar 2019 10:50:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 1 Mar 2019 10:50:54 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43487 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkk-0003DG-BM; Fri, 01 Mar 2019 02:50:54 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkf-0007u9-7G; Fri, 01 Mar 2019 02:50:49 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x21Aoc5p023136;
        Fri, 1 Mar 2019 02:50:40 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkU-0007d5-AE; Fri, 01 Mar 2019 02:50:38 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH v2 0/4] Macb power management support for ZynqMP
Date:   Fri, 1 Mar 2019 16:20:31 +0530
Message-ID: <1551437435-3462-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(396003)(39850400004)(376002)(346002)(2980300002)(199004)(189003)(2201001)(8936002)(110136005)(81156014)(81166006)(54906003)(48376002)(316002)(8676002)(16586007)(14444005)(4326008)(305945005)(107886003)(50226002)(6666004)(356004)(4744005)(478600001)(50466002)(9786002)(186003)(106002)(5660300002)(36756003)(63266004)(106466001)(51416003)(426003)(2906002)(47776003)(36386004)(2616005)(476003)(26005)(77096007)(336012)(7696005)(486006)(44832011)(126002)(107986001)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4927;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d577d1-4173-418b-3b90-08d69e33c7c0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR02MB4927;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4927:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4927;20:u9Wk4Z1pM1sYCbsScdqQXqhuOZeeDO1GGYpgBd1cX6CYEWDz4ZTM5A6Z4zzs5Y3ClGcRD/taMkGQZeZR0fQsAfTju585YAMkGaoIKZZ+nOTjV9tSm/iFp2WfNzCHwowg8Ga+hgqKZmA246vK0I7F0rC+7H3S+fvQJWGR6I08mvEHlEJA3rDDdb42XeUanWdl4fk9cPk76yIZdSBT7Z8cuPQfkQ5LKk2BSABnP258pzYFNREMeaJKF1jS1g+vReefz1UgSu8Tvv1bQzXqnFsUTW126DbpiJ9y0NkhMamcGpEXPFRsFNIIRiJh3RKLwv6xFlpLCPg7k6d1mc4fdEH5L+7wfYFrXR4DDhTiIkfrYuUYEdPsnpZeuBbQEmUig+aeZAJybJ63VvP+oFDthHF9VyONkGYEFqOWsXbE0qNTo8YyifZs4YBF0XIR/N7cDID4fa6Hv6O9s4HZVAXMQrsynreddUn6PvWxgJE6/NChwwXXBXAuRwAKJ4DnH42xHw+A
X-Microsoft-Antispam-PRVS: <SN6PR02MB4927143B4E702513A981ED2CC9760@SN6PR02MB4927.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09634B1196
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4927;23:GIr6DogbnC4JEMTcYpjrAe5ME/9UOounrABE2UKVF?=
 =?us-ascii?Q?ExTecuk/tE45rEi0n5xmuojwe9efRsDUH7+jOgwaFGWJ/3equ+hY+XOiUC2P?=
 =?us-ascii?Q?2SG9oNkwhEo6jgbd+l6w82RZo4C9J5XRRTXJZTza961ipE5YuEOD+5CVlBRW?=
 =?us-ascii?Q?3nlAOa2pM6nO4sYOK4nKI8RU0zOqKwHC2tL2btvFXNBXW9phbeAOB4W1AsVD?=
 =?us-ascii?Q?wXu/0894mIZq7wFexzmw5YPLqPcN2lJzUzR/EGxQdBuw6SshecyVYJuHXRym?=
 =?us-ascii?Q?j6aQvSRF81Kb3r8A5vGYErUF1EhrkWeirMUJJxaBt4SEo8icQXnsqKH6Yhgw?=
 =?us-ascii?Q?cLno7/FL0kf2kEeI/pgOEcnloPCaMBOrJNtt1QCBykpBrSiTgZ1id9YQzCct?=
 =?us-ascii?Q?h7cvOMipk1eF+Dgjy7Z7pzmZ4a2J5J8Uy4zUNeO9XMxH8xKNuKO4l/dFjhXF?=
 =?us-ascii?Q?5uXIJym8LA/0h3Sr0qHl9kWpuCfxgmY1RglVnJjezZtR1wO3kV0UeYK/VKKk?=
 =?us-ascii?Q?ZN9CCYsfJs66wkGUQh9rPwVKLWkxik+P/57bC8xVhnN+B7O49yXPN1PcVDC7?=
 =?us-ascii?Q?wVbvrRFqSOyNa5J/AamhBxRaU81ORhZdDs3MpQihZS2+qSvH30dlJ2xqfEF5?=
 =?us-ascii?Q?6d0PwN5jptP0g9llwTfrQ8q9PoxAZZiIFvgLv0aJzVWNHZkIiO6C1D9vTt+1?=
 =?us-ascii?Q?rBUjd3rScXDRE4MMa9wVqlhHyes5wQMT8jmLr278HORBSz3fgdCl5gKf1Lu4?=
 =?us-ascii?Q?GsaJrE0tYDdjn/6HZvJv//Y/WmG3TvxRy9kv/Va+KKF0zX3Y0DE+9Dd5DefT?=
 =?us-ascii?Q?ZLAImljiwYeddgkHihUbL21HHeP5SwDcpWgtHoz13Y+Cgnl4i7SHHh3vM4ZX?=
 =?us-ascii?Q?BI0vJlmvr1OUlND2mdnXRSM06xyCL4YVZ22e0zKZAPzfIqTIYUCCDzHoF2TT?=
 =?us-ascii?Q?ih10W1tKgS+SIg1QDWrkeTUgVeH1FL3WGAyKwUK2zrM+Jl2x64CgMgb+npKY?=
 =?us-ascii?Q?IJRiKG90DqJJ4WM5fmukeLTWORfe7f/abtNrTzeuAY/DcCUWi9PUI9aOxKvn?=
 =?us-ascii?Q?RFySxfmyecMGwgm/JgKcpvH3u8FHrXizMDwk5G/O4+kPW7vWXCzP/yyhBh49?=
 =?us-ascii?Q?L+qy0ljRI42SpxpNcgtku0sZEfk+tEr0+T+kTZMwEBPfRQse5PSd44BzSkkI?=
 =?us-ascii?Q?MS60yTSwzy/K9XcqotTvuazKP7WX9zUkQApTFLb6SzxoIgnttL2dfs1OtysR?=
 =?us-ascii?Q?+CZ33Hvz5Wn1wvuwxE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TjkjmfC3sC6TGgpGGHoveDTwaXMyJ6Lz0KVPM0fEYcH2dxeCTyaCaCpCYVHmh2/yflVIguofokFopY7gaBSKrgFE4rLmHcmEFja4rvO0zDC9pDorgKkeAsynE1/rPrvz7QUI4UUC6CKMpA2tWutCJjWDvvePwuuyY4qwVA4tr8/1tIeBjC032i7eGCBf37D2X4DQ+Q7wDkYg7az7+iU+kZJa2/WaoMPUsfWiFUjksRULME65Htk5XHfwvf+jbaCyP8oMzfrysyuc3HggeLSUijscMrcqDrAMt5IEOcZtWce1aHhcUy6TntxOoVHoS69qtfKLAQS+aB2cGgoGR9zacuW+WuIu6wHAmIoQRFzMKMkh3iGp4dyjn0DTBWUOew0Q66DEHNneZHdE1uvykpjyrl12s5oEGxZxy6KWLj2seZU=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2019 10:50:54.9547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d577d1-4173-418b-3b90-08d69e33c7c0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4927
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for macb suspend/resume with system power down.
In relation to the above, this series also updates mdio_read/write
function for PM and adds tsu clock management.

Harini Katakam (4):
  net: macb: Check MDIO state before read/write and use timeouts
  net: macb: Support clock management for tsu_clk
  net: macb: Add pm runtime support
  net: macb: Add support for suspend/resume with full power down

 drivers/net/ethernet/cadence/macb.h      |   5 +-
 drivers/net/ethernet/cadence/macb_main.c | 215 ++++++++++++++++++++++++++-----
 2 files changed, 188 insertions(+), 32 deletions(-)

-- 
2.7.4

