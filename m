Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75826C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E11B21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRzS0Ynx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfGRQFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:05:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46943 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRQFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:05:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so29273157wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 09:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqLq5hsEtX6MmIb5KNVQ+3JWGNjyMVtuJZtr99HCXe0=;
        b=fRzS0YnxLBxo//VolRREGkWM2ddR4Ql8voN4QZ2tZRtxx76j0vVqJtlLYhlwf3RW5F
         rP9w2pRajIKBjvkjUgewgx3hSrAmqjHjWlaE23ZJItr0o/RUHC9EellPtvgWtQAkjpi3
         LuLY86RDT3KauXACeC6npg5+exqFOfdfIQ/VdU+R80SWDwsOtnuYilPUQ1gs/kbYbFs2
         wNL3BfMQohmqoiOrBe/RXLG2SLq3pApn6HOUUaoXygEi7qyOxGidzM0NK9hk1PygVi50
         JWXxw5wi9OgdmaNeGn9bFBRdn6Ls0TwkMrRfinleoXMA2DVQKW+rhgJdcBjR4bQuGW+M
         DJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqLq5hsEtX6MmIb5KNVQ+3JWGNjyMVtuJZtr99HCXe0=;
        b=YOMUzrc+nsPxDbgSQZ+PjVud99NrlT4detx+YAHJf2oGsDYK/yOicrabF27NZlt4bL
         MHVJM13164aPbTHYAX/n0IfROMrwP46kVMTzu59bcFo4mjqfJoQ69oq+p7wxou6mMsei
         5gjSgy10j12uBXqp1lYeSaEzLbgki1cOZtEbOx5ZVEFcOG+5IYLpDMUREJmT3WofEdqe
         R4hUkvjWgXMH1VnCiwW/l1EKO4B8N5xV+nteNeyNeBrG8ZHaS4P0ctF+RunUdD+Yz85c
         642H+t4BgJ5VDRmbEfjorQ03zqVZBecflanbBoI91SwcCib12P2BB5dsQhdKxl8663Os
         A0Ig==
X-Gm-Message-State: APjAAAXBrZx+wiKs+5n8qb5LLjsHPHiy9r203pmfft5nvGliHXqoEFCV
        ludM8ndaJyg0n0Q027gXWKZYyNnEpKiLcZzFMyfihg==
X-Google-Smtp-Source: APXvYqydwgSdcHprykeY5HTJN+mR3i0ocgVAgkVgS+qP35PMoHSKr5687LlZE73bHgts4AHXn25rh25Ec8wknjPlERY=
X-Received: by 2002:adf:df10:: with SMTP id y16mr26563831wrl.302.1563465934349;
 Thu, 18 Jul 2019 09:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190717172100.261204-1-joel@joelfernandes.org> <20190718101735.pbu6nji6mfwq4mxa@brauner.io>
In-Reply-To: <20190718101735.pbu6nji6mfwq4mxa@brauner.io>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 18 Jul 2019 09:05:22 -0700
Message-ID: <CAJuCfpHOPfLMEjP3gqEEOwqj8bv2GnBPVL5rurjokL4X4WVugg@mail.gmail.com>
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd polling
To:     Christian Brauner <christian@brauner.io>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 3:17 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Wed, Jul 17, 2019 at 01:21:00PM -0400, Joel Fernandes wrote:
> > From: Suren Baghdasaryan <surenb@google.com>
> >
> > There is a race between reading task->exit_state in pidfd_poll and writing
> > it after do_notify_parent calls do_notify_pidfd. Expected sequence of
> > events is:
> >
> > CPU 0                            CPU 1
> > ------------------------------------------------
> > exit_notify
> >   do_notify_parent
> >     do_notify_pidfd
> >   tsk->exit_state = EXIT_DEAD
> >                                   pidfd_poll
> >                                      if (tsk->exit_state)
> >
> > However nothing prevents the following sequence:
> >
> > CPU 0                            CPU 1
> > ------------------------------------------------
> > exit_notify
> >   do_notify_parent
> >     do_notify_pidfd
> >                                    pidfd_poll
> >                                       if (tsk->exit_state)
> >   tsk->exit_state = EXIT_DEAD
> >
> > This causes a polling task to wait forever, since poll blocks because
> > exit_state is 0 and the waiting task is not notified again. A stress
> > test continuously doing pidfd poll and process exits uncovered this bug,
>
> Btw, if that stress test is in any way upstreamable I'd like to put this
> into for-next as well. :)

Definitely. I'll work with Joel on making it upstreamable and posting
as a separate patch.

>
> Christian
