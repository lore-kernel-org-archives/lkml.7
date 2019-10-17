Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5478EFA3730
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7A720650
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsFChQGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408653AbfJQJqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:46:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36716 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392740AbfJQJqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:46:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so1301940pfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HA1gROLlU5nGU3rZp9KPpPiUhlmPzfUUJa/DdhRHaus=;
        b=DsFChQGcXp/0iKktNloQYHrCgctEcJmlGRFe5cJtd064ngexVy5CRyAxFJHY8aZPmh
         H+WTGsg3MCA18mom70GTV4yMoRU+0splvu0vWL0Fj/tD1slcmF0KzCGKn4qPyI8CdrIY
         3QU+pVnjgLTFZjL3l5PH/IuLilMbvi7tE96zXxd6eeqYJjRcMczwBJ088Y3+JHTxngB1
         yNCe164G7MqXquzb1QZWaPfaaA4tBpAITRRTX9lK6PO3JTh7sIQCs9SzOsXQo8YnlZr2
         uMP2fdizjwe0KKZ5Qpz7x1xURymp2OPpbqsEHwiVpRhq79xd5Nk0rmSyqO6kMHHaALl/
         M6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HA1gROLlU5nGU3rZp9KPpPiUhlmPzfUUJa/DdhRHaus=;
        b=idsgmxBX0Ou2Sni3i9K5wgkU6+6pgLeMbIeoL2Up5Onn2A5DOaI77nCH6fmQtd0mui
         e1TIQc9euTOYtGBEOrIeQcNpWx2Svj7DT3B/8moMN4wSg3iFwRfsAaieUN9/TcptF1HB
         Ts8nl10kNMpw+FVEjdV/s1uYWCEUcKfRYs3blsos2xZ2H43dU7KNgz4QI9XE2l/6zYD/
         huLJUu7e+AIoPFZYW6TpWcduJSDIuKyr9YISv3al66SeLSpMDxiQghltCmstine5+wtJ
         0/2x0uza0ZBMoIRn4/qZYz4/SvI9on8815YZfYJGapDvXjHEFDMGp7uYoIp2XLiKTMHO
         wVKA==
X-Gm-Message-State: APjAAAV6BGT9yeKeOIEUQolfMRhfkMMevWPdeU2fIyI+r35AP4EmeEfO
        +AKAlsApPOw6lh4m0R5nEYiwbg==
X-Google-Smtp-Source: APXvYqxRRGkNYrj4IvnEwznK2d7owuc1bIYg4jbYp+1Gxo/TJcJlDlIYX89z/3q85T0fIfNrQtQqSg==
X-Received: by 2002:a65:6701:: with SMTP id u1mr3132918pgf.368.1571305575072;
        Thu, 17 Oct 2019 02:46:15 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id s202sm2510839pfs.24.2019.10.17.02.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 02:46:14 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:16:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191017094612.6tbkwoq4harsjcqv@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2811202.iOFZ6YHztY@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-19, 12:37, Rafael J. Wysocki wrote:
> Hi All,
> 
> The motivation for this series is to address the problem discussed here:
> 
> https://lore.kernel.org/linux-pm/5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org/T/#md2d89e95906b8c91c15f582146173dce2e86e99f
> 
> and also reported here:
> 
> https://lore.kernel.org/linux-pm/20191015155735.GA29105@bogus/
> 
> Plus, generally speaking, using the policy CPU as a proxy for the policy
> with respect to PM QoS does not feel particularly straightforward to me
> and adds extra complexity.
> 
> Anyway, the first patch adds frequency QoS that is based on "raw" PM QoS (kind
> of in analogy with device PM QoS) and is just about min and max frequency
> requests (no direct relationship to devices).
> 
> The second patch switches over cpufreq and its users to the new frequency QoS.
> [The Fixes: tag has been tentatively added to it.]
> 
> The third one removes frequency request types from device PM QoS.
> 
> Unfortunately, the patches are rather big, but also they are quite
> straightforward.
> 
> I didn't have the time to test this series, so giving it a go would be much
> appreciated.

Apart from the minor comment on one of the patches, these look okay to me.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
