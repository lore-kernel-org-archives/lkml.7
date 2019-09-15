Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8C5C4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0920830
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568564805;
	bh=5ygbA9QqwybqG5m1QRvHzKJH4t2jj65IdFze6EFpWPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Keo9Vyd5QydfF0Xj2VPKvf9YezUN3uqLNIdb9apphIqlEczOlZSK6B26OlWs2TgG9
	 xArzpHI6IE+HDSwSgO4emoALGr9wjIowBOXvspzT4pQqlAvOi9ta+FBdKC99fSKgjG
	 MLBtSgxAPx8rB+RA6V55dZoSfHyRZ5oQ7Nx8ryNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbfIOQ0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 12:26:44 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:34278 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387686AbfIOQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:26:44 -0400
Received: by mail-lf1-f50.google.com with SMTP id r22so14268723lfm.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSRXNFoOnxT83Q4uEqJAhbXNykBDhgkHdJqzn7eYJbw=;
        b=RT6x0zbpw5gGlxXo49Vjm3PD4i2MDTgGda+LlxSnDSs7fdDWeUDCP8oy9xdGhh1c9f
         snEkFY8KRbz0hURGShmMt4eeVgObdBN4dbnlidYjtWJFrGHIUs3oV29CXcxp70TuRIl8
         H14u7j2xbxxex1bJ8krjC72eYs6ZnccC/Wx4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSRXNFoOnxT83Q4uEqJAhbXNykBDhgkHdJqzn7eYJbw=;
        b=Mw9yh3H8lJjH0G813ViXkem2hYz7KOOtb5Bw+0U7Lcu7pAMfKpfQxNRJrR+/V7+sKt
         QgYenxmV1Mn68sCAlKqe4jqABjI2PlPMmRJ907baEHIBo+CbWW8Fv1snpbXfVwmiC6LP
         WwjyDKJIsxrPlj/gF7/1Zq34YIiRJ1+gI+a8NSxQ5iLnbreTBfNbgtfOuRDY5c++GfSz
         w6jg5OmWcx1vLhfiHev4R3LuMXEVcTSafh1hQYw8aaKN+5AYD+kaz647LAiThvGtggvU
         V34dvfVnQE4klmwZGNHgByBiWFzht1NkPpcpDVCvTAz2UVpDxtCL46jxBNEhoDhC01NB
         r8QA==
X-Gm-Message-State: APjAAAU/9HTa8djygdQ4Rjr59LqgS9FTuPRCQbPY1bR6JFt+hpGnMDnE
        DC8FMD5Tmr+ivieNtpiXDd58HRcdha8=
X-Google-Smtp-Source: APXvYqwffwxNAd1F8fnlnSyDeLZ7bkCK2JSUTP2WpljkyiD6fp+XD/cHlVycKPD7F5WCp4xeonUKOQ==
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr36859610lfp.21.1568564801680;
        Sun, 15 Sep 2019 09:26:41 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id x11sm8886183ljc.90.2019.09.15.09.26.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 09:26:40 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u3so10448368lfl.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:26:40 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr387146lfe.79.1568564800191;
 Sun, 15 Sep 2019 09:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tws0GHMQd0Byunw3XJXq2vqsbbkoR-rqOxfL3f+Rptscw@mail.gmail.com>
 <CAHk-=wja+f_PCuibu+NqkTD_YL1AY2x4wgX6EwQ3oxCyMTw_9w@mail.gmail.com> <CAPM=9tzo2HfwPsffe6wXGsyPhE-G+Ha7gpF=ONWUOLidxefV-Q@mail.gmail.com>
In-Reply-To: <CAPM=9tzo2HfwPsffe6wXGsyPhE-G+Ha7gpF=ONWUOLidxefV-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 09:26:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEvtTBXx7No=UMg9gXtqm6gzt3bT960UpoLOctokRB6w@mail.gmail.com>
Message-ID: <CAHk-=whEvtTBXx7No=UMg9gXtqm6gzt3bT960UpoLOctokRB6w@mail.gmail.com>
Subject: Re: drm fixes for 5.3-rc9
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 8:12 AM Dave Airlie <airlied@gmail.com> wrote:
>
> I've been manually writing the subject lines, seems I need to fix my brain.

Note that my "find git pull requests" logic doesn't need it in the
subject line at all, so if you just change whatever script you use to
generate the email body to have an additional "pull" in there
somewhere, that's perfectly workable too.

> The reason I do that is I generate on one machine the body, and send
> it via the gmail webui on whatever machine I'm using. This helps
> avoids google tagging my emails as spam for generating them using
> someone elses smtp servers. I should probably setup properly sending
> gmail to avoid that.

Don't worry too much about it too much.

I _do_ try to always read all my email, it's just that I find things
faster that match that pattern.

And I don't think I've actually lost one of your pull requests (knock
wood), they might just end up delayed a bit.

That said - having "[GIT PULL]" in the subject line is how the
pr-tracker-bot finds the emails too, so if you do the subject line
thing, you'll not only trigger my search term, you'll also get the
nice notifications from the bot when I've pushed out my merge.

              Linus
