Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043FBC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13242084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KALgglw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDIQyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:54:38 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46538 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfDIQyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:54:37 -0400
Received: by mail-ua1-f65.google.com with SMTP id v7so5723784uak.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jIhnjF74CISNf3nExSKH5Oqn5TCnpH9cHpwC1QyZbs=;
        b=KALgglw6sXGgZdjwzyzwLhGzuiKwgV1WjeGLG/C7Leh+PG0wjQ4wvMsbFh8zPYjZOj
         1OQnz7PtMhReDJVYbNxorXkEKDX90qEDQshXaYzt8CaAhkOUPu+Ws1SJE3JyqWqs5egN
         hmFGrLrKbsYj+VUSFjh0a4+u7wbksX58vN5xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jIhnjF74CISNf3nExSKH5Oqn5TCnpH9cHpwC1QyZbs=;
        b=aFKQp90snQaWx0EXj7UG8Ife89qk4cORz3SOtkyoXHWj8WX3kShhgF3VIVZOZR/ugh
         siQbzCahZalCA0unwNQCJ9rvpZiCjUIKHHa6YURMTc8d4sdAMoebMdGxYYo05Y+ZgOD+
         HS1bL7k9PDVcPADfqQvD8fokWqHIZJvrLjZgrxIujBlvhz5DrVcCpvkA8ypBvlzA5IOf
         rM8noywyW6jZPY01vtduNXskYXDQjgI37hRNagfF1+VzP198xUZjnmqEbRGizGvYjHX+
         5e3mbH4YV1k9naN2vLgaJKTvJGoyY6yIb2yd58wvGkE/jiByDa/w5dkDXwqfnGQtLx8D
         LS3A==
X-Gm-Message-State: APjAAAVZRrfKXqSGBBOHGPoY4V5v+jym7+XawdkLkPQQRas3KUrZ7o1g
        nrdw/61XE7psI0BS/1Ob4ojIFHQmOSA=
X-Google-Smtp-Source: APXvYqzidKU2duMDnBu4gax57hHg2qEQunj9j7n7371iLoeDvwmLORO/VkKfqpGZ1j5zmioBBuVN/g==
X-Received: by 2002:ab0:7493:: with SMTP id n19mr19637884uap.121.1554828875778;
        Tue, 09 Apr 2019 09:54:35 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id y12sm1193632vsq.16.2019.04.09.09.54.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:54:32 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id g8so5750474uaj.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:54:32 -0700 (PDT)
X-Received: by 2002:ab0:60cd:: with SMTP id g13mr19230566uam.85.1554828871567;
 Tue, 09 Apr 2019 09:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554485409.git.rdna@fb.com> <fa56a873cb76394f49996fb0d191f8c434ac8885.1554485409.git.rdna@fb.com>
In-Reply-To: <fa56a873cb76394f49996fb0d191f8c434ac8885.1554485409.git.rdna@fb.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 9 Apr 2019 09:54:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+hW4NPihH+LmvCRxpNdHJDh=KD=k2FtFx51Ay8=vSdgA@mail.gmail.com>
Message-ID: <CAGXu5j+hW4NPihH+LmvCRxpNdHJDh=KD=k2FtFx51Ay8=vSdgA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 02/21] bpf: Sysctl hook
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>, kernel-team <kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 12:36 PM Andrey Ignatov <rdna@fb.com> wrote:
> Containerized applications may run as root and it may create problems
> for whole host. Specifically such applications may change a sysctl and
> affect applications in other containers.
>
> Furthermore in existing infrastructure it may not be possible to just
> completely disable writing to sysctl, instead such a process should be
> gradual with ability to log what sysctl are being changed by a
> container, investigate, limit the set of writable sysctl to currently
> used ones (so that new ones can not be changed) and eventually reduce
> this set to zero.

Actual-root-in-a-container is pretty powerful. What about module
loading, or /dev files? Instead of sysctl-specific hooks, what about
VFS hooks, which would be able to cover all file-based APIs. This is
what, for example, Landlock was working on doing (also with eBPF).

-- 
Kees Cook
