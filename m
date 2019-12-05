Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98C1C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9206221835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIwgo3hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfLEQzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:55:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41204 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:55:46 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so3012774lfp.8;
        Thu, 05 Dec 2019 08:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XxaKTbFhPCmRNoo8ptA1/E8uJhhXVU6Ge1hgqGg3DYA=;
        b=IIwgo3hvY9MNAn12Hp/Lf9MKUA3GCBuUDJFPYc7yNsSZx6joJgWuLMuUB7vyjZDgfe
         SH11hz/4F5Sp/KV0tAL6/8UmW1LGWsJ+2OYfttHs1ZXRRU7qkwKNHNABMMTcveDSg1sv
         O3XHcxwH9sXOaE5VXSogfaYsJEkv5yma3/rwNQ57jf5lq8cXzpYxNMJAmooimxy1qXhK
         GNUttYPgDQtylhzCY0mc3vjVlQVeONUUYUcs7KoaUApi7SyIN2Ql/FMGjrSrql0tE8eZ
         nB2zwFf+vlJjf6vmJ4uL7zWW+D2M4yNfCWghhsG2U7UeufABacWV4MSBBkS2DFbX1911
         M8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxaKTbFhPCmRNoo8ptA1/E8uJhhXVU6Ge1hgqGg3DYA=;
        b=QmCckcMAJKTOuHBvFrzjbyJ++WVUhqld/1BPG8aZa1QDdS9ctokStOduZ5USk3W562
         Gm1eNwdzjnIyOlqes5e34vY5kRML8/fyA95NAlDVVZK2NoyVoOCrn6KfCtoS4YwMfTPk
         V0rrVwDQgkMp3RSknP4Dxb6hiQn13/CPDtECKB0CsKkCQCOPC80RNL+DtogO/gku/G0Q
         7+aDzOEVSEEBoGr3I+hauh3CCAUJ1vWxt9gC0FJbC3L0otW8G8zl/pgBDgwf/ofT/TOF
         YkLyd1R9dlpcOQIYUwmhuY2jjFrwxBounC2UpbNa6nFAV31IXN/Uu/LZiT/luKjIdwnO
         hlaQ==
X-Gm-Message-State: APjAAAWEWNX8OGmiQsPFV9WVRO522Su7vNYSB6KP9t5TKKnUMniKABmw
        4lprMvNjdmn1TPpV5pkMRhzPZIsNGIyjKWWWwYE=
X-Google-Smtp-Source: APXvYqxJXP0ma5LRNrxZKaabRUikh4lx3xMlQN9YyCDjs27fruEtlWoJZIOenex95wnZbkxuX7fmAgJYBNM0zL9ZVbw=
X-Received: by 2002:ac2:4c82:: with SMTP id d2mr6003714lfl.62.1575564942541;
 Thu, 05 Dec 2019 08:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20191120154148.22067-1-orson.zhai@unisoc.com> <20191120154148.22067-2-orson.zhai@unisoc.com>
 <20191204163830.GA25135@bogus> <CAK8P3a3_r6z6Qk133=4gUzJ0rYmMH7sDDqpEF8ZVXS_bc3OtkQ@mail.gmail.com>
 <20191204192639.GA15786@bogus> <CAK8P3a165hqB=5LmMiTPGJxvsSJqrbFf5EC9WnqtFRYFok+xKw@mail.gmail.com>
 <20191205125539.GH21613@lenovo> <20191205151237.GA30195@bogus> <CA+H2tpEZ_d-c6DcfQ3yZPf4s_0GTe-q5q4FnVydYm2cdi0im=g@mail.gmail.com>
In-Reply-To: <CA+H2tpEZ_d-c6DcfQ3yZPf4s_0GTe-q5q4FnVydYm2cdi0im=g@mail.gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Fri, 6 Dec 2019 00:55:30 +0800
Message-ID: <CA+H2tpGagLpf6awzGWpXuD4dMTP3kzU=sbD=AqzKqYgktGZoKg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: syscon: Add syscon-names to refer to
 syscon easily
To:     Rob Herring <robh@kernel.org>
Cc:     Orson Zhai <orson.zhai@spreadtrum.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Tang <kevin.tang@unisoc.com>, baolin.wang@unisoc.com,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry! Re-send as plain-text mode.

 On Thu, Dec 5, 2019 at 11:13 PM Rob Herring <robh@kernel.org> wrote:
 >
 > On Thu, Dec 05, 2019 at 08:55:39PM +0800, Orson Zhai wrote:
 > > Hi Arnd & Rob,
 > >
 > > On Thu, Dec 05, 2019 at 10:20:03AM +0100, Arnd Bergmann wrote:
 > > > On Wed, Dec 4, 2019 at 8:26 PM Rob Herring <robh@kernel.org> wrote:
 > > > > On Wed, Dec 04, 2019 at 06:00:17PM +0100, Arnd Bergmann wrote:
 > > > > > On Wed, Dec 4, 2019 at 5:38 PM Rob Herring <robh@kernel.org> wrote:
 > > >
 > > > > > I think generally speaking this would be useful for random
