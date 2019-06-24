Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604CEC48BE3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38278208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfFXH51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfFXH51 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DF84308FC22;
        Mon, 24 Jun 2019 07:57:22 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4EBE860BF7;
        Mon, 24 Jun 2019 07:57:19 +0000 (UTC)
Date:   Mon, 24 Jun 2019 09:57:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 4/7] perf diff: Use hists to manage basic blocks per
 symbol
Message-ID: <20190624075718.GE5471@krava>
References: <1561041402-29444-1-git-send-email-yao.jin@linux.intel.com>
 <1561041402-29444-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561041402-29444-5-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 24 Jun 2019 07:57:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 10:36:39PM +0800, Jin Yao wrote:

SNIP

> +
> +static void *block_entry_zalloc(size_t size)
> +{
> +	return zalloc(size + sizeof(struct hist_entry));
> +}
> +
> +static void block_entry_free(void *he)
> +{
> +	struct block_info *bi = ((struct hist_entry *)he)->block_info;
> +
> +	block_info__put(bi);
> +	free(he);
> +}
> +
> +struct hist_entry_ops block_entry_ops = {
> +	.new    = block_entry_zalloc,
> +	.free   = block_entry_free,
> +};

hum, so there's already block_hist_ops moving that stuff into 'struct block_hist',
which is great, but why don't we have 'struct block_entry' in here? that would
keep the 'struct block_info'

thanks,
jirka
