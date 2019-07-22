Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7F4C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC0621F26
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOevxfIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfGVGtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 02:49:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33940 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfGVGtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:49:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so16907191pfo.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 23:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XCZ14W+TeNVmxVqLLf/TFkx7EazXnv5AaEBQnQvbufc=;
        b=yOevxfIVWjZrcDxO+KBryL00uayyK6HWEH7fkamGPRW5eB8PfPlG0AX5j1ZF2Vhgyv
         unzTjje2CIg6G0LAarzCizFXun4ckE43xyEe/Gx8YK229r5M52rR+810BMQEE+0xzajW
         fi3liTZ2T9yaywVS5zmaPkhcEc5QnUFOgxNjtzgvQeMUgXsOVs+zdi9hqyzrzmNYY9Va
         FElyf0YT1i5bAFawrgYA5WXvxPTmw2KlZEbVpSK81Ja5KxoFcSv0dxaZI7k2UaTfUgph
         6AQSKM8OyUoLdHc66jqWbABtiw9Krswr/JbCR2eiigKO8QzRlRB5S6oifzYUQw5gE6n+
         4TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XCZ14W+TeNVmxVqLLf/TFkx7EazXnv5AaEBQnQvbufc=;
        b=pvwH/lLfhEM2qKrHSmCx6g7s+0UFzPZ6XiATeY8HqaTCO2CGC0CUtkPC9jue4c82DB
         I85yw1UVdQnzD7GVo3ziRTsEgAZYyM1ljrbvBPL0KmnFK243P7rusWdFFJ7y8nTlhfcd
         XI/ABOduI8z15maHyQkcNdQQZbn6RMiU7124pfVNvZCRteYj4emTgsIk767PXX9XlRne
         kpxVj3GqHg0kYzPrUose75YNv3LzP+AWrpZi62MIbduH3w0Usx5NLUMaVh/xtS4WjLGN
         crzbsVLA7Vj15IixD+DdOcJmPoy2X46H3pjn+8Jxwi2JRLwQQcn7nbI8375o5s919OK5
         YLdQ==
X-Gm-Message-State: APjAAAWwqPBWnMrYodManTg93aa3/M0CUzHf0qQhuKHZdC8Z/g6R+uda
        2zQKiK32xXNkL6Ium2TzIsbBNw==
X-Google-Smtp-Source: APXvYqwXRPQKIwxf5nHCeGZNiDbk2PIWyVBx4i1OejCqTFJIDu31MQqpvfOeOo9ngol9gtfFy+E8ng==
X-Received: by 2002:a63:d23:: with SMTP id c35mr69539464pgl.376.1563778164615;
        Sun, 21 Jul 2019 23:49:24 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 35sm40151455pgw.91.2019.07.21.23.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 23:49:23 -0700 (PDT)
Date:   Mon, 22 Jul 2019 12:19:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     rjw@rjwysocki.net, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't set next_freq to
 UINT_MAX"
Message-ID: <20190722064921.qrjslrdnbknd5j7b@vireshk-i7>
References: <1563431200-3042-1-git-send-email-dsmythies@telus.net>
 <20190718102815.utl3hanfc7fpf2i6@vireshk-i7>
 <000001d53d7f$ee306e70$ca914b50$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d53d7f$ee306e70$ca914b50$@net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-19, 08:46, Doug Smythies wrote:
> On 2019.07.18 03:28 Viresh Kumar wrote:
> > On 17-07-19, 23:26, Doug Smythies wrote:
> >> This reverts commit ecd2884291261e3fddbc7651ee11a20d596bb514.
> >> 
> >> The commit caused a regression whereby reducing the maximum
> >> CPU clock frequency is ineffective while busy, and the CPU
> >> clock remains unchanged. Once the system has experienced
> >> some idle time, the new limit is implemented.
> >
> > Can you explain why this patch caused that issue ? I am sorry but I couldn't
> > understand it from your email. How are we trying to reduce the frequency? Is
> > clk_set_rate() getting called with that finally and not working ?
> 
> The patch eliminates the "flag", UNIT_MAX, and it's related comment,
> that was used to indicate if it was a limit change that causes the
> subsequent execution of sugov_update_single.

I think I may have understood the root cause. Please try the patch I just sent
as reply to this thread. Thanks.

-- 
viresh
