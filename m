Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120C4C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CE122464
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Dxe/rhD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfKSU35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:29:57 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17817 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:29:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd450c20000>; Tue, 19 Nov 2019 12:29:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Nov 2019 12:29:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Nov 2019 12:29:53 -0800
Received: from [10.2.175.254] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 20:29:51 +0000
Subject: Re: [PATCH v1 04/17] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <tglx@linutronix.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-5-git-send-email-skomatineni@nvidia.com>
 <d072bd37-9628-4eb2-1706-a1f640606b8d@gmail.com>
 <d76f4689-5986-9239-9c67-9dd125f6547e@nvidia.com>
Message-ID: <7d01a1cb-1e40-9c4f-f68c-c1b25b775f18@nvidia.com>
Date:   Tue, 19 Nov 2019 12:29:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d76f4689-5986-9239-9c67-9dd125f6547e@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574195394; bh=OS3Yt0Ll6x3Cu7osIW+X35SFkMoPMYcvEfMLe8DyliM=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Dxe/rhD+vS7WgFAt2B8sAAMGVD5+3mxXiCZqrMER73pXqtJwg53GRo8UKzxEgd4uC
         BAmetIYtREstnl903dvSXR3QK/wORkisTFFGWD1PkIYJrSlT9d/tM0OwhWIn1QqQom
         28OP2z5TjjiHEJDu54uo0f/aCA2mvOEpQ1kU+NWfdeGv5bVZdOe7l6G9ma7QvvjDuX
         rFHEO8W5DE10RTk6Ok3ZGGK2jrpstuBS81E+OxmUKYjr8E+JbF5JoXpBWOMHwOTS8K
         amRccInXzf1d0hq3r343Hww3VYtsvsZHtSFRedHIxMGeiYXFGcgXAp3PRTyl7t5fSa
         Rw6i6v8nkyxZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/19/19 12:08 PM, Sowjanya Komatineni wrote:
