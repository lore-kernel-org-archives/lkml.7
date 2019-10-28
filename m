Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8B3CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A130320717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572265356;
	bh=1J+c8PHZoVN1vVlu80q6O6Tuj/kxN7JYe0y9l0SJ5DA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QDXeE969ervDU9G97EO7wH12RwbUShpPaLu0L7SPuyZenHHkdRpfzoQBRzVw6NuT5
	 a4yxUcKAew1Pjy19sKV05YBd+ctw7SOpYC3eSncF82EPRUv+C0sQSNwhBUsuEx2/aV
	 O9z7qIWlG4IjwfMM7hInVmCYe1meUmEaZpbkPtqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389042AbfJ1MWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:22:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42834 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfJ1MWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:22:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so11081369ljh.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enG5Lre713MdkCrSDwNrqoAuYHhMZ4WTXeUn1eOeHYo=;
        b=YOSB0iKFmpvkF4JkW7MsyVt0UzoUy5JyQueItwDpTnO+YgFV3/egElfs6LFpDxwgZ3
         8Xx0LSPXH4IrXXv2ju0022mF8Ix/O+lxAhNakrsVhZ6XQ3olaxwU7KHQ/6N0gbYnMrvo
         l7QfMdy2vlzu/Tchtryb4HVfqE+KK6i4OVXZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enG5Lre713MdkCrSDwNrqoAuYHhMZ4WTXeUn1eOeHYo=;
        b=gvZN5csBl8feouFDkTJHsmPQFRlzUDpOPjxkVBUA3o9OFmzDTbto3iup0BVD9xuP9/
         3DAquqnpPHqqlFmyNzalFw+wfYEBEIE2AMWYwK7X+8IKYf6UYka8sYeyAQdsY2bMqUGL
         ztXkFbqkL79yNeos/z0k7/+6P6UAjFCoqoaPVpvp980lHY1O4d2XFoxYkSCTMWqct0cx
         0Oqs+RL1GLbdfJvkGR6EGF3fbSJ4z7SLl8IbXjfuBn0Do7z4EtqKWbPDQYP415vVwEBA
         YKz4bGh+tkA8zc64oVdBZ/bE+wfY2OW+FOij1fPUyp3gLwk0wcBYmOFvfo4yFIxWqtKY
         M1IQ==
X-Gm-Message-State: APjAAAVtY/4ey030Sk9mPpTRVF47W66jBAXrKiY9BXX5GIbmjZgm0NsR
        sL2+BlIc4Pr9lRu+jIYCb82tkzegfUnrOg==
X-Google-Smtp-Source: APXvYqym/9Vaq93L3R8V+gLtdERRrOFtaaw3j2Vx7ARih65BjW66biLOp8jNunU/WFnEC06OD11ufQ==
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr3255963ljb.22.1572265352325;
        Mon, 28 Oct 2019 05:22:32 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id e26sm4991075ljj.76.2019.10.28.05.22.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:22:31 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id w8so6584464lji.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:22:31 -0700 (PDT)
X-Received: by 2002:a2e:819a:: with SMTP id e26mr7030458ljg.26.1572265350927;
 Mon, 28 Oct 2019 05:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <157219118016.7078.16223055699799396042.stgit@buzz>
 <CAHk-=wjoTncMYdQFmY4yspKOUsDSNn1dHp1FWvJ0eRO94ZM3dQ@mail.gmail.com> <5b970999-c714-6bfb-0b02-ed206bafced4@yandex-team.ru>
In-Reply-To: <5b970999-c714-6bfb-0b02-ed206bafced4@yandex-team.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Oct 2019 13:22:14 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjtLz=S00b0T+_Zrx0bfQ1QDLpWAq7eo=w0FPi5N_UqOA@mail.gmail.com>
Message-ID: <CAHk-=wjtLz=S00b0T+_Zrx0bfQ1QDLpWAq7eo=w0FPi5N_UqOA@mail.gmail.com>
Subject: Re: [PATCH] pipe: wakeup writer only if pipe buffer is at least half empty
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     David Howells <dhowells@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 10:09 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> Ok. This breakage scenario is doubtful but such weird software really might exist.
>
> What about making this thing tunable via fcntl like size of pipe buffer?

Let's see if we can do it without a tunable and maybe nobody notices?

But I'd like you to do it on top of David's pipe patches, so that we
don't have unnecessary churn and conflicts next merge window in this
area. Ok?

              Linus
