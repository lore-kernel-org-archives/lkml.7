Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFA9C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F72214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560267516;
	bh=DoQ+nJzbxqq3tC4iTmxZD79WfPzlewM+li1o87aekUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cqNLWfvjDuOcg8rEAxAnAJCjCo+6xR5HQdK4W6dLi0IjBVP4hNBAgy/7SIV+a4qYd
	 siEecG9moSf2/SXWETrBBF9hhh0WJqeelg8m3K22vWYgwkUwDj4M5y06Ugkib1SW0m
	 BIdceB4VWGhOrboi2WQc0NWjVMTJAWjTHDizuIOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390802AbfFKPif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:32888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388819AbfFKPie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:38:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56672089E;
        Tue, 11 Jun 2019 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560267514;
        bh=DoQ+nJzbxqq3tC4iTmxZD79WfPzlewM+li1o87aekUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMk6DGcOCBvlaQqYsfILEAlrXcjpUu2GN4cGhPNxzouGjzhA3p8fGKe98adCJb22L
         dO/KmMdITKBEY7H3+bhJEYdKsWuro+S5FhmU9X/M/05EKwl8jxBfE3cNiAvEjt1EYm
         kqRqj6y7+yUtU8E0g5/IaBz72TKuJMo7uTLFegLc=
Date:   Tue, 11 Jun 2019 17:38:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Jessica Yu <jeyu@kernel.org>, mbenes@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
Message-ID: <20190611153832.GB5706@kroah.com>
References: <20190530134304.4976-1-yuehaibing@huawei.com>
 <20190603144554.18168-1-yuehaibing@huawei.com>
 <20190611133344.GA9114@linux-8ccs>
 <362632a8-9fa8-e72a-e4f5-1bd459b922fc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <362632a8-9fa8-e72a-e4f5-1bd459b922fc@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:30:56PM +0800, Yuehaibing wrote:
> On 2019/6/11 21:33, Jessica Yu wrote:
> > +++ YueHaibing [03/06/19 22:45 +0800]:
> >> In module_add_modinfo_attrs if sysfs_create_file
> >> fails, we forget to free allocated modinfo_attrs
> >> and roll back the sysfs files.
> >>
> >> Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >> v3: reuse module_remove_modinfo_attrs
> >> v2: free from '--i' instead of 'i--'
> >> ---
> >> kernel/module.c | 21 ++++++++++++++++-----
> >> 1 file changed, 16 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/kernel/module.c b/kernel/module.c
> >> index 80c7c09..c6b8912 100644
> >> --- a/kernel/module.c
> >> +++ b/kernel/module.c
> >> @@ -1697,6 +1697,8 @@ static int add_usage_links(struct module *mod)
> >>     return ret;
> >> }
> >>
> >> +static void module_remove_modinfo_attrs(struct module *mod, int end);
> >> +
> >> static int module_add_modinfo_attrs(struct module *mod)
> >> {
> >>     struct module_attribute *attr;
> >> @@ -1711,24 +1713,33 @@ static int module_add_modinfo_attrs(struct module *mod)
> >>         return -ENOMEM;
> >>
> >>     temp_attr = mod->modinfo_attrs;
> >> -    for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
> >> +    for (i = 0; (attr = modinfo_attrs[i]); i++) {
> >>         if (!attr->test || attr->test(mod)) {
> >>             memcpy(temp_attr, attr, sizeof(*temp_attr));
> >>             sysfs_attr_init(&temp_attr->attr);
> >>             error = sysfs_create_file(&mod->mkobj.kobj,
> >>                     &temp_attr->attr);
> >> +            if (error)
> >> +                goto error_out;
> >>             ++temp_attr;
> >>         }
> >>     }
> >> +
> >> +    return 0;
> >> +
> >> +error_out:
> >> +    module_remove_modinfo_attrs(mod, --i);
> > 
> > Gah, I think there is another issue here - if sysfs_create_file()
> > fails on the first iteration of the loop (so i = 0), then we will go
> > to error_out and end up calling module_remove_modinfo_attrs(mod, -1),
> > which, for i = 0, will call sysfs_remove_file() since attr->attr.name
> > had already been set before the failed call to sysfs_create_file().
> > Perhaps we need to check that i > 0 before calling
> > module_remove_modinfo_attrs() under error_out?
> 
> Indeed, this should be checked, thanks!

There is a simple sysfs core function that does the whole "add a whole
group of files at once" in a simple manner.  Perhaps you should be
calling that one instead?

thanks,

greg k-h
