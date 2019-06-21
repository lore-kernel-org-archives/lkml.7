Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC630C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EE52070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RblRDrzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFUWNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 18:13:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34717 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfFUWNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 18:13:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so7956056wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/hHk0S9u9UZeTnfOgA1tURrEwbtjqCVR5Jur9CvSRDU=;
        b=RblRDrzJgYetJYhfs1+s8zGLEDsuGMJYIGjWEzlVg6iUUawJSAWh1cWw4zJFIa+FF9
         4LeBDtgHlqAbB+vNESZVHx4UWv8R/KrQ+it0E6eaErmnu0qwSsYrYdCN+gfY4JaQaZ6P
         AEfu5UpaZ7fkNmoFypcWAstAxxW2RwUA9GM5+pZRNuKDG4cyfxxyolNquz5LWXzCjdWv
         WZGQx+GJF9rXXbWtY2VnEdqRlmCm37wHCE+rHRRw1gRhZYoKIVHVsHwEnjpfYBeEOzcJ
         4Yyv7NWj8vqz102/YbR8CkCBI9EAp7NTZQQPoSiN3TbrXncG2CYCat7fRf4pFOmd8u8P
         OWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/hHk0S9u9UZeTnfOgA1tURrEwbtjqCVR5Jur9CvSRDU=;
        b=jng4+D1MCyDQNoxK2az08onQ/hXVy2wePQcJet+8IcFXMHJX9JiGNelWraLiUtVwqJ
         mrJIKy63PAfT3O0ph4cj91BHVF5uQp6s4Xv2xweb01jAVf9MowPiqJx+QNWwr7ooYWAk
         vRAUkcz9eLYj4rZyjWP/U/QQedHdAevbB/Tk6jgVFj9+w9R7Pg+TR/zW2VI+xD0O5h0r
         U7eFR3hnHQmsDKn3tptL5sJsEhX0kd+hg+M7FfcK43eWJ/0xLdo0jjEyF6Gg+EIiyHFz
         bxzK+J/8LXz21RnT4JORk8RmsyXIW0dqHwLS+yIAsKY19HXgzyaXQOkxEfX7F2ua6pQO
         sO9A==
X-Gm-Message-State: APjAAAVgl3NOPUVcm6SbzO74ha4r+fJM54QdJx6xXKH8A9z8p+3vsKu2
        ABp1za6uwWieEFj3FPodefM9Zw==
X-Google-Smtp-Source: APXvYqxvE86aR9hrpK/S0FbF+03Y/CoTNB7MxqN5zN4cMwFYbx/g7u97U/NtzcSGMXaqmgw1nkiDFQ==
X-Received: by 2002:a5d:4fc8:: with SMTP id h8mr9986421wrw.124.1561155220929;
        Fri, 21 Jun 2019 15:13:40 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id b6sm2547103wrx.85.2019.06.21.15.13.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:13:40 -0700 (PDT)
Date:   Sat, 22 Jun 2019 00:13:39 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: make pidfd-metadata fail gracefully on older
 kernels
Message-ID: <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
 <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
 <20190621170613.GA26182@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190621170613.GA26182@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 08:06:14PM +0300, Dmitry V. Levin wrote:
> On Thu, Jun 20, 2019 at 01:10:37PM +0200, Christian Brauner wrote:
> > On Thu, Jun 20, 2019 at 02:00:37PM +0300, Dmitry V. Levin wrote:
> > > Cc'ed more people as the issue is not just with the example but
> > > with the interface itself.
> > > 
> > > On Thu, Jun 20, 2019 at 12:31:06PM +0200, Christian Brauner wrote:
> > > > On Thu, Jun 20, 2019 at 06:11:44AM +0300, Dmitry V. Levin wrote:
> > > > > Initialize pidfd to an invalid descriptor, to fail gracefully on
> > > > > those kernels that do not implement CLONE_PIDFD and leave pidfd
> > > > > unchanged.
> > > > > 
> > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > ---
> > > > >  samples/pidfd/pidfd-metadata.c | 8 ++++++--
> > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/samples/pidfd/pidfd-metadata.c b/samples/pidfd/pidfd-metadata.c
> > > > > index 14b454448429..ff109fdac3a5 100644
> > > > > --- a/samples/pidfd/pidfd-metadata.c
> > > > > +++ b/samples/pidfd/pidfd-metadata.c
> > > > > @@ -83,7 +83,7 @@ static int pidfd_metadata_fd(pid_t pid, int pidfd)
> > > > >  
> > > > >  int main(int argc, char *argv[])
> > > > >  {
> > > > > -	int pidfd = 0, ret = EXIT_FAILURE;
> > > > > +	int pidfd = -1, ret = EXIT_FAILURE;
> > > > 
> > > > Hm, that currently won't work since we added a check in fork.c for
> > > > pidfd == 0. If it isn't you'll get EINVAL.
> > > 
> > > Sorry, I must've missed that check.  But this makes things even worse.
> > > 
> > > > This was done to ensure that
> > > > we can potentially extend CLONE_PIDFD by passing in flags through the
> > > > return argument.
> > > > However, I find this increasingly unlikely. Especially since the
> > > > interface would be horrendous and an absolute last resort.
> > > > If clone3() gets merged for 5.3 (currently in linux-next) we also have
> > > > no real need anymore to extend legacy clone() this way. So either wait
> > > > until (if) we merge clone3() where the check I mentioned is gone anyway,
> > > > or remove the pidfd == 0 check from fork.c in a preliminary patch.
> > > > Thoughts?
> > > 
> > > Userspace needs a reliable way to tell whether CLONE_PIDFD is supported
> > > by the kernel or not.
> > 
> > Right, that's the general problem with legacy clone(): it ignores
> > unknown flags... clone3() will EINVAL you if you pass any flag it
> > doesn't know about.
> > 
> > For legacy clone you can pass
> > 
> > (CLONE_PIDFD | CLONE_DETACHED)
> > 
> > on all relevant kernels >= 2.6.2. CLONE_DETACHED will be silently
> > ignored by the kernel if specified in flags. But if you specify both
> > CLONE_PIDFD and CLONE_DETACHED on a kernel that does support CLONE_PIDFD
> > you'll get EINVALed. (We did this because we wanted to have the ability
> > to make CLONE_DETACHED reuseable with CLONE_PIDFD.)
> > Does that help?
> 
> Yes, this is feasible, but the cost is extra syscall for new kernels
> and more complicated userspace code, so...

Out of curiosity: what makes the new flag different than say
CLONE_NEWCGROUP or any new clone flag that got introduced?
CLONE_NEWCGROUP too would not be detectable apart from the method I gave
you above; same for other clone flags. Why are you so keen on being able
to detect this flag when other flags didn't seem to matter that much.
(Again, mere curiosity.)

> 
> > > If CLONE_PIDFD is not supported, then pidfd remains unchanged.
> > > 
> > > If CLONE_PIDFD is supported and fd 0 is closed, then mandatory pidfd == 0
> > > also remains unchanged, which effectively means that userspace must ensure
> > > that fd 0 is not closed when invoking CLONE_PIDFD.  This is ugly.
> > > 
> > > If we can assume that clone(CLONE_PIDFD) is not going to be extended,
> > > then I'm for removing the pidfd == 0 check along with recommending
> > > userspace to initialize pidfd with -1.
> > 
> > Right, I'm ok with that too.
> 
> ... I'd prefer this variant.

Please send a patch for review.

Christian
