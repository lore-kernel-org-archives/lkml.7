Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A9BC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9949A218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ku8zmEjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfLROat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:30:49 -0500
Received: from mail-eopbgr700082.outbound.protection.outlook.com ([40.107.70.82]:4256
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfLROat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:30:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMH/3Efe7QtTq7TX/tRwf59G5+hN0ml78w/xyENmb/It9TFD3r2w7EfZuzAxO+9Q35soXM1by8mx47yc/YeZlF6J8zwWSwM+3kDJKo0/1J2fs2wWMlUUq6IrXbyXXz5YxRrmSE1kQHj/nlYjrO78McY8vpiw5tbBMYWVI5GZrpKz0aoVM7ChA5Xmo3sm29+e4JcmodsL9qsdMnLLjFhAMxIFekxBg5oF2pOmjzpGqTdBWWYfmGVclUcrKyBI4AXtJ0weo5CxZ8EjW5qsZyGJ5SAaD1mAkI8bck/FfSfbR4/NLuQSqH9gBGTqAk5sNlc1/wFoOs8vaedTTE77KNEpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bN7SS52CbiAsBIyD0ougq45UTzC2KJeveAEHmLGURc=;
 b=IB/vQCxlYhC1wMKRpdHx5S2O/SFuJArYUmzXc/UXznaEDnc2JrDVL/bx7HBjPtX3S8dA9DAjGdNQH8tJPmc3mNJD8kArrwAwlWh313uypZ/4fMsoSP8jSv5dsbqxc+S8Yu+p1SBsvBxLpHSACZGJ2npSjlY1aX4lHYU9vdPIetnoe2u6mXVSz1MWQ0TdYBRmMJGiRjY2y8GOvbCYwvKFUWCPnTzldIkSz34NA6VnSJvvV3VrDLTOLLyBwfB92qdvm+28I9wUpox5gLoMtcMMCKt0rGJ77hDdvld7Lj7CvdcHDxskA/R1Gohm9sGsF8yLGkMIlOsFwqOy3oFEPq0How==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bN7SS52CbiAsBIyD0ougq45UTzC2KJeveAEHmLGURc=;
 b=Ku8zmEjGdMpkQSCByn0GtH7sWk7kjhiRJ0C5Fl4zd/0UAi6zCL9zYD1VufCkdjBesXdgi7xoZwV2dzauNTvKT8aNr5hoJWCcqjl7G48gqb9DqqUOS/Z5rfeL1B4sEKc/UYIRHleLvqyqQWvJ6+RsH9zqFRdWNvWcPNsXV5KCixI=
Received: from CY4PR22CA0089.namprd22.prod.outlook.com (2603:10b6:903:ad::27)
 by BN7PR02MB4082.namprd02.prod.outlook.com (2603:10b6:406:ef::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Wed, 18 Dec
 2019 14:30:43 +0000
Received: from CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ad:cafe::a2) by CY4PR22CA0089.outlook.office365.com
 (2603:10b6:903:ad::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Wed, 18 Dec 2019 14:30:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT021.mail.protection.outlook.com (10.152.75.187) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Wed, 18 Dec 2019 14:30:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ihaLa-0001H0-2E; Wed, 18 Dec 2019 06:30:42 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ihaLU-0007d9-Ha; Wed, 18 Dec 2019 06:30:36 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xBIEUVRN021544;
        Wed, 18 Dec 2019 06:30:31 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ihaLO-0007XX-Sm; Wed, 18 Dec 2019 06:30:31 -0800
Subject: Re: [PATCH v2] ARM: dts: zynq: enablement of coresight topology
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com
Cc:     Zumeng Chen <zumeng.chen@windriver.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <882627bc1ecd622355fb72b742b4e3c013d0b1ca.1576161496.git.michal.simek@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <91cd571f-6c41-55bd-87d8-8925dc0a0ae4@xilinx.com>
Date:   Wed, 18 Dec 2019 15:30:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <882627bc1ecd622355fb72b742b4e3c013d0b1ca.1576161496.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(189003)(199004)(186003)(5660300002)(26005)(8936002)(4326008)(36756003)(2906002)(31696002)(2616005)(498600001)(81156014)(8676002)(81166006)(426003)(9786002)(6636002)(70586007)(70206006)(336012)(54906003)(31686004)(44832011)(356004)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB4082;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f34ca03c-523c-48b2-fac5-08d783c6dcd0
X-MS-TrafficTypeDiagnostic: BN7PR02MB4082:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR02MB4082BF11C6C33181CB9171C9C6530@BN7PR02MB4082.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0255DF69B9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdC4tgkJtXeC5u4Jt4ymfkvd8xrk0buPwS1zNKSHHSTofN74OL42FdyPeWrPaPLswYs8zLRrwPY6zuGw6ie2ymoBgtjhac1nMKZFEPqL0s48ftbEwbkmfXbDtaPMNy189MumGwCYn2nLJJQihGCBPmQqRO/0tKMkE34Gpcjrc9P9kHMsQeQHmEedHpycrAMi0CtBFT+jy1lx5u7+1XV32p7LVnSu/xHZ/DphHGKFeQHFOYSX1wPo9PkRcIF+djTG1HAXS32DO+jdSCjjl0kt0f5vJXYrTO8GKcSBexHvnI82WWNJTxfLjOhXMEVrLqVabk1CtO5UU827ry+OscA6jTm6K68YdWYBLj/F/C/lrcFxsiPKuk3LCb9NozZZlmqTndG237MnD3frz55Wd7MlXk2cMexQE506a7PPtalJCkSZEF54ZiHEYK/404bK8UuW
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 14:30:42.5469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f34ca03c-523c-48b2-fac5-08d783c6dcd0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 12. 19 15:38, Michal Simek wrote:
> From: Zumeng Chen <zumeng.chen@windriver.com>
> 
> This patch is to build the coresight topology structure of zynq-7000
> series according to the docs of coresight and userguide of zynq-7000.
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Remove slava-mode from replicator in-ports
> - Remove ITM completely
> 
>  arch/arm/boot/dts/zynq-7000.dtsi | 135 +++++++++++++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index ca6425ad794c..db3899b07992 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -59,6 +59,39 @@ regulator_vccpint: fixedregulator {
>  		regulator-always-on;
>  	};
>  
> +	replicator {
> +		compatible = "arm,coresight-static-replicator";
> +		clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +		clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +
> +		out-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* replicator output ports */
> +			port@0 {
> +				reg = <0>;
> +				replicator_out_port0: endpoint {
> +					remote-endpoint = <&tpiu_in_port>;
> +				};
> +			};
> +			port@1 {
> +				reg = <1>;
> +				replicator_out_port1: endpoint {
> +					remote-endpoint = <&etb_in_port>;
> +				};
> +			};
> +		};
> +		in-ports {
> +			/* replicator input port */
> +			port {
> +				replicator_in_port0: endpoint {
> +					remote-endpoint = <&funnel_out_port>;
> +				};
> +			};
> +		};
> +	};
> +
>  	amba: amba {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -365,5 +398,107 @@ watchdog0: watchdog@f8005000 {
>  			reg = <0xf8005000 0x1000>;
>  			timeout-sec = <10>;
>  		};
> +
> +		etb@f8801000 {
> +			compatible = "arm,coresight-etb10", "arm,primecell";
> +			reg = <0xf8801000 0x1000>;
> +			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +			in-ports {
> +				port {
> +					etb_in_port: endpoint {
> +						remote-endpoint = <&replicator_out_port1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		tpiu@f8803000 {
> +			compatible = "arm,coresight-tpiu", "arm,primecell";
> +			reg = <0xf8803000 0x1000>;
> +			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +			in-ports {
> +				port {
> +					tpiu_in_port: endpoint {
> +						remote-endpoint = <&replicator_out_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@f8804000 {
> +			compatible = "arm,coresight-static-funnel", "arm,primecell";
> +			reg = <0xf8804000 0x1000>;
> +			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +
> +			/* funnel output ports */
> +			out-ports {
> +				port {
> +					funnel_out_port: endpoint {
> +						remote-endpoint =
> +							<&replicator_in_port0>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* funnel input ports */
> +				port@0 {
> +					reg = <0>;
> +					funnel0_in_port0: endpoint {
> +						remote-endpoint = <&ptm0_out_port>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					funnel0_in_port1: endpoint {
> +						remote-endpoint = <&ptm1_out_port>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					funnel0_in_port2: endpoint {
> +					};
> +				};
> +				/* The other input ports are not connect to anything */
> +			};
> +		};
> +
> +		ptm@f889c000 {
> +			compatible = "arm,coresight-etm3x", "arm,primecell";
> +			reg = <0xf889c000 0x1000>;
> +			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +			cpu = <&cpu0>;
> +			out-ports {
> +				port {
> +					ptm0_out_port: endpoint {
> +						remote-endpoint = <&funnel0_in_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		ptm@f889d000 {
> +			compatible = "arm,coresight-etm3x", "arm,primecell";
> +			reg = <0xf889d000 0x1000>;
> +			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +			cpu = <&cpu1>;
> +			out-ports {
> +				port {
> +					ptm1_out_port: endpoint {
> +						remote-endpoint = <&funnel0_in_port1>;
> +					};
> +				};
> +			};
> +		};
>  	};
>  };
> 

Applied to zynq/dt.

Thanks,
Michal
