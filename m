Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC04C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F3B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="O2HJPqqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfCRPA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:00:27 -0400
Received: from mail-eopbgr750074.outbound.protection.outlook.com ([40.107.75.74]:9955
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbfCRPA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mChfGp0uaeisGPX8W+5mULJJWchM72/CK8EkKlL9g3M=;
 b=O2HJPqqfZE3WCz2t8AE61dcqXh1uGkR+y1WcB/sROLmptcf3PhJLOfEUwA75UaTG8iGJlUQzLQQ3Og22QvxQ0nXbImOSs9igsEvrTnMb3p5KpU3QbP2nbpC52rk9RsiR7TdPXFc6ThmY3qickNdgRlTtYJ4SXVv6LsNOSAYt7IM=
Received: from SN6PR02CA0015.namprd02.prod.outlook.com (52.135.118.156) by
 BN6PR02MB2355.namprd02.prod.outlook.com (10.168.254.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 14:59:44 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by SN6PR02CA0015.outlook.office365.com
 (2603:10b6:805:a2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.14 via Frontend
 Transport; Mon, 18 Mar 2019 14:59:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 14:59:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34732 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5tjq-0006Nu-Pv; Mon, 18 Mar 2019 07:59:42 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5tjl-0003AG-MU; Mon, 18 Mar 2019 07:59:37 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2IExYta017861;
        Mon, 18 Mar 2019 07:59:34 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h5tji-00039w-66; Mon, 18 Mar 2019 07:59:34 -0700
Subject: Re: [PATCH] arm64: zynqmp: dt: Add TI PHY quirk
To:     Harini Katakam <harini.katakam@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <sudeep.holla@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>
References: <1552130218-21505-1-git-send-email-harini.katakam@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0abac7f6-0aff-4577-18f6-17516cea0b04@xilinx.com>
Date:   Mon, 18 Mar 2019 15:59:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552130218-21505-1-git-send-email-harini.katakam@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(199004)(189003)(50466002)(76176011)(64126003)(47776003)(54906003)(478600001)(65806001)(65956001)(110136005)(2201001)(23676004)(8936002)(5660300002)(316002)(77096007)(58126008)(14444005)(36756003)(4326008)(186003)(26005)(31696002)(106466001)(2616005)(426003)(81166006)(81156014)(126002)(476003)(230700001)(8676002)(6246003)(336012)(11346002)(44832011)(65826007)(446003)(2906002)(36386004)(305945005)(9786002)(229853002)(63266004)(486006)(106002)(31686004)(2486003)(356004)(6666004)(5001870100001)(2101003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2355;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7859c455-a292-47b5-c1c4-08d6abb25acf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR02MB2355;
X-MS-TrafficTypeDiagnostic: BN6PR02MB2355:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB23557C6A4C875E59019E239AC6470@BN6PR02MB2355.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jlXkJCnjXs6ouxjObXrw6WbY5Rp3rG1L4EDrmNqrmzsYkGl1eR0LPRUBYlSLM8xptLmowSn11ittu5CBngkeiYuOZ7GTpuDEVpxDqN9D7NUXYXze7BGk6JGpa5H0NbOpdQllfsnE2jIIO2E4AlcPxghxtG9jvXnNcG7429HOrhsnGOe8Sbr612YYb8umTD6+AqO8Rg3paQNuAUBUf/ppA6SHT1nuDKQ56Tvo0jF13sJbl51L2/NF6Ti+R6Ww3y0Vm1gkfAeERxUPaKVx4hDaArb3ibwQ7fL6azFuLhvmrKTPoFnKTGHWcfIhKrDspR3JgWvFIQsenYeiSH6MlKku6I6kvC72ztSNUce7Ob2h7YI2Em2ZBKj7+F19URaAcnqbT4ivA4RukVfcBxHiPBrdvscNtnjLoYmNSlPVoB4Y4b8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 14:59:43.2274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7859c455-a292-47b5-c1c4-08d6abb25acf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2355
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 03. 19 12:16, Harini Katakam wrote:
> Add TI PHY strap ctrl quirk for all the HW where applicable.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts      | 1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 1 +
>  6 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> index 11cc671..2421ec7 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> @@ -89,6 +89,7 @@
>  		ti,rx-internal-delay = <0x8>;
>  		ti,tx-internal-delay = <0xa>;
>  		ti,fifo-depth = <0x1>;
> +		ti,dp83867-rxctrl-strap-quirk;
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index cef8167..2a3b665 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -110,6 +110,7 @@
>  		ti,rx-internal-delay = <0x8>;
>  		ti,tx-internal-delay = <0xa>;
>  		ti,fifo-depth = <0x1>;
> +		ti,dp83867-rxctrl-strap-quirk;
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> index af4d868..1780ed2 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> @@ -21,6 +21,7 @@
>  		ti,rx-internal-delay = <0x8>;
>  		ti,tx-internal-delay = <0xa>;
>  		ti,fifo-depth = <0x1>;
> +		ti,dp83867-rxctrl-strap-quirk;
>  	};
>  	/* Cleanup from RevA */
>  	/delete-node/ phy@21;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index d4ad19a..8f45614 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -55,6 +55,7 @@
>  		ti,rx-internal-delay = <0x8>;
>  		ti,tx-internal-delay = <0xa>;
>  		ti,fifo-depth = <0x1>;
> +		ti,dp83867-rxctrl-strap-quirk;
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 94cf509..93ce7eb 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -111,6 +111,7 @@
>  		ti,rx-internal-delay = <0x8>;
>  		ti,tx-internal-delay = <0xa>;
>  		ti,fifo-depth = <0x1>;
> +		ti,dp83867-rxctrl-strap-quirk;
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index 460adc3..8bb0001 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -106,6 +106,7 @@
>  		ti,rx-internal-delay = <0x8>;
>  		ti,tx-internal-delay = <0xa>;
>  		ti,fifo-depth = <0x1>;
> +		ti,dp83867-rxctrl-strap-quirk;
>  	};
>  };
>  
> 

Applied.

Thanks,
Michal
