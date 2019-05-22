Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1E5C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECFA217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ePCxXmvL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="C9wSUhPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfEVCnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 22:43:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59832 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfEVCnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 22:43:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AD8D15C70D;
        Tue, 21 May 2019 22:43:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=f1aVdB0GW/xbTEb9TCQThuKnddE=; b=ePCxXm
        vL1oVvrRySOJd9Zui1dj+EN/XNkQr3DLSTT7PEJnYdbMC9+4XRW9DdkxffIgmv9f
        gn7ha1b+MfSwvf3F+lx9Sn3OhJRJuKJt8GswrofK5AMVudjdZ4IfPc/LL6otILDp
        5yxgTXuLO1TS9f/HZrDFZxb447UynC6EovCl8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 021DB15C70C;
        Tue, 21 May 2019 22:43:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=HoxQRB22GIbOcLcVnjiMCS108F1Dfhfhq6HyGAkQViM=; b=C9wSUhPfFMm4ZmPLN4PEKcIGKEOdPeP6sVTQaXAoku0R14M0EjJGuZc+ke8vENXcLaBaiuO3m/JdydfkEqVcOkAuuw7994Q1CnhkcC1z5v5VSEADKT34mPIPpxAjhR4lWMGzoN1jtl+VvdlWkLyilydUuqBUQZlflV7mRTCAknk=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E69715C70B;
        Tue, 21 May 2019 22:43:12 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 56FA02DA01D5;
        Tue, 21 May 2019 22:43:11 -0400 (EDT)
Date:   Tue, 21 May 2019 22:43:11 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Gen Zhang <blackgod016574@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
In-Reply-To: <20190521073901.GF5263@zhanggen-UX430UQ>
Message-ID: <nycvar.YSQ.7.76.1905212218090.1558@knanqh.ubzr>
References: <20190521022940.GA4858@zhanggen-UX430UQ> <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr> <20190521030905.GB5263@zhanggen-UX430UQ> <nycvar.YSQ.7.76.1905202323290.1558@knanqh.ubzr> <20190521040019.GD5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905210022050.1558@knanqh.ubzr> <20190521073901.GF5263@zhanggen-UX430UQ>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 5765B69E-7C3B-11E9-935B-46F8B7964D18-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Gen Zhang wrote:

> On Tue, May 21, 2019 at 12:30:38AM -0400, Nicolas Pitre wrote:
> > Now imagine that MIN_NR_CONSOLES is defined to 10 instead of 1.
> > 
> > What happens with allocated memory if the err_vc condition is met on the 
> > 5th loop?
> Yes, vc->vc_screenbuf from the last loop is still not freed, right? I
> don't have idea to solve this one. Could please give some advice? Since
> we have to consider the err_vc condition.
> 
> > If err_vc_screenbuf condition is encountered on the 5th loop (curcons = 
> > 4), what is the value of vc_cons[4].d? Isn't it the same as vc that you 
> > just freed?
> > 
> > 
> > Nicolas
> Thanks for your explaination! You mean a double free situation may 
> happen, right? But in vc_allocate() there is also such a kfree(vc) and 
> vc_cons[currcons].d = NULL operation. This situation is really confusing
> me.

What you could do is something that looks like:

	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
		vc_cons[currcons].d = vc = kzalloc(...);
		if (!vc)
			goto fail1;
		...
		vc->vc_screenbuf = kzalloc(...);
		if (!vc->vc_screenbuf)
			goto fail2;
		...

	return 0;

	/* free already allocated memory on error */
fail1:
	while (curcons > 0) {
		curcons--;
		kfree(vc_cons[currcons].d->vc_screenbuf);
fail2:
		kfree(vc_cons[currcons].d);
		vc_cons[currcons].d = NULL;
	}
	console_unlock();
	return -ENOMEM;


Nicolas
