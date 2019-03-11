Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B545C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D495C2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfCKVq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:46:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38784 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfCKVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:46:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id m2so131686pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 14:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v68UaAN+XF/lpO/ZYPx+cxL/Cwdo0hNkZMg52MNN2wQ=;
        b=l4y3HBHSVl8JJPjc5Dh2GXJH5EbMo5p44ShTc6AgjrygJiednfsOd20qiHAnN6TCgM
         luOuJK8m7/6HpryxoZFVMp+czPPIdoU7W3H1DwWf6kpcJfGlqgArcUVkqj6Lz9TSjIft
         Xi/UP6igJ1ed8504dXC/zf/N4juw/qg8THSzM41G/hFn1MidwJHcAjs8/8MsQz5clQsm
         z6k4lMIZDAzdi61zL41Qujxr4Zk0hzFqJAzPxUJSzpegBcxVNUEPPbzKotCp+iVJTtVY
         zYGBWjEy4ZysOzT2oMiDXFW3ODo+kepGu08BOpri3+p8wWu9zNV75RJ2zH0QVlXgf3wd
         du4A==
X-Gm-Message-State: APjAAAWRLpzvVingOzXQSfoIhvozWZmK0VzhncXezINdj1ZcKE9bCCvD
        SMSGLXjlu8ELRqfof/V8f/Q=
X-Google-Smtp-Source: APXvYqx/FW5wmQiMfqZNGhD5+OlnFqREHbmUfV07aYsv2Zbx/Ipt5jiexUOqJgCXqXYtCjJeqGLZcg==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr35838273plp.118.1552340816219;
        Mon, 11 Mar 2019 14:46:56 -0700 (PDT)
Received: from sultan-box.localdomain (campus-007-074.ucdavis.edu. [168.150.7.74])
        by smtp.gmail.com with ESMTPSA id s18sm9312788pfh.71.2019.03.11.14.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 14:46:55 -0700 (PDT)
Date:   Mon, 11 Mar 2019 14:46:51 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190311214651.GA882@sultan-box.localdomain>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <20190311211125.GA127617@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311211125.GA127617@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 05:11:25PM -0400, Joel Fernandes wrote:
> But the point is that a transient temporary memory spike should not be a
> signal to kill _any_ process.  The reaction to kill shouldn't be so
> spontaneous that unwanted tasks are killed because the system went into
> panic mode. It should be averaged out which I believe is what PSI does.

In my patch from the first email, I implemented the decision to kill a process
at the same time that the existing kernel OOM killer decides to kill a process.
If the kernel's OOM killer were susceptible to killing processes due to
transient memory spikes, then I think there would have been several complaints
about this behavior regardless of which userspace or architecture is in use.
I think the existing OOM killer has this done right.

The decision to kill a process occurs after the page allocator has tried _very_
hard to satisfy a page allocation via alternative means, such as utilizing
compaction, flushing file-backed pages to disk via kswapd, and direct reclaim.
Once all of those means have failed, it is quite reasonable to kill a process to
free memory. Trying to wait out the memory starvation at this point would be
futile.

Thanks,
Sultan
