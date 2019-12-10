Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1063C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A69620726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nTJF7tn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLJLyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:54:08 -0500
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:37834
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726957AbfLJLyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:54:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZxKa5PAzUCGxlC0pryyf8MimNaXpcPf3lqLVg7AgWXVnQMNpPqFw8hVY28AHuYI+M/BOQRI0xXAjYaOVGjTdnubDBGIOdE/G5Vta/3skfVq3gf0rybi9V2TL4pAYfAIRc1JkaTdcpzRHe+yrJIZvyrCc+ScdLYQNnPNUoJuuW30BULQf6MGh+4hlThxUo68KPftP4mJT28skUzaY3JOmaeAx6hNxfXJtDKGYIPzvNeKtQWcAKfIDuQfy7XKk3lIx7vou0L2K8D/77FXY49ckBtvitbMCxRL1x+arWn8l7qw9wfEijN4CS2/MI67vl1sRi5KsXnMPEkycmR//FKczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzBTL6fabqvegSF/Ooo7Qg5j/2xOnygEpuKdiCjuwLo=;
 b=ghdIShCaiWVdLf4rKNoQg0vZzLEO8/URLRSOtUpY2FKaHNzfEzBUn3XcQDcM1l8IIWKj8OdwR1MqiC0w0CjLaVpBlP2rEpAIq/p4+jPWpdSj2/H8cBTZq4gfB0ujB/9L4kMFujGh3jIix4gG3hHYtjIfXN+ybV1cmZIe2uPv6sYmQ5TaJr/KSbkmBvolXxf2/ebAHJRBlp83HhwChrNmxrseBiDAi/SFnKPIfPyX2hWEscclNmEgDFsSRo2LWov0mD6/eyN9h/2rlBBP/oz3z59UIraBOZJGXLBLv1ty3VZSuCQqh7hyVQej0qeNfMabCyKaTksc7jY/+FLgKDd0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzBTL6fabqvegSF/Ooo7Qg5j/2xOnygEpuKdiCjuwLo=;
 b=nTJF7tn5J0jBwPEG6H8Vw5Em339GHwxw3WWIQO5pQCPEdSFz99gOwTZMXaUHzuLVIpfucTE4voVBI+9grmMLNhT2AymLTOWEjSuZHh1Wfn2nd+p/rbqiK2t7n65iDjZygGeoct4mxIcjjOUPzz6T9Gz3yIH6Q3/oouT6YwMh1tg=
