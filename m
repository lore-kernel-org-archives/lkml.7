Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6ABC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC5E2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565381420;
	bh=eD6+lzAMvCUjtaUh2v6tAj0AykqD2sH35Ab+I9sTK2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EPEq1sJUcMkBYmvznjDaTahDVeQgtEeU9twVuOiQ3JrLN9iK1eWYFIJeyJEzWJPKl
	 nA16M1bLRv5FMWFELe/nkYrto3fgevBpqqZ86fpcYy8Qjjsqf/5Ww3CYwcUsC6ddVc
	 wgxjslvPMQ7Y2FNXHzFsz6Wl+skh7Y8WsAzHi0cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfHIUKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:10:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41057 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfHIUKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:10:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so93131436ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBdWC4SLK43cJm7C5kXT86oBHUFmnxpYuPcIVtB99mc=;
        b=JVc0EHvAHwkTfE7HKrRMTfrqQ3F1FR90NTPgXHMu4aQ3bug1s5Oq7i7I3MwvxsOzYz
         Ds3mXSofmqFR8MPI89sCmpadOqxRvPkVt8yWLecPUd6B9f29LLMOWf1Kf6+eHrHvOK8F
         yhy28UequyRQjITaPVvwgcAbxYddRjr7djxq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBdWC4SLK43cJm7C5kXT86oBHUFmnxpYuPcIVtB99mc=;
        b=gg8zYG1oT9e5pKYmFxKbw6QT8FhG6nMk91yFI1VNxWuqx/PeBNY//V6e9plppDZc9m
         Q/XlEP/L2QWaMQUjwaFsIn0ILjXAX57764iwyOLZVM9Vg9WIHzRqwuBWj+zuIjSh2ASX
         NhVhB9KkzXj/nPa1XawlKbTA79dpxKywAy5LLOyCl1p7D7Cz9LkMm3r06k5djJgpmkM1
         D4GGQZjRv415On/nebfjyI9Dd9mBsuapH+cmp8NdMP6ynjSn34NC8/td9fMisTHxbckR
         M3w+6M28g6s3DrOQen9UJsnrDGvBMdXH0JY0I7XoH46/kYh7uOj9LJaOqmxdEpUfAqc/
         NLpQ==
X-Gm-Message-State: APjAAAU9suTEeuytXIG9GxEdyl5VCvU3csesAJ+wyTJWd+kY4fRqfzdK
        X64kY301iaWj8kEJtzHmoHer8WfHtR8=
X-Google-Smtp-Source: APXvYqySEXysJ6G84i951qQg91Ux+pSwkIWGgdhKnfNY2p+SQfSnoEu3Np/3e3l/i6UeS83MVripOA==
X-Received: by 2002:a2e:8559:: with SMTP id u25mr3026295ljj.224.1565381415837;
        Fri, 09 Aug 2019 13:10:15 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id k124sm17748603lfd.60.2019.08.09.13.10.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 13:10:14 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id r9so93147079ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:10:14 -0700 (PDT)
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr12475455ljj.165.1565381414234;
 Fri, 09 Aug 2019 13:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com>
In-Reply-To: <1565358624103.3694@mentor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Aug 2019 13:09:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=3y4XW1RA15crZpbDy8Z0pgQL7nHeTn69MX1xm3J4yw@mail.gmail.com>
Message-ID: <CAHk-=wi=3y4XW1RA15crZpbDy8Z0pgQL7nHeTn69MX1xm3J4yw@mail.gmail.com>
Subject: Re: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>
Cc:     "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 6:50 AM Schmid, Carsten
<Carsten_Schmid@mentor.com> wrote:
>
> @@ -1200,6 +1200,15 @@ void __release_region(struct resource *parent, resource_size_t start,
>                         write_unlock(&resource_lock);
>                         if (res->flags & IORESOURCE_MUXED)
>                                 wake_up(&muxed_resource_wait);
> +
> +                       write_lock(&resource_lock);
> +                       if (res->child) {
> +                               printk(KERN_WARNING "__release_region: %s has child %s,"
> +                                               "invalidating childs parent\n",
> +                                               res->name, res->child->name);
> +                               res->child->parent = NULL;
> +                       }
> +                       write_unlock(&resource_lock);
>                         free_resource(res);

So I think that this should be inside the previous resource_lock, and
before the whole "wake up muxed resource".

Also, a few other issues:

 - what about other freeing cases?  I'm looking at

        release_mem_region_adjustable()

   which has the same pattern where a resource may be freed.

 - what about multiple children? Your patch sets res->child->parent to
NULL, but what about possible other children (iow, the
res->child->sibling list)

 - releasing a resource without having released its children is a
nasty bug, but the bug is now here in release_region, it is in the
*caller*. The printk() (or pr_warn()) doesn't really help find that.

So my gut feel is that this patch is a symptom of a real bug, and a
warning is worthwhile to fix that bug, but more thought is needed.

Maybe something more along the line of

    diff --git a/kernel/resource.c b/kernel/resource.c
    index 7ea4306503c5..ebe06d77b06a 100644
    --- a/kernel/resource.c
    +++ b/kernel/resource.c
    @@ -1211,6 +1211,8 @@ void __release_region(struct resource
*parent, resource_size_t start,
                        }
                        if (res->start != start || res->end != end)
                                break;
    +                   if (WARN_ON_ONCE(res->child))
    +                           break;
                        *p = res->sibling;
                        write_unlock(&resource_lock);
                        if (res->flags & IORESOURCE_MUXED)

would be more appropriate? It simply refuses to free a resource that
has children, and gives a warning (with a backtrace) for the situation
(since clearly we now end up with a resource leak).

                Linus
