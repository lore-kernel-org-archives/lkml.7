Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1E9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE402082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RuVYDtl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDKRJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:09:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36242 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfDKRJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:09:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so7618957wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IUsO6EPkitkkKfslQlrk9jdhyI8ls4f5Jkizx1ufco=;
        b=RuVYDtl/y7612dj4+IKeQW/slL0xo/AO6Znlwf7Hk3P2RrSWmjQpRS6ixXs2G8hWnM
         5vNuGTVOdUPuWKgMoRIQuxNiBv180LSi9UhCLLCvBuYRUxBZU7hgts7AytfwciBQfvID
         jNGtv1XyjoNg3XEeUO4Lm+sNUnngJXrgwttFghcHeGnyP7g3J54xsvTnfdAXR7TSq13V
         /eHOw3id/WZuF8E0KF/QLG4QrEmm8VM0Pt/cWI3F5or+WfokXQI5ztNCx5QllAG4A8C1
         /XUA0jFNJ7OFtjlKRcbiK+3MEx7G65bNVtOWntS+GPkswQlfwl03iFmFUz0AI42MD7NW
         ErQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IUsO6EPkitkkKfslQlrk9jdhyI8ls4f5Jkizx1ufco=;
        b=rYSJ5qt5i/oLQAN+vlroaZwHHQ7cgav8lJYDOLEhXShOk18kx7ImrThry1HhOhLRnp
         /bYFFrXVOKPxS4ITNhF2q16sWT0mTaMOAwO1FA+qMv199m5Hbj1vbDmWVSMdwjkcGYC8
         /EQkuaAg5XG/v58ZXcSS2DYj5cFsBbdEk6x0xOXHzizeR0u+Ts49uaz7fzaaMIa8pDjv
         P2ByjpmnlPe0nSjuzOPqcIt7Ve9VHiP7/iP4IRWxYlCBR9M1wqNH3omIJdhue00qJKUT
         tPtk/N3J2ZzMMMzvtDFDtAziFMbhx98iIULy2ik7QZEGJwqg1yQQvZ5yfStoxDkzBEum
         XDow==
X-Gm-Message-State: APjAAAUPcwocwPeu2c/bmegMCTxwyTPJdjCZ5ylTsP6ch5sSIHnuroOV
        nMtTGpOnUbfzc7/uh1Cvj8Z5+oF4qteEluw7uQyw9Q==
X-Google-Smtp-Source: APXvYqxCOHI/Gb4CSvdUX/vm83ezHcctTmbLcpiwE5HrPevLzsRkqOTIvPC7LtxSX6FYCDdaSzHtCjw1Y83jhMor1P0=
X-Received: by 2002:a1c:c00b:: with SMTP id q11mr7791999wmf.38.1555002557981;
 Thu, 11 Apr 2019 10:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org>
In-Reply-To: <20190411153313.GE22763@bombadil.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 11 Apr 2019 10:09:06 -0700
Message-ID: <CAJuCfpGQ8c-OCws-zxZyqKGy1CfZpjxDKMH__qAm5FFXBcnWOw@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        David Rientjes <rientjes@google.com>,
        yuzhoujian@didichuxing.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        ebiederm@xmission.com, Shakeel Butt <shakeelb@google.com>,
        Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, linux-mm <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 8:33 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > victim process. The usage of this flag is currently limited to SIGKILL
> > signal and only to privileged users.
>
> What is the downside of doing expedited memory reclaim?  ie why not do it
> every time a process is going to die?

I think with an implementation that does not use/abuse oom-reaper
thread this could be done for any kill. As I mentioned oom-reaper is a
limited resource which has access to memory reserves and should not be
abused in the way I do in this reference implementation.
While there might be downsides that I don't know of, I'm not sure it's
required to hurry every kill's memory reclaim. I think there are cases
when resource deallocation is critical, for example when we kill to
relieve resource shortage and there are kills when reclaim speed is
not essential. It would be great if we can identify urgent cases
without userspace hints, so I'm open to suggestions that do not
involve additional flags.
