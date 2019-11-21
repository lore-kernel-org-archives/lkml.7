Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5CEC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5152068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WlulTIMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKUTwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:52:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33455 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUTwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:52:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so2074682plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 11:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oibr9mo+x0+TGv4WMCPaafgkJSg0wRL2Of/xQxi/DiU=;
        b=WlulTIMKfJ69Qa5u9lpbic68PHzChbTGdAZk0v72q6waDu5xHFcYiU0CJEoT30LNpK
         lgeF9rHVsLJLUb4OQsaxjm8+A7uam5+e2v6+flnO0Sys9x2CkSqVbomkf2wUiOwA8tsq
         3FzKH2z+xgD280Xlld4qTU4USfRI3qY6vMdhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oibr9mo+x0+TGv4WMCPaafgkJSg0wRL2Of/xQxi/DiU=;
        b=Y457pbH5vAdkIgZ+JNLQ7tjwsl7c40PoSFzodbjecTAF5HhHWPfcsRTKGqb6JMSgrn
         w5Mdc5Qr1c5Up2ceq5d4x54bSbXa5ONB+OtB36M7vLvIgCvKAOcEz3es5aK0XpIzqMrA
         JbnPK4hXv613e6OBrNIstmnIH2cDelX7XBDI2VQuJAKiTrEOVtQmt/zutFdz0sK+qc7K
         5gvFpYptklv9Tc4nfj2AS54RktEL8fFmcieEhGVYPdLOipI4arvgPA9+Wb2LSHnNwGqu
         eeSTcoTY63+0rapZamFeGZF4N7vU3+cQ/7kY7tQfiaGG3TfGmN4EG928HM/fqkkhMkav
         13Kw==
X-Gm-Message-State: APjAAAWHlYtdm5N/69lxW3iZFIHwX+UKkt0wteznZaHJwzd6o4E/oLRn
        CwB+4hl+tGow+h4PEgQHJT1Qmg==
X-Google-Smtp-Source: APXvYqyW7eFXDr9JMJJ9FRFENumkx9ubOhmnk19B5oInsr8SBRnIQfkXM/m4r6Y9vbhvVn7CrHJaWg==
X-Received: by 2002:a17:90b:d93:: with SMTP id bg19mr13434722pjb.81.1574365939329;
        Thu, 21 Nov 2019 11:52:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m6sm3853310pgl.42.2019.11.21.11.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:52:18 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:52:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] docs, parallelism: Rearrange how jobserver
 reservations are made
Message-ID: <201911211151.45A9C4F5F6@keescook>
References: <20191121000304.48829-1-keescook@chromium.org>
 <20191121000304.48829-4-keescook@chromium.org>
 <656afebc-fc60-7502-40a3-52d2662c1d27@rasmusvillemoes.dk>
 <201911211122.02F3646@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911211122.02F3646@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 11:39:03AM -0800, Kees Cook wrote:
> On Thu, Nov 21, 2019 at 09:09:37AM +0100, Rasmus Villemoes wrote:
> > Similarly (and the harder problem), what happens when our parent wants
> > to send its child a signal to say "stop what you're doing, return the
> > tokens, brush your teeth and go to bed". We should forward that signal
> > to the real job instead of just dying, losing track of both the tokens
> > we've claimed as well as orphaning the child.
> 
> Hm, hm. I guess I could pass INT and TERM to the child. That seems like
> the most sensible best-effort here. It seems "make" isn't only looking
> at the slots to determine process management.

Actually, this doesn't seem to work at all. Interruption already behaves
correctly. I'm going to ignore this for now...

-- 
Kees Cook
