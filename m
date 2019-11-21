Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E47C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942BD206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvzhMiJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKUTJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:09:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33203 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:09:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so2023065plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=512M0jNKnpjQCVGlztaNviSFeHJgudNPE/mVt3EA2jY=;
        b=KvzhMiJ/FqEem7WAqVSVWVE0BXFKNvDf6cbkhw+1rbjEdn85GzRjaVdbAOa+5YLaGn
         qP1zc0EpcTp7UUjx+bet/L7YmKvoFJIjDtCldnbT7U5K5IdtQEf8DVy+gfL3kb06Tg0L
         zBcP6s4y2zTGOFtqX/0Zi4Wp7bgmz6Vm6EP/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=512M0jNKnpjQCVGlztaNviSFeHJgudNPE/mVt3EA2jY=;
        b=d25mkYAsCbuLW5WYgey+j/ytNeDQsz5zz+54yZ2rNWcU9iMr+CeMJkAAVze9rE9Lgm
         z3cxovpAjy0/YwMYsRSsBZPCm6llhBO5N02J3lXWgBqJ6ucyHfAQGXuvdMhsSkUl+PyP
         GgX4c0RURnT4D2u1+u2K8R4qo9FYV9uv7bulm/Ra+hm5H6BvEyqqtgl0WCoadFjQH56U
         MlbpUu/tQVR7WYHhG0U4gboen3qpKQwM+otzwVbO+HHAOUbBQySLUpIiD9Dqb2UyiQ9E
         q9q6HIFhVddEZOoR0N2M/X7vMEbriCDU2DVIVboCayLupR01P9zfFdyA1fOFLVbdiPuY
         n8Bg==
X-Gm-Message-State: APjAAAXnegTwgkoEPP58wZGNtveT0FxIf8o8CzrllCPCYksu+kvPvAab
        eXwLfyCV6DuQX5KXBNYiaaRsSw==
X-Google-Smtp-Source: APXvYqzqEOFIMW88MCGVO5CnDlRORr2cQvFdA6SJPsREDlrTe/t/m9MweFgSt06pzTKJbzZGQf47ow==
X-Received: by 2002:a17:902:ac84:: with SMTP id h4mr10557273plr.328.1574363346681;
        Thu, 21 Nov 2019 11:09:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16sm4390942pfc.21.2019.11.21.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:09:05 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:09:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] docs, parallelism: Do not leak blocking mode to
 writer
Message-ID: <201911211105.E11EEBAC4@keescook>
References: <20191121000304.48829-1-keescook@chromium.org>
 <20191121000304.48829-3-keescook@chromium.org>
 <041953ef-0b6c-4ea8-8734-aa1e6703f9f8@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041953ef-0b6c-4ea8-8734-aa1e6703f9f8@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 08:41:01AM +0100, Rasmus Villemoes wrote:
> On 21/11/2019 01.03, Kees Cook wrote:
> > Setting non-blocking via a local copy of the jobserver file descriptor
> > is safer than just assuming the writer on the original fd is prepared
> > for it to be non-blocking.
> 
> This is a bit inaccurate. The fd referring to the write side of the pipe
> is always blocking - it has to be, due to the protocol requiring you to
> write back the tokens you've read, so you can't just drop a token on the
> floor. But it's also rather moot, since the pipe will never hold
> anywhere near 4096 bytes, let alone a (linux) pipe's default capacity of
> 64K.
> 
> But what we cannot do is change the mode of the open file description to
> non-blocking for the read side, in case the parent make (or some sibling
> process that has also inherited the same "struct file") expects it to be
> blocking.

Ah! This explains my confusion over what you were trying to tell me
before. I thought you meant the other end of the pipe, which seemed
crazy. You mean the other jobserver readers (i.e. "make" itself) who
have the same shared _reader_ fd. This is exactly what you said, but I
was too dense. :)

I'll fix this up!

> 
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Link: https://lore.kernel.org/lkml/44c01043-ab24-b4de-6544-e8efd153e27a@rasmusvillemoes.dk
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  scripts/jobserver-count | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/scripts/jobserver-count b/scripts/jobserver-count
> > index 6e15b38df3d0..a68a04ad304f 100755
> > --- a/scripts/jobserver-count
> > +++ b/scripts/jobserver-count
> > @@ -12,12 +12,6 @@ default="1"
> >  if len(sys.argv) > 1:
> >  	default=sys.argv[1]
> >  
> > -# Set non-blocking for a given file descriptor.
> > -def nonblock(fd):
> > -	flags = fcntl.fcntl(fd, fcntl.F_GETFL)
> > -	fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
> > -	return fd
> > -
> >  # Extract and prepare jobserver file descriptors from envirnoment.
> >  try:
> >  	# Fetch the make environment options.
> > @@ -31,8 +25,13 @@ try:
> >  	# Parse out R,W file descriptor numbers and set them nonblocking.
> >  	fds = opts[0].split("=", 1)[1]
> >  	reader, writer = [int(x) for x in fds.split(",", 1)]
> > -	reader = nonblock(reader)
> > -except (KeyError, IndexError, ValueError, IOError):
> > +	# Open a private copy of reader to avoid setting nonblocking
> > +	# on an unexpecting writer.
> 
> s/writer/reader/
> 
> > +	reader = os.open("/proc/self/fd/%d" % (reader), os.O_RDONLY)
> > +	flags = fcntl.fcntl(reader, fcntl.F_GETFL)
> > +	fcntl.fcntl(reader, fcntl.F_SETFL, flags | os.O_NONBLOCK)
> 
> I think you can just specify O_NONBLOCK in the open() call so you avoid
> those two fcntls.

Hah. Yes indeed.

-- 
Kees Cook
