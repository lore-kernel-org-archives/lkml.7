Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6702C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A111F21655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j0Hy/ryx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438313AbfIXVvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 17:51:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45579 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbfIXVvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:51:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id 4so1985043pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 14:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L7gG2OO+jz7b36c/gN/ybwC9G0RA1PGpUJISeNqEcl4=;
        b=j0Hy/ryx8DixYZOOmEwkUX0/pEG2qkc7U7jVaDgYP0aCO9H/XfGJ6Z0y/24GG1oiof
         rHxm/3fUioGvhaobSpoh8PZULnBsgeplegW4Gm74C5U3fVi1417fO4qWU56uhxMxrfYh
         DiYyBBdPj1ulomolqxMJchKIYdAVliR+MuuZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L7gG2OO+jz7b36c/gN/ybwC9G0RA1PGpUJISeNqEcl4=;
        b=iV1r6DITnhhSc8JGUzAYMTQTJ3FvYi2zLDUvgQ6hD6DtSgKnJrlmzA9zlGG15hyOml
         pF6sv+Qg5brZU95VF9IaXFPRMcEtEYEciXXGagc5hNSGG+T8nf0557/HS+v8pgreMwbJ
         WCUdjxVVFjcmEtLRQaE847MzVumglr400AsU0rnjrcMpm44FPhpG9rpQAhKFTQZCt/j2
         GZyrx/+qeFnyWZjBCz4ZVsqaF2AMmVzaXwVZhYau2SLhH3PFhc04WrsdXDWIOet7if4j
         7eX9YpHXk3+W43G/NzI6PzhB5tMB2IgLkJXRjg6Y5bsQyhVqPcDPJ4xIL2oJ88X5+HMB
         U4pw==
X-Gm-Message-State: APjAAAUHSBQmNRSFm0PUteBRirSrkAh84Cp3ZFFWNSmBvX1gX5hUjN5v
        3Pxub2z5GHqKSzBoZnfA7WEReahY1kk=
X-Google-Smtp-Source: APXvYqwCZP6jCkktcNQcHRwtBJrjQEe6Q8sx0//w+SKXejMYCli/WV6jeQY8d1sFIKDvQeZUZ71YlQ==
X-Received: by 2002:a63:121c:: with SMTP id h28mr5143588pgl.336.1569361895679;
        Tue, 24 Sep 2019 14:51:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b3sm840602pjp.13.2019.09.24.14.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:51:34 -0700 (PDT)
Date:   Tue, 24 Sep 2019 14:51:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] docs: Programmatically render MAINTAINERS into ReST
Message-ID: <201909241450.8A6B7E6EBF@keescook>
References: <201909231534.E8BE691@keescook>
 <87mueutb99.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mueutb99.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:16:18AM +0300, Jani Nikula wrote:
> I'd suggest making convert-maintainers.py a Sphinx extension, and
> handling all of this in Sphinx.

That's an excellent idea. I've done this now -- it simplifies things
quite a bit (though I had to beat my head against some odd behavioral
issues I tripped over inside docutils). I'll see the next version
shortly...

-- 
Kees Cook
