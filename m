Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1403C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 09:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8FE21019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 09:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oU+ZcFt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfELJAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 05:00:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35308 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELJAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 05:00:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id w12so11971198wrp.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j4B9AahyvgqRvxwaL6wD5cqfXHCYttglyJEYujL0qsQ=;
        b=oU+ZcFt058u/TxK2MYqu/i0Mi722KKm6J4CTTnxt+/lczyY6tSF7dI1WSouc3NgXP2
         49TjJZB2s6CVpQsjeOLqWfhk1oxEc9u6VWYYr7bkklLRaASu5mzHwpW12PeV6ZDTV5fj
         3CmuDSeP9zOrRzKkDk7aCA1ZMe32lO/RalPYT2Xqe63aKPBVhfxuvqhFzMzETccvwuc1
         jcX+ezeZnc4Fa4bE62PYeQSKuXstJs1NkVwN06Ppi/fLuLd/fbQKjkgPZ+DQABDn+ffL
         Ckwzv1pI/HlAdS6eBtm+98Xo6W0DcW8WQrF9ASOVk0yJFsvs8ujl6dxYW+a/cCx63mOP
         h6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j4B9AahyvgqRvxwaL6wD5cqfXHCYttglyJEYujL0qsQ=;
        b=BhSlI/RnUra8EAudtRUIHpnzQh2qCuaNf1W1LDfpn4Jmpb2NFNL8zecvxWITiHc4N3
         ZGC41yu4PDCwpc6yu4lW1eQybIA8E146GbXGVFHiT3XZNnNFZl+QAFC/ZfEvTrjLgD9f
         Cz879gclwJyGMbmEQTIj/5gbKTPPnU9X7smken/7pivhCMprsP8a/XG9qGxhvEPsehnc
         xIeybyHGia8tUSkVQJYy1h/tI5WnCik361hHLTpOW8jaKCgTnN3s5QtRWs6fO2I2CBgc
         O5B1IEngWuYPJ/JauSeG0GyZtEOIbwCDWC26T1jpRRmXM6OF80aLvWWH9yFD0qvyFSaB
         NOgA==
X-Gm-Message-State: APjAAAX81NkaET1v32nDtqEvglC6D4A1eZb6cOBM5kJpMiElMaFokFo7
        RcPka3b4CJC8sVzfPUcYf2s8tw==
X-Google-Smtp-Source: APXvYqyDp+8DRh3jRC8/N/1sFPEvCMjTC3q/iUoKwjrDJ2laaR0SdSTzwvWgw2C3FLL+7KEh30wRLg==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr10542788wrn.201.1557651606071;
        Sun, 12 May 2019 02:00:06 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d14sm8310542wre.78.2019.05.12.02.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 02:00:05 -0700 (PDT)
Date:   Sun, 12 May 2019 10:00:03 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Wenlin Kang <wenlin.kang@windriver.com>
Cc:     jason.wessel@windriver.com, prarit@redhat.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix bound check compiler warning
Message-ID: <20190512090003.de52davu55rrg7kn@wychelm.lan>
References: <1557280359-202637-1-git-send-email-wenlin.kang@windriver.com>
 <20190508081640.tvtnazr4tf5jijh7@holly.lan>
 <ac8af42c-e69d-6fd0-1d76-73a37e8a672c@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8af42c-e69d-6fd0-1d76-73a37e8a672c@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 10:56:03AM +0800, Wenlin Kang wrote:
> On 5/8/19 4:16 PM, Daniel Thompson wrote:
> > On Wed, May 08, 2019 at 09:52:39AM +0800, Wenlin Kang wrote:
> > > The strncpy() function may leave the destination string buffer
> > > unterminated, better use strlcpy() instead.
> > > 
> > > This fixes the following warning with gcc 8.2:
> > > 
> > > kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
> > > kernel/debug/kdb/kdb_io.c:449:3: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
> > >     strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> > >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
> > > ---
> > >   kernel/debug/kdb/kdb_io.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > > index 6a4b414..7fd4513 100644
> > > --- a/kernel/debug/kdb/kdb_io.c
> > > +++ b/kernel/debug/kdb/kdb_io.c
> > > @@ -446,7 +446,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
> > >   char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
> > >   {
> > >   	if (prompt && kdb_prompt_str != prompt)
> > > -		strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> > > +		strlcpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> > Shouldn't that be strscpy?
> 
> 
> Hi Daniel
> 
> I thought about strscpy, but I think strlcpy is better, because it only copy
> the real number of characters if src string less than that size.

Sorry, I'm confused by this. What behavior does strscpy() have that you
consider undesirable in this case?


Daniel.
