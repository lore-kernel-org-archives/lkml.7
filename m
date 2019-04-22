Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7EEC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D5F20693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfDVNQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:16:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVNQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:16:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A8AF307D848;
        Mon, 22 Apr 2019 13:16:21 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECFC02706A;
        Mon, 22 Apr 2019 13:16:15 +0000 (UTC)
Date:   Mon, 22 Apr 2019 09:16:13 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] audit: fix a memory leak bug
Message-ID: <20190422131613.ivnshztep4e772xq@madcap2.tricolour.ca>
References: <1555724969-15300-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555724969-15300-1-git-send-email-wang6495@umn.edu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 22 Apr 2019 13:16:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-19 20:49, Wenwen Wang wrote:
> In audit_rule_change(), audit_data_to_entry() is firstly invoked to
> translate the payload data to the kernel's rule representation. In
> audit_data_to_entry(), depending on the audit field type, an audit tree may
> be created in audit_make_tree(), which eventually invokes kmalloc() to
> allocate the tree.  Since this tree is a temporary tree, it will be then
> freed in the following execution, e.g., audit_add_rule() if the message
> type is AUDIT_ADD_RULE or audit_del_rule() if the message type is
> AUDIT_DEL_RULE. However, if the message type is neither AUDIT_ADD_RULE nor
> AUDIT_DEL_RULE, i.e., the default case of the switch statement, this
> temporary tree is not freed.
> 
> To fix this issue, only allocate the tree when the type is AUDIT_ADD_RULE
> or AUDIT_DEL_RULE.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Looks good to me.

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  kernel/auditfilter.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 63f8b3f..3ac71c4 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1114,22 +1114,24 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
>  	int err = 0;
>  	struct audit_entry *entry;
>  
> -	entry = audit_data_to_entry(data, datasz);
> -	if (IS_ERR(entry))
> -		return PTR_ERR(entry);
> -
>  	switch (type) {
>  	case AUDIT_ADD_RULE:
> +		entry = audit_data_to_entry(data, datasz);
> +		if (IS_ERR(entry))
> +			return PTR_ERR(entry);
>  		err = audit_add_rule(entry);
>  		audit_log_rule_change("add_rule", &entry->rule, !err);
>  		break;
>  	case AUDIT_DEL_RULE:
> +		entry = audit_data_to_entry(data, datasz);
> +		if (IS_ERR(entry))
> +			return PTR_ERR(entry);
>  		err = audit_del_rule(entry);
>  		audit_log_rule_change("remove_rule", &entry->rule, !err);
>  		break;
>  	default:
> -		err = -EINVAL;
>  		WARN_ON(1);
> +		return -EINVAL;
>  	}
>  
>  	if (err || type == AUDIT_DEL_RULE) {
> -- 
> 2.7.4
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
