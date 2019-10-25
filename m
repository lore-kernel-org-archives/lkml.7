Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B5BCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B59120578
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KyYvYWGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409204AbfJYKOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:14:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46168 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389112AbfJYKOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:14:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9PA3dRX166888;
        Fri, 25 Oct 2019 10:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=GpQlnPL9nKjLQO0BGa0/5SrRC2qgpRhJcmvY1jIKoYI=;
 b=KyYvYWGHdlZ7iiuKYbm3hWax+A8BgOysWb5jYHOifMKs3Yg0eBikXnRknRnwreBkwx+5
 LwQCuwGlltWynSwquQ74ZpPpoP9lIJ4dHBZ3x+6sWOCnDAJzwc0d6OKVwltUqsh9bfG4
 S4TxPOHbN5xdNODidOpTeSdbM+Jc/YljP67Yok+PCxTEuukbK3X09U3ibPTZVpfNMgjk
 rWz2DRdGMeS3odWBji5/GFnx8g2LqcNt2spNfQZx+uEWc4j60VQIyac4lg3FwZ2iEV0K
 YtQ4nmZ6Xzw739s7rOtFBLBGZyNlcBFV9b/EVaPIy8RQhqkN8rrmT+RILspwOYKTpvE5 ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4r9t4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 10:14:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P9vHse113652;
        Fri, 25 Oct 2019 10:14:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vug0dxmjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 10:14:32 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9PAEQim031517;
        Fri, 25 Oct 2019 10:14:26 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Oct 2019 03:14:25 -0700
Date:   Fri, 25 Oct 2019 13:14:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Joe Perches <joe@perches.com>, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] staging: exfat: Clean up return codes -
 FFS_PERMISSIONERR
Message-ID: <20191025101415.GL24678@kadam>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
 <20191024155327.1095907-5-Valdis.Kletnieks@vt.edu>
 <915cd2a3ee58222b63c14f9f1819a0aa0b379a4f.camel@perches.com>
 <1107916.1571934467@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1107916.1571934467@turing-police>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 12:27:47PM -0400, Valdis Klētnieks wrote:
> On Thu, 24 Oct 2019 09:23:33 -0700, Joe Perches said:
> > On Thu, 2019-10-24 at 11:53 -0400, Valdis Kletnieks wrote:
> 
> > >  	if (err) {
> > > -		if (err == FFS_PERMISSIONERR)
> > > +		if (err == -EPERM)
> > >  			err = -EPERM;
> > >  		else if (err == FFS_INVALIDPATH)
> > >  			err = -EINVAL;
> >
> > These test and assign to same value blocks look kinda silly.
> 
> One patch, one thing.  Those are getting cleaned up in a subsequent patch.:)

I was just giving an impromptu lecture on this last week....  The one
thing per patch means we cleanup the fallout that results from the
change.  So if you rename a function then you have re-indent the
parameters etc.  If you remove a cast from (type)(foo + bar) then
remove all the extra parentheses and so on.

(I don't have strong feelings about this patch, but I have just been
trying to explain the one thing rule recently).

regards,
dan carpenter

