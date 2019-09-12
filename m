Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F87C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9436A214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OdemSYJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfILFx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 01:53:29 -0400
Received: from mail-eopbgr800051.outbound.protection.outlook.com ([40.107.80.51]:12512
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbfILFx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 01:53:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gicCmPkQd81BVSmugijzwEjXbjO6y1x8dbaFXgBzlsd4mS0ZcHcklyKpsMQIZ7mBkE7glNqgqSHGYe3Gq6utwsvI+gRCh+/bccJt6vgVxI7rC2/tisqHtrjDYCCARteLZoe21ITcg80vn7HMMEk6GVgZMPd2l/nlSrCxigZsPmfBlACw8Kkr/g7pCL8s0gM0h+pYz2yal/V08rLcP7L10nmiiKPCuZWhrYwkgn9KrrAFAuBl3fo7LHFKrBOse9rOoZitgLjHjmNsSyO5b9hKCIUrSgzROQqwNXjddT8XJNsrVFtmFsVZcutFvb3rTkIsMyR8xh6hV2Hn645vkzEH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JKWX4bDY9FCLKG088aJFuVgYRA4dtXPLSGznhxrwh8=;
 b=MX282KV4NRPKNC5kZ7Tx0tarWDbRgb0ue0evPhX6kJdpvWhZocRCI6iNRmk1kVTTdmFvWs5YCqIZqYAPa0ua38Df/Nt9AHenHPageKXufUTK+jym/4/3YF97V3m7nNmhG7i5rb9wABsmfwycPqjOsYV0ZJGlvO+LLUyVpeCZmvKLGpO8sthKU6DiBvOewjSJ5Hb1jKq2Ee88YeydxfwNm3tXaJiARFxDKV2uAArOlTxaE2vXN9shdNiRo2UCx0HTrYoaVL6Luc2UJXZ1eJVL/42fZdNx0bCwZmkBYIO1f+Z+FPVohbSfQkgZfC4kNE4axuld+nPg2PhgJ+dupIpmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JKWX4bDY9FCLKG088aJFuVgYRA4dtXPLSGznhxrwh8=;
 b=OdemSYJDzzJFJSrtU+HgH2mNU5XrObJuXwtpRg1SV3/dVaiL6CE/XB5I0rpMhThtjHOzU7V+JhTteMhkuSk5xBHQ3Bs2arZtykBbm6orCcQHV/QXLXe5IhUIpMcrMmq5hrF3QtzSn/HXQaI7OjB+TsfznTuOolq3Qq8e/5uxnBw=
Received: from SN4PR0201CA0042.namprd02.prod.outlook.com
 (2603:10b6:803:2e::28) by DM6PR02MB5337.namprd02.prod.outlook.com
 (2603:10b6:5:47::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18; Thu, 12 Sep
 2019 05:53:24 +0000
Received: from SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by SN4PR0201CA0042.outlook.office365.com
 (2603:10b6:803:2e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.17 via Frontend
 Transport; Thu, 12 Sep 2019 05:53:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT044.mail.protection.outlook.com (10.152.72.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Thu, 12 Sep 2019 05:53:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52989 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i8I2l-00030O-DW; Wed, 11 Sep 2019 22:53:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i8I2g-0006lC-6Y; Wed, 11 Sep 2019 22:53:18 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i8I2Y-0006k0-40; Wed, 11 Sep 2019 22:53:10 -0700
Subject: Re: Regression: commit c9712e333809 breaks xilinx_uartps
To:     Paul Thomas <pthomas8589@gmail.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CAD56B7euf1kQpwOYiq-he8HveKKzkGdf8_-izEVfwa=QH24a3g@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <33ec2a52-91aa-6c4a-d900-1725f2970975@xilinx.com>
Date:   Thu, 12 Sep 2019 07:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD56B7euf1kQpwOYiq-he8HveKKzkGdf8_-izEVfwa=QH24a3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(5660300002)(305945005)(23676004)(52146003)(2486003)(31696002)(6246003)(8676002)(316002)(70586007)(70206006)(36386004)(126002)(110136005)(58126008)(229853002)(106002)(76176011)(81166006)(8936002)(356004)(26005)(336012)(47776003)(44832011)(2906002)(478600001)(65806001)(65956001)(81156014)(230700001)(426003)(50466002)(486006)(31686004)(9786002)(476003)(186003)(2616005)(36756003)(446003)(11346002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5337;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29450a12-5d16-4060-c9b1-08d737458634
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR02MB5337;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5337:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5337DDB2497A4221FE42A0EDC6B00@DM6PR02MB5337.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 01583E185C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5WoR+bkXHVAuAKhowX0/XKAvYzL+/C3zcP6UwIL9TWBCZnuovQS4Ks0v43yURbTDPCtmtG7OzxNDDqkk7P8of/FojjhHGrlUpwmjiT4xJ5Ou7Dni+eL4QlhddFYM1P1eqmGi0j+dEWwe1bTqsb2iWpArAbqB5jVEBXxHziXxb0hGRY3rE5x9/eha+pA8elGc1ErcnTKR+DNYHR11PfKiHM9n2dd/+i1NkYRnyS1C7wE8AAU3yajs5KFmoFRli/aje2t4/XDtBmgoNthlBahCt4kvMiO871Kmb/8uY+SVkepyR9mKYMQkJHtQEM+8vY71W7qHhonCmAAzQrEbPjBKnwXzzlXMjQ2QXMkGAsyHiGREkefiixDfTyQkDQmhrBAXwES7Ls/SXv/vfixSHWtmGGt/HjtkrQctqw/mn2dht+Q=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2019 05:53:23.7900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29450a12-5d16-4060-c9b1-08d737458634
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 09. 19 19:04, Paul Thomas wrote:
> Hello,
> 
> As I was working with a recent 5.2 kernel with a Zynq Ultrascale+
> board I found that the serial console wasn't working with a message
> like:
>  xuartps: probe of ff000000.serial failed with error -16
> 
> I did a git bisect and found that this came from:
>  commit: c9712e3338098359a82c3f5d198c92688fa6cd26
>  serial: uartps: Use the same dynamic major number for all ports
> 
> One difference I might have is in the device-tree, I'm using a proper
> clock config (zynqmp-clk-ccf.dtsi) using the firmware clock interface.
> This is absolutely necessary, for instance, with the Ethernet
> negotiation where the macb driver needs to change the clock rate. In
> any case I believe this pushes my case to the -EPROBE_DEFER when
> devm_clk_get() fails the first time, this might not have been tested
> in with the original submission. I'm not sure this makes everything
> completely correct, but the patch below does fix the issue for me.
> 
> thanks,
> Paul
> 
> ---
>  drivers/tty/serial/xilinx_uartps.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c
> b/drivers/tty/serial/xilinx_uartps.c
> index 9dcc4d855ddd..ece7f6caa994 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1565,6 +1565,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
> 
>         cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "pclk");
>         if (PTR_ERR(cdns_uart_data->pclk) == -EPROBE_DEFER) {
> +               /* If we end up defering then set uartps_major back to 0 */
> +               uartps_major = 0;
>                 rc = PTR_ERR(cdns_uart_data->pclk);
>                 goto err_out_unregister_driver;
>         }
> 

I expect that this can be problematic for all failures in probe.
What about this? Just setting up global major number if first instance
pass.
Also cleanup should be likely done in remove function too.


 diff --git a/drivers/tty/serial/xilinx_uartps.c
b/drivers/tty/serial/xilinx_uartps.c
 index f145946f659b..c1550b45d59b 100644
 --- a/drivers/tty/serial/xilinx_uartps.c
 +++ b/drivers/tty/serial/xilinx_uartps.c
 @@ -1550,7 +1550,6 @@ static int cdns_uart_probe(struct platform_device
*pdev)
                 goto err_out_id;
         }

 -       uartps_major = cdns_uart_uart_driver->tty_driver->major;
         cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;

         /*
 @@ -1680,6 +1679,7 @@ static int cdns_uart_probe(struct platform_device
*pdev)
                 console_port = NULL;
  #endif

 +       uartps_major = cdns_uart_uart_driver->tty_driver->major;
         cdns_uart_data->cts_override =
of_property_read_bool(pdev->dev.of_node,

"cts-override");
         return 0;

Thanks,
Michal
