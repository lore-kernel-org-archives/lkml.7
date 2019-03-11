Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01CFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3DF2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pzoo0SdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfCKJZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:25:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40694 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfCKJZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:25:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2B9Oam3097910;
        Mon, 11 Mar 2019 09:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=tJctHnSoODjst3bjOe9UZHMkwphx9SGkzhOAWbdjjBA=;
 b=Pzoo0SdUUgL6f5M4PowvqnGt2mhKTnrXlGk6sRMWWuSGyw5+Gz/4xuWCqxx7N+B4rVbO
 XohGfVAeNf5s7z8/KB1RgM94ev8F2ZNDpBJJLpHtt3Tav0A/NCF2r+sQP74Ee5d5H5Gp
 GeyZcZs8WDQ7ycjgYeKrWjKb4hPjcEtkHcPPBRutH/a2b+Ex47+JWTEC6hF7dkQYGo0a
 tEZQC8848ZS3ygyFr9CrqyiayDJnqKr1s+nYz8o/sPllUU6z1KC/fMW37VPD94dsMUAX
 KyWoQGD2RSuh6WGUYkLXoGlmsdlOKfDpw6JjPROGWEjBrap2Z7n8QsAVDUQJAL+Lkd18 5Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r464r553u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 09:25:12 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2B9P65W013352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 09:25:06 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2B9P585031205;
        Mon, 11 Mar 2019 09:25:05 GMT
Received: from kadam (/197.157.34.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 02:25:04 -0700
Date:   Mon, 11 Mar 2019 12:24:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     maowenan <maowenan@huawei.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, vz@mleia.com
Subject: Re: [PATCH serial v2] sc16is7xx: missing unregister/delete driver on
 error in sc16is7xx_init()
Message-ID: <20190311092456.GC2412@kadam>
References: <20190309025037.116449-1-maowenan@huawei.com>
 <20190311074605.GB2434@kadam>
 <9f611db1-11e3-9e9b-e7f3-d3dcc83b57f7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f611db1-11e3-9e9b-e7f3-d3dcc83b57f7@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9191 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 05:12:03PM +0800, maowenan wrote:
> 
> 
> On 2019/3/11 15:46, Dan Carpenter wrote:
> > On Sat, Mar 09, 2019 at 10:50:37AM +0800, Mao Wenan wrote:
> >> Add the missing uart_unregister_driver() and i2c_del_driver() before return
> >> from sc16is7xx_init() in the error handling case.
> >>
> >> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> >> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> >> ---
> >>  v1->v2: fix compile warning if CONFIG_SERIAL_SC16IS7XX_SPI is not exist.
> >>  drivers/tty/serial/sc16is7xx.c | 14 ++++++++++++--
> >>  1 file changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> >> index 268098681856..b9e5941ce767 100644
> >> --- a/drivers/tty/serial/sc16is7xx.c
> >> +++ b/drivers/tty/serial/sc16is7xx.c
> >> @@ -1509,7 +1509,7 @@ static int __init sc16is7xx_init(void)
> >>  	ret = i2c_add_driver(&sc16is7xx_i2c_uart_driver);
> >>  	if (ret < 0) {
> >>  		pr_err("failed to init sc16is7xx i2c --> %d\n", ret);
> >> -		return ret;
> >> +		goto err_i2c;
> >>  	}
> >>  #endif
> >>  
> >> @@ -1517,10 +1517,20 @@ static int __init sc16is7xx_init(void)
> >>  	ret = spi_register_driver(&sc16is7xx_spi_uart_driver);
> >>  	if (ret < 0) {
> >>  		pr_err("failed to init sc16is7xx spi --> %d\n", ret);
> >> -		return ret;
> >> +		goto err_spi;
> >>  	}
> >>  #endif
> >>  	return ret;
> >> +
> >> +#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
> >> +err_spi:
> >> +#endif
> >> +#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
> >> +	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
> >> +err_i2c:
> >> +#endif
> >> +	uart_unregister_driver(&sc16is7xx_uart);
> >> +	return ret;
> > 
> > This is quite ulgy.  Why not create two functions:
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index 635178cf3eed..9986cb2479ad 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1491,6 +1491,21 @@ static struct i2c_driver sc16is7xx_i2c_uart_driver = {
> >  	.id_table	= sc16is7xx_i2c_id_table,
> >  };
> >  
> > +static int __init register_sc16is7xx_i2c(void)
> > +{
> > +	return i2c_add_driver(&sc16is7xx_i2c_uart_driver);
> > +}
> > +
> > +static void __exit del_sc16is7xx_i2c(void)
> > +{
> > +	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
> > +}
> > +
> > +#else
> > +
> > +static int __init register_sc16is7xx_i2c(void) { return 0; }
> > +static void __exit del_sc16is7xx_i2c(void) {}
> > +
> >  #endif
> >  
> >  static int __init sc16is7xx_init(void)
> > 
> > Then you can remove all the ifdefs.
> ok， thank you, I will send v3. Do you mind Reviewed-by ?

I'll add after I review the patch.  :)

regards,
dan carpenter