>
> On 11/19/19 11:33 AM, Dmitry Osipenko wrote:
>> 19.11.2019 09:50, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 with mux and gate for
>>> each of these clocks.
>>>
>>> Currently these PMC clocks are registered by Tegra clock driver using
>>> clk_register_mux and clk_register_gate by passing PMC base address
>>> and register offsets and PMC programming for these clocks happens
>>> through direct PMC access by the clock driver.
>>>
>>> With this, when PMC is in secure mode any direct PMC access from the
>>> non-secure world does not go through and these clocks will not be
>>> functional.
>>>
>>> This patch adds these clocks registration with PMC as a clock provider
>>> for these clocks. clk_ops callback implementations for these clocks
>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC=20
>>> programming
>>> in secure mode and non-secure mode.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>> =C2=A0 drivers/soc/tegra/pmc.c | 330=20
>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 1 file changed, 330 insertions(+)
>>>
>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>> index 7a5aab0b993b..790a6619ba32 100644
>>> --- a/drivers/soc/tegra/pmc.c
>>> +++ b/drivers/soc/tegra/pmc.c
>>> @@ -13,6 +13,9 @@
>>> =C2=A0 =C2=A0 #include <linux/arm-smccc.h>
>>> =C2=A0 #include <linux/clk.h>
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/clkdev.h>
>>> +#include <linux/clk/clk-conf.h>
>>> =C2=A0 #include <linux/clk/tegra.h>
>>> =C2=A0 #include <linux/debugfs.h>
>>> =C2=A0 #include <linux/delay.h>
>>> @@ -48,6 +51,7 @@
>>> =C2=A0 #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>>> =C2=A0 #include <dt-bindings/gpio/tegra186-gpio.h>
>>> =C2=A0 #include <dt-bindings/gpio/tegra194-gpio.h>
>>> +#include <dt-bindings/soc/tegra-pmc.h>
>>> =C2=A0 =C2=A0 #define PMC_CNTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0
>>> =C2=A0 #define=C2=A0 PMC_CNTRL_INTR_POLARITY=C2=A0=C2=A0=C2=A0 BIT(17) =
/* inverts INTR=20
>>> polarity */
>>> @@ -108,6 +112,7 @@
>>> =C2=A0 #define PMC_WAKE2_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x168
>>> =C2=A0 #define PMC_SW_WAKE2_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x16c
>>> =C2=A0 +#define PMC_CLK_OUT_CNTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1a8
>>> =C2=A0 #define PMC_SATA_PWRGT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x1ac
>>> =C2=A0 #define PMC_SATA_PWRGT_PLLE_IDDQ_VALUE BIT(5)
>>> =C2=A0 #define PMC_SATA_PWRGT_PLLE_IDDQ_SWCTL BIT(4)
>>> @@ -170,6 +175,78 @@
>>> =C2=A0 #define=C2=A0 TEGRA_SMC_PMC_READ=C2=A0=C2=A0=C2=A0 0xaa
>>> =C2=A0 #define=C2=A0 TEGRA_SMC_PMC_WRITE=C2=A0=C2=A0=C2=A0 0xbb
>>> =C2=A0 +struct pmc_clk_mux {
>>> +=C2=A0=C2=A0=C2=A0 struct clk_hw=C2=A0=C2=A0=C2=A0 hw;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0 offs;
>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask;
>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift=
;
>>> +=C2=A0=C2=A0=C2=A0 /* register lock */
>>> +=C2=A0=C2=A0=C2=A0 spinlock_t=C2=A0=C2=A0=C2=A0 *lock;
>>> +};
>>> +
>>> +#define to_pmc_clk_mux(_hw) container_of(_hw, struct pmc_clk_mux, hw)
>>> +
>>> +struct pmc_clk_gate {
>>> +=C2=A0=C2=A0=C2=A0 struct clk_hw=C2=A0=C2=A0=C2=A0 hw;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0 offs;
>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift=
;
>>> +=C2=A0=C2=A0=C2=A0 /* register lock */
>>> +=C2=A0=C2=A0=C2=A0 spinlock_t=C2=A0=C2=A0=C2=A0 *lock;
>>> +};
>>> +
>>> +#define to_pmc_clk_gate(_hw) container_of(_hw, struct pmc_clk_gate,=20
>>> hw)
>>> +
>>> +struct pmc_clk_init_data {
>>> +=C2=A0=C2=A0=C2=A0 char *mux_name;
>>> +=C2=A0=C2=A0=C2=A0 char *gate_name;
>>> +=C2=A0=C2=A0=C2=A0 const char **parents;
>>> +=C2=A0=C2=A0=C2=A0 int num_parents;
>>> +=C2=A0=C2=A0=C2=A0 int mux_id;
>>> +=C2=A0=C2=A0=C2=A0 int gate_id;
>>> +=C2=A0=C2=A0=C2=A0 char *dev_name;
>>> +=C2=A0=C2=A0=C2=A0 u8 mux_shift;
>>> +=C2=A0=C2=A0=C2=A0 u8 gate_shift;
>>> +=C2=A0=C2=A0=C2=A0 u8 init_parent;
>>> +=C2=A0=C2=A0=C2=A0 int init_state;
>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_mux mux;
>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_gate gate;
>>> +};
>>> +
>>> +#define PMC_CLK(_num, _mux_shift, _gate_shift, _init_parent,=20
>>> _init_state)\
>>> +=C2=A0=C2=A0=C2=A0 {\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_name =3D "clk_out_" #_=
num "_mux",\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_name =3D "clk_out_" #=
_num,\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parents =3D clk_out ##_num=
 ##_parents,\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D ARRAY_SIZE=
(clk_out ##_num ##_parents),\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_id =3D TEGRA_PMC_CLK_O=
UT_ ##_num ##_MUX,\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_id =3D TEGRA_PMC_CLK_=
OUT_ ##_num,\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_name =3D "extern" #_nu=
m,\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_shift =3D _mux_shift,\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_shift =3D _gate_shift=
,\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_parent =3D _init_pare=
nt,\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_state =3D _init_state=
,\
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +static DEFINE_SPINLOCK(clk_out_lock);
>>> +
>>> +static const char *clk_out1_parents[] =3D { "clk_m", "clk_m_div2",
>>> +=C2=A0=C2=A0=C2=A0 "clk_m_div4", "extern1",
>>> +};
>>> +
>>> +static const char *clk_out2_parents[] =3D { "clk_m", "clk_m_div2",
>>> +=C2=A0=C2=A0=C2=A0 "clk_m_div4", "extern2",
>>> +};
>>> +
>>> +static const char *clk_out3_parents[] =3D { "clk_m", "clk_m_div2",
>>> +=C2=A0=C2=A0=C2=A0 "clk_m_div4", "extern3",
>>> +};
>> Why these are unused?
> They are used in PMC_CLK macro
>>
>>> +static struct pmc_clk_init_data tegra_pmc_clks_data[] =3D {
>>> +=C2=A0=C2=A0=C2=A0 PMC_CLK(1, 6, 2, 3, 1),
>>> +=C2=A0=C2=A0=C2=A0 PMC_CLK(2, 14, 10, 0, 0),
>>> +=C2=A0=C2=A0=C2=A0 PMC_CLK(3, 22, 18, 0, 0),
>>> +};
>>> +
>>> =C2=A0 struct tegra_powergate {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct generic_pm_domain genpd;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tegra_pmc *pmc;
>>> @@ -279,6 +356,9 @@ struct tegra_pmc_soc {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct tegra_wake_event *wake_even=
ts;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int num_wake_events;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_init_data *pmc_clks_data;
>>> +=C2=A0=C2=A0=C2=A0 unsigned int num_pmc_clks;
>>> =C2=A0 };
>>> =C2=A0 =C2=A0 static const char * const tegra186_reset_sources[] =3D {
>>> @@ -2299,6 +2379,241 @@ static int tegra_pmc_clk_notify_cb(struct=20
>>> notifier_block *nb,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NOTIFY_OK;
>>> =C2=A0 }
>>> =C2=A0 +static void pmc_clk_fence_udelay(u32 offset)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_readl(pmc, offset);
>>> +=C2=A0=C2=A0=C2=A0 /* pmc clk propagation delay 2 us */
>>> +=C2=A0=C2=A0=C2=A0 udelay(2);
>>> +}
>>> +
>>> +static u8 pmc_clk_mux_get_parent(struct clk_hw *hw)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_mux *mux =3D to_pmc_clk_mux(hw);
>>> +=C2=A0=C2=A0=C2=A0 int num_parents =3D clk_hw_get_num_parents(hw);
>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, mux->offs) >> mux->shi=
ft;
>>> +=C2=A0=C2=A0=C2=A0 val &=3D mux->mask;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (val >=3D num_parents)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return val;
>>> +}
>>> +
>>> +static int pmc_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_mux *mux =3D to_pmc_clk_mux(hw);
>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long flags =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(mux->lock, flags);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, mux->offs);
>>> +=C2=A0=C2=A0=C2=A0 val &=3D ~(mux->mask << mux->shift);
>>> +=C2=A0=C2=A0=C2=A0 val |=3D index << mux->shift;
>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, val, mux->offs);
>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_fence_udelay(mux->offs);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(mux->lock, flags);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static const struct clk_ops pmc_clk_mux_ops =3D {
>>> +=C2=A0=C2=A0=C2=A0 .get_parent =3D pmc_clk_mux_get_parent,
>>> +=C2=A0=C2=A0=C2=A0 .set_parent =3D pmc_clk_mux_set_parent,
>>> +=C2=A0=C2=A0=C2=A0 .determine_rate =3D __clk_mux_determine_rate,
>>> +};
>>> +
>>> +static struct clk *
>>> +tegra_pmc_clk_mux_register(const char *name, const char * const=20
>>> *parent_names,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int num_parents, unsigned long flags,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct pmc_clk_mux *mux, unsigned long offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 u32 shift, u32 mask, spinlock_t *lock)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct clk_init_data init;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
>>> +=C2=A0=C2=A0=C2=A0 if (!mux)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENOMEM);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 init.name =3D name;
>>> +=C2=A0=C2=A0=C2=A0 init.ops =3D &pmc_clk_mux_ops;
>>> +=C2=A0=C2=A0=C2=A0 init.parent_names =3D parent_names;
>>> +=C2=A0=C2=A0=C2=A0 init.num_parents =3D num_parents;
>>> +=C2=A0=C2=A0=C2=A0 init.flags =3D flags;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mux->hw.init =3D &init;
>>> +=C2=A0=C2=A0=C2=A0 mux->offs =3D offset;
>>> +=C2=A0=C2=A0=C2=A0 mux->mask =3D mask;
>>> +=C2=A0=C2=A0=C2=A0 mux->shift =3D shift;
>>> +=C2=A0=C2=A0=C2=A0 mux->lock =3D lock;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return clk_register(NULL, &mux->hw);
>>> +}
>>> +
>>> +static int pmc_clk_is_enabled(struct clk_hw *hw)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_gate *gate =3D to_pmc_clk_gate(hw);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return tegra_pmc_readl(pmc, gate->offs) & BIT(gate-=
>shift) ? 1=20
>>> : 0;
>>> +}
>>> +
>>> +static void pmc_clk_set_state(struct clk_hw *hw, int state)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_gate *gate =3D to_pmc_clk_gate(hw);
>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long flags =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(gate->lock, flags);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, gate->offs);
>>> +=C2=A0=C2=A0=C2=A0 val =3D state ? (val | BIT(gate->shift)) : (val &=20
>>> ~BIT(gate->shift));
>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, val, gate->offs);
>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_fence_udelay(gate->offs);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(gate->lock, flags);
>>> +}
>>> +
>>> +static int pmc_clk_enable(struct clk_hw *hw)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_set_state(hw, 1);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static void pmc_clk_disable(struct clk_hw *hw)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_set_state(hw, 0);
>>> +}
>>> +
>>> +static const struct clk_ops pmc_clk_gate_ops =3D {
>>> +=C2=A0=C2=A0=C2=A0 .is_enabled =3D pmc_clk_is_enabled,
>>> +=C2=A0=C2=A0=C2=A0 .enable =3D pmc_clk_enable,
>>> +=C2=A0=C2=A0=C2=A0 .disable =3D pmc_clk_disable,
>>> +};
>>> +
>>> +static struct clk *
>>> +tegra_pmc_clk_gate_register(const char *name, const char *parent_name,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 unsigned long flags, struct pmc_clk_gate *gate,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 unsigned long offset, u32 shift, spinlock_t *lock)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct clk_init_data init;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
>>> +=C2=A0=C2=A0=C2=A0 if (!gate)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENOMEM);
>> Why *gate is a function argument?
> for storing corresponding gate register info to use for gate clk_ops

I had gate and mux as members of pmc_clk_init_data.

Actually we don't need that so will remove it and also passing argument=20
in next version

>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 init.name =3D name;
>>> +=C2=A0=C2=A0=C2=A0 init.ops =3D &pmc_clk_gate_ops;
>>> +=C2=A0=C2=A0=C2=A0 init.parent_names =3D &parent_name;
>>> +=C2=A0=C2=A0=C2=A0 init.num_parents =3D 1;
>>> +=C2=A0=C2=A0=C2=A0 init.flags =3D flags;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 gate->hw.init =3D &init;
>>> +=C2=A0=C2=A0=C2=A0 gate->offs =3D offset;
>>> +=C2=A0=C2=A0=C2=A0 gate->shift =3D shift;
>>> +=C2=A0=C2=A0=C2=A0 gate->lock =3D lock;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return clk_register(NULL, &gate->hw);
>>> +}
>> [snip]
