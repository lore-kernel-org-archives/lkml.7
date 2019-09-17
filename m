Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F01CC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F56206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qNlof35r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391598AbfIQGeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 02:34:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60090 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387655AbfIQGeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 02:34:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8H6T0rl062376;
        Tue, 17 Sep 2019 06:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=QZJbNWf++Z67872n7yW1uz2tRZW0AIL0w9a2DxTcWBI=;
 b=qNlof35rchTuf/b01+EmLMZk9Jpnl3mhF7p0gxiKclEdsUDHfz0VEAQPGVmJVgmcgxZA
 5aROcgVQaOkHu5txY2VKn1B5+/7TzgY1O0y/h23TGggJd9quAzjD5YFxQX4ZvHr56ds8
 OaW4Hq/km95Ti89WGpLCCVOccugeYFO6FGdglIOI+cgGDH85AQVrnA/zHVKTR5Kvhlc3
 BXTRBqRoaHyvgnBiPbsV9WUWyxxsN0P8CzDmCKYNR00UZP0q6muEkgnR1VpCg8KSiSTp
 Nfv35F/63Z7m0892sar9Da7agA1OtE6I9hKA9200eL5c19+/nKaNt5h6PKCKmveT98Mh nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2v2bx2v7th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 06:34:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8H6XaAn160795;
        Tue, 17 Sep 2019 06:34:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2v2jxgtkfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 06:34:03 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8H6XvMo026025;
        Tue, 17 Sep 2019 06:33:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 23:33:57 -0700
Date:   Tue, 17 Sep 2019 09:33:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        emamd001@umn.edu, smccaman@umn.edu
Subject: Re: [PATCH] staging: comedi: drivers: prevent memory leak
Message-ID: <20190917063004.GG18977@kadam>
References: <20190917024147.26290-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917024147.26290-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=827
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909170071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=901 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909170071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 09:41:43PM -0500, Navid Emamdoost wrote:
> In das1800_attach, the buffer allocated via kmalloc_array needs to be
> released if an error happens.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Commedit calls ->detach() if the ->attach() fails so this patch would
lead to a double free.  See comedi_device_attach():

drivers/staging/comedi/drivers.c
   983          }
   984          if (!driv->attach) {
   985                  /* driver does not support manual configuration */
   986                  dev_warn(dev->class_dev,
   987                           "driver '%s' does not support attach using comedi_config\n",
   988                           driv->driver_name);
   989                  module_put(driv->module);
   990                  ret = -EIO;
   991                  goto out;
   992          }
   993          dev->driver = driv;
   994          dev->board_name = dev->board_ptr ? *(const char **)dev->board_ptr
   995                                           : dev->driver->driver_name;
   996          ret = driv->attach(dev, it);
                      ^^^^^^^^^^^^^^^^^^^^^
   997          if (ret >= 0)
   998                  ret = comedi_device_postconfig(dev);
   999          if (ret < 0) {
  1000                  comedi_device_detach(dev);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^

  1001                  module_put(driv->module);
  1002          }
  1003          /* On success, the driver module count has been incremented. */

regards,
dan carpenter

