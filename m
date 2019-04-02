Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73703C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406B52070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfDBNP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:15:29 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:6512 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731137AbfDBNP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:15:27 -0400
X-IronPort-AV: E=Sophos;i="5.60,300,1549926000"; 
   d="scan'208";a="301531226"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 15:15:23 +0200
Date:   Tue, 2 Apr 2019 15:15:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Wen Yang <wen.yang99@zte.com.cn>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH 7/7] cpufreq: ppc_cbe: fix possible object reference
 leak
In-Reply-To: <89ab8dd4-e997-1796-a522-863ff511bb58@web.de>
Message-ID: <alpine.DEB.2.20.1904021515000.3297@hadrien>
References: <1554082674-2049-8-git-send-email-wen.yang99@zte.com.cn> <89ab8dd4-e997-1796-a522-863ff511bb58@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1488356219-1554210919=:3297"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8323329-1488356219-1554210919=:3297
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 2 Apr 2019, Markus Elfring wrote:

> > @@ -86,6 +86,7 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >  	if (!cbe_get_cpu_pmd_regs(policy->cpu) ||
> >  	    !cbe_get_cpu_mic_tm_regs(policy->cpu)) {
> >  		pr_info("invalid CBE regs pointers for cpufreq\n");
> > +		of_node_put(cpu);
> >  		return -EINVAL;
> >  	}
>
> I have taken another look at the implementation of this function.
> I find that the second statement “return -EINVAL” would need related
> source code adjustments.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpufreq/ppc_cbe_cpufreq.c?id=05d08e2995cbe6efdb993482ee0d38a77040861a#n96
>
> How do you think about to complete the exception handling here?

There is an of_node_put two lines above.

julia
--8323329-1488356219-1554210919=:3297--
