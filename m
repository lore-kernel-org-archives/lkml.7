Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18731C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8D621852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfCNKtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:49:25 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42721 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfCNKtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:49:25 -0400
Received: by mail-vk1-f194.google.com with SMTP id j195so1239804vkj.9;
        Thu, 14 Mar 2019 03:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKIy6b/fNCRNihuz6p5NEN8T4h5uuF0FEWiD3d25trM=;
        b=S85v7KWnltIKr6ADoIjqEIVcQ8Ebt9/NL3I+IRoVAannUvNBU8JyHJvbfUuRreisTc
         /TasL9cjMLVcvNMIxL4AfHEeQG+tpu34Q7EZsxCzZyXp3xmisfMKE6w33uE8NIwZu9x0
         Nv7jKPdnx5TBCAlp1EV1C9fhsrWSMrTuZbJrb9eGRoFFW4PKorLe3smf04CZsmQYAg0c
         QwKnL8zmdiiZBXSCyFhgafj67bwtaWM7CNa2+Lid64jk4K/epehx55s4w59fS9cCFU1b
         JU2BsPlVsnjipecxPp3+h8IYNUCJQQxc6MBQaoah37MWTIcYHTv89zDDt2tje4linYdE
         FWqA==
X-Gm-Message-State: APjAAAVZCuv7NyubBpthekeiAICF+YzPhAfckp0KmpRz5le9DDTXXqPO
        Mx7gSM1qLrYZCqOzyDm7T+lkMBERuSW0/ey45M8=
X-Google-Smtp-Source: APXvYqwtcokC363S92X30DVpTwpfagjfF35hnbhkU5rvXgptBu+4psAL/vyiRbF4okgUVeSTZ6degWc/gy/AHitFrSA=
X-Received: by 2002:a1f:ae07:: with SMTP id x7mr3397776vke.74.1552560564022;
 Thu, 14 Mar 2019 03:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754746514.17872.4993763624097980573.stgit@warthog.procyon.org.uk>
 <CAMuHMdUo7QA+xtWWoyBtFHghwYYp4XUWeHYRM2Mt5QXq+ACTww@mail.gmail.com> <21986.1552559249@warthog.procyon.org.uk>
In-Reply-To: <21986.1552559249@warthog.procyon.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Mar 2019 11:49:11 +0100
Message-ID: <CAMuHMdVgGUrPZAS8hT3sKMSBi8rNYu6zZ8AKBV2wRyhe8PWHTw@mail.gmail.com>
Subject: Re: [PATCH 07/34] vfs: Add configuration parser helpers [ver #12]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mszeredi@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Mar 14, 2019 at 11:27 AM David Howells <dhowells@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > When would I want to disable this?
> >
> > It seems this option was introduced in "ver #10" of your patch series,
> > without being mentioned in the changelog for that version.
>
> Sorry, yes - it's a debugging tool to check that the parser tables are vaguely
> sane.  I set it to default to 'Y' for the moment to catch errors in upcoming
> fs conversion development.  You probably want to disable it if you're not
> doing fs conversion.

OK thanks. Makes perfect sense, now I see the output of

        pr_notice("*** VALIDATE %s ***\n", name);

in my boot test.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
