Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FAFC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1B520818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555058935;
	bh=z2tHWZjksT0JJz2uitfc2YyqdnMS7uukgVbHT838jwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Zx5wvJ5XNBSv7sxyI5qElQgE2TfO4B1bEmgfZRh9vZ3T8/LfYrJ+Zk0BFl6sN0SHV
	 RVEbimU/he65POuU6PoCkqpO1b68HzhmzEvYGYRli9MuLEXDBZVcd5XLqf389SislU
	 ukxRVNa+izCjYWSazeQS/yPrkiRU1A+bXctO0glY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfDLIsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:48:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38293 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfDLIsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:48:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id e80so7729075ote.5;
        Fri, 12 Apr 2019 01:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vruAS9FVO8+0ZWh8zsjH+XnzNDkt1hKHtgpkktvnD+w=;
        b=BXbf3zJT4TTIxGOs0Y76tWj3EHb0kaiCw9v5rU9jjOZw1nxXf8NwptKvWxsGDHFuVT
         FQ8RK8+Q7GhbLQNRhW5Z5VfinLdbbUPQ0XCamCi1CV1tcDJKVfM/SlH9gJoaW7vpchHx
         /7/6rQSrd3MDVmOCUbbR0oO/ZumkoOfJ0pF/HtYGZrLQH1eS5udZRfgTluIQ0sDg9RyH
         0AU6K5uIvsuAwJqYAifRi2szkYfJqOVRt9xkP2C9mfsV9qm2xNBv2VDxjCPWO+nnJii+
         yK9BjxpXJrRd1AJtsCWh9pE1apDINxFOzl6X2tX8WYKEgYsfG2tkjNZgfkGpPVB7hLqg
         iyZg==
X-Gm-Message-State: APjAAAXImaEkuuM6scuw7n106cSbc0gQCS6FQM1lLKbxE2mzD3yfkL/6
        LdF/OgzUmMdBsetHU37ml32xFdxQgSWRAvE7Kik=
X-Google-Smtp-Source: APXvYqydCjlAcj0h/1qD55yP60CnPcQb7vPuyjLlN06E9St6VPMMDagY6bXeq115CkJL6xL7lFuZTDUeWTsWo8M4khQ=
X-Received: by 2002:a05:6830:11d0:: with SMTP id v16mr2217956otq.159.1555058933127;
 Fri, 12 Apr 2019 01:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com> <20190410152505.87041-5-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190410152505.87041-5-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Apr 2019 10:48:41 +0200
Message-ID: <CAJZ5v0jTR6TqMxRoRhBzG8Rf8JgGfriuCLsGKBYxjBOZz_7yBA@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] software node: Implement .get_reference_args
 fwnode operation
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 5:26 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> This makes it possible to support drivers that use
> fwnode_property_get_reference_args() function.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/swnode.c | 56 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 39b8f8f35cfe..d6a9b56cb073 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -534,6 +534,61 @@ software_node_get_named_child_node(const struct fwnode_handle *fwnode,
>         return NULL;
>  }
>
> +static int
> +software_node_get_reference_args(const struct fwnode_handle *fwnode,
> +                                const char *propname, const char *nargs_prop,
> +                                unsigned int nargs, unsigned int index,
> +                                struct fwnode_reference_args *args)
> +{
> +       struct software_node *swnode = to_software_node(fwnode);
> +       struct software_node_reference *ref;
> +       const struct property_entry *prop;
> +       int ret = -ENOENT;
> +       int i;
> +
> +       mutex_lock(&swnode->lock);
> +
> +       if (!swnode || list_empty(&swnode->references))
> +               goto err_unlock;
> +
> +       if (nargs_prop) {
> +               prop = property_entry_get(swnode->properties, nargs_prop);
> +               if (!prop) {
> +                       ret = -EINVAL;
> +                       goto err_unlock;
> +               }
> +
> +               nargs = prop->value.u32_data;
> +       }
> +
> +       if (nargs > NR_FWNODE_REFERENCE_ARGS) {
> +               ret = -EINVAL;
> +               goto err_unlock;
> +       }
> +
> +       list_for_each_entry(ref, &swnode->references, list) {
> +               if (strcmp(ref->name, propname))
> +                       continue;
> +
> +               if (index > (ref->nrefs - 1))
> +                       break;
> +
> +               args->nargs = nargs;
> +               args->fwnode = software_node_get(ref->args[index].fwnode);
> +
> +               for (i = 0; i < nargs; i++)
> +                       args->args[i] = ref->args[index].args[i];

If nargs is provided by the caller, can't it be greater than the
number of args[index].args[] entries?

> +
> +               ret = 0;
> +               break;
> +       }
> +
> +err_unlock:
> +       mutex_unlock(&swnode->lock);
> +
> +       return ret;
> +}
> +
>  static const struct fwnode_operations software_node_ops = {
>         .get = software_node_get,
>         .put = software_node_put,
> @@ -543,6 +598,7 @@ static const struct fwnode_operations software_node_ops = {
>         .get_parent = software_node_get_parent,
>         .get_next_child_node = software_node_get_next_child,
>         .get_named_child_node = software_node_get_named_child_node,
> +       .get_reference_args = software_node_get_reference_args,
>  };
>
>  /* -------------------------------------------------------------------------- */
