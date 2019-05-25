Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDE6C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 21:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CA920856
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 21:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558820588;
	bh=RSkWc9M4HXsc7P5xgZgm2GYbuJuLKG99DNM5QI2xszs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Qs16O9GgVGOeFCGB5A6YWPEPjYQwYpEyo/ERG4QRJpdKMGDZDWYAlTHsFU+aHqNEz
	 GRfX+Nby5IK/dyLBW2aoP561KFLreHN0GkVqqndxR7k+gnbjtLP2Mw+vrG34itPY1V
	 1bG1fDzlRG8acQF02fvVllJW26S7K3pzyoeMrlKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfEYVnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 17:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfEYVnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 17:43:07 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17D920717;
        Sat, 25 May 2019 21:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558820586;
        bh=RSkWc9M4HXsc7P5xgZgm2GYbuJuLKG99DNM5QI2xszs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qcH5klgZXiIVY3yzZ3y1eFDh75WpT2Eo69UkgFOvGL+a9UoXR4VQGx/af580/7q6s
         82dNlsR9lOhsJucrwvrRl7Ily/sxnI/ahZxXajfHcLo2nxsEj+6tuTMw66DZmfXIM3
         BVS4WSXi3EAYM3JAmPvesPTE7wof+WW4rJKojdm4=
Date:   Sat, 25 May 2019 14:43:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
Message-Id: <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
In-Reply-To: <20190524201817.16509-1-jannh@google.com>
References: <20190524201817.16509-1-jannh@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 22:18:17 +0200 Jann Horn <jannh@google.com> wrote:

> load_flat_shared_library() is broken: It only calls load_flat_file() if
> prepare_binprm() returns zero, but prepare_binprm() returns the number of
> bytes read - so this only happens if the file is empty.

ouch.

> Instead, call into load_flat_file() if the number of bytes read is
> non-negative. (Even if the number of bytes is zero - in that case,
> load_flat_file() will see nullbytes and return a nice -ENOEXEC.)
> 
> In addition, remove the code related to bprm creds and stop using
> prepare_binprm() - this code is loading a library, not a main executable,
> and it only actually uses the members "buf", "file" and "filename" of the
> linux_binprm struct. Instead, call kernel_read() directly.
> 
> Cc: stable@vger.kernel.org
> Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I only found the bug by looking at the code, I have not verified its
> existence at runtime.
> Also, this patch is compile-tested only.
> It would be nice if someone who works with nommu Linux could have a
> look at this patch.

287980e49ffc was three years ago!  Has it really been broken for all
that time?  If so, it seems a good source of freed disk space...

