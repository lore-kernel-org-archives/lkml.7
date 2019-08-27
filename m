Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E85C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77C7214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TXlm0q2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfH0XEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:04:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34559 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfH0XEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:04:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id m10so766341qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=twfAj3jJ2iISvtECbV5aZw57c7oT5wmcKVNF5jtBKzw=;
        b=TXlm0q2xcS7/T/OenFpz5vi4Yo1hovc71pjCHSJFZtpy8c9XUnNxETQI04ONVL0JIb
         xjCg1ybda4kro9E97QJSZSC/ihNDktOyYrdT8R26XLgljCtsNC1Vrq1jHptibE/6c1Nf
         EnImq/F6CeVQdv8DhnroTOVUgpGI4Q53Tzi+7QBPIjjUtOvPjrzPVX/jcKew3UlbKL90
         uUttussOAeggtW9AKfycy76g+BnNBWpDYxb+G9wjbjpqMtDqXs7hiScwYsQlSR3G6afw
         kwtNsqYgOSibPsNyIiq4ivvhuJDj/CXdeSuB6tWCMVfMG0Gr1JdzT+6jpEuRLfpulGpr
         muWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=twfAj3jJ2iISvtECbV5aZw57c7oT5wmcKVNF5jtBKzw=;
        b=EgtEgYPZ66ds6CH1Y1o238OweUNFqPpf+KxmJTPoYjuTZxWedX3ReGX0eT2V827FVK
         rzEmqEN2uE1CmiyI5AjTlQmV3Y3cIieIhBMVnV8xauhTVbkUo3i5FZmeC6tbEmFxGnBX
         ycqd60DeWjojQ454kiNXIRyKBpCeMhwXh+XE8VgVgv6Th5g7Xglwq+FVCN7JtsniEL07
         ZbS3boDAIiNz20a8zvLGyeyO/vBajYT5eNywyQCV551Qvgi2fLQC/bbr8Ctj0sPg8lEC
         AuYUk1QLLOg55z+ygAenS7NcVDT8LBPR7OR4PCd6s/Qx7X0ms/Y7o1ZOjI5ULLUUHRMR
         eKaA==
X-Gm-Message-State: APjAAAUPI/XOTZgP7frRdGHg+2xuKvpF3o7ILFbrylWgS1oOtIl7NzmM
        taOsEuByWXArRsZEnSlyX4hMKA==
X-Google-Smtp-Source: APXvYqxETSoB7i089gEAZo3heQkfBeRm4nuAsZXEBqnzkt2y4Au7XwxwXBZ3oa3XifiOiixuSCRIRg==
X-Received: by 2002:a37:3d8:: with SMTP id 207mr671091qkd.191.1566947084848;
        Tue, 27 Aug 2019 16:04:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id u28sm319212qtc.18.2019.08.27.16.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 16:04:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2kW3-0007TV-VG; Tue, 27 Aug 2019 20:04:43 -0300
Date:   Tue, 27 Aug 2019 20:04:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/5] mmu notifer debug annotations
Message-ID: <20190827230443.GA28580@ziepe.ca>
References: <20190826201425.17547-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826201425.17547-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 10:14:20PM +0200, Daniel Vetter wrote:
> Hi all,
> 
> Next round. Changes:
> 
> - I kept the two lockdep annotations patches since when I rebased this
>   before retesting linux-next didn't yet have them. Otherwise unchanged
>   except for a trivial conflict.
> 
> - Ack from Peter Z. on the kernel.h patch.
> 
> - Added annotations for non_block to invalidate_range_end. I can't test
>   that readily since i915 doesn't use it.
> 
> - Added might_sleep annotations to also make sure the mm side keeps up
>   it's side of the contract here around what's allowed and what's not.
> 
> Comments, feedback, review as usual very much appreciated.
> 
> 
> Daniel Vetter (5):
>   mm, notifier: Add a lockdep map for invalidate_range_start/end
>   mm, notifier: Prime lockdep
>   mm, notifier: annotate with might_sleep()

I took these ones to hmm.git as they have a small conflict with hmm's
changes.

>   kernel.h: Add non_block_start/end()
>   mm, notifier: Catch sleeping/blocking for !blockable

Lets see about the checkpatch warning and review on these two please

Thanks,
Jason
