Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765DBC4320D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EB920578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/y9NXZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408409AbfIWXvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:51:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45693 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfIWXvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:51:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so37428pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XsWEYEMa3OUxN/rIyJmCXyYBeWS8+cU9XND539Ca4bw=;
        b=E/y9NXZybs6vA4vrlalGFLTtZlxrC7FtgNZ3guYdN0O/ZGcGF24vZNUnIPI9RNeUSU
         KG2oaE52Aag0Vkpz8/5DKgjwGlCVtVq1vVyhPWrz1aox1UxP7nt4VCA8fvKlCohfnkIs
         mSJV6kjx7O2bDKd2DZFiUTXqHAySN3KKJ4g6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XsWEYEMa3OUxN/rIyJmCXyYBeWS8+cU9XND539Ca4bw=;
        b=tXSQadOiUPlY2KMEUGpKxeQmnNquz/TMFf4s7DgDggys8h4WYm3Bvjw/m6Ddmv1Wuo
         7jIjJY/ghaSTz52ZLi2Hdpp4vCSB44fvBuAtBi2sWKkWnwksdRpnG4vpupoHUpB3r1M5
         0X7RRlRd6WlDjGFtCftQ/RLnxaJ6ZkrdUn5FDanzdWpLNrASzy4Rv5E9+aLUxCs+CzAY
         8BWabvO3ly+IG4HoQpG+VhkjoeUfX3JIQG0T13FWqdosKLcEbtYrbU73c6H5wJVO7IQD
         hD6jR3Oxn9PUTENYJaV/8hrd33WaYh1SSFHSwPXTwbDjB11q0bfV+l6kOpgQqHhxl2vA
         irIA==
X-Gm-Message-State: APjAAAW9tiPS7jAWYc3a03VDsNJe23yxMIFr9j11TTSfH20QJJH4Ais9
        NnfSPO/Awdfo7X3Td3WbsL9ebg==
X-Google-Smtp-Source: APXvYqwU0BW/btrE2Yva2gh7adQAX91dLGmJKvlNr/ftvqFACr7SANo+L9CNSieSziIXVJm4hCuctg==
X-Received: by 2002:a17:902:36a:: with SMTP id 97mr2247384pld.75.1569282694325;
        Mon, 23 Sep 2019 16:51:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4sm5126340pjs.8.2019.09.23.16.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 16:51:33 -0700 (PDT)
Date:   Mon, 23 Sep 2019 16:51:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-um@lists.infradead.org, X86 ML <x86@kernel.org>
Subject: Re: [PATCH] seccomp: remove unused arg from secure_computing()
Message-ID: <201909231650.1CCAFBA6@keescook>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
 <20190923094916.GB15355@zn.tnic>
 <CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com>
 <20190923193446.GL15355@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923193446.GL15355@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 09:34:46PM +0200, Borislav Petkov wrote:
> On Mon, Sep 23, 2019 at 11:41:59AM -0700, Andy Lutomirski wrote:
> > On Mon, Sep 23, 2019 at 2:49 AM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Sep 20, 2019 at 03:19:09PM +0200, Christian Brauner wrote:
> > > > While touching seccomp code I realized that the struct seccomp_data
> > > > argument to secure_computing() seems to be unused by all current
> > > > callers. So let's remove it unless there is some subtlety I missed.
> > > > Note, I only tested this on x86.
> > >
> > > What was amluto thinking in
> > >
> > > 2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")
> > 
> > IIRC there was a period of time in which x86 used secure_computing()
> > for normal syscalls, and it was a good deal faster to have the arch
> > code supply seccomp_data.  x86 no longer works like this, and syscalls
> > aren't fast anymore ayway :(
> 
> Uhuh, thanks Andy.
> 
> Christian, pls add that piece of history to the commit message.

Yeah, this is just left-over from the "two phase" seccomp optimization
that was removed a while back. I'll take this clean up into the seccomp
tree. Thanks!

-- 
Kees Cook
