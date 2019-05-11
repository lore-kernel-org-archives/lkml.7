Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D543DC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF412173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557596050;
	bh=q3w6HRtwLgMJIJpi/DfZr8T2FpvNZWzd4d75kZOAzhI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=be1iyQDWHI1UIJOC5t3qwctE6D0bHxwHS3HNOm/H2w4wUUtcSxjN85+OELWYVvUWq
	 tTl9RZSS8KrEYgt3OoYJOjfehhyj6FvXDuoedQjavqlln77e3y4DnT+IFJ+CmehnmC
	 mvVrC3rGe6ML4I+R6TsJ2qcFKvHaSdPE4I0Le5gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfEKReJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 13:34:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45546 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfEKReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 13:34:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so7605718lja.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4GLGKJGBr1goNxWtth5dS3A9rH5i7tbT3DW+t/vUZM=;
        b=RiMckZqa7Pv2uJ6Jmq8WdsP1tgxvuMAA1KBrEXFSuTYRZg0dss6QUXLstX+qPl0cvi
         kW8HRPGc+o9zzUTLZU0Mhh/HlnQjlbSLAThZ8m9T+v+XaeUReplqMDf56AEvKd5qKIy7
         GzSd2O/qDYd43VAL+FXerAe7FQ27GBViWurwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4GLGKJGBr1goNxWtth5dS3A9rH5i7tbT3DW+t/vUZM=;
        b=eN5VlgxC9wik8tANhTPeUhtdIhvJapITSxZKTP/o+ZwqHKyMPBKJzvqS8FA+HIBeuJ
         uDceFOZzkwm06iEHjtliN6/58uFpDMKyeJyRMWnuclLhpZCgCbRUTeJlW6D60Mg6cxnZ
         vSM6lltN0G8lDvl1PzH5FThBgHDsaI+haFQ6HyuNwnSTQVpIVaxLUDlcSwg13Ecfsd1o
         gpuKt5WGZHFCCVRMy/Ys60oStJNbSu8ZIwdUL+gMN+0pZ1BnAc91g8vNSYbbmNPap41J
         EGrVcIaXy4SC+5zlRHkk9SsVCMjf/WsrHXwkqZCcH1CB1Vt0lMFTPnR7r0PRDz8EoNXc
         EZeA==
X-Gm-Message-State: APjAAAVKozOSg2Rlp+IUuV5tXaZFgevCq0I7JTC/NBmyQOJxuMCv+C3w
        aP+/UEnkuBjb/T2pi+64+TDsmhfEBOE=
X-Google-Smtp-Source: APXvYqxETOcaZnLh5+JzAMKlx/Kfcp3GrnX6XX8NFKUEztC6tSHN6hMYx95Ms3+2BelYRAjyDLiW6A==
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr73259ljj.52.1557596047290;
        Sat, 11 May 2019 10:34:07 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id b15sm2289103ljj.1.2019.05.11.10.34.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 10:34:06 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id d8so6257111lfb.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 10:34:06 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr9073466lfg.88.1557595631432;
 Sat, 11 May 2019 10:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 May 2019 13:26:55 -0400
X-Gmail-Original-Message-ID: <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com>
Message-ID: <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 1:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Notice? None of the real problems are about execve or would be solved
> by any spawn API. You just think that because you've apparently been
> talking to too many MS people that think fork (and thus indirectly
> execve()) is bad process management.

Side note: a good policy has been (and remains) to make suid binaries
not be dynamically linked. And in the absence of that, the dynamic
linker at least resets the library path when it notices itself being
dynamic, and it certainly doesn't inherit any open flags from the
non-trusted environment.

And by the same logic, a suid interpreter must *definitely* should not
inherit any execve() flags from the non-trusted environment. So I
think Aleksa's patch to use the passed-in open flags is *exactly* the
wrong thing to do for security reasons. It doesn't close holes, it
opens them.

                Linus
