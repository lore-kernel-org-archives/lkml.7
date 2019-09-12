Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F22C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B5720CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="AW5DrAcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfILKEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:04:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38885 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbfILKEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:04:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id a23so21179024edv.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/rIExj7B4h6eC4mHl71VjTXyhp29mEK5iBcqAyTdGg=;
        b=AW5DrAcscw4bvqq/1xyyZySmm8GCobspqFQVzbhGGa04IJS4RWFuqH/svrDz92T0rJ
         K84vjWZTjUK563+t6r4w7iO/iBhPPQeFMP0di/DtMFPh1IRbUsKPHJ3Oxc8l5evb5UGg
         AfePbOriyQOkGtZCo4vvVowEroFGCCgqj9163AQu4qax5zQTSWzUA7DX4U0ePAc7Ag1b
         YNopkmk4QhOPStos9FVkKThvkxZGJpYafQ7YApID3mWeXjMS/IPoa/39Gb9v8Bp4qWNP
         38dOKgHwNl/hc/f3HZiPwdImwxrg3FY1wa8H6+gJUDAlPeS/lTDQfuoz83kbyEHNCcC/
         I6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/rIExj7B4h6eC4mHl71VjTXyhp29mEK5iBcqAyTdGg=;
        b=GC6NR+NdSFfnrd49UjKmTbSn9njS/H88nNQPB/HIvplKK8jWDF3+O5YJRqG1WmxH20
         LIejvNOmYwg+2YjhDnblfgWuOMNvZJt8y7QbcwXQ7xrClcw8wkiXuN94xHnNlLIBNZ+i
         wW+le7X+iP1kgPRWainQ/3hNOyePc4BT2FWCfp3CIIqaOQjMGUPVMYF4IrfcUpyHZdQ2
         LHQUh8Hju/AhaHkDOG3by4so0eF1gScd8Z1DzGb/Qr7hxIuLvMvtbYHACB4OUGI7MWdB
         TazFenC2qI6z846b5iI/PjYOn3OByJp2EuIbDuVxOi6BEGlOc25+Et60vx/Cmbs4MSK5
         KFfw==
X-Gm-Message-State: APjAAAUWEVxZz8e8tqVuzIPi2FUF1VmqV8a81MtbQTOT9hvH4RgMJMU/
        cWRvTzPu+mbcNZWuwRGfCiqY6Q==
X-Google-Smtp-Source: APXvYqwZKRLCxLDMpIRA2e2Lt7Qp2Tx+uu0MwTEsgXW4u8RcmiXb8xDHTXTU8wLY3dyOy0b9ZYcjmQ==
X-Received: by 2002:a17:906:3583:: with SMTP id o3mr11419151ejb.224.1568282668660;
        Thu, 12 Sep 2019 03:04:28 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id kt24sm2791872ejb.72.2019.09.12.03.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 03:04:27 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2F31C100B4A; Thu, 12 Sep 2019 13:04:29 +0300 (+03)
Date:   Thu, 12 Sep 2019 13:04:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mm: avoid slub allocation while holding list_lock
Message-ID: <20190912100429.fk5er66aostbtvyi@box>
References: <20190912004401.jdemtajrspetk3fh@box>
 <20190912023111.219636-1-yuzhao@google.com>
 <20190912023111.219636-3-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912023111.219636-3-yuzhao@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 08:31:10PM -0600, Yu Zhao wrote:
> If we are already under list_lock, don't call kmalloc(). Otherwise we
> will run into deadlock because kmalloc() also tries to grab the same
> lock.
> 
> Fixing the problem by using a static bitmap instead.
> 
>   WARNING: possible recursive locking detected
>   --------------------------------------------
>   mount-encrypted/4921 is trying to acquire lock:
>   (&(&n->list_lock)->rlock){-.-.}, at: ___slab_alloc+0x104/0x437
> 
>   but task is already holding lock:
>   (&(&n->list_lock)->rlock){-.-.}, at: __kmem_cache_shutdown+0x81/0x3cb
> 
>   other info that might help us debug this:
>    Possible unsafe locking scenario:
> 
>          CPU0
>          ----
>     lock(&(&n->list_lock)->rlock);
>     lock(&(&n->list_lock)->rlock);
> 
>    *** DEADLOCK ***
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