Received: from BN7PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:20::32)
 by DM6PR02MB5547.namprd02.prod.outlook.com (2603:10b6:5:34::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Tue, 10 Dec
 2019 11:54:04 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BN7PR02CA0019.outlook.office365.com
 (2603:10b6:408:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Tue, 10 Dec 2019 11:54:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Tue, 10 Dec 2019 11:54:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iee5b-0005O0-Gl; Tue, 10 Dec 2019 03:54:03 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iee5W-0007OP-DB; Tue, 10 Dec 2019 03:53:58 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xBABrr2N026952;
        Tue, 10 Dec 2019 03:53:53 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iee5Q-0007N5-Va; Tue, 10 Dec 2019 03:53:53 -0800
Subject: Re: [PATCH v2 2/2] devicetree: bindings: Add the binding doc for
 xilinx APM
To:     shubhrajyoti.datta@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <1575901405-3084-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <1575901405-3084-2-git-send-email-shubhrajyoti.datta@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2cbd5530-b050-6c07-de47-984dda9b9dd2@xilinx.com>
Date:   Tue, 10 Dec 2019 12:53:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575901405-3084-2-git-send-email-shubhrajyoti.datta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(5660300002)(2616005)(356004)(9786002)(426003)(8936002)(107886003)(4326008)(70206006)(8676002)(81156014)(81166006)(478600001)(316002)(31686004)(70586007)(336012)(2906002)(186003)(36756003)(26005)(44832011)(31696002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5547;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 559b7c53-878d-4452-479f-08d77d67a780
X-MS-TrafficTypeDiagnostic: DM6PR02MB5547:
X-Microsoft-Antispam-PRVS: <DM6PR02MB554715A67A5A23F43EB0A436C65B0@DM6PR02MB5547.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02475B2A01
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4U38Zh1tZ3edPa/H9tow0Nk/BSXFfYAyDi88ozoyDjBJnXS/fg5gSYhSz5B1Qa5/7+GJZ3ZKx6IeruxJsuKsAF5+Vk26jYYcvxv/FFhbEFxPjTAlJrgtr692JnuhktNw26pYQCM/cNbbAKRt0AG/YzqkuWZE0e9gYdkU/J/l4qrM9gcyO4ddLP0UsPljRE0dsrhKkSP6UQYwYHuz1WKrq0iuSCrWj/TK7uDiaJFseO8EeO3H43b5km92rLSulHwDhspAXPUgMWs9cYyU2uBsZfx/CxH6kWlnO5a+OX5Aa9aqSUmjuYSFpQ2ylWVicF2dmMhwwn2I2f/9o9YSfU/OPiDgoM0jteG/BjFO1vFSHuD+gX54p8JFAIaQw4TdM0l+Xli3HBMZRkE93OgFSZPx00kSCVtOlhiK0uooo3QyCyByZQo4Jp7CG4Ruenh1T1cvE7MkugXnmWrPFRG4Hnu/fzl6N0sEl7YVSKYKPgsVjlyu1iNl+e2rH49BgQM9nSeZ
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 11:54:03.9798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 559b7c53-878d-4452-479f-08d77d67a780
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 12. 19 15:23, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add the devicetree binding for xilinx APM.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2:
> patch added
> 
>  .../devicetree/bindings/perf/xilinx_apm.txt        | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/xilinx_apm.txt
> 
> diff --git a/Documentation/devicetree/bindings/perf/xilinx_apm.txt b/Documentation/devicetree/bindings/perf/xilinx_apm.txt
> new file mode 100644
> index 0000000..a11c82e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/xilinx_apm.txt
> @@ -0,0 +1,44 @@
> +* Xilinx AXI Performance monitor IP
> +
> +Required properties:
> +- compatible: "xlnx,axi-perf-monitor"
> +- interrupts: Should contain APM interrupts.
> +- interrupt-parent: Must be core interrupt controller.
> +- reg: Should contain APM registers location and length.
> +- xlnx,enable-profile: Enables the profile mode.
> +- xlnx,enable-trace: Enables trace mode.
> +- xlnx,num-monitor-slots: Maximum number of slots in APM.
> +- xlnx,enable-event-count: Enable event count.
> +- xlnx,enable-event-log: Enable event logging.
> +- xlnx,have-sampled-metric-cnt:Sampled metric counters enabled in APM.
> +- xlnx,num-of-counters: Number of counters in APM
> +- xlnx,metric-count-width: Metric Counter width (32/64)
> +- xlnx,metrics-sample-count-width: Sampled metric counter width
> +- xlnx,global-count-width: Global Clock counter width
> +- clocks: Input clock specifier.
> +
> +Optional properties:
> +- xlnx,id-filter-32bit: APM is in 32-bit mode
> +
> +Example:
> +++++++++
> +
> +apm: apm@44a00000 {
> +    compatible = "xlnx,axi-perf-monitor";
> +    interrupt-parent = <&axi_intc_1>;
> +    interrupts = <1 2>;
> +    reg = <0x44a00000 0x1000>;
> +    clocks = <&clkc 15>;
> +    xlnx,enable-profile = <0>;
> +    xlnx,enable-trace = <0>;
> +    xlnx,num-monitor-slots = <4>;
> +    xlnx,enable-event-count = <1>;
> +    xlnx,enable-event-log = <1>;
> +    xlnx,have-sampled-metric-cnt = <1>;
> +    xlnx,num-of-counters = <8>;
> +    xlnx,metric-count-width = <32>;
> +    xlnx,metrics-sample-count-width = <32>;
> +    xlnx,global-count-width = <32>;
> +    xlnx,metric-count-scale = <1>;
> +    xlnx,id-filter-32bit;
> +};
> 

If you look at all latest bindings everybody are ask to convert them to
yaml. That's why please do it too.

Thanks,
Michal
