Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95491C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC6F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfDQF4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbfDQF4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:56:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC4D33086214;
        Wed, 17 Apr 2019 05:56:20 +0000 (UTC)
Received: from [10.72.12.196] (ovpn-12-196.pek2.redhat.com [10.72.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80B775D719;
        Wed, 17 Apr 2019 05:56:11 +0000 (UTC)
Subject: Re: [PATCH] vhost-scsi: remove incorrect memory barrier
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>, mst@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org
References: <1555404968-39927-1-git-send-email-pbonzini@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <482f8951-f8c1-aeb4-2f57-4f03f876af6a@redhat.com>
Date:   Wed, 17 Apr 2019 13:56:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555404968-39927-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 17 Apr 2019 05:56:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/16 下午4:56, Paolo Bonzini wrote:
> At this point, vs_tpg is not public at all; tv_tpg_vhost_count
> is accessed under tpg->tv_tpg_mutex; tpg->vhost_scsi is
> accessed under vhost_scsi_mutex.  Therefor there are no atomic
> operations involved at all here, just remove the barrier.
>
> Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   drivers/vhost/scsi.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 618fb6461017..c090d177bd75 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1443,7 +1443,6 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
>   			tpg->tv_tpg_vhost_count++;
>   			tpg->vhost_scsi = vs;
>   			vs_tpg[tpg->tport_tpgt] = tpg;
> -			smp_mb__after_atomic();
>   			match = true;
>   		}
>   		mutex_unlock(&tpg->tv_tpg_mutex);


Acked-by: Jason Wang <jasowang@redhat.com>


