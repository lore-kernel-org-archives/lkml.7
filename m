Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7912BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C5720818
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Q+7dFksf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDHOgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:36:41 -0400
Received: from mail-eopbgr730081.outbound.protection.outlook.com ([40.107.73.81]:64688
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbfDHOgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOeQK7Y7TTOPaGVrtyMWVGg/mDyyvUNP1UOMIdN01yU=;
 b=Q+7dFksf2FUaKwxeNN9H7e+WQwZzkQglQaceHfZDlMPXou8egrUiUwz3YxUFgm67P5Zf0zYSRWpgCZR3K9sq+6KDY2QRbqZJ4We+Z76ez9SArGGAxDU1z3bCiykNuVcePXNqoPDwqDrQHWi44MFs6C8ngePQJWdWoWMzJ/JkHhM=
Received: from CY4PR02CA0026.namprd02.prod.outlook.com (2603:10b6:903:117::12)
 by SN1PR02MB2015.namprd02.prod.outlook.com (2a01:111:e400:7be7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.16; Mon, 8 Apr
 2019 14:36:35 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by CY4PR02CA0026.outlook.office365.com
 (2603:10b6:903:117::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16 via Frontend
 Transport; Mon, 8 Apr 2019 14:36:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 8 Apr 2019 14:36:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hDVNy-0006Nm-U9; Mon, 08 Apr 2019 07:36:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hDVNt-0006En-QF; Mon, 08 Apr 2019 07:36:29 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x38EaJ18021891;
        Mon, 8 Apr 2019 07:36:19 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hDVNi-0006D0-Oz; Mon, 08 Apr 2019 07:36:18 -0700
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
To:     Alan Tull <atull@kernel.org>, Nava kishore Manne <navam@xilinx.com>
CC:     Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-4-nava.manne@xilinx.com>
 <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
 <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d425bd61-238b-f085-f450-d052349878a8@xilinx.com>
Date:   Mon, 8 Apr 2019 16:36:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(199004)(189003)(2616005)(229853002)(6246003)(11346002)(305945005)(110136005)(54906003)(6636002)(126002)(47776003)(50466002)(31696002)(64126003)(446003)(356004)(426003)(6666004)(106002)(476003)(65826007)(336012)(36756003)(36386004)(186003)(81156014)(2870700001)(478600001)(76176011)(4326008)(9786002)(8676002)(81166006)(8936002)(2906002)(77096007)(93886005)(26005)(65956001)(486006)(65806001)(58126008)(316002)(4744005)(5660300002)(23676004)(31686004)(2486003)(106466001)(53546011)(63266004)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB2015;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 009283da-d1a3-4e3c-f53c-08d6bc2f9a3b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:SN1PR02MB2015;
X-MS-TrafficTypeDiagnostic: SN1PR02MB2015:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB20153CCA4CECE95BC616773FC62C0@SN1PR02MB2015.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0001227049
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TN0yURDSr2wc5/AXHD4O5SFWJWdhj9/hzdWe6x3ec0YkiowMY+Gl+onywCWN6aYqN46Jp7ZCHMNFDTi80QZWWqWwCEASxoBfP3a9o1/pJRqvpHzAuItxLREZPEQaspyfnWJCxCFnt8QvO6vwU4ACwWgF7rQ21Rud/vSMJA/d3+g0TmW/UORnNO6q5TqRtABhvbEvCNoWPSJlcn+naa5cS9ouAM5IOAEEGi5E3/xMwo4B8+YZyXszlfszQXdE2u7RRSbkM4lWiuWWlrASVE5K8tB0TLNnf9+Y3JkT2VG08V27abbtzkDp0C0riXzyT77z9R4ubOqDM1K/Va5hU7KFG8nJX8lAOYtmkeS/c/P+x1Fxky8uItUHGO7QrgozArc6dkyjtdnBbSMmROT2grcObDKV7DrKKAEN+yRPilN0oMI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2019 14:36:35.3356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 009283da-d1a3-4e3c-f53c-08d6bc2f9a3b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB2015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 04. 19 16:17, Alan Tull wrote:
> On Mon, Apr 8, 2019 at 7:39 AM Nava kishore Manne <navam@xilinx.com> wrote:
>>
>> Hi Alan,
>>
>> Thanks for look into it and providing the ACK.
>> I got one minor comments from Moritz Fischer do you want me fix that issue now or I can fix it later as it’s a minor comment?
> 
> Please fix for Moritz comment.
> 
>> In which kernel version i can expect this driver changes??
> 
> Patch 2/3 and 3/3 are dependent on 1/3 which isn't a drivers/fpga
> thing, it's drivers/firmware.

I can take it via arm-soc guys if you are ok with that.
Just need to have your ack in commits.
We have done it like this several times, IIRC reset, nvmem.

Thanks,
Michal
