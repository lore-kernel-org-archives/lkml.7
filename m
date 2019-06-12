Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9539C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFFA2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JGtoU/Ek";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="hUPL4hXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbfFLOcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:32:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65232 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbfFLOcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:32:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C6E17809F;
        Wed, 12 Jun 2019 10:32:08 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=bOMQaaOm2gKMIqGX2iIXCgseqvA=; b=JGtoU/
        Ek14mXheuKDS8vYJeDozewP8TnNyKPgklm+TD6DytThxtCrKzRXfZcLq5y5Ru+zp
        TzWqUZylSje/68StcZRupW3x62HsNChGRBjOZLaVCrXOfW1rnzDX50yaWRf7SCwZ
        mI571kAcgJN+u1VEXxuxVCT00UbHxNHg4dBno=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 135FA7809E;
        Wed, 12 Jun 2019 10:32:08 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=ossT+PSBWcBxEnICc2cDyEQ5Oy8oKOI11AMP/+LakHA=; b=hUPL4hXeoHn9v2aOMY0srFAEF4RRmpDqQpuOkvXEeD475DSRadF6yx3FsnRXEUEkAA1EXUQsEVVbTa/b2aUU767fj9DADX/5TYLhrgiCDclq88G6SwT58GShTSYxPDw1oQDjt5KFYrbUO5v1f6Y/ufgD2TudPAos/1QmdJPCsCA=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C953B7809D;
        Wed, 12 Jun 2019 10:32:03 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 0AE162DA0205;
        Wed, 12 Jun 2019 10:32:02 -0400 (EDT)
Date:   Wed, 12 Jun 2019 10:32:01 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Gen Zhang <blackgod016574@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>, kilobyte@angband.pl,
        textshell@uchuujin.de, mpatocka@redhat.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vt: fix a missing-check bug in con_init()
In-Reply-To: <20190612134449.GA4015@zhanggen-UX430UQ>
Message-ID: <nycvar.YSQ.7.76.1906121018340.1558@knanqh.ubzr>
References: <20190612131506.GA3526@zhanggen-UX430UQ> <20190612133838.GA7748@kroah.com> <20190612134449.GA4015@zhanggen-UX430UQ>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: D8DD0936-8D1E-11E9-9CA5-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019, Gen Zhang wrote:

> On Wed, Jun 12, 2019 at 03:38:38PM +0200, Greg KH wrote:
> > On Wed, Jun 12, 2019 at 09:15:06PM +0800, Gen Zhang wrote:
> > > In function con_init(), the pointer variable vc_cons[currcons].d, vc and 
> > > vc->vc_screenbuf is allocated by kzalloc(). However, kzalloc() returns 
> > > NULL when fails. Therefore, we should check the return value and handle 
> > > the error.
> > > 
> > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > ---
> > 
> > What changed from v1, v2, and v3?
> Thanks for your timely response. I am not a native English speaker, so
> I am not sure I understand this correctly. Does this mean that I should
> use "v5", rather than "v4"? 

Given that this is your v4 patch, you should list what has changed since 
earlier versions. Greg is asking you to produce a v5 with that 
information added. Obviously, the change from v4 to v5 would be 
something like "added version change information".

> > That always goes below the --- line.
> And I can't see what goes wrong with "---". Could you please make some
> explaination?

The version change information should be put below the --- line in your 
post, not above it. This way it won't be captured in commit log.


Nicolas
