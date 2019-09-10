Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5792BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EC62084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bbRtTRVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392395AbfIJMpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:45:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59956 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfIJMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:45:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8AChvVk087799;
        Tue, 10 Sep 2019 12:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=kPBxmrG7XhnSVDi7TSZHk3MEipMVpG8IYBW8hct14Lg=;
 b=bbRtTRVsZ07ULd4fnpUUrlkZCYxFSs1e5iGN4kXQIa6U/AhdL9pIwQgGUrzHnpZuyXXz
 /tMCqthdo0EJIx6IkBNXWz99Onn/IW6+jU4iLJjaPfgpBeePfHatuw8tHgE0wQVtk/6B
 Vu86cG0bLBidCVz5RFngm7uuYN3FmuRyIpRC1OpzldeRADVSlkQDQDICLga6S/xQD0yc
 qmp2mZAeLIuD9CXwJeHUWKd/SwAZ14IYsasPVa6Wdb5D4ytXeSAtBSEs+SlCd37zUpTK
 s7a4ExIGxeyEi8mZhDsiYKCmsPuju5NZXlPVQZVdiv7jMbBL8Zns5S/sHsnlLwrdIPt+ +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2uw1m8u4hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 12:44:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8ACiAPj191077;
        Tue, 10 Sep 2019 12:44:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2uwqktpaew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 12:44:57 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8ACio9l009207;
        Tue, 10 Sep 2019 12:44:50 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 05:44:49 -0700
Date:   Tue, 10 Sep 2019 15:44:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: staging: exfat: issue with FFS_MEDIAERR error return assignment
Message-ID: <20190910124443.GD15977@kadam>
References: <c569b04c-2959-c8eb-0d38-628e8c5ff7ac@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c569b04c-2959-c8eb-0d38-628e8c5ff7ac@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 07:38:00PM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis on exfat with Coverity has picked up an assignment of
> FFS_MEDIAERR that gets over-written:
> 
> 
> 1750        if (is_dir) {
> 1751                if ((fid->dir.dir == p_fs->root_dir) &&
> 1752                    (fid->entry == -1)) {
> 1753                        if (p_fs->dev_ejected)

Idealy we would have both a filename and a function name but this email
doesn't have either so no one knows what code you are talking about.  :P

regards,
dan carpenter
