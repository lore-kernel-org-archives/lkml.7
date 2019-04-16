Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725DAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9FB2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfDPUfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:35:03 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:58196 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728734AbfDPUfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:35:02 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GKW67j031087;
        Tue, 16 Apr 2019 20:34:33 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 2rwj9629nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Apr 2019 20:34:33 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id BD21855;
        Tue, 16 Apr 2019 20:34:32 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 1D9E64A;
        Tue, 16 Apr 2019 20:34:31 +0000 (UTC)
Date:   Tue, 16 Apr 2019 14:34:31 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190416203431.GA20072@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:25:05PM +0200, Wolfram Sang wrote:
> The core will print out details now.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/watchdog/hpwdt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index ef30c7e9728d..db1bf6f546ae 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -311,8 +311,7 @@ static int hpwdt_init_one(struct pci_dev *dev,
>  		goto error_init_nmi_decoding;
>  
>  	watchdog_set_nowayout(&hpwdt_dev, nowayout);
> -	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
> -		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
> +	watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL);

I applied patches 1,2 & 6 in testing.

Note, that hpwdt is passing NULL as the third parameter to watchdog_init_timeout().

The second patch in this series is using "dev" as input to dev_err and dev_warn.

This results in the following in dmesg when trying to load hpwdt w/ an invalid soft_margin:


[   80.848160] (NULL device *): driver supplied timeout (4294967295) out of range
[   80.855429] (NULL device *): falling back to default timeout (30)


if the call in hpwdt driver is changed to:

	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, &dev->dev))


We see the message like we'd desire:

[ 2061.167100] hpwdt 0000:01:00.0: driver supplied timeout (4294967295) out of range
[ 2061.174633] hpwdt 0000:01:00.0: falling back to default timeout (30)



watchdog_init_timeout() uses dev to "try to get the timeout_sec property"

I am not familiar with this part of the core and what effect having the hpwdt
driver pass in dev to watchdog_init_timeout would have.  (I.e. is the
change safe?)

Guenter, can you help on this question?

Note, hpwdt isn't the only watch dog device that is passing NULL to
watchdog_init_timeout.

Thanks,


Jerry


>  
>  	if (pretimeout && hpwdt_dev.timeout <= PRETIMEOUT_SEC) {
>  		dev_warn(&dev->dev, "timeout <= pretimeout. Setting pretimeout to zero\n");
> -- 
> 2.11.0

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
