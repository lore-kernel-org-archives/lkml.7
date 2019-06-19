Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB68C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD7721743
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Flnxb0rv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfFSOT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:19:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41482 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfFSOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:19:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so9841934pff.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PEI8Fh7ieFXqGBrFSnKZWlQnMv0luEiXTnHXkZ6G908=;
        b=Flnxb0rv5SjdEq2CKX8JHqbKsFM0KVjZtMPocQih0yh/tlHcXNp+gTJF1d3aatDuKG
         Nc0s++FslvZhpEtaargu2qhErlHO8T6DlrJomDt3JuVsYnib4Z04ZvwRAmoKoTpnlV56
         h2PhrigWUEQpjcUzByjv8A7f84QU/Iw9e44BFhVDUabu8HrtzZLlE15kBah3mIcWcCFE
         0OJqCPAq1yVhQoRxI5LOCY+v/m9Nt/Y+5QUVkoOTnhCn7RpD54S4i6rcpUjMZ1Ex6IgW
         pP0NL+qPzV2G9oMryq/+573XRpBVwpqLrrUzBVM4C0Y32h9GCbk4RcVQF3pgk1yWzQHA
         xznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PEI8Fh7ieFXqGBrFSnKZWlQnMv0luEiXTnHXkZ6G908=;
        b=XA/m0pwep/Yss8mgkZY6ya+lMYsMN+W2G9zWHtqoy6qpdGnxrR2lGOdduCYNB0ZnxX
         UTFlyHgZzlZ6e5q/F+cIMf7Wm78m+XjPyXRaHa6LJcefmGofMf0jp9wg29Y8tS50XWB2
         FlJKjj9ymNkdbWvF510b+LgXAfnJywn7JjBFWkrssQw8dVRfZY03vlRLqmaE4F49U+ur
         5uzVfCFhp3Ju/8r3er2+p3GJorEWRiYY154tZ/9zuS1olrRFunh4LiEkI+r8TvUqfAcU
         W6CU+Ou5JYct0N3x8Q8OyXKE7T2plI8wcfdFamx91RaKS7mCaG1va02JI3zeAfY7W2pn
         FmCA==
X-Gm-Message-State: APjAAAU9zoDa3qt/oX030S4qRU/0zGPu/rMnEvifdu/2zw1FUS5zFXF3
        qpw3bpHgW8XcpUcV19c2lRE4QQ==
X-Google-Smtp-Source: APXvYqxA6X8rzB/43IY/tGvTMR/odXg3L4My5wUefd93mYzS9onGsZtlYTlKN5dvV08YCESlYhOA0g==
X-Received: by 2002:a62:d0:: with SMTP id 199mr93025140pfa.253.1560953967461;
        Wed, 19 Jun 2019 07:19:27 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id e63sm21555025pgc.62.2019.06.19.07.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:19:26 -0700 (PDT)
Date:   Wed, 19 Jun 2019 19:49:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] cpufreq: Remove the has_target() check from notifier
 handler
Message-ID: <20190619141924.eud6hctk75ihgw27@vireshk-i7>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
 <4008d21f166accfb28180eb804cb8ebda6da4f4d.1560944014.git.viresh.kumar@linaro.org>
 <CAJZ5v0iR8oBZ2mM2vdHzTBNcjsHa6QtJmN+Q17Q8ZD-ny3qy3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iR8oBZ2mM2vdHzTBNcjsHa6QtJmN+Q17Q8ZD-ny3qy3w@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-19, 14:25, Rafael J. Wysocki wrote:
> On Wed, Jun 19, 2019 at 1:35 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > cpufreq_notify_transition() is only called for has_target() type driver
> > and not for set_policy type, and the check is simply redundant. Remove
> > it.
> 
> Ah, OK
> 
> So this patch removes a check introduced by the previous one. :-)
> 
> Please merge them together.

It made sense to keep them separate because there are two different
issues I am fixing here. But if that is what you want, I will merge
them.

-- 
viresh
