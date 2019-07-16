Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2FCC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F262173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZMThBuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfGPLLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 07:11:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41189 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbfGPLLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:11:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so19502554ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3UppoPnrfp6kARoJ/BDdFjbxhg47y2G5VBuTvBYTHHQ=;
        b=ZZMThBuqDwl13ushWHRzxVb31hKXGtnUr381OARDy7qrG6qqWJpTATmxvAQnytdAd3
         WWDhBdDpm+aWAaKR6GNoMepO73uWzpX3Qrndbq8J4ty6ViUsvfMqyfs6/itFL/SsfjvD
         CzxIFvBlOjGBd7b3bQw1kh10DwoT/SRvujKG3kD7MpfQ58VUFlH7XAtPL2MVgV+UUGdM
         PdJxH8MVJRUyObEnV+822Z8xRF663Ftj2lbHKB47Za8KRrcZFef/noS7YpIO/Wdn4R3n
         v/aLNt5jQ5gRow8yjC6AmEIagWic/ijm95+H7igKOYeyZsuZTnBx5UE36T44aBN4y5d1
         VXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3UppoPnrfp6kARoJ/BDdFjbxhg47y2G5VBuTvBYTHHQ=;
        b=ajXzrZDSV2L9PLTiCJ+7lQcoXuze5cfZgtx1+FlZ4h+btnBpAgWZSM57VUZKqJ8b/J
         L6Yt2xneT3JF8YB0WpH+BtKDnBwUfLrtuDPAqGJX6joxWRMF7vgNKTsIA+XsvJ24+g7Z
         W6PwVkI6aaJRBzLZIZOyWpDA85Yrj4loS+1hK/w8IFTsnKFRH4rMTGX1rnjwzITLk3o9
         JuxVVVPSy6fzPNZCOaGSrdLhgYdXOdn1VJbGLDUJ9XxXamPim3pvF4gEOzMJqdmy4xZW
         yujzBg+rzLzpONYFnStet8zwT/und6v1AyaAIpPeRg1qEXpUC8i9w8bRn583G0HPBVWr
         G51w==
X-Gm-Message-State: APjAAAVAEXL3X20ovdO/6wn6kflEfQGdPSPVL+W8p/W6SGlaAdlGjNU5
        chTEYRMMurMVhnVAYivvOQbg3w==
X-Google-Smtp-Source: APXvYqzeSAcuRom68dwCg4OqurM1KOFbKuik+yk8ytvJMNyBTrsS8bz4TOshqSAR5pUyabqrXE0MZg==
X-Received: by 2002:a2e:b4c9:: with SMTP id r9mr17164546ljm.196.1563275493271;
        Tue, 16 Jul 2019 04:11:33 -0700 (PDT)
Received: from centauri (ua-83-226-229-61.bbcust.telenor.se. [83.226.229.61])
        by smtp.gmail.com with ESMTPSA id m25sm2768631lfc.83.2019.07.16.04.11.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 04:11:32 -0700 (PDT)
Date:   Tue, 16 Jul 2019 13:11:30 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Sricharan R <sricharan@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/13] cpufreq: qcom: Re-organise kryo cpufreq to use it
 for other nvmem based qcom socs
Message-ID: <20190716111130.GB13918@centauri>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-3-niklas.cassel@linaro.org>
 <20190710061839.quncnis6pjyjntip@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710061839.quncnis6pjyjntip@vireshk-i7>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 11:48:39AM +0530, Viresh Kumar wrote:
> On 05-07-19, 11:57, Niklas Cassel wrote:
> > -static struct platform_driver qcom_cpufreq_kryo_driver = {
> > -	.probe = qcom_cpufreq_kryo_probe,
> > -	.remove = qcom_cpufreq_kryo_remove,
> > +static struct platform_driver qcom_cpufreq_driver = {
> > +	.probe = qcom_cpufreq_probe,
> > +	.remove = qcom_cpufreq_remove,
> >  	.driver = {
> > -		.name = "qcom-cpufreq-kryo",
> > +		.name = "qcom-cpufreq",
> 
> Should we still name it "qcom-cpufreq-nvmem" here ? Only the string
> here.

Sure, I can fix this in next version.

Kind regards,
Niklas

> 
> >  	},
> >  };
> 
> -- 
> viresh