registers that
 > > > > > logically belong to one device but are grouped with other unrelated
 > > > > > registers in a syscon, and that are in a different register
offset for
 > > > > > each chip that has them. Using named properties instead of a list
 > > > > > of phandle/arg tuples with names is clearly a simpler alternative
 > > > > > and more like we do it today, but I can also see some API
simplification
 > > > > > with Orson's patch without the binding getting out of hand.
 > > > >
 > > > > I understand when a phandle to a syscon is used. That's nothing new.
 > > > > What's special about Unisoc SoC that needs something new/different?
 > > > > I saw there's a large number of syscons, but I don't understand what's
 > > > > in them.
 > > > >
 > > > > If the API is this:
 > > > >
 > > > > struct regmap *syscon_regmap_lookup_by_name(struct device_node *np,
 > > > >                                        const char *name,
 > > > >                                        int arg_count, __u32 *out_args)
 > > > >
 > > > > How is 'name' being an entry in syscon-names simpler than
just being the
 > > > > property name? The implementation for the latter would certainly be
 > > > > simpler.
 > > > >
 > > > > It also makes the property unparseable without knowledge outside of the
 > > > > DT (i.e. in the driver). I suppose if the number of cells for
each entry
 > > > > is fixed, we could count the number of syscon-names entries to figure
 > > > > out the stride. But then if one entry needs a lot of cells, then they
 > > > > all have to have padding cells.
 > > >
 > > > Good point. The syscon_regmap_lookup_by_name() interface would
 > > > work just as well when passing a property name compared to
 > > > a name listed in another property, and this would still be more in
 > > > line with what we do on other SoCs.
 > > >
 > >
 > > udx710-modem.dtsi:69:   syscons = <&pmu_apb_regs 0x18 0x2000000>,
 > > udx710-modem.dtsi-70-           <&pmu_apb_regs 0x544 0x1>,
 > > udx710-modem.dtsi-71-           <&aon_apb_regs 0x218 0x7e00>,
 > > udx710-modem.dtsi-72-           <&pmu_apb_regs 0xb0 0x20000>,
 > > udx710-modem.dtsi-73-           <&pmu_apb_regs 0xff 0x100>;
 > > udx710-modem.dtsi:74:   syscon-names = "shutdown", "deepsleep",
"corereset",
 > > udx710-modem.dtsi-75-                  "sysreset", "getstatus";
 >
 > Reset at least has a standard binding.

 You mean the reset-controller binding?
 I have noticed that before.
 Okay, it's time for us to consider to setup it.

 >
 >
 > > ud710.dtsi:1268:        syscons = <&aon_apb_regs
REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PRESENT_32K>,
 > > ud710.dtsi-1269-                  <&aon_apb_regs
REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PROTECT_32K>,
 > > ud710.dtsi-1270-                  <&aon_apb_regs
REG_AON_APB_SDIO0_CTRL_REG
MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_EN_32K>,
 > > ud710.dtsi-1271-                  <&aon_apb_regs
