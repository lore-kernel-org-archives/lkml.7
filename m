Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67B9C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E1D2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olk4Y4iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfH2WEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:04:05 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:37910 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfH2WEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:04:05 -0400
Received: by mail-lf1-f49.google.com with SMTP id c12so3737869lfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qmQAdDRYulUDjSpMspTEPnnb4TRIYFsZQNmhOKS11AU=;
        b=olk4Y4iZag61wP1hPA3Br9s19D+SI48mrDe97epo/a7ja3nmIUJ1UW8dDTQEudnCot
         1rnKEtiyP81Axb4ndf5Ni20lVk7FBuW1LOu7/V5wvu5s8axkfpD2k8Its1nqKDucVCrS
         S8yMPZ8Nw6GPrdw3UkBvomVkp1MQw1CgvQh8WBMnqa5qO0lAfXIzXAi50aOm1UCbg2ai
         GJ+LzdGBPdyjQ5Eb8a60J9SAQ2dB5ZNFSuvTeLhDZSArZX6uf03nNmd4KBwPQli0UcBZ
         +8Ce2PdTca8oaDWDIc6NF2csNQVP0JO+LkIGg0U7Q/tgFjsOMYp40upVHb1DBhO4Ok42
         ZRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qmQAdDRYulUDjSpMspTEPnnb4TRIYFsZQNmhOKS11AU=;
        b=MgaWRYJlbOtLzbIdk8Oj5IULgnd24L5VJFMZA5iyuqkh9hcT6ueu1RENZ9Ed4Yqdxc
         Z7MJYCR6WUfY5Wzl2JENCyfNNMjbgO7xy+z1t3RQS4lx/lwLNfkceTSH6S/tVT8OPcu1
         03T22FqY2dCqUKKtZ7DmVLucsCoRZCZdw6ovjzXt/bUoCdROrlx4HXkOYfPZgmJcQd7f
         KJ3bep9VdFcONze3sc2/FYVqx36ez/uWgG4zWYDFvfpqJ0pCg9SD0Y0gZXmC2+ghLmK9
         nnejQHw0Ic+PJtqi25kllxQVXhMuKNyY4/xnfICvMfnM2YHbAoOEpKH2b+t0ArwgA/91
         ZvQw==
X-Gm-Message-State: APjAAAUcRKfFiMWxfeOCAHXOI7U6l3ZJ/r0uxpRqdQuwzMayG/+bt9Cz
        H/Ra6LOdQ36kjCmWapq1/6A=
X-Google-Smtp-Source: APXvYqx5Rzds4epSb/bOTOocRGoYxAjXegirF5KGbnGG+NfeQNJOyfAEBiAXvG0M0ytaQNmDGCVGug==
X-Received: by 2002:a19:6a12:: with SMTP id u18mr7345008lfu.133.1567116242773;
        Thu, 29 Aug 2019 15:04:02 -0700 (PDT)
Received: from localhost.localdomain ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id e21sm575402lfj.10.2019.08.29.15.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:04:02 -0700 (PDT)
Message-ID: <a07be36905f145f2fb07beee73f9d3805c285022.camel@gmail.com>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
From:   mikhail.v.gavrilov@gmail.com
To:     Daniel Vetter <daniel@ffwll.ch>, Hillf Danton <hdanton@sina.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Date:   Fri, 30 Aug 2019 03:03:58 +0500
In-Reply-To: <20190826092408.GA2112@phenom.ffwll.local>
References: <20190825141305.13984-1-hdanton@sina.com>
         <20190826092408.GA2112@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.33.91 (3.33.91-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 10:13:05PM +0800, Hillf Danton wrote:
> Can we try to add the fallback timer manually?
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -322,6 +322,10 @@ int amdgpu_fence_wait_empty(struct amdgp
>         }
>         rcu_read_unlock();
>  
> +       if (!timer_pending(&ring->fence_drv.fallback_timer))
> +               mod_timer(&ring->fence_drv.fallback_timer,
> +                       jiffies + (AMDGPU_FENCE_JIFFIES_TIMEOUT <<
> 1));
> +
>         r = dma_fence_wait(fence, false);
>         dma_fence_put(fence);
>         return r;
> --
> 
> Or simply wait with an ear on signal and timeout if adding timer
> seems to go a bit too far?
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -322,7 +322,12 @@ int amdgpu_fence_wait_empty(struct amdgp
>         }
>         rcu_read_unlock();
>  
> -       r = dma_fence_wait(fence, false);
> +       if (0 < dma_fence_wait_timeout(fence, true,
> +                               AMDGPU_FENCE_JIFFIES_TIMEOUT +
> +                               (AMDGPU_FENCE_JIFFIES_TIMEOUT >> 3)))
> +               r = 0;
> +       else
> +               r = -EINVAL;
>         dma_fence_put(fence);
>         return r;
>  }

I tested both patches on top of 5.3 RC6. Each patch I was tested more
than 24 hours and I don't seen any regressions or problems with them.


On Mon, 2019-08-26 at 11:24 +0200, Daniel Vetter wrote:
> 
> This will paper over the issue, but won't fix it. dma_fences have to
> complete, at least for normal operations, otherwise your desktop will
> start feeling like the gpu hangs all the time.
> 
> I think would be much more interesting to dump which fence isn't
> completing here in time, i.e. not just the timeout, but lots of debug
> printks.
> -Daniel

As I am understood none of these patches couldn't be merged because
they do not fix the root cause they eliminate only the consequences?
Eliminating consequences has any negative effects? And we will never
know the root cause because not having enough debugging information.

