Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723CDC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C90D2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566826166;
	bh=B8w4oTKAlSq8ZbOEvl/7t4CbtbVqse0prFdJzNbdtPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=04MZy/pehBozjAZpO3cljB3DV0/OoPpyks87KLw+g5gV2Zfva8c3ZDYg5C4S8SxDA
	 3x827RqotUbNiDxdMEBUIYjFZh5XKD87f9avoi9pYAUXJuM4654xC7sylSZE8osjDw
	 aP6ZLzk77RjeCnz6d1nevh4smi4wbkXra8zxCbBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbfHZN3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbfHZN3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:29:24 -0400
Received: from localhost (unknown [89.205.128.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6752053B;
        Mon, 26 Aug 2019 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566826163;
        bh=B8w4oTKAlSq8ZbOEvl/7t4CbtbVqse0prFdJzNbdtPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LaaTm62jYNx2f2wor1dbjtx3gGJgN01k6hNOvw5pBnU2nkirrp7fK+Xvi4BGeIFur
         UOv5YPD0CsjgPZiQe4UBTcrPZLALyMeDCxvLe1Z2BWhPJteMiXrKTnGL+jGrUivXkf
         861K/LXfpYAEvubpifQa+r8rai0lUTXgkVzBuLtk=
Date:   Mon, 26 Aug 2019 15:29:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] /dev/mem: Bail out upon SIGKILL.
Message-ID: <20190826132916.GB12281@kroah.com>
References: <1566825205-10703-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566825205-10703-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 10:13:25PM +0900, Tetsuo Handa wrote:
> syzbot found that a thread can stall for minutes inside read_mem() or
> write_mem() after that thread was killed by SIGKILL [1]. Reading from
> iomem areas of /dev/mem can be slow, depending on the hardware.
> While reading 2GB at one read() is legal, delaying termination of killed
> thread for minutes is bad. Thus, allow reading/writing /dev/mem and
> /dev/kmem to be preemptible and killable.
> 
>   [ 1335.912419][T20577] read_mem: sz=4096 count=2134565632
>   [ 1335.943194][T20577] read_mem: sz=4096 count=2134561536
>   [ 1335.978280][T20577] read_mem: sz=4096 count=2134557440
>   [ 1336.011147][T20577] read_mem: sz=4096 count=2134553344
>   [ 1336.041897][T20577] read_mem: sz=4096 count=2134549248
> 
> Theoretically, reading/writing /dev/mem and /dev/kmem can become
> "interruptible". But this patch chose "killable". Future patch will make
> them "interruptible" so that we can revert to "killable" if some program
> regressed.
> 
> [1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
> ---
>  drivers/char/mem.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

What changed from previous versions?

That goes below the --- line at the very least.

thanks,

greg k-h
