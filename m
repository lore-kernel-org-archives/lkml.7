Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917A4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639082070B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="siW7/+Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfHTBND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 21:13:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37654 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfHTBNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 21:13:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so2192902pgp.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 18:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gcg1TIyUzFxxlA81LjYIRwKVzD7/bL5EZdTOuDoC+1c=;
        b=siW7/+ZlyyfE9Ou+gCBx8jZsWAQa1gTwU28gp29cwjqVTx1Lgad/XphN4RlImfDdOv
         2BQlIBiItdFsWt/pTfsAqg4mVD9zbX7lIo7ivlWDalIykDndMqvQ5MQIjmMCpTq4Hsvp
         3SnbKloKR69uZLKl7VpSyLOaJ12YlKEesBZOn2MTWwTJJi+6xqBo10ZeDkeUteptBWA5
         YXGTjkGaZkOZzEmy1uW4ih1Qwkl/QjvScQ2FQBGiVHz8SqLRXjCI/eSNB4vCMPlwMT+h
         hs8ZZcmLL+OFda81pzOsomKe7q3/wHBTwSd/PftK7NpqEcZrR+RWov+wVMY1akw/Qq87
         ndVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gcg1TIyUzFxxlA81LjYIRwKVzD7/bL5EZdTOuDoC+1c=;
        b=hx2oJB9YCM3U3UZiOefm6HrgMzuq+tkG0Oq2gjHJQZgJbrhiA4dp1pda8pCpAa7iuj
         urXV/h7P63KBs4plSQHBw9/TrdWTJ0cXhfoMSscx8pVmwZI8U1zr2fbANX8xLFTPpTKZ
         MUWURdNKnHxsVJR6UUKHn1Vchklhxg3/tVTrNwrj/nZQIFAUgd8/JQMbk1k7gzWHx4WZ
         OhMFKhMEyejK8xrqCvPum7zPMSeowC/Xb7PYPWyO/8FpFLJn+B0JvYxwY8GUpb0tSC4j
         QGroaYwYawh54ijVsQGVYT0dP1inAYjIhm8ETtnQFkwWOH9zOycFc00YqdmvZs3Ycc43
         mQ8Q==
X-Gm-Message-State: APjAAAWpf/30zvcn4Fl8s/0j7q7OWUrTFZitFpToxzQrUN43iaB3x1iK
        9eJ7OlMh4t+BCSmgGOetOXwiig==
X-Google-Smtp-Source: APXvYqwwQuqYwKcfAJzTL9vULrGYrNn4rtFjGuXSylssXZm/xWw6CZLfZ0JVnBWWZ/ZKFRtRSBVZpA==
X-Received: by 2002:a17:90a:9f4b:: with SMTP id q11mr23242647pjv.105.1566263581995;
        Mon, 19 Aug 2019 18:13:01 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li456-16.members.linode.com. [50.116.10.16])
        by smtp.gmail.com with ESMTPSA id h42sm2712377pjb.24.2019.08.19.18.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 18:13:01 -0700 (PDT)
Date:   Tue, 20 Aug 2019 09:12:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH 1/2] perf cs-etm: Support sample flags 'insn' and
 'insnlen'
Message-ID: <20190820011255.GD5599@leoy-ThinkPad-X240s>
References: <20190815082854.18191-1-leo.yan@linaro.org>
 <CANLsYkx5TanDyztpceZvwf4pZSgoqRMOBgiHcdJxxpnGA9-h-Q@mail.gmail.com>
 <20190819185054.GB3929@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819185054.GB3929@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 03:50:54PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 19, 2019 at 12:08:26PM -0600, Mathieu Poirier escreveu:
> > On Thu, 15 Aug 2019 at 02:30, Leo Yan <leo.yan@linaro.org> wrote:
> > >
> > > The synthetic branch and instruction samples are missed to set
> > > instruction related info, thus perf tool fails to display samples with
> > > flags '-F,+insn,+insnlen'.
> > >
> > > CoreSight trace decoder has provided sufficient information to decide
> > > the instruction size based on the isa type: A64/A32 instruction are
> > > 32-bit size, but one exception is the T32 instruction size, which might
> > > be 32-bit or 16-bit.
> > >
> > > This patch handles for these cases and it reads the instruction values
> > > from DSO file; thus can support flags '-F,+insn,+insnlen'.
>  
> > The code seems to be correct.  I have also tested this patch.
>  
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Thanks, applied.

Thanks a lot, Mathieu & Arnaldo.
