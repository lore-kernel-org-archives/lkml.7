Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD139C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C75720707
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgAFP4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:56:55 -0500
Received: from foss.arm.com ([217.140.110.172]:45428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgAFP4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:56:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C148331B;
        Mon,  6 Jan 2020 07:56:54 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 523CE3F6C4;
        Mon,  6 Jan 2020 07:56:54 -0800 (PST)
Subject: Re: [PATCH 1/3] firmware: arm_sdei: fix possible deadlock
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1577110975-54782-1-git-send-email-zhangliguang@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <0f122a88-e2e1-2139-1c2d-095f684a5701@arm.com>
Date:   Mon, 6 Jan 2020 15:56:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1577110975-54782-1-git-send-email-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luanshi!

On 23/12/2019 14:22, luanshi wrote:
> From: Liguang Zhang <zhangliguang@linux.alibaba.com>
> 
> We call sdei_reregister_event() with sdei_list_lock held but
> _sdei_event_register() and sdei_event_destroy() also acquires
> sdei_list_lock thus creating A-A deadlock.

Ooer. This was clearly never tested properly!
The hibernate support got plenty of testing, but it must have been with only private
events. Hibernate+SDEI with a side-order of cpuhp is a niche sport.


> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index a479023..b122927 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -651,20 +651,19 @@ static int sdei_reregister_event(struct sdei_event *event)
>  
>  	lockdep_assert_held(&sdei_events_lock);
>  
> -	err = _sdei_event_register(event);
> +	err = sdei_api_event_register(event->event_num,
> +				       sdei_entry_point,
> +				       event->registered,
> +				       SDEI_EVENT_REGISTER_RM_ANY, 0);

I don't like pushing these 'api' calls further out creating more of them...

The root of the problem is the reregister/reenable values are protected by the same lock
as the list, _sdei_event_register() needs to manipulate these, which it can't do from
something that is walking the list.

The list lock is a spin_lock() because the cpuhp callbacks happen too early for taking
mutexes, (fairly sure). Those callbacks don't hit this because they skip shared events.


As the simplest fix for stable, could we add another spin_lock inside struct sdei_event to
independently protect the reregister/renable values? This would always be taken last, and
removes the double-lock.


Was this from inspection, or is there some tool I should be running?!
(my testing obviously missed it)


Thanks,

James
