Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87832C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619DF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfDWNz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:55:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56860 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfDWNz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:55:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14B20EBD;
        Tue, 23 Apr 2019 06:55:56 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963583F238;
        Tue, 23 Apr 2019 06:55:53 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:55:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH 0/7] Introduce bus domains controller framework
Message-ID: <20190423135550.GB3892@e107155-lin>
References: <20190318100605.29120-1-benjamin.gaignard@st.com>
 <20190318104343.GA15574@e107155-lin>
 <CA+M3ks6bsiGXCKEQmaFmzBRhWPVhV5wBjVhgyfCa-25DohnsOg@mail.gmail.com>
 <20190423132116.GA3892@e107155-lin>
 <b36d8e3b-926c-11ce-747c-74124c09d13b@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b36d8e3b-926c-11ce-747c-74124c09d13b@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 01:33:19PM +0000, Benjamin GAIGNARD wrote:
>
> On 4/23/19 3:21 PM, Sudeep Holla wrote:
> > On Mon, Mar 18, 2019 at 12:05:54PM +0100, Benjamin Gaignard wrote:
> >> Le lun. 18 mars 2019 à 11:43, Sudeep Holla <sudeep.holla@arm.com> a écrit :
> >>> On Mon, Mar 18, 2019 at 11:05:58AM +0100, Benjamin Gaignard wrote:
> >>>> Bus domains controllers allow to divided system on chip into multiple domains
> >>>> that can be used to select by who hardware blocks could be accessed.
> >>>> A domain could be a cluster of CPUs (or coprocessors), a range of addresses or
> >>>> a group of hardware blocks.
> >>>>
> >>>> Framework architecture is inspirated by pinctrl framework:
> >>>> - a default configuration could be applied before bind the driver
> >>>> - configurations could be apllied dynamically by drivers
> >>>> - device node provides the bus domains configurations
> >>>>
> >>>> An example of bus domains controller is STM32 ETZPC hardware block
> >>>> which got 3 domains:
> >>>> - secure: hardware blocks are only accessible by software running on trust
> >>>>    zone.
> >>>> - non-secure: hardware blocks are accessible by non-secure software (i.e.
> >>>>    linux kernel).
> >>>> - coprocessor: hardware blocks are only accessible by the corpocessor.
> >>>> Up to 94 hardware blocks of the soc could be managed by ETZPC and
> >>>> assigned to one of the three domains.
> >>>>
> >>> You fail to explain why do we need this in non-secure Linux ?
> >>> You need to have solid reasons as why this can't be done in secure
> >>> firmware. And yes I mean even on arm32. On platforms with such hardware
> >>> capabilities you will need some secure firmware to be running and these
> >>> things can be done there. I don't want this enabled for ARM64 at all,
> >>> firmware *has to deal* with this.
> >> We use ETZPC to define if hardware blocks can be used by Cortex A7 or Cortex
> >> M4 (both non-secure) on STM32MP1 SoC, this new framework allow to change
> >> hardware block split at runtime. This could be done even on non-secure world
> >> because their is nothing critical to change hardware blocks users.
> > OK, that's interesting, assuming Cortex M4 execution as non-secure. I would
> > expect otherwise. Even if it's configurable, I would see that happen in
> > secure entity via OPTEE or something similar from non-secure side.
> Your assumption is correct Cortex M4 execution is non-secure.

Sorry if I was not clear. I told Cortex M4 non-secure execution is interesting
as I expected it to be secure.

> >
> > Do you have any documents that I can refer to get the overall security
> > design for such platforms ?
>
> SoC datasheet is here:
>
> https://www.st.com/resource/en/datasheet/stm32mp157a.pdf
>
> with just few words about ETZPC:
>
> 3.14 TrustZone protection controller (ETZPC)
> ETZPC is used to configure TrustZone security of bus masters and slaves with
> programmable-security attributes (securable resources) such as:
> • On-chip SYSRAM with programmable secure region size
> • AHB and APB peripherals to be made secure
> Notice that by default, SYSRAM and peripheral are set to secure access
> only, so, not accessible by non-secure masters such as Cortex-M4 or DMA1/DMA2.
> ETZPC can also allocate peripherals and SRAM to be accessible only by
> the Cortex-M4 and/or DMA1/DMA2. This ensures the safe execution of the
> Cortex-M4 firmware, protected from other masters (e.g. Cortex-A7) unwanted
> accesses.
>
The above statement makes me wonder if Cortex-M4 firmware is really
non-secure, if so why does it need such an isolation from other masters
like Cortex-A7. For me Cortex-M4 is secure and Cortex-A7 can execute
in non-secure hence Cortex-M4 needs to be isolated from Cortex-A7 as
mentioned in the above excerpts from the datasheet.

--
Regards,
Sudeep
