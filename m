Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98060C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F8B20679
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ritRXhRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfFPQ1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 12:27:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43577 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfFPQ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:27:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id j29so4779466lfk.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cVuvolx0crP2RdRYi3l8AqoSD+eqXL2UwZAQBs6f87k=;
        b=ritRXhRUWri2ajUBEJqAb8sN7dg1so0SakcFYpITeSodyL6ROwOWOP1wruSQb7gM0E
         7v6zL7TWZjx4HEyzGcit1ShuLzToPmJWmc/hJw4+7X4KIKNjf/3eK0QhqY9G7X78+6wb
         WeCCIKjMV9ERdSda39uHxZxuuViTUcjDR+nV24QFyTAcEGCqwf/MhFotRPdDxhkjO03g
         2xJvt6erCxUEWOuNvuvY5gK21c7TMNkQXwrI4on+F8rb/hL0v12NyL01o04WyE41x1lq
         foRlj2rPRgZ8U+Bggen1bNvqHkRLmKP7qNpb97M9YOVxRGp3JN/CZP9OEG7AReKQC/Q7
         Rorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cVuvolx0crP2RdRYi3l8AqoSD+eqXL2UwZAQBs6f87k=;
        b=hILUv9lPxNle0UlNdOoQJ17HPoB8TxQpnrWJsUgiiB2oVpMOMxvHtZVa+VAWahuroO
         nJPcA/4yagQZhQfvwI9gZeku5uRkmvk935sk3ua3aPnNNzwcwooiKrcTytRvTKRYlpz0
         phzTecjMFCpSYkXXtgdNDqzjA4NmZkdBKAIgBejFt2ax2g8SHgoKrH51oTx7Eqf7Lf2W
         dZzVtWSoMCJc174LTDGx7YhvMdipxOEp41aRyus1+YFIBRZnq/zl7gMwyHH+zeOXV8hA
         XCUTaA/Y2z3tJuOraeX+ZKqkAhpb/o4T8PvJhT5v02od0LN0vEVSP0LZ15GpPi/l+Dvb
         tBFg==
X-Gm-Message-State: APjAAAVcmBeVidipG3ijpl4pC7fj28hthk4f3HM6fpRm8NZS/BoNrqeO
        97v3BBuoFbsTUR6YaqHu1c4=
X-Google-Smtp-Source: APXvYqzy25joefgU8Dw0kC+dz7ltpG9ilwsoYNoU+2LxGFnAeuLIcpR8rTBaAdSrO6lhpOx8cDgMDA==
X-Received: by 2002:ac2:47fa:: with SMTP id b26mr18365774lfp.82.1560702437898;
        Sun, 16 Jun 2019 09:27:17 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id q4sm1844099lje.99.2019.06.16.09.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Jun 2019 09:27:17 -0700 (PDT)
Date:   Sun, 16 Jun 2019 19:27:16 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v7 07/10] mm: synchronize access to kmem_cache dying flag
 using a spinlock
Message-ID: <20190616162716.broxurphhmvdzy5s@esperanza>
References: <20190611231813.3148843-1-guro@fb.com>
 <20190611231813.3148843-8-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611231813.3148843-8-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:18:10PM -0700, Roman Gushchin wrote:
> Currently the memcg_params.dying flag and the corresponding
> workqueue used for the asynchronous deactivation of kmem_caches
> is synchronized using the slab_mutex.
> 
> It makes impossible to check this flag from the irq context,
> which will be required in order to implement asynchronous release
> of kmem_caches.
> 
> So let's switch over to the irq-save flavor of the spinlock-based
> synchronization.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
