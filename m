Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4370C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8822075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYwAxvST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCQPOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:14:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44300 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfCQPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:14:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so9517398pff.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VtxNmDYgIzsDougV/TPlkPTZMWK9ij3bHNvJx9sQQjE=;
        b=KYwAxvSTEt56P6tJaKe8vjI6xS/qWRtuvhnTLVp0n1SmoSHRw6VmCFJb4oSwdBFWKn
         Q6ApTdQYJfU+i3l6tFdnfmI1ts1EL6BtrKrsrlMxlLS8VeQoPxqtuoOSAoZqcQOicwk8
         6A6+tlpzcR3YMchkd0ozcReBu9TpiJLPIwPxFxHpxbZr/WBb6DNle6/TXRori7U2Q9rG
         LQrd3tjE3gQMin2Q7Ym3mrPiKURsloYiEnD7qPu9Zy6xgF63K5ygoGWMmhzg0NgW99Xu
         /XsirM9T/qd49NODqs9xObEoFbZIwS/34rpocS/v8sx4CTUak6/RHYNxNgk30sJ1RSLI
         inng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VtxNmDYgIzsDougV/TPlkPTZMWK9ij3bHNvJx9sQQjE=;
        b=IYlDE9Gd8MD30TkFkyAvU/Mjl3NxES4FWxTrqybbe04Jl+7ifNHcuz3/bV4jYiLmD4
         XWIFc7qa3Ia0Y0pBZCEQ3tP88wsigytiubDcbDdGAzQYws9N83s8Yhew/4+7Fycdw2Hd
         +xGtV3QqlOM/CfqsFozr1wNd0kFhg98u72/1WfyCJ2453x0ryb5Hu/HdkrEcyX0fD82y
         MnfOxijnrogBCd/xk9hMG2urHxl8uoErUMyoi8PqenGCeFPd4mgd4nW6Tv9CUXTeY+fD
         7OVpCx8F2z+5xqfLz9rTKNMtKMIgD2lr+fz62/CTNezwYBWhWSX31hBvrDh3Q1JOprBE
         rrAQ==
X-Gm-Message-State: APjAAAXJGTqmhEpWEBWalap2jzm0ZHHVVE5QLjkwyRj4pn+0/ysV4KgE
        kEe6m567JzDMC4LVtZPZZw4=
X-Google-Smtp-Source: APXvYqzC02r0yAnQMpsvne93Q7FVapJYOL27bCBbeOA6qrnLCMVPuSLlTzO4N6O52H7VjNMFLD4bkA==
X-Received: by 2002:a63:b242:: with SMTP id t2mr13305663pgo.451.1552835660127;
        Sun, 17 Mar 2019 08:14:20 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id h15sm7886503pgd.12.2019.03.17.08.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 08:14:19 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 18 Mar 2019 00:14:15 +0900
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCHv2] staging: rtl8723bs: do not use __constant_cpu_to_le16
Message-ID: <20190317151415.GA23308@tigerII.localdomain>
References: <20190317114803.21670-1-sergey.senozhatsky@gmail.com>
 <20190317121621.GA7832@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317121621.GA7832@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/17/19 13:16), Greg Kroah-Hartman wrote:
> On Sun, Mar 17, 2019 at 08:48:03PM +0900, Sergey Senozhatsky wrote:
> > From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> 
> Why ".work"?

Aha, good question. There is not so much of a difference between .work and
!.work. (if any at all).

> > cpu_to_le16() is capable enough to detect __builtin_constant_p()
> > and to use an appropriate compile time ___constant_swahbXX()
> > function.
> > 
> > So we can use cpu_to_le16() instead of __constant_cpu_to_le16().
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> Email address does not match up to the From: line above :(

Greg, sorry about that!
Either you were the first one to complaint or this was the first time
I re-rent a patch from a different google account.

	-ss
