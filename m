Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21293C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F3520854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCRKnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:43:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59512 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfCRKnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:43:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D228680D;
        Mon, 18 Mar 2019 03:43:51 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 779343F614;
        Mon, 18 Mar 2019 03:43:49 -0700 (PDT)
Date:   Mon, 18 Mar 2019 10:43:43 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     broonie@kernel.org, robh@kernel.org, arnd@arndb.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        benjamin.gaignard@linaro.org, loic.pallardy@st.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH 0/7] Introduce bus domains controller framework
Message-ID: <20190318104343.GA15574@e107155-lin>
References: <20190318100605.29120-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318100605.29120-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:05:58AM +0100, Benjamin Gaignard wrote:
> Bus domains controllers allow to divided system on chip into multiple domains
> that can be used to select by who hardware blocks could be accessed.
> A domain could be a cluster of CPUs (or coprocessors), a range of addresses or
> a group of hardware blocks.
>
> Framework architecture is inspirated by pinctrl framework:
> - a default configuration could be applied before bind the driver
> - configurations could be apllied dynamically by drivers
> - device node provides the bus domains configurations
>
> An example of bus domains controller is STM32 ETZPC hardware block
> which got 3 domains:
> - secure: hardware blocks are only accessible by software running on trust
>   zone.
> - non-secure: hardware blocks are accessible by non-secure software (i.e.
>   linux kernel).
> - coprocessor: hardware blocks are only accessible by the corpocessor.
> Up to 94 hardware blocks of the soc could be managed by ETZPC and
> assigned to one of the three domains.
>

You fail to explain why do we need this in non-secure Linux ?
You need to have solid reasons as why this can't be done in secure
firmware. And yes I mean even on arm32. On platforms with such hardware
capabilities you will need some secure firmware to be running and these
things can be done there. I don't want this enabled for ARM64 at all,
firmware *has to deal* with this.

--
Regards,
Sudeep
