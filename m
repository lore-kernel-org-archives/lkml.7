Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2EDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5935C20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="SoQnVirB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfDPQdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:33:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32803 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfDPQdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:33:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id k14so24059901qtb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=dpOp2rCFUHLqbHciyTTI8wfp5HqQC2Cnpfqou9WcUjs=;
        b=SoQnVirBrLyp7uUb92BbuvnSFn+szPq8SjzT48x1lwjjc+jFyHGzW/inl4A7pwiw3E
         Tq0fJc+BM/PLE3smpnaI+/e5ofnJbDywWOkywWnR2cfj7qJjlezDZ7szuTRiHy1EiIax
         iikadhZXL8rjjH+puwgMo9Yg4fAnOU6U83Biz3stuEY4nOyw9aAj6YF2fzS0mBIcHglH
         ZcutS43AWKk2HjJjdH0e3KeNwyQP5Fngk2VhgAucy+UB5O6StxDAvp3NoG+JP9wsJ6Yc
         Cz6nh5CnFZ/3r+T9fbQn+gODabOUSf90YXjR0dXyUh97ox2wC97abJ4AScvYfDft8Fxo
         +hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dpOp2rCFUHLqbHciyTTI8wfp5HqQC2Cnpfqou9WcUjs=;
        b=LuAslPiycFg2z/ezg5YcT822BpidbVsez1k1JNnPY+CVOfMPE7kVS43OlMBS8UOJjr
         r+e0IV0mDJA1TU0vieAOIX5aQ2B0xJAh2DdYw1ixzTpHd9ZYHXwdDrbQwnr0+AVOmMNJ
         qPxNbg3gMBMl53NrEZVvMBoFxUUrxCXGenaThFkLQ7vk88DZTKBDSfkrMOc53ptFU9Dy
         nnxR7fLDYKV+LvaOB6q1B1MdLBuJy8rPXxOPI7bOmJbr0I5660c9LeFDt+TrAkvaDYEZ
         LEk0tfYLxM7IZ4nbIP7EFkvoqQJZ5zRsVTmjvGFhKQSi8+lqwTRKAUxRP7zfSC9Zbv0j
         a04A==
X-Gm-Message-State: APjAAAWAJ4/e1LBF/PQWkPMgWM4fJUneMPmY36C02gfpk9/IVSQf5+T6
        vq/0jF5gtLB7D9IN9v0ENAbzzw==
X-Google-Smtp-Source: APXvYqwORePkf9ccMuAVOTVH2Hm+EtiMtV9F67femaoWdjpRIsvULoAqJQt9kbLqi7ycQ6o2bJpXTg==
X-Received: by 2002:ac8:27b0:: with SMTP id w45mr66414745qtw.341.1555432400352;
        Tue, 16 Apr 2019 09:33:20 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s17sm34367198qtc.15.2019.04.16.09.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 09:33:20 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:33:15 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, David Miller <davem@davemloft.net>,
        ard.biesheuvel@linaro.org, yamada.masahiro@socionext.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH 0/3] locking/static_key: improve rate limited labels
Message-ID: <20190416093315.4f8fee4f@cakuba.netronome.com>
In-Reply-To: <20190404102902.GW4038@hirez.programming.kicks-ass.net>
References: <20190330000854.30142-1-jakub.kicinski@netronome.com>
        <20190401112153.2f9e87ba@cakuba.hsd1.ca.comcast.net>
        <20190404102902.GW4038@hirez.programming.kicks-ass.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019 12:29:02 +0200, Peter Zijlstra wrote:
> On Mon, Apr 01, 2019 at 11:21:53AM -0700, Jakub Kicinski wrote:
> > On Fri, 29 Mar 2019 17:08:51 -0700, Jakub Kicinski wrote:  
> > > Hi!
> > > 
> > > This will be used to fix the static branch disabling in the TLS
> > > code.  The net/tls/ code should be using the deferred static
> > > branch type, because unprivileged users can flip the branch
> > > on and off quite easily with CONFIG_TLS_DEVICE=y.
> > > 
> > > Second of all we shouldn't take the jump label locks from
> > > the RX path, when the socket is destroyed.  This can be avoided
> > > with some slight code refactoring in deferred static_key as
> > > it already runs from a workqueue.
> > > 
> > > This the series (and a simple tls patch which makes use of it)
> > > applied opening 0.5M TLS connections to localhost (just calling
> > > setsockopt, no data exchange) goes down from 37.9s to 12.4s.  
> > 
> > Once/if we get positive feedback from locking folks, would it be
> > possible to merge these via net-next tree alongside the patch
> > converting TLS to rate limited branches?  
> 
> Looks good. If routed through the network tree because usage there:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Otherwise let me know and I'll carry them.

Hi Peter!  I was initially hoping that a1247d06d010
("locking/static_key: Fix false positive warnings on concurrent dec/inc")
may go into 5.1, but it's not really a regression.  It will conflict, so
the net-next route won't work.  Would you be able to carry this set
after all?
