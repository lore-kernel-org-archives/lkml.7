Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202F9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBCF218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdoZ6xic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfDXMqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:46:05 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38869 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfDXMqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:46:04 -0400
Received: by mail-yb1-f194.google.com with SMTP id a13so871241ybm.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=As6uk2DhYTW1wYuwtzJCnQmFuf1wfWhskoVX4TFR+Sc=;
        b=qdoZ6xicj/F+/BD3vE/23ThNFm5gk999tLcbBoOnJ2c3z93BHEd15LCSSIpqmFoLdH
         AiXGbJ5cWHJsPx5cSAolxFiXuN83fykBe4NaUlaGwxwMgAODb4Xl/Afqt728oOrHkup7
         AMamLH3hJWh1MUQgKKwUzSNnz390nhaBesdRNHSxaBPG5moNZM+W7uZkzj7ZZTHz2PKV
         pwDJjHWueP3bbizfl8DO9ylyf2YKvcMG+nYiXOnFbxYy3NVOyYkE3tWbu9FmfpvPm1WY
         WR7u3JZT0PbU65g6o7I3NX6GLuucVTyUef5+Ry5jUI2F8eRQskCEvN4OoRBqZJsuKGwf
         PEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=As6uk2DhYTW1wYuwtzJCnQmFuf1wfWhskoVX4TFR+Sc=;
        b=iGvvZnJQo+wYX+xcONveClsi3xYCjX3w/vsVnnKq39tf4lqh4m69SP02IMG4aEWA5w
         C/HXH8+9l+ZyYVkLHQvQ+9QaDBgzEM5cFnOoCzlTt10V2QM0ffQZst0FXmzRDwFIqQeW
         y3+XPDohTfkKZIhDEnq7yisydNYpOVUJBkKm8UOp332kvjpqDeQ18U8ZnSBA/MGlC8wP
         8qJszw+eUnHuYjK+s41B0bAZ7Pc0B+tBIB0CGBIQzIa66bqh8dIONWQVNefKzY+RQZPO
         HvZJ6BTv5g72RzJmxudR64JEk6eHnlHIgNLZf5Y7pvxUDN6mydSz+6z2KfWs3M2XJfJ5
         Yzig==
X-Gm-Message-State: APjAAAUB0gHM+CdtiO0R3PtE9SuVMuXMBFS8p66lx3fcAbj3QAJAr1ub
        aFMC+XaH60UTSlql4xh2oWcYYw==
X-Google-Smtp-Source: APXvYqzG1LvcHxN6vXL7agUw4cG0325tlPWxuGpPfSifUUjcdqEM3+P4Wu1M5NkSBs9qdw8p56Arrg==
X-Received: by 2002:a25:41c5:: with SMTP id o188mr26360525yba.249.1556109963297;
        Wed, 24 Apr 2019 05:46:03 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id a4sm6655317ywa.7.2019.04.24.05.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 05:46:02 -0700 (PDT)
Date:   Wed, 24 Apr 2019 20:45:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools lib traceevent: Change tag string for error
Message-ID: <20190424124556.GA8948@leoy-ThinkPad-X240s>
References: <20190424013802.27569-1-leo.yan@linaro.org>
 <20190424080829.0043469b@gandalf.local.home>
 <20190424124427.GC4339@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424124427.GC4339@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:44:27AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 24, 2019 at 08:08:29AM -0400, Steven Rostedt escreveu:
> > On Wed, 24 Apr 2019 09:38:02 +0800
> > Leo Yan <leo.yan@linaro.org> wrote:
> > 
> > > The traceevnt lib is used by perf tool, when execute 'perf test -v 6' it
> > > outputs error log on ARM64 platform:
> > > 
> > >   running test 33 '*:*'trace-cmd: No such file or directory
> > > 
> > >   [...]
> > > 
> > >   trace-cmd: Invalid argument
> > > 
> > > The trace event parsing code originally came from trace-cmd so it keeps
> > > the tag string "trace-cmd" for errors, this easily introduces the
> > > impression that perf tool launches trace-cmd command for trace event
> > > parsing, but in fact the related parsing is accomplished by traceevent
> > > lib.
> > > 
> > > This patch changes the tag string to "libtraceevent" so can avoid
> > > confusion and let users to be more easily to connect the error with
> > > traceevent lib.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > 
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Arnaldo,
> > 
> > Can you pull this into your tree.
> 
> Sure, applied.

Thanks, Steven and Arnaldo.
