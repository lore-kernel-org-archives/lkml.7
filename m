Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296CDECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AE82133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eL0KkC/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbfJNPKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:10:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45934 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732647AbfJNPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:10:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id o205so14004077oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8mZzQYgCJoh/U/LtDTWoqHWL38rFTI9nqBb83t1F0I=;
        b=eL0KkC/qG5Sqdy3584kkE+iz33uqISxvsXEGdERUa7Qba35awyW4wPPpCaQDK4Vf1r
         A3DLF2XrRN3Lwh4n2M6qxwxu2T46oy32FbABZOdyiBDH2LNz67ggJr+I5OhDY4eeapth
         bIGYmB1CSf53TZI51DGqJab6Wjwy5z7eYIb7P7XsOHgHr1mbV/Jf08+om+Jr88+Wba5R
         oTzg3htSuDlhpSRZS3B1U76DkyOGgI+M99HxgN9w9xoR6tCXMFWhLG44qctxm9vFjIrm
         5i5FtAqJuGamLA8VvOY1RqJRFB8jEkEhrNIziL8n1p3hBxPQloscS8mtFR/Ak1n5qkBB
         6+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8mZzQYgCJoh/U/LtDTWoqHWL38rFTI9nqBb83t1F0I=;
        b=XPsqaJg2EHVz5otrhNea3Eyto55GeZ1rFSnl9AU1h9tZn8DX2lgKlsYYZcgHxd+XXJ
         J8OPdkVKRgjLyq4Nj0nM2Lu1MB1hDTM51+Tj1wKrfK52P8S6CI2hLqiiAK1PBVyCcdP0
         kh0ETHxmXe92YEkJcS8mvnyzI65wdCgD6YyFQE9SMIoZHa7y6xPtl07nj4N37lXF3n10
         mPsj22//lrzK9HZxxHFbNfr+qYYxDRryfvXeEu2CvjCFKAAgNf0lonkmzYA+5f9VjzO9
         coEDwTHR5yf0u1Wa6RiIGHQF59vJHPrf5EXk1J/cR1qd7EuNsot2dnFwpBj1R4l6t30a
         16nQ==
X-Gm-Message-State: APjAAAXVBiYMGfBEgjCPBehHdHARn61S2kLzH7AYmrLgIoHVtl3IDHFB
        0U2SCO9phgyAg6MAfVxx/kwwiliCz76SzaSjurscfA==
X-Google-Smtp-Source: APXvYqzcVFFImqZI58K41aEG21TM6C60Hd0B7GL6/+3YeLE94vV5SzMbABckyJbt3DVKWbg2bM0mT6UlrjQp+Ume+Q4=
X-Received: by 2002:a05:6808:95:: with SMTP id s21mr25075773oic.68.1571065827544;
 Mon, 14 Oct 2019 08:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1hk9d-qAPcRy9QOgNuO8u3Y_hu_3=GZoFYLY+oMdo8xg@mail.gmail.com>
 <20191012101922.24168-1-christian.brauner@ubuntu.com> <20191012102119.qq2adlnxjxrkslca@wittgenstein>
 <abc477fb3bd8fbf7b4d7e53d079dd1d8902e54af.camel@kellner.me> <20191014103157.h2wph2ujjidsrhyw@wittgenstein>
In-Reply-To: <20191014103157.h2wph2ujjidsrhyw@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Oct 2019 17:10:01 +0200
Message-ID: <CAG48ez1Yf05j2irdZxT2TA=2n3xo25KN48nRQdp_F8j14K36rA@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add NSpid entries to fdinfo
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:32 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Mon, Oct 14, 2019 at 11:43:01AM +0200, Christian Kellner wrote:
> > On Sat, 2019-10-12 at 12:21 +0200, Christian Brauner wrote:
> > > I tried to think of cases where the first entry of Pid is not
> > > identical
> > > to the first entry of NSpid but I came up with none. Maybe you do,
> > > Jann?
> > Yeah, I don't think that can be the case. By looking at the source of
> > 'pid_nr_ns(pid, ns)' a non-zero return means that a) 'pid' valid, ie.
> > non-null and b) 'ns' is in the pid namespace hierarchy of 'pid' (at
> > pid->level, i.e. "pid->numbers[ns->level].ns == ns").

Agreed.

> You could probably do:
>
> #ifdef CONFIG_PID_NS
> seq_put_decimal_ull(m, "\nNSpid:\t", nr);
> for (i = ns->level + 1; i <= pid->level && nr; i++)
>         seq_put_decimal_ull(m, "\t", pid->numbers[i].nr);
> #endif

Personally, I dislike hiding the precondition for running the loop in
the loop statement like that. While it makes the code more concise, it
somewhat obfuscates the high-level logic at a first glance.
