Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E1CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154BE2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572564508;
	bh=PBIVho+NsCRnh1duj1FgKfPosLuMmKWV+Ax7lihqGaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BKerU6+HfkWVtVHMtNuiNkaWDX2GmkGSFKTAOtNvxxcf1TAye8jkKdP+WO1PJvETS
	 wPaD86BHrxie7YZb8sbRbUdnNj7Z2TYRsh0n+tjujfIWbgkZWfoOg6ir3dI0FsJMzQ
	 oKbpnP7Li1bg3a1RwzQA44eZLAoqOZOzJ1Wx2RU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfJaX20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 19:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfJaX20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:28:26 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E34AC2086D;
        Thu, 31 Oct 2019 23:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572564506;
        bh=PBIVho+NsCRnh1duj1FgKfPosLuMmKWV+Ax7lihqGaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y7jGEoeqAAEdG8wkoJsNM09wjH7WM7Ye0HkBYw1Zgx9Fs8zFjBRuIvcG2VtctppWL
         dOCPw42Jl+NFLlSxc9Irhco9vXW/+z7XAo+8yPmdzxKaMf+PXZbFrJx0A90OVcfnlq
         gDs9SMtGGmjxRfb6THajuRWXupQTlLp4Zux2BfeI=
Date:   Thu, 31 Oct 2019 16:28:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
Message-Id: <20191031162825.a545a5d4d8567368501769bd@linux-foundation.org>
In-Reply-To: <20191031221602.9375-1-hannes@cmpxchg.org>
References: <20191031221602.9375-1-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019 18:16:02 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Currently, the drop_caches proc file and sysctl read back the last
> value written, suggesting this is somehow a stateful setting instead
> of a one-time command. Make it write-only, like e.g. compact_memory.
> 
> ...
>
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1474,7 +1474,7 @@ static struct ctl_table vm_table[] = {
>  		.procname	= "drop_caches",
>  		.data		= &sysctl_drop_caches,
>  		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> +		.mode		= 0200,
>  		.proc_handler	= drop_caches_sysctl_handler,
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= &four,

hm.

Risk: some (odd) userspace code will break.  Fixable by manually chmodding
it back again.

Reward: very little.

Is the reward worth the risk?
