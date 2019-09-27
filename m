Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E76EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2C6217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="D605eG+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfI0OvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:51:10 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46999 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfI0OvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:51:10 -0400
Received: by mail-yb1-f194.google.com with SMTP id t2so1953477ybo.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=254bSCItV40ra6eS0UsY9jGqBmoWcHXJxb4TfwrjaqA=;
        b=D605eG+9QWlClAVA/6X2ZEXIvGkc1xp4OT0jZEr37ZwCjQSYuaeGGC2oNKyG4p/Jwd
         m3WXlicYPcNXoBvIe2XsjwBUmAqocbxJbkTLdo0foie298qCuLVlcGiADKIaNBHW2lsR
         XUn3bpFWRrrPMgLKWMK7cQ6J3WxOxaBUadk4gSZTNL0boAPbedqu8/ZVXNIsSrr0bmpu
         gX40nCHpB5D/niQj+IvDufIbkKaUAxAyydkt+ZRx61+egA6hC7YnwiXmUz62jolC4JjW
         Bs3P0ynfCdcWvf3cEIBYukegwwJJ6z/+AfdEw51zXeRifqo+nplzPcGSAn6DWSW8/iTV
         ajXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=254bSCItV40ra6eS0UsY9jGqBmoWcHXJxb4TfwrjaqA=;
        b=T9KQN7bp3cZdpGz5HeRaYQs7kFFoTVPvQgwj0SbWzGZPgDG5iHfG0h4Ho+/1sk8KOX
         u4TNVEuzk2sscrlt4locHW6OEBXnVOM7u+YXhGN2NRMCkp6++GJYF7GRI9sG7YQrw8FS
         DJu/BNRjDtTiwj1nSk5I4f+/4qrO+udtND3WaEIoAO33n1ue4rQNtPAJ9jrVgrV6KnqW
         6xGeirzOqNcYr+AI43rt2KfdTE4KnNxPjSBjQqYOx0sZn87OdwM9s/nO5k9UBJrBiedF
         mM64+GKlLWnYn+e0sRB26/UrzLASUDcbxqMz5DP7WJFQfrkObEYPg9mAHk7/HtiGQbEq
         dNLw==
X-Gm-Message-State: APjAAAWxy7nHbc8mENM5jpQLLn+eM0b7rDA+wpZMuH4inyzcREe2TxeL
        uVSHvERkPMOlNd4+skqQ1ovGgQ==
X-Google-Smtp-Source: APXvYqy2x7JoHPja/00RW0Ab6QxJZgs6UJvklVuDVMwi4RwrPo4OIV1uJ34A8irGBcN+Agzqk9jG0Q==
X-Received: by 2002:a25:a3c6:: with SMTP id e64mr5898524ybi.179.1569595868226;
        Fri, 27 Sep 2019 07:51:08 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id v63sm625921ywd.100.2019.09.27.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 07:51:07 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:51:07 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 27/27] drm/dp_mst: Add topology ref history tracking
 for debugging
Message-ID: <20190927145107.GT218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-28-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-28-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:46:05PM -0400, Lyude Paul wrote:
> For very subtle mistakes with topology refs, it can be rather difficult
> to trace them down with the debugging info that we already have. I had
> one such issue recently while trying to implement suspend/resume
> reprobing for MST, and ended up coming up with this.
> 
> Inspired by Chris Wilson's wakeref tracking for i915, this adds a very
> similar feature to the DP MST helpers, which allows for partial tracking
> of topology refs for both ports and branch devices. This is a lot less
> advanced then wakeref tracking: we merely keep a count of all of the
> spots where a topology ref has been grabbed or dropped, then dump out
> that history in chronological order when a port or branch device's
> topology refcount reaches 0. So far, I've found this incredibly useful
> for debugging topology refcount errors.
> 
> Since this has the potential to be somewhat slow and loud, we add an
> expert kernel config option to enable or disable this feature,
> CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS.
> 

Looks very useful indeed! 

My only nit is that we could probably grow the list a little more aggressively
(or start it off at some size > 1) and avoid a bunch of reallocs. That said,
I'm not sure how often it's reallocated so it might not be an issue. Either
way, 

Reviewed-by: Sean Paul <sean@poorly.run>


