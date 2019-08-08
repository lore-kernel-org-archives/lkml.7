Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA18BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800A821873
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnK2WRFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfHHEud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 00:50:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37134 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfHHEud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 00:50:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so993310wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 21:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c2ctl4XAji46HwbaOhdkmf4zUAn2rV12GD6HMJfhhu0=;
        b=EnK2WRFCo2HUJXN26DDv3YeH1cdtPs78djtjZutI4oJDd6kAR7L+cBMTApuNBZJlAl
         EpA23bP8D5uElbDt0/Ac1AMatfMdb0pzwqof7AZehQl4T1OBlle9qLAjuM/lkqt7SxPB
         E44Rnf5Ou2h5TqHcewh4p5YllNwZpAA/zyQKFjEXFgV6PdGnMwrtvNIS6PA6ArUre5bk
         +Y2nj+0oIDqPEzPU5hIRUEyUYYIZQTNLWzv52Grs+N+kmJRjiHeXbkke5uxxBZ/WuooY
         rUzdU50fx13CU0iXSKbZ4GOozYjrKYQz0QTy6Ovgiv/rq3PnNvJ+1d2RySmOVgXVPDOx
         hYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c2ctl4XAji46HwbaOhdkmf4zUAn2rV12GD6HMJfhhu0=;
        b=JBYS7nYsUuX0u1ojUAlTbTmeHe52tAgDDd6534Ms6VfUui007URY8Qu7rvDdfijHJa
         K8o4GW5x75zcRpWUmN05EH++BBeY59tg3SVcPFg/Kio/nHU3FQ4OusRtWRZctnLOluvY
         fv7wKPgps0FrS/Qz4KMCOG4yVYJUWx5b7cXwoOtVp94yvP2lRoCYQFMuqw2ZSqwjqpK7
         CUh0fjrXJheIG2GYA4kJSTBh3X7/LOVahOCcVNuy02cVMfNNWO2XYLE81mqQtQKriu4q
         +t5YXlo/qC9Pd8vjy9DnJXX/XwXywfxE1468vi4o485atEpQ8zMarlOVF1Xkj7WlenyR
         Xc/w==
X-Gm-Message-State: APjAAAUe3MstvjdSvYQy8qAyF8VPHyVr1tQ8YXMSsDYmM5AAQ6MCL+Ea
        0Kxp4PhLHWQFzjNypK1AIHY=
X-Google-Smtp-Source: APXvYqzmVvFk9Dv5wtqWGfmpt4Ku8O6izZqJSqYGCnAp0dXDc8Alq0JXGsAIxvYE6kRL99pKbFZg6Q==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr1823749wml.124.1565239829705;
        Wed, 07 Aug 2019 21:50:29 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id 2sm136472106wrn.29.2019.08.07.21.50.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 21:50:29 -0700 (PDT)
Date:   Wed, 7 Aug 2019 21:50:27 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cache: silence -Woverride-init warnings
Message-ID: <20190808045027.GA34150@archlinux-threadripper>
References: <20190808032916.879-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808032916.879-1-cai@lca.pw>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 11:29:16PM -0400, Qian Cai wrote:
> The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
> VIVT I-caches") introduced some compiation warnings from GCC (and
> Clang) with -Winitializer-overrides),
> 
> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
> overwritten [-Woverride-init]
> [ICACHE_POLICY_VIPT]  = "VIPT",
>                         ^~~~~~
> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
> 'icache_policy_str[2]')
> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
> overwritten [-Woverride-init]
> [ICACHE_POLICY_PIPT]  = "PIPT",
>                         ^~~~~~
> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
> 'icache_policy_str[3]')
> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
> overwritten [-Woverride-init]
> [ICACHE_POLICY_VPIPT]  = "VPIPT",
>                          ^~~~~~~
> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
> 'icache_policy_str[0]')
> 
> because it initializes icache_policy_str[0 ... 3] twice. Since
> arm64 developers are keen to keep the style of initializing a static
> array with a non-zero pattern first, just disable those warnings for
> both GCC and Clang of this file.
> 
> Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
> Signed-off-by: Qian Cai <cai@lca.pw>

It's a shame we can't just use one cc-disable-warning statement but
-Woverride-init wasn't added for GCC compatibility until clang 8.0.0
and we don't have an established minimum clang version.

With that said, I applied your patch and I don't see with warning with
W=1 anymore and I see both options get added to the clang command line
with V=1.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Cheers!
