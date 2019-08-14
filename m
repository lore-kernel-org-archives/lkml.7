Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C81BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E412720665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmzvqj2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfHNQ3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:29:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37685 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfHNQ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:29:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id f22so7596248edt.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=siwMqdoojDd3vGBAd4TykA8P+3WWK1D0e4/pZN7NS4U=;
        b=jmzvqj2gv7f2RYPLWq9PNdOEZbIytJWu8r+PsIQdugqqEbOS0IYDcU4LUwwPFT3QvK
         VXRL0BYivhu6A78eRmiztpl20FRIaQzgaKBgXqUvfBINyRRN5dRexSp9LvCX8dJV3UUH
         AnNzJSviou2/H9wmpqk+ZYd4Q/gh2khEZrA9+ueK7Vf4cyd/baz2OK16KqDnYJWzplJb
         4i/FEeu4cRSbwrgC6UGgUC9U+W6oNYnEMfNxaQEtOVG81PjyjJQc5cTma/9HJpqGVk65
         YRcazufHAPVbbIvCQAak2bAxa+wDKTUrzHZfXTpS29Vq4uScHOWjHvQ1RkNzgowA2jM4
         OUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=siwMqdoojDd3vGBAd4TykA8P+3WWK1D0e4/pZN7NS4U=;
        b=DdyO6vnfT9+NcznJ8G3gaJUFIJbO4y0XtgcGxisHfk+uUy1/AHkMmY9RsvWqqJsaqL
         QF/mv265exRkpjxO+fV4XRXjczDZbjUwCgAU2DuIzgifztQyzrND6+WczkXXCFXKDli5
         Wa6hAoWqmkUZYxAwMCoHgMqepK6xfdNBaWpJmmSd6UmVOGLu8mXamU/3qL+qD/B8wgMl
         FT3V53rU/i8JcDWVVmaVkmOualxqjnd8hwApBOdgayle46q8PlGy+71uj4J3woAL4wtQ
         KPvKHJjAcZY5CDFXaCK0gnRNqyue3I3mmmQLAv/tbeyACNH0eAb120hoZrCkN8yM7jLl
         WXlw==
X-Gm-Message-State: APjAAAWs8l3ljDQS4pHN94D/4/RiDkYFe14DHkA1ypUFDqUwDQ9zgwVf
        tuxW3NWskSbp+N+i6AZLSgU=
X-Google-Smtp-Source: APXvYqyqjyd1o1Utzo4odGjN6U4rkrRwW4HCZlNXs+6r6J6S1nBGdR8O2xRwKKvv/HCe8HCgNiWloA==
X-Received: by 2002:a50:ba69:: with SMTP id 38mr542706eds.46.1565800173379;
        Wed, 14 Aug 2019 09:29:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w13sm14738eji.22.2019.08.14.09.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 09:29:32 -0700 (PDT)
Date:   Wed, 14 Aug 2019 16:29:32 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] kernel/resource.c: invalidate parent when freed
 resource has childs
Message-ID: <20190814162932.alwo7g4664c2dtp3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1565278859475.1962@mentor.com>
 <1565358624103.3694@mentor.com>
 <20190809223831.fk4uyrzscr366syr@master>
 <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
 <1565794104204.54092@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565794104204.54092@mentor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 02:48:24PM +0000, Schmid, Carsten wrote:
>When a resource is freed and has children, the childrens are

s/childrens/children/

>left without any hint that their parent is no more valid.
>This caused at least one use-after-free in the xhci-hcd using
>ext-caps driver when platform code released platform devices.
>
>In such case, warn and release all resources beyond.
>
>Signed-off-by: Carsten Schmid <carsten_schmid@mentor.com>
>---
>v2:
>- release everything below the released resource, not only
>  one child; re-using __release_child_resources
>  (Inspired by Linus Torvalds outline)
>- warn only once
>  (According to Linus Torvalds outline)
>- Keep parent and child name in warning message
>  (eases hunting for the involved parties)
>---
> kernel/resource.c | 26 ++++++++++++++++++++++----
> 1 file changed, 22 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/resource.c b/kernel/resource.c
>index c3cc6d85ec52..eb48d793aa74 100644
>--- a/kernel/resource.c
>+++ b/kernel/resource.c
>@@ -239,7 +239,7 @@ static int __release_resource(struct resource *old, bool release_child)
> 	return -EINVAL;
> }
> 
>-static void __release_child_resources(struct resource *r)
>+static void __release_child_resources(struct resource *r, bool warn)
> {
> 	struct resource *tmp, *p;
> 	resource_size_t size;
>@@ -252,9 +252,10 @@ static void __release_child_resources(struct resource *r)
> 
> 		tmp->parent = NULL;
> 		tmp->sibling = NULL;
>-		__release_child_resources(tmp);
>+		__release_child_resources(tmp, warn);

This function will release all the children.

Is this what Linus suggest?

From his code snippet, I just see siblings parent is set to NULL. I may miss
some point?

> 
>-		printk(KERN_DEBUG "release child resource %pR\n", tmp);
>+		if (warn)
>+			printk(KERN_DEBUG "release child resource %pR\n", tmp);
> 		/* need to restore size, and keep flags */
> 		size = resource_size(tmp);
> 		tmp->start = 0;
>@@ -265,7 +266,7 @@ static void __release_child_resources(struct resource *r)
> void release_child_resources(struct resource *r)
> {
> 	write_lock(&resource_lock);
>-	__release_child_resources(r);
>+	__release_child_resources(r, true);
> 	write_unlock(&resource_lock);
> }
> 
>@@ -1172,7 +1173,20 @@ EXPORT_SYMBOL(__request_region);
>  * @n: resource region size
>  *
>  * The described resource region must match a currently busy region.
>+ * If the region has children they are released too.
>  */
>+static void check_children(struct resource *parent)
>+{
>+	if (parent->child) {
>+		/* warn and release all children */
>+		WARN_ONCE(1, "%s: %s has child %s, release all children\n",
>+				__func__, parent->name, parent->child->name);
>+		write_lock(&resource_lock);

In previous version, lock is grasped before parent->child is checked.

Not sure why you change the order?

>+		__release_child_resources(parent, false);
>+		write_unlock(&resource_lock);
>+	}
>+}
>+
> void __release_region(struct resource *parent, resource_size_t start,
> 		      resource_size_t n)
> {
>@@ -1200,6 +1214,10 @@ void __release_region(struct resource *parent, resource_size_t start,
> 			write_unlock(&resource_lock);
> 			if (res->flags & IORESOURCE_MUXED)
> 				wake_up(&muxed_resource_wait);
>+
>+			/* You should'nt release a resource that has children */
>+			check_children(res);
>+
> 			free_resource(res);
> 			return;
> 		}
>-- 
>2.17.1
>

-- 
Wei Yang
Help you, Help me
