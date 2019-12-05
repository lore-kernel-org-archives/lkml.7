Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B94C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFE02245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfLEM5b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:57:31 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:19732 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729096AbfLEM5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:57:31 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xB5Ctg0s004364
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 5 Dec 2019 20:55:42 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from lenovo (10.0.74.130) by BJMBX01.spreadtrum.com (10.0.64.7) with
 Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 5 Dec 2019 20:55:43 +0800
Date:   Thu, 5 Dec 2019 20:55:39 +0800
From:   Orson Zhai <orson.zhai@spreadtrum.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Rob Herring <robh@kernel.org>, Orson Zhai <orson.zhai@unisoc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <kevin.tang@unisoc.com>, <baolin.wang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: syscon: Add syscon-names to refer to
 syscon easily
Message-ID: <20191205125539.GH21613@lenovo>
References: <20191120154148.22067-1-orson.zhai@unisoc.com>
 <20191120154148.22067-2-orson.zhai@unisoc.com>
 <20191204163830.GA25135@bogus>
 <CAK8P3a3_r6z6Qk133=4gUzJ0rYmMH7sDDqpEF8ZVXS_bc3OtkQ@mail.gmail.com>
 <20191204192639.GA15786@bogus>
 <CAK8P3a165hqB=5LmMiTPGJxvsSJqrbFf5EC9WnqtFRYFok+xKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAK8P3a165hqB=5LmMiTPGJxvsSJqrbFf5EC9WnqtFRYFok+xKw@mail.gmail.com>
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [10.0.74.130]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com xB5Ctg0s004364
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd & Rob,

On Thu, Dec 05, 2019 at 10:20:03AM +0100, Arnd Bergmann wrote:
> On Wed, Dec 4, 2019 at 8:26 PM Rob Herring <robh@kernel.org> wrote:
> > On Wed, Dec 04, 2019 at 06:00:17PM +0100, Arnd Bergmann wrote:
> > > On Wed, Dec 4, 2019 at 5:38 PM Rob Herring <robh@kernel.org> wrote:
>
> > > I think generally speaking this would be useful for random registers that
> > > logically belong to one device but are grouped with other unrelated
> > > registers in a syscon, and that are in a different register offset for
> > > each chip that has them. Using named properties instead of a list
> > > of phandle/arg tuples with names is clearly a simpler alternative
> > > and more like we do it today, but I can also see some API simplification
> > > with Orson's patch without the binding getting out of hand.
> >
> > I understand when a phandle to a syscon is used. That's nothing new.
> > What's special about Unisoc SoC that needs something new/different?
> > I saw there's a large number of syscons, but I don't understand what's
> > in them.
> >
> > If the API is this:
> >
> > struct regmap *syscon_regmap_lookup_by_name(struct device_node *np,
> >                                        const char *name,
> >                                        int arg_count, __u32 *out_args)
> >
> > How is 'name' being an entry in syscon-names simpler than just being the
> > property name? The implementation for the latter would certainly be
> > simpler.
> >
> > It also makes the property unparseable without knowledge outside of the
> > DT (i.e. in the driver). I suppose if the number of cells for each entry
> > is fixed, we could count the number of syscon-names entries to figure
> > out the stride. But then if one entry needs a lot of cells, then they
> > all have to have padding cells.
>
> Good point. The syscon_regmap_lookup_by_name() interface would
> work just as well when passing a property name compared to
> a name listed in another property, and this would still be more in
> line with what we do on other SoCs.
>

udx710-modem.dtsi:69:   syscons = <&pmu_apb_regs 0x18 0x2000000>,
udx710-modem.dtsi-70-           <&pmu_apb_regs 0x544 0x1>,
udx710-modem.dtsi-71-           <&aon_apb_regs 0x218 0x7e00>,
udx710-modem.dtsi-72-           <&pmu_apb_regs 0xb0 0x20000>,
udx710-modem.dtsi-73-           <&pmu_apb_regs 0xff 0x100>;
udx710-modem.dtsi:74:   syscon-names = "shutdown", "deepsleep", "corereset",
udx710-modem.dtsi-75-                  "sysreset", "getstatus";

