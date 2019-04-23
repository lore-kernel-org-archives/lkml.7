Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263A1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1FB21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfDWLL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:11:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfDWLL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:11:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F71B356F6;
        Tue, 23 Apr 2019 11:11:56 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FFCB5C29A;
        Tue, 23 Apr 2019 11:11:55 +0000 (UTC)
Date:   Tue, 23 Apr 2019 13:11:53 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jiang Biao <benbjiang@tencent.com>
Cc:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm_main: fix some comments
Message-ID: <20190423131153.4b68c9e6.cohuck@redhat.com>
In-Reply-To: <20190423094008.67986-1-benbjiang@tencent.com>
References: <20190423094008.67986-1-benbjiang@tencent.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 23 Apr 2019 11:11:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 17:40:08 +0800
Jiang Biao <benbjiang@tencent.com> wrote:

> is_dirty has been rename to flush, but the comment for it is

s/rename/renamed/

> outdated. And the description about @flush parameter for
> kvm_clear_dirty_log_protect() is missing, add it in this patch
> also.
> 
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  virt/kvm/kvm_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index dc8edc97ba85..40b435e77672 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1138,7 +1138,7 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
>   *	and reenable dirty page tracking for the corresponding pages.

BTW: Not seen in the diff, but this line and the preceding one do not
really form a sentence that makes sense :) Maybe fix that as well, as
you are touching the area anyway?

>   * @kvm:	pointer to kvm instance
>   * @log:	slot id and address to which we copy the log
> - * @is_dirty:	flag set if any page is dirty
> + * @flush:	if TLB flush is needed by caller

Hm, maybe "true if TLB flush is needed by caller"?

>   *
>   * We need to keep it in mind that VCPU threads can write to the bitmap
>   * concurrently. So, to avoid losing track of dirty pages we keep the
> @@ -1223,6 +1223,7 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log_protect);
>   *	and reenable dirty page tracking for the corresponding pages.
>   * @kvm:	pointer to kvm instance
>   * @log:	slot id and address from which to fetch the bitmap of dirty pages
> + * @flush:	if TLB flush is needed by caller
>   */
>  int kvm_clear_dirty_log_protect(struct kvm *kvm,
>  				struct kvm_clear_dirty_log *log, bool *flush)

