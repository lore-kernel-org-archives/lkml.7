Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85046C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E9C216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZC0heqct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391650AbfETOru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:47:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45152 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732544AbfETOrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:47:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so12696536lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lduM1D/30FHnKa/TxamjAn4bdPB0y468JNuwks7lSTQ=;
        b=ZC0heqctg4mOdx1j9EMHSRagFdJdZJ6b9kHkjDQxtco1Csn3xTmsBYjOmu9YOcA7Q2
         717eB1oJLOdvSZ3Vbzl9SlvBWMkMynGOxlLvsfSYGXyPmFsJnr+qT48ftsNhXTTVtnjj
         +E7nwypgTJ0Hh66RUR0VT6tZoIi8XHPj7TBnsX7ru9FfzjfvfmX74muund4krn1SFnsS
         x9CopEVxxXevkrxfb98W12dtpSPuwb7bCFnwSbsj2//qAXEIRBDRzJShhbNPI/mlnBCR
         iqrNazpmDZG2NwOrYWo1iDsBcX55HVhBpE/aYqWVIw2JJm1CdU+RxAZ8aajGL3IbsBFG
         9g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lduM1D/30FHnKa/TxamjAn4bdPB0y468JNuwks7lSTQ=;
        b=O6HPkVW7N0H+olBA27f1GiV4Ra8SvZ+96xUWuN8NdRreAJVO/3J89Pxt8WbRF79keW
         WDMcYMctnuxoCaDeQwb77ICB5zbCkrjHwuWlMlYveUCm+1ARkvRuedmM2lEFCHE3YGwr
         K37LNRZb/HKl4sdh6HpD7L3p7LaPW68/ReQsLT5c0WR8p6P7vpCEVTcPxAEZdgdhc//2
         nIJ8d8JGp+8WIeNdLMk28XNcep+dvnwDRqD5ck63p9hQejs8j7qpAOJEDco2AFQpIYnH
         QBIw4tEP093t8DMZfugT9MmPtoi4psUqyCtmKKDE7RNm6G08Ph0cfrYlNlhlRXgFtsjx
         xXuQ==
X-Gm-Message-State: APjAAAURFGId2aqZiH372Ra1FKnNbi0Y/6tURVE1lSUkFCEkAYMp7ln4
        T7L+z84oEo5dinD9NVM+qIqyRQ==
X-Google-Smtp-Source: APXvYqy49HmF/zVtrpBI/4FFwPmxErLVpwCnhMGaASUN4pBhhjDI0xWaYrQSipQDNjEyeHj1TIVEgg==
X-Received: by 2002:a2e:6c0b:: with SMTP id h11mr2381223ljc.15.1558363667338;
        Mon, 20 May 2019 07:47:47 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id z3sm3805757ljg.78.2019.05.20.07.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 07:47:46 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH 10/10] venus: dec: make decoder compliant with stateful
 codec API
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-11-stanimir.varbanov@linaro.org>
 <60b3efff-31c1-bc04-8af9-deebb8bc013a@xs4all.nl>
 <fe51ae1e-6d2e-36bd-485a-d85520ad2386@linaro.org>
 <CAAFQd5Co3G1J4+HOcjtCb7p3rhLcm+1E=mPr2d=AtdOSuF_eKg@mail.gmail.com>
Message-ID: <c56930e0-be6f-2ade-fcea-8ee0ff6247ec@linaro.org>
Date:   Mon, 20 May 2019 17:47:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Co3G1J4+HOcjtCb7p3rhLcm+1E=mPr2d=AtdOSuF_eKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 4/24/19 3:39 PM, Tomasz Figa wrote:
> On Wed, Apr 24, 2019 at 9:15 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Hi Hans,
>>
>> On 2/15/19 3:44 PM, Hans Verkuil wrote:
>>> Hi Stanimir,
>>>
>>> I never paid much attention to this patch series since others were busy
>>> discussing it and I had a lot of other things on my plate, but then I heard
>>> that this patch made G_FMT blocking.
>>
>> OK, another option could be to block REQBUF(CAPTURE) until event from hw
>> is received that the stream is parsed and the resolution is correctly
>> set by application. Just to note that I'd think to this like a temporal
>> solution until gstreamer implements v4l events.
>>
>> Is that looks good to you?
> 
> Hmm, I thought we concluded that gstreamer sets the width and height
> in OUTPUT queue before querying the CAPTURE queue and so making the
> driver calculate the CAPTURE format based on what's set on OUTPUT
> would work fine. Did I miss something?

Nobody is miss something.

First some background about how Venus implements stateful codec API.

The Venus firmware can generate two events "sufficient" and
"insufficient" buffer requirements (this includes decoder output buffer
size and internal/scratch buffer sizes). Presently I always set minimum
possible decoder resolution no matter what the user said, and by that
way I'm sure that "insufficient" event will always be triggered by the
firmware (the other reason to take this path is because this is the
least-common-divider for all supported Venus hw/fw versions thus common
code in the driver). The reconfiguration (during codec Initialization
sequence) is made from STREAMON(CAPTURE) context. Now, to make that
re-configuration happen I need to wait for "insufficient" event from
firmware in order to know the real coded resolution.

In the case of gstreamer where v4l2_events support is missing I have to
block (wait for firmware event) REQBUF(CAPTURE) (vb2::queue_setup) or
STREAMON(CAPTURE) (vb2::start_streaming).

I tried to set the coded resolution to the firmware as-is it set by
gstreamer but then I cannot receive the "sufficient" event for VP8 and
VP9 codecs. So I return back to the solution with minimum resolution above.

I'm open for suggestions.

-- 
regards,
Stan
