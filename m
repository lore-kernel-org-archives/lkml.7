Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ED6C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DE421741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HRyajfzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfK1Hpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 02:45:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54088 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfK1Hpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 02:45:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAS7jMFU011581;
        Thu, 28 Nov 2019 07:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=OdpF9tLxLFKM7EnkRAYagcdyDm+kWt6AXF8o3UG4bMk=;
 b=HRyajfzZSaedBpO9gCM8SyuLLeUKiQaJk00s0eoc8hVckt3gaA1AV+q/ZJ6FVwyQ/W0o
 7F/iR7RmlNP/u0pnPjcm73b2QO3/CQdeSNw5JH1VklUlMCEwnPYN0f4k7Bm9ux746Z44
 b32LFfmdGVwYUh0G4S1awoYDG4Q2JEyxVFDtw8k5P7dCL8lxpIRKWi9pgyKlwlQMZT6+
 PSLFYkzNYatwp2pOyMHYJ7Xsil0Mwp2ObSl49eNFpRrjqnPHVrDWuL0jwAPfmTteCZvd
 szy5CxlWFNGkCcYyqv10C6Mw6BzqP9R+gyuYZXWx6bivGNv65Xmk6JqUT0a6PkJ8qCdy 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wevqqhxn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Nov 2019 07:45:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAS7jAWt049678;
        Thu, 28 Nov 2019 07:45:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2why49m30r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Nov 2019 07:45:21 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAS7jEpZ028073;
        Thu, 28 Nov 2019 07:45:15 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Nov 2019 23:45:14 -0800
Date:   Thu, 28 Nov 2019 10:45:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        robh+dt@kernel.org, soren.brinkmann@xilinx.com
Subject: Re: [PATCH v3 08/10] clk: clock-wizard: Make the output names unique
Message-ID: <20191128074505.GC1781@kadam>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
 <d9277db2692bb77a41dfed927cfb791bdcced17d.1574922435.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9277db2692bb77a41dfed927cfb791bdcced17d.1574922435.git.shubhrajyoti.datta@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911280065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911280065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 12:06:15PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Incase there are more than one instance of the clocking wizard.
> And if the output name given is the same then the probe fails.
> Fix the same by appending the device name to the output name to
> make it unique.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/clk/clk-xlnx-clock-wizard.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
> index 75ea745..9993543 100644
> --- a/drivers/clk/clk-xlnx-clock-wizard.c
> +++ b/drivers/clk/clk-xlnx-clock-wizard.c
> @@ -555,6 +555,9 @@ static int clk_wzrd_probe(struct platform_device *pdev)
>  		ret = -ENOMEM;
>  		goto err_disable_clk;
>  	}
> +	outputs = of_property_count_strings(np, "clock-output-names");
> +	if (outputs == 1)
> +		flags = CLK_SET_RATE_PARENT;
>  	clk_wzrd->clks_internal[wzrd_clk_mul] = clk_register_fixed_factor
>  			(&pdev->dev, clk_name,
>  			 __clk_get_name(clk_wzrd->clk_in1),
> @@ -566,9 +569,6 @@ static int clk_wzrd_probe(struct platform_device *pdev)
>  		goto err_disable_clk;
>  	}
>  
> -	outputs = of_property_count_strings(np, "clock-output-names");
> -	if (outputs == 1)
> -		flags = CLK_SET_RATE_PARENT;
>  	clk_name = kasprintf(GFP_KERNEL, "%s_mul_div", dev_name(&pdev->dev));
>  	if (!clk_name) {
>  		ret = -ENOMEM;
> @@ -591,6 +591,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
>  	/* register div per output */
>  	for (i = outputs - 1; i >= 0 ; i--) {
>  		const char *clkout_name;
> +		const char *clkout_name_wiz;
>  
>  		if (of_property_read_string_index(np, "clock-output-names", i,
>  						  &clkout_name)) {
> @@ -599,9 +600,11 @@ static int clk_wzrd_probe(struct platform_device *pdev)
>  			ret = -EINVAL;
>  			goto err_rm_int_clks;
>  		}
> +		clkout_name_wiz = kasprintf(GFP_KERNEL, "%s_%s",
> +					    dev_name(&pdev->dev), clkout_name);

If this kasprintf() crashes then clk_wzrd_register_divf() will fail.
But that was a headache to review.  Just add a check for NULL.  We need
a kfree() as well.

One alternative would be to just declare a buffer on the stack and use
snprintf().  We don't need to keep the name around after the call to
clk_wzrd_register_divf().

regards,
dan carpenter

