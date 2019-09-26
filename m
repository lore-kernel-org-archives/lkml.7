Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A151C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC048222C5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nLceuRWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfIZKMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:12:05 -0400
Received: from mail-eopbgr790047.outbound.protection.outlook.com ([40.107.79.47]:63274
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbfIZKME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:12:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9be9dZmqrs/zxQorvop4U6zfsKiSfG8anwEpZQ18365lRYMTQv4zvv0ydgQ1XOc0V2j+NDeb42lIPBxEfNZ9oL1TCaPRUU8iSK9lGU2nmtgM1UuZ5oX/UuFDo6ki1HNYs48h6TS9eWchypxJ8fBJR4XhCu9+bwLV+HnJiKquCfqD0ttyVTSRbId8qwJjxmuGApcckAoIimwnw7qkJfPqu9MwIh6zg4xvlXviGaGsqs+iJjnbbLOYI+1Aa6dtg+Po/nxKXK7MEuwo0C0pNN2MkBteu9RAJnMy54ogp7H2Zue0T5cnOTFFeen2xH+gHyBWmDmNmG1YI3SZuFG573bwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNh/BOjFkDoXwnwANy704ccPw1kb2Chmn0XNg8T6EdA=;
 b=gTqwp4XkEpr0IWEc6Gskp2ye1HJq9a3s7exr7HxVntbU0+K5GUKDfWONn62uFHnTAGGzYhrqemMhSjWr9HWFa8CrRITXQq9MW30ieRQYG/IaOECYVShn8bwVgGxghQ1oaqn+psaUJz0ebYUKfcJgkl2i9iqd9mwIV2eEPRURP02/WTLni5m+Mz37fMgZdd4QugM+cfTcxj52/iifkT7WMKbwwmIUC/7JYy1GHosl/HERzzO0Ff0MdGV2LGslqEtydbMNtfB6+qg9XsH0taZdvqZ9ePUwyppy12V3zCeup5wvXFaBN9x1zSp58SBF+UTu2DomHY2m5lwG/3b2YVyu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNh/BOjFkDoXwnwANy704ccPw1kb2Chmn0XNg8T6EdA=;
 b=nLceuRWtmT33xOxoVyiqXp7VuBITu5kZOKwAWDrS3p0CsbNb7gPWY4xRyCwlGGWo75DVvhcTQS2bQDV2z6QMQhu/hkUn0z8Zi6YprJbIEAiEtdD+gkMtn9q2tcr3Q0gemMYLBuCJjvYY3PW5WleImZPCKhA9a6KXYtz5HzzsPks=
Received: from DM6PR02CA0046.namprd02.prod.outlook.com (2603:10b6:5:177::23)
 by DM6PR02MB5324.namprd02.prod.outlook.com (2603:10b6:5:47::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Thu, 26 Sep
 2019 10:12:01 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by DM6PR02CA0046.outlook.office365.com
 (2603:10b6:5:177::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.21 via Frontend
 Transport; Thu, 26 Sep 2019 10:12:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:12:00 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iDQki-0003GC-Fh; Thu, 26 Sep 2019 03:12:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iDQkd-0000ie-CD; Thu, 26 Sep 2019 03:11:55 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8QABkQB014397;
        Thu, 26 Sep 2019 03:11:46 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iDQkT-0000ZP-PM; Thu, 26 Sep 2019 03:11:45 -0700
Subject: Re: [PATCH] arm64: zynqmp: Add dr_mode property to usb node
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, sudeep.holla@arm.com,
        jan.kiszka@siemens.com
Cc:     v.anuragkumar@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1568128642-4782-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <e0f8681e-1c0e-668e-25af-270574d4d748@xilinx.com>
Date:   Thu, 26 Sep 2019 12:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568128642-4782-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(81156014)(229853002)(47776003)(70206006)(65956001)(356004)(8676002)(58126008)(23676004)(336012)(6666004)(316002)(305945005)(106002)(50466002)(65806001)(478600001)(5660300002)(31696002)(4326008)(476003)(2616005)(126002)(446003)(8936002)(486006)(2906002)(11346002)(426003)(26005)(70586007)(31686004)(2486003)(76176011)(36386004)(6246003)(186003)(230700001)(81166006)(44832011)(9786002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5324;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ae7753e-aa2e-4cbb-c2e8-08d74269f8f1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR02MB5324;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5324:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5324EA6A5907D0B7EF87FA05C6860@DM6PR02MB5324.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: uvApn+xdGHzMEHOTA3D2VxjRzHLxyVbtUtDn9qmEiNiBYUCW6E8ub+9wKJg4cvfsl/xXbPTXJjqmHN0TYrufR1YUg/laqRjW03Rdgexb92bpq4S1RH1Ft/wP9WtvpZtV+LTXSykfdxdixYNE2X8Ztu8ksgMLC6iQLR7TP/fip5g20fa52Yo5in9f7V96qCqtN7dWPt1D+pLkvFCrOz+PtPNv6yWXmrQVinBr0K8Pm/n7AjL0bBj0SI/Ss3qDSi1PdbRJPgxN4dqVCJ73q5QGow3LwzzXpw8olfoUeQD/0k/Uo3FoHlu3zY75kaJevN0PB8vrLNFaZC+1BtCTcuG42rEVQ6a6lO35yzlDBWTUr3BnJbIy6gy7W5lRNUM7IS+Q0ec2aTxArgBBcENgN5En1I8eakAoVzjj+OZxx8hPl3E=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:12:00.9915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae7753e-aa2e-4cbb-c2e8-08d74269f8f1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 09. 19 17:17, Anurag Kumar Vulisha wrote:
> This patch adds dr_mode property to the usb node for
> zynqmp boards.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 2 ++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 1 +
>  7 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index 9a3e39d..386f701 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> @@ -128,4 +128,5 @@
>  /* ULPI SMSC USB3320 */
>  &usb0 {
>  	status = "okay";
> +	dr_mode = "host";
>  };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> index 2421ec7..c6c8e2c 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> @@ -158,6 +158,7 @@
>  /* ULPI SMSC USB3320 */
>  &usb1 {
>  	status = "okay";
> +	dr_mode = "host";
>  };
>  
>  &uart0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index e5699d0..c64c7b8 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -274,11 +274,13 @@
>  /* ULPI SMSC USB3320 */
>  &usb0 {
>  	status = "okay";
> +	dr_mode = "peripheral";
>  };
>  
>  /* ULPI SMSC USB3320 */
>  &usb1 {
>  	status = "okay";
> +	dr_mode = "host";
>  };
>  
>  &watchdog0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 2a3b665..011f138 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -540,6 +540,7 @@
>  /* ULPI SMSC USB3320 */
>  &usb0 {
>  	status = "okay";
> +	dr_mode = "host";
>  };
>  
>  &watchdog0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 8f45614..7e372b1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -189,6 +189,7 @@
>  /* ULPI SMSC USB3320 */
>  &usb0 {
>  	status = "okay";
> +	dr_mode = "host";
>  };
>  
>  &watchdog0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 93ce7eb..c4aac7a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -514,6 +514,7 @@
>  /* ULPI SMSC USB3320 */
>  &usb0 {
>  	status = "okay";
> +	dr_mode = "host";
>  };
>  
>  &watchdog0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index 8bb0001..4909533 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -440,4 +440,5 @@
>  /* ULPI SMSC USB3320 */
>  &usb0 {
>  	status = "okay";
> +	dr_mode = "host";
>  };
> 

Applied.
M
