Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23338CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32542084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbfJYSTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:19:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388490AbfJYSSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:18:46 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PI82bW049675
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:18:44 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv4m3302k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:18:44 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 25 Oct 2019 19:18:42 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 19:18:38 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PIIbqP54788316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 18:18:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0FC411C04A;
        Fri, 25 Oct 2019 18:18:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBAD811C052;
        Fri, 25 Oct 2019 18:18:36 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 18:18:36 +0000 (GMT)
Subject: Re: [PATCH] tpm: Add major_version sysfs file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Date:   Fri, 25 Oct 2019 14:18:36 -0400
In-Reply-To: <20191025142847.14931-1-jsnitsel@redhat.com>
References: <20191025142847.14931-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102518-0016-0000-0000-000002BD9FC7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102518-0017-0000-0000-0000331EEABF
Message-Id: <1572027516.4532.41.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-25 at 07:28 -0700, Jerry Snitselaar wrote:
> Easily determining what TCG version a tpm device implements
> has been a pain point for userspace for a long time, so
> add a sysfs file to report the tcg version of a tpm device.

Use "TCG" uppercase consistently.
 
> 
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

thanks!

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

FYI, on my system(s) the new file is accessible as
/sys/class/tpm/tpm0/version_major.  Does this need to be documented
anywhere?


> ---
>  drivers/char/tpm/tpm-sysfs.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index edfa89160010..9372c2d6f0b3 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -309,7 +309,17 @@ static ssize_t timeouts_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(timeouts);
>  
> -static struct attribute *tpm_dev_attrs[] = {
> +static ssize_t major_version_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct tpm_chip *chip = to_tpm_chip(dev);
> +
> +	return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
> +		       ? "2.0" : "1.2");
> +}
> +static DEVICE_ATTR_RO(major_version);
> +
> +static struct attribute *tpm12_dev_attrs[] = {
>  	&dev_attr_pubek.attr,
>  	&dev_attr_pcrs.attr,
>  	&dev_attr_enabled.attr,
> @@ -320,18 +330,28 @@ static struct attribute *tpm_dev_attrs[] = {
>  	&dev_attr_cancel.attr,
>  	&dev_attr_durations.attr,
>  	&dev_attr_timeouts.attr,
> +	&dev_attr_major_version.attr,
>  	NULL,
>  };
>  
> -static const struct attribute_group tpm_dev_group = {
> -	.attrs = tpm_dev_attrs,
> +static struct attribute *tpm20_dev_attrs[] = {
> +	&dev_attr_major_version.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group tpm12_dev_group = {
> +	.attrs = tpm12_dev_attrs,
> +};
> +
> +static const struct attribute_group tpm20_dev_group = {
> +	.attrs = tpm20_dev_attrs,
>  };
>  
>  void tpm_sysfs_add_device(struct tpm_chip *chip)
>  {
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		return;
> -
>  	WARN_ON(chip->groups_cnt != 0);
> -	chip->groups[chip->groups_cnt++] = &tpm_dev_group;
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		chip->groups[chip->groups_cnt++] = &tpm20_dev_group;
> +	else
> +		chip->groups[chip->groups_cnt++] = &tpm12_dev_group;
>  }

