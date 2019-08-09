Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A251C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B550208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="W9IoyICp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436738AbfHIQ7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:59:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45141 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436716AbfHIQ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:59:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id m97so1750544otm.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8urhOE507etpc43ZLTt/hh0V3pJ4BwrdpGHMg7/duNc=;
        b=W9IoyICpPFY54k64kbGeHDgN1O4hcTgU3AN1zziTBToTJ1ppVPkyWjwQ1VQVaNj2OO
         AY7AqwfGxZJpHD/e/q8sNDl9yuU5EXTGkAf3sT0vn3bO5k4HJXHL9gpr5fj2QzMe7sW5
         sBrtNKYOlBJqAFk6NDdIxBl5SZX0D644+X6m5+jiS66MzX96q0v/DlkkfEqGKXBNwJGx
         w5mD7Ch+td4pdM1whJrC/euhMRdWs13SiFKBLocFVotQrvG3Mbq6YDdtTR8LiPTF9nFk
         GoIufA57AfRgys5KXkGH5wpiPFFEFVxEGLOZ0dEVLY5sudYBGxPS0HWoFyUPkBW6a4Nl
         5b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8urhOE507etpc43ZLTt/hh0V3pJ4BwrdpGHMg7/duNc=;
        b=PlhThLWkLHAWPKROXse7PlQutVC/RQt3wgdZ/8fzlcd0nrZhPZJb8UGGf6Xl4ieQ0x
         DZvXYvijnMaiZFjxXPjK9Bw9iSN2PFOOjnOCIdo+dfv6SNlHVyHcFlGGk6llloe+9JIV
         ZIToQuRD3bsL2MPcSqRekzHOsdojJ+6mWf7AKClFX3bHUZ5wTRPlpfvFjLlzKoQ3C0u2
         CDKnX8Tbxq6nGQXuLlbBRQo8D1EcwDCWhnBI4SlYyaacOAIgMGA4OoT9ilNzpsUGOj8p
         BWS6VgeUGMzMoedYDzbpofxF5aL/Aw6xtL2IuolW/GwAzHtwzwmNfpo92Vj9ouWOwgDY
         H0ng==
X-Gm-Message-State: APjAAAX0n5nz557CLQTGMHjmlW8ahFUgccDa7Q7rHsznnD45kjuQvuMi
        Ha6sm/cKEZYXPnBwjMzAyT0lBE8G/TopsOElrV80u1WbdWI=
X-Google-Smtp-Source: APXvYqz7bE3ITqJyjUO7D68c6iM7G6q70W1Gidd7qGbqUBTLi7lNdkiUJEhklmdh4/Jt48xPlZM2SlzsX8dtr4V0dO0=
X-Received: by 2002:aca:d558:: with SMTP id m85mr3097063oig.0.1565369981539;
 Fri, 09 Aug 2019 09:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com>
In-Reply-To: <1565358624103.3694@mentor.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 9 Aug 2019 09:59:30 -0700
Message-ID: <CAPcyv4h1vp2o-bw7sZLM=ivS97aNK9Ru-t-ocUMcvOLAAoSSjQ@mail.gmail.com>
Subject: Re: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>
Cc:     "bp@suse.de" <bp@suse.de>, "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 6:50 AM Schmid, Carsten
<Carsten_Schmid@mentor.com> wrote:
>
> When a resource is freed and has children, the childrens are
> left without any hint that their parent is no more valid.
> This caused at least one use-after-free in the xhci-hcd using
> ext-caps driver when platform code released platform devices.
>
> Fix this by setting child's parent to zero and warn.
>
> Signed-off-by: Carsten Schmid <carsten_schmid@mentor.com>
> ---
> Rationale:
> When hunting for the root cause of a crash on a 4.14.86 kernel, i
> have found the root cause and checked it being still present
> upstream. Our case:
> Having xhci-hcd and intel_xhci_usb_sw active we can see in
> /proc/meminfo: (exceirpt)
>   b3c00000-b3c0ffff : 0000:00:15.0
>     b3c00000-b3c0ffff : xhci-hcd
>       b3c08070-b3c0846f : intel_xhci_usb_sw
> intel_xhci_usb_sw being a child of xhci-hcd.
>
> Doing an unbind command
> echo 0000:00:15.0 > /sys/bus/pci/drivers/xhci_hcd/unbind
> leads to xhci-hcd being freed in __release_region.
> The intel_xhci_usb_sw resource is accessed in platform code
> in platform_device_del with
>                 for (i = 0; i < pdev->num_resources; i++) {
>                         struct resource *r = &pdev->resource[i];
>                         if (r->parent)
>                                 release_resource(r);
>                 }

How did we get here while intel_xhci_usb_sw is still active? I would
have expected intel_xhci_usb_sw to pin its parent preventing release
while any usage was pending?

> as the resource's parent has not been updated, the release_resource
> uses the parent:
>         p = &old->parent->child;
> which is now invalid.
> Fix this by marking the parent invalid in the child and give a warning

This does not seem like a fix. It does seem like a good sanity check
though, some notes below.

> in dmesg.
> ---
> Advised by Greg (thanks):
> Try resending it with at least the people who get_maintainer.pl says has
> touched that file last in it. [CS:done]
>
> Also, Linus is the unofficial resource.c maintainer.  I think he has a
> set of userspace testing scripts for changes somewhere, so you should
>  cc: him too.  And might as well add me :) [CS:done]
>
>  thanks,
>
>  greg k-h
> ---
>  kernel/resource.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 158f04ec1d4f..95340cb0b1c2 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1200,6 +1200,15 @@ void __release_region(struct resource *parent, resource_size_t start,
>                         write_unlock(&resource_lock);
>                         if (res->flags & IORESOURCE_MUXED)
>                                 wake_up(&muxed_resource_wait);
> +
> +                       write_lock(&resource_lock);

I'd move this above that write_unlock() a few lines up to eliminate a
lock bounce.

> +                       if (res->child) {
> +                               printk(KERN_WARNING "__release_region: %s has child %s,"

How about WARN_ONCE() to identify the code path that mis-sequenced the release?

> +                                               "invalidating childs parent\n",

s/childs/child's/

> +                                               res->name, res->child->name);
> +                               res->child->parent = NULL;
> +                       }
> +                       write_unlock(&resource_lock);
>                         free_resource(res);
>                         return;
>                 }
> --
> 2.17.1
