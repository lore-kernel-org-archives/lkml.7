Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58857C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2485821773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SM0gvU5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfDXMPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:15:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37370 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfDXMPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:15:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id h126so3838561lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1BwZFno63wZytLE3xAp+LLjJ3VbyMrFIKeO69px4b/8=;
        b=SM0gvU5XI0ur7wcJDLik+s4+K5IqC4FF6GWc++RcBTnJpAZOMeXI0JLiX0jnlHS7SR
         VEtwA7+RDJAPhuicFR00DMyDnFOGO47u3oMPts2zih+xC56o7yLpVTJ+tKp6rkXtVsev
         8xNrL3gtr+dtpspoRXPuiXkKNEtS1FtVo7ZsdTfe/4zd95efp6pgcS7zJzOe6pu9rz5E
         v7ICLaRm7lNtrha3hFZcuGfVQwe/K4M0AI4lye6T+qyvKdfw/3W35YW7zh2KG2Xj5jD2
         A4bm+fmsOy0rbxLe0ZTl/QlTkKYOXkcLiVasTR5n0xA5JBF5gmAvHay6roFnYpGaEINC
         1pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1BwZFno63wZytLE3xAp+LLjJ3VbyMrFIKeO69px4b/8=;
        b=GxteKoalMaJDy2s/iLq7Vy6N/pPZxIcv86Yqx9CgIB/gw3CqcaxGPw2LmfrJwHOeFj
         /F/vkzgV6zZfqveZi/wUiYrWfOEqHDiEPoh37rSmA17aYT7w91nnit87UzgjnEJGB5uo
         ipQYXfDY+i0hWlaRKFm8NgcLxo4PKp+zyCnIBnV5mydadPPZ8fSQF0Q/q4gXMWx191b+
         QU0ewy3pdY42qH7g0ybTtFaqDc5b4yzhFz4uWvQXNdkfLuGhdBFp5LMcwzpEv/TmbwCY
         k/z4RAWr+Djrg7pRTYF1bjQnZMjTqd2fIaxWfGZwDo++v/sKo5bPFFhyOrwZ7tl7h9St
         dazw==
X-Gm-Message-State: APjAAAWp2L8/4VTnXOddlYWGTNww2cTXASI6QggMik14bkBRdVDVbLlU
        J0WieR2NWETR9GGaNt6c2YOczg==
X-Google-Smtp-Source: APXvYqykqPPNNReAIjNAq+UP8AP4yVdGrunde2oRAdka3qS/4IzoRNbFxe0B14mIAFiPFovgqVlLgw==
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr18132853lfg.133.1556108146855;
        Wed, 24 Apr 2019 05:15:46 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id b14sm3995192ljf.53.2019.04.24.05.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:15:45 -0700 (PDT)
Subject: Re: [PATCH 10/10] venus: dec: make decoder compliant with stateful
 codec API
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-11-stanimir.varbanov@linaro.org>
 <60b3efff-31c1-bc04-8af9-deebb8bc013a@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <fe51ae1e-6d2e-36bd-485a-d85520ad2386@linaro.org>
Date:   Wed, 24 Apr 2019 15:15:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <60b3efff-31c1-bc04-8af9-deebb8bc013a@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 2/15/19 3:44 PM, Hans Verkuil wrote:
> Hi Stanimir,
> 
> I never paid much attention to this patch series since others were busy
> discussing it and I had a lot of other things on my plate, but then I heard
> that this patch made G_FMT blocking.

OK, another option could be to block REQBUF(CAPTURE) until event from hw
is received that the stream is parsed and the resolution is correctly
set by application. Just to note that I'd think to this like a temporal
solution until gstreamer implements v4l events.

Is that looks good to you?

-- 
regards,
Stan
