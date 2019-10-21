Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE6DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009292084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQVWXTnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfJUCP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:15:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36014 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfJUCP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:15:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so7407023pfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 19:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K7Q4LZifGL7VHvZw/Cjerl4FYJxwkVtMy+33DYa6tmU=;
        b=jQVWXTnbLFCmmP1dE9F9kegEBWgp/9HIGqCxhdYO10WPo85dD8zOiecS2ZMt0ynGYS
         3PmBtO5nvq49dWEJOlBWkq5C3jN1/3o93F547Cg6ta5nDjIzic6Hr95jAA3TYfmi5p4E
         +apQjSARDiGALO4Ktig2vugQ5BTCoZmDXA2gU6qTmwzAveZKBPZzsXc/l1sS97zqQ5j8
         Yy9R1JEe57xqjY7ekFZbdWaeRLP0rSDXKRZnX//XcGQArgFzCM8GyLVDPzcRF2sndFWP
         tGX2ifR1s1zeBVGNGoTPYIar/wucytN+ZI1relNUQr+xDWeCAyZFKtSTresLaDVVoCMd
         3RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K7Q4LZifGL7VHvZw/Cjerl4FYJxwkVtMy+33DYa6tmU=;
        b=I4swOC+Elp1q9WAF7oSfhSwUN2rB4UznKUuqasbR1A7x4QLWpqrCs5aF9vQQnSdWng
         HUG+1XfJuuUsdZsUCMm5YFcwK9V90NpbtDto2m5KuIJx5cvkG4TWU0zczmhnZoZTML8r
         eZjXwZHtNgcDfplP2aoZ7LO3EL0tYNORyrJz9z9zJOKsgfd1wXJ8nCzZ1jGjcMJdkR7q
         rOKNjxJHwxnKVkZfo6GaPXtKiyXh+euAamgUi1ZAaBAl0wiwXP6PVq9Bol7to7IAdhFk
         hvL12EX4qcdBW74cRVQk6xIWpBF4N8pwJN0pvDpHybg1nKm/DMsZsi1LzBilFPwikNNK
         iGGQ==
X-Gm-Message-State: APjAAAW96Yt1MRrSmf6T8kBRUKETurwnKlBlUjEZj/LDZ+V4VYikfZnO
        RPk8wpSzefvIESlZD6oqV5sArA==
X-Google-Smtp-Source: APXvYqzelopchHc5kd7KDiVDWvBUvBXKfv2ziRjbolBOmcK/p4njnjkRPIHp6rGh8Xa6eQ1PQTSMTw==
X-Received: by 2002:a17:90a:fb85:: with SMTP id cp5mr25789957pjb.19.1571624155496;
        Sun, 20 Oct 2019 19:15:55 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id p189sm14070465pfp.163.2019.10.20.19.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:15:53 -0700 (PDT)
Date:   Mon, 21 Oct 2019 07:45:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
Message-ID: <20191021021551.bjhf74zeyuqcl4w3@vireshk-i7>
References: <20191017163503.30791-1-sudeep.holla@arm.com>
 <20191018060247.g5asfuh3kncoj7kl@vireshk-i7>
 <20191018101924.GA25540@bogus>
 <4881906.zjS51fuFuv@kreacher>
 <20191018110632.GB25540@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018110632.GB25540@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19, 12:06, Sudeep Holla wrote:
> Callstack is:
> 
> (cpufreq_notifier_max)
> (notifier_call_chain)
> (blocking_notifier_call_chain)
> (pm_qos_update_target)
> (freq_qos_apply)
> (freq_qos_remove_request)
> (cpufreq_policy_free)
> (subsys_interface_unregister)
> (cpufreq_unregister_driver)

@sudeep: I see that the patch is merged now, but as I said earlier the
reasoning isn't clear yet. Please don't stop working on this and lets
clean this once and for all.

What patches were you testing this with? My buggy patches or Rafael's
patches as well ? At least with my patches, this can happen due to the
other bug where the notifier doesn't get removed (as I said earlier),
but once that bug isn't there then this shouldn't happen, else we have
another bug in pipeline somewhere and should find it.

-- 
viresh
