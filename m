Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0201C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3312084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfEOGXX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:23:23 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:58195 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725857AbfEOGXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:23:23 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16559056-1500050 
        for multiple; Wed, 15 May 2019 07:23:12 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190515043753.9853-1-yamada.masahiro@socionext.com>
Cc:     Dave Airlie <airlied@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20190515043753.9853-1-yamada.masahiro@socionext.com>
Message-ID: <155790139253.21839.18331243986827594086@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: drop unneeded -Wall addition
Date:   Wed, 15 May 2019 07:23:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masahiro Yamada (2019-05-15 05:37:53)
> The top level Makefile adds -Wall globally:
> 
>   KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
> 
> I see two "-Wall" added for compiling under drivers/gpu/drm/i915/.

Does it matter? Is the statement in i915/Makefile not more complete for
saying "-Wall -Wextra -Werror"?

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> BTW, I have a question in the comment:
> 
>  "Note the danger in using -Wall -Wextra is that when CI updates gcc we
>   will most likely get a sudden build breakage... Hopefully we will fix
>   new warnings before CI updates!"
> 
> Enabling whatever warning options does not cause build breakage.
> -Werror does.
> 
> So, I think the correct statement is:
> 
>  "Note the danger in using -Werror is that when CI updates gcc we ...

No. CI enforces -Werror and that is constant, so the uncontrolled
variable, the danger, lies in using the unreliable heuristics gcc may
arbitrary enable between versions. That the set of warnings causing an
error may be different between CI and the developer.
-Chris
