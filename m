Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C80206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ww8bqj+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCKHWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:22:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45864 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCKHW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:22:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2B7Iv7o182152;
        Mon, 11 Mar 2019 07:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=u3zdheaaMSJAaANsUPzJIyBjAAxjJIIi1UjQ3vAV0LU=;
 b=ww8bqj+h1u/3jm42mHHixZCS4EFayFYbYN0V1WfjQQnIWUCnQlDQENoNsxYrBDbqGiVZ
 G4k0ne5884zz7LQOCsSKnEFzlrKoJtG641fMp/MsMQjHrweQkqs5FajkGFSj6E99956I
 Weow7WwFJxg/YqwvpnH8DdZenjNJsI6OR2TKqUUZxYkt40v4EiyRqum8HH9ZbrDD1JKu
 tAdC+RtvYQYVkeWOKU5xGi5PJMn/3NxsB+lEjr1gdWB36wrD2EDs5/szRXALKLbebXGW
 WKiO1udKfTuie2gEOp8hL3q+TwWxZWxysaFwH3Tw5ztmeLYbWgREP/V02japMXQIEQmG 2w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r464r4gjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 07:22:19 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2B7MIUv026262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 07:22:18 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2B7MHAv001679;
        Mon, 11 Mar 2019 07:22:17 GMT
Received: from kadam (/197.157.34.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 00:22:16 -0700
Date:   Mon, 11 Mar 2019 10:22:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: sh-sci: Missing uart_unregister_driver() on
 error in sci_probe_single()
Message-ID: <20190311072201.GA2434@kadam>
References: <20190308142310.112914-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308142310.112914-1-maowenan@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9191 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:23:10PM +0800, Mao Wenan wrote:
> Add the missing uart_unregister_driver() before return
> from sci_probe_single() in the error handling case.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/tty/serial/sh-sci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 64bbeb7d7e0c..dde4eac9d222 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3254,8 +3254,10 @@ static int sci_probe_single(struct platform_device *dev,
>  	mutex_unlock(&sci_uart_registration_lock);
>  
>  	ret = sci_init_single(dev, sciport, index, p, false);
> -	if (ret)
> +	if (ret) {
> +		uart_unregister_driver(&sci_uart_driver);
>  		return ret;

Why only this error path and not the next one?

> +	}
>  
>  	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
>  	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
            ^^^^^^^^^^^^^^^^^^^^^
This one.

regards,
dan carpenter

