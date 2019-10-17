Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E42ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD0C21925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0A+U3EH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440739AbfJQRh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:37:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37298 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440729AbfJQRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:37:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id n17so4802763qtr.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aceUwkkVxfnoNY/+s3ZJ1xTD/awywXhqdnMzBifH9/U=;
        b=p0A+U3EHAH0PU+dbixFcwYDYh2bSzZaPUAXBq3X+y0qht3kFoixLuC9f1W2Q5vfqmz
         0TbRhBd8EcJi3S6Om8gTPg4NDdtLU7VhQhTkcNi8S0UuRDqBfEELA7v6JdK94T1InBsT
         cbJ2QQz+REGB+J9rN4abVfWkcciK4XzgqunbZ1hPsWxYKxfEcylopZ8d1PRtVGCZ7dQY
         MX68+gw0dGchlP9YS3rz6S/4d68ezz+VDGSLVvHJarYTLMdYySR2SMpav7Up3jZSgFlv
         HI6NNq5P4IUwl2WUJ2nClYoBoVG0AP6gjq7i+Cem6fAPVcgYYgVmQ48RDQdY4MrlXWQ+
         3MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aceUwkkVxfnoNY/+s3ZJ1xTD/awywXhqdnMzBifH9/U=;
        b=G23JBrrQXcrYZqrMH0/DJBHaXbe2JMQYX+8kivkE6ifEEJztKGqy0F8lIlqwZdVwRl
         MXmxXueATaxmYyDoA9ulxlEcfRPLMeySsUamKI+ZqGGuuVGafCj+YKdYsGaysGcxkByK
         N+4l+OdIF9m/rK/yIdM+vX0smxEwsmRZInoisDlomqFBqMk99slIzxYcir1qfsmny+/L
         WN5802D5Qc1nkba4/GjhVunZI6AJKEvwNTbay6vRz8wUBh9b/4V/N0OII8wFpuoygd4J
         G27HjbY6Y/fo1SwXCAfzMqasnk9FJ0BO6S4IefW7qg+CajNfzxAHZWaqbTEv2APaaa/X
         SPIQ==
X-Gm-Message-State: APjAAAX0HL1jtTBCh/XBwLXVi6p2KQaB9FBBgiYMRqUmfcPQztcdvL4T
        EmbsH81qSN7PjkW7DadOuZyM+HRU6ph9fr/3yuk=
X-Google-Smtp-Source: APXvYqwVt6TX7IQ6z4AE1gMJB06hGN47z5+R6yZGws5+GRJVkDdVPu4cYIXw2dZQdnKadDd4lhD84iqGJSh5pkh/0tA=
X-Received: by 2002:a0c:f788:: with SMTP id s8mr5119067qvn.92.1571333870915;
 Thu, 17 Oct 2019 10:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191017164223.2762148-1-songliubraving@fb.com> <20191017164223.2762148-2-songliubraving@fb.com>
In-Reply-To: <20191017164223.2762148-2-songliubraving@fb.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 17 Oct 2019 10:37:40 -0700
Message-ID: <CAHbLzkqL4iUVF5d01uBU8HhT7U3jq4urdNZNCE3pK2QfySSYHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] proc/meminfo: fix output alignment
To:     Song Liu <songliubraving@fb.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        matthew.wilcox@oracle.com, kernel-team@fb.com,
        william.kucharski@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 9:42 AM Song Liu <songliubraving@fb.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> Add extra space for FileHugePages and FilePmdMapped, so the output is
> aligned with other rows.
>
> Fixes: 60fbf0ab5da1 ("mm,thp: stats for file backed THP")
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Tested-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

> ---
>  fs/proc/meminfo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index ac9247371871..8c1f1bb1a5ce 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -132,9 +132,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>                     global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
>         show_val_kb(m, "ShmemPmdMapped: ",
>                     global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
> -       show_val_kb(m, "FileHugePages: ",
> +       show_val_kb(m, "FileHugePages:  ",
>                     global_node_page_state(NR_FILE_THPS) * HPAGE_PMD_NR);
> -       show_val_kb(m, "FilePmdMapped: ",
> +       show_val_kb(m, "FilePmdMapped:  ",
>                     global_node_page_state(NR_FILE_PMDMAPPED) * HPAGE_PMD_NR);
>  #endif
>
> --
> 2.17.1
>
>
