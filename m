Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1BEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E634223D1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URpWrUxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfKTJjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:39:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38359 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfKTJiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:38:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so13950189pfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 01:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JKn/ypHBJEQaLSoXlZSCwq2PzKzgmEP1tdAmz9/2rE8=;
        b=URpWrUxARABgIbO1nebn1hxneaIAyiBzMBbyjmZPF8gcmlp+hlXB6sT+7CuuYn5uXj
         9xgpmClXkG6HXoru5zSAj9wUf+nQoEY8D2NBbjfRCJ1ookRgYKsQz5zf2CRX1PQVEvDD
         BIKsAgdjhgKoOnZHs/eLzHmRbi4WHPIPuygGnoKSF5E0cXFHgXTO1Y7zP8JjMEsFEBIW
         NMYHMgGknk73rZXI//caJKGrfmVEz3sNL642VCNQJsPOYvxRwU9ojZ3lFGi0n+SNps/I
         agP0t05TI+OGzJiNcUUnOmMq4OCke9oJ2XCZzAf8y26fy7Ril66S3tbnGV6aGNypi7jd
         8UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JKn/ypHBJEQaLSoXlZSCwq2PzKzgmEP1tdAmz9/2rE8=;
        b=OBk00hJVIXHl5Oiw9P42CprBs/ECCbdTQqYfAJg2PFoL2VeodmpHHWR51dvuZaGesN
         Pz5v7JhA/QuzYcpfUNtmDfqL7dA9DrSeA2bpHnbMxkwu4uhjBC+rqq2f6Usb1+HPWTRF
         eeajJE7MqL2Bx4wExPzR4OFlU2Kb6qfBkGKfpgMvnaz6szmVT9p2uTqumfMKzfz6/DXC
         OpP0DJ8ek7xxm3qaTSeSRs9Nk4Mbv8w1T51+8zb4KuGdeyaYOmqRu+aswzVKzpExh+cb
         1+Sa8BvbPDpxWk+dAaHO6IXGzE1AHL3E8qAQpGNtV7OypF6xTgP+GP5gRapOZ+Jecw5y
         CrKQ==
X-Gm-Message-State: APjAAAUeqZTYbDxIvaBlsO1uaqid/WulFQKbjGuGzoMP8uV4nNJQj5Mz
        53cOBV5NwsqhBD7SG5fCuS2fcQ==
X-Google-Smtp-Source: APXvYqwgGngAsrnl1Ni7lgI4C9rbWtfZQ6ZApFqsNSwIF7o7TVFDnSi+fJw+CqR95WKruzfgNboVzA==
X-Received: by 2002:a65:5542:: with SMTP id t2mr2155255pgr.74.1574242731587;
        Wed, 20 Nov 2019 01:38:51 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id c1sm6858272pjc.23.2019.11.20.01.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 01:38:50 -0800 (PST)
Date:   Wed, 20 Nov 2019 15:08:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] PM: QoS: Invalidate frequency QoS requests after removal
Message-ID: <20191120093849.u7gelifptikwv632@vireshk-i7>
References: <12409907.uLZWGnKmhe@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12409907.uLZWGnKmhe@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-19, 10:33, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Switching cpufreq drivers (or switching operation modes of the
> intel_pstate driver from "active" to "passive" and vice versa)
> does not work on some x86 systems with ACPI after commit
> 3000ce3c52f8 ("cpufreq: Use per-policy frequency QoS"), because
> the ACPI _PPC and thermal code uses the same frequency QoS request
> object for a given CPU every time a cpufreq driver is registered
> and freq_qos_remove_request() does not invalidate the request after
> removing it from its QoS list, so freq_qos_add_request() complains
> and fails when that request is passed to it again.
> 
> Fix the issue by modifying freq_qos_remove_request() to clear the qos
> and type fields of the frequency request pointed to by its argument
> after removing it from its QoS list so as to invalidate it.
> 
> Fixes: 3000ce3c52f8 ("cpufreq: Use per-policy frequency QoS")
> Reported-and-tested-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/power/qos.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/kernel/power/qos.c
> ===================================================================
> --- linux-pm.orig/kernel/power/qos.c
> +++ linux-pm/kernel/power/qos.c
> @@ -814,6 +814,8 @@ EXPORT_SYMBOL_GPL(freq_qos_update_reques
>   */
>  int freq_qos_remove_request(struct freq_qos_request *req)
>  {
> +	int ret;
> +
>  	if (!req)
>  		return -EINVAL;
>  
> @@ -821,7 +823,11 @@ int freq_qos_remove_request(struct freq_
>  		 "%s() called for unknown object\n", __func__))
>  		return -EINVAL;
>  
> -	return freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> +	ret = freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> +	req->qos = NULL;
> +	req->type = 0;
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(freq_qos_remove_request);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
