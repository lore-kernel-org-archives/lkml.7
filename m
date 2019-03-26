Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83954C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6492084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553592052;
	bh=3VoxYXXfC/ephkZikhA8FpQ/TiJ/bDk1N5SoAFJZuH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jdjLSTjOc0kLc6cKKLqEGwW2vhlIiCJqs5pLlv1FeAmjmV780r+wLj3GBjRRmKv7F
	 dBkH6zEdx4QXXcQjPgmbcyqQ22ITrkeqPHBAuIY0zxA1KVJHOK04jZE2coWGwer8yn
	 cLW0g02oNRishcNo+nZLQEE20aw3u0HjO80Cao6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfCZJUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:20:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35231 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfCZJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:20:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id j132so9359591oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 02:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zemCmibtaoX3q0w9wSy5V2h50Omizvur52zLBvlN87Y=;
        b=n3znuIu6ROxIl6ZyB894kFCbSlp9ItbEX+9kgLy7AdNokdi1CyqqGZtxTYbX62du6b
         MYgIzMQ9+o4leB5QVepodxq1Z9mHP9GsKT+Ymn1yaMDvaSASj/sMDlhryMYKEXg9MJux
         BOnnPcI9jwZa4wb6B23lODXTrCWV64+5S42R5pBxzbnPoCZwMQjT5IdzTsnnztnwz/nV
         8/CopMswtFPx7bWVuOjzRU6VMif/wuQS2E73yuTi4usD+NS4EhzlHJgjER9nCylumA4c
         8X21XwsGCj97Omq//W9eTCaRPJx/TbEwigYp/MD05wghF5avwJE70tGpFJLo2kaYx+UG
         AzEw==
X-Gm-Message-State: APjAAAVoiLnAAJ3bzZ92I/l/tvyvc1Kmga2jaYW9lqaIe3osRCqh6pkr
        1vE6vDBWvaXepVSy4otHonuLpxtpBr6eOV8/4g8=
X-Google-Smtp-Source: APXvYqwWiVNkUg0kQnllObtpc5oZuAO/qHdzOMWzDEo7vVIYb/NTFDa/3nyuSCLamnpkTKiDNR14xV1HQ6RPuDHgViY=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr15015032oib.95.1553592049441;
 Tue, 26 Mar 2019 02:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190326090227.3059-1-bhe@redhat.com> <20190326090227.3059-5-bhe@redhat.com>
In-Reply-To: <20190326090227.3059-5-bhe@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Mar 2019 10:20:38 +0100
Message-ID: <CAJZ5v0gcweDzkmYPFB3zVE8Np4ptMy1nuB0=HLuWHbHKZuuhrw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drivers/base/memory.c: Rename the misleading parameter
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, rppt@linux.ibm.com,
        osalvador@suse.de, Matthew Wilcox <willy@infradead.org>,
        william.kucharski@oracle.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:02 AM Baoquan He <bhe@redhat.com> wrote:
>
> The input parameter 'phys_index' of memory_block_action() is actually
> the section number, but not the phys_index of memory_block. Fix it.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/memory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index cb8347500ce2..184f4f8d1b62 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -231,13 +231,13 @@ static bool pages_correctly_probed(unsigned long start_pfn)
>   * OK to have direct references to sparsemem variables in here.
>   */
>  static int
> -memory_block_action(unsigned long phys_index, unsigned long action, int online_type)
> +memory_block_action(unsigned long sec, unsigned long action, int online_type)
>  {
>         unsigned long start_pfn;
>         unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
>         int ret;
>
> -       start_pfn = section_nr_to_pfn(phys_index);
> +       start_pfn = section_nr_to_pfn(sec);
>
>         switch (action) {
>         case MEM_ONLINE:
> @@ -251,7 +251,7 @@ memory_block_action(unsigned long phys_index, unsigned long action, int online_t
>                 break;
>         default:
>                 WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
> -                    "%ld\n", __func__, phys_index, action, action);
> +                    "%ld\n", __func__, sec, action, action);
>                 ret = -EINVAL;
>         }
>
> --
> 2.17.2
>
