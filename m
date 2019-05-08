Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3EE214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR/4UD8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfEHHBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:01:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33355 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEHHBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:01:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so16525147ljc.0;
        Wed, 08 May 2019 00:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LlkeWsi6LmpJS+erXuy96JNFrHh+hmFbNQBGbb+jt0s=;
        b=KR/4UD8TzdEJ8dkuISmY8CnlmVWHb8M/fEDMAQJqu6U5N874Tq/31m2QEXw7ey7HN2
         jlU1CpGJhQCuMl5fdU90KQvf6HNOSMeqSg/VAEuQHI9mWfvNDd87TsOxQTw5Gi8qyUkE
         2HLG0eMH/eUqFy+piudOLBvux+7DFTQ5xy0PEIlNZcEWFvayja2nnjBEjuECGwEwAe0d
         MSyAxlDY6ymKS6+C+/LQ8ApcsMCh/bkG91s0+moZMIwvgyprW010AOXF4SJdKXMs/VvQ
         IvGqu16hm+kqJzidK4LO+Xv27p4L8rogD/sjzdSEtlNWlI48QI9y2+aGrCs3831/x6nf
         p22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LlkeWsi6LmpJS+erXuy96JNFrHh+hmFbNQBGbb+jt0s=;
        b=pOsDCBxYH6A0CgjLL6Q4qROrrbHfz2Pz3QxRfQDrpKTxOn1NxkGYWI9s9yMWlzVcSs
         8UQ2zc2PatG/9O8cmZrlK9tQfN8/bXH2DQmB6gPBI4cak3rSmmjlovqf1YfuYa1E8jnN
         MfhlbxzuDHtjdRS0EAzl7kMUppcBK1E2Jl6fFdk1yuU5ytP+SvFxatj04JAhw/zPXAL1
         9EP7KfoDiM94qTFbgAwB2dSQmytn86ennfgHcXGQMWQ/9DFtzI9LqStR2m7+Vi/+d+Dw
         JfYs082fFQB843Ps+eP/jIZJjmPjzh4bgL2pvcTJyS1Q3NdliHJXSlSLaMZVE6Me2HHs
         Y5dA==
X-Gm-Message-State: APjAAAWa5TdTdg1xtWQ3a5cKiUsIdmRPWYy1RpEvGKAsJp/U9RrsdD3x
        lJoiD13LxA8Vgw81p/tL0vg=
X-Google-Smtp-Source: APXvYqwEcmDSKZI8nPp7flMQUUXOqApyNGLAjuBp9uXH19ysfrzB9szdYO6x+9xRYmK7D15erwg9Ug==
X-Received: by 2002:a2e:1296:: with SMTP id 22mr19939937ljs.11.1557298889143;
        Wed, 08 May 2019 00:01:29 -0700 (PDT)
Received: from [192.168.0.140] (rev-10.ethnet.com.pl. [87.204.29.10])
        by smtp.gmail.com with ESMTPSA id q5sm3358417lfj.1.2019.05.08.00.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 00:01:28 -0700 (PDT)
Subject: Re: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
To:     John Stultz <john.stultz@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     "Yang, Fei" <fei.yang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
From:   Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Message-ID: <5d58059c-1b10-665f-983b-a1d018a30d1f@gmail.com>
Date:   Wed, 8 May 2019 09:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

+= Marek

W dniu 08.05.2019 o 04:18, John Stultz pisze:
> Since commit 772a7a724f69 ("usb: gadget: f_fs: Allow scatter-gather
> buffers"), I've been seeing trouble with adb transfers in Android on
> HiKey960, HiKey and now Dragonboard 845c.
> 
> Sometimes things crash, but often the transfers just stop w/o any
> obvious error messages.
> 
> Initially I thought it was an issue with the HiKey960 dwc3 usb patches
> being upstreamed, and was using the following hack workaround:
>    https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-5.1&id=dcdadaaec9db7a7b78ea9b838dd1453359a2f388
> 
> Then dwc2 added sg support, and I ended up having to revert it to get
> by on HiKey:
>    https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey-5.1&id=6e91b4c7bd1e94bdd835263403c53e85a677b848
> 
> (See thread here: https://lkml.org/lkml/2019/3/8/765)
> 
> And now I've reproduced the same issue (with the same dwc3 workaround)
> on the already upstream code for Dragonboard 845c.
> 
> Fei Yang has also reached out and mentioned he was seeing similar
> problems with the f_fs sg support.
> 
> Andrzej: Do you have any ideas or suggestions on this? I'm happy to
> test or run any debug patches, if it would help narrow the issue down.
> 

There is a patch:

https://www.spinics.net/lists/linux-usb/msg178536.html
https://www.spinics.net/lists/linux-usb/msg179653.html

which fixes a subtle bug, but hasn't been applied yet.

Can you please try it?

> If not, should we consider reverting the f_fs sg support?
> 

Andrzej
