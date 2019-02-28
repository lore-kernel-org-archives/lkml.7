Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C710C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D46A20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367590;
	bh=YgWFmbL5nUArkImjwXjIATysvgwImQLyFBYDaaUYUek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Anyz45LWpHtZOydoV8ybkiIIIwcOpaN08Z/1ui9lmyXjDPK671KhlUFd/gHNp6ic9
	 h/61QFyV+fkR3lpWFEqBsRsel3+ruY2gReKzsJS1Y+kM8alo+ujKS94HxOXxTrYVkM
	 Sn3AF+QQ3gbiMzWZle/dWpAAd6ex30Ke/ib5Cjrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbfB1P02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:26:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfB1P0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:26:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF7D20C01;
        Thu, 28 Feb 2019 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551367583;
        bh=YgWFmbL5nUArkImjwXjIATysvgwImQLyFBYDaaUYUek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qP+IOunUbb2he6pUnH1y98ckA/z6zMgstDUMyvVJAthMMrHhFE4yak9Uk7TjD3q7M
         bU9mtFnzZJ+Xt6KZFhP/Yonh92kHy/e457se2fUq+LJpULO3yNYmgMaEMU7ZSNU/Sk
         ijfuXrmV4Dg9PbtRpaHUXXRcAGtf71Mt63J+bSqo=
Date:   Thu, 28 Feb 2019 16:26:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH AUTOSEL 4.20 42/81] relay: check return of
 create_buf_file() properly
Message-ID: <20190228152621.GF8481@kroah.com>
References: <20190228150813.10256-1-sashal@kernel.org>
 <20190228150813.10256-42-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228150813.10256-42-sashal@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:07:34AM -0500, Sasha Levin wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [ Upstream commit 2c1cf00eeacb784781cf1c9896b8af001246d339 ]
> 
> If create_buf_file() returns an error, don't try to reference it later
> as a valid dentry pointer.
> 
> This problem was exposed when debugfs started to return errors instead
> of just NULL for some calls when they do not succeed properly.
> 
> Also, the check for WARN_ON(dentry) was just wrong :)
> 
> Reported-by: Kees Cook <keescook@chromium.org>
> Reported-and-tested-by: syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/relay.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Same here as well, please drop this from all queues.

greg k-h
