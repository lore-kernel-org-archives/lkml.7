Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7E5C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF9E208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560947158;
	bh=xkXkM6pk3D1wt75LNn+sl1QCrk+nTkgt9CiNrQc2iLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IE/YsrlIZ0HP+ZSLD/EtVuVbf+jWOT70mjxYEITWidG7MWvjCbSoa/w8/jC2pM5Yr
	 1wEOLFncgW004jS+kdz32JWwK9Q3aT4l8K+xYEfZQbj2HQ1EfekcAqUN38yPUrMC8T
	 rz17m33RUEMzRhstReEVTfyBnH1FAun7zm9dWHds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfFSMZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:25:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45918 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSMZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:25:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id x21so19024328otq.12;
        Wed, 19 Jun 2019 05:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t636JR0WhKBOeLD0UwHYBIKxLtvPrJCBGRwoWUBCtFY=;
        b=fizbzBOfmYcQZQGreojAqxPK2D3h0RYGNlD6HW4e+a+0+cQzIQY2swEWzrymtXxqrW
         v2q4wTkUmpPjqgeV95riS488ty6kYdNZVpPHA5GOfbbBlnr+9Ao9kUeDQlvu9yJ4OhYf
         lq6R5Vox0iAFY3NmqWz5XgNymj/2+pTqs1h4sdjk9wfH5PAv/6QzLhTYroaNAEBsjc0N
         FEDtoSjwTY28rHeHItDDAoz/B3kNPiKm16jG7lQTCN0wQHHfRmAqI3lQwLGDZSlH88Fi
         xm52lKb0l3whfr07to+yA+JY4I5iszxq80j+jinfXWcgim2CxBZL1o9bY5WCO6BCpAM5
         w0Mg==
X-Gm-Message-State: APjAAAX4pWJSkrelwkFUq5CTfmusGXMpxRQieF3LR5ONmAjs/hqv4B59
        uFTv6wi/Jx3eQtf5gTAi+bSeCVtYJ4RInqpVI6k=
X-Google-Smtp-Source: APXvYqy02yoWKMqt5h/YXcJjrxDjMFc91cJ/bUD9qVVWG6Usl1FN1ytOlSfXptOi2wc94asLYWkrKF21cp3FkaNK5GI=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr45214408oto.118.1560947155377;
 Wed, 19 Jun 2019 05:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560944014.git.viresh.kumar@linaro.org> <4008d21f166accfb28180eb804cb8ebda6da4f4d.1560944014.git.viresh.kumar@linaro.org>
In-Reply-To: <4008d21f166accfb28180eb804cb8ebda6da4f4d.1560944014.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 14:25:44 +0200
Message-ID: <CAJZ5v0iR8oBZ2mM2vdHzTBNcjsHa6QtJmN+Q17Q8ZD-ny3qy3w@mail.gmail.com>
Subject: Re: [PATCH 3/6] cpufreq: Remove the has_target() check from notifier handler
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 1:35 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> cpufreq_notify_transition() is only called for has_target() type driver
> and not for set_policy type, and the check is simply redundant. Remove
> it.

Ah, OK

So this patch removes a check introduced by the previous one. :-)

Please merge them together.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e59194c2c613..41ac701e324f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -359,7 +359,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>                  * which is not equal to what the cpufreq core thinks is
>                  * "old frequency".
>                  */
> -               if (has_target() && policy->cur && policy->cur != freqs->old) {
> +               if (policy->cur && policy->cur != freqs->old) {
>                         pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
>                                  freqs->old, policy->cur);
>                         freqs->old = policy->cur;
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
