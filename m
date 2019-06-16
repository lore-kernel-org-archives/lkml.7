Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C648EC31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 10:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C88F2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 10:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp0zNssZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfFPKMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 06:12:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34984 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfFPKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 06:12:49 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so15178385ioo.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXi83X39sc+SHqsRQb9qWakQ658qfuo/1ekg8hliBD0=;
        b=Sp0zNssZ3yGsTgfmNa9NkVGcWT/8Bn/SQOq3LUSy7KJSExWEAP4Qte5nb4jT/waLpA
         fx7Qiv9/fF+EuODR9/itkek4S1+dEGfgVBOpDm2wGAUXcueWeHHHgPI4wt0FQR5VbGM3
         AyMwUJQNqwZiviyReqLSvHBVMV1mh/d5rdKdeisQRDZUSdZ4rFT/LW2qAhZvHXEwpw56
         s+EyglpJMgN2kuq6581xB/X5hMUB6T61S385mK7WaOnmn8+oXbr+Xm7wGXu3S+gcCYpo
         VkTGDhLKQfwOkEo2pwG/g42CgANc4AAV4Oh+lIF1BMZ8YpnXxtsvU4mppO9esDH4g/1a
         HRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXi83X39sc+SHqsRQb9qWakQ658qfuo/1ekg8hliBD0=;
        b=XRZEZ8iV8ZtazjvzR+Z+yxE9ulLF+3LzuVhiOwMLWMdiJmmI5D/lBRZoiNrV8V7OGY
         AlhQWbu64Lwoc/sji/z+6I71HuiZ4MmA0jba85XzSVig/ZBWsxoVj//Mx/yQC4NVQ/mL
         vM9Rh9pOYhrsYc5puwlPFcCrAPvtATaIB/0Ec9f3OLEaKp/Q85N/QlAsot0airNqy384
         LHTjINGWIjxBXu/Rj5pgP6Q6U0TOivqStfToKD2f+jjkKKDBPNyu7i2uBosRPadGZZMy
         FQl+S/qSOpeTOeUi0TeIEsyqgBPVCCv94q9FxvTomzqsejYF4DXbsIir40tCp6wh6w9Y
         2QxA==
X-Gm-Message-State: APjAAAUjdJGkA9PH8QkQXJMCuCXmcA/994DnQN9AXjkPO2NmEBgc1u5E
        G+xABTKSWtsEhZFlfJEzpRg99FS+nauDQsVf23HeliDG/VLZnQ==
X-Google-Smtp-Source: APXvYqyUrK+C6uFyPu/mN+CP7kqloxH5tDYqAI6TJES117YkgWE/uPQUS7hB4tpeYLyAnmqD+FGwYyPPoXuvWiRvuYI=
X-Received: by 2002:a02:16c5:: with SMTP id a188mr78260707jaa.86.1560679967918;
 Sun, 16 Jun 2019 03:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com>
 <20190529180931.GI18589@dhcp22.suse.cz> <CABXGCsPrk=WJzms_H+-KuwSRqWReRTCSs-GLMDsjUG_-neYP0w@mail.gmail.com>
In-Reply-To: <CABXGCsPrk=WJzms_H+-KuwSRqWReRTCSs-GLMDsjUG_-neYP0w@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 16 Jun 2019 15:12:37 +0500
Message-ID: <CABXGCsMjDn0VT0DmP6qeuiytce9cNBx8PywpqejiFNVhwd0UGg@mail.gmail.com>
Subject: Re: kernel BUG at mm/swap_state.c:170!
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I finished today bisecting kernel.
And first bad commit for me was cd736d8b67fb22a85a68c1ee8020eb0d660615ec

Can you look into this?


$ git bisect log
git bisect start
# good: [a188339ca5a396acc588e5851ed7e19f66b0ebd9] Linux 5.2-rc1
git bisect good a188339ca5a396acc588e5851ed7e19f66b0ebd9
# good: [a188339ca5a396acc588e5851ed7e19f66b0ebd9] Linux 5.2-rc1
git bisect good a188339ca5a396acc588e5851ed7e19f66b0ebd9
# bad: [cd6c84d8f0cdc911df435bb075ba22ce3c605b07] Linux 5.2-rc2
git bisect bad cd6c84d8f0cdc911df435bb075ba22ce3c605b07
# bad: [060358de993f24562e884e265c4c57864a3a4141] treewide: Replace
GPLv2 boilerplate/reference with SPDX - rule 125
git bisect bad 060358de993f24562e884e265c4c57864a3a4141
# bad: [d53e860fd46f3d95c437bb67518f7374500de467] Merge branch 'linus'
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad d53e860fd46f3d95c437bb67518f7374500de467
# bad: [34dcf6a1902ac214149a2742250ff03aa5346f3e] net: caif: fix the
value of size argument of snprintf
git bisect bad 34dcf6a1902ac214149a2742250ff03aa5346f3e
# bad: [c7d5ec26ea4adf450d9ab2b794e7735761a93af1] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
git bisect bad c7d5ec26ea4adf450d9ab2b794e7735761a93af1
# good: [3d21b6525caeae45f08e2d3a07ddfdef64882b8b] selftests/bpf: add
prog detach to flow_dissector test
git bisect good 3d21b6525caeae45f08e2d3a07ddfdef64882b8b
# bad: [3ebe1bca58c85325c97a22d4fc3f5b5420752e6f] ppp: deflate: Fix
possible crash in deflate_init
git bisect bad 3ebe1bca58c85325c97a22d4fc3f5b5420752e6f
# bad: [d0a7e8cb3c9d7d4fa2bcdd557be19f0841e2a3be] NFC: Orphan the subsystem
git bisect bad d0a7e8cb3c9d7d4fa2bcdd557be19f0841e2a3be
# bad: [0fe9f173d6cda95874edeb413b1fa9907b5ae830] net: Always descend into dsa/
git bisect bad 0fe9f173d6cda95874edeb413b1fa9907b5ae830
# bad: [cd736d8b67fb22a85a68c1ee8020eb0d660615ec] tcp: fix retrans
timestamp on passive Fast Open
git bisect bad cd736d8b67fb22a85a68c1ee8020eb0d660615ec
# first bad commit: [cd736d8b67fb22a85a68c1ee8020eb0d660615ec] tcp:
fix retrans timestamp on passive Fast Open



--
Best Regards,
Mike Gavrilov.

On Tue, 11 Jun 2019 at 08:59, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Wed, 29 May 2019 at 23:09, Michal Hocko <mhocko@kernel.org> wrote:
> >
> >
> > Do you see the same with 5.2-rc1 resp. 5.1?
>
> I can say with 100% certainty that kernel tag 5.1 is not affected by this bug.
>
> Say anything about 5.2 rc1 is very difficult because occurs another
> problem due to which all file systems are switched to read only mode.
>
> And I am sure that since 5.2 rc2 this issue is begin occurring.
>
> I also able recorded much more kernel logs with netconsole and option
> memblock=debug. (attached as file here)
>
> Please help me.
