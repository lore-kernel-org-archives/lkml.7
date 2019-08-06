Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6719C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D872070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdHnNHPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbfHFP1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:27:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45213 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbfHFP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:27:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so82512953lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lQLK4tb5Z256tMmoTbFqTBvyP3uC/HL9pRxf6y947jw=;
        b=FdHnNHPgfbF3ymARaKBNViWrTvZwfqthjKmU18mLnfuyV9/hU8KwTGKqrCkYC2c7p1
         FaHUji7eK/d9R32k1vK8A2AO5MszIgZKI/LL+SIIqjZBdYHxRuiaiypq8d6blILjN/eG
         mUPaAdM/2GyLRse4P6TgTMZgUtyBgS7EPvbD9jBJnFBrmp3Wm2zlDLZPFT/YdAWUiLIu
         epxK5Z3WYlBq12C8PkBYNAQrxSeao6xujqTFkO6QKX/yc8fYnl7DTX7Cb8ulLJY28MpX
         jVUD+Q/rEbxuatHSv3H4vvehKoI7A9+XvgGciT4BNq9t4/61RKLY1FqqaXg6Yjlmc1c/
         DC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lQLK4tb5Z256tMmoTbFqTBvyP3uC/HL9pRxf6y947jw=;
        b=Rg59uG1tRCDqazRJYujfoWqf4gMviqbhmeVcNHltTs64Yssg6kmDZHxP8Pea5puZxI
         9zPQheTB6FwjMgoYoIVSiulVHKJS7emSc0NSKctkrF83ZBxkEnA8vtpmEJySv5LbUYY4
         eXL/nCStUzwZG2oVq/1YTfaTTVlihPTwp1nRFB3Yf2R6mFN3C/uTK7o1Rj2+K22oSNry
         9E1sF8FW0/AHITkao7majwxADwfSo6immBE1j69JF7XZQzDq4mSVaYXkuCXGWPPYfINC
         hHd2MdzNzdPFTaRMqvy7EWpJByF8ccvGh52wK5S1P3205VS4hcqwr2ET/dPDYywdCefQ
         NV1A==
X-Gm-Message-State: APjAAAWym8Dfy0GctAn7iiArAoydC5tXWkvREBT/1fGeKaw3jyI2bIaV
        NpeuQoDbtHKwo3PiqGKBc1Eg7+Rwddo=
X-Google-Smtp-Source: APXvYqwGDIikezEUCpyF3cWy2FfzA7zvcCQTl5EZtpBbYwgUbe1LZDM7iaW/jgjtceJP6PoArtd7dQ==
X-Received: by 2002:a2e:834e:: with SMTP id l14mr2066083ljh.158.1565105234727;
        Tue, 06 Aug 2019 08:27:14 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e23sm1539179lfn.43.2019.08.06.08.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:27:13 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] Introduce Bandwidth OPPs for interconnects
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
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
References: <20190726231558.175130-1-saravanak@google.com>
 <20190729093545.kvnqxjkyx4nogddk@vireshk-i7>
 <CAGETcx8OBFGgP1-hj717Sk-_N95-kacVsz0yb288n3pej12n1Q@mail.gmail.com>
 <20190730024640.xk27jgdfl2j6ucx7@vireshk-i7>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <b1d2697d-bf72-3476-b9a0-0bf79cec2145@linaro.org>
Date:   Tue, 6 Aug 2019 18:27:09 +0300
MIME-Version: 1.0
In-Reply-To: <20190730024640.xk27jgdfl2j6ucx7@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/19 05:46, Viresh Kumar wrote:
> On 29-07-19, 13:16, Saravana Kannan wrote:
>> Sibi might be working on doing that for the SDM845 CPUfreq driver.
>> Georgi could also change his GPU driver use case to use this BW OPP
>> table and required-opps.
>>
>> The problem is that people don't want to start using this until we
>> decide on the DT representation. So it's like a chicken and egg
>> situation.
> 
> Yeah, I agree to that.
> 
> @Georgi and @Sibi: This is your chance to speak up about the proposal
> from Saravana and if you find anything wrong with them. And specially
> that it is mostly about interconnects here, I would like to have an
> explicit Ack from Georgi on this.
> 
> And if you guys are all okay about this then please at least commit
> that you will convert your stuff based on this in coming days.

Looks fine to me. I am already doing some testing with this patchset.
However, as Stephen already pointed out, we should s/KBps/kBps/.

Thanks,
Georgi
