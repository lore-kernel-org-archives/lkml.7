Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6318FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261E42184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVyXQYpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfCTKud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:50:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42333 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfCTKud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:50:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so2164453wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=byyOSm8fQnY1q7PlStaUHwXQMjLqMHEJhNuztoZtxR4=;
        b=cVyXQYprwj44RxS8HhhRms/us7vKBj2RclTh4tc836gzovrZQtA7mgIC8MjzFKT1iY
         Fw9/ONpAuz8cNUQmkaFdo+4ScduIB89BPef+DYLEJVYosYnKLl67Mcab05YFdjxoyfLF
         baEwMcbJao0K24XloYi5WOKAhp9qiESx4br+C4aUE/6oARb3Fcr0Omvm5Ls/gGpXzAA5
         q8N9KpxR8SvGbkkUiU6R3fxmioN38QFzgC2rEsrn9xMn/JHh1GAT29stSXFl3IuLpedH
         nP7IeqHnkDTx9n9Fs2OyUfQoDOfzPve05nPbB6goIVomHF4ulV+Q1R60BrTgIfsm136E
         zeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=byyOSm8fQnY1q7PlStaUHwXQMjLqMHEJhNuztoZtxR4=;
        b=DrSaGf7+jbsEZsjoqkTbWArDjnCWvzUyU/1I6MMVr2r1/fN0SZQilxgtZn4eAur0aY
         FQ8boaZoSOeYajS77GoKYxXGbfls5yZSaJM+4D6K61D5V0vCMnc+YdOfUy0r5oXZiMqq
         eFBXDsa27teA3FzuWGRxS4sVPQ9BK+zWDZctwkJ29GlmeYauPj2kLwetlQhVMtVFot32
         6KupDcG5oDcQobcmAqfOB9oGePVNt+Be9bA+DeS+dz5/jRW/GKQmm1mDwXtXccvcwHoV
         3opJhBfaW/VCaq+UizlmbZrHiLEt/R719nAPCUaN/Z/nQyQNpljYOj9GQI/0QrO0Dy2U
         ZQ3g==
X-Gm-Message-State: APjAAAXBqE9BqolSVjSpiWu1YCgcwl6YN0KHXWO717NSxVkS815MrTdu
        JGaYUshx5w1bp0Yt2yWfYfWn0A==
X-Google-Smtp-Source: APXvYqyCjJBwuF20XF98SxC3j0Kq8JkQCwdgPn3Uyf1FLK8ddplUwSbj6pOYmGZGRyvOQ3HYISpwMg==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr5047976wrm.152.1553079031135;
        Wed, 20 Mar 2019 03:50:31 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r12sm2629537wrr.71.2019.03.20.03.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 03:50:30 -0700 (PDT)
Date:   Wed, 20 Mar 2019 10:50:28 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] tracing: kdb: Allow ftdump to skip all but the
 last few entries
Message-ID: <20190320105028.6t6urpf344mljb2g@holly.lan>
References: <20190319171206.97107-1-dianders@chromium.org>
 <20190319171206.97107-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319171206.97107-3-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:12:06AM -0700, Douglas Anderson wrote:
> The 'ftdump' command in kdb is currently a bit of a last resort, at
> least if you have lots of traces turned on.  It's going to print a
> whole boatload of data out your serial port which is probably running
> at 115200.  This could easily take many, many minutes.
> 
> Usually you're most interested in what's at the _end_ of the ftrace
> buffer, AKA what happened most recently.  That means you've got to
> wait the full time for the dump.  The 'ftdump' command does attempt to
> help you a little bit by allowing you to skip a fixed number of
> entries.  Unfortunately it provides no way for you to know how many
> entries you should skip.
> 
> Let's do similar to python and allow you to use a negative number to
> indicate that you want to skip all entries except the last few.  This
> allows you to quickly see what you want.
> 
> Note that we also change the printout in ftdump to print the
> (positive) number of entries actually skipped since that could be
> helpful to know when you've specified a negative skip count.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v6:
> - Keep tracing disabled between counting and dumping.
> - Remove Daniel Thompson Ack due to changes between v5 and v6.

... and I'm very happy to replace it:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
