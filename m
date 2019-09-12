Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606AEC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345B8206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfILQgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 12:36:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbfILQgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 12:36:35 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2598859FF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 16:36:34 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 4so214995wmj.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 09:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/owxSmNMWZ2KtO5h9/JWcueELgP8PsnNJ3eJCYm9WZo=;
        b=RM0iQv/8AYgpmQt6DV75uRDL0k1StAS13Xs//blcc5zAHa/vmovPCj/oSsbc1aX0Xl
         IbPd2N2sx7IorSx7DEiYStTGca1a62jQ25otJQD27D+kmBxy+EHExu0iGHpJZyJQstvF
         N+cYTX6RMVfO/rkDrCtlACXy/qX/jtAuH/j7dQGLzDt7DmrDNRyEkKD7nAWoNUftfJN5
         gBJke9wq4ShI2ZxlL0HnneeMOGhVtjHILATu8qZYI/PlTCA46c0q87t7Vo65gOTz9ldQ
         d6VnA8JyFmTnEoo6u6q+t8kVmcBhXXgau1qKMteVGvmgytpfqP9uf57gv0ZGX8s3Ex6d
         Qtbw==
X-Gm-Message-State: APjAAAV8fHKd71sD4fsVRQ5UMO3rz7ie6mdlmoY6YGCxILPeIREuwWgd
        I4+d/2flCTztJE8xoISWAv5BQ38lIXHsQCEu7wdJbqbdOKqEYbIoqP1M4hpSsRCPwrXrHSdSBWW
        lMjcVPLQpheZGslVvOkGYO4jn
X-Received: by 2002:adf:f20f:: with SMTP id p15mr30353941wro.17.1568306193653;
        Thu, 12 Sep 2019 09:36:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwhJqoIOeUNv6NTeaJESyJDUJRFK+Rpvo3HCRffX0Rgqnu2KKxCVhPhKUD5QdpNxL9FJv34fA==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr30353921wro.17.1568306193410;
        Thu, 12 Sep 2019 09:36:33 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n14sm59468582wra.75.2019.09.12.09.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 09:36:32 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 1/3] hv_utils: Add the support of hibernation
In-Reply-To: <1568245130-70712-2-git-send-email-decui@microsoft.com>
References: <1568245130-70712-1-git-send-email-decui@microsoft.com> <1568245130-70712-2-git-send-email-decui@microsoft.com>
Date:   Thu, 12 Sep 2019 18:36:32 +0200
Message-ID: <877e6dcvzj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

