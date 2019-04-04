Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1673C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A63206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1gMACFGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfDDTOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:14:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39108 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfDDTOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:14:44 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34J90HL054777;
        Thu, 4 Apr 2019 19:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=rsh4sNTtTPpzLzpoZK7QqGEVJD5blCoPJ8Gkq1Y+dic=;
 b=1gMACFGVbeBJQyYrjHvixqGeb4dQiBFDup8yJc5R2ViP335Ala9ZOe+Y/3Dds8NWFDlO
 yjmP2Uqc6c4CJxqW75AT4cY3pZl4uHKMa2RD4XW7iBFCkTowaoKANVvmHiBA2LONNr5a
 y0vJ3AJVl82pvDAxR+zN/PURrlOz+TUBhmHTCGnJHJdnfFtGcVv88aJpwd/RdABhL6pl
 tas6cCL7W7NPvInfRsBimZVAFw0K7pPhy+0AqYcKyqJt8vP39jrMFVCeR+OVXHEo9Kq0
 i12mhEpm70q5PAS39R4BQ7TPLoKMmU936ErgVLIGt8xMuLm+icoPFK/Jna5H2m9VEG6+ EA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rhwydh9w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 19:14:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34JDLDv176677;
        Thu, 4 Apr 2019 19:14:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2rm8f63xdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 19:14:35 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x34JETsH002127;
        Thu, 4 Apr 2019 19:14:30 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 12:14:29 -0700
Date:   Thu, 4 Apr 2019 22:14:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Timur Tabi <timur@freescale.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Mihai Caraman <mihai.caraman@freescale.com>,
        Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] fsl_hypervisor: dereferencing error pointers in ioctl
Message-ID: <20190404191420.GQ32613@kadam>
References: <20181218082003.GD32567@kadam>
 <20190404121044.a38ba5895a485abcdc57f297@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404121044.a38ba5895a485abcdc57f297@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040120
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:10:44PM -0700, Andrew Morton wrote:
> On Tue, 18 Dec 2018 11:20:03 +0300 Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > The strndup_user() function returns error pointers on error, and then
> > in the error handling we pass the error pointers to kfree().  It will
> > cause an Oops.
> > 
> 
> Looks good to me.
> 
> I guess we should fix this too?
> 

I didn't notice that.  Thanks!

regards,
dan carpenter

