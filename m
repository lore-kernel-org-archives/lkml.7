Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC79DC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17552173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="WlEH0FIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbfGRKRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:17:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33666 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfGRKRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:17:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so28119397wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 03:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oBf2lMyfhY7EY3KqVK9i6b5kfQhduu/064vS7gNPNXs=;
        b=WlEH0FIED2hjJ3xoIvYe2qPOvQ2qO+x+VBe+H3SWgJlPS2i82UNkA0xSRuHQfStXz9
         MYG+LZSWG26byysWhUrg/oU3uYv5nZiA4DSn/bJl0U6jU8HAVNS8gPnHL7AdhNnKaqJr
         3IoS/lbEoaCRlcxso8fqepk+Vg6NTZzEvWGTSDPQ9qIE4+IDNCh9X6JzzqOmpXRsf71a
         HvMJjGc1mTO7fzqR/aT/c0TOQmttDjrAnYOrZ+GEDqKchn6oUV8U7Dnz9pa2cPJ4D5qP
         zv+L4hqQCmabpOXK1Az9oj6+KqAbj3MuHBdnHx/EITx5nXpFEe7NNV4iWMMEVNfP5t4c
         v8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oBf2lMyfhY7EY3KqVK9i6b5kfQhduu/064vS7gNPNXs=;
        b=bcSkZjpQpMSCy/ZaKs02IXh8G9I16aJnEVFWXsXtEgz79VuSYZpNbxiAwFTZXZAib4
         vfcAbFJk7wEf1dIrzZt/oxwESMsQaukm/dypVCcFVmFla1bukEd3bXekl1nflRlTXUaJ
         /25Sff3UBlHmVavFFckc/BS/aOe+0Y6E3ed0JdHkKN3pnMzwY5JhgDZz0Q+nt93RF9O2
         hf79ITNrAxlH9BJfIjAaJ78it2vROcqY/vQPKen+OTwuYMWG4P8pdjIb5OLW8Ot9NaLt
         9Y8DFvfP5fDfNqG1OPBkTeQd7YTSTwKRNrtdkeSfYp5CYzFHwBJllDXY+c7tDLpnwglL
         l26w==
X-Gm-Message-State: APjAAAUpZjX3++S4ODevF44jXLytgjGxp2/aP9Pojwyj+VNCernAwJXi
        qLy6ndwzdjvWhRIArd6JVr8=
X-Google-Smtp-Source: APXvYqzFM7PBqeuTzxAiUo8pyI3tcXZtVaBVcraYnfuLLLlME0CY+GYai3kvzJPhNn3VdicTZa8SdQ==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr50445144wrn.240.1563445061438;
        Thu, 18 Jul 2019 03:17:41 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id s188sm19818806wmf.40.2019.07.18.03.17.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 03:17:40 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:17:40 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd
 polling
Message-ID: <20190718101735.pbu6nji6mfwq4mxa@brauner.io>
References: <20190717172100.261204-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190717172100.261204-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 01:21:00PM -0400, Joel Fernandes wrote:
> From: Suren Baghdasaryan <surenb@google.com>
> 
> There is a race between reading task->exit_state in pidfd_poll and writing
> it after do_notify_parent calls do_notify_pidfd. Expected sequence of
> events is:
> 
> CPU 0                            CPU 1
> ------------------------------------------------
> exit_notify
>   do_notify_parent
>     do_notify_pidfd
>   tsk->exit_state = EXIT_DEAD
>                                   pidfd_poll
>                                      if (tsk->exit_state)
> 
> However nothing prevents the following sequence:
> 
> CPU 0                            CPU 1
> ------------------------------------------------
> exit_notify
>   do_notify_parent
>     do_notify_pidfd
>                                    pidfd_poll
>                                       if (tsk->exit_state)
>   tsk->exit_state = EXIT_DEAD
> 
> This causes a polling task to wait forever, since poll blocks because
> exit_state is 0 and the waiting task is not notified again. A stress
> test continuously doing pidfd poll and process exits uncovered this bug,

Btw, if that stress test is in any way upstreamable I'd like to put this
into for-next as well. :)

Christian
