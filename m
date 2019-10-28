Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8005CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD2E21479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbfJ1XeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 19:34:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46618 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfJ1XeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:34:19 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6319214BEB445;
        Mon, 28 Oct 2019 16:34:18 -0700 (PDT)
Date:   Mon, 28 Oct 2019 16:34:17 -0700 (PDT)
Message-Id: <20191028.163417.1094349367022411108.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     olteanv@gmail.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, maowenan@huawei.com,
        jakub.kicinski@netronome.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: sja1105: improve NET_DSA_SJA1105_TAS
 dependency
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191025072654.2860705-1-arnd@arndb.de>
References: <20191025072654.2860705-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 28 Oct 2019 16:34:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 25 Oct 2019 09:26:35 +0200

> An earlier bugfix introduced a dependency on CONFIG_NET_SCH_TAPRIO,
> but this missed the case of NET_SCH_TAPRIO=m and NET_DSA_SJA1105=y,
> which still causes a link error:
> 
> drivers/net/dsa/sja1105/sja1105_tas.o: In function `sja1105_setup_tc_taprio':
> sja1105_tas.c:(.text+0x5c): undefined reference to `taprio_offload_free'
> sja1105_tas.c:(.text+0x3b4): undefined reference to `taprio_offload_get'
> drivers/net/dsa/sja1105/sja1105_tas.o: In function `sja1105_tas_teardown':
> sja1105_tas.c:(.text+0x6ec): undefined reference to `taprio_offload_free'
> 
> Change the dependency to only allow selecting the TAS code when it
> can link against the taprio code.
> 
> Fixes: a8d570de0cc6 ("net: dsa: sja1105: Add dependency for NET_DSA_SJA1105_TAS")
> Fixes: 317ab5b86c8e ("net: dsa: sja1105: Configure the Time-Aware Scheduler via tc-taprio offload")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
