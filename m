Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9424AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F092208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560331469;
	bh=r+Wtx9RxQ8AR8woF+J5gD2DYf54g7vBdtUikWoiXG70=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=txIaPhjjecgc4HwNxK9zQBfEewvvJOva1Im7jpNsSlzmF4/r3aKFl9pIGcH7qreZZ
	 NdYCl+yGVghnrFZq1f8ZZ0LuPSZOeYQo3H2ItSdb3DBCxrruezCwEEeHBhlsfFaklv
	 NEjCZYAvgWXmMcKjj9NR0sevKiu3WOuNSZF1JBvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437337AbfFLJY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbfFLJY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:24:28 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B59A3208C4;
        Wed, 12 Jun 2019 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560331468;
        bh=r+Wtx9RxQ8AR8woF+J5gD2DYf54g7vBdtUikWoiXG70=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CZrStXBpb1jj9NvuVMuap6aXGz3ZsWto+XfE70qKHNeJJpmW6R0Rx10KEmvXr5Egp
         b/jAqg7IDGDKcF90xYU2rn8afAOQg6VlUZflqtVQn1j7TKgNAShjGT9Wvh1l7tizyM
         0TwjQvjrxcKhyPDzRfbWbI61hdexYZcFgsYr+NdQ=
Date:   Wed, 12 Jun 2019 11:24:24 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: Strange regression in hid_llogitech_dj (was: Re: Linux
 5.2-rc4)
In-Reply-To: <14875910.PnJmU55uV6@kreacher>
Message-ID: <nycvar.YFH.7.76.1906121123580.27227@cbobk.fhfr.pm>
References: <CAHk-=wjm7FQxdF=RKa8Xe23CLNNpbGDOACewgo8e-hwDJ8TyQg@mail.gmail.com> <1875376.0DUQQ8o03D@kreacher> <nycvar.YFH.7.76.1906121029350.27227@cbobk.fhfr.pm> <14875910.PnJmU55uV6@kreacher>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019, Rafael J. Wysocki wrote:

> > > hid-logitech-dj is not loaded after a fresh boot, so I need to modprobe it manually and that
> > > appears to be blocking (apparently indefinitely) until terminated with ^C.  But then it turns
> > > out that hid-logitech-dj is there in the list of modules and it is in use (by usbhid) and the
> > > mouse works.
> > 
> > My bad, I should've asked you to test with the complete 'for-5.2/fixes' 
> > branch which contains two reverts [1] [2] that should fix this issue as 
> > well.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-5.2/fixes&id=e0b7f9bc0246bc642d1de2ff3ff133730584c956
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-5.2/fixes&id=f9482dabfd1686987cc6044e06ae0e4c05915518
> 
> Yes, with the two reverts applied in addition to the fix, it all works as expected.

Rafael, thanks a lot for testing. I am sending the pile to Linus today or 
tomorrow latest.

-- 
Jiri Kosina
SUSE Labs

