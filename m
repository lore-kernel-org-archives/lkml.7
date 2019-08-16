Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639A5C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387F32064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwMs+Z1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfHPNm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:42:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33983 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfHPNm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:42:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so3181317pfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i95hjXCJDrJPx4BxvkVZX0wlp8fNawFNwEDM8N6lzWk=;
        b=cwMs+Z1zU8uKnOFjaxWVb4exkaTKQXN4WfXdfP3udYFeulyAnCPgxPlKeJCYUlsP4u
         NgYdFKMqnCXuG/g6WKitl9enp3T19S+ys9Z6nL6G+VpmIeHLjr/NEMUv3rJtvxD+UH++
         c/S4TjxLcpouiAIirMf0M9KIyJu9NngdKF9TjpFApGG55ck6g5qyoY3xeRBvCn2aBqKZ
         i2sJMoExoF4/bRnkL3H0EFVzIi0dv6o16H6PHIdFigw7WFvwCplbBhmhCSRq59RdPlL1
         0FFwJftv+qFGwk793L2q7wg8NeXN0PXuFq9jBK6KjH4I9Oj2J2yr44l7FoBm+KMKGMGY
         r8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i95hjXCJDrJPx4BxvkVZX0wlp8fNawFNwEDM8N6lzWk=;
        b=FbXdAQKb0/gNlHoOl/sVsTM1eiMJRulvd4CQv7PVmiFSHx0Mraf6MoLj/seBQO9FxT
         tBQswB1RluyLr3XWF2v1vg9K3ZsTJVudLPk4bCbBf1M544yddGfpg/tAyIsr69N6zP2W
         nvPQcf2bPQUTaQJmWUAq1ZadRcma8UcmOA7JgwbOIoK7SUVJpTSNlxH09wQxq66UN8em
         FLT87NntS3MntMKFAHGlQQMLy9QeE9Taabaa3M598hZi/OBT20fIdDUyYdJzPztdx9SY
         NygJOvYoSPlyk4ehcU13dH2T7qdBH2mCj7lb0a1+D9HFwgV5dZorVFdU0gbXztB8qjDu
         v4Bw==
X-Gm-Message-State: APjAAAWhzIJZnK9JNL1KVB+NkPIxs59CxJg7Y7oYbTi3DxCCnNOQm68J
        mvCmRCXD3bRBBZ/EJ8DgzwZq7270YqG48cKGvX8=
X-Google-Smtp-Source: APXvYqzepLDKeM2xkfmllmPMj2LYmRwJCr7AUK+efN/I7goGu/oUV8dsfD7I4XNg0V7rRORVmDdK7LMs5X/K/Mq1d84=
X-Received: by 2002:a17:90a:a114:: with SMTP id s20mr7378476pjp.20.1565962977120;
 Fri, 16 Aug 2019 06:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190816104515.63613-1-heikki.krogerus@linux.intel.com> <20190816104515.63613-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190816104515.63613-2-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Aug 2019 16:42:45 +0300
Message-ID: <CAHp75Vcp6JZ6jWT0dcbWXZYEJKz8Ps1TE-d8+haVni+g4DMnBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] software node: Add software_node_find_by_name()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 1:45 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Function that searches software nodes by node name.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/base/swnode.c    | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/property.h |  4 ++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index e7b3aa3bd55a..ee2a405cca9a 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -620,6 +620,43 @@ static const struct fwnode_operations software_node_ops = {
>
>  /* -------------------------------------------------------------------------- */
>
> +/**
> + * software_node_find_by_name - Find software node by name
> + * @parent: Parent of the software node
> + * @name: Name of the software node
> + *
> + * The function will find a node that is child of @parent and that is named
> + * @name. If no node is found, the function returns NULL.
> + *
> + * NOTE: you will need to drop the reference with fwnode_handle_put() after use.
> + */
> +const struct software_node *
> +software_node_find_by_name(const struct software_node *parent, const char *name)
> +{
> +       struct swnode *swnode;
> +       struct kobject *k;
> +
> +       if (!name)
> +               return NULL;
> +
> +       spin_lock(&swnode_kset->list_lock);
> +
> +       list_for_each_entry(k, &swnode_kset->list, entry) {
> +               swnode = kobj_to_swnode(k);
> +               if (parent == swnode->node->parent && swnode->node->name &&
> +                   !strcmp(name, swnode->node->name)) {
> +                       kobject_get(&swnode->kobj);
> +                       break;
> +               }
> +               swnode = NULL;
> +       }
> +
> +       spin_unlock(&swnode_kset->list_lock);
> +
> +       return swnode ? swnode->node : NULL;
> +}
> +EXPORT_SYMBOL_GPL(software_node_find_by_name);
> +
>  static int
>  software_node_register_properties(struct software_node *node,
>                                   const struct property_entry *properties)
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 5a910ad79591..9b3d4ca3a73a 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -421,6 +421,10 @@ bool is_software_node(const struct fwnode_handle *fwnode);
>  const struct software_node *to_software_node(struct fwnode_handle *fwnode);
>  struct fwnode_handle *software_node_fwnode(const struct software_node *node);
>
> +const struct software_node *
> +software_node_find_by_name(const struct software_node *parent,
> +                          const char *name);
> +
>  int software_node_register_nodes(const struct software_node *nodes);
>  void software_node_unregister_nodes(const struct software_node *nodes);
>
> --
> 2.23.0.rc1
>


-- 
With Best Regards,
Andy Shevchenko
