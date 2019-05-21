Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E176BC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B734D208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rq4TFyqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfEUPEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:04:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54098 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbfEUPEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:04:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LF1oGJ100284;
        Tue, 21 May 2019 15:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=35tZeQA6ZY3DGjuTLtn9WnT9tN8MglgeZRXykYFX0Wo=;
 b=rq4TFyqiow+82j8Ho6ihMfG8c1IKNUX05juKGjRVWrnutGhYtwzde8qdGhWNqKA5whYo
 8loF7dTrxwX+8atkZwgwl1TsAEumsgTLtYMGrgbUvwpmLR72bfPTeFFfD/Vs5vhP6Sj/
 NspMAyh/yK4UrAhB4+VRKG0u6/ZqUfTPDROnCnWcub70+I7DjIYHHnNLzMG7LAZOOuvC
 sb87KzHyxeV7ZFnEyyBWj93tB2oJ40WH+PtpBTplhhGFYnmwElP0JjEaH+Ra4oU1LEL0
 TXrcJiGc3mGovHKiN5jpf/r8GW2vqO3EDg0okxA0XEaHSe2wnm9gOsSBAv2ZO4SBryJp nA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2sj7jdp82v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 15:03:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LF1eu1016990;
        Tue, 21 May 2019 15:03:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2sks1jgjm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 15:03:21 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4LF3J4w026807;
        Tue, 21 May 2019 15:03:19 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 15:03:19 +0000
Date:   Tue, 21 May 2019 18:03:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Colin King <colin.king@canonical.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] orangefs: remove redundant assignment to variable
 buffer_index
Message-ID: <20190521150311.GL31203@kadam>
References: <20190511132700.4862-1-colin.king@canonical.com>
 <CAOg9mSQt42NQu-3nwZOCGOPx45y7G8aaiDaVe4SwotGnD9iY1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSQt42NQu-3nwZOCGOPx45y7G8aaiDaVe4SwotGnD9iY1A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210094
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 12:06:31PM -0400, Mike Marshall wrote:
> Hi Colin...
> 
> Thanks for the patch. Before I initialized buffer_index, Dan Williams sent
> in a warning that a particular error path could try to use ibuffer_index
> uninitialized. I could induce the problem he described with one
> of the xfstests resulting in a crashed kernel. I will try to refactor
> the code to fix the problem some other way than initializing
> buffer_index in the declaration.
> 

The only explanation I can think of is that you guys are discussing
different code.  :P

regards,
dan carpenter

