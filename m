Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D00BC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D29D2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZLtk758R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfDBQOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:14:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45530 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbfDBQOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:14:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id m16so12157380edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1FwBWnVtp2A1UjavE6GDLjjZeFVpOsXxYVw4gzWiuzo=;
        b=ZLtk758R6+fqNBqGlySDep2Y6wKz//X4O3sRTaS2OgUOSA0IqDaRnjG1RnLLlJ5yRN
         qtZ87qs7F35qFa2HWV+RcF4f8kAI6UCvc7BCYdHnGHa7qZnqnfWVwaMOBCCkFd8r+gsh
         9QIV0XYqE35Z1uAIFxpnYAsVxnmwMUIhTqx9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=1FwBWnVtp2A1UjavE6GDLjjZeFVpOsXxYVw4gzWiuzo=;
        b=il5MUNA9yOUD2uC1W0I9AXDSg1CKv+z+AwybDfYeExrbs/66zD5VNhk03cWgDb5DiT
         jMZgA+gg2CUenMX0LTZIcSxaKsJxb/kUnuEi1NETelQKB5wW9iNOUI0vPkAr6aUlsGWc
         hYI4Yf4L90F07rHf0bDOClCkq00F/J0VeZO/cdGNM79H0Xb/+0e7hEXrVjLY6zGAtRjN
         dicn1G2Fh9d2rfL7HlZvTyE69iI9f9n/9umshJQwRmrhvsykGrqLrp3Kzdj0hNDAQtBB
         KYrIxa5Bq6ObRd7PosSkKWQYcrkXhdEySqbbhrOQKC5JMJgs8iA/AREAndgneec2hhWA
         sHIw==
X-Gm-Message-State: APjAAAX6ZjGzayIYBnwn0BFMoRN72sJv5ohygowBAueWZOEAW9RodB32
        oD1TOO3Fg5s/Lddfds4UAZrjRw==
X-Google-Smtp-Source: APXvYqyLX1vOgTPjCKVjyTUPGS2O9zDO0yejogmOVBsYFAQ6G7YEaaj9ndy9tEPUqUwkH2B1lu1PlQ==
X-Received: by 2002:a50:cb4a:: with SMTP id h10mr47180168edi.134.1554221671203;
        Tue, 02 Apr 2019 09:14:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k8sm4114064edr.85.2019.04.02.09.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 09:14:30 -0700 (PDT)
Date:   Tue, 2 Apr 2019 18:14:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Tejun Heo <tj@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC tip/core/rcu 2/4] drivers/gpu/drm: Dynamically
 allocate drm_unplug_srcu
Message-ID: <20190402161428.GM2665@phenom.ffwll.local>
Mail-Followup-To: "Paul E. McKenney" <paulmck@linux.ibm.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Tejun Heo <tj@kernel.org>, dri-devel@lists.freedesktop.org
References: <20190402142816.GA13084@linux.ibm.com>
 <20190402142933.14547-2-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402142933.14547-2-paulmck@linux.ibm.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 07:29:31AM -0700, Paul E. McKenney wrote:
> Having DEFINE_SRCU() or DEFINE_STATIC_SRCU() in a loadable module
> requires that the size of the reserved region be increased, which is not
> something we really want to be doing.  This commit therefore removes
> the DEFINE_STATIC_SRCU() from drivers/gpu/drm/drm_drv.c in favor of
> defining drm_unplug_srcu as a simple srcu_struct, initializing it in
> drm_core_init(), and cleaning it up in drm_core_exit().
> 
> In this particular case, drm_unplug_srcu is statically allocated and thus
> guaranteed to be initially zero.  Unfortunately, cleanup_srcu_struct()
> cannot rely on this in the general case (which includes dynamically
> allocated srcu_struct structures), and therefore cannot tell whether it
> is being called on something that has been passed to init_srcu_struct().
> Thus the code added to drm_core_init() is a bit non-standard.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: <dri-devel@lists.freedesktop.org>

Seems reasonable (but I don't have the full patch series as context).

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Any preferences as to how this should be merged? Upfront ack for merging
through rcu trees if that helps you.
-Daniel
> ---
>  drivers/gpu/drm/drm_drv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 381581b01d48..ce4582af814d 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -77,7 +77,7 @@ static bool drm_core_init_complete = false;
>  
>  static struct dentry *drm_debugfs_root;
>  
> -DEFINE_STATIC_SRCU(drm_unplug_srcu);
> +static struct srcu_struct drm_unplug_srcu;
>  
>  /*
>   * DRM Minors
> @@ -958,12 +958,18 @@ static void drm_core_exit(void)
>  	drm_sysfs_destroy();
>  	idr_destroy(&drm_minors_idr);
>  	drm_connector_ida_destroy();
> +	cleanup_srcu_struct(&drm_unplug_srcu);
>  }
>  
>  static int __init drm_core_init(void)
>  {
>  	int ret;
>  
> +	ret = init_srcu_struct(&drm_unplug_srcu);
> +	if (ret) {
> +		DRM_ERROR("Cannot create DRM class: %d\n", ret);
> +		return ret; /* cannot cleanup after failed srcu_struct init. */
> +	}
>  	drm_connector_ida_init();
>  	idr_init(&drm_minors_idr);
>  
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
