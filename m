Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54852C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A10C2182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563381475;
	bh=30eU5ELaAJYoi29O7YFGfYhLpZ9NmIoalK4wfJfVBMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C/bnEKLkdHhlj2Ka5SLymjnyECAap4LiwvrlDFdbOXzBylVK+s4Z5u6SM+Ha1JWUF
	 faWDNi8klw7TdtesnKTkURDusjWECbKa/vAcPCAKLRI2xvPzXUdiCW3i+BRGHl/oa9
	 sk2RqS/91JDXOBpS+9Ynv/W6JmmZGOBKxJFMc2NA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfGQQhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:37:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33699 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfGQQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:37:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so24306685ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMxKBrHbaCYZ7EPaXwQPGqSA3XqPvkB1xpOdIDuCCrY=;
        b=W+H1eAbr0x/336nxm+phDdQoBpM4zKEhC1A3xYfYOJhkFt1KU0HRU10ocYzgZ72S6Z
         CODVGbLbkNpHiPQXBkqNBLVV0xA4XfE9VW/YjeKZ4/FQY3DYsMECEiPfF3nZQv2PRfY/
         qkSR8VR/H0YU3Rx6BBKcjqn+gBiq1T8ZXFS1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMxKBrHbaCYZ7EPaXwQPGqSA3XqPvkB1xpOdIDuCCrY=;
        b=reAT+S9egBSB12mm7wcpDIMipgrkP6QvPU36NRdud3U8LaBIzsQ8zUCEKJoIL+4KNt
         OxP9ECDM7IVeHr5ig6lQhswiin0nDLphwp5G8blXYi/Pax8rZk2m7YbQOOd/yNnbgfNC
         rLDrX3V0Pq6LK5Ufc3asWdVld/fHVOSXKlogRFlnFUIu4PBLlQFGu0xhKpVUdpMxA0I5
         fmijcNJuMvzE+OU/FseOJxAI1Ii6/o/6n7qt12Kglc0ZZLLIBKuIHntM89XRnpXkgsgR
         9B0v1C/TCF2zX4zS2Xsg6Tm0BavnhSgWa0lSYwYzlGogdkPShGmFrBhPRDEXSw24bKwY
         dP+g==
X-Gm-Message-State: APjAAAUX0ei6m259DqfhKkIxvM83ucDfMFyGxa0szVC67n3BDTGj9MVf
        8qeESGQzEz+dTWHvumgkqePm+fosNrY=
X-Google-Smtp-Source: APXvYqwekrg1mPFYRNxddcbP6z9ppqmk2+enSksibszSVA5J8fBG+GiLQm1UGKMryIXMS3QSw+jxmw==
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr21460593ljj.122.1563381471404;
        Wed, 17 Jul 2019 09:37:51 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id l22sm4521780ljc.4.2019.07.17.09.37.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 09:37:50 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id z15so12701288lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:37:50 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr18454554lft.79.1563381470164;
 Wed, 17 Jul 2019 09:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <87y30xozv8.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87y30xozv8.wl-ysato@users.sourceforge.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jul 2019 09:37:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHq9OWGJ6nE6jhO8cguW0k+Wk-tsoqas5gdKtN_Djbow@mail.gmail.com>
Message-ID: <CAHk-=wgHq9OWGJ6nE6jhO8cguW0k+Wk-tsoqas5gdKtN_Djbow@mail.gmail.com>
Subject: Re: [GIT PULL] arch/h8300 update
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 12:59 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
> h8300 update for 5.3

Both this and the SH update had neither explanations nor a diffstat.

Yeah, they were so small and innocuous that I took them anyway, but
please fix your workflow.

                  Linus
