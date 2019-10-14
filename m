Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93375C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A62C206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYmFX1rQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfJNUAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:00:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36801 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbfJNUAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:00:23 -0400
Received: by mail-vs1-f65.google.com with SMTP id v19so11611891vsv.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gT8AJ5zC76BzDPhvGvt6qWojAo/i060zkW5n4AaFo7g=;
        b=mYmFX1rQtaKhS7Kq025fsQiOsgkFtLq4VG8gfhlbCgAls2DW364XsHAOFY3vGU0S7o
         JcVQz/xcZADTs5M6RIUG3nQKygfiOfrXzRXV0TN7aLzr/6KziTMKlJSow0KVRYk124Uv
         HwBK9wcrfXlfjhxGeHkhhsiRc+5fRMoUr3pSKgsQROQ8TEvlUppejy6t/9ywhE9yYVR3
         oQUbod0rSKWL/t89bwABqG8DIeeaItpKg8lkqtqF8d9N1KfzGj6MKCwj3kzfucO3il72
         Cu/KCUXh3zIOIY1Se/Iava3FzPegmwDqW+1G1OTtNC++z8+sh+O/swPTPcdWZXokCvhR
         BVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gT8AJ5zC76BzDPhvGvt6qWojAo/i060zkW5n4AaFo7g=;
        b=Y1EE+dVpsmKr5nmMwLtlTwl4zC2xLUuonztemfmB8imBAFv20i1eRvWij29Hc9AisL
         kqLgviuLQR9RLjhLPAhXR0lO5/+MmLhJ8evExk5u8X00WG0ex0zU3aur6eORfrzM8lqR
         CjP7uXDFCop9z6EyYD6DW74+9dKTNxjsQr5/fLGJIygeJcjoeDF1+E13gM5ngSKOsr6+
         bDYhIluGAiwQlh82xxDJRzLIIkI94Gwl8T18oeaZNJO9dQKGbOarA6AoaoWVlqf003aH
         9QoTg5bPbavZa5VkyVTBZirCTqExWsGwkVYWDeJ6PgXZeMXqHmGnYRa8idcb7qEnvx7a
         q4TA==
X-Gm-Message-State: APjAAAXYdZdNMq9ZKfP1dRyT7PEIK36v/IQjDWEwmTH/UthfeiEXLAAq
        79+sq1xw56aDuFW/AJa5OMiheFLi/Rzv0+aurQsRtw==
X-Google-Smtp-Source: APXvYqzLqn0tUdUJEKvRoSY8oRoCW+w1jzJ9gC+G9AjoPpQUvzXAB9vs2r2VpKu4p0dA9aOVq1mXRjJ1wv6cAaEqCFM=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr16123159vsp.104.1571083220972;
 Mon, 14 Oct 2019 13:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191007214740.188547-1-samitolvanen@google.com>
 <201910101411.98362BA0@keescook> <20191011142650.36404713@gandalf.local.home>
In-Reply-To: <20191011142650.36404713@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 14 Oct 2019 13:00:09 -0700
Message-ID: <CABCJKueYhWL_YnkqRW9TtM4sTB50TNjTZ23_4xfpZNy0GwY5VA@mail.gmail.com>
Subject: Re: [PATCH] ftrace: fix function type mismatches
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:26 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> Unfortunately, this breaks function graph tracing.

Thank you for pointing this out. I should have realized this solution
wouldn't work.

> Is there a way to do an alias or something that can fix whatever you
> are trying to fix?

Unfortunately, an alias doesn't work in this case either, because the
compiler still looks at the type of the target function. I'll find
another way to solve the issue.

Sami
