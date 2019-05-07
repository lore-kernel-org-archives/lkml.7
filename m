Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C094CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F90E20449
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557261789;
	bh=h+XYgHBh8G9/ZcxiIoFinnwwN6MR0gvPw7wQ7la7TWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CrejRf/qa5tWAyl7FjUY5yVzXY2YwJUCTQ3+ALWu8B/xiXcjQVfOGwX7gi1nT816h
	 oaXCHIg3HFjLbeVJY4QjTW6BOJ4nUQHbsMpDM9/KVqEvSXvmOGTXTupSXHu8vV1PGq
	 +Bc8V+f8rVBRQ/uwZRcsjz5JVMqOTgH+F38LH4EE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfEGUnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:43:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35430 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfEGUnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:43:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id m20so6333453lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFtoFl9o8jZDP1GfRO7Vvn+F3IJAEhFQ7BMm/fB3wfQ=;
        b=A4sU98RSlOmv8oGbC72vtqW/KJdIvfDnPZ5IdHnk5LXH/tIG2ND3kTCEEnt41vmddY
         JniXDyU+zIELCrArIfldwnebSDNY5MbZnkhk5WeEuUcFffjuGhjnaxYKffW1Il2GtxVO
         BthkQKcJAdeVW/2EzcuD5TVAKmmcpGNiWX1ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFtoFl9o8jZDP1GfRO7Vvn+F3IJAEhFQ7BMm/fB3wfQ=;
        b=kcRefY8pEPeH346ln+QrWpQKSMVs7Apvgg8KOQeYse+SgXIu64sxZFCjjlE7K3i3GQ
         6GAQAMgEZQlN0cc/TwUPhOvYLDSKkFybIl5s2kiHiHdFwPs04gE7rRQ+7N1eWPHPkZTt
         CHKueyruKhMOnxQReELHqE+RUovjEXLB21/f/y/G41Cun8YRecxbsrfycn2vATz9UgaQ
         qfCqEgZqGmoLGbz3hftcRqra6Umnp3d/7x+t4ZwwYz3tjFBIGyg0fjf8mQW8f/AyZZy1
         TfeOsQhRaN1/NT1SZcd38VJ9IcZfar4OfHNfxtxJFtI8zhocK8ogWgyBAlBaZhkQY50J
         Z75g==
X-Gm-Message-State: APjAAAWXuhNtvYzVTnaAHkJddVnuRl7fxyoQb98o6ywYj73k5N3ZKU3u
        QUlK7GvP0lJDEC6dfjjMN4i1qFmBH44=
X-Google-Smtp-Source: APXvYqza9LOvj8/MM7v54hxQ2RFwZ0MHWDfKdSApY9SQGW+pj3A63N35gdkJgnJYDtnBVvfQKaB80Q==
X-Received: by 2002:a2e:298d:: with SMTP id p13mr4319896ljp.64.1557261785602;
        Tue, 07 May 2019 13:43:05 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id t7sm3343099ljj.87.2019.05.07.13.43.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 13:43:04 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 132so7817316ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:43:04 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr3093343ljh.22.1557261784061;
 Tue, 07 May 2019 13:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190506123659.23591-1-christian@brauner.io> <CAHk-=wh692HhZ+s=WWCw81mWFvXEGpXKccHcmpRUrO9p3KKD=w@mail.gmail.com>
 <20190507204034.kgwqkgw6lc3hzukd@brauner.io>
In-Reply-To: <20190507204034.kgwqkgw6lc3hzukd@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 13:42:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWdJyGnsiBFXA0_3Utey3=JP831X4gPYKx2wEcGFKNAg@mail.gmail.com>
Message-ID: <CAHk-=wjWdJyGnsiBFXA0_3Utey3=JP831X4gPYKx2wEcGFKNAg@mail.gmail.com>
Subject: Re: [GIT PULL] pidfd patches for v5.2-rc1
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, David Howells <dhowells@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 1:40 PM Christian Brauner <christian@brauner.io> wrote:
>
> Oh, sorry. You want me to send a follow-up that fixes it?

Yes, but no hurry. If you add it to the queue of fixup patches, that
would be good.

And if it ends up being the *only* such patch by the end of the merge
window, that's fine and you can just send it as a patch (or git pull),
but if there are other fixes just send it together with those.

Ok?

               Linus
