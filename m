Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA4BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1032190F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OA/AFTiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfJUCky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:40:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41035 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfJUCky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:40:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id t3so6802913pga.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Bmcm7T/zcyVGhPhSabpZfUntv4i1edeqmeNi4+8NAw=;
        b=OA/AFTiKFstPFoO/Ct4VVDeh4wnOMLVd+warA3PtSFT+985BDdvHSedeHMQ6jsHjfz
         3lAfbTQr58ine6Ey7l/xUZcuIpAi3X5ZPe5qCoS0uO3XGOhvhm1KRJHo2qwLo1QQ0pus
         gt8DOW/ue3q7TzQyJ/xlGWFAWprVEDNYrAUIpx41Nu58/lSYlc8pOHHLhTmz1FwpGX9V
         pt/taCEuuqHBUFrjah4hZ+/2yF3nL8dJE58kivfgcibws0zJbOjdCeYazSrfnD1ez3wG
         qXC8dwi23to7Y636OFL1U1r3ClIueqjqpjTdhX/DE+Dn2IoFdUgSTvFIshCKgTsR8YP2
         Xvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Bmcm7T/zcyVGhPhSabpZfUntv4i1edeqmeNi4+8NAw=;
        b=XAo+RuJxGehAuZ6G9Xx8mKgxvrUbq5m6UZ1C/mafxdZiZhexvmhqJLOA9maN5oM5dC
         9aDBWvo2BggunnFPu/M3g3FzpFizJpbj6jB8wQrjtRs2uhoiEwvd7W3UfF98RoOlNSaD
         Fqbpa5eXCP70FRE7sTMAEhUkvLFRIRTCPzN28VSG+j3XZP434cCiN5AwVWUPtG+P18mf
         3ARY30+KFN5YnaGr67KhleCBah0n8V0lMCHGNApDf2pjR9Lfzge8HK59Jg2z6KkHyy0/
         vsnCJKBMsaklULAwIGXXfi/O3iKVAX3wlrBKir2AufdluFkZrUXU9s+d8MKUSDLHO33k
         kL1Q==
X-Gm-Message-State: APjAAAX/DXBRaweN5rG3EBLtL4ROojSHRbLPiyB9D+8tpR/Lih+hDhxz
        wR0SNOnfHKC53s1sSJTI80vR0fbwYz4=
X-Google-Smtp-Source: APXvYqxLx0H3vlInhitEUORpSnDYrwSm3XKCc7L2YZpm1pbtgErYPIS1rZ/LGLGMGdM8wz92rggLBQ==
X-Received: by 2002:a17:90a:9f44:: with SMTP id q4mr25587101pjv.81.1571625652356;
        Sun, 20 Oct 2019 19:40:52 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id e14sm13870948pgk.70.2019.10.20.19.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:40:51 -0700 (PDT)
Date:   Mon, 21 Oct 2019 08:10:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: Re: [PATCH v3 2/5] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191021024049.uyit2zp24l6jqzf5@vireshk-i7>
References: <20191018103749.11226-1-sudeep.holla@arm.com>
 <20191018103749.11226-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018103749.11226-3-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19, 11:37, Sudeep Holla wrote:
> +static struct platform_driver ve_spc_cpufreq_platdrv = {
> +	.driver = {
> +		.name	= "vexpress-spc-cpufreq",
> +	},
> +	.probe		= ve_spc_cpufreq_probe,
> +	.remove		= ve_spc_cpufreq_remove,
> +};
> +module_platform_driver(ve_spc_cpufreq_platdrv);
>  
>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
> -MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
> +MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
> +MODULE_DESCRIPTION("Vexpress SPC ARM big LITTLE cpufreq driver");
>  MODULE_LICENSE("GPL v2");

Strange. The -B option you used while generating the patch makes it
fails to get applied om my side with am -3. git doesn't get the rename
of file properly and shows me this conflict:

  
  static int ve_spc_init_opp_table(const struct cpumask *cpumask)
  {
@@@ -68,4 -697,7 +727,11 @@@ static struct platform_driver ve_spc_cp
  };
  module_platform_driver(ve_spc_cpufreq_platdrv);
  
++<<<<<<< HEAD
 +MODULE_LICENSE("GPL");
++=======
+ MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
+ MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+ MODULE_DESCRIPTION("Vexpress SPC ARM big LITTLE cpufreq driver");
+ MODULE_LICENSE("GPL v2");
++>>>>>>> cpufreq: merge arm_big_little and vexpress-spc

Can you resend this patch (only) without the -B option ?

-- 
viresh
