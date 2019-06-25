Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC0C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9D42063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="naD61bgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfFYR0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:26:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46754 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFYR0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:26:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so17058961ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gq84utB8K04TkFkVIjVVbqj+RReCP6QFmHdu5HDrdE=;
        b=naD61bgrphwvsuQeh7I3S2TOG7WlFTu05G05sniZdPLkEFxpVLI4QzWmwpfPA9CiN2
         ATfzx5rBs7HjKcRc1YDoStMPiGwTbE/QZWGQPVuWefMqhX47HS5O9BFNQFOGzfMmdXPX
         IVJXBGv0G6J/Vm5nvfJK/lyKs9vJ4Qmi6I9GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gq84utB8K04TkFkVIjVVbqj+RReCP6QFmHdu5HDrdE=;
        b=qTqFGVcClNgBurTPKnRdq17O7D81WHYiL0tHb6oauerrw7BDsJso6iV/+lf53f2jFC
         lYwl7fsS/WfMBqOioElaApnwVS3v0Xm09GJZaT3oMlfGWYMm8hQkWYx0OlRiAlDtbAqF
         F8tAtT1BQVWl51/r05g7sqvGEtMa2xKcjpe9bqW009lFuhUPRtbLxKO8IQFCX/DBYk3K
         6JzOgwk1g6mXzhCO9PB8dmWp+G1kSHE65VnvizjlbsfsKONFqUL+TpKMkBoh4abKCXAd
         KKIx7VGpoc1h/Ug2zQk+OBcGSi08sLSQork2T+3obm9vtr/1N8svDhmFICByKf7lWNVe
         hE1g==
X-Gm-Message-State: APjAAAWhQcZVX/rj9aJE2fTH3V/gzmccQMrsL7WWfRATg4pKWreVs0li
        7EU4cMjk3G2bsuOVInmKW50iqYV/n9c=
X-Google-Smtp-Source: APXvYqx6owkLDuWzHNsdFbI4dR7//+vrm9KeJ4KlrDvRWQyYelg1WwIznZ8SY0xsvu5wWk3SYOU2yg==
X-Received: by 2002:a2e:9b10:: with SMTP id u16mr38601399lji.231.1561483600197;
        Tue, 25 Jun 2019 10:26:40 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c19sm2014827lfi.39.2019.06.25.10.26.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 10:26:38 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id q26so13256266lfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:26:37 -0700 (PDT)
X-Received: by 2002:a19:5515:: with SMTP id n21mr22825839lfe.26.1561483597150;
 Tue, 25 Jun 2019 10:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190604205323.200361-2-briannorris@chromium.org> <20190625044525.846A8607DE@smtp.codeaurora.org>
In-Reply-To: <20190625044525.846A8607DE@smtp.codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 25 Jun 2019 10:26:25 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP2xY_7BXk6L25FVFf1yyhnXOZygYwreGYGVY7aK0TVkg@mail.gmail.com>
Message-ID: <CA+ASDXP2xY_7BXk6L25FVFf1yyhnXOZygYwreGYGVY7aK0TVkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mwifiex: dispatch/rotate from reorder table atomically
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 9:45 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> New warning:
>
> drivers/net/wireless/marvell/mwifiex/wmm.c: In function 'mwifiex_wmm_process_tx':
> drivers/net/wireless/marvell/mwifiex/wmm.c:1438:4: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     mwifiex_11n_aggregate_pkt(priv, ptr, ptr_index, flags);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/marvell/mwifiex/wmm.c:1406:16: note: 'flags' was declared here
>   unsigned long flags;
>                 ^~~~~

Yikes! Not sure how I missed that, as I *thought* I had -Werror
enabled. Maybe things got lost a bit in the shuffles from GCC to Clang
for building our kernels internally.

Anyway, "used" is a bit generous here, since these are just useless
function arguments (never *actually* used now). I should remove these
args entirely.

> 2 patches set to Changes Requested.

Will send a v2.

Thanks,
Brian
