Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7441C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE35B2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VFJqqWo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfCSMSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:18:09 -0400
Received: from mail-eopbgr790080.outbound.protection.outlook.com ([40.107.79.80]:58944
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726743AbfCSMSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRP77eQxjaqRWmlZ1LHy00gMoU+DT2aJ/qXmySgDmyg=;
 b=VFJqqWo43YYaKLv2oNwv/nOJamJF/1bvr5bXhu5i4fagrQLJnXYu5D/aN278Fat03Ss7AVuEOxao0DRSLWzACl7H/nlnRNJBBbF7hsiISx958AJuWGwHkCT84cUIihZeABS6Cgao37a1uXCC1JmRs3dp7BBWOVveN7mILiOsLRg=
Received: from MWHPR0201CA0059.namprd02.prod.outlook.com
 (2603:10b6:301:73::36) by BYAPR02MB5542.namprd02.prod.outlook.com
 (2603:10b6:a03:9b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 12:18:05 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by MWHPR0201CA0059.outlook.office365.com
 (2603:10b6:301:73::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 12:18:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 12:18:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:41647 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h6Dgy-0005Me-Qt; Tue, 19 Mar 2019 05:18:04 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h6Dgt-0000QT-MI; Tue, 19 Mar 2019 05:17:59 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2JCHq2u031431;
        Tue, 19 Mar 2019 05:17:52 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h6Dgl-0000PZ-QX; Tue, 19 Mar 2019 05:17:52 -0700
Subject: Re: [PATCH 00/12] misc: xilinx sd-fec driver
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5f1d4915-27ad-0cdc-a174-98f88f36a762@xilinx.com>
Date:   Tue, 19 Mar 2019 13:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(2980300002)(199004)(189003)(107886003)(6246003)(23676004)(50466002)(966005)(6346003)(36386004)(5660300002)(229853002)(478600001)(446003)(486006)(44832011)(426003)(126002)(336012)(186003)(2616005)(476003)(230700001)(11346002)(2486003)(76176011)(106002)(26005)(77096007)(4326008)(81166006)(356004)(64126003)(31686004)(36756003)(8676002)(8936002)(6666004)(305945005)(63266004)(2906002)(31696002)(65806001)(65956001)(6306002)(110136005)(81156014)(47776003)(2201001)(58126008)(54906003)(14444005)(65826007)(9786002)(316002)(106466001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5542;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c66b4216-c8ef-4db3-0996-08d6ac64f0c6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR02MB5542;
X-MS-TrafficTypeDiagnostic: BYAPR02MB5542:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB554245409E32659287DB000BC6400@BYAPR02MB5542.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZHJasGkVC925xV3Y81yfuSAYow+eBGT6J3oz+BoKJLf9Uqte2IqYtjwwhA1LduHQWr1pUfPFtA3dC4Vb2MCUQAA0wDZpW5UrxXhNOK40FMeGfBIoJrNFPu6XYJJAbEYVmcpRbfd3h9soJ63yYcmIcrqD+HBau7amSQ4/5FcGdbRYB9qPCHesFY3IZ+MHVKJOKZyTC+sBiNDTDQDBJK9k8Ps1R85j/mZWKL+f7GtezmwJBcm7t+GvJD2mlF3fCafXY1Ps0M0+Ttkbqv9ZA+R5w3qldbFQ9QwHfxWqezowTpM98bYcs2H8e2WcSiHYmBUiHy/YukgVRnc8m0YX/9J49nHL+0NFev4nQQZc22Yot1Lm2nMN31q428oZoF1xwShrNt1CCoNduHxUr6IXbM2hXP3ot63MtSiPYDFbG4fzEag=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:18:05.2748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66b4216-c8ef-4db3-0996-08d6ac64f0c6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5542
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 03. 19 13:04, Dragan Cvetic wrote:
> This patchset is adding the full Soft Decision Forward Error
> Correction (SD-FEC) driver implementation, driver DT binding and
> driver documentation.
> 
> Forward Error Correction (FEC) codes such as Low Density Parity
> Check (LDPC) and turbo codes provide a means to control errors in
> data transmissions over unreliable or noisy communication
> channels. The SD-FEC Integrated Block is an optimized block for
> soft-decision decoding of these codes. Fixed turbo codes are
> supported directly, whereas custom and standardized LDPC codes
> are supported through the ability to specify the parity check
> matrix through an AXI4-Lite bus or using the optional programmable
> (PL)-based support logic. For the further information see
> https://www.xilinx.com/support/documentation/ip_documentation/
> sd_fec/v1_1/pg256-sdfec-integrated-block.pdf
> 
> This driver is a platform device driver which supports SDFEC16
> (16nm) IP. SD-FEC driver supports LDPC decoding and encoding and
> Turbo code decoding. LDPC codes can be specified on
> a codeword-by-codeword basis, also a custom LDPC code can be used.
> 
> The SD-FEC driver exposes a char device interface and supports
> file operations: open(), close(), poll() and ioctl(). The driver
> allows only one usage of the device, open() limits the number of
> driver instances. The driver also utilize Common Clock Framework
> (CCF).
> 
> The control and monitoring is supported over ioctl system call.
> The features supported by ioctl():
> - enable or disable data pipes to/from device
> - configure the FEC algorithm parameters
> - set the order of data
> - provide a control of a SDFEC bypass option
> - activates/deactivates SD-FEC
> - collect and provide statistical data
> - enable/disable interrupt mode
> 
> Poll can be utilized to detect errors on IRQ trigger rather than
> using looping status and stats ioctl's.
> 
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>

I am not using this tag a lot that's why I am curious where you got it
from? I can't see it in Xilinx tree too.

Thanks,
Michal
