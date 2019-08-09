Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD1BC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20272070D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTbqj9ZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfHIWif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:38:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35697 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfHIWif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:38:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id w20so96582181edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vu3fnCcoCE+ex8fQgUjUcYvR6FHd62qNPU0Diyzu0d4=;
        b=bTbqj9ZWHPadfN6LLOC9UMICB5kn/HMYHcah/VdkJ/91n1gdgYl9iCXaQ7+lQyW+iU
         /K9XhJT30UZbEJMacPFWpAeI8DzdC069Ch3c9bGObt3hligarrSU8qzeQ5X/678mKBoc
         Z1fzSV8oCwH4k0VOyax8HnmUKubyvnoe7mbD0YvqH2Cxd04mdlVxHaZxaSKv3xYhh24R
         BeRWhhEpwlCqp32XN+4C/QWrPwwH8y3m0VmGlR+QxE9JvEmED6a8ktkqxR5+bYoNcbCd
         6iooou0Ntw80/fJX+swWTbkSMtIl2hWXtIPceMxbTWWIMAU9C8UH8cL7ESqccjToJees
         i7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vu3fnCcoCE+ex8fQgUjUcYvR6FHd62qNPU0Diyzu0d4=;
        b=S/uUGc4ghfYfpVoVe4u0cFb+nR9yIXey+UPI19c2Y7DTuQ167ym2yF5xpxDgKxn9Jc
         mPqqZbai/YRn5l1xcBMNV3joSKaxe4sWXfbbhWDvf7VTWjTzWCkiigXR52z6Hp9k4o5/
         49bg+YGuU3DC2AKzdeY5biuzzN2VGbYqMVyK7LElxDgMBwnHMnw2dU6+G87SAA/UUrUN
         tPLz0g15nNCqkrYkthkzq4gcR8YkAabhFg/6xETwQ+nf7XlGRF+voYeclBqMQOaPGLPc
         RZf74KLzKOhOCfPQQ9wBrY/OAiOG1GJto98KNYdldiXGQmoValJ5zhHjqq4OWzaMv/38
         g9tQ==
X-Gm-Message-State: APjAAAVahq3eG9apbOZ/ZdPD8i0sFJOrwNGuxBB3p8hkacdHV2/wtwER
        aJe1fveBeyhCg4UK3oCtMfk=
X-Google-Smtp-Source: APXvYqwTXWKUACHXvHZ7TN1OHxj0u36CHorImMUpkKzD4WXEIyslj5fUFmHkCwO5SN7ReKkm4X6XbA==
X-Received: by 2002:a17:906:fc5:: with SMTP id c5mr20644991ejk.129.1565390313150;
        Fri, 09 Aug 2019 15:38:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t2sm22840571eda.95.2019.08.09.15.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 15:38:32 -0700 (PDT)
Date:   Fri, 9 Aug 2019 22:38:31 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
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
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
Message-ID: <20190809223831.fk4uyrzscr366syr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1565278859475.1962@mentor.com>
 <1565358624103.3694@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565358624103.3694@mentor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:50:24PM +0000, Schmid, Carsten wrote:
>When a resource is freed and has children, the childrens are
>left without any hint that their parent is no more valid.
>This caused at least one use-after-free in the xhci-hcd using
>ext-caps driver when platform code released platform devices.
>
>Fix this by setting child's parent to zero and warn.
>
>Signed-off-by: Carsten Schmid <carsten_schmid@mentor.com>
>---
>Rationale:
>When hunting for the root cause of a crash on a 4.14.86 kernel, i
>have found the root cause and checked it being still present
>upstream. Our case:
>Having xhci-hcd and intel_xhci_usb_sw active we can see in
>/proc/meminfo: (exceirpt)
>  b3c00000-b3c0ffff : 0000:00:15.0
>    b3c00000-b3c0ffff : xhci-hcd
>      b3c08070-b3c0846f : intel_xhci_usb_sw
>intel_xhci_usb_sw being a child of xhci-hcd.
>
>Doing an unbind command
>echo 0000:00:15.0 > /sys/bus/pci/drivers/xhci_hcd/unbind
>leads to xhci-hcd being freed in __release_region.
>The intel_xhci_usb_sw resource is accessed in platform code
>in platform_device_del with
>                for (i = 0; i < pdev->num_resources; i++) {
>                        struct resource *r = &pdev->resource[i];
>                        if (r->parent)
>                                release_resource(r);
>                }
>as the resource's parent has not been updated, the release_resource
>uses the parent:
>        p = &old->parent->child;
>which is now invalid.
>Fix this by marking the parent invalid in the child and give a warning
>in dmesg.
>---
>Advised by Greg (thanks):
>Try resending it with at least the people who get_maintainer.pl says has
>touched that file last in it. [CS:done]
>
>Also, Linus is the unofficial resource.c maintainer.  I think he has a
>set of userspace testing scripts for changes somewhere, so you should
> cc: him too.  And might as well add me :) [CS:done]
>
> thanks,
>
> greg k-h
>---
> kernel/resource.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/kernel/resource.c b/kernel/resource.c
>index 158f04ec1d4f..95340cb0b1c2 100644
>--- a/kernel/resource.c
>+++ b/kernel/resource.c
>@@ -1200,6 +1200,15 @@ void __release_region(struct resource *parent, resource_size_t start,
>                        write_unlock(&resource_lock);
>                        if (res->flags & IORESOURCE_MUXED)
>                                wake_up(&muxed_resource_wait);
>+
>+                       write_lock(&resource_lock);
>+                       if (res->child) {

In theory, child may have siblings. Would it be possible to have several
devices under xhci-hcd?

>+                               printk(KERN_WARNING "__release_region: %s has child %s,"
>+                                               "invalidating childs parent\n",
>+                                               res->name, res->child->name);
>+                               res->child->parent = NULL;
>+                       }
>+                       write_unlock(&resource_lock);
>                        free_resource(res);
>                        return;
>                }
>--
>2.17.1

-- 
Wei Yang
Help you, Help me
