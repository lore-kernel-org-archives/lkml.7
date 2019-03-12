Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7809F205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwoZi4sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCLSn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:43:27 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:38989 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCLSn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:43:26 -0400
Received: by mail-io1-f53.google.com with SMTP id x3so3017267ior.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fo/v7SBqR9Y8HorvRV4qY+qTc74qy6r2ZpOJax4E0b4=;
        b=OwoZi4sCHLXm6jIB0SrimzodzEpnuPM1ocHav7KTqC/dNINfGz1ZTNNM/Qor4MM/g0
         N+4QizOgiWx6nzvYXPvQ/Cv4V0+kOKHlBD849Q6u93IR06hIERUU+zCuFjk+zYBU0hVW
         +9wA5VDFmCWUJQo4t4/PMQqmEY68hU97RT4cDqmb03LNd8WglTVlQSADJx8bOSlnFh/h
         IM6esZI0z3TL94uA0L3h1/beuuBxUp2WaMn2DAMWX4EW2ypY0Ylq3Lr8IdGG/Z4WJy+L
         nTpuBSvtJn5K6TfhDU/Iupb3+Qq+u8M1sDN4xRN4LTInedhd+UXZkbovRG74KnkZKRpC
         N40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fo/v7SBqR9Y8HorvRV4qY+qTc74qy6r2ZpOJax4E0b4=;
        b=nq3wBLy1k63k65e8NMR8fpv4nYaKfX+crUtHNFaikWq0yIzIMj9zOQmXOOUFLVx+us
         j51eiuse7UIct8O2UFtVlo9piGZJFhekyD+EkDQhElz7DTUmSEF4J5V2F5gF9yhZKFW4
         yHLjvpmqYudQsIXU7H97CHzfSheycHHN+QP53LhuMWklG1OKX/rN4mmMUubsKuUxVTya
         3jUpHsAeTzO03hUsyaCb//hVu69L8IIRYucdXuUAznK5fQIYMOIJQqbXrs1EC0o13cjx
         DneAq//J8dYJOA55V6kg1+d3FOmn6yNhkEJiwSBpZUDbxIfEgFNZgOyCatLVUJBqzRTD
         UopA==
X-Gm-Message-State: APjAAAUN8KpzxccCriBeWo46GA1uhBF5tw/YWa+u7E8InRarL0hvE/0D
        gPbfX1Z+xWf4ojd9nT2wUTqvgwZB8sVu6oZ4CcYGqQ==
X-Google-Smtp-Source: APXvYqxl7+sqyVCZd0nlCLusQ7k24/I/mt+5W6Z1PdcID4CmgBm88PBxwF51+PonJKlNy38PiMl+aatep/V5nuxT7XQ=
X-Received: by 2002:a5e:db0d:: with SMTP id q13mr425229iop.279.1552416204862;
 Tue, 12 Mar 2019 11:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz> <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain> <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz> <20190312163741.GA2762@sultan-box.localdomain>
 <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com> <20190312174520.GA9276@sultan-box.localdomain>
In-Reply-To: <20190312174520.GA9276@sultan-box.localdomain>
From:   Tim Murray <timmurray@google.com>
Date:   Tue, 12 Mar 2019 11:43:13 -0700
Message-ID: <CAEe=Sx=MxzBB46WxuwHTQcocBkx1UW+fmVOa3VWv_eUferzVYw@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:45 AM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
>
> On Tue, Mar 12, 2019 at 10:17:43AM -0700, Tim Murray wrote:
> > Knowing whether a SIGKILL'd process has finished reclaiming is as far
> > as I know not possible without something like procfds. That's where
> > the 100ms timeout in lmkd comes in. lowmemorykiller and lmkd both
> > attempt to wait up to 100ms for reclaim to finish by checking for the
> > continued existence of the thread that received the SIGKILL, but this
> > really means that they wait up to 100ms for the _thread_ to finish,
> > which doesn't tell you anything about the memory used by that process.
> > If those threads terminate early and lowmemorykiller/lmkd get a signal
> > to kill again, then there may be two processes competing for CPU time
> > to reclaim memory. That doesn't reclaim any faster and may be an
> > unnecessary kill.
> > ...
> > - offer a way to wait for process termination so lmkd can tell when
> > reclaim has finished and know when killing another process is
> > appropriate
>
> Should be pretty easy with something like this:

Yeah, that's in the spirit of what I was suggesting, but there are lot
of edge cases around how to get that data out efficiently and PID
reuse (it's a real issue--often the Android apps that are causing
memory pressure are also constantly creating/destroying threads).

I believe procfds or a similar mechanism will be a good solution to this.
