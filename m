Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C0AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E3920673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="FUMbx870"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbfJNMHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:07:50 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54070 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730300AbfJNMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:07:50 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D3D205C2968;
        Mon, 14 Oct 2019 14:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1571054868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fGSDKEgEW7BTtJ6OBIYcChc1m09kq3Pb++u8DDpss1k=;
        b=FUMbx870896ZdZPxjyq4W7LVBAjDqlqc5ejZBSky0FJ48m9JvSo2ZoIc1Q7KVs5Ixaf/p1
        L43fFVxgJllKRRQHCuas0Gl19yjPNzoMH/BblCVWfQUDuvKGmjq1UckXJ/GAXuMheVz9/c
        Ka7loV0ooM25DqLB7MgSwaz1fJwu1vs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Oct 2019 14:07:48 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        Stefan Agner <stefan.agner@toradex.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers: firmware: psci: use kernel restart handler
 functionality
In-Reply-To: <20191014100756.GA4028@bogus>
References: <20191012214735.1127009-1-stefan@agner.ch>
 <20191014100756.GA4028@bogus>
Message-ID: <312b244bfacca2f2b3f9b7d7e9462464@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,


On 2019-10-14 12:07, Sudeep Holla wrote:
> On Sat, Oct 12, 2019 at 11:47:35PM +0200, Stefan Agner wrote:
>> From: Stefan Agner <stefan.agner@toradex.com>
>>
>> Use the kernels restart handler to register the PSCI system reset
>> capability. The restart handler use notifier chains along with
>> priorities. This allows to use restart handlers with higher priority
>> (in case available) while still supporting PSCI.
>>
>> Since the ARM handler had priority over the kernels restart handler
>> before this patch, use a slightly elevated priority of 160 to make
>> sure PSCI is used before most of the other handlers are called.
>>
> 
> There's an attempt(rather pull request[1]) to consolidate these into new
> system power/restart handler.

Oh thanks for the pointer! Interesting timing :-)

--
Stefan

> 
> --
> Regards,
> Sudeep
> 
> [1]
> https://lore.kernel.org/linux-arm-kernel/20191002131228.4085560-1-thierry.reding@gmail.com
