Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E31AC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7722068F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceYD8a31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfKNHSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:18:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35962 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfKNHSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:18:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so3554218pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 23:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SWzq6uTLY5mVnefMYGycIvz6HVBtKdbdnPHbBMx9syQ=;
        b=ceYD8a313MDKs169JlAFjZU37hyTCz7Zt9zApCYZMO+zxys56Y5lyEEL5r2BAErgGN
         u97FAIVJdvtMF4AKb20WfzdL3fj0r2VcsYizu6+cfwhd6VtOyjH94vsfMLxoTlOZCKdO
         PDgDlTyGkSWsjrOuoHrj2eGXFI+GWgXnNRZvycu2x/WXjmUfA9RDCMcETRbgFRGkRexd
         TxHdgTPcAKn11S9XG7Wsq6BYktNmh776S6leaCc9SGT7o5MvxYRnV9tEsYnU/i8hT4zZ
         13S+Bt+RHqVzeHzcmsB/+InSLNWpGTYllv8fCtoz26xbpVh6e2FMZKkxd1nyuvl7Pt4+
         MH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SWzq6uTLY5mVnefMYGycIvz6HVBtKdbdnPHbBMx9syQ=;
        b=rNN/3mxKrmIkh8X+HtxG+KyMvmZ+NUW5wmbpHiP+M2w7AMR9wi4gQqdc/0DiY9H4g+
         w+UloYRyE70w1secVshQjWovZAfVBA6NgD2wa0CIBBHMpLc7VZ4pqMBLQzrFpJa9ezGl
         TRIc+8B2qpxj95BFYSIQaDXwYCZKQsbWMjBcGblgF3pb4zPha4g4c704WuBNd6YTo4h/
         OIYOeNdaHNltjK/unnxqJPuD+TdK0QxeG9tYda7BSX5Kl8w5WgrTG5djwb6bvBoa9guH
         tXsgwWcH97ZysNeA6FuBuW6EqPF8IKsRGMF0zu1F8oyPEe7HEZa+syT4aRfIgX/J1+MZ
         6t9w==
X-Gm-Message-State: APjAAAW1o555DHkEtvTEdNgzr4RUKB69gJZJ8uNfIOdd0puN+C1rkSd5
        Ctgu6skjljWNaX9+SeWOtc6rBg==
X-Google-Smtp-Source: APXvYqwiE7VyDVUAUMtOVay2Oy9nvN7pjH7Mx2lfhrbs4sp6pR8AxTJgOBfH1s5ytgRPJWGmAVTf7w==
X-Received: by 2002:a17:90a:ae01:: with SMTP id t1mr10681989pjq.32.1573715932002;
        Wed, 13 Nov 2019 23:18:52 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id c3sm4711729pgi.19.2019.11.13.23.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 23:18:51 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:48:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Register cpufreq drivers only after CPU devices
 are registered
Message-ID: <20191114071845.ea62rlcbjiprx3t6@vireshk-i7>
References: <c60806d5480b7311ced8db07ff239aa5af7a050d.1573702497.git.viresh.kumar@linaro.org>
 <CAP245DXgrnkVWp2ycObP+b5MV7CT8JzQdgxe8CeWktFT-eE6GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP245DXgrnkVWp2ycObP+b5MV7CT8JzQdgxe8CeWktFT-eE6GQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-11-19, 12:33, Amit Kucheria wrote:
> My series was going to get merged through the thermal tree. Currently
> it is hosted here[1] for linux-next testing. We could sign-off this
> patch to the thermal tree or bring the series into the PM tree. Up to
> Rafael and you.

Your thermal patches need to get based of this patch in that case.
Maybe just ask Rui to drop your last patch (for qcom-cpufreq-hw.c)
and merge things as planned. After rc1 is out, you can ask Rafael to
merge that one on top of rc1 ? Everything can still go in 5.5 that
way.

-- 
viresh
