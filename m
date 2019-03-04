Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C410B20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfCDOsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:48:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfCDOsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:48:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B44CE5945C;
        Mon,  4 Mar 2019 14:48:42 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5B3741001DCD;
        Mon,  4 Mar 2019 14:48:41 +0000 (UTC)
Date:   Mon, 4 Mar 2019 15:48:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 07/11] perf tools report: Support running scripts for
 current time range
Message-ID: <20190304144840.GJ30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-8-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-8-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 04 Mar 2019 14:48:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:46AM -0800, Andi Kleen wrote:

SNIP

> +add_script_opt(struct hist_browser *browser,
> +	       struct popup_action *act, char **optstr,
> +	       struct thread *thread, struct symbol *sym)
> +{
> +	int n, j;
> +	struct hist_entry *he;
> +
> +	n = add_script_opt_2(browser, act, optstr, thread, sym, "");
> +
> +	he = hist_browser__selected_entry(browser);
> +	if (sort_order && strstr(sort_order, "time")) {
> +		char tstr[128];
> +
> +		optstr++;
> +		act++;
> +		j = sprintf(tstr, " in ");
> +		j += timestamp__scnprintf_usec(he->time, tstr + j,
> +					       sizeof tstr - j);
> +		j += sprintf(tstr + j, "-");
> +		timestamp__scnprintf_usec(he->time + symbol_conf.time_quantum,
> +				          tstr + j,
> +				          sizeof tstr - j);

no need to put sizeof on extra line

jirka
