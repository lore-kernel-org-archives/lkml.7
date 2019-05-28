Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD16C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535E621670
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559059217;
	bh=OYe+1bYcfgwFnqj+mXfudmI+WjDIgbiTQq8j+vun4/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lxPwX87wLXSrDJRLn82twz88ix6wBzdYqVL6lI8htZjp3dhQ1A9ulWmPaWpIiksX4
	 4dGrqQm6CG4X1iGOa6xgk2UJQQGcJdT/iXn74vX0ASVKLBhRdmhnszxOn0JXvUbxc4
	 o2KAVe3Oa30x+kYX0C7O1g1JIAhTOHFFdEHTl47k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfE1QAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfE1QAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:00:16 -0400
Received: from localhost (unknown [8.46.75.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA84E21530;
        Tue, 28 May 2019 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559059215;
        bh=OYe+1bYcfgwFnqj+mXfudmI+WjDIgbiTQq8j+vun4/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzXL7iNBzs5Z9OLqbFsz3v1L2jQz5ZujxrsBgiIdk4R/QOpOkIUpnONHTasrO6TkF
         259VXgp6pkJ/BL/Ne2w7SzdE9wdqtJ+cm+/+aleUkGSGFeKqXXLi4zQm+QAF/o2HWL
         v7XlGErykFSR/fel04zq8W6HCQG4Y9P9yyhy1+rY=
Date:   Tue, 28 May 2019 17:59:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] staging: fieldbus: Fix build error without
 CONFIG_REGMAP_MMIO
Message-ID: <20190528155956.GA21964@kroah.com>
References: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
 <20190528142912.13224-1-yuehaibing@huawei.com>
 <CAGngYiW_hCDPRWao+389BfUH_2sP4S6pL+gteim=kDrnb9UDzQ@mail.gmail.com>
 <3f4c1d4c-656b-8266-38c4-3f7c36a2bd7e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4c1d4c-656b-8266-38c4-3f7c36a2bd7e@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:41:57PM +0800, YueHaibing wrote:
> On 2019/5/28 22:35, Sven Van Asbroeck wrote:
> > On Tue, May 28, 2019 at 10:31 AM YueHaibing <yuehaibing@huawei.com> wrote:
> >>
> >> Fix gcc build error while CONFIG_REGMAP_MMIO is not set
> >>
> > 
> > checkpatch.pl errors remain:
> > 
> > $ ./scripts/checkpatch.pl < ~/Downloads/YueHaibing.eml
> > ERROR: DOS line endings
> > #92: FILE: drivers/staging/fieldbus/anybuss/Kconfig:17:
> > +^Iselect REGMAP_MMIO^M$
> 
> This seems text/plain messages have crlf set when saved as .eml file,
> 
> I do check my v2 patch is not crlf ending, but when save as eml file in
> 
> my thunderbird, it becomes crlf ending.

You all need a better email client, mutt handles this just fine, it's
not a problem on my system with my workflow at all :)

So this patch looks fine to me from a formatting point of view.  But
does it do what it says it does, that's up to Sven...

thanks,

greg k-h
