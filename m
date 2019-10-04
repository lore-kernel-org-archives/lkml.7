Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AACC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46CE20873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hZFdMVFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390273AbfJDQIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:08:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33116 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389835AbfJDQIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:08:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so4207280pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qrCnb7i9JDwc6blmAIDbox87WNow8e8t5hEwB+pWVBs=;
        b=hZFdMVFV7j843awiFhtiwvubJHpPI7ra02+62OBzo9GoxRoBuqEmV6toR7JIz8BCFr
         6UnvZctpbn4vMcN0Ayo9VIWXQBX+TpFrrYl8BQQg+j6WAJDUD6EWhYrDH99gYyzCcUo6
         vy10MIyb6Q93JecjIljYmaKCdx2Vs/MZtVUYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qrCnb7i9JDwc6blmAIDbox87WNow8e8t5hEwB+pWVBs=;
        b=mvpB33KP2MkFKJAgYC1dFLegZ18XRNIDYuyp5a091v0OmW9Fx2icT+wp1jlOtoQj9J
         QzRFrkKJ3RlhvnhnsdkesF8d3nuiB3VTess9lbuhDlBG0yQrhVclEQ70W2lEZ8xnh3gT
         qHuhSMrJz8ZzP+7wLLf5g811jvnZLbNc7Cpq9eH7T266uXXfzX7FY+j+MDga9O2pNalt
         M01xUAhqXVMwq0kfvdasPdZhROBJn+xsaA7J+N+n4/bdLjFQyDVuYFHJjvgmRjyzQZ4P
         L+Ir6kHWsWG9ZdNr1PXvRT7L6/1LZj5psibs9Fr7UPwp+GM7WM93MDHNsBCElYoU3Z9K
         czCw==
X-Gm-Message-State: APjAAAUXEHb2GGTu22JsI8QLaCbimXj2+JuHgu0KsvlHWXoXXQ2eb6RI
        oZ1AAxmoXvx27DL9/4xa6mm1nYQSfNM=
X-Google-Smtp-Source: APXvYqz5w9xK4kX8GbSZOFca7EyZFYY9c4Vb2LaIIQ6NnRL73yrrHDXHJz7b/SiMjslmBxwS1nBTKA==
X-Received: by 2002:aa7:9ab4:: with SMTP id x20mr18521389pfi.59.1570205314226;
        Fri, 04 Oct 2019 09:08:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n8sm7333945pgt.40.2019.10.04.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:08:33 -0700 (PDT)
Date:   Fri, 4 Oct 2019 09:08:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: Use make invocation's -j argument for
 parallelism
Message-ID: <201910040904.43B61E4@keescook>
References: <201909241627.CEA19509@keescook>
 <eb25959a-9ec4-3530-2031-d9d716b40b20@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb25959a-9ec4-3530-2031-d9d716b40b20@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 11:15:46AM +0200, Rasmus Villemoes wrote:
> On 25/09/2019 01.29, Kees Cook wrote:
> > +# Extract and prepare jobserver file descriptors from envirnoment.
> > +try:
> > +	# Fetch the make environment options.
> > +	flags = os.environ['MAKEFLAGS']
> > +
> > +	# Look for "--jobserver=R,W"
> > +	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
> 
> OK, this handles the fact that Make changed from --jobserver-fds to
> --jobserver-auth at some point. Probably the comment could be more accurate.

I can update that, sure.

> > +# Read out as many jobserver slots as possible.
> > +jobs = b""
> > +while True:
> > +	try:
> > +		slot = os.read(reader, 1)
> > +		jobs += slot
> > +	except (OSError, IOError) as e:
> > +		if e.errno == errno.EWOULDBLOCK:
> > +			# Stop when reach the end of the jobserver queue.
> > +			break
> > +		raise e
> 
> Ah, reading more carefully you set O_NONBLOCK explicitly. Well, older
> Makes are going to be very unhappy about that (remember that it's a
> property of the file description and not file descriptor). They don't
> expect EAGAIN when fetching a token, so fail hard. Probably not when
> htmldocs is the only target, because in that case the toplevel Make just
> reads back the exact number of tokens it put in as a sanity check, but
> if it builds other targets/spawns other submakes, I think this breaks.

Do you mean the processes sharing the file will suddenly gain
O_NONBLOCK? I didn't think that was true, but I can test. If it is true,
we could easily just restore the state before exit.

> > +# Return all the reserved slots.
> > +os.write(writer, jobs)
> 
> Well, that probably works ok for the isolated case of a toplevel "make
> -j12 htmldocs", but if you're building other targets ("make -j12
> htmldocs vmlinux") this will effectively inject however many tokens the
> above loop grabbed (which might not be all if the top-level make has
> started things related to the vmlinux target), so for the duration of
> the docs build, there will be more processes running than asked for.

That is true, yes, though I still think it's an improvement over the
existing case of sphinx-build getting run with -jauto which lands us in
the same (or worse) position.

The best solution would be to teach sphinx-build about the Make
jobserver, though I expect that would be weird. Another idea would be to
hold the reservation until sphinx-build finishes and THEN return the
slots? That would likely need to change from a utility to a sphinx-build
wrapper...

> > +# If the jobserver was (impossibly) full or communication failed, use default.
> > +if len(jobs) < 1:
> > +	print(default)
> > +
> > +# Report available slots (with a bump for our caller's reserveration).
> > +print(len(jobs) + 1)
> 
> There's a missing exit() or else: here; if len(jobs) < 1 you print both
> default (probably "1") and 0+1 aka "1".

Whoops! Yes, that needs fixing too. I'll send a patch...

-- 
Kees Cook
