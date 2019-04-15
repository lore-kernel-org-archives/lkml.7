Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC14C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ECE2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAeENev+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfDOP3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:29:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53356 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfDOP3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:29:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so21196268wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kr44SK2HThZL5A/9tdsLeRzKYr3Xh/YHputuHogkqyM=;
        b=PAeENev+04z0RIKc09YLGKGDdGIzKxqofUMbHmO2r5puU3Wb71+U158bVIlm8/BsXT
         alnSqDnxmBnrEvg1S3BM5RCuSi4OBgfgXK1xV5OP5N0eb8rY+rhV5NK9hODKu/MfnRj2
         PKIn4ZbS0L8a8c8LYufwxjrJIv78KpPiJX6GuXBz4SY0JsvyQUQmzXLTLrnAFOBxEEkz
         RoQU2+ageoHmoA4as+2if75Yd5qaeW7kT1xrSaMQVzCtyxJKulry4ZES8Rh4KB2J7gnI
         DdvA23FOrzdsfKB4OvMjPIqW2hQtrpKTGv7A7aTlrIVOd0Hiw9k5TklW+5oR9SM5tP/J
         2nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kr44SK2HThZL5A/9tdsLeRzKYr3Xh/YHputuHogkqyM=;
        b=l8RyI1hRNXpOJhskTah0PeD6rqKTv5n0Wor+pRtx7wpFni07Ruga/hb0Ecxmnkexgp
         BL1tbDU9H6vXtj/iYCSzwoE92MECVMPrPb6RYY/uMdxOXb65GmcCsp7oumvrcdX/Lt8k
         JPs+8kvj7VxmC+8/UEX0pEyE678oedLhG8zOUIoCHA9QalLWrrJFAaHNc4IPcY5nkVRc
         1LdkCsTVrQ7DEbDTslgw2KAwnUcQvpBJy44W5sbGDLXcwZaQFe91sGDfqJDAnlyLTGYu
         QHq+E4Mm2b2WNdUjDU/WcpsEjWyNEJs+Im3HXe7nero2pEfKUP2/xJ2v/7Ub8IOiufcd
         L8yw==
X-Gm-Message-State: APjAAAWQ2dh6Znu9U97vzf0M6i0D8QXluPtOvp7yYLGf/fQ/VqmlrqJC
        qZDGVnM7aSdJGb0R7M/8h3k=
X-Google-Smtp-Source: APXvYqy9Nd7eZ+JJMnJL8F4YeEpeW7mamrRsU8ZXt8M2mt/CIHjGKlYVsTggoGqVNT6SxhLLUfPllA==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr21702893wmg.119.1555342142165;
        Mon, 15 Apr 2019 08:29:02 -0700 (PDT)
Received: from macpro-scc.lancs.ac.uk (inc028000049.lancs.ac.uk. [148.88.224.78])
        by smtp.gmail.com with ESMTPSA id j7sm72351748wrt.96.2019.04.15.08.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 08:29:01 -0700 (PDT)
Date:   Mon, 15 Apr 2019 16:29:01 +0100
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] driver core: fix statics initilisation
Message-ID: <20190415152900.7axwpeczvu7i5kkj@macpro-scc.lancs.ac.uk>
References: <20190412154819.oiztq2uf4teuxewn@macpro-scc.lancs.ac.uk>
 <CAJZ5v0hSTVHp43TtK9_yjcy2t2V9jSL6VyPJg9cQHE2SYBOejA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hSTVHp43TtK9_yjcy2t2V9jSL6VyPJg9cQHE2SYBOejA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your review.

I follow https://kernelnewbies.org/FirstKernelPatch to write this patch.
It's not stated that checkpatch.pl is for new patches only. Moreover,
https://kernelnewbies.org/FirstKernelPatch#Running_checkpatch.pl suggest to
run over the entire file.

Also, uninitialised static global variable are initialised to 0 by default.
Thus, initialising driver_deferred_probe_enable to false (which is 0) is
redundant.

As my knowledge, initialised global goes to .data section, and uninitialised
goes to .bss.

What does it mean for the kernel? Is this still hold?
Are performance or memory footprint of the kernel be affected?
Please, clarify my knowledge of C and kernel developement if I'm wrong.

I think checkpatch.pl should mention that information as a reminder.

Best Regards,
Willy

On Mon, Apr 15, 2019 at 10:12:43AM +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 12, 2019 at 5:48 PM Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
> >
> > perl scripts/checkpatch.pl -f drivers/base/dd.c got red here:
> 
> Please note that checkpatch.pl is for new patches.  Running it against
> the existing code base is questionable and so the results of that.
