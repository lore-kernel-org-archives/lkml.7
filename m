Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34707FA3730
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE34A21848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4IY9lhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408612AbfJQJlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:41:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40015 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408594AbfJQJlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:41:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so1281733pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y42TivkNMfetbxPGlFDe/PapDuIuV8Zv/0BU9JPv/Sw=;
        b=x4IY9lhRWJKpuUcTJmCu4HwELtwtgqIXa/MqsOgleEc4A/1PgUfGyU2PCXBgc4pmWs
         FPYWR7u92W3RSinCOBRUq5MeGtJqWATdgogW4hUe5VMWopjQGoc6MsaylQIqHOoXQTa9
         2IxlG/fLRLQMQuw9xTQKFiRf+F/AB6OoUASmeBlXmHP5I84cU597Kd2ajqncPHGgpzR/
         cPO9p3JavSs3mBZaIpsBXp0F7lldyPKCDuMIUAKxcriR8hW2+7zg76IR81fX1feZaAL8
         sw/Yvv6JW1p8OCiU4vO+BQFAYd8NJfrH3S6DRT3IaW3aHCTJHgMBHmrmpnKqieLgQH/u
         8xJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y42TivkNMfetbxPGlFDe/PapDuIuV8Zv/0BU9JPv/Sw=;
        b=sh6k7U6MPHPQ1Vo27IO+zuDO3INt6YLB7EUPTyUDHYJ25iagrND3/GsTp9OUMQ+JWb
         BMm+o7tMA49VSyQSwwDoH+VY+c4IETvGwCv1YFCQW8O2YjEKPkJIBzPMwqU4EBkJ0T0Q
         Ea7wR37Z41tkUu6HxtRC68KruGd9RBKNnwEdu5td0KIUbbtm/gbMPCqP+dz0FxgSwA4O
         Y2Fvabk/20hLz+cgY4J+77zdbSQmGvnM+N9rCBKn5uJHD/lvcCROw0K5CzO0d4Qwdlk5
         2mfk69HopC5t8Oqglk6s+QMIuuhER1jkwwjE1oU/ud4OkjLGVx77ZnYGm6hHdqmO/TBM
         gy4A==
X-Gm-Message-State: APjAAAVxqlIJyvP+K9jnVWtgoZn5lHxfqIXgFvQK0Ej7VDB1JTYvJx15
        i0GlRT17FRpSApl/bBBviGRobA==
X-Google-Smtp-Source: APXvYqyB8RFSVWz8vGu6//urFkfMwFxB3+cTUymMIqmME0nH8iTOeICrBAJR5KkvNSpjhktRZyuxVA==
X-Received: by 2002:aa7:9715:: with SMTP id a21mr2775707pfg.144.1571305306934;
        Thu, 17 Oct 2019 02:41:46 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id ep10sm14612289pjb.2.2019.10.17.02.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 02:41:45 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:11:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Message-ID: <20191017094143.fhmhgltv6ujccxlp@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <4551555.oysnf1Sd0E@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4551555.oysnf1Sd0E@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-19, 12:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce frequency QoS, based on the "raw" low-level PM QoS, to
