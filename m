Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFA8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7905D2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P3jT7Dwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfC0OhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:37:18 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:32918 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfC0OhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:37:17 -0400
Received: by mail-vk1-f193.google.com with SMTP id r189so3697370vkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37CBxpM6hJRVRXBi1QvHUgQ7PqT5WnVvQfm+mD9AjJM=;
        b=P3jT7Dwz7sWNPHKzVf1fng5BPY4yRF3BBP7ERTDinG+cZ/pW8x5VYU7cL35mQuBcDy
         wq1qc/9+fjALBcpkrK0qzQAMeIVhgUeoJm3svZlqw810LMKQXzpuyjZGZZMRQHzcW+8N
         w4AVJIpt/uWLZSpdEAKBzyyqoRwI3AIJ6EfXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37CBxpM6hJRVRXBi1QvHUgQ7PqT5WnVvQfm+mD9AjJM=;
        b=NAvz5PgeTtodJOhpZy4HANHJs8wZq+qrTdfL4qRf8it8ZX9CJOvvvSTPAfnqMu7UgE
         dZ+gdCECl8eXb/kNGaTiehhJN6bLh5YKBTZ9DwBmYwIkYxwW9hFbhJgUGOQV4dUBDQvS
         PWwPPNqpjrUbDtYYzY9F9fhnjV2agbB3nQqrgWSbD+D6TyKlYadkGgNlwKxfz1wUz9yQ
         G23oGprAm0Lke3DPW0aGTYRPfi5OZkThCz+8r7WBrif2ntz2O5MibHAPgs1fqsbEtTw+
         Gs3O8cquv/OVh82d8NQ4tvq6XgDS4ES1fyY8P8iQ4zl6qJpnel1Xchy8bYDkURKCiLHi
         wJrQ==
X-Gm-Message-State: APjAAAUpBevbTZ0TQtzCJFvMP6I9S2L42Oq1p9UyKdM1xYvjHr8HsCjS
        V/9dwWt1YUJHAiZazZK7SdGL+PjY3fs=
X-Google-Smtp-Source: APXvYqywe51ePQQ2uyqXAWxmzGZ5pslYIOm+5eSpVhpLY8ZlUQtwxCyTAL822TkZW6V7DVcoS87oVA==
X-Received: by 2002:a1f:bc8d:: with SMTP id m135mr20950806vkf.68.1553697436697;
        Wed, 27 Mar 2019 07:37:16 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id q66sm14346388vsd.32.2019.03.27.07.37.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 07:37:16 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id g8so5667520uaj.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:37:14 -0700 (PDT)
X-Received: by 2002:ab0:20c1:: with SMTP id z1mr8206209ual.109.1553697434059;
 Wed, 27 Mar 2019 07:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190327131711.7484-1-qiaochong@loongson.cn>
In-Reply-To: <20190327131711.7484-1-qiaochong@loongson.cn>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Mar 2019 07:37:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UTBrAgkgtTLQh0hA=9GAmfH194uBdD3683WPkq=LCKnA@mail.gmail.com>
Message-ID: <CAD=FV=UTBrAgkgtTLQh0hA=9GAmfH194uBdD3683WPkq=LCKnA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
To:     qiaochong <qiaochong@loongson.cn>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 27, 2019 at 6:17 AM qiaochong <qiaochong@loongson.cn> wrote:
>
> KGDB_call_nmi_hook is called by other cpu through smp call.
> MIPS smp call is processed in ipi irq handler and regs is saved in
>  handle_int.
> So kgdb_call_nmi_hook get regs by get_irq_regs and regs will be passed
>  to kgdb_cpu_enter.
>
> Signed-off-by: qiaochong <qiaochong@loongson.cn>
> ---
>  arch/mips/kernel/kgdb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index 6e574c02e4c3b..6c438a0fd2075 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -214,7 +214,7 @@ void kgdb_call_nmi_hook(void *ignored)
>         old_fs = get_fs();
>         set_fs(KERNEL_DS);
>
> -       kgdb_nmicallback(raw_smp_processor_id(), NULL);
> +       kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>
>         set_fs(old_fs);
>  }

I'm excited to see others using kgdb!  :-)

As far as I can tell your patch is good, or at least as seems like it
will make MIPS on par with other platforms.  I always wondered why
MIPS (and ARC) didn't have the get_irq_regs() call but when I last
touched this code I left it alone since I didn't have the history for
it and had no way to test.  Since it seems like you have a way to test
this then we should do it.  Now to find someone who would do the same
for ARC.  :-P  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE as pointed out in code reviews when I last touched this code,
using get_irq_regs() isn't perfect since it could plausibly return
NULL.  I created a bug in the Chromium tracker with all the details
for this at <https://crbug.com/908723>.

-Doug
