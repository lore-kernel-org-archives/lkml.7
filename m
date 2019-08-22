Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09912C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEFD2342E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dU9mhAA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfHVI3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:29:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56386 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731051AbfHVI3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:29:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7M8T2Ge082986;
        Thu, 22 Aug 2019 08:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ESxl8CBY1GOljdugvc2JxeIFo2luM3a4IAGiMVGl4Xo=;
 b=dU9mhAA/VbEAqBez6N08RYpOTLCHYvwhusgL/cLHEkuZLx1YT7eS3hc+Hx4PIgwcqGK2
 xd+b4h8D3sJg15xC1qElgD2boCaPPMYgdSm3+oI2cuhWwvbSkjgFnStTfk2UEHqtUA7e
 u6LnKxQrobXBuI/LyWIC6wViCLbUwuf2/mWZXDg5G4oG9BXmpNqQwnrc9Lavlc5vvPLv
 IykmyK/Xxks9l34fZ/ur8oj6lTL8z3M8mGmHcwc4St4aVwL7R1fY8JfmCQb915C7IhRG
 pDrA1fCDA0zUThwpYkeALqAQzs7sxeqqWtT0W7O9JcWRWBIvhfnz7jY/bYLlpVuNxciK IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ue90tuv3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 08:29:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7M8Sul5103153;
        Thu, 22 Aug 2019 08:29:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2uh2q5ma4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 08:29:01 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7M8Sceb029421;
        Thu, 22 Aug 2019 08:28:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Aug 2019 01:28:38 -0700
Date:   Thu, 22 Aug 2019 11:28:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/4] misc: xilinx_sdfec: Fix a couple small information
 leaks
Message-ID: <20190822082831.GH3964@kadam>
References: <20190821070606.GA26957@mwanda>
 <58e9a151-3d92-c730-eea6-5cfde90934a4@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e9a151-3d92-c730-eea6-5cfde90934a4@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=854
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908220093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=913 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908220093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:14:12AM +0200, Michal Simek wrote:
> Hi Dan,
> 
> On 21. 08. 19 9:06, Dan Carpenter wrote:
> > These structs have holes in them so we end up disclosing a few bytes of
> > uninitialized stack data.
> > 
> > drivers/misc/xilinx_sdfec.c:305 xsdfec_get_status() warn: check that 'status' doesn't leak information (struct has a hole after 'activity')
> > drivers/misc/xilinx_sdfec.c:449 xsdfec_get_turbo() warn: check that 'turbo_params' doesn't leak information (struct has a hole after 'scale')
> 
> Who is generating these warnings? Is this any new GCC or different tool?
> I see that 3byte padding but never seen these warnings.

This is a Smatch check.

regards,
dan carpenter

