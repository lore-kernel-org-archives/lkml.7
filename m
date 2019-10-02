Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83961C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553252133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKTwvoIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfJBLuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:50:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33785 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBLuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 07:50:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so12518775lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ERYCwhz2Jv8a2PVju4gxqh772VeR3/dOesngu7HPYnA=;
        b=NKTwvoIxQtQKHiWFgsb0Dr5MXuoTKgm2v5uaWdQsgbZAg65hZVIWoISq3wolvdEAAR
         FxxPvE8dnm3bANECmAtFuazY5ZXEviGexcvyvzpErii7cWM6uZL9mg7hf34049JsB6Xd
         9pdqnmVmk3p9j35vtwN2sO6IdAtnyUzWR2KGUJYmodCR4iKYYOJciJLMQvdug4MZiuiP
         2nVI7cs8AKCxchOuVfkGDUxzjr811bGzOImlN4hKtKc95U20sJvHz2INXyyvmn5DwPiA
         EMZGI36ZasVGpNtA/WWHXlYBBHpqp6CBBdyKCDD3XPuR7/zujFdCdXJsKCuL7H54F0Yt
         UMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ERYCwhz2Jv8a2PVju4gxqh772VeR3/dOesngu7HPYnA=;
        b=nToojUNG7vpGirv1Pi7cRCbIXhwDoPc9AmmQtCJQ+8uO5vaLo8L8erWf3DPoCejz0j
         QJGyQ66Fty3Zj+xW7eM05SgqgkZWCi33SUTeW4xllALaxeVd5mUBC8Y+LQFohbmw2Gbs
         /AfceFobeFPrXk+CSTC7w+f2gXNMg7ue3JZxHWgN9ZC2fCShxC+63fHmeGaz8gtweXlf
         tEzVtr/RCCIhnJ229PXUv0IxrSI8Ulwzz6AD/JiUQYyrWxhEnnSE+Digy9vkRKXDIg1G
         IKkW375qumwJ2fczKYmhuI/fehi+I8W215NUWZRRLKK5A6x3Du7W3kZOX6VODbRw8gX9
         g50g==
X-Gm-Message-State: APjAAAV4hHltcDzznPxfjmGoQykn3hgDvlTg5Emq5RTLUVI9zNkzIm7V
        KW7sB70yqNJGL0/cich4H50cUeKnXEI=
X-Google-Smtp-Source: APXvYqzmBtraLl7Fkhb/mX+JH5ZW8CPDsl554EacBpP42KpX5nl7Qc54pEaK0EtGedCJwAONbblaZg==
X-Received: by 2002:a19:8c14:: with SMTP id o20mr2075568lfd.158.1570017005189;
        Wed, 02 Oct 2019 04:50:05 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id x76sm6142064ljb.81.2019.10.02.04.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 04:50:04 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 2 Oct 2019 13:49:52 +0200
To:     Daniel Axtens <dja@axtens.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, aryabinin@virtuozzo.com,
        glider@google.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20191002114952.GA30483@pc636>
References: <20191001065834.8880-1-dja@axtens.net>
 <20191001065834.8880-2-dja@axtens.net>
 <20191001101707.GA21929@pc636>
 <87zhik2b5x.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhik2b5x.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:23:06AM +1000, Daniel Axtens wrote:
> Hi,
> 
> >>  	/*
> >>  	 * Find a place in the tree where VA potentially will be
> >>  	 * inserted, unless it is merged with its sibling/siblings.
> >> @@ -741,6 +752,10 @@ merge_or_add_vmap_area(struct vmap_area *va,
> >>  		if (sibling->va_end == va->va_start) {
> >>  			sibling->va_end = va->va_end;
> >>  
> >> +			kasan_release_vmalloc(orig_start, orig_end,
> >> +					      sibling->va_start,
> >> +					      sibling->va_end);
> >> +
> > The same.
> 
> The call to kasan_release_vmalloc() is a static inline no-op if
> CONFIG_KASAN_VMALLOC is not defined, which I thought was the preferred
> way to do things rather than sprinkling the code with ifdefs?
> 
I agree that is totally correct.

> The complier should be smart enough to eliminate all the
> orig_state/orig_end stuff at compile time because it can see that it's
> not used, so there's no cost in the binary.
> 
It should. I was more thinking about if those two variables can be
considered as unused, resulting in compile warning like "set but not used".
But that is theory and in case of having any warning the test robot will
notify anyway about that.

So, i am totally fine with that if compiler does not complain. If so,
please ignore my comments :)

--
Vlad Rezki
