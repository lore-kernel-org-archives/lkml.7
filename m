Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B669C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFDE206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IB37whGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfDJDi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:38:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44912 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfDJDi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 23:38:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id w5so1230215qtb.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 20:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCy3P7ML9ZsqI83lS9uCMZFubXl5eBqHzrd0tI9mq6s=;
        b=IB37whGcX8y/wQ9VF6yKfaMGidEsnCIprAPgj8WlAm6SJ0SsH3IRy+HKq2UWzRD9mT
         1f6xENiTyaqLwYtesCsvh47oi8KGKWpGEXNp1FfCkMwqfX2dcnWGKwpMpMJhcDaDHQ57
         vUyUoBuyPYoIvfCI9D55OowZdeSM7wPvDkmnBhOygxeZVzzbcxC57ycEvkpqQ6cib6BP
         wxcdGDSgN6c7/nlurn0aYl10kVtw3x1aEk3lEPXchrxYf/ZYGpySmo9PKyIa8EwvGrI4
         H3SV6z2GhjFViwamjHml0Xcbpf9I4K7hAvkikQcjcdnw+px0cUAmeAZjzxvpU2S644PT
         6QKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCy3P7ML9ZsqI83lS9uCMZFubXl5eBqHzrd0tI9mq6s=;
        b=LhWXhuyWmDbPJsohubGKGbIPJvoGxmi4a6MLK7Zgc/zMAfpEESp+Q1e1LtLw4aLyNc
         NTblonvxlokCmmk2/j0zOqCpOVzYLVjNzq1m4urTVi7r0O6aqMccZHo7w9IIp9yICExf
         u/m3oZVenTb9FSqktQJX8Wi6fPme9H8meGu3FWSpzYpI0Krmf3IdJjwyQRvZE4yPwwHW
         UKO0vDM9GPnNrshg6BkhREhvu/uZkfwhGtaAOaNokjQCA5iFEixaPWLqENEXpi0iGx/3
         O6yJuFxq6RhcFvK1ALc7o2wqCOuno0IRdEqrqIoJ26CCLQMbjD+Lj1o6eEfdXjjJ/qxm
         ruoA==
X-Gm-Message-State: APjAAAW8HlB0FPYof1fub0B33GTnCuFXDKqw4rrRRS/ZF9Hafx1dSDch
        /ebTLIux49I85qU9FRb2TBvvud//qNgI19q3B2hEvg==
X-Google-Smtp-Source: APXvYqwR8iZbBOuCHSu9wG7k7XVw8YitDiyBqiUOUtgTgDXjlYvkJzdJDlsZ6HwygGu15my2YQnWe6jieR8fWO3Alzc=
X-Received: by 2002:aed:23b4:: with SMTP id j49mr33311794qtc.175.1554867506068;
 Tue, 09 Apr 2019 20:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190410011418.76408-1-joel@joelfernandes.org>
 <20190410011418.76408-2-joel@joelfernandes.org> <20190409223820.511e3671@oasis.local.home>
 <20190410024103.GA104423@google.com> <20190409224826.308b12a4@oasis.local.home>
In-Reply-To: <20190409224826.308b12a4@oasis.local.home>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 9 Apr 2019 23:38:14 -0400
Message-ID: <CAJWu+orXgFkJpB8ww9kz_Nzmmj4qXjj2HtN_eDW3x+XPLbH0qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: Make srcu_struct ptr array as read-only post init
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 10:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 9 Apr 2019 22:41:03 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > > Other than that, the two patches look fine to me.
> >
> > Could I add your Reviewed-by in the respin?
>
> You can add an Acked-by, as I haven't spent enough time to offer a
> Reviewed-by tag. ;-)
>
> Maybe I'll get some time to vet it a bit more tomorrow, and then
> upgrade the ack to a review.
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>

Thanks!

Also we could possibly consider adding the tracepoint ptrs array as
well to the list, which would be useful I think, if one were to over
write that array by accident (and the bpf tps related array too).

 - Joel
