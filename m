Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B87EC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125C2208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406272AbfHILbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:31:18 -0400
Received: from foss.arm.com ([217.140.110.172]:46032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfHILbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:31:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C07901596;
        Fri,  9 Aug 2019 04:31:17 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27C633F575;
        Fri,  9 Aug 2019 04:31:17 -0700 (PDT)
Subject: Re: [PATCH v4 6/8] sched: Replace strncmp with str_has_prefix
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20190809071051.17387-1-hslester96@gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e10b37c6-25fa-e584-b943-07aa32725198@arm.com>
Date:   Fri, 9 Aug 2019 12:31:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809071051.17387-1-hslester96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2019 08:10, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone because len
> is easy to have typo.
> The example is the hard-coded len has counting error
> or sizeof(const) forgets - 1.
> So we prefer using newly introduced str_has_prefix()
> to substitute such strncmp to make code better.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

I tried to have a look at the series as a whole but it's not properly
threaded (or at least doesn't appear as such on lore), which makes it
unnecessarily annoying to review.

Please make sure to use git-send-email, which should properly thread all
patches (IOW make them in-reply-to the cover letter).


Other than that, I stared at it and it seems fine. It's not that helpful
here since I doubt any of these prefixes will change in the near feature,
but hey, why not.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
> Changes in v4:
>   - Eliminate assignments in if conditions.
> 
>  kernel/sched/debug.c     |  6 ++++--
>  kernel/sched/isolation.c | 11 +++++++----
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index f7e4579e746c..a03900523e5d 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -102,10 +102,12 @@ static int sched_feat_set(char *cmp)
>  {
>  	int i;
>  	int neg = 0;
> +	size_t len;
>  
> -	if (strncmp(cmp, "NO_", 3) == 0) {
> +	len = str_has_prefix(cmp, "NO_");
> +	if (len) {
>  		neg = 1;
> -		cmp += 3;
> +		cmp += len;
>  	}
>  
>  	i = match_string(sched_feat_names, __SCHED_FEAT_NR, cmp);
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index ccb28085b114..ea2ead4b1906 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -141,16 +141,19 @@ __setup("nohz_full=", housekeeping_nohz_full_setup);
>  static int __init housekeeping_isolcpus_setup(char *str)
>  {
>  	unsigned int flags = 0;
> +	size_t len;
>  
>  	while (isalpha(*str)) {
> -		if (!strncmp(str, "nohz,", 5)) {
> -			str += 5;
> +		len = str_has_prefix(str, "nohz,");
> +		if (len) {
> +			str += len;
>  			flags |= HK_FLAG_TICK;
>  			continue;
>  		}
>  
> -		if (!strncmp(str, "domain,", 7)) {
> -			str += 7;
> +		len = str_has_prefix(str, "domain,");
> +		if (len) {
> +			str += len;
>  			flags |= HK_FLAG_DOMAIN;
>  			continue;
>  		}
> 
