Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8370C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A799522CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfHZJTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:19:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41951 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHZJTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:19:14 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id b85cc94dc3460384; Mon, 26 Aug 2019 11:19:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/8] PM/sleep: Replace strncmp with str_has_prefix
Date:   Mon, 26 Aug 2019 11:19:12 +0200
Message-ID: <13649784.SkF4frceZu@kreacher>
In-Reply-To: <20190809071023.17224-1-hslester96@gmail.com>
References: <20190809071023.17224-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 9, 2019 9:10:23 AM CEST Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone because len
> is easy to have typo.
> The example is the hard-coded len has counting error
> or sizeof(const) forgets - 1.
> So we prefer using newly introduced str_has_prefix()
> to substitute such strncmp to make code better.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  kernel/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index bdbd605c4215..5e5f64bb3a43 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -495,7 +495,7 @@ static suspend_state_t decode_state(const char *buf, size_t n)
>  	len = p ? p - buf : n;
>  
>  	/* Check hibernation first. */
> -	if (len == 4 && !strncmp(buf, "disk", len))
> +	if (len == 4 && str_has_prefix(buf, "disk"))
>  		return PM_SUSPEND_MAX;
>  
>  #ifdef CONFIG_SUSPEND
> 

Applied, thanks!




