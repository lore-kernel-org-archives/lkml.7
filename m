Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458C0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BE32087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZEMpBjD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfHSQdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:33:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43781 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfHSQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:33:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id h13so2255571edq.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVK+oDacf76Bx/B5cuYpj3efTA3uTCksTraTbtiiMb0=;
        b=ZEMpBjD1i8baVAX/ysJWrVswsclG5Ad98mIeqTE/tdXxI8qBuXPct792egADG2RR7r
         4WqNdNKNoNpDzDDyL8S5UElB1wql/7fcm9FEC9kEb9rR1nmCuc33o1Mu3CGfUOO4vaD1
         fVtFr3LF4sw1xugNbHHRMApJ+dbe8tCgl859HeK8Ezaw612OsfP2u11M5CKtz3i9aYuB
         raHJWrkU32+i55vWzSvZZhUa2Lorjv/Xn4/PRO2V0oFVOxB+GkW2KnO7ujnITNFll6K/
         wXTKtGUMyYu2QqZe/sMjFRDDbes+QqWwm1b95GyQAS45k3C2khb54EAK0qO674IRBVq6
         UlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVK+oDacf76Bx/B5cuYpj3efTA3uTCksTraTbtiiMb0=;
        b=llkz+741Ze1CTMU4t+dviT0WiVpjUib/jetZe/GQOYG+SHlRqI6eplZ1YJvTcvo/n9
         NBlnfR0h7Y9Pawjn4X8SuJkbDEC9c4jhClUbu80mY7fn5WcHDfKR37tuLgLPd3v6aCMI
         cM4rUaxWjA/w64AdlVHTLPvvpqIgu2OpdJgPB6B59Px+A2plLfY6WlbgymbWXM3PKMt1
         hD8+3sl2cZ+EM2Y1BeXgURnXTYyTvQvQ7+6kSvYacEA9gmsTc5Av+C8M6sfNcJR47MbP
         Zn2FuN0ERcwHg5VnP6nE13rUFE4Wio6Y/h/6rUqvjgSj44FBoCpn0Oh6PyKw9WIrQT2w
         d9qw==
X-Gm-Message-State: APjAAAXIGBSP3cz7BzVQUIh3oJnJUWGw39Jin1DCsrefnfCtAM78s9Dy
        chnMGWTOsrDHKmgjHmnH/mLZX5QsVcPJj8oFeWKDRw==
X-Google-Smtp-Source: APXvYqyjbCqvgSjNDeQHl6JxdPMDE41wKcHDp+hgvJVj2Py8dcsk85GHr9ynLPCamRht+oDfymAzPK5UbbwLGbxAp2Y=
X-Received: by 2002:a17:906:ccc1:: with SMTP id ot1mr22297087ejb.156.1566232422354;
 Mon, 19 Aug 2019 09:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
 <20190817024629.26611-4-pasha.tatashin@soleen.com> <20190819155824.GE9927@lakrids.cambridge.arm.com>
In-Reply-To: <20190819155824.GE9927@lakrids.cambridge.arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 19 Aug 2019 12:33:31 -0400
Message-ID: <CA+CK2bD4zE6eieSW2OLQwOQC7=4ncDc8wK6ZjhDO3Dv+BUqnzQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] arm64, hibernate: add trans_table public functions
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:58 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Aug 16, 2019 at 10:46:18PM -0400, Pavel Tatashin wrote:
> > trans_table_create_copy() and trans_table_map_page() are going to be
> > the basis for public interface of new subsystem that handles page
> > tables for cases which are between kernels: kexec, and hibernate.
>
> While the architecture uses the term 'translation table', in the kernel
> we generally use 'pgdir' or 'pgd' to refer to the tables, so please keep
> to that naming scheme.

The idea is to have a unique name space for new subsystem of page
tables that are used between kernels:
between stage 1 and stage 2 kexec kernel, and similarly between
kernels during hibernate boot process.

I picked: "trans_table" that stands for transitional page table:
meaning they are used only during transition between worlds.

All public functions in this subsystem will have trans_table_* prefix,
and page directory will be named: "trans_table". If this is confusing,
I can either use a different prefix, or describe what "trans_table"
stand for in trans_table.h/.c

Thank you,
Pasha
