Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C563CC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954D82073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftzFVjyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbfHBFh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:37:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44374 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732543AbfHBFh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:37:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so33170944plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ihRIEHRjtJIPus/danpDF2O/WfsfhF+xvDGQLaVGba0=;
        b=ftzFVjyfXoKLkBYNUMy31X98rL/NnJ8hllXWpl0KRZE/jG55BdBSqB5J1eDuE9kY7a
         aOrDSt03+MjcLtacH3layAaidKQ6bFw2OUKmk1j6Ol9G426SpZEcIf/M1fZRfSsuAJYj
         C6+SzwOAVWFe0xcQC/KGNlvgWQMGGBooqyrnAWQom/dNI0UjuYp7RayvRxOegnWThP25
         Tey1oildsxoH7wSomoGATwjH1OmclS1/j9TMY7I6PZ9Fe70UuJMWMHkIR5Z1qfdJ+JvX
         asuve8Y7Sd9y66IvBmlGl2LuEZN88zQPY/rDQC+SP4UvLmMQWmpALsqq4rtj5qPrJU3d
         2Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ihRIEHRjtJIPus/danpDF2O/WfsfhF+xvDGQLaVGba0=;
        b=i+8QwCaBlK6x6TYFP8Z0G146jb0zK2tkU6eJwBlSy10xqnzkrQyY5B2lJ9LQlWmHnM
         50Qs7eK2ikQJo+cVyx1IabaxT370cMVZ7GAIpe1nD8vGEcVgxKUQXik0rTCfkIuVBWhN
         iNdK3gruNQPVP0Tp446DEeHPyYOxDsbRGXVDmGLzNlAE16GBPpnoCSEmXFkvpHD2uy+N
         IT3Huo/AjfLcO6Z+NVGyMIQ2bffXqabVPzdgE52wFX+wMLHIAPhsyoqBQEfTN46FoUq/
         /kV5iK2u5FVYO72Ph62LwDxN2t2kpsFNd0plOA/SPC94q00Fji1MfYAbJyej7mReee9c
         EebA==
X-Gm-Message-State: APjAAAXRERgjuUjrR9SQ0upgdMLdGqCOb1rocglJTupNSZPQSAnvST4s
        AqYkOirek/vePGJTyv4578Y=
X-Google-Smtp-Source: APXvYqyxSYMw4QN2SRQ515CrxjGKV3nanM01epjwWH4RWeHALCxAI0t+x/3BqYGx0VGsG1ZUoXSy1Q==
X-Received: by 2002:a17:902:1004:: with SMTP id b4mr131792482pla.325.1564724245276;
        Thu, 01 Aug 2019 22:37:25 -0700 (PDT)
Received: from localhost ([175.223.19.29])
        by smtp.gmail.com with ESMTPSA id q19sm77991081pfc.62.2019.08.01.22.37.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 22:37:24 -0700 (PDT)
Date:   Fri, 2 Aug 2019 14:37:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Intel-gfx] [linux-next] mm/i915: i915_gemfs_init() NULL
 dereference
Message-ID: <20190802053720.GA3838@jagdpanzerIV>
References: <20190721142930.GA480@tigerII.localdomain>
 <20190731164829.GA399@tigerII.localdomain>
 <156468064507.12570.1311173864105235053@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156468064507.12570.1311173864105235053@skylake-alporthouse-com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/01/19 18:30), Chris Wilson wrote:
> Quoting Sergey Senozhatsky (2019-07-31 17:48:29)
> > @@ -36,19 +38,35 @@ int i915_gemfs_init(struct drm_i915_private *i915)
[..]
> > +               if (!fc->ops->parse_monolithic)
> > +                       goto err;
> > +
> > +               err = fc->ops->parse_monolithic(fc, options);
> > +               if (err)
> > +                       goto err;
> > +
> > +               if (!fc->ops->reconfigure)
> 
> It would be odd for fs_context_for_reconfigure() to allow creation of a
> context if that context couldn't perform a reconfigre, nevertheless that
> seems to be the case.

Well, I kept those checks just because fs/ code does the same.

E.g. fs/super.c

	reconfigure_super()
	{
		if (fc->ops->reconfigure)
			fc->ops->reconfigure(fc)
	}

	do_emergency_remount_callback()
	{
		fc = fs_context_for_reconfigure();
		reconfigure_super(fc);
	}

> > +                       goto err;
> > +
> > +               err = fc->ops->reconfigure(fc);
> > +               if (err)
> > +                       goto err;
> 
> Only thing that stands out is that we should put_fs_context() here as
> well.

Oh... Indeed, somehow I forgot to put_fs_context().

> I guess it's better than poking at the SB_INFO directly ourselves.
> I think though we shouldn't bail if we can't change the thp setting, and
> just accept whatever with a warning.

OK.

> Looks like the API is already available in dinq, so we can apply this
> ahead of the next merge window.

OK, will cook a formal patch then. Thanks!

	-ss
