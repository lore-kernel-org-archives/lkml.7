Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33562C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAB92085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551513445;
	bh=jxJ0TYI72cb/7mo1z3aSC9IxUGZVvyNNKztVduoqyaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GIc/6SJBqn/cAxUKytKbAVBrUZX9+0YF/knBrJK5wpNtTmFDqwG4m9ERWHn5b0Tgk
	 5+qEnZ5GEtc8NqHVYFdpL6BSH94zKW7iHwPwWtlLbZz5uM0zE3pjokx1W6kQoHsTR/
	 NLhSSH6PsiUQIq9gd4pm9RN82OkiZ9p2g5it8Gvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfCBH5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 02:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfCBH5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 02:57:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3197020818;
        Sat,  2 Mar 2019 07:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551513442;
        bh=jxJ0TYI72cb/7mo1z3aSC9IxUGZVvyNNKztVduoqyaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fknQkhdnHVSUsjcrzbIP305tkdKRrcDVkFNw9HhDCPL3hrtL5D2Aqctn2RT14iaeU
         KpSuwdAx5dL7sLhI3CqtoBDkJGz/t/UDocJweoCJB9cQf1HdJdVw6YydHyh+AoyLE1
         X4ru0jJTo9QXO929jw2md7JTwsYaIg/w8SohZvcs=
Date:   Sat, 2 Mar 2019 08:57:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: fix race between munmap() and direct reclaim
Message-ID: <20190302075720.GA18046@kroah.com>
References: <20190301230606.8302-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301230606.8302-1-tkjos@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 03:06:06PM -0800, Todd Kjos wrote:
> An munmap() on a binder device causes binder_vma_close() to be called
> which clears the alloc->vma pointer.
> 
> If direct reclaim causes binder_alloc_free_page() to be called, there
> is a race where alloc->vma is read into a local vma pointer and then
> used later after the mm->mmap_sem is acquired. This can result in
> calling zap_page_range() with an invalid vma which manifests as a
> use-after-free in zap_page_range().
> 
> The fix is to check alloc->vma after acquiring the mmap_sem (which we
> were acquiring anyway) and skip zap_page_range() if it has changed
> to NULL.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---

Any specific commit that this fixes?  And should it be marked for
stable releases?

thanks,

greg k-h