> Changes since v1:
> * Don't forget to destroy topology_ref_history_lock
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/Kconfig               |  14 ++
>  drivers/gpu/drm/drm_dp_mst_topology.c | 233 +++++++++++++++++++++++++-
>  include/drm/drm_dp_mst_helper.h       |  45 +++++
>  3 files changed, 288 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index e67c194c2aca..44fc2c2a6e2c 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -93,6 +93,20 @@ config DRM_KMS_FB_HELPER
>  	help
>  	  FBDEV helpers for KMS drivers.
>  
> +config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
> +        bool "Enable refcount backtrace history in the DP MST helpers"
> +        select STACKDEPOT
> +        depends on DRM_KMS_HELPER
> +        depends on DEBUG_KERNEL
> +        depends on EXPERT
> +        help
> +          Enables debug tracing for topology refs in DRM's DP MST helpers. A
> +          history of each topology reference/dereference will be printed to the
> +          kernel log once a port or branch device's topology refcount reaches 0.
> +
> +          This has the potential to use a lot of memory and print some very
> +          large kernel messages. If in doubt, say "N".
> +
>  config DRM_FBDEV_EMULATION
>  	bool "Enable legacy fbdev support for your modesetting driver"
>  	depends on DRM
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 5b5c0b3b3c0e..18f9a02927d9 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -28,6 +28,13 @@
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
>  
> +#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
> +#include <linux/stackdepot.h>
> +#include <linux/sort.h>
> +#include <linux/timekeeping.h>
> +#include <linux/math64.h>
> +#endif
> +
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_dp_mst_helper.h>
> @@ -1405,12 +1412,189 @@ drm_dp_mst_put_port_malloc(struct drm_dp_mst_port *port)
>  }
>  EXPORT_SYMBOL(drm_dp_mst_put_port_malloc);
>  
> +#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
> +
> +#define STACK_DEPTH 8
> +
> +static noinline void
> +__topology_ref_save(struct drm_dp_mst_topology_mgr *mgr,
> +		    struct drm_dp_mst_topology_ref_history *history,
> +		    enum drm_dp_mst_topology_ref_type type)
> +{
> +	struct drm_dp_mst_topology_ref_entry *entry = NULL;
> +	depot_stack_handle_t backtrace;
> +	ulong stack_entries[STACK_DEPTH];
> +	uint n;
> +	int i;
> +
> +	n = stack_trace_save(stack_entries, ARRAY_SIZE(stack_entries), 1);
> +	backtrace = stack_depot_save(stack_entries, n, GFP_KERNEL);
> +	if (!backtrace)
> +		goto fail_alloc;
> +
> +	/* Try to find an existing entry for this backtrace */
> +	for (i = 0; i < history->len; i++) {
> +		if (history->entries[i].backtrace == backtrace) {
> +			entry = &history->entries[i];
> +			break;
> +		}
> +	}
> +
> +	/* Otherwise add one */
> +	if (!entry) {
> +		struct drm_dp_mst_topology_ref_entry *new;
> +		int new_len = history->len + 1;
> +
> +		new = krealloc(history->entries, sizeof(*new) * new_len,
> +			       GFP_KERNEL);
> +		if (!new)
> +			goto fail_alloc;
> +
> +		entry = &new[history->len];
> +		history->len = new_len;
> +		history->entries = new;
> +
> +		entry->backtrace = backtrace;
> +		entry->type = type;
> +		entry->count = 0;
> +	}
> +	entry->count++;
> +	entry->ts_nsec = ktime_get_ns();
> +
> +	return;
> +fail_alloc:
> +	DRM_WARN_ONCE("Failed to allocate memory for topology refcount backtrace\n");
> +}
> +
> +static int
> +topology_ref_history_cmp(const void *a, const void *b)
> +{
> +	const struct drm_dp_mst_topology_ref_entry *entry_a = a, *entry_b = b;
> +
> +	if (entry_a->ts_nsec > entry_b->ts_nsec)
> +		return 1;
> +	else if (entry_a->ts_nsec < entry_b->ts_nsec)
> +		return -1;
> +	else
> +		return 0;
> +}
> +
> +static inline const char *
> +topology_ref_type_to_str(enum drm_dp_mst_topology_ref_type type)
> +{
> +	if (type == DRM_DP_MST_TOPOLOGY_REF_GET)
> +		return "get";
> +	else
> +		return "put";
> +}
> +
> +static void
> +__dump_topology_ref_history(struct drm_dp_mst_topology_ref_history *history,
> +			    void *ptr, const char *type_str)
> +{
> +	struct drm_printer p = drm_debug_printer(DBG_PREFIX);
> +	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	int i;
> +
> +	if (!buf)
> +		return;
> +
> +	if (!history->len)
> +		goto out;
> +
> +	/* First, sort the list so that it goes from oldest to newest
> +	 * reference entry
> +	 */
> +	sort(history->entries, history->len, sizeof(*history->entries),
> +	     topology_ref_history_cmp, NULL);
> +
> +	drm_printf(&p,
> +		   "%s (%p/%px) topology count reached 0, dumping history:\n",
> +		   type_str, ptr, ptr);
> +
> +	for (i = 0; i < history->len; i++) {
> +		const struct drm_dp_mst_topology_ref_entry *entry =
> +			&history->entries[i];
> +		ulong *entries;
> +		uint nr_entries;
> +		u64 ts_nsec = entry->ts_nsec;
> +		u64 rem_nsec = do_div(ts_nsec, 1000000000);
> +
> +		nr_entries = stack_depot_fetch(entry->backtrace, &entries);
> +		stack_trace_snprint(buf, PAGE_SIZE, entries, nr_entries, 4);
> +
> +		drm_printf(&p, "  %d %ss (last at %5llu.%06llu):\n%s",
> +			   entry->count,
> +			   topology_ref_type_to_str(entry->type),
> +			   ts_nsec, rem_nsec / 1000, buf);
> +	}
> +
> +	/* Now free the history, since this is the only time we expose it */
> +	kfree(history->entries);
> +out:
> +	kfree(buf);
> +}
> +
> +static __always_inline void
> +drm_dp_mst_dump_mstb_topology_history(struct drm_dp_mst_branch *mstb)
> +{
> +	__dump_topology_ref_history(&mstb->topology_ref_history, mstb,
> +				    "MSTB");
> +}
> +
> +static __always_inline void
> +drm_dp_mst_dump_port_topology_history(struct drm_dp_mst_port *port)
> +{
> +	__dump_topology_ref_history(&port->topology_ref_history, port,
> +				    "Port");
> +}
> +
> +static __always_inline void
> +save_mstb_topology_ref(struct drm_dp_mst_branch *mstb,
> +		       enum drm_dp_mst_topology_ref_type type)
> +{
> +	__topology_ref_save(mstb->mgr, &mstb->topology_ref_history, type);
> +}
> +
> +static __always_inline void
> +save_port_topology_ref(struct drm_dp_mst_port *port,
> +		       enum drm_dp_mst_topology_ref_type type)
> +{
> +	__topology_ref_save(port->mgr, &port->topology_ref_history, type);
> +}
> +
> +static inline void
> +topology_ref_history_lock(struct drm_dp_mst_topology_mgr *mgr)
> +{
> +	mutex_lock(&mgr->topology_ref_history_lock);
> +}
> +
> +static inline void
> +topology_ref_history_unlock(struct drm_dp_mst_topology_mgr *mgr)
> +{
> +	mutex_unlock(&mgr->topology_ref_history_lock);
> +}
> +#else
> +static inline void
> +topology_ref_history_lock(struct drm_dp_mst_topology_mgr *mgr) {}
> +static inline void
> +topology_ref_history_unlock(struct drm_dp_mst_topology_mgr *mgr) {}
> +static inline void
> +drm_dp_mst_dump_mstb_topology_history(struct drm_dp_mst_branch *mstb) {}
> +static inline void
> +drm_dp_mst_dump_port_topology_history(struct drm_dp_mst_port *port) {}
> +#define save_mstb_topology_ref(mstb, type)
> +#define save_port_topology_ref(port, type)
> +#endif
> +
>  static void drm_dp_destroy_mst_branch_device(struct kref *kref)
>  {
>  	struct drm_dp_mst_branch *mstb =
>  		container_of(kref, struct drm_dp_mst_branch, topology_kref);
>  	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
>  
> +	drm_dp_mst_dump_mstb_topology_history(mstb);
> +
>  	INIT_LIST_HEAD(&mstb->destroy_next);
>  
>  	/*
> @@ -1448,11 +1632,18 @@ static void drm_dp_destroy_mst_branch_device(struct kref *kref)
>  static int __must_check
>  drm_dp_mst_topology_try_get_mstb(struct drm_dp_mst_branch *mstb)
>  {
> -	int ret = kref_get_unless_zero(&mstb->topology_kref);
> +	int ret;
>  
> -	if (ret)
> +	topology_ref_history_lock(mstb->mgr);
> +	ret = kref_get_unless_zero(&mstb->topology_kref);
> +
> +	if (ret) {
>  		DRM_DEBUG("mstb %p/%px (%d)\n",
>  			  mstb, mstb, kref_read(&mstb->topology_kref));
> +		save_mstb_topology_ref(mstb, DRM_DP_MST_TOPOLOGY_REF_GET);
> +	}
> +
> +	topology_ref_history_unlock(mstb->mgr);
>  
>  	return ret;
>  }
> @@ -1473,10 +1664,15 @@ drm_dp_mst_topology_try_get_mstb(struct drm_dp_mst_branch *mstb)
>   */
>  static void drm_dp_mst_topology_get_mstb(struct drm_dp_mst_branch *mstb)
>  {
> +	topology_ref_history_lock(mstb->mgr);
> +
> +	save_mstb_topology_ref(mstb, DRM_DP_MST_TOPOLOGY_REF_GET);
>  	WARN_ON(kref_read(&mstb->topology_kref) == 0);
>  	kref_get(&mstb->topology_kref);
>  	DRM_DEBUG("mstb %p/%px (%d)\n",
>  		  mstb, mstb, kref_read(&mstb->topology_kref));
> +
> +	topology_ref_history_unlock(mstb->mgr);
>  }
>  
>  /**
> @@ -1494,9 +1690,14 @@ static void drm_dp_mst_topology_get_mstb(struct drm_dp_mst_branch *mstb)
>  static void
>  drm_dp_mst_topology_put_mstb(struct drm_dp_mst_branch *mstb)
>  {
> +	topology_ref_history_lock(mstb->mgr);
> +
>  	DRM_DEBUG("mstb %p/%px (%d)\n",
>  		  mstb, mstb, kref_read(&mstb->topology_kref) - 1);
> +	save_mstb_topology_ref(mstb, DRM_DP_MST_TOPOLOGY_REF_PUT);
>  	kref_put(&mstb->topology_kref, drm_dp_destroy_mst_branch_device);
> +
> +	topology_ref_history_unlock(mstb->mgr);
>  }
>  
>  static void drm_dp_destroy_port(struct kref *kref)
> @@ -1505,6 +1706,8 @@ static void drm_dp_destroy_port(struct kref *kref)
>  		container_of(kref, struct drm_dp_mst_port, topology_kref);
>  	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
>  
> +	drm_dp_mst_dump_port_topology_history(port);
> +
>  	/* There's nothing that needs locking to destroy an input port yet */
>  	if (port->input) {
>  		drm_dp_mst_put_port_malloc(port);
> @@ -1548,12 +1751,18 @@ static void drm_dp_destroy_port(struct kref *kref)
>  static int __must_check
>  drm_dp_mst_topology_try_get_port(struct drm_dp_mst_port *port)
>  {
> -	int ret = kref_get_unless_zero(&port->topology_kref);
> +	int ret;
> +
> +	topology_ref_history_lock(port->mgr);
> +	ret = kref_get_unless_zero(&port->topology_kref);
>  
> -	if (ret)
> +	if (ret) {
>  		DRM_DEBUG("port %p/%px (%d)\n",
>  			  port, port, kref_read(&port->topology_kref));
> +		save_port_topology_ref(port, DRM_DP_MST_TOPOLOGY_REF_GET);
> +	}
>  
> +	topology_ref_history_unlock(port->mgr);
>  	return ret;
>  }
>  
> @@ -1572,10 +1781,15 @@ drm_dp_mst_topology_try_get_port(struct drm_dp_mst_port *port)
>   */
>  static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
>  {
> +	topology_ref_history_lock(port->mgr);
> +
>  	WARN_ON(kref_read(&port->topology_kref) == 0);
>  	kref_get(&port->topology_kref);
>  	DRM_DEBUG("port %p/%px (%d)\n",
>  		  port, port, kref_read(&port->topology_kref));
> +	save_port_topology_ref(port, DRM_DP_MST_TOPOLOGY_REF_GET);
> +
> +	topology_ref_history_unlock(port->mgr);
>  }
>  
>  /**
> @@ -1591,9 +1805,14 @@ static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
>   */
>  static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
>  {
> +	topology_ref_history_lock(port->mgr);
> +
>  	DRM_DEBUG("port %p/%px (%d)\n",
>  		  port, port, kref_read(&port->topology_kref) - 1);
> +	save_port_topology_ref(port, DRM_DP_MST_TOPOLOGY_REF_PUT);
>  	kref_put(&port->topology_kref, drm_dp_destroy_port);
> +
> +	topology_ref_history_unlock(port->mgr);
>  }
>  
>  static struct drm_dp_mst_branch *
> @@ -4548,6 +4767,9 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>  	mutex_init(&mgr->payload_lock);
>  	mutex_init(&mgr->delayed_destroy_lock);
>  	mutex_init(&mgr->up_req_lock);
> +#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
> +	mutex_init(&mgr->topology_ref_history_lock);
> +#endif
>  	INIT_LIST_HEAD(&mgr->tx_msg_downq);
>  	INIT_LIST_HEAD(&mgr->destroy_port_list);
>  	INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
> @@ -4613,6 +4835,9 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr)
>  	mutex_destroy(&mgr->qlock);
>  	mutex_destroy(&mgr->lock);
>  	mutex_destroy(&mgr->up_req_lock);
> +#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
> +	mutex_destroy(&mgr->topology_ref_history_lock);
> +#endif
>  }
>  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_destroy);
>  
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 1bdee5ee6dcd..75b8fba6f399 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -26,6 +26,26 @@
>  #include <drm/drm_dp_helper.h>
>  #include <drm/drm_atomic.h>
>  
> +#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
> +#include <linux/stackdepot.h>
> +#include <linux/timekeeping.h>
> +
> +enum drm_dp_mst_topology_ref_type {
> +	DRM_DP_MST_TOPOLOGY_REF_GET,
> +	DRM_DP_MST_TOPOLOGY_REF_PUT,
> +};
> +
> +struct drm_dp_mst_topology_ref_history {
> +	struct drm_dp_mst_topology_ref_entry {
> +		enum drm_dp_mst_topology_ref_type type;
> +		int count;
> +		ktime_t ts_nsec;
> +		depot_stack_handle_t backtrace;
> +	} *entries;
> +	int len;
> +};
> +#endif /* IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS) */
> +
>  struct drm_dp_mst_branch;
>  
>  /**
> @@ -92,6 +112,14 @@ struct drm_dp_mst_port {
>  	 */
>  	struct kref malloc_kref;
>  
> +#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
> +	/**
> +	 * @topology_ref_history: A history of each topology
> +	 * reference/dereference. See CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS.
> +	 */
> +	struct drm_dp_mst_topology_ref_history topology_ref_history;
> +#endif
> +
>  	u8 port_num;
>  	bool input;
>  	bool mcs;
> @@ -162,6 +190,14 @@ struct drm_dp_mst_branch {
>  	 */
>  	struct kref malloc_kref;
>  
> +#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
> +	/**
> +	 * @topology_ref_history: A history of each topology
> +	 * reference/dereference. See CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS.
> +	 */
> +	struct drm_dp_mst_topology_ref_history topology_ref_history;
> +#endif
> +
>  	/**
>  	 * @destroy_next: linked-list entry used by
>  	 * drm_dp_delayed_destroy_work()
> @@ -630,6 +666,15 @@ struct drm_dp_mst_topology_mgr {
>  	 * transmissions.
>  	 */
>  	struct work_struct up_req_work;
> +
> +#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
> +	/**
> +	 * @topology_ref_history_lock: protects
> +	 * &drm_dp_mst_port.topology_ref_history and
> +	 * &drm_dp_mst_branch.topology_ref_history.
> +	 */
> +	struct mutex topology_ref_history_lock;
> +#endif
>  };
>  
>  int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