> On hibernation, Linux can not guarantee the host side utils operations
> still succeed without any issue, so let's simply cancel the work items.
> The host is supposed to retry the operations, if necessary.
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/hv_fcopy.c     |  9 ++++++++-
>  drivers/hv/hv_kvp.c       | 11 +++++++++--
>  drivers/hv/hv_snapshot.c  | 11 +++++++++--
>  drivers/hv/hv_util.c      | 37 ++++++++++++++++++++++++++++++++++++-
>  drivers/hv/hyperv_vmbus.h |  3 +++
>  include/linux/hyperv.h    |  1 +
>  6 files changed, 66 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
> index 7e30ae0..f44df3d 100644
> --- a/drivers/hv/hv_fcopy.c
> +++ b/drivers/hv/hv_fcopy.c
> @@ -345,9 +345,16 @@ int hv_fcopy_init(struct hv_util_service *srv)
>  	return 0;
>  }
>  
> +void hv_fcopy_cancel_work(void)
> +{
> +	cancel_delayed_work_sync(&fcopy_timeout_work);
> +}
> +
>  void hv_fcopy_deinit(void)
>  {
>  	fcopy_transaction.state = HVUTIL_DEVICE_DYING;
> -	cancel_delayed_work_sync(&fcopy_timeout_work);
> +
> +	hv_fcopy_cancel_work();
> +
>  	hvutil_transport_destroy(hvt);
>  }
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index 5054d11..064c384 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -757,11 +757,18 @@ static void kvp_on_reset(void)
>  	return 0;
>  }
>  
> -void hv_kvp_deinit(void)
> +void hv_kvp_cancel_work(void)
>  {
> -	kvp_transaction.state = HVUTIL_DEVICE_DYING;
>  	cancel_delayed_work_sync(&kvp_host_handshake_work);
>  	cancel_delayed_work_sync(&kvp_timeout_work);
>  	cancel_work_sync(&kvp_sendkey_work);
> +}
> +
> +void hv_kvp_deinit(void)
> +{
> +	kvp_transaction.state = HVUTIL_DEVICE_DYING;
> +
> +	hv_kvp_cancel_work();
> +
>  	hvutil_transport_destroy(hvt);
>  }
> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
> index 20ba95b..0eb718a 100644
> --- a/drivers/hv/hv_snapshot.c
> +++ b/drivers/hv/hv_snapshot.c
> @@ -378,10 +378,17 @@ static void vss_on_reset(void)
>  	return 0;
>  }
>  
> -void hv_vss_deinit(void)
> +void hv_vss_cancel_work(void)
>  {
> -	vss_transaction.state = HVUTIL_DEVICE_DYING;
>  	cancel_delayed_work_sync(&vss_timeout_work);
>  	cancel_work_sync(&vss_handle_request_work);
> +}
> +
> +void hv_vss_deinit(void)
> +{
> +	vss_transaction.state = HVUTIL_DEVICE_DYING;
> +
> +	hv_vss_cancel_work();
> +
>  	hvutil_transport_destroy(hvt);
>  }
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index e32681e..039c752 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -81,12 +81,14 @@
>  };
>  
>  static int hv_timesync_init(struct hv_util_service *srv);
> +static void hv_timesync_cancel_work(void);
>  static void hv_timesync_deinit(void);
>  
>  static void timesync_onchannelcallback(void *context);
>  static struct hv_util_service util_timesynch = {
>  	.util_cb = timesync_onchannelcallback,
>  	.util_init = hv_timesync_init,
> +	.util_cancel_work = hv_timesync_cancel_work,
>  	.util_deinit = hv_timesync_deinit,
>  };
>  
> @@ -98,18 +100,21 @@
>  static struct hv_util_service util_kvp = {
>  	.util_cb = hv_kvp_onchannelcallback,
>  	.util_init = hv_kvp_init,
> +	.util_cancel_work = hv_kvp_cancel_work,
>  	.util_deinit = hv_kvp_deinit,
>  };
>  
>  static struct hv_util_service util_vss = {
>  	.util_cb = hv_vss_onchannelcallback,
>  	.util_init = hv_vss_init,
> +	.util_cancel_work = hv_vss_cancel_work,
>  	.util_deinit = hv_vss_deinit,
>  };
>  
>  static struct hv_util_service util_fcopy = {
>  	.util_cb = hv_fcopy_onchannelcallback,
>  	.util_init = hv_fcopy_init,
> +	.util_cancel_work = hv_fcopy_cancel_work,
>  	.util_deinit = hv_fcopy_deinit,
>  };
>  
> @@ -440,6 +445,28 @@ static int util_remove(struct hv_device *dev)
>  	return 0;
>  }
>  
> +static int util_suspend(struct hv_device *dev)
> +{
> +	struct hv_util_service *srv = hv_get_drvdata(dev);
> +
> +	if (srv->util_cancel_work)
> +		srv->util_cancel_work();
> +
> +	vmbus_close(dev->channel);

And what happens if you receive a real reply from userspace after you
close the channel? You've only cancelled timeout work so the driver
will not try to reply by itself but this doesn't mean we won't try to
write to the channel on legitimate replies from daemons.

I think you need to block all userspace requests (hang in kernel until
util_resume()).

While I'm not sure we can't get away without it but I'd suggest we add a
new HVUTIL_SUSPENDED state to the hvutil state machine.

> +
> +	return 0;
> +}
> +
> +static int util_resume(struct hv_device *dev)
> +{
> +	struct hv_util_service *srv = hv_get_drvdata(dev);
> +	int ret;
> +
> +	ret = vmbus_open(dev->channel, 4 * PAGE_SIZE, 4 * PAGE_SIZE,
> +			 NULL, 0, srv->util_cb, dev->channel);
> +	return ret;
> +}
> +
>  static const struct hv_vmbus_device_id id_table[] = {
>  	/* Shutdown guid */
>  	{ HV_SHUTDOWN_GUID,
> @@ -476,6 +503,8 @@ static int util_remove(struct hv_device *dev)
>  	.id_table = id_table,
>  	.probe =  util_probe,
>  	.remove =  util_remove,
> +	.suspend = util_suspend,
> +	.resume =  util_resume,
>  	.driver = {
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
> @@ -545,11 +574,17 @@ static int hv_timesync_init(struct hv_util_service *srv)
>  	return 0;
>  }
>  
> +static void hv_timesync_cancel_work(void)
> +{
> +	cancel_work_sync(&adj_time_work);
> +}
> +
>  static void hv_timesync_deinit(void)
>  {
>  	if (hv_ptp_clock)
>  		ptp_clock_unregister(hv_ptp_clock);
> -	cancel_work_sync(&adj_time_work);
> +
> +	hv_timesync_cancel_work();
>  }
>  
>  static int __init init_hyperv_utils(void)
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index f7a5f56..dc280fa 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -353,14 +353,17 @@ int vmbus_add_channel_kobj(struct hv_device *device_obj,
>  void vmbus_on_msg_dpc(unsigned long data);
>  
>  int hv_kvp_init(struct hv_util_service *srv);
> +void hv_kvp_cancel_work(void);
>  void hv_kvp_deinit(void);
>  void hv_kvp_onchannelcallback(void *context);
>  
>  int hv_vss_init(struct hv_util_service *srv);
> +void hv_vss_cancel_work(void);
>  void hv_vss_deinit(void);
>  void hv_vss_onchannelcallback(void *context);
>  
>  int hv_fcopy_init(struct hv_util_service *srv);
> +void hv_fcopy_cancel_work(void);
>  void hv_fcopy_deinit(void);
>  void hv_fcopy_onchannelcallback(void *context);
>  void vmbus_initiate_unload(bool crash);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index a3aa9e9..b4e2768 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1412,6 +1412,7 @@ struct hv_util_service {
>  	void (*util_cb)(void *);
>  	int (*util_init)(struct hv_util_service *);
>  	void (*util_deinit)(void);
> +	void (*util_cancel_work)(void);
>  };
>  
>  struct vmbuspipe_hdr {

-- 
Vitaly
