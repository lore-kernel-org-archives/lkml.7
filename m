Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55735C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AF42075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uvzaUue8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfD3J6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:58:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44200 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfD3J6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:58:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U9rRmA035227;
        Tue, 30 Apr 2019 09:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=JCtV/ZLtr2X4CT0OeJOY2sF0kaDDNi70kDHNC8+vCUU=;
 b=uvzaUue8m2vWFGgb3BIU5Xgr85OL4zhdxHc74C4oEkFlz4ouBbKRu12VNcFcohd+jIur
 XqVmZYutdshWiv1enve/+OV5TYurZj+ssuM7xl2MQATtfH+XnQFBs80P3mMN3wCvxqbd
 7yEVFwAkVBclZCvPDQZIg5WwQrceSHDbs6uHreUxdx03Y1foXM0ozZUzhiVFSzqzYHOI
 XeRwzFr2yMM5ZY20JDP4c6b0v3rcHhJ+C/ZgnEpIzGUXw1UGhZ59Hyy1VOkkon/ISf3W
 D8SmS+uNhqxNz8w719BWokZag5TaMy+lyOdevljfNgkfaWgxlFeZpT0mXr5GmrvsBNkV UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2s4ckdbr9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 09:58:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U9ui7q073845;
        Tue, 30 Apr 2019 09:58:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2s4ew1562p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 09:58:36 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3U9wVTb027602;
        Tue, 30 Apr 2019 09:58:31 GMT
Received: from kadam (/196.97.65.153)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 02:58:31 -0700
Date:   Tue, 30 Apr 2019 12:58:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     David Lin <dtwlin@gmail.com>, devel@driverdev.osuosl.org,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH] staging: greybus: use proper return type for
 wait_for_completion_timeout
Message-ID: <20190430095821.GD2269@kadam>
References: <1556335645-7583-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556335645-7583-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=817
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300066
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=840 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 05:27:25AM +0200, Nicholas Mc Guire wrote:
> wait_for_completion_timeout() returns unsigned long (0 on timeout or
> remaining jiffies) not int. 
> 

Yeah, but it's fine though because 10000 / 256 fits into int without a
problem.

I'm not sure this sort of patch is worth it when it's just a style
debate instead of a bugfix.  I'm a little bit torn about this.  In
Smatch, I run into this issue one in a while where Smatch doesn't know
if the timeout is less than int.  Right now I hacked the DB to say that
these functions always return < INT_MAX.

Anyway, for sure the commit message should say that it's just a cleanup
and not a bugfix.

regards,
dan carpenter

