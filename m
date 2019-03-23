Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78281C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA7E2190A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3gh7JXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfCWO2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:28:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41828 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfCWO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:28:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id 10so3224718lfr.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtc6wmjbQBTBQdUz3oV7S43ZDs+IcAGzJyhPyCX9Nx8=;
        b=R3gh7JXz32dmXFxJ2JcCHd9yJKGw9L1b9YMZYSsPsz9jb9ytauJTauxbBt1RYb18CU
         gWPX/oHfpG/qST8eMMUAJkq0Qjp5x6lvpBeG71UOJFB6ibTgKwhYM8ANJlzTUr90JUrd
         UJt85b53ej/7wNOWX1UpARjQbO9+0ocYkIYvQsues0R0vkC1Do2fdIWcQqpGSFWHL8PH
         XuhWpn2ieii5XEwhQvq5BIUZUmUnzjVwuo45N6QP27GMMjJOnDW2wl/a+iVMZyqjIFXp
         MZyDY8aMdUxNL/hAvjKBUkIuSnKxkiVMSHLbPAGEekA0PEc1e5YDwzHZbhYkLxfoM92I
         A/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtc6wmjbQBTBQdUz3oV7S43ZDs+IcAGzJyhPyCX9Nx8=;
        b=UAfo0dIsqMgX6+zTMHpZmrZ36iSjGNqcTwhbywlGJoutyNINsW8dorLMxreGrvG8Rw
         LS9oh8l4Q+KQACLkHQUaYOQBhYLHmyJLqb9jRTzKJl9sPySGATlAwwdOzm5xg+VWLzPK
         KMbm4o6aGvrarroplsdDtWz4spUIL1kTuJ01dZvxqNKCNx4fBicQuU0/CVC+CA8ckB8G
         cj5AImfSuQDY6b3FvnoYXju8d8tdUkHXluBUOXQDlcZlFVlexWlzRgV9djhniJjAFDEP
         im1oIddlbPXEEAHH+tnex/p2PNlyOALEMgMV8u2QdA3xG4BrMj7adfn/EWWt+Vig+1eL
         dVYw==
X-Gm-Message-State: APjAAAU5DsWQq3tzpUZhPHZfvTpz4C5Pm3H0Efpr6YsI4U9SgT8fJ2Fe
        e/PH8daUNIbzXVnc6nFdGpIvmj7imPiWctHh961JFAvT
X-Google-Smtp-Source: APXvYqxrHPRHg9MFL94bt9APenD8tHShlD01TlQaMUMSYhcx19+tg96Q8NwK4vH61TBP87dYKQGLUNvy9SkNTWLs9o8=
X-Received: by 2002:ac2:42da:: with SMTP id n26mr7056001lfl.91.1553351298620;
 Sat, 23 Mar 2019 07:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190301184816.784-1-mans@mansr.com> <CANiq72=H1Gubbr+eoEKUR+m49fkcC7Sr_hsyP3azzpk=i-au+Q@mail.gmail.com>
In-Reply-To: <CANiq72=H1Gubbr+eoEKUR+m49fkcC7Sr_hsyP3azzpk=i-au+Q@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 23 Mar 2019 15:28:07 +0100
Message-ID: <CANiq72=fExsa6cxG=TpuQb3OxcFDdfQhfrE5=OU8vS0gn8KgZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: deconfuse configuration
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mans Rullgard <mans@mansr.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 11:14 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Since you are touching the panel.c options, CC'ing the maintainers
> (please do run get_maintainer.pl in that case!)

I was preparing the PR for -rc2 and I just noticed we didn't CC Randy
which was the last one changing the Kconfig. CC'ing now in case he
wants to take a look before I send the PR.

Cheers,
Miguel
