Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489A7C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270F824D42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfFDGqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:46:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726694AbfFDGqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:46:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x546hLH8128811
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 02:46:04 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2swjgntr1a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:46:04 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Tue, 4 Jun 2019 07:46:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 07:45:58 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x546jwk752035712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 06:45:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E576F42045;
        Tue,  4 Jun 2019 06:45:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B4DD42041;
        Tue,  4 Jun 2019 06:45:57 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.152.224.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 06:45:57 +0000 (GMT)
Subject: Re: [RFC PATCH 32/57] drivers: s390-crypto: Use
 class_device_find_by_name() helper
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-33-git-send-email-suzuki.poulose@arm.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Tue, 4 Jun 2019 08:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559577023-558-33-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19060406-0028-0000-0000-00000374D56F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060406-0029-0000-0000-00002434AB8C
Message-Id: <8d555ff8-816d-f4c4-485a-ca6015e044e9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.19 17:49, Suzuki K Poulose wrote:
> Use the new class_find_device_by_name() helper.
>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/s390/crypto/zcrypt_api.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index 1058b4b..16cad8e 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -133,12 +133,6 @@ struct zcdn_device {
>  static int zcdn_create(const char *name);
>  static int zcdn_destroy(const char *name);
>  
> -/* helper function, matches the name for find_zcdndev_by_name() */
> -static int __match_zcdn_name(struct device *dev, const void *data)
> -{
> -	return strcmp(dev_name(dev), (const char *)data) == 0;
> -}
> -
>  /* helper function, matches the devt value for find_zcdndev_by_devt() */
>  static int __match_zcdn_devt(struct device *dev, const void *data)
>  {
> @@ -152,10 +146,8 @@ static int __match_zcdn_devt(struct device *dev, const void *data)
>   */
>  static inline struct zcdn_device *find_zcdndev_by_name(const char *name)
>  {
> -	struct device *dev =
> -		class_find_device(zcrypt_class, NULL,
> -				  (void *) name,
> -				  __match_zcdn_name);
> +	struct device *dev = class_find_device_by_name(zcrypt_class,
> +							NULL, (void *) name);
>  
>  	return dev ? to_zcdn_dev(dev) : NULL;
>  }
fine with me, thanks
acked-by: Harald Freudenberger <freude@linux.ibm.com>

