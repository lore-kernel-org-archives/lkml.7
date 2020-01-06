Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4688AC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1927A2072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gR+oYRZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgAFWvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:51:17 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33929 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgAFWvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:51:17 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so19770029qvf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pd6XIV7OgADHPUC0a4p/Mb4IhnpWoH1UAexZuXJ1p3s=;
        b=gR+oYRZ4onpW0u9eAxj2ULlDOyWb/ugEKFPgUuK2O9X4B/ADTb1dAA1I8WaavTN82y
         TKTIz5wUd/O9vHnYgWUUQewQh5/ZQhyv/kzfmjfxmbqrKoLZ8iwhZ4k1SccdXyF2UtbP
         lyWZ0Yw6bvfq+QSjMpFD5XKceAOGyIPdBuN0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pd6XIV7OgADHPUC0a4p/Mb4IhnpWoH1UAexZuXJ1p3s=;
        b=ryJ4OLlhmcpI4hw3ndUo3wUQ2yNqUzy3BYwj/aH7pN4vBgflyxKFgjVtU/hhrSQu2w
         m1iMGk9XkhVeEKV/iidmriS+7aNYZQNbNbvHsjJog0j9vsAtp0SY5YkKJl7uWf0TRdMR
         +hl9pwcJm3EspN7N0GX1Sr+xakT5pBbymIDfiwLyK57OLHf0y2BcyqIegspmJhtc7jRV
         iFHkhgsvbDjrYD9LyReo4ZiFlxhwDYUowK79MCgOvzcctf7RD4SdJculYss+Jwc76iMO
         ID5nikvBSqNN460GRtHeqdv6NU2DccVxA5grhCSptXMMTqIPdQEN2WFOPEGRG0+DS1MW
         hlpQ==
X-Gm-Message-State: APjAAAUblFUSTrvwEFDNZsl46VMp9ef53r/qAS6Mz5tFSE+Kkp7qgv/0
        ztSC5ZnvxacOOogIZlCEzxOYaBXVtMI=
X-Google-Smtp-Source: APXvYqy4dp1jl4z8hsYnRGymN0DG/QHr2tw9SOAIH8SWzo09ssF0q0JxNo8+8XfZV9ATRdQaMWElKA==
X-Received: by 2002:a0c:ea45:: with SMTP id u5mr79287669qvp.171.1578351075330;
        Mon, 06 Jan 2020 14:51:15 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id c18sm2229828qtn.71.2020.01.06.14.51.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 14:51:14 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id w127so40994695qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:51:14 -0800 (PST)
X-Received: by 2002:a05:620a:2043:: with SMTP id d3mr85418653qka.279.1578351073659;
 Mon, 06 Jan 2020 14:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20200106224212.189763-1-briannorris@chromium.org>
In-Reply-To: <20200106224212.189763-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 6 Jan 2020 14:51:02 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNN5=97nhN99rPneLGSQAmQ4ULS6Kim1oxCzKWNtPkWFw@mail.gmail.com>
Message-ID: <CA+ASDXNN5=97nhN99rPneLGSQAmQ4ULS6Kim1oxCzKWNtPkWFw@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: fix unbalanced locking in mwifiex_process_country_ie()
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        stable <stable@vger.kernel.org>, huangwen <huangwenabc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 2:43 PM Brian Norris <briannorris@chromium.org> wrote:
>
> We called rcu_read_lock(), so we need to call rcu_read_unlock() before
> we return.
>
> Fixes: 3d94a4a8373b ("mwifiex: fix possible heap overflow in mwifiex_process_country_ie()")
> Cc: stable@vger.kernel.org
> Cc: huangwen <huangwenabc@gmail.com>
> Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

I probably should have mentioned somewhere here: the bug is currently
in 5.5-rc and is being ported to -stable already (I'll try to head
that off). So this probably should have said [PATCH 5.5]. Sorry about
that.

Brian
