Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7795C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B158D2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbfETOup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:50:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36222 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfETOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:50:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id a17so16655991qth.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5E2CmroOQaOo/TrxhzxQ6Ezjd12+3pDduSOuRKPBfJM=;
        b=h13j2SnpQbyUyKtfNoMCDsmBRjp+w0l0MYqEGp2znHhJtKf93FrpG3KSHGVbHANYjQ
         pqr3MB+bpwGWSBFIQq/qLGw/C1T9jtGUEfSFZ/SujUsEAjWHrrnN7Nmop49ALifGvxB/
         +LFPnNz8s80AmuXzJr4m4bV2cNrBAcZH2PsxerD5gbDqFXPTuSaeX8nZ82Y4X6CwknzG
         UwU/8wYwYkIugU9HGm4JNEis3FRe6XextdPW5ZU9eMELpfBzAGKyo32Sa1wELeIfBpId
         7/BeNLxybiX5MuDJAg+RZyUphELRo0yOxS3Wvr3gjf089/1xkhujtAHZho5aPlOFEbf1
         PYzw==
X-Gm-Message-State: APjAAAWMOZerPpP2nZnhR183PTczDdXthBzMtMpvKpW85k2QqFyzHuLk
        IuFa7qxC3Fy5k+ugZyZC90SD+rvOmpt3VYFNcu7a2QEZ
X-Google-Smtp-Source: APXvYqxNOt8mBns69LnXFIRC3kU8+EZ1A0S32QHVxvkWdg3L/4bns73ARWOKeQNwLGWNHu74aRDhUu9oWtyJOOevNN0=
X-Received: by 2002:ac8:6750:: with SMTP id n16mr40753641qtp.142.1558363843497;
 Mon, 20 May 2019 07:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-13-elder@linaro.org>
 <CAK8P3a3v2fzSBmYk1vG7sKJ9jnAWGt_u91EuLC7f5jq_PqrKXQ@mail.gmail.com>
 <f92bfb59-07bb-e8c0-c307-cd69da7ccd8a@linaro.org> <5d948d74-f739-0cfa-8fae-b15c20fbe7ec@linaro.org>
In-Reply-To: <5d948d74-f739-0cfa-8fae-b15c20fbe7ec@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 May 2019 16:50:27 +0200
Message-ID: <CAK8P3a3161Oc3ALB74LTuDny-aO9E4VGYpmqQSNoDNbj6PhRsQ@mail.gmail.com>
Subject: Re: [PATCH 12/18] soc: qcom: ipa: immediate commands
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 2:34 AM Alex Elder <elder@linaro.org> wrote:
> On 5/15/19 7:35 AM, Alex Elder wrote:
> > On 5/15/19 3:16 AM, Arnd Bergmann wrote:
> >>
> >> This looks rather strange. I think I looked at it before and you explained
> >> it, but I have since forgotten what you do it for, so I assume everyone else
> >> that tries to understand this will have problems too.
> >
> > This is a bug.  I think I misunderstood why you were
> > puzzled before.  Now I get it.  I need to save that
> > DMA address and not free it at the end of the function
> > (except on error).
>
> OK, now I'm going to correct myself.  I hope I don't make
> any mistakes here because things are confused enough...
>
> Part of what I described previously is still true, namely
> there are tables that need to be initialized (i.e., the
> IPA needs to be told where they reside), and there is a
> separate step is available to zero the content of the tables.
>
> But there really is no need for the AP to hang onto this
> DMA memory after this immediate command has been issued.
> I will add comments in the code to make it less surprising.
>
> But here's a summary of why.
>
> I think there are two things at play that make it confusing.
>
> The first thing is that these "header tables" are actually
> located in a region of shared memory ("smem") that is local
> to the IPA (not the AP).  The the IPA_CMD_HDR_INIT_LOCAL
> immediate command is meant to:
> 1) define the header table location in IPA local memory
> 2) define the header table size
> 3) provide a buffer used to fill the table with its initial
>    contents
>
> The location and size are encoded in the flags field
> of the payload (offset and size).
>
> The initial contents are filled via DMA from a buffer
> in main memory, whose DMA address is supplied in the
> hdr_table_addr parameter in the payload.  The initial
> contents we supply are all zero.  So this is why we
> need to allocate DMA memory.
>
> The second thing is that this is an instance where the
> AP is responsible for performing some initialization
> of resources it may not "own" thereafter.  The IPA
> hardware owns this table, even though the AP needs to
> tell it where it sits in IPA local memory.  The AP is
> able to copy (using DMA) content into that table, but
> doing so involves a DMA transfer.
>
> More advanced features of the IPA would make more use
> of this header table, but those features not yet
> supported so this initialization (and a subsequent,
> seemingly redundant zeroing) is all we do.
>
> Does that make sense?

Ok, that sounds reasonable, yes. I'm not sure if
dma_alloc_coherent() guarantees zero-initialization
though, so if that is required, you may have to
add a memset().

       Arnd