REG_AON_APB_SDIO0_CTRL_REG
MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_THD_32K>;
 > > ud710.dtsi:1272:        syscon-names =  "sd_detect_pol",
 > > ud710.dtsi-1273-                        "sd_hotplug_protect_en",
 > > ud710.dtsi-1274-                        "sd_hotplug_debounce_en",
 > > ud710.dtsi-1275-                        "sd_hotplug_debounce_cn";
 >
 > This looks to me like it should be a single phandle. How many different
 > register layouts across how many SoCs do you need to support?

 Not sure. It's up to the IC designer how to layout their next chip registers.

 For a simple example:

 Chip A:   offset        Chip B:     offset
 -------------------------+----------------------------
 glb-reg0    0x0     |     glb-reg0      0x0
 glb-reg1    0x4     |     a-new-reg     0x4   (newly insert in the
middle of list)
 glb-reg2    0x8     |     glb-reg1      0x8   (same function with A's reg1)
 ....                |     glb-reg2         0xc    (same function with A's reg2)

 So for chip B's driver which is same to chip A, but the offsets are
partly different.
 Earlier we use chip macro to separate them.
 #ifdef CHIP_A
 #define REG1 0x4
 #endif
 #ifdef CHIP_B
 #define REG1 0x8
 #endif
 ......
 That time we also used single phandle like sprd,xxxx-syscon = <&yyy>;
 But these macro will prevent us from building all-in-one kernel image
for different SoCs
 and this also make dtb less powerful -- we can't use multiple dtbs
for different SoCs with a single image --
 although these SoCs are compatible in many drivers.


 >
 > > > The only advantage I can see in having a list of phandle/arg tuples
 > > > rather than a set of properties is that it is a slightly more compact
 > > > representation in source form, but otherwise they should be equivalent
 > >
 > > Yes, I agree.
 > > They are equivalent.
 > >
 > > But sprd SoCs have too many registers and the representation might matter.
 > > Here's some real code from local,
 > >
 > > orca.dtsi:1276:         syscons = <&pmu_apb_regs
REG_PMU_APB_RF_PD_AUDCP_SYS_CFG
MASK_PMU_APB_RF_PD_AUDCP_SYS_FORCE_SHUTDOWN >,
 > > orca.dtsi-1277-                 <&pmu_apb_regs
REG_PMU_APB_RF_PD_AUDCP_AUDDSP_CFG
MASK_PMU_APB_RF_PD_AUDCP_AUDDSP_AUTO_SHUTDOWN_EN>,
 > > orca.dtsi-1278-                 <&pmu_apb_regs
REG_PMU_APB_RF_SLEEP_CTRL MASK_PMU_APB_RF_AUDCP_FORCE_DEEP_SLEEP>,
 > > orca.dtsi-1279-                 <&pmu_apb_regs
REG_PMU_APB_RF_CP_SOFT_RST MASK_PMU_APB_RF_AUDCP_AUDDSP_SOFT_RST>,
 > > orca.dtsi-1280-                 <&pmu_apb_regs
REG_PMU_APB_RF_CP_SOFT_RST MASK_PMU_APB_RF_AUDCP_SYS_SOFT_RST>,
 > > orca.dtsi-1281-                 <&pmu_apb_regs
REG_PMU_APB_RF_SOFT_RST_SEL MASK_PMU_APB_RF_SOFT_RST_SEL>,
 > > orca.dtsi-1282-                 <&pmu_apb_regs
REG_PMU_APB_RF_PWR_STATUS3_DBG MASK_PMU_APB_RF_PD_AUDCP_SYS_STATE>,
 > > orca.dtsi-1283-                 <&pmu_apb_regs
REG_PMU_APB_RF_PWR_STATUS3_DBG MASK_PMU_APB_RF_PD_AUDCP_AUDDSP_STATE>,
 > > orca.dtsi-1284-                 <&pmu_apb_regs
REG_PMU_APB_RF_SLEEP_STATUS MASK_PMU_APB_RF_AUDCP_SLP_STATUS>,
 > > --
 > > orca.dtsi:1288:         syscon-names = "sysshutdown",
"coreshutdown", "deepsleep", "corereset",
 > > orca.dtsi-1289-                 "sysreset", "reset_sel",
"sysstatus", "corestatus", "sleepstatus",
 > > orca.dtsi-1290-                 "bootprotect", "bootvector",
"bootaddress_sel";
 >
 > Again, reset has standard binding.
 >
 > Also consider if you really need to access all of these vs. assuming a
 > fixed mode that the firmware/bootloader sets up.

 I believe most of them are used in kernel suspend/resume process.

 >
 > > ud710.dtsi:1268:        syscons = <&aon_apb_regs
REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PRESENT_32K>,
 > > ud710.dtsi-1269-                  <&aon_apb_regs
REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PROTECT_32K>,
 > > ud710.dtsi-1270-                  <&aon_apb_regs
REG_AON_APB_SDIO0_CTRL_REG
MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_EN_32K>,
 > > ud710.dtsi-1271-                  <&aon_apb_regs
REG_AON_APB_SDIO0_CTRL_REG
MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_THD_32K>;
 > > ud710.dtsi:1272:        syscon-names =  "sd_detect_pol",
 > > ud710.dtsi-1273-                        "sd_hotplug_protect_en",
 > > ud710.dtsi-1274-                        "sd_hotplug_debounce_en",
 > > ud710.dtsi-1275-                        "sd_hotplug_debounce_cn";
 > >
 > > Compare to following,
 > >
 > > sd_hotplug_protect_en-syscon = <&aon_apb_regs
REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PRESENT_32K>;
 > > sd_hotplug_debounce_en-syscon = <&aon_apb_regs
REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PROTECT_32K>;
 > > sd_hotplug_debounce_cn-syscon = <&aon_apb_regs
REG_AON_APB_SDIO0_CTRL_REG
MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_THD_32K>;
 > > .....
 > >
 > > For me, my choice would be the former.
 > > It looks more clear.
 > >
 > > > and agree about this being harder to parse in an automated way.
 > > >
 > > > Orson, do you see any other reason for the combined property?
 > > No other reason.
 > >
 > > > If not, could you respin the series once more with
 > > > syscon_regmap_lookup_by_name() replaced by something like:?
 > > >
 > > > struct regmap *
 > > > syscon_regmap_lookup_args_by_phandle(struct device_node *np,
 > > >                                         const char *property,
 > > >                                         int arg_count, __u32 *out_args)
 > >
 > > I like this idea. syscon_regmap_lookup_by_phandle_args() would be better?
 > >
 > > May I impelement them both?
 >
 > No.

 Okay. I will send patch V3.

 Thanks for your comments!

 BR,
 Orson
 >
 > Rob
