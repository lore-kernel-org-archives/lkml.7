Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC52C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EA720828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576000358;
	bh=h1yDgBiBQnmhjiwC4RsoTbv9SDy85ywpupjU/q0rRKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1RcbLS5WKJYeKjPhrsLnf7n0LOXjSXHY5cfxPaUiWm/+Sm/f5HsvtG7CndW+XzRI4
	 CrbXSCAWM4G5405KpYL8JpZYT0uXnvllFWPLavh4SeEiqhqG7IaSr/dROOdSmn7+rK
	 vW7vi7j/iUgW14ZQIjMZuSoRG5464nv6sBiV0nKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfLJRwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:52:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33140 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfLJRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:52:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id 21so20957385ljr.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 09:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktwnBelOBvFJpjKuF3uDbyoR2+Ho0WYd40e7X6G/Ax4=;
        b=XDHhbs2a8XE64U2SOt752BFK+HfakWHiThL/FiJTrRyMG/Vs77GtdpLI8fgQKUor/O
         +kGI9sdd9bjkCqZiqBE5NKc6GvcYHWa5q+tJOgwbt9LMIdYAwc+FCf1I08Plw0ztBuAG
         iiP9mpueXZ6Tupr+S7j2jUNPTo7OJISmLlrOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktwnBelOBvFJpjKuF3uDbyoR2+Ho0WYd40e7X6G/Ax4=;
        b=S4nEGpxSRchzoY/vCLkou+OJAEIANCUNHO0ocN2Jt2669EVkwogNUUIU/1PAbm7AJ5
         2TE9znu8RICPxZdFETOAer0xAQvcLb1zcFvTA9HudkrzdyvXPSmzMMyO01ZyqUO+Y/yV
         ZHbjtIdb1DQVyJqrYdZsdVcG7cu4KEATxC2ILnLIpxyGHwo1bGygPY99l85vwUoU5HHj
         bNkvEzgyciwFczGLMRBxjlNfsUWcNnoQq4QPNhHUPns+aGQyNY95pAOu5ff6b6ydog06
         MQbsnjYNbTMwl11C2SGK7TX0Hh0Mvp/Gd9LTFpNW3hpsVmq4za8L6xVFKCk8wrHIgbER
         uhkw==
X-Gm-Message-State: APjAAAUC1w1PISC0tbqjLWm83U8EjyM9eAy75jtqkcrfKWE3KxWoUkmg
        iHI0u8fBOWFwV4AHqd4YjoOhmcSHJ3M=
X-Google-Smtp-Source: APXvYqy68OsK1llJEQLk2JPrBYEgYQ0FMSD6rEUgo1+OVczbxcncSRqDgiU+w1TggCLQ0gUYh5TT+w==
X-Received: by 2002:a2e:9181:: with SMTP id f1mr22086298ljg.51.1576000353985;
        Tue, 10 Dec 2019 09:52:33 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p26sm1980411lfh.64.2019.12.10.09.52.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 09:52:32 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id y1so3122162lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 09:52:32 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr16180003lfp.106.1576000352511;
 Tue, 10 Dec 2019 09:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20191208153949.GJ32275@shao2-debian> <20191209085559.GA5868@dhcp22.suse.cz>
 <CAHk-=whF0mbvWC=sYKWTrpymmjWkGZcX9hnHgnm1t1M++W66zA@mail.gmail.com> <20191210141502.GQ32275@shao2-debian>
In-Reply-To: <20191210141502.GQ32275@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Dec 2019 09:52:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjj33OvL17p4XOjTjS-_MMEr5p0RqR9yLGhKWV3cgb57w@mail.gmail.com>
Message-ID: <CAHk-=wjj33OvL17p4XOjTjS-_MMEr5p0RqR9yLGhKWV3cgb57w@mail.gmail.com>
Subject: Re: [pipe] 3c0edea9b2: lmbench3.PIPE.bandwidth.MB/sec -17.0% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 6:15 AM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Hi Linus,
>
> Sorry for the inconvenience, indeed, the regression has been fixed.

Woohoo.. And more than fixed, it looks like. Not that I looked at
historical data, I'm not sure how much this number normally
fluctuates. I'm assuming the stddev is just a per-boot "do it a few
times" rather than any long-term thing?

                Linus
