Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BC3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9552186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCTP2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:28:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbfCTP2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:28:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6FBE307D95F;
        Wed, 20 Mar 2019 15:28:16 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2173A1778C;
        Wed, 20 Mar 2019 15:28:00 +0000 (UTC)
Date:   Wed, 20 Mar 2019 11:27:58 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] audit: Make audit_log_cap and audit_copy_inode
 static
Message-ID: <20190320152757.qt45w75x2zy3iuv5@madcap2.tricolour.ca>
References: <20190320135922.8772-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320135922.8772-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 20 Mar 2019 15:28:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-20 21:59, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> kernel/auditsc.c:1150:6: warning: symbol 'audit_log_cap' was not declared. Should it be static?
> kernel/auditsc.c:1908:6: warning: symbol 'audit_copy_inode' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for the patch.

Acked-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  kernel/auditsc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index fa7b804..17b0007 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1147,7 +1147,8 @@ static void audit_log_execve_info(struct audit_context *context,
>  	kfree(buf_head);
>  }
>  
> -void audit_log_cap(struct audit_buffer *ab, char *prefix, kernel_cap_t *cap)
> +static void audit_log_cap(struct audit_buffer *ab, char *prefix,
> +			  kernel_cap_t *cap)
>  {
>  	int i;
>  
> @@ -1905,8 +1906,9 @@ static inline int audit_copy_fcaps(struct audit_names *name,
>  }
>  
>  /* Copy inode data into an audit_names. */
> -void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> -		      struct inode *inode, unsigned int flags)
> +static void audit_copy_inode(struct audit_names *name,
> +			     const struct dentry *dentry,
> +			     struct inode *inode, unsigned int flags)
>  {
>  	name->ino   = inode->i_ino;
>  	name->dev   = inode->i_sb->s_dev;
> -- 
> 2.7.0
> 
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
