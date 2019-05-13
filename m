Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F827C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70C221019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsdcE677"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfEMHot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:44:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45108 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfEMHor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:44:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so4023844wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GbstJVyW1AtQn0uCOokyeICMnnihu2g5VNt0MV0fVRw=;
        b=NsdcE677iiLa6/IG0QmYfUg1mJqtJgcJIBPmrYoGXf7HmCEJJIm0yONFrNG9JD73jM
         7+dFIEL9HKpTCmVMlx7GoRq7P2BSklJhQ6v2MN+kVtpjc5sK+sBmnoiI61faAD3LOFpK
         xm3JpbHXFaMd1B5lP9KyEtk7HO2ZghB061Oh7U3TIy7btqR295rwud6g3jAxJxnhwov1
         nIqRnSqQF6YtMRZ1lUUm0Y6CJd1V80mJW1oeBc8KeNoUUQqGrEfO3dgnvir5pa3zrFzW
         Spe9k2wBvyQhswd3H8VwU8YEDGW8bBtB6dHfeErWVrRKBnc4LF5a9XyXkSly9b13zOmq
         jdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GbstJVyW1AtQn0uCOokyeICMnnihu2g5VNt0MV0fVRw=;
        b=HjYTQtuF4GLNC4jfNhoIUEZ4M3gEyblFrGpKmg7Xv6xqMe40jz2Nhp80PpO0xb4RHj
         UDTuJMDLJNg03SaFUbuyyx159gQvjMPt8PDsV1kGkXI/c96GTmRmxYK3CmYxhs4ZFe4v
         364hVKujjGxDyfY9LSxSYUtqYC33KMNUHlG4X6jX2y4XeujLKgRCJ7OEbEZs/9ffi7wL
         vzFqeQjmwoapdijqKUlJfaEOi5mGfyMt+4IpVqZeSZ7fXEGEVVuRY5FFOQ+HtBSkUBsL
         pa7LBPhDnHU41HjXOu7H6lFT1M+CMPbcdQveWzjrbCf0zosvlrym0/bhHKK+17M1Ymth
         L9vw==
X-Gm-Message-State: APjAAAU7yYkk3fpUQEhc4VWQiDR5ncgx4WDo9kj5jqX2MgD/Hwb3q5XN
        9F+iaoiT/2ujdxYHUqvLkV7Eog==
X-Google-Smtp-Source: APXvYqy26b5mNoq9PPPNs08FcGKst+gUyWf/A1XghrrIho6WmjLmmKyzPwn2tDVdt9/FuWw0mNY/aw==
X-Received: by 2002:adf:f841:: with SMTP id d1mr9758107wrq.62.1557733486527;
        Mon, 13 May 2019 00:44:46 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g2sm3521885wru.37.2019.05.13.00.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 00:44:45 -0700 (PDT)
Date:   Mon, 13 May 2019 08:44:44 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Wenlin Kang <wenlin.kang@windriver.com>
Cc:     jason.wessel@windriver.com, prarit@redhat.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix bound check compiler warning
Message-ID: <20190513074444.eftse5jimrl4xtc7@holly.lan>
References: <1557280359-202637-1-git-send-email-wenlin.kang@windriver.com>
 <20190508081640.tvtnazr4tf5jijh7@holly.lan>
 <ac8af42c-e69d-6fd0-1d76-73a37e8a672c@windriver.com>
 <20190512090003.de52davu55rrg7kn@wychelm.lan>
 <0c5121f7-645c-3651-cccc-2ae836d415b6@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5121f7-645c-3651-cccc-2ae836d415b6@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 11:39:47AM +0800, Wenlin Kang wrote:
> On 5/12/19 5:00 PM, Daniel Thompson wrote:
> > On Thu, May 09, 2019 at 10:56:03AM +0800, Wenlin Kang wrote:
> > > On 5/8/19 4:16 PM, Daniel Thompson wrote:
> > > > On Wed, May 08, 2019 at 09:52:39AM +0800, Wenlin Kang wrote:
> > > > > The strncpy() function may leave the destination string buffer
> > > > > unterminated, better use strlcpy() instead.
> > > > > 
> > > > > This fixes the following warning with gcc 8.2:
> > > > > 
> > > > > kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
> > > > > kernel/debug/kdb/kdb_io.c:449:3: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
> > > > >      strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> > > > >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > 
> > > > > Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
> > > > > ---
> > > > >    kernel/debug/kdb/kdb_io.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > > > > index 6a4b414..7fd4513 100644
> > > > > --- a/kernel/debug/kdb/kdb_io.c
> > > > > +++ b/kernel/debug/kdb/kdb_io.c
> > > > > @@ -446,7 +446,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
> > > > >    char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
> > > > >    {
> > > > >    	if (prompt && kdb_prompt_str != prompt)
> > > > > -		strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> > > > > +		strlcpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> > > > Shouldn't that be strscpy?
> > > 
> > > Hi Daniel
> > > 
> > > I thought about strscpy, but I think strlcpy is better, because it only copy
> > > the real number of characters if src string less than that size.
> > Sorry, I'm confused by this. What behavior does strscpy() have that you
> > consider undesirable in this case?
> 
> 
> Hi Daniel
> 
> I checked strscpy() again, and think either is fine to me, if you think
> strscpy() is better, I can change it to this, and send v2, thanks for your
> review.

I think strscpy() is better.


Daniel.

> 
> 
> > 
> > Daniel.
> > 
> 
> -- 
> Thanks,
> Wenlin Kang
> 
