Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAE8C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AA42054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deYxp5Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfCLQsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:48:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35392 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfCLQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:48:42 -0400
Received: by mail-io1-f65.google.com with SMTP id x4so2704307ion.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vn5wNO/WHCHX81GlqPviWQYIH5Lzg6cde82VdIWJCjc=;
        b=deYxp5EciTonLP20GiipCn6zYpT6i3uEQqvqeLMYjvljhs47mCzzshPuTtD8RSDDVS
         Pe7MV5S+CwfbZM+r6pMsbsS0WOifN0FMUMGTwUc94CCm6FcnEtggJXVUycXIYHws+449
         0lVcQujc+6IwJAHtFZFxD59LGeagXWdVpo5bB/271Z1FWOXeG/9wiW1ZnwSetXGcDY0T
         xT+mfiJ0vREY5611ZF1EzHYIzkHlifo9JphZnFKlUar6xkC6EyYpqd3vVUtvUXM8L9wz
         8r+TZEsQxteBO/6pd2qFsxlhzPmfzAs/P6XOA+eK6KegArqBWnO7Gr/OnwZnQx3aPQpn
         VVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vn5wNO/WHCHX81GlqPviWQYIH5Lzg6cde82VdIWJCjc=;
        b=p3A6rgRXQeTjCuoJGmu3JS+4h2nEtTN/henvLgUXkKMXAJZYjJQygxM/S2W8hMsMU6
         PW7DGbLjZ37AhP17q0mY1qbI+ydFJIjIml5oUzfpumaWEkTdObaXdlQ+kz4IVMMU9bKF
         ORBF5MT4Qeza1oYEoyl4BuT6ce7PpC6J97o6Acl4zE/dIfUa9SZzOCOlU9hssvRVfNpY
         P8HINXHrKKEQo7b0DoY7BIVDqzmjRDwuQwDklMmB0H3qAjJXXaJ+hlEHz6Ofm01MHwSs
         fw1MNwNdLyCmgoveCP2cruOy9wZPQiwhGJT9QBTXGyt53KYV3s+UfAJpHBknvh6Vco+w
         Azuw==
X-Gm-Message-State: APjAAAWFg3JWi3tPAoSNLU7g5Mq3ngd4Cq5isa4R5Ud6StR/0iZN9joc
        B9MQKts9bEG1UjddNQPf39NhEwF4XMGG2lGN69o=
X-Google-Smtp-Source: APXvYqxsDkikFxqx/sEbgrtm9RM2PjJGtNIcVX64HEMgN3lMFB5D3QiHEorrQdr1ygFj1VOyLjjpE07EQeirFNKKxKw=
X-Received: by 2002:a6b:e50d:: with SMTP id y13mr326423ioc.142.1552409321489;
 Tue, 12 Mar 2019 09:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <1551501538-4092-1-git-send-email-laoar.shao@gmail.com>
 <1551501538-4092-2-git-send-email-laoar.shao@gmail.com> <20190312161803.GC5721@dhcp22.suse.cz>
 <CALOAHbBR119mzbkkQ5fmGQ5Bqxu2O4EFgq89gVRXqXN+USzDEA@mail.gmail.com> <20190312164422.GD5721@dhcp22.suse.cz>
In-Reply-To: <20190312164422.GD5721@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 13 Mar 2019 00:48:05 +0800
Message-ID: <CALOAHbC5+YJR6BYLCz+-8xPhZPczqnaKv-rZ97tF+traPTut0A@mail.gmail.com>
Subject: Re: [PATCH] mm: compaction: some tracepoints should be defined only
 when CONFIG_COMPACTION is set
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:44 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 13-03-19 00:29:57, Yafang Shao wrote:
> > On Wed, Mar 13, 2019 at 12:18 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Sat 02-03-19 12:38:58, Yafang Shao wrote:
> > > > Only mm_compaction_isolate_{free, migrate}pages may be used when
> > > > CONFIG_COMPACTION is not set.
> > > > All others are used only when CONFIG_COMPACTION is set.
> > >
> > > Why is this an improvement?
> > >
> >
> > After this change, if CONFIG_COMPACTION is not set, the tracepoints
> > that only work when CONFIG_COMPACTION is set will not be exposed to
> > the usespace.
> > Without this change, they will always be expose in debugfs no matter
> > CONFIG_COMPACTION is set or not.
>
> And this is exactly something that the changelog should mention. I
> wasn't aware that we do export tracepoints even when they are not used
> by any code path. This whole macro based programming is just a black
> magic.
> --

Sure, I will modify the changelog and send v2.

Thanks
Yafang
