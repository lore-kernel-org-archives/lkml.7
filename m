Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310D8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF5D21881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="wYi+F6cb";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Cj4hTj+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfIQKNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:13:19 -0400
Received: from smtp105.ord1d.emailsrvr.com ([184.106.54.105]:36323 "EHLO
        smtp105.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbfIQKNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1568715197;
        bh=zBaogtQ3EoCF+64rfNf65r5QvbzLx7Mg3lSrFpdGkKM=;
        h=Subject:To:From:Date:From;
        b=wYi+F6cbUf1Dx7LxP18BTN7foALesFpO4vw1cBLHFIXjXV1yE1nNG+UUpDTp+YKc7
         yDqWPYZ006BYB/SGiIiMwpWl8fqEM6FUPCtQ+zaeRCOJx2DMyGEE2MaGRE0s4JQYFN
         8eNdS+C0H8gileZARkOSf2OIeGtODFmcF7rWbnOQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1568715197;
        bh=zBaogtQ3EoCF+64rfNf65r5QvbzLx7Mg3lSrFpdGkKM=;
        h=Subject:To:From:Date:From;
        b=Cj4hTj+xdzZchVGk7I1Oy9l9SCo4BouxiUFno5o12V9+6w+9QwOEKp7FoZs+GbzPf
         wcpRFNmNZZrl87+eW8IaNAk6/xua2APpNk7s+Q+J3NSNaXz93ERMQKUV+Ws7WDgTrK
         p/d8kliycVsrWrj4CuNa+l4Eva6Q0DVkDly9+APg=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp22.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6209AE0173;
        Tue, 17 Sep 2019 06:13:16 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 17 Sep 2019 06:13:17 -0400
Subject: Re: [PATCH] staging: comedi: drivers: prevent memory leak
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, emamd001@umn.edu, smccaman@umn.edu
References: <20190917024147.26290-1-navid.emamdoost@gmail.com>
 <20190917063004.GG18977@kadam>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <86a2ceb0-cc59-2b57-e2b0-f620a42e9ac1@mev.co.uk>
Date:   Tue, 17 Sep 2019 11:13:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917063004.GG18977@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2019 07:33, Dan Carpenter wrote:
> On Mon, Sep 16, 2019 at 09:41:43PM -0500, Navid Emamdoost wrote:
>> In das1800_attach, the buffer allocated via kmalloc_array needs to be
>> released if an error happens.
>>
>> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> 
> Commedit calls ->detach() if the ->attach() fails so this patch would
> lead to a double free.  See comedi_device_attach():
> 
> drivers/staging/comedi/drivers.c
>     983          }
>     984          if (!driv->attach) {
>     985                  /* driver does not support manual configuration */
>     986                  dev_warn(dev->class_dev,
>     987                           "driver '%s' does not support attach using comedi_config\n",
>     988                           driv->driver_name);
>     989                  module_put(driv->module);
>     990                  ret = -EIO;
>     991                  goto out;
>     992          }
>     993          dev->driver = driv;
>     994          dev->board_name = dev->board_ptr ? *(const char **)dev->board_ptr
>     995                                           : dev->driver->driver_name;
>     996          ret = driv->attach(dev, it);
>                        ^^^^^^^^^^^^^^^^^^^^^
>     997          if (ret >= 0)
>     998                  ret = comedi_device_postconfig(dev);
>     999          if (ret < 0) {
>    1000                  comedi_device_detach(dev);
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    1001                  module_put(driv->module);
>    1002          }
>    1003          /* On success, the driver module count has been incremented. */

Yes, everything should be freed properly by comedi_device_detach(). 
 From comedi_device_detach(), some of the stuff is freed by 
dev->driver->detach(), and the remainder is freed by 
comedi_device_detach_cleanup().

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
