Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A9FC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B8E21670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ohai5YMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfFSGye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:54:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59314 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSGye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:54:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J6s3o1049267;
        Wed, 19 Jun 2019 06:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=DlKNJuvcASeK8pBRu937XHctNTJ0nqeBGOzXI0KJiZk=;
 b=Ohai5YMfgkYyE2gW6+kp0v734uX79EDWBfm+7mUeaNCOClTgeZ2ukG9aq4oELB8q0yMo
 spxgW5BVidnS0ZPC6wmMMiD1Dtps13S7Fvo2+UHg1vam2zH8M4+ww/UHzuE86B3L4xST
 u5wy3RpL3WfMBntDZdBJxSt9UEYtb8a5PIeX6W0YqsMsPSdM7F/Drk9BSzr4c857tGHy
 HGrfpQoSqgqlkaJ+APUPXp2mxXakX1JKcCVGI5u57hJ6gm53pZsLbifhuSZftxUucz0e
 1oENivX1K58BRP22PcgIK+Li9ZAKOmuwHu2xsWzut02YyTMXoKSMpkLZNUYwsbk14eZH +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t78099fe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 06:54:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J6rAwt042359;
        Wed, 19 Jun 2019 06:54:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t77ymwbjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 06:54:29 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5J6rD9O024098;
        Wed, 19 Jun 2019 06:53:14 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 23:53:12 -0700
Date:   Wed, 19 Jun 2019 09:53:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: kpc2000: simplify error handling in
 kp2000_pcie_probe
Message-ID: <20190619065306.GN28859@kadam>
References: <20190619063607.20722-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619063607.20722-1-simon@nikanor.nu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 08:36:07AM +0200, Simon Sandström wrote:
> We can get rid of a few iounmaps in the middle of the function by
> re-ordering the error handling labels and adding two new labels.
> 
> Signed-off-by: Simon Sandström <simon@nikanor.nu>
> ---
> 
> This change has not been tested besides by compiling. It might be good
> took take an extra look to make sure that I got everything right.
> 

You have the right instincts that when something looks really
complicated that's probably for a reason.  That attitude will serve you
well in the future!  But in this case it's staging code so the original
code is just strange.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

> Also, this change was proposed by Dan Carpenter. Should I add anything
> in the commit message to show this?

There is a Suggested-by: tag for this, but don't resend because I don't
care and I've already reviewed this version so I don't want to review
the patch again.

regards,
dan carpenter

