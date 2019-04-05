Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6A9C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A1320863
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfDES3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:29:08 -0400
Received: from foss.arm.com ([217.140.101.70]:54222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731474AbfDES3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:29:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACFAB168F;
        Fri,  5 Apr 2019 11:29:07 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D96F73F557;
        Fri,  5 Apr 2019 11:29:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
To:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Jose Abreu <jose.abreu@synopsys.com>
Cc:     Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        =?UTF-8?Q?Christoph_M=c3=bcllner?= 
        <christoph.muellner@theobroma-systems.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
 <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
 <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
 <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
 <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
 <78EB27739596EE489E55E81C33FEC33A0B423811@de02wembxa.internal.synopsys.com>
 <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com> <1554245296.1271.0@gmail.com>
 <78EB27739596EE489E55E81C33FEC33A0B4254A0@de02wembxa.internal.synopsys.com>
 <1554305721.1328.0@gmail.com> <1554306954.1328.1@gmail.com>
 <c863f88a-65e2-4093-7cc1-f37e4443b871@arm.com>
 <78EB27739596EE489E55E81C33FEC33A0B44985F@DE02WEMBXB.internal.synopsys.com>
 <1554488052.1193.1@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <85c1d945-d49b-3350-6ff4-a058c5a8c1d7@arm.com>
Date:   Fri, 5 Apr 2019 19:29:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554488052.1193.1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2019 19:14, Leonidas P. Papadakos wrote:
> 
> Seems like snps,txpbl = <0x20> gives me better performance

What's your overall setup? So far with my RK3328 box I've found that 
with an IPv4 link and an MTU of 2000 I have to dial PBL right down to 1 
or 2 (with no-pbl-x8 as well) to prevent Tx stalling, and with the MTU 
bumped up to 3000 it just won't play at any PBL setting...

Robin.
