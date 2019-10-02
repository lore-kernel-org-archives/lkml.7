Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13ACC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C753D2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCUdwY76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfJBJ1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:27:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44545 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJBJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:27:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so16315915ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6SKGJtRjRwGm3Gfog0PHR1zM7cDCImdjAnhzrGYUec4=;
        b=DCUdwY76HKpHKa3RgaCGbfADwXg4XDsYYaqbrH5c382btFUWzyCXtS8+HgmYhxu0gn
         dHLj+Eo0zgIyN4P+mXUJJYn9KsRxDVEwzqLWB6IO2Zs+NyMoXM/bmbPtjuuxG/xgmpYN
         OsjUiONZuNFiXpttc8HlwJ13qTG3HSsRvMdsKOVtOu5g4pXQzmtkRox3FyH7TLvesWQn
         h1ou+E9vm3yNKaRRjkcTM1il4z5QUgaayUvUS4xK/+njUa7zDCaF4hrfrbJgbaejTbn7
         VtQTRxwD9XXyCcTU8Qy71O2HWoUE+AX6BTEDBZ7yg0Q57vXiOeGa3ZLDsRUXKxRHCJYb
         pqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6SKGJtRjRwGm3Gfog0PHR1zM7cDCImdjAnhzrGYUec4=;
        b=PAhEVBqiyv5NTihM/BBxmbitPhaotQtcI47Xk+By4sFdEhe8/GBfrAVgRr1K50cwU/
         wr1QZwRlLkyQ6qHNhp0hFMZuTHRDLGjNmgbFF3eKp5efwt0aEZiLs+uIMvYmnjhjzxKc
         bsxSeyFYRMa6qBQfFylFjZmNSP0BtwLaenLdaC+8oFGjjPWY7Da9rK226ZEbJnKmT+Pj
         0S0wlTkKnHq9rracO7C3Gc4sJpl78LuyqFXziXQ2MSxPWhd7aKjurJgUnt/fKYUb0fNx
         wnsK0hT7aJOyj1QxAcK1lo+pcEnKZcLoEZgg5VTNzH9WeiBfJH+1OXw7ayO2p5ZlY0/J
         3FSg==
X-Gm-Message-State: APjAAAXGCcavyqygFEuCs72e+4SsfuCkmyGSlPDBGuiXxfzrVPDfN75c
        CiWVX9ylqI/N3e00LvIHiBxx+w==
X-Google-Smtp-Source: APXvYqzlP5sk7vLuux/qAMdsdIfm+H8xV21u3k2FgL6nwDndAe7xpYuRU4xQyXuHfzD+735xMWvK8w==
X-Received: by 2002:a05:651c:150:: with SMTP id c16mr1732245ljd.224.1570008458471;
        Wed, 02 Oct 2019 02:27:38 -0700 (PDT)
Received: from centauri (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id r19sm4632654ljd.95.2019.10.02.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:27:36 -0700 (PDT)
Date:   Wed, 2 Oct 2019 11:27:34 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Sibi Sankar <sibis@codeaurora.org>, daniel.lezcano@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: msm8998: Add PSCI cpuidle low
 power states
Message-ID: <20191002092734.GA15523@centauri>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
 <49cf5d94beb9af9ef4e78d4c52f3b0ad20b7c63f.1558430617.git.amit.kucheria@linaro.org>
 <CAOCk7NptTHPOdyEkCAofjTPuDQ5dsnPMQgfC0R8=7cp05xKQiA@mail.gmail.com>
 <20191002091950.GA9393@centauri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002091950.GA9393@centauri>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:19:50AM +0200, Niklas Cassel wrote:
> On Mon, Sep 30, 2019 at 04:20:15PM -0600, Jeffrey Hugo wrote:
> > Amit, the merged version of the below change causes a boot failure
> > (nasty hang, sometimes with RCU stalls) on the msm8998 laptops.  Oddly
> > enough, it seems to be resolved if I remove the cpu-idle-states
> > property from one of the cpu nodes.
> > 
> > I see no issues with the msm8998 MTP.
> 
> Hello Jeffrey, Amit,
> 
> If the PSCI idle states work properly on the msm8998 devboard (MTP),
> but causes crashes on msm8998 laptops, the only logical change is
> that the PSCI firmware is different between the two devices.

Since the msm8998 laptops boot using ACPI, perhaps these laptops
doesn't support PSCI/have any PSCI firmware at all.


Kind regards,
Niklas
