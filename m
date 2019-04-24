Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ED9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21195218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125336;
	bh=I0l476XyVzeji+kfFkiTE/STPvHXToQQfFFwfxuBYrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0dE3TMRXyLYurB2b1OPLthw+g4mracD5R11xxyT20SsQGTZTWeU2BNtdXBVXLzp3I
	 PfOs+WVaWin23nA+U+jwMy/yeADsdQmiApI1bMbLTfi993ochosRU/olWjnCP8rU/O
	 bOLBNAW0lon37N5IMRyBLrzXgOIf8NniIR7eoe0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbfDXRCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730844AbfDXRCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:02:14 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F00602148D;
        Wed, 24 Apr 2019 17:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125333;
        bh=I0l476XyVzeji+kfFkiTE/STPvHXToQQfFFwfxuBYrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PkAtPdFuy5Bm1qOz2bZvKvkXVgOYz4xHJQC0liUOHKoSJml5QNFUH5j3iYOTuTOai
         6aDXoGVOKew4ZAZfjgecThv3cxbCgtaCb/e/GiQ1wcQJQA1hHrRNErnh6X4hJ90Rcj
         sUZTHghsO427NjnZSHSrhTgUrDvB11K8EJVf7Hzk=
Date:   Wed, 24 Apr 2019 19:02:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 5.0 59/66] fs: stream_open - opener for
 stream-like files so that read and write can run simultaneously without
 deadlock
Message-ID: <20190424170211.GA4253@kroah.com>
References: <20190424143341.27665-1-sashal@kernel.org>
 <20190424143341.27665-59-sashal@kernel.org>
 <20190424163415.GB21413@kroah.com>
 <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:40:53AM -0700, Linus Torvalds wrote:
> On Wed, Apr 24, 2019 at 9:34 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > I think there is a follow-on patch for this one as well, that adds the
> > proper "stream open" logic to all of the individual locations.
> 
> That bulk one hasn't been applied yet, and wouldn't be appropriate for
> stable anyway. It's 5.2 material.

Ah, ok.

> But...
> 
> > But even with that, I don't think this is stable material, it should
> > just be for 5.1 and newer kernels.
> 
> We likely *will* have a fuse-only patch that uses stream_open() and
> _will_ be marked for stable, but that hasn't actually happened yet
> either. But if/when that happens, then this infrastructure patch will
> indeed be needed in stable.

Ok, I'll add this to my list of things to apply sometime in the future
when it shows up.

thanks,

greg k-h
