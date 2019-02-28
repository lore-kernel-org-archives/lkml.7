Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA07820C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367507;
	bh=TLqtuwEwMi9F4V3x2iZGUvT6WDfvwMQUPvcRj9t4V08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=diyNnWmiZrfDsJ1z5iKJ2GYJ2DFRtux/UKQu7VH6l1yOppRaIyTl5pwc0Xa2ZpB4m
	 sNZFXDJ/31ZfYmaNCoLXg5rNPRZe6Q8sRyhBnkKDax+VTStXWUKeNF8mh6cyW23T0y
	 Mahb8IzZP4TkGnKCqDHGLN/hPRyzwbeDWW61Mo6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbfB1PZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388195AbfB1PZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:25:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3127120C01;
        Thu, 28 Feb 2019 15:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551367503;
        bh=TLqtuwEwMi9F4V3x2iZGUvT6WDfvwMQUPvcRj9t4V08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJ25LVidrQUEPqQ8tS/f6jjoGzuSr6PKGrFEO7tAg4zpqVynyK4Ltlw0tpoCfUzn3
         JKZx3QC8Lwx+diLuG8BXdtDk4NzxBFuarfb5hWL7GAJrf8PCRjCCYn5Jb61WIIwsr1
         p23nHEL8rbYsZrzYkDFWYNrtz7q6FcH1PJiI59Ms=
Date:   Thu, 28 Feb 2019 16:25:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 34/81] debugfs: return error values, not NULL
Message-ID: <20190228152501.GC8481@kroah.com>
References: <20190228150813.10256-1-sashal@kernel.org>
 <20190228150813.10256-34-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228150813.10256-34-sashal@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:07:26AM -0500, Sasha Levin wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [ Upstream commit ff9fb72bc07705c00795ca48631f7fffe24d2c6b ]
> 
> When an error happens, debugfs should return an error pointer value, not
> NULL.  This will prevent the totally theoretical error where a debugfs
> call fails due to lack of memory, returning NULL, and that dentry value
> is then passed to another debugfs call, which would end up succeeding,
> creating a file at the root of the debugfs tree, but would then be
> impossible to remove (because you can not remove the directory NULL).
> 
> So, to make everyone happy, always return errors, this makes the users
> of debugfs much simpler (they do not have to ever check the return
> value), and everyone can rest easy.
> 
> Reported-by: Gary R Hook <ghook@amd.com>
> Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Michal Hocko <mhocko@kernel.org>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/debugfs/inode.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)

As much as I would love to backport this patch, no, please do not, I did
not mark it for stable on purpose.  It can cause regressions with code
that is not expecting this behavior (I have a fix that needs to go into
5.0 for this very reason.)

Please drop it from all queues.

thanks,

greg k-h
