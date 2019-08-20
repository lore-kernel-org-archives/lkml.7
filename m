Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB48C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082D02082F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="0KkU5zF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfHTGq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:46:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33932 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTGq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:46:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id b24so2782169pfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 23:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mucqo3LhMIR4tStl5Pm2qj0Empc+I33Wun9fYdjBSPM=;
        b=0KkU5zF60DRo+9X3lGke27qW9hs3yRwLPnoCZ3y6IAPV7s+2TS6zAunFGSuQuxAacA
         xTXNumLhGhu4n34dFKQs1GHCc4NzsniRsD96828abf9v+xKpqxx2y4SInBHdLOwfqgS+
         aMniF/c25Oh4f46fA7Qsdc61lSYXNy1DY6bb+Dtynp8LVrxX0sMKIEkLgWTUcgsV36B6
         wo5efXJ9I9hMNsu0U34A/hP2h5BmIPUOKo79hjMPd1By03SoEHd/bBMLy3q1/ai6APcs
         jd7XSHUGmg8fNpDhf585GMmTL6sSbg4t4Uee8OGpctUM4BASYKLT85uwzXzGeOGC7O0q
         ktkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mucqo3LhMIR4tStl5Pm2qj0Empc+I33Wun9fYdjBSPM=;
        b=PBdF0jMJKpn21UA7CKJOInWbF1vNtliPd2Ucoq1THMt5tLijI/brXcdu/conHhzSQM
         Chi3GF0wuILC3h9xBl608P1z6K8k7J6VPtzUk1uFJit65/ncGhtlEhPnPI/69k8Fb2CZ
         fYRkkzpBOBw2/umJdGKSpDj9vN0b0j2DrTPAkswxpEbRIjw4JTCnqSStwgdOQgIyPKh4
         4IkE/nknJ/AtxNawq/qV3bqF73wzOhPyXAQ8gYRuv0wsEC4pG9R0apxXe5J5hGAGVn4J
         6EWWXIcvtvzkZDDEN59TH2mY8HCm8H4EERc1ESOhy3dVcOxAp/dcm4UB0GmCOjzdDZCQ
         Fhvg==
X-Gm-Message-State: APjAAAVKs+SWam12qjIaYu//GU2CqBhettPBV3Ck2L4lFn/ADlzSAWxY
        FCzsajhDFwXVT5XLmRZSGypk5w==
X-Google-Smtp-Source: APXvYqw0tPluysh6L9scDAcw2L4bPHCiB+Z6GVsEHlW64BqIv285puFdvNVEkR01mDkaycc23m5kUA==
X-Received: by 2002:a17:90a:3be5:: with SMTP id e92mr25187011pjc.86.1566283585731;
        Mon, 19 Aug 2019 23:46:25 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id e7sm18678827pfn.72.2019.08.19.23.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 23:46:24 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     aros@gmx.com
Cc:     linux-kernel@vger.kernel.org, linux@endlessm.com,
        hadess@hadess.net, hannes@cmpxchg.org
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's inability to gracefully handle low memory pressure
Date:   Tue, 20 Aug 2019 14:46:20 +0800
Message-Id: <20190820064620.5119-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Artem S. Tashkinov wrote:
> Once you hit a situation when opening a new tab requires more RAM than
> is currently available, the system will stall hard. You will barely  be
> able to move the mouse pointer. Your disk LED will be flashing
> incessantly (I'm not entirely sure why). You will not be able to run new
> applications or close currently running ones.
> 
> This little crisis may continue for minutes or even longer. I think
> that's not how the system should behave in this situation. I believe
> something must be done about that to avoid this stall.

Thanks for reviving this discussion. Indeed, this is a real pain point in
the Linux experience.

For Endless, we sunk some time into this and emerged with psi being the best
solution we could find. The way it works on a time basis seems very appropriate
when what we're ultimately interested in is maintaining desktop UI interactivity.
With psi enabled in the kernel, we add a small userspace daemon to kill a process
when psi reports that *all* userspace tasks are being blocked on kernel memory
management work for (at least) 1 second in a 10 second period.

https://github.com/endlessm/eos-boot-helper/blob/master/psi-monitor/psi-monitor.c

To share our results so far, despite this daemon being a quick initial
implementation, we find that it is bringing excellent results, no more memory
pressure hangs. The system recovers in less than 30 seconds, usually in more
like 10-15 seconds. Sadly a process got killed along the way, but that's a lot
better than the user having no option other than pulling the plug.
The system may not always recover to a totally smooth state, but the
responsiveness to mouse movements and clicks is still decent, so at that point
the user can close some more windows to restore full UI performance again. 

There's just one issue we've seen so far: a single report of psi reporting
memory pressure on a desktop system with 4GB RAM which is only running
the normal desktop components plus a single gmail tab in the web browser.
psi occasionally reports high memory pressure, so then psi-monitor steps in and
kills the browser tab, which seems erroneous. We haven't had a chance to look at
this in detail yet. Here's a log from the kernel OOM killer showing the memory and
process state at this point.
https://gist.github.com/dsd/b338bab0206dcce78263f6bb87de7d4a

> I'm almost sure some sysctl parameters could be changed to avoid this
> situation but something tells me this could be done for everyone and
> made default because some non tech-savvy users will just give up on
> Linux if they ever get in a situation like this and they won't be keen
> or even be able to Google for solutions.

As you anticipated, myself and others already jumped in with solutions
appropriate for tech-savvy users. Getting solutions widely deployed is indeed
another important aspect to tackle.

If you're curious to see how this can look from a "just works" standpoint, you
might be interested in downloading Endless (www.endlessos.com) and running your
tests there; we have the above solution running and active out of the box.

Bastien Nocera has recently adapted and extended our solution, presumably
with an eye towards getting this more widely deployed as a standard part
of the Linux desktop.
https://gitlab.freedesktop.org/hadess/low-memory-monitor/

And if there is a meaningful way to make the kernel behave better, that would
obviously be of huge value too.

Thanks
Daniel
