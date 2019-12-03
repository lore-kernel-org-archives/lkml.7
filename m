Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3326C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8112068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCLqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 06:46:16 -0500
Received: from foss.arm.com ([217.140.110.172]:40882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCLqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:46:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16FCB30E;
        Tue,  3 Dec 2019 03:46:15 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69F083F68E;
        Tue,  3 Dec 2019 03:46:13 -0800 (PST)
Date:   Tue, 3 Dec 2019 11:46:07 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
Message-ID: <20191203114607.GA4171@bogus>
References: <1575281525-1549-1-git-send-email-peng.fan@nxp.com>
 <1575281525-1549-3-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575281525-1549-3-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+Viresh,Arnd)

On Mon, Dec 02, 2019 at 10:14:43AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> This mailbox driver implements a mailbox which signals transmitted data
> via an ARM smc (secure monitor call) instruction. The mailbox receiver
> is implemented in firmware and can synchronously return data when it
> returns execution to the non-secure world again.
> An asynchronous receive path is not implemented.
> This allows the usage of a mailbox to trigger firmware actions on SoCs
> which either don't have a separate management processor or on which such
> a core is not available. A user of this mailbox could be the SCP
> interface.
>

I would like to know all the use-cases for this driver ? Is this only for
SCMI or will this get used with other protocols on the top. I assume the
latter and hence it is preferred to keep this as a mailbox driver.

I am not against this approach but the reason I ask is to avoid duplication.
Viresh has suggested abstraction of transport from SCMI driver to enable
other transports[1]. Couple of transports that I am aware of is this SMC/HVC
and the new(still in-concept) SPCI.

So I am looking for opinions on that approach. Please feel free to comment
here or as part of that patch.

--
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org
