Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A43C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB730207FF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTke3Cc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgAGFT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 00:19:57 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:32906 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgAGFT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 00:19:57 -0500
Received: by mail-pj1-f65.google.com with SMTP id u63so4934894pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 21:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o424RCYfUnkY205fqTDroBAVPlaoUOrgoI5FseVpUN0=;
        b=qTke3Cc+OKnCWiGKR/Q0maKi0YSJRPT9Y774n9qyP7g04f5Xo2B5ex+fObXmEAPzr2
         U/ruLoaIegItXTcUrJk4b0MGJY/txM+7poyXtNyWLxUUa3eDJMrtIYXjjQZTFsO4btFe
         3UstS7AK/HbX5zLber8BthVJBmZ+n3edew9DVUtupbvMtLNOmBtTSJhs/kSUiEpatXT7
         KpjPVVFwcT26EU9m+Sy/lj1MnbSoSdBMHW3H2O+qxks62i2kCJOrfdWgGPTPSI10hPxK
         7Ih7DGwoXKyb2DeaQkvmEQso7JnOiMgGFwAtPksGdV9C8XPfueC0JDT+Ux5PgxHx1Hja
         oCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o424RCYfUnkY205fqTDroBAVPlaoUOrgoI5FseVpUN0=;
        b=dHHAzDNwVLi2oXrHQ5VvFvcIQg7NkFXDuinSQJyR+I40RAnzcUsox8cV0c/XiPGE2L
         bEFK23pvR8SJ/AU8PJlmUr6IrsfTPTLe0FAaHfqS7x/Qw1YihetoHLxQwkMSEI0G3kEh
         mvhbFv+b0MaVD04rJPlYV3+DS9hTPLgyJwmD1BiSrnb4Q938Rr2hSfGrcPM7Fxt2b3HB
         PZK+XO//xhbTiR+dV9Wf/Zbk0zqc0O/6Lgds74RIEoIfIJ12a8XaLReKElz6ClyRfQD5
         zxj0GJdfdTqB8om023G+80yFOJDxLWkpOXFB1LvRNpYL/l4+0ryfVZxdebnIRSsmN9pA
         OMuA==
X-Gm-Message-State: APjAAAVeCoki1WLENBBKS6D7fDGIJ6PI/mjuktYo5ZFWHyyzc3HF4PHL
        S8dqn5S/YcV5Fa175vJa5+U=
X-Google-Smtp-Source: APXvYqxl6YMJ6s/KynQ1XKsRs4hBUy+BjJHxzUXj28pZrQnNtd1wE3oN59QVK/izq6KVbRQzEVSZPw==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr48255384pjz.116.1578374396521;
        Mon, 06 Jan 2020 21:19:56 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id 7sm70774607pfx.52.2020.01.06.21.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 21:19:55 -0800 (PST)
Date:   Tue, 7 Jan 2020 14:19:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] printk: Fix preferred console selection with multiple
 matches
Message-ID: <20200107051954.GA205756@google.com>
References: <2712d7e2fb68bca06a33e2e062fc8e65a2652410.camel@kernel.crashing.org>
 <20191219135053.xr67lybhycepcxkp@pathway.suse.cz>
 <32fde8cd451ea0eaff38108d9f2f2d4a97a43097.camel@kernel.crashing.org>
 <20191220091131.4uifcbudwppjspf4@pathway.suse.cz>
 <20200106051508.GA17351@google.com>
 <20200106102537.nirnfcauqdh4olgv@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106102537.nirnfcauqdh4olgv@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/06 11:25), Petr Mladek wrote:
> On Mon 2020-01-06 14:15:08, Sergey Senozhatsky wrote:
> > On (19/12/20 10:11), Petr Mladek wrote:
> > [..]
> > > > > > +enum con_match {
> > > > > > +	con_matched,
> > > > > > +	con_matched_preferred,
> > > > > > +	con_braille,
> > > > > > +	con_failed,
> > > > > > +	con_no_match,
> > > > > > +};
> > > > > 
> > > > > Please, replace this with int, where:
> > > > > 
> > > > >    + con_matched -> 0
> > > > >    + con_matched_preferred -> 0 and make "has_preferred" global variable
> > > > >    + con_braile -> 0		later check for CON_BRL flag
> > > > >    + con_failed -> -EFAULT
> > > > >    + con_no_match -> -ENOENT
> > > > 
> > > > Not fan of using -EFAULT here, it's a detail since it's rather kernel
> > > > internal, but I'd rather use -ENXIO for no match and -EIO for failed
> > > > (or pass the original error code up if any). That said it's really bike
> > > > shed painting at this point :-)
> > > 
> > > Sigh, either variant is somehow confusing.
> > > 
> > > I think that -ENOENT is a bit better than -EIO. It is abbreviation of
> > > "No entry or No entity" which quite fits here. Also the device might
> > > exist but it is not used when not requested.
> > 
> > Can we please keep the enum? Enum is super self-descriptive, can't
> > get any better. Any other alternative - be it -EFAULT or -EIO or
> > -ENOENT - would force one to always look at what is actually going
> > on in try_match_new_console() and what particular errno means. None
> > of those errnos fit, they make things cryptic. IMHO.
> 
> I agree that the enums are more self-descriptive. My problem with it is
> that there are 5 values. I wanted to check how they were handled
> and neither 'con_matched' nor 'con_failed' were later used.

Right, I also saw that not all con_match were used, but I didn't consider
it to be an issue, con_match describes all possible cases (completeness)
but not all of those cases exist in the code.

try_match_new_console() is going to return multiple error codes anyway,
all of which should be handled. Switching to `int' (4 billion possible
values) probably doesn't really help us.

> I though how to improve it. And I ended with feeling that the enum
> did more harm then good. -E??? codes are a bit less descriptive
> but there are only two. The meaning can be explained easily by
> a comment above the function.

I understand it. It's just we don't have appropriate errnos. So instead
of only documenting the logic (because enum is self-documenting), with
errnos we also need to document the return values we check. IMHO.

	-ss
