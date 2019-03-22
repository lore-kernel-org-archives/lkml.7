Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDC0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863712190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="abxfmGyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfCVKFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:05:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36600 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfCVKFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:05:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2MA42Cc107387;
        Fri, 22 Mar 2019 10:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=2RuZxhioD2XVVddKxnV7wIoBzWmB4yEHTN0zOac6Y+k=;
 b=abxfmGyyCK6jFFxefVjI2077bULPqofsIQUPFq33J7VnNy9GPPGR6gJ8Wr1vRbl6cgNV
 USaOugxplzfWYR/sWot37mWZ6DwYX43Jz4lzBMU8sjKqrCqvkvt/elqDaWMrRhAPE69i
 iASEOonYec6em6/g7fiN4TPQlDHzHRl4LElHsOGNEy7SPkj8XtvqiHvqmq8xYG85WrX5
 IZ8DFGi886g915xbyrNfLmuSC474opX7hvdkCgtMsZ+/gzY/5TeReZ/ETqdln9+2PuuD
 ULhiAHVV6CTAxwdNnF2NsyUYdh3mTKXUekOXsWFzcU/CCDUaVjZ2vuEFy8wuFywy2dTd RA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r8rjv561p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 10:05:13 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2MA5D7i021230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 10:05:13 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2MA5Cb6003751;
        Fri, 22 Mar 2019 10:05:12 GMT
Received: from kadam (/41.202.241.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Mar 2019 03:05:12 -0700
Date:   Fri, 22 Mar 2019 13:05:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     michael.hennerich@analog.com, stefan.popa@analog.com,
        alexandru.Ardelean@analog.com, dragos.bogdan@analog.com,
        jic23@kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: Help on testing ad5933 driver
Message-ID: <20190322100502.GM2202@kadam>
References: <20190321193913.q46gq3h7h63ltpgp@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321193913.q46gq3h7h63ltpgp@smtp.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9202 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903220076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:39:13PM -0300, Marcelo Schmitt wrote:
> Hello, would anyone mind helping me test ad5933 driver on actual
> hardware?  I went through this
> (https://oslongjourney.github.io/linux-kernel/experiment-one-iio-dummy/)
> tutorial so I was able to load iio_simple_dummy driver, create and
> inspect some dummy devices.  Now, as Jonathan has asked me, I would like
> to test ad5933 driver on an EVAL-AD5933 board which was donated to FLUSP
> (https://flusp.ime.usp.br/).
> 
> So far I've been hesitating to plug this device on my Debian distro
> since this
> (https://www.analog.com/media/en/technical-documentation/user-guides/UG-364.pdf)
> user guide for Windows says not to connect it before driver
> installation. Is there something that could harm the board if plugged
> on a computer without a proper driver?

The kernel shouldn't be bricking hardware...  Hardware used to be easier
to brick in olden times...

regards,
dan carpenter

