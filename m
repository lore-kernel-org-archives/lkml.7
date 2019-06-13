Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D0FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F038206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GQXJaktv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404367AbfFMRAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:00:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46862 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbfFMAEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 20:04:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so10588778pfy.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=enyuAfwIUm7QZb/zhVy1/4Va6a5/NPi/JrG9djy3bF8=;
        b=GQXJaktvgKtFOEDW1sUlsUsVwTuVAnIA8hh4WjxCiXsXvlvtfRzGg7etclRAdgKv4U
         4ShkffdYG971cLxlYNt6mPgcxcVKbfFPcLkX7gZMRMy0uHwgTA+CLDAnKeuUPidLGO3I
         bqwz3QvEooRJpl5P8hL/GSorok8hu1ktGl9+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=enyuAfwIUm7QZb/zhVy1/4Va6a5/NPi/JrG9djy3bF8=;
        b=GO7klXVRSyR0iYziogSEp36FVatv8c19D71tyuNho1nVjpux64PVmJxGhZ1C6puPv4
         MNOGs+fOT87reCWTkNaMczhiyMBo8FC0ffHGzYKOf1269EvjOSC+tZ7chzE3oNKXx7Xn
         MyLYBpXTTz1lTKKCPUVT2FOG1rDJphNYrApLb2h8xqNk5nxfSTYedDkTNjoh62OE7Dmh
         jNUS/17VtUpJ1drJkWmK0rYnyUbPxsLL+oQQYT3njZY/ufczTIgEpfoLHufdufWPs+W8
         R1OIji2PONS8CRvIYWIIXtz8Tj6Wfl+daz1A7QFPslShq83g+PuX4oCPiDVujqjUBv+1
         MPPA==
X-Gm-Message-State: APjAAAWa/MCvTuFlmbC0Yv7E+uMa+vIsfjICIm6TYJeLpOSX4tLxXoZk
        7AnzgRFsM5mn6UWl5TyRvdKaJQ==
X-Google-Smtp-Source: APXvYqwO5UFiyckgdUgkZVSFQmP4vYWEFYVqaJ7SB58Em//0AXY36VhkhuJlG3u3XDCMdNZATgT/Wg==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr1876181pjr.116.1560384284934;
        Wed, 12 Jun 2019 17:04:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x66sm642436pfx.139.2019.06.12.17.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 17:04:43 -0700 (PDT)
Date:   Wed, 12 Jun 2019 17:04:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/5] PM / QoS: Add support for MIN/MAX frequency
 constraints
Message-ID: <20190613000441.GM137143@google.com>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <8c0ead9cc598f9eb7d15bd4878108b545368dd6e.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c0ead9cc598f9eb7d15bd4878108b545368dd6e.1560163748.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 04:21:34PM +0530, Viresh Kumar wrote:
> This patch introduces the min-frequency and max-frequency device
> constraints, which will be used by the cpufreq core to begin with.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Again, I'm mostly ignorant about QoS, in the context of the
existing code (particularly looking at DEV_PM_QOS_RESUME_LATENCY)
this looks reasonable to me. FWIW:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
