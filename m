Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A58C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF858213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgWVQkT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfCSLaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:30:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41466 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:30:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id a25so9049928edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 04:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ytHiib+dnGUjJNmKYiMd5LJAkJRVvfEmWqPaX2cg7Dc=;
        b=vgWVQkT6WaD1fCwIhWAZjTRVUkhAK3uBmMQq8jHkpV6NoG+RqkmeuUd1jUeVqyl+/c
         PQkCTOaZ/FzJTPWEOb0+wL8o42i6B50KIZZZazwpFvAuly4Un9B7yIG73C97IOE2Mwmx
         sIHxJiYGDG6S1Ml0X1cs0JBBueec0g8hFHBfi/odtkTEngZ0JtkN8JbbIXirn+iN3y09
         6S06BugYgpXHVelgiB0pfQm3gnNK1OtbGSwpWw70MMefe/yKBxIAr+UHzqcmJKm1YH4f
         YYno5K8KZ7+1B9KYTnrjZ+ElaEsHCAf4j3cFt3K0oDW7meP0inX2rcSLOtmWHjmTIOGk
         IU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytHiib+dnGUjJNmKYiMd5LJAkJRVvfEmWqPaX2cg7Dc=;
        b=lAp5+M4h4X5KYj+Hb8/MAKMvxQi5mhV3aqZlo8WCrvmypL7jGNNrdZW4d41dePFpwX
         lNuyYR3znJImWc+UPH7+891ZnB+t7M2cm/Me+ZzdKjZwZVhQDIrdauGXnTMk8E7HUjFJ
         vwyrr/7IwecX1aFSR1ICv8ejoTuG2w6IUgMeAuWptU4voK//pF5ReJRYAtHPYLixYKML
         T9ywD0mFlnylhWkfIBUjcd7XcjorFAR1r/7CWMu4B70fSTg2pli9yxBlZt874MWn7zDc
         MHiTCM5U0f345+1g+qzrsJ6Re6kvy4XtxbQn/X1SMXdLSjw/vzb9tLygwaNIMg6+h7Ae
         tDag==
X-Gm-Message-State: APjAAAWgA2GyzCmkqfI/z8RKm56yZePApn7ZNIOn9kf5dm8W1xBRRM8H
        rzB0hlw0XJSqx8E/NkUFhK2dAw==
X-Google-Smtp-Source: APXvYqzqCtfAR1UaYNdxT+SMXKeJpltVoYKpXbk1V/X8yGyYuAQcW4B3Z8d0SS72llhHHLYoBbJz1w==
X-Received: by 2002:a17:906:453:: with SMTP id e19mr14021837eja.197.1552995010701;
        Tue, 19 Mar 2019 04:30:10 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c9sm4066660eds.92.2019.03.19.04.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 04:30:09 -0700 (PDT)
Date:   Tue, 19 Mar 2019 11:30:08 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] tracing: Add trace_total_entries() /
 trace_total_entries_cpu()
Message-ID: <20190319113008.gpd3xtdtrbqytcr2@holly.lan>
References: <20190318204741.116550-1-dianders@chromium.org>
 <20190318204741.116550-2-dianders@chromium.org>
 <20190318171846.2b4fd8dd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318171846.2b4fd8dd@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 05:18:46PM -0400, Steven Rostedt wrote:
> On Mon, 18 Mar 2019 13:47:40 -0700
> Douglas Anderson <dianders@chromium.org> wrote:
> 
> > These two new exported functions will be used in a future patch by
> > kdb_ftdump() to quickly skip all but the last few trace entries.
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> Actually, I guess only this email needs the ack from Daniel.

I skipped this patch in v4 since I misunderstood and thought it was just
tweaking an existing trace API (which wouldn't really need an ack from
me).

I did offer a bit of feedback after reading it but TBH even if the
feedback is rejected I'm ok to ack:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
