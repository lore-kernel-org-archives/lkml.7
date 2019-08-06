Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C161CC32754
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 04:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75702216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 04:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ur1TTksH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfHFEBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 00:01:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37755 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHFEBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 00:01:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so40725538pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 21:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3TFYUjYnPdFwbR/gZPSkhap+wwa2+UTWPedjNUfvaCs=;
        b=Ur1TTksHqEzo+3mspdwHLh/GPTMgpYFALryUKxCRN74kc9TNhwuseHRUfrQ9+59trc
         blJCGvuLj4KJ9h4GIfQaAG0/v5p5aZx6ZkjjIhmxB2gGTlbY/Uyv/yNEHl83mkKeUfwl
         Rjdynz3duonl57UAn+YkaQxrfx6OWvdYv7ied0JgviZXwpaKMlYB50/y7i/UCcUFwt9z
         /7PMYLpV96bsmqqQMkxc7RQjIAYURoc5Ji5kZcYDIgJffde5ee2BBZHS+v4PUvC2/0Os
         khZhvBeQ82l4kJJCLTlbg4ilgJXyPADJOwl+qUYiA5uWsAYsE7Ri1R0TRdugbH9aBrl0
         C64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3TFYUjYnPdFwbR/gZPSkhap+wwa2+UTWPedjNUfvaCs=;
        b=MGc1LLyL9DxJAQWv2q7FX7QXI5NTiFda/GiUAT/5BuDMl1rn8BCXl9qEGrZNLWonFs
         x5NClYAoUQwdjYropN3QTI71LARqZABnhvQZw0vbl10XyBlawzvu/kPFrbKe95nm1/qq
         6Q8hK1vHi6k9NU1u3PVU+igseQ+JHW7h9qpk18iFac54PDgFnoZ1z0qa49JMx2TsHYN6
         t37D4nMc/owqIsPfdfCOVhx/TIEO+o2tVCPRyI1pCv2oDtzwaAYEdV/LpoIHEX+USDmK
         0KZsqN7/W6/qtkiFid76ZucDmi0yLpu6Es8rXFDrntgXx2R+NnzH8wWlFLCPDzZX32xW
         /2GQ==
X-Gm-Message-State: APjAAAURpI+icc18lVMAuOvWzR+SKw9FjHH9RVYpmorZsVcKkuSU77um
        90h2+W1JrQba5WVemYT7vnV9uw==
X-Google-Smtp-Source: APXvYqx1/4OA0fwfHhSRGbm8u/zUMW5hd76Tbpp6hlQ3NVYY8btzNNtrrWg6ZXfxmtcL7Je7iiXrQA==
X-Received: by 2002:a62:82c2:: with SMTP id w185mr1548036pfd.202.1565064061906;
        Mon, 05 Aug 2019 21:01:01 -0700 (PDT)
Received: from localhost ([122.172.146.3])
        by smtp.gmail.com with ESMTPSA id a15sm118235731pfg.102.2019.08.05.21.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 21:01:01 -0700 (PDT)
Date:   Tue, 6 Aug 2019 09:30:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Doug Smythies <dsmythies@telus.net>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Linux PM' <linux-pm@vger.kernel.org>,
        'Vincent Guittot' <vincent.guittot@linaro.org>,
        'Joel Fernandes' <joel@joelfernandes.org>,
        "'v4 . 18+'" <stable@vger.kernel.org>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: Don't skip freq update when limits
 change
Message-ID: <20190806040059.ty4qhjarx4obomhs@vireshk-i7>
References: <CAJZ5v0ji+ksapJ4kc2m5UM_O+AShAvJWmYhTQHiXiHnpTq+xRg@mail.gmail.com>
 <000001d54892$a25b86b0$e7129410$@net>
 <20190802034819.vywlces7rxzfy33f@vireshk-i7>
 <1599417.3YyTWY6lWL@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599417.3YyTWY6lWL@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-08-19, 11:11, Rafael J. Wysocki wrote:
> On Friday, August 2, 2019 5:48:19 AM CEST Viresh Kumar wrote:
> > On 01-08-19, 10:57, Doug Smythies wrote:
> > > Disagree.
> > > All I did was use a flag where it used to be set to UNIT_MAX, to basically
> > > implement the same thing.
> > 
> > And the earlier code wasn't fully correct as well, that's why we tried
> > to fix it earlier.
> 
> Your argument seems to be "There was an earlier problem related to this, which
> was fixed, so it is fragile and I'd rather avoid it".  Still, you are claiming that the
> code was in fact incorrect and you are not giving convincing arguments to
> support that.
> 
> > So introducing the UINT_MAX thing again would be
> > wrong, even if it fixes the problem for you.
> 
> Would it be wrong, because it would reintroduce the fragile code, or would it
> be wrong, because it would re-introduce a bug?  What bug if so?

There will be two issues here if that patch is reintroduced:

- It will cause the BUG to reappear, which was fixed by the earlier
  commit. The commit log of ecd28842912 explains the bug in detail.

- And overriding next_freq as a flag will make the code fragile and we
  may have similar bugs coming up.

But yeah, lets continue discussion on the intel-pstate patch now.

-- 
viresh
