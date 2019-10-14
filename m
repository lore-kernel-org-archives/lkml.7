Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6C8C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1360420873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhfeBhIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbfJNKhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:37:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33822 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbfJNKg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:36:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so24791177qta.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26plC+LB/ET6lKUK8GUr/NZh4YTG4I5vCBM0xWKfjSY=;
        b=vhfeBhIbqctA+sxvOa8rDMgMZA0l1qMP0sDE3KgO56Y6lc3OpphV7fkCxySXu6yuf0
         zQI3csG/xFqaWpTB1334kqSZvke3KFNRZYH+iOzLeYF3LT0sw39+f3oVcoWI/Kv5yeV/
         nNxqTAO+Kkfu0gzhK+V47J7dgvcAuP4c770wVb5w76FXzfs6pyIY8mljaRNp6JX/TsgU
         uSpYNOzzWshBvP5PbZKMF4IAnIEEvTr8NIlBi/AY3fRAdB+qU1REmKvrl1AY0eM9iCWI
         gm54+mmfq7mVRBq78QlBBUDV44/ghCCEpEvb32E2HuFldPnFvz+sBUrhiU9wVri71POt
         YM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26plC+LB/ET6lKUK8GUr/NZh4YTG4I5vCBM0xWKfjSY=;
        b=ic0/BmZXOyJkwprJYXhmtXHz3HN/kZIfqR3VG7RjLOJc2pI5lTIDXvdkJhVYgTakj2
         nkl5bKUBNRkNFX0vJHCvUJIxROHxduEhwgjPQgA//qIz3l1S6OcKp+Z9+dAdY51m6II6
         UXQ35guDCW+CLv9kDfCOrEQbxMK0FseZSx9ooQoklbDBOleXtqoXsuA9cXTAWxobdQBc
         cC86P66/fp5fWP05iuY33z72UM82fphh0531N3pgyVPKMiVS6CONqrvLaJWysT8a5VbT
         YEGevzpcCTS7Gp2+3zCsZGaaRaCgzF3n5UMUSuN0hd+ryCzrYOS31e5ddNIixJ8R0sCM
         eUrw==
X-Gm-Message-State: APjAAAX3tGIX83MD5eH+6nOj05E9/jvdViG/tv62poV5g3qifHBqIxNz
        j88tmuSuWRBR8pw+4PdlfqtcBVj+Rctwm6bw6Lpkjw==
X-Google-Smtp-Source: APXvYqwTjnC0ebjhJ3BkDHAXlucgRKIkCIRgkmsqM/V/dciQe1QoV4OVLkh9U5GxaZS3jwgbGp4caX/J7J0IoKwv77k=
X-Received: by 2002:ac8:37e8:: with SMTP id e37mr30909144qtc.57.1571049418182;
 Mon, 14 Oct 2019 03:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191014103148.17816-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20191014103148.17816-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Oct 2019 12:36:45 +0200
Message-ID: <CACT4Y+aSybD6Z0YHuhbaTKK+fd4c3t4z8WneYdRRqA4N-G0fkA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix the missing underflow in memory operation function
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:32 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> The patchsets help to produce KASAN report when size is negative numbers
> in memory operation function. It is helpful for programmer to solve the
> undefined behavior issue. Patch 1 based on Dmitry's review and
> suggestion, patch 2 is a test in order to verify the patch 1.

Hi Walter,

I only received this cover letter, but not the actual patches. I also
don't see them in the group:
https://groups.google.com/forum/#!forum/kasan-dev
nor on internet. Have you mailed them? Where are they?

> [1]https://bugzilla.kernel.org/show_bug.cgi?id=199341
> [2]https://lore.kernel.org/linux-arm-kernel/20190927034338.15813-1-walter-zh.wu@mediatek.com/
>
> Walter Wu (2):
> kasan: detect negative size in memory operation function
> kasan: add test for invalid size in memmove
>
> ---
>  lib/test_kasan.c          | 18 ++++++++++++++++++
>  mm/kasan/common.c         | 13 ++++++++-----
>  mm/kasan/generic.c        |  5 +++++
>  mm/kasan/generic_report.c | 18 ++++++++++++++++++
>  mm/kasan/tags.c           |  5 +++++
>  mm/kasan/tags_report.c    | 17 +++++++++++++++++
>  6 files changed, 71 insertions(+), 5 deletions(-)
>
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191014103148.17816-1-walter-zh.wu%40mediatek.com.
