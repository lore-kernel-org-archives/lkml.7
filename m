Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95326C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A476207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="UTqM58yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbfJDN01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:26:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39776 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbfJDN01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:26:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id a15so5822297edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iWYDUEgKuCJeyJ9I6tYYxrawWm8Ddb31rIaod5aHvEQ=;
        b=UTqM58yftpKounDpD+4rAyIh0EPTO6sSobQgHt7atHQjC6TplYZV1uL7Pd9pvU8Vfh
         ioTH7H78xYUGHRX8TkHQzF+eIr4+uEWYxFv5+Iu4QKtqrOB3GRdeiJY3i+i324HSf4X8
         k/sfG6qYxEAtkXWP7ej6YifNl95NLmgBxBcAAJCEJ+qAhLYzXznt56UQWETMOn6CQZWe
         CbFd3OAWGcigI5gFmR0ModJdNdjm6ex5JHy1G80II/jop5Ark/Q+oOFkmNQIww2FFo1/
         qV/ShDCfTk6ThII0/GlExArOauZsOlEZ+pMh0iuqQ5jvrFx/0diovtefYIjC14xpPR/u
         irFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iWYDUEgKuCJeyJ9I6tYYxrawWm8Ddb31rIaod5aHvEQ=;
        b=oyql88CEI87jwdGMoDWi05khPLG9RZ5LxUEkJkyFj8GtFcDob2USDT6UUj5BLG0rc8
         WTONxtX0X8wDiGz7WR6W+O7rhDq9wu2R3dMTbbgL3glu+b8j1zb6m9r0QHL5xps3nMEw
         XcDwu+ubpMBEWpYHMmkSHoUDJfaUEZ8w62Z/ynMMMF/BBnCFjhu63kSt4Os0hzqrF0Bh
         qylHcqlWYw4Y3jQCKxWkGpKtEC25dXDgxI9dtgKMYVKS5NFEKh9JH/URd0oXjd/FTT13
         R6AwCfPiIdNKpV4VGyZim7/FUZPN0hlOhves9juOkzVTtU9V/HhHZ24CTkfMZVfR9WQr
         yaZw==
X-Gm-Message-State: APjAAAVbWy4LxbHMJZu0CUAQqakKNaDxhNT4kn10Tem8vTk346GH3IFs
        tJRzbqrPru51mVM3yQIfghVrWA==
X-Google-Smtp-Source: APXvYqy3lg5fGs39WgPY20gmrfOzi6+KMhhev0MZZy1hZjCN0h3YpvVCFSn45T6y83HlbvFzqQTbcw==
X-Received: by 2002:aa7:c4d0:: with SMTP id p16mr15268554edr.266.1570195585640;
        Fri, 04 Oct 2019 06:26:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z39sm1115252edd.46.2019.10.04.06.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:26:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1F27F102143; Fri,  4 Oct 2019 16:26:24 +0300 (+03)
Date:   Fri, 4 Oct 2019 16:26:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>, Qian Cai <cai@lca.pw>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] Make SPLIT_RSS_COUNTING configurable
Message-ID: <20191004132624.ctaodxaxsd7wzwlh@box>
References: <CAKOZuesMoBj-APjCipJmWcAgSzkbD1mvyOp0UvHLnkwR-EU4Ww@mail.gmail.com>
 <1C584B5C-E04E-4B04-A3B5-4DC8E5E67366@lca.pw>
 <CAKOZuesKY_=qkSXfmDO_1ALaqQtU0kz5Z+fBh05c8BR7oCDxKw@mail.gmail.com>
 <20191004123349.GB10845@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004123349.GB10845@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 02:33:49PM +0200, Michal Hocko wrote:
> On Wed 02-10-19 19:08:16, Daniel Colascione wrote:
> > On Wed, Oct 2, 2019 at 6:56 PM Qian Cai <cai@lca.pw> wrote:
> > > > On Oct 2, 2019, at 4:29 PM, Daniel Colascione <dancol@google.com> wrote:
> > > >
> > > > Adding the correct linux-mm address.
> > > >
> > > >
> > > >> +config SPLIT_RSS_COUNTING
> > > >> +       bool "Per-thread mm counter caching"
> > > >> +       depends on MMU
> > > >> +       default y if NR_CPUS >= SPLIT_PTLOCK_CPUS
> > > >> +       help
> > > >> +         Cache mm counter updates in thread structures and
> > > >> +         flush them to visible per-process statistics in batches.
> > > >> +         Say Y here to slightly reduce cache contention in processes
> > > >> +         with many threads at the expense of decreasing the accuracy
> > > >> +         of memory statistics in /proc.
> > > >> +
> > > >> endmenu
> > >
> > > All those vague words are going to make developers almost impossible to decide the right selection here. It sounds like we should kill SPLIT_RSS_COUNTING at all to simplify the code as the benefit is so small vs the side-effect?
> > 
> > Killing SPLIT_RSS_COUNTING would be my first choice; IME, on mobile
> > and a basic desktop, it doesn't make a difference. I figured making it
> > a knob would help allay concerns about the performance impact in more
> > extreme configurations.
> 
> I do agree with Qian. Either it is really helpful (is it? probably on
> the number of cpus) and it should be auto-enabled or it should be
> dropped altogether. You cannot really expect people know how to enable
> this without a deep understanding of the MM internals. Not to mention
> all those users using distro kernels/configs.
> 
> A config option sounds like a bad way forward.

And I don't see much point anyway. Reading RSS counters from proc is
inherently racy. It can just either way after the read due to process
behaviour.

-- 
 Kirill A. Shutemov
