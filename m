Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88EEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FE0218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRlEoDHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfCTUjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:39:16 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51340 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCTUjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:39:15 -0400
Received: by mail-wm1-f45.google.com with SMTP id 4so85756wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QtXCkD1EGRDrRYjOnCfs08SvF8/UAvCiKGLbAEX6Tyk=;
        b=uRlEoDHMUNPxQ0L/OeP4I2isOxExoQJM3UPDqJcINRU99uIicizH06iF9ngtPo7F6O
         kbPjJmebnnpBWMxQVa0tMsWCM0pjkLknc4zXuw2CBVG61oUnXygAMsgUdIHvEbXzXtnv
         YhPxhtThpLMBtp8c8ncIUY8d5WBtiSqjQpG47/0+PSARLHrFLjZQzhHWi2lUccAU7sqd
         kPcKG60+StMq6ukb8gXa7dF4IEpWjVUb+K7g6A06kAWbe4DB1j7S3nK4Saom4I+n/1jz
         XKffmoDfmehsFIYSVWCl9FKL8iyJffPULFDLq32xl7GU5d9mtp1ENoiT6PzNrrUxL3iV
         jo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QtXCkD1EGRDrRYjOnCfs08SvF8/UAvCiKGLbAEX6Tyk=;
        b=f1rphB9Ldh4OHXYeXxSYEe8It4uUpq8vLek1AVczHCwmBzGukMNhJm4bLhhJCDeHQh
         ScMaLBBRnYEpj0MJM6eSUbLV9d1Fgd/DDiV8bIIXDtp0Gtd7QUlAaVcSQgAaoR/e+/At
         aibdoml24GqCFt3hGl6VEAZ+Jq1idZOse4at9bgWmf5IGJPUP6SPBiL8uHTswfTlMptU
         4uCNLo0VEpYUQqgwKJBwNHQSijpzrL0qa+kA1BzgAaBad3cLrlRpW+d5jfHhBY90Uzbh
         Xgaeju9KMUXv9Xh5c2q5HFtRO/83WRv1kuTo7+eMdandJjyph281tUCsKNWPJQgn5y65
         JVQA==
X-Gm-Message-State: APjAAAUNLDiNALDjBPFYN2lr/6j3IITUhJx2ycrDu9vpJsshDoLqd7lt
        FkW6YOxVX+cCbvoeW4OCfw==
X-Google-Smtp-Source: APXvYqyLZG0NeSJaJl4C/7zwXmib9hqHLLMdsxUEiWjvOtWFPHxWdUQgfj25MrxbN3MVtE8TZqbm9g==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr146626wmj.117.1553114353760;
        Wed, 20 Mar 2019 13:39:13 -0700 (PDT)
Received: from avx2 ([46.53.240.229])
        by smtp.gmail.com with ESMTPSA id e16sm6404190wrs.0.2019.03.20.13.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:39:12 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:39:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: pidfd design
Message-ID: <20190320203910.GA2842@avx2>
References: <20190320200702.GA27111@avx2>
 <CAKOZuespjOTbaTDbgQLo=7PXTE-nYCLy7k=s+RJh_GpZ_5gwgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZuespjOTbaTDbgQLo=7PXTE-nYCLy7k=s+RJh_GpZ_5gwgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 01:14:01PM -0700, Daniel Colascione wrote:
> On Wed, Mar 20, 2019 at 1:07 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > What would be your opinion to having a
> > > /proc/<pid>/handle
> > > file instead of having a dirfd.
> >
> > This is even worse than depending on PROC_FS. Just for the dependency
> > pidfd code should be backed out immediately. Forget about /proc.
> 
> We already have pidfds, and we've had them since /proc was added ages
> ago.

New pidfd code (or whatever the name) should NOT depend on /proc and
should not interact with VFS at all at any point (other than probably
being a descriptor on a fake filesystem). The reason is that /proc is
full of crap and you don't want to spill that into new and hopefully
properly designed part of new code.
