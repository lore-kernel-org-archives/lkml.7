Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31451C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DAD2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCyfNCr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfDJG3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:29:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43604 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfDJG3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:29:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so798772pfd.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xwfoUJqPA7B1qNvVW6xqIft2TcTCZV15J00JP5m2zL0=;
        b=UCyfNCr519TJ50zJhOYOS3XKdK0WnZVYhD5rWWcwm5L+T5bcxT1LczBzkY6bHu6BbZ
         Mq6EKHOZYz8zBPDZC4PThzCQbbpvAZ75UJMy9XcVMRHyHe74YoH2niI771wWBOitsY5K
         RALtn2igb0aj1KJWqiveis3Tv0VroWV0Sc23h+mTdYuLUlOegjP+YOWxHvRL2GxjQbsI
         1mSchPAZq4NEXqW8mc2GUZpr9sE10Sp1C92sSoKdis2uOvfOyfx/KbvCithIp7QY9Qn8
         DF22GRECTU9827sKvmqsEYqKvpodXBM5CfuzB9EUJ0MEl/uWslrv7y8HJN3oQVBA4Bc8
         p/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xwfoUJqPA7B1qNvVW6xqIft2TcTCZV15J00JP5m2zL0=;
        b=NYWh+RtppBp7RmcpL4EmrO1fkDXfNZVuoxjDQVjQHdvKYjfoqlxhMQi92quXck5uRS
         ckjPPxOFln97QoFO3o2tR6eT6fV5JYQWoxJdUhTG9YCA4Mj4MB4NHIVAtU4VFhnr3gYL
         f3dHG8Ys8W2VEaqZLDaZ7jkVGFVX6EvVo1Te9CYF7z36M0pHdjdlhNe0z1dH5EwwUHOW
         fbm5bWSPc3V+/ljARMcKMsUZXV2z7PJ1tgk6gqTNcZ76uv9xosPvo/Z93UfPFEXhKmob
         7Ow7ob4KIvHH3SFNHZ8G7Onpx1R/6/E663s3u7whDG1boDaGFD354lLPmNERTShrfSd7
         gNxg==
X-Gm-Message-State: APjAAAUa25UJuhMbHQkNHIRnz5d8IVCK0fM5TfwR9svFQPInrvODf0BN
        cbUwGt/TG41oZm+ggAHiTqFLAw==
X-Google-Smtp-Source: APXvYqwhCjnR8iyO0qw7uyNVRkxDrU991+dX+WGTKAyB0guZWqyPfl3YUsBqGPPZOoIM+eCh3ZxgIQ==
X-Received: by 2002:a63:195f:: with SMTP id 31mr39424906pgz.116.1554877753878;
        Tue, 09 Apr 2019 23:29:13 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id a129sm79153601pfa.152.2019.04.09.23.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 23:29:11 -0700 (PDT)
Date:   Wed, 10 Apr 2019 11:59:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
Subject: Re: [PATCH v2 2/4] opp: add API which get max freq by voltage
Message-ID: <20190410062909.6nkl4m4j5evrmqrl@vireshk-i7>
References: <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-03-19, 14:46, Andrew-sh.Cheng wrote:
> This API will get voltage as input parameter.
> Search all opp items for the item which with max frequency,
> and the voltae is smaller than provided voltage.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/opp/core.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  8 ++++++++
>  2 files changed, 63 insertions(+)

I have applied this patch with some modifications, here is the diff:

---
 drivers/opp/core.c     | 29 ++++++++++++++---------------
 include/linux/pm_opp.h |  8 ++++----
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7323cd9aabf9..0e7703fe733f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -527,31 +527,30 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
 /**
- * dev_pm_opp_find_max_freq_by_volt() - Search for a opp with max freq
- * under provided voltage
- * @dev:	device for which we do this operation
- * @u_volt:	provided voltage
+ * dev_pm_opp_find_freq_ceil_by_volt() - Find OPP with highest frequency for
+ *					 target voltage.
+ * @dev:	Device for which we do this operation.
+ * @u_volt:	Target voltage.
+ *
+ * Search for OPP with highest (ceil) frequency and has voltage <= u_volt.
  *
- * Search for the matching available OPP which provide voltage can support.
+ * Return: matching *opp, else returns ERR_PTR in case of error which should be
+ * handled using IS_ERR.
  *
- * Return: matching *opp, else returns ERR_PTR in case of error
- * and should be handled using IS_ERR.
  * Error return values can be:
- * EINVAL:	for bad pointer
- * ERANGE:	no match found for search
- * ENODEV:	if device not found in list of registered devices
+ * EINVAL:	bad parameters
  *
  * The callers are required to call dev_pm_opp_put() for the returned OPP after
  * use.
  */
-struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
-					      unsigned long u_volt)
+struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
+						     unsigned long u_volt)
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	if (!dev || !u_volt) {
-		dev_err(dev, "%s: Invalid argument volt=%d\n", __func__,
+		dev_err(dev, "%s: Invalid argument volt=%lu\n", __func__,
 			u_volt);
 		return ERR_PTR(-EINVAL);
 	}
@@ -564,7 +563,6 @@ struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
 
 	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available) {
-			/* go to the next node, before choosing prev */
 			if (temp_opp->supplies[0].u_volt > u_volt)
 				break;
 			opp = temp_opp;
@@ -574,12 +572,13 @@ struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
 	/* Increment the reference count of OPP */
 	if (!IS_ERR(opp))
 		dev_pm_opp_get(opp);
+
 	mutex_unlock(&opp_table->lock);
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return opp;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_find_max_freq_by_volt);
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_by_volt);
 
 static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 			    struct dev_pm_opp_supply *supply)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 57deef9cf5d3..b150fe97ce5a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -102,8 +102,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
-struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
-					      unsigned long u_volt);
+struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
+						     unsigned long u_volt);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
@@ -209,8 +209,8 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
-					      unsigned long u_volt)
+static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
+					unsigned long u_volt)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
