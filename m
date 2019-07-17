Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C573DC76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB322173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQntnTM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfGQFrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 01:47:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35894 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQFrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:47:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so10588406pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 22:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FtZ0UgdNHJWDVHHoxzF6IAqcb8s3MALQMghduEE8rY4=;
        b=oQntnTM77gszwZAh+WwmoqmvQ7CACqNjN326diAE1Fe0GO7JzQDYUxX37i2S+nc82J
         U4EZGqkd+98Dsjku3puKP9lIBAE0jCTKDHs0/XwA4/zqWJxEtdGXLocUHR/zTBxKAdFq
         fXXO8IdoXolGB4stPKIPuz5lEuvqF2lu63KfXhQ2ll7Upu5cN+BxgJDHd1mqj0p8RIC5
         9OdIj1Uh9qJ8BJHmZcB+6RYGPSuZlW4y4BN6W34rSBheaLOdWB057Dh3iqsLsZa+ZluU
         MEkZrAROptBjWXTKMKXWhg/Pp/oiCoITMI+fhr5u01IYYpGaG6wWuOijL+IwVaAm1Ita
         XPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FtZ0UgdNHJWDVHHoxzF6IAqcb8s3MALQMghduEE8rY4=;
        b=X25V72OTbaCHyeSO9SAegz5EEWM4/bmduOJQwROKQorcvQTLQ3KptPxq52V37Q5myT
         N0JJyWaeiDeIemoXgQqhGdGjI0/ZaCiNgk9LteIZEQwWlLHkrYiJYCyX12Ql6AnNDvK2
         lzl+yG1Od14AX5Hqr2CPQNlz11j76cok28RRxZihztOOttQEn5vXg/X2ZokjHvKChZj5
         yBEs7eS4/uEl65SFusDBNIAE/cVx/tu1NO0sMY3NAxIWfXphCMq6w5sLLNxCIlO2Zsdj
         NZ6UnN8Gwcn0iLCgBm58PUbKxweasApPE57mlnHxZSVQI4jEflSN81YzrKzPsD1bLfLT
         6aoQ==
X-Gm-Message-State: APjAAAXKDqzxluUPvxBnjifL1JJJUtheye0jukAgq9pkLhC6yFwYHZF5
        HUWubvkcukqvvSFf9az0jXQQXCRvjb4=
X-Google-Smtp-Source: APXvYqxT3LdyBnPGX8def6EOLQvEhKwYdEp10ZmFFPutwAzP8gjxeqXrIKbG/dDV5XFVnvALjbQElQ==
X-Received: by 2002:a63:1046:: with SMTP id 6mr40084422pgq.111.1563342436937;
        Tue, 16 Jul 2019 22:47:16 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id w14sm24599914pfn.47.2019.07.16.22.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 22:47:15 -0700 (PDT)
Date:   Wed, 17 Jul 2019 11:17:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Return genpd virtual devices from
 dev_pm_opp_attach_genpd()
Message-ID: <20190717054713.vn65cfiqebhzdvjq@vireshk-i7>
References: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
 <2ed7993d-523b-270a-2be9-83ad2426e946@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ed7993d-523b-270a-2be9-83ad2426e946@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-19, 15:09, Rajendra Nayak wrote:
> Sorry for the delay

Same here :)

> I seem to have completely missed this patch.
> I just gave this a try and here are some observations,
> 
> I have a case where I have one device with 2 power domains, one of them
> is scale-able (supports perf state) and the other one supports only being
> turned on and off.
> 
> 1. In the driver I now need to use dev_pm_domain_attach_by_name/id to attach the
> power domain which supports only on/off and then use dev_pm_opp_attach_genpd()
> for the one which supports perf states.
> 
> 2. My OPP table has only 1 required_opps, so the required_opp_count for the OPP table is 1.
> Now if my device tree has my scale-able powerdomain at index 1 (it works if its at index 0)
> then I end up with this error
> 
> [    2.858628] ufshcd-qcom 1d84000.ufshc: Index can't be greater than required-opp-count - 1, rpmh_pd (1 : 1)
> 
> so it looks like a lot of the OPP core today just assumes that if a device has multiple power domains,
> all of them are scale-able which isn't necessarily true.

I don't think a lot of OPP core has these problems, but maybe only
this place. I was taking care of this since the beginning just forgot
it now.

What about this over this commit:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d76ead4eff4c..1f11f8c92337 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1789,13 +1789,16 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  *
  * This helper needs to be called once with a list of all genpd to attach.
  * Otherwise the original device structure will be used instead by the OPP core.
+ *
+ * The order of entries in the names array must match the order in which
+ * "required-opps" are added in DT.
  */
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
                const char **names, struct device ***virt_devs)
 {
        struct opp_table *opp_table;
        struct device *virt_dev;
-       int index, ret = -EINVAL;
+       int index = 0, ret = -EINVAL;
        const char **name = names;
 
        opp_table = dev_pm_opp_get_opp_table(dev);
@@ -1821,14 +1824,6 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
                goto unlock;
 
        while (*name) {
-               index = of_property_match_string(dev->of_node,
-                                                "power-domain-names", *name);
-               if (index < 0) {
-                       dev_err(dev, "Failed to find power domain: %s (%d)\n",
-                               *name, index);
-                       goto err;
-               }
-
                if (index >= opp_table->required_opp_count) {
                        dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
                                *name, opp_table->required_opp_count, index);
@@ -1849,6 +1844,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
                }
 
                opp_table->genpd_virt_devs[index] = virt_dev;
+               index++;
                name++;
        }
 

-- 
viresh
