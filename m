Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD26EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 05:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B216921924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 05:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfIIFwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 01:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfIIFwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 01:52:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5F7330A00C5;
        Mon,  9 Sep 2019 05:52:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-59.ams2.redhat.com [10.36.117.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD9E05D6A7;
        Mon,  9 Sep 2019 05:52:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B9D2992F; Mon,  9 Sep 2019 07:52:19 +0200 (CEST)
Date:   Mon, 9 Sep 2019 07:52:19 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jaak Ristioja <jaak@ristioja.ee>, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Xorg indefinitely hangs in kernelspace
Message-ID: <20190909055219.q44k27cczwkuio3z@sirius.home.kraxel.org>
References: <20190906055322.17900-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906055322.17900-1-hdanton@sina.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 09 Sep 2019 05:52:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

--verbose please.  Do you see the same hang?  Does the patch fix it?

> --- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> @@ -97,8 +97,9 @@ int ttm_eu_reserve_buffers(struct ww_acq
>  			   struct list_head *dups, bool del_lru)
[ ... ]

> +			if (locked)
> +				ttm_eu_backoff_reservation_reverse(list, entry);

Hmm, I think the patch is wrong.  As far I know it is the qxl drivers's
job to call ttm_eu_backoff_reservation().  Doing that automatically in
ttm will most likely break other ttm users.

So I guess the call is missing in the qxl driver somewhere, most likely
in some error handling code path given that this bug is a relatively
rare event.

There is only a single ttm_eu_reserve_buffers() call in qxl.
So how about this?

----------------------- cut here --------------------
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 312216caeea2..2f9950fa0b8d 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -262,18 +262,20 @@ int qxl_release_reserve_list(struct qxl_release *release, bool no_intr)
 	ret = ttm_eu_reserve_buffers(&release->ticket, &release->bos,
 				     !no_intr, NULL, true);
 	if (ret)
-		return ret;
+		goto err_backoff;
 
 	list_for_each_entry(entry, &release->bos, tv.head) {
 		struct qxl_bo *bo = to_qxl_bo(entry->tv.bo);
 
 		ret = qxl_release_validate_bo(bo);
-		if (ret) {
-			ttm_eu_backoff_reservation(&release->ticket, &release->bos);
-			return ret;
-		}
+		if (ret)
+			goto err_backoff;
 	}
 	return 0;
+
+err_backoff:
+	ttm_eu_backoff_reservation(&release->ticket, &release->bos);
+	return ret;
 }
 
 void qxl_release_backoff_reserve_list(struct qxl_release *release)
----------------------- cut here --------------------

cheers,
  Gerd

