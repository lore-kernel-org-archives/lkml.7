Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91008C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DA7206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfFUOaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:30:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43725 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFUOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:30:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so7064316qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TbbcZvsIKaxtIS7FqGvDDvNk0JCEAo015DOsbTJhC4=;
        b=FRCYKvhRfaK30uGMqKLkZ3twQEd8shDb/N12QPu8aBoMvVDb4IFo3qPeMfVnIWyI9E
         gTqLHiXA8V33ximEXDHnztgUh8bq/AuabSEP4Y7MyAZugLYQkjiZCz1uiTlQVnqL6xMG
         f1h3l4Awuz7GnoDkVWQ+2j+XtGLqnrQ3/tef5AFD/WgvwtnbQjM/Jew7ymg0PQenycEb
         JmWP+0jA+tGxFIWdd4lxC01fCQvVuHI6WQKi6Jtf6xeyrAFSHzWSQE+W5Pxn8uCnHyav
         S0tWbQELCcraVk9E7eQQE3oYryF/GVZG/yZs6oq5GEuu2FiIMf5KfhmSGAu5F7F1mxVQ
         455Q==
X-Gm-Message-State: APjAAAV8MFMRs2txHrVkITAQVCsBPDA3QKvCLW6BMXpCypb0RXTCjfBM
        WDT3do6v251VqgLdqvJZmMXwCNNk9YCOPpRZJFg=
X-Google-Smtp-Source: APXvYqzrCK+h6qkXj9rHJP9MuO5+nYUSnuRVG6XZM+5Digug57BvxLC4M94kkCnC75G2UbudyM/CmS2u010PjTTKBGc=
X-Received: by 2002:a0c:91dd:: with SMTP id r29mr1041117qvr.93.1561127406817;
 Fri, 21 Jun 2019 07:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
 <20190620141159.15965-1-Jason@zx2c4.com> <20190620141159.15965-2-Jason@zx2c4.com>
In-Reply-To: <20190620141159.15965-2-Jason@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 16:29:50 +0200
Message-ID: <CAK8P3a1_arn_4gUdwYJeuxTcYQgiakFpdci7LauRd0j+3eb3qg@mail.gmail.com>
Subject: Re: [PATCH 2/3] timekeeping: use proper ktime_add when adding nsecs
 in coarse offset
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 4:12 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> While this doesn't actually amount to a real difference, since the macro
> evaluates to the same thing, every place else operates on ktime_t using
> these functions, so let's not break the pattern.
>
> Fixes: e3ff9c3678b4 ("timekeeping: Repair ktime_get_coarse*() granularity")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
