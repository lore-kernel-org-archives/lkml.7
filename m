Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A01AC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2ABA21739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj3Mjv+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfLQM1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:27:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46753 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfLQM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:27:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so5579312pgb.13;
        Tue, 17 Dec 2019 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5cjvBrcC+slfYxS6uW+QoTN2ho7iIbuInkeSW4tyMSU=;
        b=Jj3Mjv+l5tg+b4JMXtrVcHDyv17klT6kvLUFYr69U2NHP/LzuJJI9bz8ANuhXFFPXX
         GP5G8QVsJ1tbcPsHPJrv9JoyUldFDhJtYXeN6gAWfvev9/mcpca4HqWEytKPM6/R2RRi
         xf8T3JVe3uEyMOO5WvhPUCFgBHUIRWF5xh8QpIQOwbN2fkKJwSovph8lm9wMLBW/Qug3
         fhadpUvy9bwVUVHHSDxDIxHWfu4UVNJGirBwSDtl/mRg7zvp8/HuZgGTw0F7n5KI3CpH
         kp/80AI3MgxcavnxoEPeFkIwk1nZsoFxiWNookAMOpXz2duyxLaSrFtkVZlufuN4WoNq
         dWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5cjvBrcC+slfYxS6uW+QoTN2ho7iIbuInkeSW4tyMSU=;
        b=GU0FK5Lm68utwVS6WCJoJ7GKuSsSbcZTRYD7b0Zs1ZwQo/G4v087yI48nkUM5bIUXA
         rRGKwSL4bxSOROZOuOZU8k6wLCphkhELw26me1HyUaDltHg6fYYkH7T2ByvQKgh6ITdi
         INC7QbFA1jA6ExdU7/YJUshu0Kkl6wd+dqWdUQfXn/0DG3NdSQYjw3bd856xGvLZf6WE
         Dofxl8kKyvzcy9EHTzCSrni0DHbNAQIvGN89RymhLvIgzLs/w5hPbVUA5HX9drvPH11K
         Ip4iqVueNojwtMU79fJsUmLrPDcwAI1kGYWR6/Qscxe4eqO+VX9b6PbMpP+OWMqRiUtR
         WNFA==
X-Gm-Message-State: APjAAAUrfRs8CUmon7nq0AQNn/U+nmZsqE02zz9097CvUlZyGvv8XTw4
        TH1jFvlWO9g8L1SG4m+hOiGBlr7feXc=
X-Google-Smtp-Source: APXvYqzHhx1UfwmdRXwpJXLRVu5MFJs80dR/bqUVbmDqa6szzo5N6tEAr+Bd0R44rcrKQqFBtx3EZg==
X-Received: by 2002:a62:aa09:: with SMTP id e9mr21866836pff.154.1576585631804;
        Tue, 17 Dec 2019 04:27:11 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.134? ([2402:f000:1:1501:200:5efe:a66f:8b86])
        by smtp.gmail.com with ESMTPSA id c1sm26721075pfa.51.2019.12.17.04.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 04:27:11 -0800 (PST)
Subject: Re: [PATCH] usb: musb: Remove unnecessary check of musb->hcd in
 musb_handle_intr_connect()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     b-liu@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191217095023.6878-1-baijiaju1990@gmail.com>
 <20191217095911.GA2807137@kroah.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <b5c78da3-3d64-c3d5-0820-39747063b572@gmail.com>
Date:   Tue, 17 Dec 2019 20:27:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191217095911.GA2807137@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/17 17:59, Greg KH wrote:
> On Tue, Dec 17, 2019 at 05:50:23PM +0800, Jia-Ju Bai wrote:
>> In musb_handle_intr_connect(), musb->hcd should be non-null,
>> so the check of musb->hcd on line 783 could be dropped.
> Have you verified that this is always the case?  How did you do that?

Ah, so sorry, I misunderstood your last message...
I have not verified it, but I thought you made sure of it from your last 
message, sorry...

In my opinion, adding an if check is safer, as shown in my last patch:
"usb: musb: Fix a possible null-pointer dereference in 
musb_handle_intr_connect()"

I recall that Bin Liu has applied my last patch:
https://patchwork.kernel.org/patch/11283007/

Maybe we can listen to his opinion or other people's opinions?


Best wishes,
Jia-Ju Bai
