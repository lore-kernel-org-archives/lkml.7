Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E9BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275C620640
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RXHqFYIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbfJVI5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:57:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55896 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbfJVI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:57:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M8sBCV143259;
        Tue, 22 Oct 2019 08:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=SFu/TFiwpeeKX8PKL3pXaA9wgPMjspuyljVipqet9AI=;
 b=RXHqFYIEnnvhHtMuYiLTp2GXmOtWrKyY7PL3m/PD187bWaJonFUQpY8to/P0D9Wd5+pw
 ZQqhs+FJw4DXjPNPDBW7dbCAriWL6ZCVr993ByrTBhS7xJvuCYD7tcUoVaaV/j6NsqJA
 RtTRbGNkNubi4C4Ijek/gZY7R+ZKHCYNgXync19JquvRDs843hTJdHX68CoHZwPZtvCY
 unYByJvAz77iBvGnyokRqAzVXxJ8weziwh/ZRB7I6KCr6fAbrNXhAM4nh3q6Ln4MVII5
 MyhDBr8qoWKywhf0g8xI8Dek+Gj1DT+cbTKbwKEJ/a6D6n0bK+TsxrcjNqoe0QxlLzce Yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4qn0q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 08:57:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M8rDwP049157;
        Tue, 22 Oct 2019 08:57:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vsp3xpt0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 08:57:22 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9M8vK2q003695;
        Tue, 22 Oct 2019 08:57:20 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 01:57:19 -0700
Date:   Tue, 22 Oct 2019 11:57:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, devel@driverdev.osuosl.org,
        outreachy-kernel@googlegroups.com,
        Jules Irenge <jbi.octave@gmail.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v1 1/5] staging: wfx: fix warnings of no space is
 necessary
Message-ID: <20191022085712.GK24678@kadam>
References: <20191019140719.2542-1-jbi.octave@gmail.com>
 <20191019140719.2542-2-jbi.octave@gmail.com>
 <20191019142443.GH24678@kadam>
 <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>
 <20191019180514.GI24678@kadam>
 <336960fdf88dbed69dd3ed2689a5fb1d2892ace8.camel@perches.com>
 <20191020191759.GJ24678@kadam>
 <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 12:36:50PM -0700, Joe Perches wrote:
> > It's sort of tricky to know what "one thing per patch means".
> 
> It seems somewhat arbitrary and based on Greg's understanding
> of the experience of the patch submitter and also the language
> of the potential commit message.

Of course the language of the commit message matters.  You have to
"sell" your commit and convince us why we should apply it.  That's a
life lesson right there...  :P

regards,
dan carpenter