> represent min and max frequency requests and aggregate constraints.
> 
> The min and max frequency requests are to be represented by
> struct freq_qos_request objects and the aggregate constraints are to
> be represented by struct freq_constraints objects.  The latter are
> expected to be initialized with the help of freq_constraints_init().
> 
> The freq_qos_read_value() helper is defined to retrieve the aggregate
> constraints values from a given struct freq_constraints object and
> there are the freq_qos_add_request(), freq_qos_update_request() and
> freq_qos_remove_request() helpers to manipulate the min and max
> frequency requests.  It is assumed that the the helpers will not
> run concurrently with each other for the same struct freq_qos_request
> object, so if that may be the case, their uses must ensure proper
> synchronization between them (e.g. through locking).
> 
> In addition, freq_qos_add_notifier() and freq_qos_remove_notifier()
> are provided to add and remove notifiers that will trigger on aggregate
> constraint changes to and from a given struct freq_constraints object,
> respectively.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/pm_qos.h |   44 ++++++++
>  kernel/power/qos.c     |  240 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 284 insertions(+)
> 
> Index: linux-pm/include/linux/pm_qos.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_qos.h
> +++ linux-pm/include/linux/pm_qos.h
> @@ -267,4 +267,48 @@ static inline s32 dev_pm_qos_raw_resume_
>  }
>  #endif
>  
> +#define FREQ_QOS_MIN_DEFAULT_VALUE	0
> +#define FREQ_QOS_MAX_DEFAULT_VALUE	(-1)
> +
> +enum freq_qos_req_type {
> +	FREQ_QOS_MIN = 1,
> +	FREQ_QOS_MAX,
> +};
> +
> +struct freq_constraints {
> +	struct pm_qos_constraints min_freq;
> +	struct blocking_notifier_head min_freq_notifiers;
> +	struct pm_qos_constraints max_freq;
> +	struct blocking_notifier_head max_freq_notifiers;
> +};
> +
> +struct freq_qos_request {
> +	enum freq_qos_req_type type;
> +	struct plist_node pnode;
> +	struct freq_constraints *qos;
> +};
> +
> +static inline int freq_qos_request_active(struct freq_qos_request *req)
> +{
> +	return !IS_ERR_OR_NULL(req->qos);
> +}
> +
> +void freq_constraints_init(struct freq_constraints *qos);
> +
> +s32 freq_qos_read_value(struct freq_constraints *qos,
> +			enum freq_qos_req_type type);
> +
> +int freq_qos_add_request(struct freq_constraints *qos,
> +			 struct freq_qos_request *req,
> +			 enum freq_qos_req_type type, s32 value);
> +int freq_qos_update_request(struct freq_qos_request *req, s32 new_value);
> +int freq_qos_remove_request(struct freq_qos_request *req);
> +
> +int freq_qos_add_notifier(struct freq_constraints *qos,
> +			  enum freq_qos_req_type type,
> +			  struct notifier_block *notifier);
> +int freq_qos_remove_notifier(struct freq_constraints *qos,
> +			     enum freq_qos_req_type type,
> +			     struct notifier_block *notifier);
> +
>  #endif
> Index: linux-pm/kernel/power/qos.c
> ===================================================================
> --- linux-pm.orig/kernel/power/qos.c
> +++ linux-pm/kernel/power/qos.c
> @@ -650,3 +650,243 @@ static int __init pm_qos_power_init(void
>  }
>  
>  late_initcall(pm_qos_power_init);
> +
> +/* Definitions related to the frequency QoS below. */
> +
> +/**
> + * freq_constraints_init - Initialize frequency QoS constraints.
> + * @qos: Frequency QoS constraints to initialize.
> + */
> +void freq_constraints_init(struct freq_constraints *qos)
> +{
> +	struct pm_qos_constraints *c;
> +
> +	c = &qos->min_freq;
> +	plist_head_init(&c->list);
> +	c->target_value = FREQ_QOS_MIN_DEFAULT_VALUE;
> +	c->default_value = FREQ_QOS_MIN_DEFAULT_VALUE;
> +	c->no_constraint_value = FREQ_QOS_MIN_DEFAULT_VALUE;
> +	c->type = PM_QOS_MAX;

should this be MIN ?

> +	c->notifiers = &qos->min_freq_notifiers;
> +	BLOCKING_INIT_NOTIFIER_HEAD(c->notifiers);
> +
> +	c = &qos->max_freq;
> +	plist_head_init(&c->list);
> +	c->target_value = FREQ_QOS_MAX_DEFAULT_VALUE;
> +	c->default_value = FREQ_QOS_MAX_DEFAULT_VALUE;
> +	c->no_constraint_value = FREQ_QOS_MAX_DEFAULT_VALUE;
> +	c->type = PM_QOS_MIN;

and this MAX ?

> +	c->notifiers = &qos->max_freq_notifiers;
> +	BLOCKING_INIT_NOTIFIER_HEAD(c->notifiers);
> +}
> +
> +/**
> + * freq_qos_read_value - Get frequency QoS constraint for a given list.
> + * @qos: Constraints to evaluate.
> + * @type: QoS request type.
> + */
> +s32 freq_qos_read_value(struct freq_constraints *qos,
> +			enum freq_qos_req_type type)
> +{
> +	s32 ret;
> +
> +	switch (type) {
> +	case FREQ_QOS_MIN:
> +		ret = IS_ERR_OR_NULL(qos) ?
> +			FREQ_QOS_MIN_DEFAULT_VALUE :
> +			pm_qos_read_value(&qos->min_freq);
> +		break;
> +	case FREQ_QOS_MAX:
> +		ret = IS_ERR_OR_NULL(qos) ?
> +			FREQ_QOS_MAX_DEFAULT_VALUE :
> +			pm_qos_read_value(&qos->max_freq);
> +		break;
> +	default:
> +		WARN_ON(1);
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * freq_qos_apply - Add/modify/remove frequency QoS request.
> + * @req: Constraint request to apply.
> + * @action: Action to perform (add/update/remove).
> + * @value: Value to assign to the QoS request.
> + */
> +static int freq_qos_apply(struct freq_qos_request *req,
> +			  enum pm_qos_req_action action, s32 value)
> +{
> +	int ret;
> +
> +	switch(req->type) {
> +	case FREQ_QOS_MIN:
> +		ret = pm_qos_update_target(&req->qos->min_freq, &req->pnode,
> +					   action, value);
> +		break;
> +	case FREQ_QOS_MAX:
> +		ret = pm_qos_update_target(&req->qos->max_freq, &req->pnode,
> +					   action, value);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * freq_qos_add_request - Insert new frequency QoS request into a given list.
> + * @qos: Constraints to update.
> + * @req: Preallocated request object.
> + * @type: Request type.
> + * @value: Request value.
> + *
> + * Insert a new entry into the @qos list of requests, recompute the effective
> + * QoS constraint value for that list and initialize the @req object.  The
> + * caller needs to save that object for later use in updates and removal.
> + *
> + * Return 1 if the effective constraint value has changed, 0 if the effective
> + * constraint value has not changed, or a negative error code on failures.
> + */
> +int freq_qos_add_request(struct freq_constraints *qos,
> +			 struct freq_qos_request *req,
> +			 enum freq_qos_req_type type, s32 value)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(qos) || !req)
> +		return -EINVAL;
> +
> +	if (WARN(freq_qos_request_active(req),
> +		 "%s() called for active request\n", __func__))
> +		return -EINVAL;
> +
> +	req->qos = qos;
> +	req->type = type;
> +	ret = freq_qos_apply(req, PM_QOS_ADD_REQ, value);
> +	if (ret < 0) {
> +		req->qos = NULL;
> +		req->type = 0;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(freq_qos_add_request);
> +
> +/**
> + * freq_qos_update_request - Modify existing frequency QoS request.
> + * @req: Request to modify.
> + * @new_value: New request value.
> + *
> + * Update an existing frequency QoS request along with the effective constraint
> + * value for the list of requests it belongs to.
> + *
> + * Return 1 if the effective constraint value has changed, 0 if the effective
> + * constraint value has not changed, or a negative error code on failures.
> + */
> +int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
> +{
> +	if (!req)
> +		return -EINVAL;
> +
> +	if (WARN(!freq_qos_request_active(req),
> +		 "%s() called for unknown object\n", __func__))
> +		return -EINVAL;
> +
> +	if (req->pnode.prio == new_value)
> +		return 0;
> +
> +	return freq_qos_apply(req, PM_QOS_UPDATE_REQ, new_value);
> +}
> +EXPORT_SYMBOL_GPL(freq_qos_update_request);
> +
> +/**
> + * freq_qos_remove_request - Remove frequency QoS request from its list.
> + * @req: Request to remove.
> + *
> + * Remove the given frequency QoS request from the list of constraints it
> + * belongs to and recompute the effective constraint value for that list.
> + *
> + * Return 1 if the effective constraint value has changed, 0 if the effective
> + * constraint value has not changed, or a negative error code on failures.
> + */
> +int freq_qos_remove_request(struct freq_qos_request *req)
> +{
> +	if (!req)
> +		return -EINVAL;
> +
> +	if (WARN(!freq_qos_request_active(req),
> +		 "%s() called for unknown object\n", __func__))
> +		return -EINVAL;
> +
> +	return freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> +}
> +EXPORT_SYMBOL_GPL(freq_qos_remove_request);
> +
> +/**
> + * freq_qos_add_notifier - Add frequency QoS change notifier.
> + * @qos: List of requests to add the notifier to.
> + * @type: Request type.
> + * @notifier: Notifier block to add.
> + */
> +int freq_qos_add_notifier(struct freq_constraints *qos,
> +			  enum freq_qos_req_type type,
> +			  struct notifier_block *notifier)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(qos) || !notifier)
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case FREQ_QOS_MIN:
> +		ret = blocking_notifier_chain_register(qos->min_freq.notifiers,
> +						       notifier);
> +		break;
> +	case FREQ_QOS_MAX:
> +		ret = blocking_notifier_chain_register(qos->max_freq.notifiers,
> +						       notifier);
> +		break;
> +	default:
> +		WARN_ON(1);
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(freq_qos_add_notifier);
> +
> +/**
> + * freq_qos_remove_notifier - Remove frequency QoS change notifier.
> + * @qos: List of requests to remove the notifier from.
> + * @type: Request type.
> + * @notifier: Notifier block to remove.
> + */
> +int freq_qos_remove_notifier(struct freq_constraints *qos,
> +			     enum freq_qos_req_type type,
> +			     struct notifier_block *notifier)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(qos) || !notifier)
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case FREQ_QOS_MIN:
> +		ret = blocking_notifier_chain_unregister(qos->min_freq.notifiers,
> +							 notifier);
> +		break;
> +	case FREQ_QOS_MAX:
> +		ret = blocking_notifier_chain_unregister(qos->max_freq.notifiers,
> +							 notifier);
> +		break;
> +	default:
> +		WARN_ON(1);
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(freq_qos_remove_notifier);
> 
> 

-- 
viresh
