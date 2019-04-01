Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A3BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C077320857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cP95FCrA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HeXEMYrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfDAPIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:08:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44262 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfDAPIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:08:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C334F6087A; Mon,  1 Apr 2019 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554131317;
        bh=yrb//KgvtDwYMZKuOiYZZ8sqgaDIuPz1wFPpLJdCEQE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cP95FCrAVXcPbaQdhJMxDnL6sjjn01nJrPdJQYMxKsCGUgv9MWtOpQbEy1RYt9LA1
         MKjKpMwH39emUgYPiI0PEI60JxJFpBcDjTAXGRBWgcKgGR/YK9N7coZ38bRNeJreK/
         WC2wyxQp2kDkNlRqGz4xYm/YnMLZCShbZPktkNHE=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40A836047C;
        Mon,  1 Apr 2019 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554131315;
        bh=yrb//KgvtDwYMZKuOiYZZ8sqgaDIuPz1wFPpLJdCEQE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HeXEMYrU3MdYVMzPwGbPw8laV87DHrC3KcT0VGY9yV+lk5/FcaNzklE9KJOPTxjQ0
         0S4z8PcWXeuzCfdP7Ftui5DlJbn087U9cSNhx3wn2gFn1dYubCz9mjekx+aM+xQHQB
         w3iJ4FUF0ZgD9sie9RSQk2YArJmdOW+1AyBTCuk0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40A836047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 1/3] drm/virtio: add missing drm_atomic_helper_shutdown()
 call.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190401140306.28063-1-kraxel@redhat.com>
 <20190401140306.28063-2-kraxel@redhat.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1431a9d8-7a60-079d-57ba-33eea6d30ce2@codeaurora.org>
Date:   Mon, 1 Apr 2019 20:38:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401140306.28063-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please atleast mention here why it is required?

-Mukesh

On 4/1/2019 7:33 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_display.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 653ec7d0bf4d..86843a4d6102 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -385,5 +385,6 @@ void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
>   
>   	for (i = 0 ; i < vgdev->num_scanouts; ++i)
>   		kfree(vgdev->outputs[i].edid);
> +	drm_atomic_helper_shutdown(vgdev->ddev);
>   	drm_mode_config_cleanup(vgdev->ddev);
>   }
