Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B753FC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5D121734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="HVHMul+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgACJAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:00:34 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:49319 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgACJAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 04:00:31 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C6944230E1;
        Fri,  3 Jan 2020 10:00:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578042029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxest8tMtRZIdMS9+HLvWHLoP9WwYOR1xCl5Hh5xNZQ=;
        b=HVHMul+06/ZqJth5tKFXAnG5dpRCq4qhYeW3NtIHl/pcOfI7lniaAEVLNvdgIL4ZRV/eMq
        9pHtaXe2W30cM+5iMTQ3BfdBfegn/YY2xoQlPYHJQPRSOMvWYZOuIsf63p8cyeDFz5Hra6
        pPajyaQkEQJ0mLNgU90PDN65qrDSUZI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Jan 2020 10:00:27 +0100
From:   Michael Walle <michael@walle.cc>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] clk: fsl-sai: new driver
In-Reply-To: <20200102080929.0EE2C215A4@mail.kernel.org>
References: <20191209233305.18619-1-michael@walle.cc>
 <20191209233305.18619-2-michael@walle.cc>
 <20191224080536.B0C99206CB@mail.kernel.org>
 <91275d33d6a7c9978a2c70545fde38cd@walle.cc>
 <20200102080929.0EE2C215A4@mail.kernel.org>
Message-ID: <6b092a602b3b8cf09160b1dcb4a282e6@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: C6944230E1
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.273];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

>> >> +       parent_name = of_clk_get_parent_name(node, 0);
>> >
>> > Could this use the new way of specifying clk parents so that we don't
>> > have to query DT for parent names and just let the core framework do it
>> > whenever it needs to?
>> 
>> you mean specifying parent_data with .index = 0? Seems like
>> clk_composite
>> does not support this. The parent can only be specified by supplying 
>> the
>> clock names.
>> 
>> I could add that in a separate patch. What do you think about the
>> following new functions, where a driver can use parent_data instead
>> of parent_names.
> 
> I started doing this in
> https://lkml.kernel.org/r/20190830150923.259497-1-sboyd@kernel.org but 
> I
> never got around to the composite clks. Sounds fine to add this new API
> for your use case.

Yeah took me a while to figure out what you've meant by the "new way" ;)
Anyway, I've posted a v3 of this series with the new composite clock 
API.

> 
>> 
>> +struct clk *clk_register_composite_pdata(struct device *dev, const 
>> char
>> *name,
>> +               const struct clk_parent_data *parent_data,
>> +               struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
>> +               struct clk_hw *rate_hw, const struct clk_ops 
>> *rate_ops,
>> +               struct clk_hw *gate_hw, const struct clk_ops 
>> *gate_ops,
>> +               unsigned long flags);

num_parents was missing here. added that in the v3.

-michael
