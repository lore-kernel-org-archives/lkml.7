Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8992BC4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564C7222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568833675;
	bh=H5xd1JLuc+KZZgyxsViY02joXajgujuuU9AlQi7B7bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kyp4yCF13WTMI2kGOP/o2k+IG8/i9C3hOBp8W2EO5zeNT9k5CGHtUrU3wQFOa2HcV
	 pKLNwb11D8WaoCjMLqrqsfAcOhhVjIg0Eh+SmSmmNVG509wi5l4vJm7AFmAAGz4arI
	 NUKjwDP40GGDf3boLCLYPY4/FudortCatasHYRbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfIRTHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfIRTHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:07:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AA4D222CD;
        Wed, 18 Sep 2019 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568833672;
        bh=H5xd1JLuc+KZZgyxsViY02joXajgujuuU9AlQi7B7bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOVbDWSWgtkE648/8vlwK+lwARn1/XB9zYPBqUJeWUDo7jvDaQMkI9LH2BDGBmCxO
         L9j9LC6nTOL8tI3SLN8nRWFBBir9iakxAIZ/eYtY/kZ3N3XClGROKyVMXhPo4cidHm
         4MPvsakJyUF3zuKJl9mlB2s98Je6rM+tVMTXy19A=
Date:   Wed, 18 Sep 2019 21:07:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <20190918190748.GA2014907@kroah.com>
References: <20190918170952.GT2596@sirena.co.uk>
 <20190918185257.GC1933777@kroah.com>
 <CAHk-=whreYmsU_AQtzDS5gd3yamYJ72gBo+YekYSyJLPQ1Qo-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whreYmsU_AQtzDS5gd3yamYJ72gBo+YekYSyJLPQ1Qo-A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 12:03:17PM -0700, Linus Torvalds wrote:
> On Wed, Sep 18, 2019 at 11:53 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Sep 18, 2019 at 06:09:52PM +0100, Mark Brown wrote:
> > >
> > > After merging the driver-core tree, today's linux-next build
> > > for arm64 allmodconfig failed like this:
> >
> > Wait, I thought Linus said this fixup was now resolved.  What went
> > wrong?
> 
> I think this is purely a linux-next build failure.
> 
> I do full allmodconfig builds between each merge I do, and what
> happened is that as part of the LED merge, I removed the
> no-longer-used 'i2c_acpi_find_match_adapter()' to resolve that build
> warning.
> 
> Then linux-next presumably merged my tree with the driver-core tree,
> and that re-instated the use of i2c_acpi_find_match_adapter() - which
> was now gone.
> 
> But when *I* merged the driver-core tree, I did the merge fixup
> correctly to actually re-instate not only the use, but also re-instate
> the removed function that now had a use again.
> 
> > Linus, should I submit a fix for this?
> 
> My tree should be fine, and I really think this is just a temporary
> linux-next effect from the above. I think linux-next only handled the
> actual syntactic conflicts, not the semantic conflict of "function had
> been removed to avoid build error from previous merge, and needed to
> be brought back"
> 
> Knock wood.

I looked at your merge of the driver core tree, and see that the
"missing" function is now back.

And I did a test build here and all works for me, so I think this is ok,
thanks for the fixup.

greg k-h
