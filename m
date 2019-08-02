Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D438DC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B141E20578
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392973AbfHBNKY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:10:24 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:50232 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389781AbfHBNKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:10:24 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17817444-1500050 
        for multiple; Fri, 02 Aug 2019 14:10:20 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <156475071634.6598.8668583907388398632@skylake-alporthouse-com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
 <20190802123956.2450-2-sergey.senozhatsky@gmail.com>
 <156475071634.6598.8668583907388398632@skylake-alporthouse-com>
Message-ID: <156475141863.6598.6809215010139776043@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 2/2] i915: do not leak module ref counter
Date:   Fri, 02 Aug 2019 14:10:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wilson (2019-08-02 13:58:36)
> Quoting Sergey Senozhatsky (2019-08-02 13:39:56)
> > put_filesystem() before i915_gemfs_init() deals with
> > kern_mount() error.
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/gem/i915_gemfs.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
> > index cf05ba72df9d..d437188d1736 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
> > @@ -24,8 +24,10 @@ int i915_gemfs_init(struct drm_i915_private *i915)
> >                 return -ENODEV;
> >  
> >         gemfs = kern_mount(type);
> 
> Looking around, it looks like we always need to drop type after
> mounting. Should the
>         put_filesystem(type);
> be here instead?
> 
> Anyway, nice catch.

Sigh. put_filesystem() is part of fs internals. I'd be tempted to add

static void put_filesystem(struct file_system_type *fs)
{
	module_put(fs->owner);
}

and cc that for stable. And send a patch to add EXPORT_SYMBOL and queue
it for removal. Or just ignore the stable@ since it's unlikely to be
ever met in the wild and just request the EXPORT_SYMBOL.
-Chris
