Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A70C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDAF206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="voaf1z+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfCKMqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:46:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32776 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfCKMqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:46:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2BChWbY065629;
        Mon, 11 Mar 2019 12:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=+ACjL87tByM3JFvyUxB4JR80HaK25MypTng9GMcUFm4=;
 b=voaf1z+zG3ruS1CRNs8Yfyr+2KT5yML2uoAAKs8yLre5FsbAA2+Q9RWDJ+UtaXExMwPr
 snPZqQJmBg2roBjt+BPaPfFIngYipRBCEfkEbqz9ksvEsXaPZw/44WQWAWxhXBUNm5dL
 E38oBTfWPfilJBaQr5SQaiW6QxwjQOSKKkIfnyXDVthqKaelGnCzeLbzMAMOyPoaEbZS
 vCbTeMRbmXRPXrP9GpQquOY4csza04EJUyLKKjmx6+mRWrN6WLuSlTFNlBwax12YRZKV
 ocnmbkvRfKfluCa17Hfxd7e3sRH6NQpe2HBFuA4g4lRXGfh/z+fdokPKCfidY5pWSwe9 eg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2r44wtx5cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 12:46:31 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2BCkPdT030684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 12:46:25 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2BCkOub004301;
        Mon, 11 Mar 2019 12:46:24 GMT
Received: from kadam (/197.157.34.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 12:46:24 +0000
Date:   Mon, 11 Mar 2019 15:46:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: sh-sci: Missing uart_unregister_driver() on
 error in sci_probe_single()
Message-ID: <20190311124616.GE2412@kadam>
References: <20190311095115.156774-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311095115.156774-1-maowenan@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9191 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 05:51:15PM +0800, Mao Wenan wrote:
> Add the missing uart_unregister_driver() before return
> from sci_probe_single() in the error handling case.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---

Sorry, I didn't really look at the code when I saw the v1 patch.

There are other error paths, but actually the whole approach is wrong.
Please, read my google plus post about error handling:

https://plus.google.com/u/0/106378716002406849458/posts/1Ud9JbaYnPr

But then the other rule I didn't mention in that post which applies
here is that the error handling should "mirror" the allocation code
so if you have:

	if (foo) {
		ret = allocate_one();
		if (ret)
			return ret;
	}
	ret = allocate_two();
	if (ret)
		goto free_one;

The error handling should mirror the "if (foo) " condition.  Like this:

free_one:
	if (foo)
		free_one();

Even if you can do extra analysis and find that the "if (foo) " can
be removed, you should leave there, because the mirroring helps human
readers.

In this case, the code is doing:

drivers/tty/serial/sh-sci.c
  3259                  return -EBUSY;
  3260  
  3261          mutex_lock(&sci_uart_registration_lock);
  3262          if (!sci_uart_driver.state) {
                    ^^^^^^^^^^^^^^^^^^^^^^
  3263                  ret = uart_register_driver(&sci_uart_driver);
  3264                  if (ret) {
  3265                          mutex_unlock(&sci_uart_registration_lock);
  3266                          return ret;
  3267                  }
  3268          }
  3269          mutex_unlock(&sci_uart_registration_lock);
  3270  

We would have to mirror the "if (!sci_uart_driver.state) {" code.

But actually, we can't.

The first driver to hit this code is supposed to load the
sci_uart_driver.  We can't know if we are the last driver to stop using
the sci_uart_driver so we can't know if we can free it.  This looks like
a very ugly hack to me.  It should probably be using ref counters.

regards,
an carpenter
