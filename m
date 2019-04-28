Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DD8C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D4B2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWaPsYuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfD1TTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 15:19:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33537 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfD1TTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 15:19:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so6313919lfm.0;
        Sun, 28 Apr 2019 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mJFlfNrLLhFodWAkDjyar3iFGrW1LqXEzsbbr5M3lsY=;
        b=UWaPsYuc83bWsj4h2kCex5L8UGlnpYYgTp8VNkWrPkDj1HEPkOWnoLzDvKMGnFoCX6
         fO9YpHkKaPm5Cljm4K0dbWkBPXLy/sIsd33cA4daEzKvLQ/PydojlBfnDjL4ny4O2VeF
         wnd7v9gJ/ljKF+W2zcz7BpQAwjy0sIf5vHSfitVywNd8X456r+M8WiFFQQ++4tBgyHC0
         HAbX5JEdVZR8CN2vICH173vrhBI5517r3TYIiC3/ndl4M359eaKTlfak2qmPRtPGVTKa
         j4nW4iiofe0mP+/bG/ATP8QwiKgzqXcXSSThNld4beEWMJqqSMbHnc7k0rB87WM35fI3
         r5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mJFlfNrLLhFodWAkDjyar3iFGrW1LqXEzsbbr5M3lsY=;
        b=paqJRpxovcgCKQgn6vS1QHHxnISZ4OS1BqWcteLAmU7HVdVknyFkVU4EMNU9U+EVI+
         ansIKMvhuzbb/35JNIa6xiiTx9wRrQbPAkrxuklNk6P+dSH85wB2r1IslkCq1bn9gr/k
         MTlwRTamhBsUKIEWIGxylx94MQJ9xlk8ijyhbH1MP/YDB6eoA7l7Paz3pNKgqdY0+Ts1
         nLICgk11j8dW5vQPLXWPdREK/C2SeKbTz9cesgay8RzM5NQ2nKNjoHW2VTLVZtXs+qRe
         Mnf+8h8E/ujJehMJuXlihvKhRPR8Qf8xQgz7pVwbFh4q0bOHMVxjVbTFBl0vKNyC0398
         cTCw==
X-Gm-Message-State: APjAAAUcSTcRBWJO5MOYgFQe6nG9My+bGKuj0HiWjamP1kZivATwb82l
        bSbo/3dlrk1L4t3nDEFknFY=
X-Google-Smtp-Source: APXvYqyXHwhIK5hh1x/2ixW2wygdQGI98pqYAmzIQi/+zhAh695dFkXjiI+m6nJ6IQyYA4GilhDOOg==
X-Received: by 2002:a19:7014:: with SMTP id h20mr31619963lfc.158.1556479148051;
        Sun, 28 Apr 2019 12:19:08 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id p19sm6921283lfc.48.2019.04.28.12.19.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Apr 2019 12:19:07 -0700 (PDT)
Date:   Sun, 28 Apr 2019 22:19:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: phy: realtek: Add rtl8211e rx/tx delays
 config
Message-ID: <20190428191903.ec53f25kspb7zhzd@mobilestation>
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
 <20190426212112.5624-1-fancer.lancer@gmail.com>
 <20190426214050.GU4041@lunn.ch>
 <20190426234503.y6nm5hekyclmgftc@mobilestation>
 <fbf2ff24-a435-fe69-abcc-1f9326e1d61d@gmail.com>
 <20190427074400.is2hbij2k57f5daz@mobilestation>
 <20190427152109.GJ14432@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427152109.GJ14432@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 05:21:09PM +0200, Andrew Lunn wrote:
> > > >> Hi Serge
> > > >>
> > > >> Next time please include a patch 0 containing a cover note explaining
> > > >> the who series.
> > > >>
> > > > 
> > > > Sure as long as the patchset gets to be much bigger than two small
> > > > patches with an obvious reason to be merged.
> > > 
> > > netdev likes to have a cover letter for patch count >= 1, probably
> > > something to be added to netdev-FAQ.rst.
> > > -- 
> > > Florian
> > 
> > Hello Florian
> > Really, even with count = 1? So just one patch with cover-letter? Doesn't it
> > seem redundant since at least a single patch can be thoroughly described in
> > it' commit message?
> 
> Hi Serge
> 
> David workflow is to put the patch set into a branch, and then merge
> the branch into his master, using the cover note as the merge commit
> message.
> 
> You occasionally see commit messages for count == 1, but not often.
> For > 1, if there is no cover note, somebody is likely to ask for one
> :-)
> 
>     Andrew

Hello Andrew and Florian

Alright. I see your point. Though I am not really agree with it at this
situation, the next version of the mini-patchset will be sent with a
cover-letter as per maintainers request.

Meanwhile lets put aside this discussion and get back to the topic-related
one. Could you respond to the email I've sent in response to the Andrew's
comment on the second patch of v2 duet?

-Sergey

