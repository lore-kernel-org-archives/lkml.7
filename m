Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D6DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FDD2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VALgzOeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDIGen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:34:43 -0400
Received: from mail-eopbgr710073.outbound.protection.outlook.com ([40.107.71.73]:36000
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfDIGem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQhPn69KdUnb7zds+71WEBjrDcaMJquJBnmE4VybI5I=;
 b=VALgzOeP+Wf2WKl9niK7i+rebyrSqMi6jtlXRecHgziMcx5G3qGxJxlGCXFLSGyLR7wMalTcAZ047tzvK0mrWY1vacdPvfNEM0giJ20F3C2aqlISevYBAXOiPaFyNJsSsbv/YT9P8ILupRlFGuK79r6ZavZ41CNrLKf5AgVySJM=
Received: from SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) by CY1PR02MB2012.namprd02.prod.outlook.com
 (2a01:111:e400:c5ab::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.15; Tue, 9 Apr
 2019 06:34:39 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by SN4PR0201CA0011.outlook.office365.com
 (2603:10b6:803:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.14 via Frontend
 Transport; Tue, 9 Apr 2019 06:34:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Tue, 9 Apr 2019 06:34:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hDkL8-00037V-Bb; Mon, 08 Apr 2019 23:34:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hDkL3-0007hL-7u; Mon, 08 Apr 2019 23:34:33 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hDkKy-0007dX-Q9; Mon, 08 Apr 2019 23:34:29 -0700
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
To:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
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
 <d425bd61-238b-f085-f450-d052349878a8@xilinx.com>
 <20190408165109.GA6459@archbook>
 <CANk1AXQ5mHr0ZTuRoby3GomKbbQxv8z-O=o83VV=mXTh1aUZZA@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <19e24c86-a92d-cabe-f20a-64a1a805e172@xilinx.com>
Date:   Tue, 9 Apr 2019 08:34:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANk1AXQ5mHr0ZTuRoby3GomKbbQxv8z-O=o83VV=mXTh1aUZZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(189003)(199004)(126002)(186003)(36756003)(316002)(63266004)(11346002)(76176011)(2616005)(426003)(64126003)(476003)(9786002)(486006)(81156014)(93886005)(8936002)(2486003)(106466001)(58126008)(50466002)(26005)(478600001)(77096007)(8676002)(5660300002)(81166006)(23676004)(44832011)(336012)(53546011)(446003)(65826007)(31686004)(2870700001)(6246003)(229853002)(106002)(4326008)(2906002)(31696002)(65806001)(54906003)(36386004)(47776003)(305945005)(356004)(65956001)(6666004)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB2012;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 431bdb50-b3e8-4446-e274-08d6bcb57109
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:CY1PR02MB2012;
X-MS-TrafficTypeDiagnostic: CY1PR02MB2012:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB201271E31CA712F9251AFE57C62D0@CY1PR02MB2012.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yRsC0BA9mfKXHai4MBlpLHb54w4/b1TxkkOB7UD4U7Eivdy4cMhN2525XRYk0mPXWO4QQkAxU9n2J3h28RBxrGRh/eDIyPtGhGbeNcOWU0EATZWqMkUXMdCvsqR7Vl8l3QIL4weRbps2H90MoW6OpRXQ27Mapj/o96ZTsODKdNUSG8MmFydDgWQUGo9EbhDogfKWvN2Mph86iPirRsA4h+HxMOr7GwjDkKxuQDqneoz3HGjKQvzsLoRydu+ZONF7CkFzYwiAxaD0gC8EfUbtk9by5XD5gEJQYpc5cD4ZAAW0SSM2siIuVyMingee1gb3QyKitN+X8VRp1xKyF1wnoLC3bXdL+RdRDGuC9NyGoLob6p/1kq2a+/zT9m9ojRQd1AkEx4FbaACuU2fVKq7DmlKV8d9+lW74HPKUmGmDOJM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 06:34:38.9368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 431bdb50-b3e8-4446-e274-08d6bcb57109
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB2012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 04. 19 22:27, Alan Tull wrote:
> On Mon, Apr 8, 2019 at 11:51 AM Moritz Fischer <mdf@kernel.org> wrote:
>>
>> Hi Michal,
>>
>> On Mon, Apr 08, 2019 at 04:36:15PM +0200, Michal Simek wrote:
>>> On 08. 04. 19 16:17, Alan Tull wrote:
>>>> On Mon, Apr 8, 2019 at 7:39 AM Nava kishore Manne <navam@xilinx.com> wrote:
>>>>>
>>>>> Hi Alan,
>>>>>
>>>>> Thanks for look into it and providing the ACK.
>>>>> I got one minor comments from Moritz Fischer do you want me fix that issue now or I can fix it later as it’s a minor comment?
>>>>
>>>> Please fix for Moritz comment.
>>>>
>>>>> In which kernel version i can expect this driver changes??
>>>>
>>>> Patch 2/3 and 3/3 are dependent on 1/3 which isn't a drivers/fpga
>>>> thing, it's drivers/firmware.
>>>
>>> I can take it via arm-soc guys if you are ok with that.
>>> Just need to have your ack in commits.
>>> We have done it like this several times, IIRC reset, nvmem.
>>
>> I'm fine with you taking it through arm-soc. Alan?
> 
> Fine with me!

ok.
Nava: Please address all comments from reviewers and let me know when
all are happy and I will take it.

Thanks,
Michal
