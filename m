Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFF9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4157320857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554796315;
	bh=kqKl/3RVuSDSjnJGLkF2QN6+m79NRO5u35n/OV7I/64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iHZ4M0kslbe3o7gla5lstFSozXa+4a9kYR7C3QUy1jchdQktwvX1sJw0T5aQaO8I0
	 gfRJk0a2r2xEgrwr2KBaf8G77eiI2K/P8ntpz3YTsrBhvOGnpfEm1gfWwmKqNjP2s9
	 KGzIPvpFQ3+XhKOqGfpYSQxcOlN5axxDquoQf7CI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDIHvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:51:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36875 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIHvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:51:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id v84so12772187oif.4;
        Tue, 09 Apr 2019 00:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evxZYFfKsXbCQjzTR4SOB+0xSipzPCh8tZrToggUcck=;
        b=OovX6Z1b5rz3Wmki/k2DHEraBLSFfYZPtyoG6fLzRN2hGiQ6mEBWA6l55ZoIxQMOHI
         i0ztMN64/K5UOjaGeJe0Gavv05lh/rgCLyLoXz9poZyXjvhYajlqBgxub7jvKa1ep0Rm
         fqkUP3xcb5dsrs9gcKDhlkDBNqSKqWYOeV2lWQt74QPPmtcvo4PlfIIBt7TIum5OirdL
         r6iVZDSbSO8AJrP98QiJzJzZSlyBUmiOYurhITn7WF+vdY4eT+brH6WAp8SvgbNUY+F0
         ZUNN6mGvlxBHB7Z8I4mM1ldWGbvCjIGPbfqrO30qMgrQMSYieWV6hehS2+v9siT2Vg6D
         rQFg==
X-Gm-Message-State: APjAAAVs+5p0Jea4j4yqDvMmwnXr8lQB22pjwiJOI92e6/tv7IU+6vih
        7RMGN+0p9nKn5A1ZM6qLKQKvXT5YHYxh1I/TzNY=
X-Google-Smtp-Source: APXvYqz6SYn6srGWYg5PeazX89ohtOZ5L0CAy1Ry21Fv1oP9OmbPDOKBIQ7NwaxiB6RMZUouwO4MUOn2iEMLO/oM6CU=
X-Received: by 2002:aca:4c08:: with SMTP id z8mr19937976oia.30.1554796309691;
 Tue, 09 Apr 2019 00:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190405141215.2079-1-colin.king@canonical.com>
In-Reply-To: <20190405141215.2079-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Apr 2019 09:51:38 +0200
Message-ID: <CAJZ5v0gxx_4nRS6R8ACfKG7C-eRMh+hXa7WkNYoMzqOTA2WqJQ@mail.gmail.com>
Subject: Re: [PATCH][next] acpi/hmat: fix uninitialized pointer dereference on
 pointer 'target'
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 4:12 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer 'target' is not initialized and is only assigned when the
> ACPI_HMAT_MEMORY_PD_VALID bit in p->flags is set.  There is a later null
> check on target that leads to an uninitialized pointer read and
> dereference when assigning target->processor_pxm when target contains a
> non-null garbage value.  Fix this by initializing targer to null.
>
> Fixes: 665ac7e92757 ("acpi/hmat: Register processor domain to its memory")
> Addresses-Coverity: ("Uninitialized pointer read")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Greg, since the patch fixed by this one is in your tree, can you apply
this too, please?

> ---
>  drivers/acpi/hmat/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b7824a0309f7..b275016ff648 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>                                               const unsigned long end)
>  {
>         struct acpi_hmat_proximity_domain *p = (void *)header;
> -       struct memory_target *target;
> +       struct memory_target *target = NULL;
>
>         if (p->header.length != sizeof(*p)) {
>                 pr_notice("HMAT: Unexpected address range header length: %d\n",
> --
> 2.20.1
>
