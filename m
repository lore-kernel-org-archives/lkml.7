Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C12C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B6121881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AJvYHzwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfH0QWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:22:02 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43743 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbfH0QWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:22:02 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RGG0BV019934;
        Tue, 27 Aug 2019 18:21:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=sTwTEKh7PY7xWSu6lXW3JPWtDKCZvlUhRrOtUzusNF0=;
 b=AJvYHzwFCR6O19zZZtRcXPFdYXbcTlO2jqn0zDfzYqbPiPAb7hAIgE9tSbq2GYy6IGVd
 jM+N40rxWGIA24TvZZcsJD53gP6dJz95i+vkp7JcQoVML4qSHRZaw6qPCjoJZhQcnp0m
 VoICawxzPl15pKMs4xWVmVxvE9BjmSCICDnujxoT46cglrloS4kS6n1B52E5NUdi5hCO
 cfaMMw50GuWtUR0pE15Cdoyxv4IMQ33npJak1UgZ8MeT83FImATZKCWxRuh4bdiFlPZx
 QBIynFMBi5Rh4WXTwUPeroFPun85W11NZO2q+u4A09+g+/9CZLGMGcMneN7Mx8ILYdO6 QA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uju0vthq6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 27 Aug 2019 18:21:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5BEDF4C;
        Tue, 27 Aug 2019 16:21:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 900432B76DF;
        Tue, 27 Aug 2019 18:21:46 +0200 (CEST)
Received: from [10.48.0.131] (10.75.127.45) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 18:21:46 +0200
Subject: Re: [PATCH] remoteproc: Add a sysfs interface for name
To:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190809222057.13924-1-s-anna@ti.com>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <01cf27f8-c586-5a9e-c361-082bb1facbb4@st.com>
Date:   Tue, 27 Aug 2019 18:21:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809222057.13924-1-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

Acked-by:Arnaud POULIQUEN <arnaud.pouliquen@st.com>

Thanks,
Arnaud

On 8/10/19 12:20 AM, Suman Anna wrote:
> This patch adds a sysfs interface that provides the name of the
> remote processor to userspace. This allows the userspace to identify
> a remote processor as the remoteproc devices themselves are created
> based on probe order and can change from one boot to another or
> at runtime.
> 
> The name is made available in debugfs originally, and is being
> retained for now. This can be cleaned up after couple of releases
> once users get familiar with the new interface.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>   Documentation/ABI/testing/sysfs-class-remoteproc | 10 ++++++++++
>   drivers/remoteproc/remoteproc_sysfs.c            | 11 +++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-remoteproc b/Documentation/ABI/testing/sysfs-class-remoteproc
> index c3afe9fab646..36094fbeb974 100644
> --- a/Documentation/ABI/testing/sysfs-class-remoteproc
> +++ b/Documentation/ABI/testing/sysfs-class-remoteproc
> @@ -48,3 +48,13 @@ Description:	Remote processor state
>   
>   		Writing "stop" will attempt to halt the remote processor and
>   		return it to the "offline" state.
> +
> +What:		/sys/class/remoteproc/.../name
> +Date:		August 2019
> +KernelVersion:	5.4
> +Contact:	Suman Anna <s-anna@ti.com>
> +Description:	Remote processor name
> +
> +		Reports the name of the remote processor. This can be used by
> +		userspace in exactly identifying a remote processor and ease
> +		up the usage in modifying the 'firmware' or 'state' files.
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index fa4131930106..7f8536b73295 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -113,9 +113,20 @@ static ssize_t state_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(state);
>   
> +/* Expose the name of the remote processor via sysfs */
> +static ssize_t name_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct rproc *rproc = to_rproc(dev);
> +
> +	return sprintf(buf, "%s\n", rproc->name);
> +}
> +static DEVICE_ATTR_RO(name);
> +
>   static struct attribute *rproc_attrs[] = {
>   	&dev_attr_firmware.attr,
>   	&dev_attr_state.attr,
> +	&dev_attr_name.attr,
>   	NULL
>   };
>   
> 
