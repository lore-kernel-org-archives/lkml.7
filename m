Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A751C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0302086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1fQq7Ol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfHFV33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:29:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33728 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfHFV32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:29:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so64195760qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nDyENKB38R0uDM7hzocjvJMgcMblLNFl99d81wPXq0=;
        b=B1fQq7Olm//etuiMshyzmR6nSITrP4xNB2SwIKDtHN5C821cmc3nhuNNwgaDWMZGto
         1qYoxibjR9Z9Oigna5Oiuk2AYfsr+1BH8D00qhDVSSA1ZyZ4B/N59UUHC+FsVGq2FWHl
         CtGq2qFPjmvD53RUyCsRTToG3Z22W2bFRi1zs9A+4fJEk+NVMXUqDTKSaHZu3bYzxFxr
         D8fjEqe/NPo4IKE8KJKVG3k7PNY/7kPcZBU4/FL+gkuooHMkjb9V6OTyRPVJgE+mZpsK
         zi9/sADR3/muEXHww/dsvT39wNnXqIjhUpuDogkcSLgvusdYd9NyTzpgxtbqIIZJxq8e
         DQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nDyENKB38R0uDM7hzocjvJMgcMblLNFl99d81wPXq0=;
        b=hM/w2tIftZ6mqoWRiQ3XTj7lCKWvG3uflmBUFzoq42dDN8GWDKqXtckGDJwek1Waf5
         RlczAr93ISjNgCXjOmnO8EWrE1sOIYSPU+DIWJ4Fq/Bw8aJg8X/GpDz3xkITMH98mc8Z
         L10WVnMEwQaRVoYoE70YAzfRMZlzqDsPLZdrngVUHTrwTiYzVzm4KRML1XtKHNWszbnL
         ryK32Y9tk4YyC95WKizNa+YTMXW3KMwz/0ARPnX8fd1xH3mrk/xoPg6pM/n6J31roXv8
         fluAOTfhtuxDMc41FHToU1pYheC2Wlv74dvY+uGLNTIIGJtyRwI2zBilgx7qTyVNfAwp
         hVPA==
X-Gm-Message-State: APjAAAVEbS0GVaHZP16TfqPtXOGxlyeEw/48qxl7DBebLEQR18EZJE9Z
        iJqC6d2CwlyQo1t3Q6z2XVSqZP5zrphMR945uPGndQ==
X-Google-Smtp-Source: APXvYqwMhpodfcmFZmigtZ2ZQfdNe3smtprv7hGk7bV/GFr4e1nUIfOgE0olXMdgZCEEf2V/pzG/GSvH0OLHgF7TDz4=
X-Received: by 2002:a37:4d82:: with SMTP id a124mr5158808qkb.72.1565126967750;
 Tue, 06 Aug 2019 14:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190801231046.105022-1-nhuck@google.com> <01222982-4206-9925-0482-639a79384451@arm.com>
 <CAJkfWY6StuyMuKG7XdEJrqMsA_Xy02QZKp8r0K2jwSZwBCt+9Q@mail.gmail.com> <20190805133940.GA10425@arm.com>
In-Reply-To: <20190805133940.GA10425@arm.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Tue, 6 Aug 2019 14:29:16 -0700
Message-ID: <CAJkfWY5EL+MyRzSfcfJF2H8WoX73FEO0bOrwcoR4c4ekvaWvOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ARM: UNWINDER_FRAME_POINTER implementation for Clang
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Tri Vo <trong@google.com>, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure that we should disable a broken feature instead of
attempting a fix.

CONFIG_FUNCTION_GRAPH_TRACER is dependent on CONFIG_FRAME_POINTER and
there have been reports by MediaTek that the frame pointer unwinder is
faster in some cases.

On Mon, Aug 5, 2019 at 6:39 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Fri, Aug 02, 2019 at 10:27:30AM -0700, Nathan Huckleberry wrote:
> > You're right. Would pushing an extra register be an adequate fix?
>
> Would forcing CONFIG_ARM_UNWIND=y for clang work as an alternative to
> this?
>
> Assuming clang supports -funwind-tables or equivalent, this may just
> work.
>
> [...]
>
> Cheers
> ---Dave
