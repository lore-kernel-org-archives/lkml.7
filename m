Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8473CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DA021928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571861735;
	bh=QHiezjYfxn4sLc+sGGgFt/nvLtklMah+lIxtJOoZuJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lTBcGoSzHR6SksMb8vtu0Oz7lxI6aXQhEUCU20sHCuXj4SKhFUs3/bgFBHhPbnCbM
	 U76jJvaeMixroNrpkIaCirHQShpIkCQaIserp+YoJk1MPikbYHwF3OQO+8sEK+80Wv
	 DlLnEfzdqF9uzcJ3iL9Yt3Y70S1nDAaaQJgz80Lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391623AbfJWUPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:15:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34101 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJWUPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:15:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id f5so9459731lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=816t39R7woXwpi4P0kaDZ51TulQhFsv/sI1rickj8mI=;
        b=bmXkO63NtJoUxakzTF2eVeCibnH18VL+m6U+RxQXcqjGwaDE50VnfmaPgUESOXh2v2
         Zp60EhLG5l8J57GRXh83GnxEctvxLWQj4gTiMkGxaphmhn7/Z5TYukqP3tif0I87yEld
         twzwabTE+KLDhegSN3Jqq4G19wBI0H8Fdu+iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=816t39R7woXwpi4P0kaDZ51TulQhFsv/sI1rickj8mI=;
        b=QJWHXjqsWL4HRMyV/YiYaygbvyUudpMCjKNprsVmTiRBrZFN3UJkfYogD/JzyzWdD6
         M15K57gEPvnvFV1WeaaTY/aXs6U789to6gscpaCufgQKS+pw/zwatw/opoBkuYawYd5c
         V7pevuk0K/kX/ilNGap28wHlWxpJKPFCNcwvt8iEHi5+jSpuZEZDUx23gVdiT1/PAbJq
         bIV2gYzkC2hLQnfFW8NAKzClHxlMOaYYEyc9KyUYMyUK+U3Xkf++VlK8m3fwCFKRXy0w
         HVlto7M8tfcKT4/HsB7sMTlsBtUmjnePL8fm5AlhRQacmihBq1sXWrQtgH+JrTPiPE3b
         YO9A==
X-Gm-Message-State: APjAAAWRiWce8c0QSc7thfCAk0lpGSOtyuE2xqkHHWmWY+gNmFQ2lyBr
        c6kRojerXfGkoFUho4TXj5nJW1ikJj7O+A==
X-Google-Smtp-Source: APXvYqy7rz1+eMXXRCiu9L70+Pz5TrqV4hfbGRNMuWWEvOhspltijYAewsh2sB/U0uhpLfuI3z2Y9Q==
X-Received: by 2002:a19:ac04:: with SMTP id g4mr23969800lfc.63.1571861731332;
        Wed, 23 Oct 2019 13:15:31 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y3sm9499001lfh.97.2019.10.23.13.15.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 13:15:29 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id c4so7376019lja.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 13:15:29 -0700 (PDT)
X-Received: by 2002:a2e:2e10:: with SMTP id u16mr3404094lju.97.1571861729069;
 Wed, 23 Oct 2019 13:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com> <20191023190959.GA9902@redhat.com>
In-Reply-To: <20191023190959.GA9902@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Oct 2019 16:15:12 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgC-RGcTOrtY+ZQLdZ74EULBvD_+uiPToqhAAMNjAHM6g@mail.gmail.com>
Message-ID: <CAHk-=wgC-RGcTOrtY+ZQLdZ74EULBvD_+uiPToqhAAMNjAHM6g@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 3:10 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> That wouldn't break the ABI, no more than when if you boot a kernel
> built with CONFIG_USERFAULTFD=n.

What? No.

You're entirely incorrect.

If USEFAULTFD no longer works, and if people depend on it, then it's
breaking the ABI. End of story. No weaselwording of "as if built with
CONFIG_USERFAULTFD=n" allowed, no garbage.

Btw, the whole "breaking the ABI" is misleading wording anyway. It's
irrelevant. You can "break" the ABI all you want by changing
semantics, adding or removing features, or making it do anything else
- as long as nobody notices.

Because the only thing that matters is that it doesn't break any user
workflows. That's _all_ that matters, but it's a big deal, and it
means that your fantasy reading of what "ABI" means is irrelevant.
Just because there's a config option to turn something off, doesn't
mean that you can then claim that you can do whatever.

So your statement is nonsensical and pointless.

Please don't spread this kind of bogus claims.

                Linus
