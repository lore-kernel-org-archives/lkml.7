Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB53C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF45272AC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Hzs5RRzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfFCHbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:31:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36404 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFCHbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:31:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so25527249edx.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5F+wBhCS8sAZq+YWWqmEdfsd0GQvCSzsuUSE02Dy/+0=;
        b=Hzs5RRzcSR5/iPErwK/TEKCpPfXXb7NKCEOoQh6t1GSNoJcrbpRJTGuHhRcsIvE4GA
         Q2fL8ChTxAdQyhg9lYzM6RlDVxYJ872nr/HoKow0Nt4+OHzRXdZXlY1B4atsQeSCQSJq
         9U7pW/mavwwQfxwMb6LJD5fDNPhck3RJgGjfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5F+wBhCS8sAZq+YWWqmEdfsd0GQvCSzsuUSE02Dy/+0=;
        b=NmSvs7BpLNctgCIT0QzIzGDHeSUrdYs3/oq7ItW90LcfvV9aZQQPyE01uNztTRBg+9
         BQS89h4suu1A21Vj/IhC0RRFXE08Co4VxT6JNxvlwfK6N3Z+meckhKEhPh0iImEzxmb3
         Pt++VfIfFz3ZKu7lnrg05LUxXSif/EfxyVR3Hg8xigHzkITKOuFpscfINHH8CZ87C+5i
         0nMjBwWvY7SndqDGdGDdbso0ISqE4B019kxIh8L5UVeQf1z9EWbE8/VIvsyQ/P2PWWLe
         SV3zUrizv70bNrPlG+7eHlXbM2/5defgWh2djrU05KmX+365S7RvyQb97Um+ZpoJgF/f
         q6iw==
X-Gm-Message-State: APjAAAVHoCFTcz5pCpQECC13bJuma0ISmJHCDA+3uJNHon4AY6oi50K7
        sapScGOqUKXqP6CwG42HQFfQpg==
X-Google-Smtp-Source: APXvYqyMy/Q966VQ6QHnjPoehMyRWwroWW9LptlRkVDBtGI4jRcS7IQg+vBhXqAEQ7Dl1PqAwJEjjw==
X-Received: by 2002:a17:906:254c:: with SMTP id j12mr21659216ejb.176.1559547065959;
        Mon, 03 Jun 2019 00:31:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b53sm3889272edd.89.2019.06.03.00.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 00:31:05 -0700 (PDT)
Date:   Mon, 3 Jun 2019 09:31:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: linux-next: unable to fetch the drm-intel-fixes tree
Message-ID: <20190603073103.GC21222@phenom.ffwll.local>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20190603082051.273a014c@canb.auug.org.au>
 <20190603110403.0412ed22@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603110403.0412ed22@canb.auug.org.au>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 11:04:03AM +1000, Stephen Rothwell wrote:
> Hi Stephen,
> 
> On Mon, 3 Jun 2019 08:20:51 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> > 
> > Trying to fetch the drm-intel-fixes tree today gives me this error:
> > 
> > -----------------------------------------------------------------
> > fatal: Could not read from remote repository.
> > 
> > Please make sure you have the correct access rights
> > and the repository exists.
> > -----------------------------------------------------------------
> > 
> > The same for drm-misc-fixes, drm-intel and drm-misc.  These are all
> > hosted on git://anongit.freedesktop.org/ .
> 
> Also the drm-tegra tree.

drm.git too I guess?

But yeah fd.o anongit keeled over over the w/e :-( Admins not yet awake,
so can't tell you what's up.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
