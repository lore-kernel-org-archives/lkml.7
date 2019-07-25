Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14FBC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FEB206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRA93SCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfGYKkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:40:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35422 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbfGYKkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:40:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id p197so34142658lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+UWD3xYaSGOyTzdv6esnqt7Upp+zoX6rMbyHIp+AOY4=;
        b=LRA93SCm5QQuPJ6N6Qfi90MXp6KuO+w3c8jbPxdOZFNgztdWErMFHqN1EcFYyzYdQ0
         sdGMNhKOvpnrS7wxjtdCQ9gS/PLfXOSadeZmRLRHME9HvGUcD322RyALyQz8Nfs9gTGG
         03/kqLr99SEtkpPoneETS/y65I8m7nXrcLzBPWSDVZ3PCFaN4sz9qfW2AUUqHSHcA/+4
         hFH4jiEmQ2Zr/KglfFp1AAzrXuYxAJc6TBJ2ZkdT+6gPezz77i6h2ywYNKzCIFySlgCD
         bTGifd4WQ01KI/JL7q5k7o0MF941I1LgbPdR0NrwaULx/yiFm2IQ/rAX2FbHlcHo8jYk
         a7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+UWD3xYaSGOyTzdv6esnqt7Upp+zoX6rMbyHIp+AOY4=;
        b=OiHd8tFh8e6g6twBd81ZngJpMJ+ZPzzWiPtX6+Bmc8AiPHeeGwCfnnoSjZVjmM38b1
         rHmsm+mnaUIGWxQHSrEwFaHKTyW9bAvAyph4DeEIldHMHSVKMoSHdml3l88qPRFq2+3q
         C3wEssTuSBiQfg//vd0uM6uI9Y6TjoWB3IXbTeTscJcx+TOaUCSeC3bNX7ELpxYPG+EN
         +/iSVW+1LxMPVaKmDJzPHCWSIxQDo4JdsMTsZ+Y1w6hYtwcata8qyxtg8aduN48yxyhh
         eW6D1sR8ZA+9T5T3o8FZmyqgc1nZq8llIeMy12U4zuyLfeZ4YEFtAIFsLczfC6VSj6XO
         v2CA==
X-Gm-Message-State: APjAAAXT9uTLWsqXg20lGl/0XVqBP+JAdZe035gswQqQHQG8W6P0q4xX
        GRdOsPrM+lFWssRajIcN3RjIVw==
X-Google-Smtp-Source: APXvYqzGbt4oOeH84QtqSxX8UF4CG2N1aap1JmO0v04H5OhO70HwR0JJTLr+iTx4GIfqRX7wfRqMZQ==
X-Received: by 2002:ac2:414d:: with SMTP id c13mr2229756lfi.47.1564051234400;
        Thu, 25 Jul 2019 03:40:34 -0700 (PDT)
Received: from centauri (ua-83-226-44-230.bbcust.telenor.se. [83.226.44.230])
        by smtp.gmail.com with ESMTPSA id b17sm9057244ljf.34.2019.07.25.03.40.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:40:33 -0700 (PDT)
Date:   Thu, 25 Jul 2019 12:40:31 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] arm64: dts: qcom: qcs404: Add CPR and populate OPP
 table
Message-ID: <20190725104031.GA21998@centauri>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-12-niklas.cassel@linaro.org>
 <20190710090303.tb5ue3wq6r7ofyev@vireshk-i7>
 <20190715132405.GA5040@centauri>
 <20190716103436.az5rdk6f3yoa3apz@vireshk-i7>
 <20190716105318.GA26592@centauri>
 <20190717044923.ccmebeewbinlslkm@vireshk-i7>
 <20190719154558.GA32518@centauri>
 <20190723015635.rl5a2isjnjn23fzh@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723015635.rl5a2isjnjn23fzh@vireshk-i7>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 07:26:35AM +0530, Viresh Kumar wrote:
> On 19-07-19, 17:45, Niklas Cassel wrote:
> > Hello Viresh,
> > 
> > Could you please have a look at the last two patches here:
> > https://git.linaro.org/people/niklas.cassel/kernel.git/log/?h=cpr-opp-hz
> 
> There is no sane way of providing review comments with a link to the
> git tree :)
> 
> I still had a look and I see that you don't search for max frequency
> but just any OPP that has required-opps set to the level u want. Also,
> can't there be multiple phandles in required-opps in your case ?

For each OPP in the CPR OPP table, we need three things,
opp-level, qcom,fuse-level and opp-hz.
The first two can simply be parsed from the OPP node
itself while iterating the CPR OPP table.
The opp-hz has to be fetched from the CPU OPP table.

Several OPPs might have the same qcom,fuse-level value.
However, they will have unique opp-level values and unique
opp-hz values. Each opp-level has a matching opp-hz.

required-opps is basically a connection between a opp-hz
(CPU OPP table) and and a opp-level (CPR OPP table).

So there will be only one match. No need to search for
max frequency.

I think you are confusing this with something else.
The CPR hardware has to be programmed with the highest
frequency for each qcom,fuse-corner.
This is done here:
https://git.linaro.org/people/niklas.cassel/kernel.git/tree/drivers/power/avs/qcom-cpr.c?h=cpr-full#n1219
by saving the highest frequency for each fuse level
while iterating the OPP table.


There can be only one phandle in the required-opps in my case,
this is one of the reasons why I prefer implementing it in the
CPR driver. If it were to be implemented in OPP core, it probably
has to handle multiple phandles.

> 
> > If you like my proposal then I could send out the first patch (the one to
> > OPP core) as a real patch (with an improved commit message), and
> > incorporate the second patch into my CPR patch series when I send out a V2.
> 
> Send them both in your series only, otherwise the first one is useless
> anyway.

Ok, will do.


Kind regards,
Niklas
