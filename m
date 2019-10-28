Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FD9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 04:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D7020663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 04:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHl3lffz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfJ1E35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 00:29:57 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37330 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfJ1E35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 00:29:57 -0400
Received: by mail-yb1-f196.google.com with SMTP id z125so3622440ybc.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 21:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kay/B6Pbmp52GXhHLdI41CSSdennX3J2TNNpq3dL5KE=;
        b=pHl3lffzuwfzmHI3pzQCCUD+EgCKcge0eQF50bDurCUXGU05HAlRKes7teALt2xETM
         B88kFIKmourv44FDT/Y5HnD7uhWT8HsCCgnXxNiZzpf7wbpgD++IclOzcO6zDB3N0GIB
         zMc34/Ya4/sb0EDCAGMLteY6Tl/H/CTEiVdsdDgGNMFL6nKgkRRhelAbP+gIsuoJdIlw
         HARizMQS6Ga7f02I9a54VIcpGQNyN4bS1wShB5b3A8WPjl0TRhjMXc7iu1ZYwtT5Bkgz
         Bmh2bQ6D7dim34qCoVv3gCLtwikssyw0nmQUO7CVowYjsjYkqsed+Fr8pRIqllq4wU37
         giow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kay/B6Pbmp52GXhHLdI41CSSdennX3J2TNNpq3dL5KE=;
        b=hQS6vTrsskygDGJ5EXe7wzyzfMPiS+LdbdNMqGLtAWwvYpOzwy7a7PqYz8iXWBcSNu
         q6WK6DUz/fKJzCdf+r+SrhIW+h3KvDDTtrozhOM5L/07k+yKz3CAHo5fdrLTs+TEMoW3
         ZHquDLU8wm1T/rWXtEiZHkPbHWeWLFXZTMcMirs4QrZWWmaz3jnnpHlJBtGR5xKxMaHY
         O7XgAyfmi4Eg6oItYbqJS7dfxLJErZueD7yhoCoK/xbbE1IFoktUg460M0a7LqfG4Dm7
         w6CtOtsIpANe6ZDNCwl9tqGa9gA4GfFXAb5pc7xc7M40MviDKfkItIfaO6DbV/u+M51I
         t3sg==
X-Gm-Message-State: APjAAAWu6fMfjsP6swJ86m6MGjZscsRSCmKfCw0gM7ZGO4THUOrQAE9h
        CiUkQ8IHyPEHGy3dJ0hSHBNIh8SySjC/ouNFosmvkA==
X-Google-Smtp-Source: APXvYqwTW4qR98/8ui/7P1JiCS/B04syzKwKFdZ0+Ts/9BW7FhAHzDKoF8E7+F7v+6/coxyI7YvuoQJI9Lz1BkY0DkQ=
X-Received: by 2002:a25:19c5:: with SMTP id 188mr11659594ybz.253.1572236995910;
 Sun, 27 Oct 2019 21:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191028021442.5450-1-richardw.yang@linux.intel.com>
In-Reply-To: <20191028021442.5450-1-richardw.yang@linux.intel.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Sun, 27 Oct 2019 21:29:43 -0700
Message-ID: <CANN689FNPD1U+gGaO5PmCuMULvkzOffOAPuB8fmyhVLHSqM7Vw@mail.gmail.com>
Subject: Re: [Patch v2 1/2] lib/rbtree: set successor's parent unconditionally
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code looks fine, for both commits in this series. Please make sure to
double check that lib/rbtree_test does not show any performance
regressions, but assuming they don't, looks great !

Reviewed-By: Michel Lespinasse <walken@google.com>

On Sun, Oct 27, 2019 at 7:15 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> Both in Case 2 and 3, we exchange n and s. This mean no matter whether
> child2 is NULL or not, successor's parent should be assigned to node's.
>
> This patch takes this step out to make it explicit and reduce the
> ambiguity.
>
> Besides, this step reduces some symbol size like rb_erase().
>
>    KERN_CONFIG       upstream       patched
>    OPT_FOR_PERF      877            870
>    OPT_FOR_SIZE      635            621
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  include/linux/rbtree_augmented.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
> index fdd421b8d9ae..99c42e1a74b8 100644
> --- a/include/linux/rbtree_augmented.h
> +++ b/include/linux/rbtree_augmented.h
> @@ -283,14 +283,13 @@ __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
>                 __rb_change_child(node, successor, tmp, root);
>
>                 if (child2) {
> -                       successor->__rb_parent_color = pc;
>                         rb_set_parent_color(child2, parent, RB_BLACK);
>                         rebalance = NULL;
>                 } else {
>                         unsigned long pc2 = successor->__rb_parent_color;
> -                       successor->__rb_parent_color = pc;
>                         rebalance = __rb_is_black(pc2) ? parent : NULL;
>                 }
> +               successor->__rb_parent_color = pc;
>                 tmp = successor;
>         }
>
> --
> 2.17.1
>


-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
