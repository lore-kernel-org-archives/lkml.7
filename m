Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F386C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 00:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569D820656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 00:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556496637;
	bh=D87YdQrfI8j4ASOV/iW19nxbxSpJwygaWkLOJT/tfdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ye5Or/vlaek9gXpp48/zTJS9Ec9OBACuEwhu4Uerh8Zkq9sYsLy/c+4DT7vASMU+Z
	 wEWrgE62IXAb4wp/VW51vD8nUPmVTBpCAWFtMWQF0FqHJpzscEB3G1kPAGHC2W0kFH
	 0bNEmLSsyNFQ2mjBiQ9/sxmaiAzyhuUe1MgxelFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfD2AKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 20:10:36 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:39572 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfD2AKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 20:10:35 -0400
Received: by mail-lj1-f169.google.com with SMTP id q10so7716229ljc.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 17:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daBnujA8XMsVFktt1tOkVwXjbO0tg/42IDsTJURJFfA=;
        b=ZjVoKo+jZRaeawwz2eV2mk5E2D+TEZqHXtoY+bds9frs157skHKZ8ARbCE+r3sf5X1
         fh37PdYxlPrTpHo4Mn/oIKIjf0MaS5uu+udf//8uYzbIZYvajImvIumtM6L+3PEGiKTl
         UAFqQIIp+Xo+EbTOJPhhmPJzSfQ7bVxsD8hf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daBnujA8XMsVFktt1tOkVwXjbO0tg/42IDsTJURJFfA=;
        b=hBlbT4i3ZF1Xoesz5eWXvQrW0WMdXQZ7kEgQZnCoR9RXIcuUUunQUh7z36pHTRSFhR
         JxBTABlAoo4e82EjeXNCySlWwklnU9K3o2kZVdJQbXXb+jQvfrOJnI8WqjXGNWSRehwS
         j3qucWN61f93Q7p3zEHKJ/zwfNmhqFCSAT3h91z6QT8B6+b0PHqLgKl7k4wfbXjwgXgw
         h+OK0Z8Z8c9VW1XLbqtBvjbByz7Bv3kwdLEvZmZZZLTRnbR26bbIuzqSlqNPXMS2suHU
         ZS6hhQGLyV2Y1nIfAA5THTkQhBaj9Q+cV0d9I3u7u0FNEGVjx1+TwBVE1EnV93455NH/
         V02w==
X-Gm-Message-State: APjAAAXcGFbz/4eXP++dtJZUVheWF8BxgwU8y6i0sN6nCDkXu/tJMGmX
        q8YCqLIFiC7ILiqnusZRjNM2a0dVmI8=
X-Google-Smtp-Source: APXvYqxYzXAgAuQSshehartAfBXWywN4nLnLG68V3HOOSTYIO2A0043bLqt5Vqtx6StSPtLO7tO8xw==
X-Received: by 2002:a2e:9f44:: with SMTP id v4mr996665ljk.72.1556496633298;
        Sun, 28 Apr 2019 17:10:33 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id n10sm8115775ljh.36.2019.04.28.17.10.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 17:10:32 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id q10so7716193ljc.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 17:10:32 -0700 (PDT)
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr4066856lje.2.1556496631749;
 Sun, 28 Apr 2019 17:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190428212557.13482-1-longman@redhat.com> <CAHk-=whU83HbayBmOS-jbK7bQJUp87mvAYxhL=vz5wC_ARQCWA@mail.gmail.com>
 <3f8fd44d-1962-e309-49b5-bb16fd662312@redhat.com>
In-Reply-To: <3f8fd44d-1962-e309-49b5-bb16fd662312@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Apr 2019 17:10:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_facR6y3gnmtGwBSJYZdHm5rWSPpPhJG6XswW4+mO1Q@mail.gmail.com>
Message-ID: <CAHk-=wg_facR6y3gnmtGwBSJYZdHm5rWSPpPhJG6XswW4+mO1Q@mail.gmail.com>
Subject: Re: [PATCH-tip v7 00/20] locking/rwsem: Rwsem rearchitecture part 2
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 4:12 PM Waiman Long <longman@redhat.com> wrote:
>
> I implemented your suggestion in patch 1 as it will produce simpler and
> faster code. However, one of the changes in my patchset is to wake up
> all the readers in the wait list. This means I have to jump over the
> writers and wake up the readers behind them as well. See patch 11 for
> details. As a result, I have to revert back to use list_add_tail() and
> list_for_each_entry_safe() for the first pass. That is why the diff for
> the whole patchset is just the below change. It is done on purpose, not
> an omission.

Ahh, ok. In that case I suspect the clever code isn't even worth it,
since it very much depends on just splitting the list in a fixed
place.

                   Linus
