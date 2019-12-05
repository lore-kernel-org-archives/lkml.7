Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D91C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71B52464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575558762;
	bh=JzjNkX/2Nbo6GlblPPluACsjcHZsfz/p6Nojkr11NQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I24QRcHQ0Sr+KE24/GXOnfOuWdy/Sz48CdzIYukio6OUmKgxB8evh5afQ0eH9PqSo
	 Enr6ooE/gyMFdtBHzODzOi9qTwn/kxRkoDSjkQ7Q5fI+3F8zIYqigpWgBDoR5rgI0P
	 BS2XBIVc2HKZCse5oS3z0I6JKiu/6QFjzOaqBWlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfLEPMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:12:40 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44098 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEPMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:12:40 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so2999560oia.11;
        Thu, 05 Dec 2019 07:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ct3cztTVPY5fqFtFxY79enKS5M3PxUPj5Gr6za0FKzc=;
        b=RNRAYxSWpyztyJp4emajf5yG2rj4ydxeUA5TIUulBhEsLpXEsEJRVUih/mbvfMTp2t
         bj6cmhsvRpRprjIZwZax9srD2XVB+8doGDHpZN8zve52FAGK+LP4OGFczpFoBq2QDdw3
         x9eikJ7a7cV+PmdWeB0I669B9pZu+M6Wx1i9lKHU3aImRkCn2lCqvaO1eLjd1VxydMoe
         PvbIYKkA1WQ3Y/iWKcsG1duFr8QVN/TiV21npghlgUio9ukH3Zu+gYTAejHwXXntoCFR
         mTbBXajcawgIZGc0GK/K3JLptI1w7BZh/+9gdZS+eOXWnRtRrPteUKYz1k4gdeQMm7o/
         1yNg==
X-Gm-Message-State: APjAAAVH3NO+asi2m16qUt5uSC2W5NSSrArhIG1qnPbsrzbrptQo1FFY
        y4Irab6nCVvQTX9w2ldqww==
X-Google-Smtp-Source: APXvYqyEn64lxv2I6QD1cuSgRAQUS0/AMs3S4yVo81pvB0lnM7FD5eedCJJ/HwIkntkujI43KeChfQ==
X-Received: by 2002:a05:6808:996:: with SMTP id a22mr7208327oic.146.1575558759243;
        Thu, 05 Dec 2019 07:12:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m7sm2064241otl.20.2019.12.05.07.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:12:38 -0800 (PST)
Date:   Thu, 5 Dec 2019 09:12:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Orson Zhai <orson.zhai@spreadtrum.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Orson Zhai <orson.zhai@unisoc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kevin.tang@unisoc.com, baolin.wang@unisoc.com,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: syscon: Add syscon-names to refer to
 syscon easily
Message-ID: <20191205151237.GA30195@bogus>
References: <20191120154148.22067-1-orson.zhai@unisoc.com>
 <20191120154148.22067-2-orson.zhai@unisoc.com>
 <20191204163830.GA25135@bogus>
 <CAK8P3a3_r6z6Qk133=4gUzJ0rYmMH7sDDqpEF8ZVXS_bc3OtkQ@mail.gmail.com>
 <20191204192639.GA15786@bogus>
 <CAK8P3a165hqB=5LmMiTPGJxvsSJqrbFf5EC9WnqtFRYFok+xKw@mail.gmail.com>
 <20191205125539.GH21613@lenovo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205125539.GH21613@lenovo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 08:55:39PM +0800, Orson Zhai wrote:
> Hi Arnd & Rob,
> 
> On Thu, Dec 05, 2019 at 10:20:03AM +0100, Arnd Bergmann wrote:
> > On Wed, Dec 4, 2019 at 8:26 PM Rob Herring <robh@kernel.org> wrote:
> > > On Wed, Dec 04, 2019 at 06:00:17PM +0100, Arnd Bergmann wrote:
> > > > On Wed, Dec 4, 2019 at 5:38 PM Rob Herring <robh@kernel.org> wrote:
> >
> > > > I think generally speaking this would be useful for random registers that
> > > > logically belong to one device but are grouped with other unrelated
> > > > registers in a syscon, and that are in a different register offset for
> > > > each chip that has them. Using named properties instead of a list
> > > > of phandle/arg tuples with names is clearly a simpler alternative
> > > > and more like we do it today, but I can also see some API simplification
> > > > with Orson's patch without the binding getting out of hand.
> > >
> > > I understand when a phandle to a syscon is used. That's nothing new.
> > > What's special about Unisoc SoC that needs something new/different?
> > > I saw there's a large number of syscons, but I don't understand what's
> > > in them.
> > >
> > > If the API is this:
> > >
> > > struct regmap *syscon_regmap_lookup_by_name(struct device_node *np,
> > >                                        const char *name,
> > >                                        int arg_count, __u32 *out_args)
> > >
> > > How is 'name' being an entry in syscon-names simpler than just being the
> > > property name? The implementation for the latter would certainly be
> > > simpler.
> > >
> > > It also makes the property unparseable without knowledge outside of the
> > > DT (i.e. in the driver). I suppose if the number of cells for each entry
> > > is fixed, we could count the number of syscon-names entries to figure
> > > out the stride. But then if one entry needs a lot of cells, then they
> > > all have to have padding cells.
> >
> > Good point. The syscon_regmap_lookup_by_name() interface would
> > work just as well when passing a property name compared to
> > a name listed in another property, and this would still be more in
> > line with what we do on other SoCs.
> >
> 
> udx710-modem.dtsi:69:   syscons = <&pmu_apb_regs 0x18 0x2000000>,
> udx710-modem.dtsi-70-           <&pmu_apb_regs 0x544 0x1>,
> udx710-modem.dtsi-71-           <&aon_apb_regs 0x218 0x7e00>,
> udx710-modem.dtsi-72-           <&pmu_apb_regs 0xb0 0x20000>,
> udx710-modem.dtsi-73-           <&pmu_apb_regs 0xff 0x100>;
> udx710-modem.dtsi:74:   syscon-names = "shutdown", "deepsleep", "corereset",
> udx710-modem.dtsi-75-                  "sysreset", "getstatus";

