Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AB2C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A664B218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfGZL5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:57:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfGZL5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:57:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3785183F4C;
        Fri, 26 Jul 2019 11:57:33 +0000 (UTC)
Received: from [10.72.12.238] (ovpn-12-238.pek2.redhat.com [10.72.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC5EA60C18;
        Fri, 26 Jul 2019 11:57:28 +0000 (UTC)
Subject: Re: [PATCH] vhost: disable metadata prefetch optimization
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
References: <20190726115021.7319-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ccba99c1-7708-3e55-6fc9-7775415c77a8@redhat.com>
Date:   Fri, 26 Jul 2019 19:57:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726115021.7319-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 26 Jul 2019 11:57:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/26 下午7:51, Michael S. Tsirkin wrote:
> This seems to cause guest and host memory corruption.
> Disable for now until we get a better handle on that.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> I put this in linux-next, we'll re-enable if we can fix
> the outstanding issues in a short order.


Btw, is this more suitable to e.g revert the 
842aa64eddacd23adc6ecdbc69cb2030bec47122 and let syzbot fuzz more on the 
current code?

I think we won't accept that patch eventually, so I suspect what syzbot 
reports today is a false positives.

Thanks


>
>   drivers/vhost/vhost.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 819296332913..42a8c2a13ab1 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -96,7 +96,7 @@ struct vhost_uaddr {
>   };
>   
>   #if defined(CONFIG_MMU_NOTIFIER) && ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE == 0
> -#define VHOST_ARCH_CAN_ACCEL_UACCESS 1
> +#define VHOST_ARCH_CAN_ACCEL_UACCESS 0
>   #else
>   #define VHOST_ARCH_CAN_ACCEL_UACCESS 0
>   #endif
