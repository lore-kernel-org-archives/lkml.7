Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0AAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B78F2483A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfE3Tw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 15:52:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59248 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Tw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 15:52:28 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2211E14DA9761;
        Thu, 30 May 2019 12:52:27 -0700 (PDT)
Date:   Thu, 30 May 2019 12:52:26 -0700 (PDT)
Message-Id: <20190530.125226.748439790590538564.davem@davemloft.net>
To:     jakub.kicinski@netronome.com
Cc:     horatiu.vultur@microchip.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: mscc: ocelot: Hardware ofload for
 tc flower filter
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190529151802.19aa82a2@cakuba.netronome.com>
References: <1559125580-6375-1-git-send-email-horatiu.vultur@microchip.com>
        <1559125580-6375-3-git-send-email-horatiu.vultur@microchip.com>
        <20190529151802.19aa82a2@cakuba.netronome.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 May 2019 12:52:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Wed, 29 May 2019 15:18:44 -0700

> On Wed, 29 May 2019 12:26:20 +0200, Horatiu Vultur wrote:
>> +static int ocelot_flower_replace(struct tc_cls_flower_offload *f,
>> +				 struct ocelot_port_block *port_block)
>> +{
>> +	struct ocelot_ace_rule *rule;
>> +	int ret;
>> +
>> +	if (port_block->port->tc.block_shared)
>> +		return -EOPNOTSUPP;
> 
> FWIW since you only support TRAP and DROP actions here (AFAICT) you
> should actually be okay with shared blocks.  The problems with shared
> blocks start when the action is stateful (like act_police), because we
> can't share that state between devices.  But for most actions which just
> maintain statistics, it's fine to allow shared blocks.  HTH

Please update to remove this test Horatiu, thanks.
