Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11567C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC89F2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="WBxNdLsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLTMqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:46:49 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:60755 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfLTMqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:46:48 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6D56123D1F;
        Fri, 20 Dec 2019 13:46:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1576846005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GrX8218OZlK1OdarzjqvWdw/65Ksoux5IbNS+/y+8TE=;
        b=WBxNdLsKddON8fDuOngYT9aWaqD8OK10kkTHtAcjAiHlYv7llsmLpvhqbamS4C1dZQPjBD
        ikjLCAjK28tl/KKgfkgOS8iBDDou6hkY/ifKISm8BpyY2r0GkSsY6F69i2GfMp4A/2HPKP
        3Uq08nQc7zBAb6uwpsEqEMvPyVzL4jc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 20 Dec 2019 13:46:40 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: spi-nor: document new flag
In-Reply-To: <2dfc30a7-3261-d783-8256-f72458a0141b@ti.com>
References: <20191214191943.3679-1-michael@walle.cc>
 <556fe468-0080-ad05-8228-5ff8f1b3dac6@ti.com>
 <af3692dba69e85fa8136ab3d170bef39@walle.cc>
 <2dfc30a7-3261-d783-8256-f72458a0141b@ti.com>
Message-ID: <09f5f76eb49a38c4b2960abe688b2892@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 6D56123D1F
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         NEURAL_HAM(-0.00)[-0.742];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

Am 2019-12-19 06:33, schrieb Vignesh Raghavendra:
> Hi Michael,
> 
> [...]
>>>> +- no-unlock : By default, linux unlocks the whole flash because 
>>>> there
>>>> +           are legacy flash devices which are locked by default
>>>> +           after reset. Set this flag if you don't want linux to
>>>> +           unlock the whole flash automatically. In this case you
>>>> +           can control the non-volatile bits by the
>>>> +           flash_lock/flash_unlock tools.
>>>> 
>>> 
>>> Current SPI NOR framework unconditionally unlocks entire flash which
>>> I agree is not the best thing to do, but I don't think we need
>>> new DT property here. MTD cmdline partitions and DT partitions 
>>> already
>>> provide a way to specify that a partition should remain locked[1][2]
>> 
>> I know that the MTD layer has the same kind of unlocking. But that
>> unlocking is done on a per mtd partition basis. Eg. consider something
>> like the following
>> 
>>  mtd1 bootloader  (locked)
>>  mtd2 firmware    (locked)
>>  mtd3 kernel
>>  mtd4 environment
>> 
>> Further assume, that the end of mtd2 aligns with one of the possible
>> locking areas which are supported by the flash chip. Eg. the first 
>> quarter.
>> 
>> The mtd layer would do two (or four, if "lock" property is set) 
>> unlock()
>> calls, one for mtd1 and one for mtd2.
>> 
> 
> 
>> My point here is, that the mtd partitions doesn't always map to the
>> locking regions of the SPI flash (at least if the are not merged 
>> together).
>> 
> 
> You are right! This will be an issue if existing partitions are not
> aligned to locking regions.
> 
> I take my comments back... But I am not sure if a new DT property is 
> the
> needed. This does not describe HW and is specific to Linux SPI NOR
> stack. How about a module parameter instead?
> Module parameter won't provide per flash granularity in controlling
> unlocking behavior. But I don't think that matters.

I don't argue against having a kernel parameter, but just wanting to 
point
out another alternative (which might be controversial):

  - What is the purpose of this unlock_all() at all. Apparently there are
    some flashes which have the protection bits set. Either at startup
    (and then they are non-volatile) or they come in that state out of 
the
    factory. The latter makes little sense IMHO.

  - Actually, all newer flashes we've used have these bits non-volatile 
and
    are unlocked by default.

So can't we have a whitelist (ie. a new flag in the spi_nor_ids) which
supresses the unlock if they haven't any block protections bit set
according to the manual? Because in this case the unlocking makes never
sense IMHO.

-michael

> 
> Tudor,
> 
> You had a patch doing something similar. Does module param sound good 
> to
> you?
