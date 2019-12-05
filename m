Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9D3C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F26321835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575567650;
	bh=r67g/9hiA927KJVVx+cBd7MCpOd+2xqMrxYTzGwUZns=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=1fOwX+U47J7YqwNxElZgI6uennoqmwDwNXJcbqzQ1sg2NBJGmOJ8YgBaK/Ca34tpy
	 olKzd+bzngswTGPtH4vhMbakmCq97clm/hbgWCPbtrnPcN3LRjXULaNi/MGeFP8l1f
	 /WE6QCk1SPpYAatkx/RW3OP6hBW7vrod2r1DC/a4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfLERkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:40:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37408 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLERkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:40:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id u17so4571470lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/eKd/FDqrplPYUuvbR0AiU2l8M+m4LPxDGweCaRKq6w=;
        b=M56np70zVr1VfiJPsuEXyT4OG9+Mgq+nZRonIdlMO0qNjSITB1EVwHnE+jM9THnBNz
         3vX00ZNLigUAoH1Qop/bcwkoEis8chlXpTrSREoavAISt/m/5l5mLyPd23rMwP17l/QA
         7M9TY3swoS1z9u0iCZT3it6ySOEzIm2iiZPAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/eKd/FDqrplPYUuvbR0AiU2l8M+m4LPxDGweCaRKq6w=;
        b=IWy+KcmaKnnE+NSZ2xusHW05GydntW1VB6eJy4UFZ91q1iX+awK2+R4A/jnvqzZ8l0
         cApnFWqmF6sZwaisAMYSu1VP0p73EqpuwHCFX16ZYJHzP3lxql+yPyMeK7b1DIxgFLty
         CPpj6UbBB7WV3SvfyqTmI5cJ6bK2Xf6kL05Huxrw6/wOTekr4dbFupSBkoz6Waqh5Wzy
         06m+JBjzfVtB7qNXZse5/s5o76j3SBw39GO438EV93FcJd06fl36fKFqNZO3nlDbJDzL
         vFKts+5GhixNeCGvCmFSRWFPsBBvIBjbdsKlsaZVAz/otJRRhrD/yR79pasOFWWbb8/e
         R0+w==
X-Gm-Message-State: APjAAAWFMV+eNylHR9dZvfpaISEIUnKfwzXigmx/Rb+MtBpxfkevdtzF
        gWUCIkRx1J+9zb1hlTxdzfRfjUQI0d0=
X-Google-Smtp-Source: APXvYqzl8g/rX5BwukYiYmiZqnhk3mJuhPCOpVcIBhnwp4o3sFyvfPgSl6JfjWZJ5+tjebJkTpjlIQ==
X-Received: by 2002:a2e:2e0e:: with SMTP id u14mr6281462lju.106.1575567646735;
        Thu, 05 Dec 2019 09:40:46 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id y7sm5312989ljn.31.2019.12.05.09.40.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:40:46 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id l18so3163415lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:40:46 -0800 (PST)
X-Received: by 2002:ac2:430e:: with SMTP id l14mr2520386lfh.79.1575567200366;
 Thu, 05 Dec 2019 09:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20191205125826.GK2734@twin.jikos.cz> <31452.1574721589@warthog.procyon.org.uk>
 <1593.1575554217@warthog.procyon.org.uk> <20191205172127.GW2734@suse.cz>
In-Reply-To: <20191205172127.GW2734@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:33:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whw+R5GVQdpV6J_5afQ=76vtBPzBPRj6-zG1tnhT32Pag@mail.gmail.com>
Message-ID: <CAHk-=whw+R5GVQdpV6J_5afQ=76vtBPzBPRj6-zG1tnhT32Pag@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: Notification queue preparation
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 9:22 AM David Sterba <dsterba@suse.cz> wrote:
>
> I rerun the test again (with a different address where it's stuck), there's
> nothing better I can get from the debug info, it always points to pipe_wait,
> disassembly points to.

Hah. I see another bug.

"pipe_wait()" depends on the fact that all events that wake it up
happen with the pipe lock held.

But we do some of the "do_wakeup()" handling outside the pipe lock now
on the reader side

        __pipe_unlock(pipe);

        /* Signal writers asynchronously that there is more room. */
        if (do_wakeup) {
                wake_up_interruptible_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
                kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
        }

However, that isn't new to this series _either_, so I don't think
that's it. It does wake up things inside the lock _too_ if it ended up
emptying a whole buffer.

So it could be triggered by timing and behavior changes, but I doubt
this pipe_wait() thing is it either. The fact that it bisects to the
thing that changes things to use head/tail pointers makes me think
there's some other incorrect update or comparison somewhere.

That said, "pipe_wait()" is an abomination. It should use a proper
wait condition and use wait_event(), but the code predates all of
that. I suspect pipe_wait() goes back to the dark ages with the BKL
and no actual races between kernel code.

               Linus
