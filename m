Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB484C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9040E20723
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QYMnEMQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfKOQtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:49:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36989 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfKOQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:49:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id bb5so5038535plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ptqDM2bmHnot4adtaFSv3VaRZd83rjxzM9yPEL0ZiVQ=;
        b=QYMnEMQdAAVP1ErDUxIsFQ6DlszLOn9whrvq/Y2SkMm3zbUFH+xz7ZikY3RfYWSyFL
         CgLAPq64BHMWfuyf6WB4hq42WvHXD1+xlybGrdxKdVwbyB7Goxz+ZSO9LU3F6eWD2L5g
         ONFqp4+EO1xyjzoG/IdQWW4dq6e9+ckLUvZjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ptqDM2bmHnot4adtaFSv3VaRZd83rjxzM9yPEL0ZiVQ=;
        b=MOL5fWDgBrN+S7U7k9e3MapKUj6qx/NkXMFG2EcMCGjMMyMe3xts4AcVOZEf7IgL3e
         N5hdEzl1w3Lz7V6uISY2CB7n3nXigV/bvmW55oHKAFTnJjjKl6hXJaQ/lMT0/UkEztW9
         SF3Lj+slgmvutM6fvmgkDeNFg1jmRqEu+f3Ti61mvy5uOnFGZT9a+kv7sNC6QuGEl+74
         j0ct+54tkriG8PER5W5+WBoXia5SSWAUUiClV95vR9zlr/CdC/A6YsMYJgU3Dv8m6FSp
         xVzbYAg4HkzyDIz+51phF1skCx0pPhcvBZSf9cOj5wgJ2iUC6lVEE9kLfHGZK0Xtw5Kf
         8fLQ==
X-Gm-Message-State: APjAAAW0c/A5i/Qk5FM7cU9Wy/j+otgWyucdm+dMoVjMrWG8fwbu3kMd
        JMIA3Cg4+l6DzF1svNPyMlDgwFMtfpU=
X-Google-Smtp-Source: APXvYqx05o7Lzkd/xkkJdoxu2DTq4WyYxecLtO0mGNyWyc+EB6il/XJ0N+kSYVGwAcNEssnj4S4clA==
X-Received: by 2002:a17:902:6903:: with SMTP id j3mr7357486plk.231.1573836588247;
        Fri, 15 Nov 2019 08:49:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x29sm11756518pfj.131.2019.11.15.08.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:49:47 -0800 (PST)
Date:   Fri, 15 Nov 2019 08:49:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Romain Perier <romain.perier@gmail.com>
Subject: Re: [PATCH] staging: rtl*: Remove tasklet callback casts
Message-ID: <201911150848.4518DFCA1@keescook>
References: <201911142135.5656E23@keescook>
 <20191115061610.GA1034830@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115061610.GA1034830@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 02:16:10PM +0800, Greg Kroah-Hartman wrote:
> On Thu, Nov 14, 2019 at 09:39:00PM -0800, Kees Cook wrote:
> > In order to make the entire kernel usable under Clang's Control Flow
> > Integrity protections, function prototype casts need to be avoided
> > because this will trip CFI checks at runtime (i.e. a mismatch between
> > the caller's expected function prototype and the destination function's
> > prototype). Many of these cases can be found with -Wcast-function-type,
> > which found that the rtl wifi drivers had a bunch of needless function
> > casts. Remove function casts for tasklet callbacks in the various drivers.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c        |  3 +--
> >  drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c        |  3 +--
> >  drivers/staging/rtl8188eu/include/rtl8188e_recv.h     |  2 +-
> >  drivers/staging/rtl8188eu/include/rtl8188e_xmit.h     |  2 +-
> >  drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c      |  4 ++--
> >  drivers/staging/rtl8192e/rtllib_softmac.c             |  7 +++----
> >  .../staging/rtl8192u/ieee80211/ieee80211_softmac.c    |  7 +++----
> >  drivers/staging/rtl8192u/r8192U_core.c                |  8 ++++----
> >  drivers/staging/rtl8712/rtl8712_recv.c                | 11 +++++------
> >  drivers/staging/rtl8712/rtl871x_xmit.c                |  5 ++---
> >  drivers/staging/rtl8712/rtl871x_xmit.h                |  2 +-
> >  drivers/staging/rtl8712/usb_ops_linux.c               |  4 ++--
> >  drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c        | 11 ++++-------
> >  13 files changed, 30 insertions(+), 39 deletions(-)
> 
> This fails to apply to my staging-next branch of staging.git.  Can you
> rebase and resend?

Ah, hrm, sorry. I think I was based on Linus's master. I will adjust!

-- 
Kees Cook
