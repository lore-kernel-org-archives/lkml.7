Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4468EC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 16:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006E22075B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558889457;
	bh=6wkxCgvt8/Zi7K8oINVd1Zd/nTh4EaQoaWcSE84UKrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gkDt89iYCZvqwT6V7ZrnrbYI/Mpoi67UzQK1xqUWtXUOpnJ7nmcby3ss8I3u+25ho
	 yHK4ReCVrZ4qxHabelOvoz+CPkX6oETMpAoKhtsFMvHIKpZMbFkHVXySSt0RWnXUQ7
	 smeWwNmD9RqzMzg1b40VypmCprU99D/Mu3rL4mCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfEZQuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 12:50:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44089 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfEZQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 12:50:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so920006lfm.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwWdQnmq8yASPrv2cFHrDQaqBgqtmSmbYfjT2af0Acs=;
        b=UXAoISgQjf1jQmsrwHd12UAUvhD6bf1H5d4w3/6UVxx1RAozQIy7yc+RrEsARJDzoR
         K1BNPe1jPjl5Z3yMoxGsaOGzTOj1A035x4xcNiPp17tsaBS9HrmfLWpUaJSdRTJB95CQ
         lGTpp6xg251xIEiGguzO4NBvatZ9DuEMxtP5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwWdQnmq8yASPrv2cFHrDQaqBgqtmSmbYfjT2af0Acs=;
        b=I4IpNasagKkIOJdHJ0KBw2oeWQh6Hbqvfica1SysmdblzICHSZv1fmFQi7S5ZxsuHu
         3RiSIRnPWA5klrnW8tzYNIgZk57e94X3J6p3X+IHV7XthPnKXjKkpvwfvYMfq2XC5Uvh
         /TWyfo9Qw7kChEHcsbrDMaaxZKCZXn1DS/QyhGvKx6OuLjlv3aYdmtBPce/fJBz4ofKV
         dhMcwax4yqZ+Ms0694txOFafzq5Uvaqu2WyIy5+DD/dqTIeTGrruqsnA59j+zzn3meBj
         0jgbXrye0/9YJxviaMCTRCA+pGQh6EB24ePlw7j6NsXBqwIgMl/BHUV0v5DySS473YC5
         oVWg==
X-Gm-Message-State: APjAAAXmr6GnSvihfcXjtXZ9zbu3TLeaKneDMkPai91azGRiSkfOJvYG
        V0LjO+oXINH/6HgI9XDrnKw6P5adin4=
X-Google-Smtp-Source: APXvYqybTWkYljgXH5VH7oSyYRrywsF0RGlCpR7ahH1lXLtxt/1dBMXKyaf8FYH1ui7kH0yHOm4avg==
X-Received: by 2002:a19:5044:: with SMTP id z4mr3130762lfj.80.1558889451142;
        Sun, 26 May 2019 09:50:51 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id e6sm1759592ljg.65.2019.05.26.09.50.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 09:50:49 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id n22so2657278lfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 09:50:48 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr1557648lfm.170.1558889448623;
 Sun, 26 May 2019 09:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io>
In-Reply-To: <20190526102612.6970-1-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 May 2019 09:50:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
Message-ID: <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fork: add clone6
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 3:27 AM Christian Brauner <christian@brauner.io> wrote:
>
> This adds the clone6 system call.

No, this is not acceptable.

