Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245D1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7082085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="2MAyDqbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCSNvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:51:36 -0400
Received: from mail-eopbgr800044.outbound.protection.outlook.com ([40.107.80.44]:43520
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfCSNvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9YhCxJPk3Cvzc2zS/YCY6dTWZ6nSCEAvKj9f7RUb8I=;
 b=2MAyDqbSB9Z+ic3Lw7K+rHJgIUQTabuyRyS/BmWJy5C6cp8RCMpDhABHqRQBmtta71JZT/IHbaoQkVFAkohlNQrNd5VODGdlt9p+lkR2GryeEK+4D7czh0abxG7EA5Jf7ZZMkRlmG27sPM9U/nhFHGTZBHc3VQFN8AOEkyy/GjI=
Received: from DM6PR02CA0101.namprd02.prod.outlook.com (2603:10b6:5:1f4::42)
 by DM6PR02MB5916.namprd02.prod.outlook.com (2603:10b6:5:152::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Tue, 19 Mar
 2019 13:51:33 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by DM6PR02CA0101.outlook.office365.com
 (2603:10b6:5:1f4::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.14 via Frontend
 Transport; Tue, 19 Mar 2019 13:51:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 13:51:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:39102 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h6F9Q-0005wa-77; Tue, 19 Mar 2019 06:51:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h6F9L-0005dQ-32; Tue, 19 Mar 2019 06:51:27 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2JDpQXI020604;
        Tue, 19 Mar 2019 06:51:26 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h6F9J-0005cu-PK; Tue, 19 Mar 2019 06:51:25 -0700
Subject: Re: [PATCH 00/12] misc: xilinx sd-fec driver
To:     Dragan Cvetic <draganc@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
 <5f1d4915-27ad-0cdc-a174-98f88f36a762@xilinx.com>
 <BL0PR02MB56812FE00104090D02A1B1B5CB400@BL0PR02MB5681.namprd02.prod.outlook.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <fadca342-1ef6-97e7-1399-929dbf5b69f2@xilinx.com>
Date:   Tue, 19 Mar 2019 14:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <BL0PR02MB56812FE00104090D02A1B1B5CB400@BL0PR02MB5681.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(13464003)(189003)(199004)(316002)(53546011)(63266004)(31686004)(126002)(8676002)(476003)(81156014)(81166006)(2486003)(486006)(11346002)(966005)(106466001)(77096007)(65806001)(8936002)(76176011)(446003)(44832011)(2616005)(2906002)(23676004)(54906003)(110136005)(106002)(107886003)(6246003)(9786002)(50466002)(5660300002)(58126008)(336012)(305945005)(26005)(2201001)(230700001)(31696002)(229853002)(6306002)(426003)(64126003)(4326008)(478600001)(36386004)(2501003)(65956001)(47776003)(186003)(356004)(45080400002)(65826007)(14444005)(36756003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5916;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8056e6dd-8d98-49cf-20c2-08d6ac71ff14
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR02MB5916;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5916:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB591653A9EE9F44F4C466F449C6400@DM6PR02MB5916.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RabevBy5hIR1goMILYplMuUI2AmYXBvX6kElXgRclbx2wB0gmbgv/EsPlsHvtcodjXpif1aiVW3DAVYpfS7HjQ4An+pwJ/zqpeMd/269xF1Mq2G/iP5TLxM6fnTVh9gn2SBmBedAYjCmgOyuXLIOx0wep15DJcDc0RFQqs/t1QF1As/dHEhlc/knXXiaZl3D1/Izyp0LVEcs5oUOiB5hlfTm5Mr5N7SI9p8n24a8V7VrAym+H4v0xOkmplcJJko5s85LsHqOIbH5s3S/sUIjIIQYrhY+G8wEl6Tt+aEgYB+0HWcoDcBquVrXzKmdLUAJGdVtl/HhMCCBoHacO8yEpLccH1hmw0U2wFKfLVlomPtSi73pf4tgaZCzPjZX8HZdoQ5FRviqT+pFXwW/b6o+C/xsT/bhhxHb3fpQ9OGHKck=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 13:51:32.7852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8056e6dd-8d98-49cf-20c2-08d6ac71ff14
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 03. 19 14:44, Dragan Cvetic wrote:
> 
> 
>> -----Original Message-----
>> From: Michal Simek [mailto:michal.simek@xilinx.com]
>> Sent: Tuesday 19 March 2019 12:18
>> To: Dragan Cvetic <draganc@xilinx.com>; arnd@arndb.de; gregkh@linuxfoundation.org; Michal Simek <michals@xilinx.com>; linux-
>> arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
>> Subject: Re: [PATCH 00/12] misc: xilinx sd-fec driver
>>
>> On 19. 03. 19 13:04, Dragan Cvetic wrote:
>>> This patchset is adding the full Soft Decision Forward Error
>>> Correction (SD-FEC) driver implementation, driver DT binding and
>>> driver documentation.
>>>
>>> Forward Error Correction (FEC) codes such as Low Density Parity
>>> Check (LDPC) and turbo codes provide a means to control errors in
>>> data transmissions over unreliable or noisy communication
>>> channels. The SD-FEC Integrated Block is an optimized block for
>>> soft-decision decoding of these codes. Fixed turbo codes are
>>> supported directly, whereas custom and standardized LDPC codes
>>> are supported through the ability to specify the parity check
>>> matrix through an AXI4-Lite bus or using the optional programmable
>>> (PL)-based support logic. For the further information see
>>> https://www.xilinx.com/support/documentation/ip_documentation/
>>> sd_fec/v1_1/pg256-sdfec-integrated-block.pdf
>>>
>>> This driver is a platform device driver which supports SDFEC16
>>> (16nm) IP. SD-FEC driver supports LDPC decoding and encoding and
>>> Turbo code decoding. LDPC codes can be specified on
>>> a codeword-by-codeword basis, also a custom LDPC code can be used.
>>>
>>> The SD-FEC driver exposes a char device interface and supports
>>> file operations: open(), close(), poll() and ioctl(). The driver
>>> allows only one usage of the device, open() limits the number of
>>> driver instances. The driver also utilize Common Clock Framework
>>> (CCF).
>>>
>>> The control and monitoring is supported over ioctl system call.
>>> The features supported by ioctl():
>>> - enable or disable data pipes to/from device
>>> - configure the FEC algorithm parameters
>>> - set the order of data
>>> - provide a control of a SDFEC bypass option
>>> - activates/deactivates SD-FEC
>>> - collect and provide statistical data
>>> - enable/disable interrupt mode
>>>
>>> Poll can be utilized to detect errors on IRQ trigger rather than
>>> using looping status and stats ioctl's.
>>>
>>> Reviewed-by: Michal Simek <michal.simek@xilinx.com>
>>
>> I am not using this tag a lot that's why I am curious where you got it
>> from? I can't see it in Xilinx tree too.
>>
>> Thanks,
>> Michal
> 
> It is copied from the email address in Outlook. I'll correct this to michals@xilinx.com.

It is not about email address. It is about meaning of that line.
I have never done deep review of this driver that you can put here my
tag that I have reviewed that.
It means you should remove all these lines from all patches were you put
it because I have never gave you this tag.

Thanks,
Michal