ud710.dtsi:1268:        syscons = <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PRESENT_32K>,
ud710.dtsi-1269-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PROTECT_32K>,
ud710.dtsi-1270-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_EN_32K>,
ud710.dtsi-1271-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_THD_32K>;
ud710.dtsi:1272:        syscon-names =  "sd_detect_pol",
ud710.dtsi-1273-                        "sd_hotplug_protect_en",
ud710.dtsi-1274-                        "sd_hotplug_debounce_en",
ud710.dtsi-1275-                        "sd_hotplug_debounce_cn";


> The only advantage I can see in having a list of phandle/arg tuples
> rather than a set of properties is that it is a slightly more compact
> representation in source form, but otherwise they should be equivalent

Yes, I agree.
They are equivalent.

But sprd SoCs have too many registers and the representation might matter.
Here's some real code from local,

orca.dtsi:1276:         syscons = <&pmu_apb_regs REG_PMU_APB_RF_PD_AUDCP_SYS_CFG MASK_PMU_APB_RF_PD_AUDCP_SYS_FORCE_SHUTDOWN >,
orca.dtsi-1277-                 <&pmu_apb_regs REG_PMU_APB_RF_PD_AUDCP_AUDDSP_CFG MASK_PMU_APB_RF_PD_AUDCP_AUDDSP_AUTO_SHUTDOWN_EN>,
orca.dtsi-1278-                 <&pmu_apb_regs REG_PMU_APB_RF_SLEEP_CTRL MASK_PMU_APB_RF_AUDCP_FORCE_DEEP_SLEEP>,
orca.dtsi-1279-                 <&pmu_apb_regs REG_PMU_APB_RF_CP_SOFT_RST MASK_PMU_APB_RF_AUDCP_AUDDSP_SOFT_RST>,
orca.dtsi-1280-                 <&pmu_apb_regs REG_PMU_APB_RF_CP_SOFT_RST MASK_PMU_APB_RF_AUDCP_SYS_SOFT_RST>,
orca.dtsi-1281-                 <&pmu_apb_regs REG_PMU_APB_RF_SOFT_RST_SEL MASK_PMU_APB_RF_SOFT_RST_SEL>,
orca.dtsi-1282-                 <&pmu_apb_regs REG_PMU_APB_RF_PWR_STATUS3_DBG MASK_PMU_APB_RF_PD_AUDCP_SYS_STATE>,
orca.dtsi-1283-                 <&pmu_apb_regs REG_PMU_APB_RF_PWR_STATUS3_DBG MASK_PMU_APB_RF_PD_AUDCP_AUDDSP_STATE>,
orca.dtsi-1284-                 <&pmu_apb_regs REG_PMU_APB_RF_SLEEP_STATUS MASK_PMU_APB_RF_AUDCP_SLP_STATUS>,
--
orca.dtsi:1288:         syscon-names = "sysshutdown", "coreshutdown", "deepsleep", "corereset",
orca.dtsi-1289-                 "sysreset", "reset_sel", "sysstatus", "corestatus", "sleepstatus",
orca.dtsi-1290-                 "bootprotect", "bootvector", "bootaddress_sel";


ud710.dtsi:1268:        syscons = <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PRESENT_32K>,
ud710.dtsi-1269-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PROTECT_32K>,
ud710.dtsi-1270-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_EN_32K>,
ud710.dtsi-1271-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_THD_32K>;
ud710.dtsi:1272:        syscon-names =  "sd_detect_pol",
ud710.dtsi-1273-                        "sd_hotplug_protect_en",
ud710.dtsi-1274-                        "sd_hotplug_debounce_en",
ud710.dtsi-1275-                        "sd_hotplug_debounce_cn";

Compare to following,

sd_hotplug_protect_en-syscon = <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PRESENT_32K>;
sd_hotplug_debounce_en-syscon = <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PROTECT_32K>;
sd_hotplug_debounce_cn-syscon = <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_THD_32K>;
.....

For me, my choice would be the former.
It looks more clear.

> and agree about this being harder to parse in an automated way.
>
> Orson, do you see any other reason for the combined property?
No other reason.

> If not, could you respin the series once more with
> syscon_regmap_lookup_by_name() replaced by something like:?
>
> struct regmap *
> syscon_regmap_lookup_args_by_phandle(struct device_node *np,
>                                         const char *property,
>                                         int arg_count, __u32 *out_args)

I like this idea. syscon_regmap_lookup_by_phandle_args() would be better?

May I impelement them both?

But I will be OK if no one here except me likes to expand name list.

Best,
Orson
>
>          Arnd
________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
