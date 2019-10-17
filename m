Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CB4ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3A121835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="im138kZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441514AbfJQVSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:18:34 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38349 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441370AbfJQVSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:18:34 -0400
Received: by mail-ua1-f68.google.com with SMTP id 107so1129468uau.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etI31KzHT2q8i7/qza32Bl1FPZmxfAFlonbXD/SphcM=;
        b=im138kZxjCWcm5LRBg1nd/p+5cuI6FdrJigK0zjXfy9KDEgaaZhi67eiLdrjJbXypS
         7gvkSnajbf6ndXt9OHRb5yZ0G9OVL4y9pfIKTv3AzHbz+oTW0LMVG6lFnF2kVTwe6e0Q
         boFAggfKATpIGhWORAVusyoy2qqeiH2kVa+xUPK+FRhPD782y3WzNr/iJ0WqtNR0+JsO
         Co5uPFw1FBYbd5v58QiE0+6UVYuuVDUt5Nww3J138aASTVssPmeZgFf14loAPJ1F9Jna
         TQ0FnGGTpXMZXu9Dku/KlCRqBGvWuRLI0fE+UW2gG4JpGuXF5axupJufMQABDJ/HJlNX
         MSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etI31KzHT2q8i7/qza32Bl1FPZmxfAFlonbXD/SphcM=;
        b=J0DKWxvOu7SFi6RC2EVJF1N7Z/EWaPhREW17qYrYX82/0EuCAA7LEl1paok0SPOEK1
         0AhmL2JphmyPhzNeMyBwZWwZx7mHjekra3r/75Jbk1thHo5ngnV/CWHWpFt86YG1TDyg
         ZS2aLjboIcZVeMCa329kn5RZGUi3VgjGvtpdtM5Iaq4P1kUO8/GmpO9oRRagZmdLHimE
         5H0MbyfU2lvUrKgjt0nh0vHhEnMUQcpubpdGV6xBHAzt9Xn89g7uR3p+f5EbXbar6lgW
         MMdmOVb7xnth2WTOVTlx9wuKj6keidZMupKYp+QxdBXg1Z02FIshXS6hJhYp+S3GEDe1
         k6bA==
X-Gm-Message-State: APjAAAWowYe6GF28SQYdzUz6dI3woVDdFIXW+dxo6cwsJP9bMwSoj0+G
        uJdffOGfWIcCCPZlHzAxPMi0Bv6Gxw6Vwzn0VorWV8l9TOXhxA==
X-Google-Smtp-Source: APXvYqwVsPn60vVTYdGHORvzzOev1FUgxoOqrSATGeUeOkCW8C2qdWF5+y73TMv5AKwbhIpxdkF9hWro28pkmXf1U/g=
X-Received: by 2002:ab0:6387:: with SMTP id y7mr3562286uao.110.1571347112431;
 Thu, 17 Oct 2019 14:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191007214740.188547-1-samitolvanen@google.com>
 <201910101411.98362BA0@keescook> <20191011142650.36404713@gandalf.local.home>
 <CABCJKueYhWL_YnkqRW9TtM4sTB50TNjTZ23_4xfpZNy0GwY5VA@mail.gmail.com> <20191015090055.789a0aed@gandalf.local.home>
In-Reply-To: <20191015090055.789a0aed@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 17 Oct 2019 14:18:20 -0700
Message-ID: <CABCJKue6x0KfCR1xYUrJZnnzf_yp1CidmULwvGS5a-=yRbPzCQ@mail.gmail.com>
Subject: Re: [PATCH] ftrace: fix function type mismatches
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 6:01 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> Would this work for you?

>  #define MCOUNT_REC()   . = ALIGN(8);                           \
>                         __start_mcount_loc = .;                 \
>                         KEEP(*(__patchable_function_entries))   \
> -                       __stop_mcount_loc = .;
> +                       __stop_mcount_loc = .;                  \
> +                       ftrace_graph_stub = ftrace_stub;

> +extern void ftrace_graph_stub(struct ftrace_graph_ret *);

Yes, it looks like the compiler is actually happy with this approach.
Thank you for the patch!

Sami