> +       struct clone6_args args = {

First of all, we don't pass in "clone6_args" to the actual implementation.

Passing in lots of args as a structure is fine. But it damn well isn't
a "clone6" structure. It's just a "clone_args" inside the kernel, and
there should be a separate clone_uapi_args for the user/kernel
interface.

The user interface (in the uapi file) may be called "clone6_args", but
that is *not* then what we pass around inside the kernel.

But even for the uapi version, the "clone6" name doesn't make any
sense as a name to begin with. It's not the sixth revision of clone,
and that clone6 structure isn't even "six arguments", because it has
lots of other arguments (with the extra flags registers you did, but
I'll get to that later).

Finally, the actual definition of that thing is wrong for a uapi interface too:

   struct clone6_args {
          __s32 pidfd;
          __aligned_u64 parent_tidptr;
          __aligned_u64 child_tidptr;
          ...

because now it has a hole in that structure definition because of
alignment issues. So make "pidfd" be 64-bit too. You clearly tried to
make this be compat-aware etc, but we really don't want to have parts
of user structures with random padding that we then don't check.

So the *user* visible structure should be full of those __aligned_u64
to make sure everything is aligned and doesn't care about compat
models.

But the *kernel* structure that we use should be nice and tailored for
kernel use, and use proper kernel types.

And related to that disgusting thing:

> -extern long _do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *, unsigned long);
> +extern long _do_fork(u64 clone_flags, struct clone6_args *uargs);

This is the correct thing to do (except for the "clone6" name), but:

>  static __latent_entropy struct task_struct *copy_process(
> -                                       unsigned long clone_flags,
> -                                       unsigned long stack_start,
> -                                       unsigned long stack_size,
> -                                       int __user *parent_tidptr,
> -                                       int __user *child_tidptr,
> +                                       u64 clone_flags,
>                                         struct pid *pid,
>                                         int trace,
> -                                       unsigned long tls,
> -                                       int node)
> +                                       int node,
> +                                       struct clone6_args *args,
> +                                       bool is_clone6)

But this is absolutely wrong.

That "bool is_clone6" is garbage.

The in-kernel "struict clone_args" should just be everything that
clone needs to know.

So the in-kernel "struct clone_args" should never ever need some
"is_clone6" boolean to specify how you then treat the arguments.

Stuff like this:

> +       int __user *child_tidptr = u64_to_user_ptr(args->child_tidptr);

should have been done in the stubs that set up the "struct clone_args"
thing, not in copy_process().

So all those

        if (is_clone6) ...

things need to go away, and it just needs to be the caller (who knows
what kind of clone call it is) setting up the clone_args properly,
depending on the *different* user interfaces.

And no, we don't do crazy stuff like this either:

+SYSCALL_DEFINE6(clone6, struct clone6_args __user*, uargs,
+                       unsigned int, flags1,
+                       unsigned int, flags2,
+                       unsigned int, flags3,
+                       unsigned int, flags4,
+                       unsigned int, flags5)

where this is wrong because it randomly just decides that everything
is flags (BS), and then doubles down on stupidity by making them
"unsigned int", so that the tests of the flags actually don't test the
upper bits anyway.

Why would you reserve 5 words of flags for future use when you have a
whole structure in user space that you _didn't_ reserve anything in?

So remove all those random flags, put ONE of them in the structure you
already have (as a "__aligned_u64", so that you actually get 64 bits,
not the 32 in "unsigned int"), and then perhaps you can add *one*
other register argument, which is the *size* of the structure that
user space is passing in.

That way, if we ever expand things, we'll just add new flags to the
end of the in-memory structure we have, but old binaries that don't
know about the size will continue to pass in the old size, and we'll
be all good.

So I hate the whole patch with a passion. It does absolutely
everything wrong from an interface standpoint.

I don't hate the notion of just adding flags. But do it cleanly, not
with random "is_clone6" bits.

And no, the structure we pass in from user space must *NOT* be the
same structure that we just copy blindly around as a kernel structure.
We've done that mistake before, and it is *always* a mistake. Think
"struct stat" and friends. No, we have a "struct kstat" for the kernel
version, and then we convert at the system call boundary. Let's not
repeat traditional mistakes.

And part of the conversion is exactly that

  Make everybody use the same in-kernel interface, so that the
lower-down routines don't have those kinds of "if it's this system
call, do this, otherwise, do that"

kind of horrible nasty mis-designs.

So to summarize:

 (a) make a separate kernel-only "clone_args" structure that is
unified and works for every single version of clone/fork/vfork, and
that has pointers and types in the kernel native format.

     So this will have things like "int __user *parent_tidptr" etc,
and something like *one* u64 flag field.

 (b) have the new system call have a nice compat-safe but
_independent_ format ("struct clone_uapi_struct")

 (c) you can now make the new system-call interface be something like

int clone_ext(struct clone_uapi_struct __user *uargs, size_t size);
{
        struct clone_uapi_struct kargs;
        struct clone_args args;

        // The API is defined as a stucture of 64-bit words
        if (size & 7)
                return -EINVAL;
        if (!access_ok(uargs, size))
                return -EFAULT;

        // If the user passes in new flags we don't
        // know about (because it was compiled against
        // a newer kernel than what is runn ing), make
        // sure they are zero
        if (size > sizeof(kargs)) {
                size_t n = (size - sizeof(kargs))>>3;
                u64 __user *ptr = (u64 __user *)(uargs+1)

                if (n > 10)
                        return -EINVAL;
                do {
                        u64 val;
                        if (get_user(val, ptr++))
                                return -EFAULT;
                        if (val)
                                return -EINVAL;
                } while (--n);

                // Ok, everything else was zero, we use
                // the part we know about
                size = sizeof(kargs);
        }
        memset(&kargs, 0, sizeof(kargs));
        memcpy_from_user(&kargs, uargs, size);

        .. now convert 'kargs' to 'args' ..

See? The above may be a bit *unnecessarily* anal about the whole
checking etc, but it's actually fairly simple in the end. And it means
that we have that "convert to internal format" in just one place - the
place where it makes sense. And it's a lot cleaner interface to user
mode, and allows for easy expansion later.

NOTE! By all means make "clone_ext()" take some of the other arguments
as part of the argument registers, not everything has to be part of
"struct clone_uapi_struct". But none of this "flag1..5" stuff. That's
what a struct is for.

Maybe the basic ":u64 clone_flags" could be the first argument (but
64-bit arguments can be a bit nasty for compat layers, so it's
probably not even worth it - once you have to copy an argument
structure from user space, you might as well put everything there).

                Linus