Reset at least has a standard binding.


> ud710.dtsi:1268:        syscons = <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PRESENT_32K>,
> ud710.dtsi-1269-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PROTECT_32K>,
> ud710.dtsi-1270-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_EN_32K>,
> ud710.dtsi-1271-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_THD_32K>;
> ud710.dtsi:1272:        syscon-names =  "sd_detect_pol",
> ud710.dtsi-1273-                        "sd_hotplug_protect_en",
> ud710.dtsi-1274-                        "sd_hotplug_debounce_en",
> ud710.dtsi-1275-                        "sd_hotplug_debounce_cn";

This looks to me like it should be a single phandle. How many different 
register layouts across how many SoCs do you need to support?

> > The only advantage I can see in having a list of phandle/arg tuples
> > rather than a set of properties is that it is a slightly more compact
> > representation in source form, but otherwise they should be equivalent
> 
> Yes, I agree.
> They are equivalent.
> 
> But sprd SoCs have too many registers and the representation might matter.
> Here's some real code from local,
> 
> orca.dtsi:1276:         syscons = <&pmu_apb_regs REG_PMU_APB_RF_PD_AUDCP_SYS_CFG MASK_PMU_APB_RF_PD_AUDCP_SYS_FORCE_SHUTDOWN >,
> orca.dtsi-1277-                 <&pmu_apb_regs REG_PMU_APB_RF_PD_AUDCP_AUDDSP_CFG MASK_PMU_APB_RF_PD_AUDCP_AUDDSP_AUTO_SHUTDOWN_EN>,
> orca.dtsi-1278-                 <&pmu_apb_regs REG_PMU_APB_RF_SLEEP_CTRL MASK_PMU_APB_RF_AUDCP_FORCE_DEEP_SLEEP>,
> orca.dtsi-1279-                 <&pmu_apb_regs REG_PMU_APB_RF_CP_SOFT_RST MASK_PMU_APB_RF_AUDCP_AUDDSP_SOFT_RST>,
> orca.dtsi-1280-                 <&pmu_apb_regs REG_PMU_APB_RF_CP_SOFT_RST MASK_PMU_APB_RF_AUDCP_SYS_SOFT_RST>,
> orca.dtsi-1281-                 <&pmu_apb_regs REG_PMU_APB_RF_SOFT_RST_SEL MASK_PMU_APB_RF_SOFT_RST_SEL>,
> orca.dtsi-1282-                 <&pmu_apb_regs REG_PMU_APB_RF_PWR_STATUS3_DBG MASK_PMU_APB_RF_PD_AUDCP_SYS_STATE>,
> orca.dtsi-1283-                 <&pmu_apb_regs REG_PMU_APB_RF_PWR_STATUS3_DBG MASK_PMU_APB_RF_PD_AUDCP_AUDDSP_STATE>,
> orca.dtsi-1284-                 <&pmu_apb_regs REG_PMU_APB_RF_SLEEP_STATUS MASK_PMU_APB_RF_AUDCP_SLP_STATUS>,
> --
> orca.dtsi:1288:         syscon-names = "sysshutdown", "coreshutdown", "deepsleep", "corereset",
> orca.dtsi-1289-                 "sysreset", "reset_sel", "sysstatus", "corestatus", "sleepstatus",
> orca.dtsi-1290-                 "bootprotect", "bootvector", "bootaddress_sel";

Again, reset has standard binding. 

Also consider if you really need to access all of these vs. assuming a 
fixed mode that the firmware/bootloader sets up.

> ud710.dtsi:1268:        syscons = <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PRESENT_32K>,
> ud710.dtsi-1269-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PROTECT_32K>,
> ud710.dtsi-1270-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_EN_32K>,
> ud710.dtsi-1271-                  <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_THD_32K>;
> ud710.dtsi:1272:        syscon-names =  "sd_detect_pol",
> ud710.dtsi-1273-                        "sd_hotplug_protect_en",
> ud710.dtsi-1274-                        "sd_hotplug_debounce_en",
> ud710.dtsi-1275-                        "sd_hotplug_debounce_cn";
> 
> Compare to following,
> 
> sd_hotplug_protect_en-syscon = <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PRESENT_32K>;
> sd_hotplug_debounce_en-syscon = <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARD_PROTECT_32K>;
> sd_hotplug_debounce_cn-syscon = <&aon_apb_regs REG_AON_APB_SDIO0_CTRL_REG MASK_AON_APB_SDIO0_EMMC_CARDDET_DBNC_THD_32K>;
> .....
> 
> For me, my choice would be the former.
> It looks more clear.
> 
> > and agree about this being harder to parse in an automated way.
> >
> > Orson, do you see any other reason for the combined property?
> No other reason.
> 
> > If not, could you respin the series once more with
> > syscon_regmap_lookup_by_name() replaced by something like:?
> >
> > struct regmap *
> > syscon_regmap_lookup_args_by_phandle(struct device_node *np,
> >                                         const char *property,
> >                                         int arg_count, __u32 *out_args)
> 
> I like this idea. syscon_regmap_lookup_by_phandle_args() would be better?
> 
> May I impelement them both?

No.

Rob
