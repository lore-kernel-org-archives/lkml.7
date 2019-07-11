Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4252C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972D320863
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbqfq59l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfGKTAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:00:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45682 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfGKTAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:00:18 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so14842611ioc.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MQ+WdUsbw85bafIfY5vqhGcvT72hk9+x2VlH4K9nFs=;
        b=bbqfq59lXwLkswsYb1EWpzajlzQMmj6s3ntjMrBCbncKXKjg+/LEZRLqKRic3dB5VO
         yhZ9BF3srLGsuipoADB9dD+1jeSv0JPuhVC3d8+KDMMuE95N4KUb/VMNAksYwKnafQ/4
         Aq1mpndac6ls0mEbhoCj6spdW314CkeR9DiEEWVUO+Qa+OIZB1g0QQNBY8cn5gcYeEYe
         4zJH42Cjj09TpCeeW868D+IiuAcfrV8qKjRjB/GlNQQVLTCshPPFiaUWNgnEdsAdIj9Q
         jHTay489NLEGmLg8CWsysuNBcUUTeRBbDqfFqfPi7MN4uwoBWdjMJ1p+HZCM7Bf0gBpz
         FVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MQ+WdUsbw85bafIfY5vqhGcvT72hk9+x2VlH4K9nFs=;
        b=kTBYZMcNIYLgffkiboJnf6XXFQq2MPWf7d/ENmCeOOkz5JFVq6lbXjGOFTsdc2J/9P
         aVvQsmCKGz94ZeXInRw09Hiz0AOHz3pB3XORNMKK+lXeoY+f5Nojt7zDSibAaf/KcYgt
         xqaj1O/zNsIm9eE9dFbiTRz1+x5RPt7S5wH4vil2XDRQHtISzzPuuNdEoR5ThoFIJD10
         LT1BSG/hMcxoRJ1yzLLVHOHT+NFCShKWgqmFOchl/W9AXcn2XFLnJo4Tf/dD3C9Lo2Se
         Uv0wBDAUx+GWEGy1gwPntffElArPDG9yx2sY2rSB3VY7B+2XFx5ptuzD+WnOUqwN1EeP
         APwA==
X-Gm-Message-State: APjAAAUrCflbGGis0ueeZcUT7DTgKAwbRVmE0h9RWoQGhjlDv/sfHhL7
        rwFRvfPK7Nj3OS3ExsmQ6V3yHFgKmEwH0As4A2o=
X-Google-Smtp-Source: APXvYqxao4C23tWRRS7i+uEPQ0rx39LAUwoCPppfImrL1ZaZYpxs4cQCPzCB1W0Q2XQbqqPIdVRNbC2lZdXN1pfKZ6c=
X-Received: by 2002:a5d:9858:: with SMTP id p24mr6201253ios.171.1562871617204;
 Thu, 11 Jul 2019 12:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
 <CALCETrXKgVMiqSfaWoBoM+WCZGHDihV8frSOdG5BFsRr2=mGJw@mail.gmail.com>
In-Reply-To: <CALCETrXKgVMiqSfaWoBoM+WCZGHDihV8frSOdG5BFsRr2=mGJw@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 11 Jul 2019 21:00:06 +0200
Message-ID: <CAFULd4ZgBB-VMapjY6gcTWoSKrkPx2D_KB+ov_HyC0FXLNhWBQ@mail.gmail.com>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop targets
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 4:39 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Jul 11, 2019 at 1:13 AM Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Recent patch [1] disabled a self-snoop feature on a list of processor
> > models with a known errata, so we are confident that the feature
> > should work on remaining models also for other purposes than to speed
> > up MTRR programming.
> >
> > I would like to resurrect an old patch [2] that avoids calling clflush
> > and wbinvd
> > to invalidate caches when CPU supports selfsnoop.
>
> The big question here is: what are all the reasons that we might need
> to flush?  Certainly, for stuff like SEV and MKTME, we need to flush
> regardless of any self-snoop capability.

No AMD target defines self-snoop capability, and set_memory_encrypted
forces cache clearing in __set_memory_enc_dec:

    /*
     * Before changing the encryption attribute, we need to flush caches.
     */
    cpa_flush(&cpa, 1);

Uros.
