Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A27520883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbfDARqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:46:31 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36606 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbfDARqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554140786; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpB3gNb95F/GGonib/43haMZjqG4EA7j6bKVwvf3yHw=;
        b=FhcSGzqToDa+k+S2M2FyE0LdWj/2OO8k19XMV9rR2sZyU6oEOe3gxjcSzFNl5JuvvIq7RL
        xYDfntTgSJH0dZmFS+vuyhVqQXRVOnYNMQgEGxNMYW4BFQBKzEmvRhB3U1gxGuY8NOlisW
        LjMJS5RRlDd5++yc2W9ff6Dw87wqKzg=
Date:   Mon, 01 Apr 2019 19:46:22 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: musb: Force-disable pullup on shutdown
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, od@zcrc.me
Message-Id: <1554140782.10471.0@crapouillou.net>
In-Reply-To: <20190401171725.GK25852@uda0271908>
References: <20190321144246.3547-1-paul@crapouillou.net>
        <20190401171725.GK25852@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 1 avril 2019 =E0 19:17, Bin Liu <b-liu@ti.com> a =E9crit :
> On Thu, Mar 21, 2019 at 03:42:46PM +0100, Paul Cercueil wrote:
>>  When the musb is shutdown, for instance when the driver is unloaded,
>>  force-disable the pullup. Otherwise, the host will still see the=20
>> gadget
>>  device even after the shutdown.
>=20
> how would this happen?
>=20
> when musb-hdrc driver is unloaded, udc core removes the bound gadget
> driver which calls musb_gadget_pullup() to disable the pullup.

I'm testing with the jz4740-musb driver. I don't unload the module (it's
built-in) but unbind it from sysfs.

> Regards,
> -Bin.

=

