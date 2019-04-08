Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AA0C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878F9213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PoFroFYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDHKoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:44:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43144 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:44:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so7388556pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 03:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Do567jb5pvMfMDC8A/0Ct++Ouy5BDdPJlPi9HiPjOgI=;
        b=PoFroFYmQDL1qoqLuT2Z2InIhcdfN9or+hy3E9o1C3kWliyeQdCWF8imcV+IRiqDXq
         Q/D9HQLX96O4hpY6rhOj0v5KYfQe/tvP9fWOFYPPFhrUNbyZDLwo4+TV1Ghz2qrB+BR6
         nzk6Cr7ixSHG6f6jUdsSGiFLJ+i2f6RWwf1mL31TeSS51Xwr/6U1QnumIqJAFF5wFm3M
         VRBPRoWabVqxV1BjBQQxKFvjrL5swvttWiBxQo34VxsVK/IU2gLjbtXNHSIBW9mI5TbK
         IfbEsyp95cilYFZ5Q/YuiQ6Olq8uPlUVvN6dLJiRcEbCMr7Mhwov0kWstPzbpyxpWUZW
         n/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Do567jb5pvMfMDC8A/0Ct++Ouy5BDdPJlPi9HiPjOgI=;
        b=iCOkcMmq3KcYV3TtZ9Nb00CNGAGPtlXaRWPVkM6SAlqn9hqpThwNPlPur5K/khxbL2
         juiu/Is8Qe++2AMAMqe2c+iKulTJmg10OjEPRiWEtp9uyY+Q8GqPxFMTfkVVr2GPiPHB
         Hh901JWbWTEkLSYSCdvJO4Fjct9/Jy+VEY25k2iUa66+hhMFxa2Y3ZT5YeFR1bPvKYtx
         EVgDryTu3QqbbTOWK7aiqyF57Bxbys9QvXxUVLsmtMj3YVIkTlpZBv3an909CNf/ZuVM
         9hRmbkfBh4NI85QifoiUGPzO8qR1zIcCxTbDGMZYuRBJMAuVgXqWipU17vsQhDSDDUK8
         PpCg==
X-Gm-Message-State: APjAAAVUTJ08XhzkLGxA98U1M8IU/H8OtsqzA8iPapkLwNB2u0WauWQ+
        Dl54YrRAfuGKKkHFmFMFlnmV+Q==
X-Google-Smtp-Source: APXvYqxscKB0OBTYsfDN7tA/run04HM83o8l+gcII8Ydvxco46COhIHtOB9oi2j9m8vyGhbORh2deQ==
X-Received: by 2002:aa7:9aa8:: with SMTP id x8mr6928766pfi.193.1554720291887;
        Mon, 08 Apr 2019 03:44:51 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id k65sm57380024pfb.68.2019.04.08.03.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 03:44:51 -0700 (PDT)
Date:   Mon, 8 Apr 2019 16:14:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        Sricharan R <sricharan@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/9] cpufreq: qcom: Re-organise kryo cpufreq to use
 it for other nvmem based qcom socs
Message-ID: <20190408104449.zqbamhcrjheanlgt@vireshk-i7>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-3-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404050931.9812-3-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-04-19, 07:09, Niklas Cassel wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> The kryo cpufreq driver reads the nvmem cell and uses that data to
> populate the opps. There are other qcom cpufreq socs like krait which
> does similar thing. Except for the interpretation of the read data,
> rest of the driver is same for both the cases. So pull the common things
> out for reuse.

This is really sad for me. The driver was added in May last year and I am quite
sure it would have been known at that time itself that there are more hardware
platforms which will end up using this driver because of the similarity in
hardware. Not that you (personally) could have done anything about it as you
weren't there then, but it should have been taken care of by the then
developers.

Anyway, its okay now, can't do anything but rename things.

-- 
viresh
