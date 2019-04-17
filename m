Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E68C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F4420674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfDQF51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfDQF51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6C1B308427C;
        Wed, 17 Apr 2019 05:57:26 +0000 (UTC)
Received: from [10.72.12.196] (ovpn-12-196.pek2.redhat.com [10.72.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 213155D719;
        Wed, 17 Apr 2019 05:57:19 +0000 (UTC)
Subject: Re: [PATCH] vhost/scsi: drop unnecessary smp_mb__after_atomic()
To:     Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
References: <20190416104748.26942-1-stefanha@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c18ed846-940b-0b10-3d40-639b1f8dc499@redhat.com>
Date:   Wed, 17 Apr 2019 13:57:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416104748.26942-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 17 Apr 2019 05:57:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/16 下午6:47, Stefan Hajnoczi wrote:
> The vhost_scsi.ko code used several atomic variables at one point.
> Later they were dropped or converted to regular ints protected by a
> mutex.
>
> The commit that made these changes left an unused smp_mb__after_atomic()
> in vhost_scsi_set_endpoint().  It was previously used after incrementing
> vhost_scsi->vhost_ref_cnt but this field has been dropped:
>
>    -     atomic_inc(&vs->vhost_ref_cnt);
>          smp_mb__after_atomic_inc();
>
> Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Fixes: 101998f6fcd680 ("tcm_vhost: Post-merge review changes requested by MST")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   drivers/vhost/scsi.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 618fb6461017..c090d177bd75 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1443,7 +1443,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
>   			tpg->tv_tpg_vhost_count++;
>   			tpg->vhost_scsi = vs;
>   			vs_tpg[tpg->tport_tpgt] = tpg;
> -			smp_mb__after_atomic();
>   			match = true;
>   		}
>   		mutex_unlock(&tpg->tv_tpg_mutex);


Looks like Paolo has sent an identical patch before this one.

Thanks

