Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084D1C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD31206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuL7aQSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfJFFBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 01:01:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37978 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfJFFBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 01:01:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so9251398wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 22:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tTvAuzGrj/MaPLYLsAwRasMomLPOQMmMC24Exul2pJo=;
        b=GuL7aQSDIQWPIdAcQ9Nt/0D4W+tz6PgwMt55Bhf1YJo6ds/MBb/JvrI3avuLcMq+Os
         Mzx7Ced4FgCUuIRkGwSz8AdrSrS0fn+BAuytVpeujtg3fgw/V/KhYQNzdkAlXsFBBjHT
         kU+AsWK78V4XQ+hM5yhfsenI1W51D1hWTyOGhjeIkERaz0MYANAiQYXTe98NfR1ncDId
         roIE0kyOcOJn0uoAvq+fBq4HIH1Z802qxRBuuiKKUAgPYlqZBDZcvw2FZeuJ05m6kskL
         GeT06yX8zVZfEghgVSULaDGgwNSNFImn1VKljDsTlRScSHQ+iEITXnV7FnjIm3OfPkqu
         OnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tTvAuzGrj/MaPLYLsAwRasMomLPOQMmMC24Exul2pJo=;
        b=I68eLzTAlcHAtM7xnLF1fCe8GaqH7ktLP259/IPcz26NKgdTQHDyDWeog+F+0IPcz9
         Alz59YQozuWkXTEgyw84mnOyy7GEwA4FWi7rV8//bPrcwxq5AQTiw6Mf3eqrro581bhx
         tMUW3xtPB5TX6kAO2BzdIjD1DkCtx57ZIN0h8ysTEVgpXbEgMmHCHUT8AbfFwWqJd7OE
         nGxr/Hma/ZB6LvOSnrtw+RujSOARoINWcfeQ84HdH+MajSg5yABiPfnAvwJn4KamMob1
         /lu+sNvGnrSp4M9AtlttPvmzpOhCgolk7UGv4o+7ILZ7F0GNPREaXrLgpOlZKhWCLiej
         nglw==
X-Gm-Message-State: APjAAAWhkIGQxJjDenlxEnVsr+VJGN8yQdKPW840C3LkK+NeHurDHb+D
        dcGbAAHDXMgvdSa67Nv7vU8=
X-Google-Smtp-Source: APXvYqxp25S/Q6VgwuI0Y8RtglJDYEwB/uyXL3HZuMWNDz2aalxr3wtvUdlrm/wHN06+uREqzjhV1g==
X-Received: by 2002:a1c:968b:: with SMTP id y133mr15582411wmd.56.1570338099787;
        Sat, 05 Oct 2019 22:01:39 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id r27sm32339652wrc.55.2019.10.05.22.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 22:01:39 -0700 (PDT)
Date:   Sat, 5 Oct 2019 22:01:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: test_user_copy: style cleanup
Message-ID: <20191006050137.GA1789703@archlinux-threadripper>
References: <20191005233028.18566-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005233028.18566-1-cyphar@cyphar.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 10:30:28AM +1100, Aleksa Sarai wrote:
> While writing the tests for copy_struct_from_user(), I used a construct
> that Linus doesn't appear to be too fond of:
> 
> On 2019-10-04, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Hmm. That code is ugly, both before and after the fix.
> >
> > This just doesn't make sense for so many reasons:
> >
> >         if ((ret |= test(umem_src == NULL, "kmalloc failed")))
> >
> > where the insanity comes from
> >
> >  - why "|=" when you know that "ret" was zero before (and it had to
> >    be, for the test to make sense)
> >
> >  - why do this as a single line anyway?
> >
> >  - don't do the stupid "double parenthesis" to hide a warning. Make it
> >    use an actual comparison if you add a layer of parentheses.
> 
> So instead, use a bog-standard check that isn't nearly as ugly.
> 
> Fixes: 341115822f88 ("usercopy: Add parentheses around assignment in test_copy_struct_from_user")
> Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

I assume the comment diff is a line length/alignment thing? The commit
message does not mention it.

Regardless, thank you for providing the fix that I should have.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
