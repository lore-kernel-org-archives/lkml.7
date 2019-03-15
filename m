Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87090C10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6045F206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfCODpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:45:08 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:41111 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfCODpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 23:45:08 -0400
Received: by mail-oi1-f172.google.com with SMTP id k8so6223830oik.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 20:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jqNqOSWwhyyf+mDbXl2RsLz9qA1Z9EB5hcTdEP6DIm8=;
        b=F+A7tMjgqgwOlbrcjvaKvS2ffg5fZxUn0QOb5X53ob2p+fyQkAPoEhbE6LQXcLHm9o
         +Owy/8OqUCEBSqP0bNil+qAK5CggwmzdGqpYbmhHd80A73BaHsRURCdK6fEsv6C4Cn5a
         SWW6szpXpIkSoGUM9vNlwzxbhFxANi9aQ9wz2Qwwv78lINR88n9vfn7pDhhANgQFCEVj
         MsCUOML5X9dmIM68Kt9AFKVeuVtgiM14gZV3pnux8G/omWcrXPcFvwLizM6ZHe/H2uTM
         LtugnM7miSt9k4FTAviwnQzo6dvfCdFXDqxY3noSXMx+p0F3sftwpaKjZOPuT45TqwAe
         GxFQ==
X-Gm-Message-State: APjAAAXg9wYcPfrXXqIXfe5xC2I/F1+TLDt+NtoDY93EY67ZLsEB2Phs
        GD1wA+3IJeKZb0u0QOv6EZg=
X-Google-Smtp-Source: APXvYqynQjzPuOsgLwmkCGsLMO/giFuMCJcqVPUnKs8zN8zfF6EmPqXnpAVPXz3B2yxsCH/0b2BTBw==
X-Received: by 2002:aca:47d4:: with SMTP id u203mr295513oia.175.1552621507233;
        Thu, 14 Mar 2019 20:45:07 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id b2sm587690oih.1.2019.03.14.20.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 20:45:06 -0700 (PDT)
Date:   Thu, 14 Mar 2019 20:45:02 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190315034502.GB3171@sultan-box.localdomain>
References: <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz>
 <20190312163741.GA2762@sultan-box.localdomain>
 <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
 <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
 <20190314204911.GA875@sultan-box.localdomain>
 <20190314231641.5a37932b@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314231641.5a37932b@oasis.local.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:16:41PM -0400, Steven Rostedt wrote:
> How would you implement such a method in userspace? kill() doesn't take
> any parameters but the pid of the process you want to send a signal to,
> and the signal to send. This would require a new system call, and be
> quite a bit of work. If you can solve this with an ebpf program, I
> strongly suggest you do that instead.

This can be done by introducing a new signal number that provides SIGKILL
functionality while blocking (maybe SIGKILLBLOCK?).

Thanks,
Sultan
