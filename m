Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F63C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9B52084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JjWLEMlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfFQL2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:28:07 -0400
Received: from mail-eopbgr790053.outbound.protection.outlook.com ([40.107.79.53]:13518
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726730AbfFQL2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkVd47VmwBO8IEC90rtKzOIRaR+qHFy5pL9YKefJ2/0=;
 b=JjWLEMlX8cAAPoO8883dnuDp0JRjRF8v7oufwQuGx/5Y1qS3AF5REkpO3j8NgbF7fwqKc0cPMspk50Gx83qdx3u7KPEjLqhkeYUjqFMMP20q5ktar6ia24592eNte6eiRlqwpmdjoh48YP1ut04ValMFyKDyVlesZy8BxJ/NM2E=
Received: from MN2PR02CA0030.namprd02.prod.outlook.com (2603:10b6:208:fc::43)
 by DM5PR02MB2682.namprd02.prod.outlook.com (2603:10b6:3:108::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.13; Mon, 17 Jun
 2019 11:28:03 +0000
Received: from CY1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by MN2PR02CA0030.outlook.office365.com
 (2603:10b6:208:fc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15 via Frontend
 Transport; Mon, 17 Jun 2019 11:28:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT036.mail.protection.outlook.com (10.152.75.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Mon, 17 Jun 2019 11:28:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hcpnu-000757-1x; Mon, 17 Jun 2019 04:28:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hcpnp-00082a-29; Mon, 17 Jun 2019 04:27:57 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x5HBRltU023902;
        Mon, 17 Jun 2019 04:27:47 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hcpne-00080r-Vf; Mon, 17 Jun 2019 04:27:47 -0700
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        Olof Johansson <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com>
Date:   Mon, 17 Jun 2019 13:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(43544003)(189003)(199004)(36386004)(476003)(2616005)(356004)(6666004)(36756003)(8936002)(11346002)(8676002)(486006)(26005)(186003)(126002)(77096007)(336012)(65806001)(65956001)(81166006)(81156014)(76176011)(305945005)(446003)(229853002)(47776003)(106002)(52146003)(23676004)(14444005)(2486003)(426003)(50466002)(9786002)(63266004)(6636002)(230700001)(2906002)(5660300002)(64126003)(44832011)(70586007)(70206006)(6246003)(65826007)(4326008)(31686004)(110136005)(58126008)(54906003)(478600001)(316002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2682;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0259b3-2664-4a64-1c8a-08d6f316dc58
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM5PR02MB2682;
X-MS-TrafficTypeDiagnostic: DM5PR02MB2682:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB268246177828F97DB61237B4C6EB0@DM5PR02MB2682.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0071BFA85B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: eCjQKNcCCrUvoWfRZMmvcApvPe7ZDS8A+YBxOWLXYB2HH7MxGPoT7lz2Vvx1eEMpIffdwHW6kucB5q+MJlN6zHM3QExX+XgSrVUdupmfndXG+9co5ezVH17CvzkW9VBxZH/QcxFpkjVL6w1aTVD/24bqOHh0lOi60aftCb5SfI9G2ZiInRdiLa+ptgngwAYSCHNzx9qSn7o0J13taLrJz5qGP9XhfqAexKDulXGS+YYkEeDMpaam/JJGSngRp5Q8OGXis/NDXISXzExGqjY2BaTywKmdK+VHGMj1eboJuG/WdUXO0/yfWaSu+Ct1fZSzNw4KQKuilcK+iBiUTOjbWmuIcyixp1QJkyDsoswtoXlQIW55X4VE7caOXvNuwkkj25VMB9PmuUwHrLPyfcw+Lqm2QgymK88pcxfgS1/tj3w=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2019 11:28:02.5311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0259b3-2664-4a64-1c8a-08d6f316dc58
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17. 06. 19 13:15, Ulf Hansson wrote:
> On Tue, 11 Jun 2019 at 11:57, Manish Narani <manish.narani@xilinx.com> wrote:
>>
>> Apart from taps set by auto tuning, ZynqMP platform has feature to set
>> the tap values manually. Add support to read tap delay values from
>> DT and set the same in HW via ZynqMP SoC framework. Reading Tap
>> Delays from DT is optional, if the property is not available in DT the
>> driver will use the pre-defined Tap Delay Values.
>>
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>> ---
>>  drivers/mmc/host/sdhci-of-arasan.c | 173 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 172 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index b12abf9..7af6cec 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/phy/phy.h>
>>  #include <linux/regmap.h>
>>  #include <linux/of.h>
>> +#include <linux/firmware/xlnx-zynqmp.h>
>>
>>  #include "cqhci.h"
>>  #include "sdhci-pltfm.h"
>> @@ -32,6 +33,10 @@
>>
>>  #define PHY_CLK_TOO_SLOW_HZ            400000
>>
>> +/* Default settings for ZynqMP Tap Delays */
>> +#define ZYNQMP_ITAP_DELAYS {0, 0x15, 0x15, 0, 0x15, 0, 0, 0x3D, 0x12, 0, 0}
>> +#define ZYNQMP_OTAP_DELAYS {0, 0x5, 0x6, 0, 0x5, 0x3, 0x3, 0x4, 0x6, 0x3, 0}
>> +
>>  /*
>>   * On some SoCs the syscon area has a feature where the upper 16-bits of
>>   * each 32-bit register act as a write mask for the lower 16-bits.  This allows
>> @@ -81,6 +86,7 @@ struct sdhci_arasan_soc_ctl_map {
>>   * @sdcardclk:         Pointer to normal 'struct clock' for sdcardclk_hw.
>>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
>>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
>> + * @of_data:           Platform specific runtime data storage pointer
>>   */
>>  struct sdhci_arasan_data {
>>         struct sdhci_host *host;
>> @@ -101,6 +107,15 @@ struct sdhci_arasan_data {
>>  /* Controller immediately reports SDHCI_CLOCK_INT_STABLE after enabling the
>>   * internal clock even when the clock isn't stable */
>>  #define SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE BIT(1)
>> +
>> +       void *of_data;
>> +};
>> +
>> +struct sdhci_arasan_zynqmp_data {
>> +       void (*set_tap_delay)(struct sdhci_host *host);
>> +       const struct zynqmp_eemi_ops *eemi_ops;
>> +       u8 tapdly[MMC_TIMING_MMC_HS400 + 1][2]; /* [0] for input delay, */
>> +                                               /* [1] for output delay */
>>  };
> 
> Please use two different structs, one for the clock provider data and
> one for the mmc variant/platform data. This makes the code more
> readable.

Origin version before sending that out was using two fields.
+	u32 itapdly[MMC_TIMING_MMC_HS400 + 1];
+	u32 otapdly[MMC_TIMING_MMC_HS400 + 1];

I did asked for putting it together to two dimensional array for
improving readability of this code. The reason was that you need to take
care about input/output together.
One thing I was also suggesting was to use instead of 2 just enum values
to specify IN=0/OUT/MAX to improve readability of this.
Do you think that using enum should be enough?


> In regards to the mmc data part, I suggest to drop the
> ->set_tap_delay() callback, but rather use a boolean flag to indicate
> whether clock phases needs to be changed for the variant. Potentially
> that could even be skipped and instead call clk_set_phase()
> unconditionally, as the clock core deals fine with clock providers
> that doesn't support the ->set_phase() callback.

In connection to another version of this driver for latest Xilinx chip
it would be better to keep set_tap_delay callback in the driver. The
reason is that new chip/ip is capable to setup tap delays directly
without asking firmware to do it. That's why for versal IP there is a
need to call different setup_tap_delay function.

> 
> [...]
> 
> Otherwise this looks good to me!
> 
> When it comes to patch1, I need an ack from Michal to pick it up.

I am waiting till Rob ack dt binding and then I wanted to talk to you if
you want to take it with 1/3 or if you want me to take all of them via
my tree.
In previous releases I was taking them via my tree because there were
several subsystem changing firmware interface. In this cycle there are
just small changes to firmware interface that's why taking it via your
tree shouldn't be a problem too.

Thanks,
Michal

