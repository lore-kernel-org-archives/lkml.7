Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E50C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0DE20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DTrVz9xs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbfGaLcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:32:36 -0400
Received: from mail-eopbgr800082.outbound.protection.outlook.com ([40.107.80.82]:14603
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbfGaLce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:32:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bar+DGU/gD/A93vyhjGM4SBrIeSn9fZVqBlSjtfpkJHJyOhLTQ1SGhm8V/Z21WdEcfsCn8rMSZ9GrTNoVy5JZFi0bzKoJh7pgK6PuGQNpna/8moTbp1TE6z73Qw30OeRezM5m5W5R/88vi5IP9qwYGEVc/9ZqdurB1+dJDqLP3pwfbm3kU96Fwn3ppmKA3u/bF/rl5M3k4RpGSvL+BGzH/qVoWsJhRrjNYcgDGAnP7itJ46GG9JahYwj9/uA5SmGITrzWb3EH+MreVidQTrmeZ40Yob42Qtq83Tu1pwL4fU6WRyIjzQ4kkiVPOjhCOLDiSRakqRGXjSW6/4SREm8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h2JeoHZrcREEgxP2g8r8bXM/6ExQOZh0xBcMCk3xig=;
 b=jbPCVRXCAByRirO74RHF3yPtoCdiRjdkdTjfVA0uBwkN1yBSTHDBoo8KdW0FiRoBzDFUAJ+nB+aBmUg6WkUH+mknXPwhnj3xXNbpDgscGumFDEo3IXki+x9iJFiHUTCTFFA9vSBOc3zE5BiNcovyp7hkUfqQkrgAVCGHqUl8tVaT4hmJCxovl2APw2LnhGLktntLOCMIPwg7OtQx+3H4a943bfQCviA1oI/YqPLEbacb5AHIn5WlzYKz1Lmvm2rUNlYVC3Nof24/xi+VpeClxJjBGxREOXAxnBIJhEecqq4c43vXLzlFneSnfQrdUeC5k5L27yIKQtGzboA+jw0bHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=xilinx.com;dmarc=bestguesspass action=none
 header.from=xilinx.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h2JeoHZrcREEgxP2g8r8bXM/6ExQOZh0xBcMCk3xig=;
 b=DTrVz9xs/8NnksvyE0T+2StxX53w2k0F5aPXIzXjc6Vm+XF0Zht1+k0lL3j6QWJtgPqJISRcqynJGHtIazTKscBjfBixNmq+yF+wBH8DXtJ5PerqwYja1P5TyOTgJ9BDQfTq0zQUxAukvVwn3TRleJzmqKrxIpG8UUQK8VBjyTo=
Received: from CY4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:903:18::12)
 by BY5PR02MB6737.namprd02.prod.outlook.com (2603:10b6:a03:209::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.12; Wed, 31 Jul
 2019 11:32:30 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by CY4PR02CA0002.outlook.office365.com
 (2603:10b6:903:18::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.15 via Frontend
 Transport; Wed, 31 Jul 2019 11:32:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Wed, 31 Jul 2019 11:32:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hsmqK-000885-FT; Wed, 31 Jul 2019 04:32:28 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hsmqF-0000zx-Dn; Wed, 31 Jul 2019 04:32:23 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hsmq9-0000z5-C2; Wed, 31 Jul 2019 04:32:17 -0700
Subject: Re: mmc: sdhci-of-arasan small issue with clock with 5.2 kernel
To:     Paul Thomas <pthomas8589@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Manish Narani <mnarani@xilinx.com>
References: <CAD56B7cF3QXQbMmZVehtBEm2Bhfda4GpsHFZyDJE8D82xkgyEA@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <505526dc-5b3c-eb7d-a619-195d0b6dce81@xilinx.com>
Date:   Wed, 31 Jul 2019 13:32:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD56B7cF3QXQbMmZVehtBEm2Bhfda4GpsHFZyDJE8D82xkgyEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(2980300002)(189003)(199004)(9786002)(8676002)(44832011)(106002)(65956001)(36756003)(230700001)(47776003)(6306002)(58126008)(316002)(65806001)(8936002)(70586007)(81156014)(110136005)(70206006)(229853002)(5660300002)(81166006)(50466002)(76176011)(64126003)(966005)(126002)(6636002)(31686004)(336012)(305945005)(2486003)(52146003)(23676004)(31696002)(186003)(426003)(36386004)(2906002)(476003)(11346002)(65826007)(14444005)(486006)(446003)(2616005)(26005)(478600001)(6246003)(63266004)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6737;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b305cc29-bc07-4d01-af95-08d715aac557
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BY5PR02MB6737;
X-MS-TrafficTypeDiagnostic: BY5PR02MB6737:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <BY5PR02MB6737060DD0E43F12B9C727BDC6DF0@BY5PR02MB6737.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 011579F31F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: zbwoBjW9bzNzMF70CImbYRfQs9Eq7USzcT0cq2WaYWl4MxxBsGTaoiGI5ucwu5xnNP5Y1wLwjPUYLxtg1OQ/CMmUBDF9maeVAKMPsS2nbyx/VnVoT7m8cSdE+a7e4wnKxzdoQvSpBeTCc2Mm/Md5rb80DEPQQf7apxxfnoQ4vZW3yZObU0WvCEaAcYRKGKZQbUzOQ2w+J8jPQoVaU2+lv46pTHAoCsv6Dd8qGavTs/3VzE9wJii/JN0ePiGg7HuuPwHILZhB84fM39QNV/1GkT8CDeIGzfWToqeqjhj9Nl2wk3MUn5zB6Co/zagNans6Q2d4lrRnVvSA9L5No8/meEZbdK0gFh8ZFBxkbTmBahrSl3KMUUdn4GL98LcQ7+U79Q140/mgucljP+2H2UzuAJ/Oa9zdbwRzdfInRVIZqx8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2019 11:32:29.2321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b305cc29-bc07-4d01-af95-08d715aac557
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Manish,

On 26. 07. 19 20:23, Paul Thomas wrote:
> Hello,
> 
> I'm using the arm64 Zynq Ultrascale+ parts, and I'm running into what
> I think is a small issue in sdhci-of-arasan with the handling of the
> 'clk_xin' which becomes pltfm_host->clk.
> 
> If I just use the mainline zynqmp-clk.dtsi file then 'clk_xin' get's
> blindly defined as a "fixed-clock" at 200 Mhz and everything seems to
> work fine.
> 
> However, in this design the clock is actually 50 Mhz [1]. For other
> reasons [2] I switched the device-tree clock definitions to actually
> use the zynqmp firmware interface for getting the clocks [3] when I do
> this the clock is then correctly detected as 50 MHz:
> # cat /sys/kernel/debug/clk/clk_summary
> ...
> sdio0_ref       1        1        1    50000000          0     0  50000
> ...
> 
> And this is the frequency that is given to the controller (I put
> printk's in to verify that 200 and 50 were the respective values for
> mhz):
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/mmc/host/sdhci-of-arasan.c?h=v5.2.3#n594
> 
> At this point the functionality becomes partially broken. Detecting
> the chip and some reads seem to work, but then when I go to fdisk
> write there are errors such as:
> [   56.481985] 002: print_req_error: I/O error, dev mmcblk0, sector 0 flags 1
> [   56.481999] 002: Buffer I/O error on dev mmcblk0, logical block 0,
> lost async page write
> 
> It seems to me that giving the real 'clk_xin' frequency to the
> controller should not break anything? For now I'm fine with just using
> the incorrect 200 MHz fixed-clock, but I thought someone might be
> interested in this.
> 
> This controller is connected to an eMMC part.
> 
> I did try reducing spi-max-frequency from 10M down to 1M, but that
> does not seem to make a difference.
> 
> thanks,
> Paul
> 
> [1] As defined in Vivado in the MPSoC block in Output Clocks -> Low
> Power Domain Clocks -> Peripherals/IO Clocks -> SDIO0
> [2] To enable the macb driver to properly set the frequency of the GEM
> clock so that 100 Mb/s works
> [3] The device-tree like this:
> https://github.com/Xilinx/linux-xlnx/blob/master/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> and adding "xlnx,zynqmp-clk" clock-controller
> 

It should be related to tap delay setup which Manish sent to mainline
for review some time ago.
Please take a look at https://lkml.org/lkml/2019/7/1/25
and talk to Manish to resolve this.

Thanks,
Michal


