Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4442DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 18:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFBB21739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 18:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXnWKlni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfK1SIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 13:08:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33562 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfK1SIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 13:08:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so11895052plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 10:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UzTAtRry397ZYhg0O1GlX7oqsC/jtQu5uTWNzYWatZU=;
        b=jXnWKlni3SRaJ0xAUeaz25YOx8dNpgfEHFTumsUre4KFGIegDvD73LK/Co+4NnH3Pa
         XwsKwowB8tclY+zCN2YQgl81i/kJ6ioeHEQUaU83TU/1dFZRhCgSeGkPRhSlipmKoO13
         Ar4ry4Dr3ctbuGK/h+R7DA470yA52KedBnxqfNbxUDN67FNaWNR2BKqgrkW99b9eLTcV
         gJzEQlMWrlDqJbAFfbLmL1BMrp4ujBQrdX4tZqoW5vZ1HxB11hRk7F8qG2gRee28risb
         iYk9B+CRY/ij+HCqvosZJ7/tXDIu86X/PvIkAW71eTfeKZF5U1QRE1D+lcJATCQzRskA
         /eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UzTAtRry397ZYhg0O1GlX7oqsC/jtQu5uTWNzYWatZU=;
        b=gYML5B4p5zlSibfsCn4HIO35ghwUoZg2uXXuyYaUVHDA1OAgQvA5BEPval9meh569a
         KqJmd+DBKuEJQgVq7ymmVKBGhaZbVU3l+kEDs+W2cG3dM3ILlpxA7y+xlSw9CkXrb+E3
         eDiAKvHKUZjZMooWxUkhR/ipuSRDggRoc/gBNM/gjFD35WufaruEIEQidrpfxh+ohV99
         jRV4hMPofgZihgt9fGSIP1IcKXOjL3epiCqfauxVeQ70Zg/buGZGO8nbEV0XXXQ9R6Kv
         ZK2REwNTGfmDn3Ud04nNV1YQFZbASSJpOBwmgh9cR/kDbg2C/bGvu/gyjtCyBPJu1nUq
         8vWg==
X-Gm-Message-State: APjAAAXE13Q8EKA7/yMuAX/cmPS6UuKfgFzR12TuPsphwfsbPIP5vqQ4
        YccPQW8gJ9/awXSktBmY56u1/w==
X-Google-Smtp-Source: APXvYqydcsPPlLQHOKIvBcm1KKunXeHD/OSxHg2CJr144gqJVjvmqFjSW1ftEUXE3tTpAOp8YUdJhA==
X-Received: by 2002:a17:90a:bd8f:: with SMTP id z15mr9369094pjr.54.1574964522806;
        Thu, 28 Nov 2019 10:08:42 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b1sm11323605pfi.74.2019.11.28.10.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 10:08:42 -0800 (PST)
Date:   Thu, 28 Nov 2019 10:08:39 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        okukatla@codeaurora.org, evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] interconnect: Move internal structs into a
 separate file
Message-ID: <20191128180839.GH82109@yoga>
References: <20191128141818.32168-1-georgi.djakov@linaro.org>
 <20191128141818.32168-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128141818.32168-2-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28 Nov 06:18 PST 2019, Georgi Djakov wrote:

> Move the interconnect framework internal structs into a separate file,
> so that it can be included and used by ftrace code. This will allow us
> to expose some more useful information in the traces.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c     | 30 ++-----------------------
>  drivers/interconnect/internal.h | 40 +++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/interconnect/internal.h
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 1b811423020a..f30a326dc7ce 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -19,39 +19,13 @@
>  #include <linux/of.h>
>  #include <linux/overflow.h>
>  
> +#include "internal.h"
> +
>  static DEFINE_IDR(icc_idr);
>  static LIST_HEAD(icc_providers);
>  static DEFINE_MUTEX(icc_lock);
>  static struct dentry *icc_debugfs_dir;
>  
> -/**
> - * struct icc_req - constraints that are attached to each node
> - * @req_node: entry in list of requests for the particular @node
> - * @node: the interconnect node to which this constraint applies
> - * @dev: reference to the device that sets the constraints
> - * @tag: path tag (optional)
> - * @avg_bw: an integer describing the average bandwidth in kBps
> - * @peak_bw: an integer describing the peak bandwidth in kBps
> - */
> -struct icc_req {
> -	struct hlist_node req_node;
> -	struct icc_node *node;
> -	struct device *dev;
> -	u32 tag;
> -	u32 avg_bw;
> -	u32 peak_bw;
> -};
> -
> -/**
> - * struct icc_path - interconnect path structure
> - * @num_nodes: number of hops (nodes)
> - * @reqs: array of the requests applicable to this path of nodes
> - */
> -struct icc_path {
> -	size_t num_nodes;
> -	struct icc_req reqs[];
> -};
> -
>  static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
>  {
>  	if (!n)
> diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
> new file mode 100644
> index 000000000000..5853e8faf223
> --- /dev/null
> +++ b/drivers/interconnect/internal.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Interconnect framework internal structs
> + *
> + * Copyright (c) 2019, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_INTERNAL_H
> +#define __DRIVERS_INTERCONNECT_INTERNAL_H
> +
> +/**
> + * struct icc_req - constraints that are attached to each node
> + * @req_node: entry in list of requests for the particular @node
> + * @node: the interconnect node to which this constraint applies
> + * @dev: reference to the device that sets the constraints
> + * @tag: path tag (optional)
> + * @avg_bw: an integer describing the average bandwidth in kBps
> + * @peak_bw: an integer describing the peak bandwidth in kBps
> + */
> +struct icc_req {
> +	struct hlist_node req_node;
> +	struct icc_node *node;
> +	struct device *dev;
> +	u32 tag;
> +	u32 avg_bw;
> +	u32 peak_bw;
> +};
> +
> +/**
> + * struct icc_path - interconnect path structure
> + * @num_nodes: number of hops (nodes)
> + * @reqs: array of the requests applicable to this path of nodes
> + */
> +struct icc_path {
> +	size_t num_nodes;
> +	struct icc_req reqs[];
> +};
> +
> +#endif
