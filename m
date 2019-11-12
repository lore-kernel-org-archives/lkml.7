Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5358C17448
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE2821925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gMuZpNu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKLXPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:15:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37995 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfKLXPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:15:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so17645pgh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q/7zKomDvwvoQVmplaYbzXQkEiXPJRscqerdxI0XpvE=;
        b=gMuZpNu2ZWWW1U1Djp24A57ML3WMX9pxLpjzy9vcatjVYek6YJx07FQmY8w0YIjtWk
         npdddXUg54q759/2mZ1xUDLqAY/tN+mCvK2bLXfWZscdZbUFsmPrJ8mGS42dXbUexSqn
         FLkNDOuNubyqmyvpl7RPVvVrXPThIpjdJPxl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/7zKomDvwvoQVmplaYbzXQkEiXPJRscqerdxI0XpvE=;
        b=b95X35scxJ8EeYcvEJy+VNqF1z2mvFM/ATqKvVeYCClrlJAAtCaq2VYmTZEteg4OYw
         Wb0/iVrzd5pFntkRwxKf2U0wHY5kXuYHGl4H/QiefKP6JEjho91nhUvJUIFrfy1hZi3U
         iLb/jLwW6A55vmYsXa45094RPYpm+S091FVcZV6ziX2/FaHrDqOirKVIkMRDM8BqjrGq
         fCdcASxveG5wpep8PsaUE2rZCiFpqXvjgkilsRcCxKqk/hUPesIByMFLqJHelXLnBmC8
         BAmUM3dDlOnJBrDd2IPBbknNGmCyITYJp7owCKvu1MahqA2UDNvsLxUgRbp1zBvqsi75
         +6Xg==
X-Gm-Message-State: APjAAAUS7w2oyiJ46x8owA512Of43g4YLn8FgINZYMjQN2D3oaA57BHG
        rVucCX1gTm5nYhk2iHvt+WnbiA==
X-Google-Smtp-Source: APXvYqy+Au3kYLmA11xfFKoZBV6/GOO9I8Z5Zy4Zp4gEbzdOoKsHxdFIrmkacipgx8+7hy/Mu8ANxw==
X-Received: by 2002:a17:90a:3b0d:: with SMTP id d13mr473073pjc.86.1573600517339;
        Tue, 12 Nov 2019 15:15:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l74sm172205pje.29.2019.11.12.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:15:16 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:15:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
Message-ID: <201911121514.DA3BEED0@keescook>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <20191103175648.GA4603@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103175648.GA4603@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 12:56:48PM -0500, Theodore Y. Ts'o wrote:
> On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
> > Several items in /proc/sys need not be accessible to unprivileged
> > tasks. Let the system administrator change the permissions, but only
> > to more restrictive modes than what the sysctl tables allow.
> > 
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> 
> Why should restruct the system administrator from changing the
> permissions to one which is more lax than what the sysctl tables?
> 
> The system administrator is already very much trusted.  Why should we
> take that discretion away from the system administrator?

Generally speaking, they're there to provide some sense of boundary
between uid 0 and the kernel proper. I think it's correct to not allow
weakening of these permissions (which is the current state: no change at
all).

-- 
Kees Cook
