Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FA320663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfCDOtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:49:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfCDOtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:49:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8181A30EBE76;
        Mon,  4 Mar 2019 14:49:06 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2B0875D96F;
        Mon,  4 Mar 2019 14:49:05 +0000 (UTC)
Date:   Mon, 4 Mar 2019 15:49:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 04/11] perf tools report: Parse time quantum
Message-ID: <20190304144904.GM30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-5-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-5-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 04 Mar 2019 14:49:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:43AM -0800, Andi Kleen wrote:

SNIP

> +static int
> +parse_time_quantum(const struct option *opt, const char *arg,
> +		   int unset __maybe_unused)
> +{
> +	unsigned long *time_q = opt->value;
> +	char *end;
> +
> +	*time_q = strtoul(arg, &end, 0);
> +	if (end == arg)
> +		goto parse_err;
> +	if (*time_q == 0) {
> +		pr_err("time quantum cannot be 0");
> +		return -1;
> +	}
> +	while (isspace(*end))
> +		end++;
> +	if (*end == 0)
> +		return 0;
> +	if (!strcmp(end, "s")) {
> +		*time_q *= 1000000000;
> +		return 0;
> +	}
> +	if (!strcmp(end, "ms")) {
> +		*time_q *= 1000000;
> +		return 0;
> +	}
> +	if (!strcmp(end, "us")) {
> +		*time_q *= 1000;
> +		return 0;
> +	}
> +	if (!strcmp(end, "ns"))
> +		return 0;
> +parse_err:
> +	pr_err("Cannot parse time quantum `%s'\n", arg);
> +	return -1;
> +}
> +
>  int
>  report_parse_ignore_callees_opt(const struct option *opt __maybe_unused,
>  				const char *arg, int unset __maybe_unused)
> @@ -1148,6 +1186,9 @@ int cmd_report(int argc, const char **argv)
>  		     "Set percent type local/global-period/hits",
>  		     annotate_parse_percent_type),
>  	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs, "Show times in nanosecs"),
> +	OPT_CALLBACK(0, "time-quantum", &symbol_conf.time_quantum, "time (ms|us|ns)",

missing 's' unit in ()

jirka
