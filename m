Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0EBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C9820679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8GR5DfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfG3Cqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:46:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46090 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731462AbfG3Cqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:46:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so28235318plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 19:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TIMkP6Sbv3HhH7Pg62xgc50SN2hQat3s6fyOGmFVet4=;
        b=L8GR5DfMRyep5ArrsWvl2jbLj0dmva+GRlpTMBEy28z/3U4kCIKeBfzq/cFSiBzTUq
         WhFNVymIRwcWDQ1d+MP+L6pG65a1cGoWsZQPFjvo6ct+L43Bji6mvXlBS1bQneYXg7cx
         fy+1Mt8/3wqfOeX7J2TAKnyQ35VlrhKD8JpFAba6lteniuBVkgF4ubCMEGl0DZ/8hxjE
         AcnOxEssWV3etZKwaV/WP3qCQ2uzrfUxPFssPd4SdLqohFGIpSgD7oSRd5+RzJ7P/oUp
         9eGmRtDwiQDJsUdu9E6hAg0U25uQ22eAq+YqsUekO+88XtqsfJH7eqal1w1uOJS6LDPz
         A67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TIMkP6Sbv3HhH7Pg62xgc50SN2hQat3s6fyOGmFVet4=;
        b=Smds756yCidFKfl3W03dxVH8aFLUIA0eZGGXrCU4jifyLOUdg8mH3Sj48QDAo4+vDK
         u5GI1VqL5TCywsySbmaII2QPMub++QiWRjh0wNWIeRInU0K4J7OxhKyHYOtzaM4y1HcK
         sWeWMQ0OHbSPJl82iG1Ha6AKfhJsOMVSgfpP1uobAxZOPWWt/8RbprZiZG/ASg7Wc+aX
         Ult06wBPe9aOHXDNeizSlhbp6GbeRJMbS7cqCmDUgNORQ1KUbZ8VxcNxlgJ6ILM7lYeb
         Jh0yoz/PDyYvMxzbkQJD7hMPvt54hUExM6Qj/Cb2E5bu/qu3M1QUeVMga5mEnPbV+fsl
         Iwyg==
X-Gm-Message-State: APjAAAX2uImjDfoniwdWvzFRgzA/KUYPVfgzc8PvxgQhRioYieZhYYHa
        PykhUMbVFaCAM5aBG+ChMIpSew==
X-Google-Smtp-Source: APXvYqzeA9LVcJv5kbvk0OnqoT6oBgmnCofJDcZtwfBTMsDgwL3UumIql4DmQbc9jwe2WS2gmfH5ow==
X-Received: by 2002:a17:902:aa41:: with SMTP id c1mr112285898plr.201.1564454803345;
        Mon, 29 Jul 2019 19:46:43 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id x14sm79932677pfq.158.2019.07.29.19.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 19:46:42 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:16:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Introduce Bandwidth OPPs for interconnects
Message-ID: <20190730024640.xk27jgdfl2j6ucx7@vireshk-i7>
References: <20190726231558.175130-1-saravanak@google.com>
 <20190729093545.kvnqxjkyx4nogddk@vireshk-i7>
 <CAGETcx8OBFGgP1-hj717Sk-_N95-kacVsz0yb288n3pej12n1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8OBFGgP1-hj717Sk-_N95-kacVsz0yb288n3pej12n1Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-07-19, 13:16, Saravana Kannan wrote:
> Sibi might be working on doing that for the SDM845 CPUfreq driver.
> Georgi could also change his GPU driver use case to use this BW OPP
> table and required-opps.
> 
> The problem is that people don't want to start using this until we
> decide on the DT representation. So it's like a chicken and egg
> situation.

Yeah, I agree to that.

@Georgi and @Sibi: This is your chance to speak up about the proposal
from Saravana and if you find anything wrong with them. And specially
that it is mostly about interconnects here, I would like to have an
explicit Ack from Georgi on this.

And if you guys are all okay about this then please at least commit
that you will convert your stuff based on this in coming days.

-- 
viresh
