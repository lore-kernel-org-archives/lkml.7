Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73921C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E39720657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCKMca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:32:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfCKMca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:32:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5BE1E88306;
        Mon, 11 Mar 2019 12:32:30 +0000 (UTC)
Received: from krava (ovpn-204-224.brq.redhat.com [10.40.204.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id C229B5DA27;
        Mon, 11 Mar 2019 12:32:28 +0000 (UTC)
Date:   Mon, 11 Mar 2019 13:32:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 11/15] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190311123227.GA26829@krava>
References: <20190309055628.21617-1-andi@firstfloor.org>
 <20190309055628.21617-12-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309055628.21617-12-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 11 Mar 2019 12:32:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 09:56:24PM -0800, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 08e2b3be4c1b..da3a944f42aa 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -445,6 +445,14 @@ static int hist_entry__init(struct hist_entry *he,
>  			return -ENOMEM;
>  		}
>  	}
> +
> +	if (symbol_conf.res_sample) {
> +		he->res_samples = calloc(sizeof(struct res_sample),
> +					symbol_conf.res_sample);
> +		if (!he->res_samples)

you need to free the memory in here, anyway this function
just changed, so please rebase on latest Arnaldo's perf/core

jirka

> +			return -ENOMEM;
> +	}
> +

SNIP
