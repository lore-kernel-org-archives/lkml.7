Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C06C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79979217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qU0c29yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfDKRFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:05:44 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41301 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:05:43 -0400
Received: by mail-yb1-f195.google.com with SMTP id c15so2482985ybk.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7jjkT3BK3TrD5+yfkCQiasOngzvtZFHArOGePxAfgQY=;
        b=qU0c29yC3Jj2uhWf//ABSUwx8aGOnQVAOyECPol8iMOkmoVx3rfLlnPdd3abk7ZIrp
         cBnWLlTqwPlbX1abhPCMls/eFNIMnUkF0DlH2l/IQsX0oCd6JYIEG+PECn1nS6tPnOCt
         URhwJBR07oEmOXuZrKhyuYUEWY/+PaNLauQKgcppotczYrHtnkwitBMUiCdjhy+5xKXI
         o5wwWqjLBHPqgWxYJU0rDmT3PWJv+SWGJTH2lxRsPbBRvdYvEluu5WsyoZSNTJ4KuzWN
         Om7O9RGcwc0wsTPbTuDNdsg2r4/EBvk7VaOXYH8jueQDOkSlPikaepIw1aT4oXZyFcop
         d9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7jjkT3BK3TrD5+yfkCQiasOngzvtZFHArOGePxAfgQY=;
        b=emtHDZfcCAPLh5yb+arK2VZGyXuRHhUgQsS9brrXzqssw9jeIhQMOHBTrXuEGE0zpR
         fGtxuakUJZSgE9ZSbyhsJCFNRlqMcMPv6HQH7OO9qf5sJj87+l9VZupicgygxazrl4kq
         0QU1i2t8ieRYepA/kWn4XUlFrvLVJYbO4ajyMLaMIg/sW3dgzAotVvm1G4t+CdvBL9KZ
         nk/71fIsAZrS+4MKPn9gi+7fKOf0yi/avQaEzJ7S92N010Z2HVds3zVak2ufk2cZZdLl
         v/5Yh6/u/+tTPAgLFsSLhqEjJZvCbtVfSkNIOLoPfap2DnWSZ2dTylpLFdKDjh2gMRY7
         IsZQ==
X-Gm-Message-State: APjAAAU7+4F0z2iNO4HzT+JAq7K+4cUwSOPPcxioHOT1E/Qhy+XSBm7F
        q2PnV2yYxVD43mZmcS9LlbnRSw==
X-Google-Smtp-Source: APXvYqybSGDxqGfs0YDwR/MRKFuproumSYuZA3xfdWLANrwNc6cL+PJzmEZqmBocDRbJxqob5OWAlA==
X-Received: by 2002:a25:4e08:: with SMTP id c8mr27714529ybb.339.1555002342830;
        Thu, 11 Apr 2019 10:05:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:2a81])
        by smtp.gmail.com with ESMTPSA id k125sm24528572ywb.26.2019.04.11.10.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 10:05:41 -0700 (PDT)
Date:   Thu, 11 Apr 2019 13:05:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        mhocko@suse.com, rientjes@google.com, yuzhoujian@didichuxing.com,
        jrdr.linux@gmail.com, guro@fb.com,
        penguin-kernel@i-love.sakura.ne.jp, ebiederm@xmission.com,
        shakeelb@google.com, christian@brauner.io, minchan@kernel.org,
        timmurray@google.com, dancol@google.com, joel@joelfernandes.org,
        jannh@google.com, linux-mm@kvack.org,
        lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
Message-ID: <20190411170540.GA5136@cmpxchg.org>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411153313.GE22763@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:33:13AM -0700, Matthew Wilcox wrote:
> On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > victim process. The usage of this flag is currently limited to SIGKILL
> > signal and only to privileged users.
> 
> What is the downside of doing expedited memory reclaim?  ie why not do it
> every time a process is going to die?

I agree with this. The oom reaper mostly does work the exiting task
would have to do anyway, so this shouldn't be measurably more
expensive to do it per default. I wouldn't want to add a new interface
unless we really do need that type of control.
