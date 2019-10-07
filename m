Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA9AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A0B21835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i3/yK5Mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfJGNZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:25:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36140 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJGNZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:25:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97DJEMn044722;
        Mon, 7 Oct 2019 13:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=CjAq2/qIQ+hwx+J1512MljThH+9wP2hyv7uTXzQ8/ps=;
 b=i3/yK5MrK0JFZNPBX5l974i3IlH9H9BBtbIxX5oWOGo7JVoBVKie72fW7IbWelYwRt6j
 RFduqLV/h/rz+GHDxJOEJyeabgG/AedoHFMxJGzhOue6tOy6RXX2Q3Qtap2UYBu2w6xE
 +gfkdijAx0K+maHOinBb/NAE3Ty6D2wuVPHIQpSuHR4DkH2GghY0faiMGh1buH/R60Ct
 CzP8rWKI1e8CXNshnVvDJj7YvTJzFUyCYL0pvirXXfC5FnScU4dThRIs6bYY0Wn0JFd7
 iPKHHQyxQpVE7L6CFiEyWK7nHhDp+pkwwNmlXOZQAY6dU5JZonIPM6Jih+T1frb6I+Xh FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vejku6py0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 13:25:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97DHrbC037339;
        Mon, 7 Oct 2019 13:25:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vg203rtxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 13:25:17 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x97DPEfm017826;
        Mon, 7 Oct 2019 13:25:15 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 13:25:13 +0000
Date:   Mon, 7 Oct 2019 16:25:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        James Wang <james.qian.wang@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/komeda: remove redundant assignment to pointer
 disable_done
Message-ID: <20191007132505.GV22609@kadam>
References: <20191004162156.325-1-colin.king@canonical.com>
 <20191004192720.7eiqdvsm2yv62svg@e110455-lin.cambridge.arm.com>
 <35232014-f65a-f7a1-99db-8ed91f610a77@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35232014-f65a-f7a1-99db-8ed91f610a77@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=919
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:53:44PM +0100, Colin Ian King wrote:
> On 04/10/2019 20:27, Liviu Dudau wrote:
> > On Fri, Oct 04, 2019 at 05:21:56PM +0100, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The pointer disable_done is being initialized with a value that
> >> is never read and is being re-assigned a little later on. The
> >> assignment is redundant and hence can be removed.
> > 
> > Not really true, isn't it? The re-assignment is done under the condition that
> > crtc->state->active is true. disable_done will be used regardless after the if
> > block, so we can't skip this initialisation.
> > 
> > Not sure why Coverity flags this, but I would NAK this patch.
> 
> I'm patching against the driver from linux-next so I believe this is OK
> for that. I believe your statement is true against linux which does not
> have commit:
> 
> d6cb013579e743bc7bc5590ca35a1943f2b8f3c8
> Author: Lowry Li (Arm Technology China) <Lowry.Li@arm.com>
> Date:   Fri Sep 6 07:18:06 2019 +0000
> 

It really does help reviewing patches when this is mentioned in the
commit message.

There is some debate about whether this should be mentioned as a Fixes
since it doesn't fix a bug.  I initialy felt it shouldn't be, but now
I think enough people think it should be listed as Fixes that I must be
wrong.  Either way, it's very useful information.

The other thing is that soon get_maintainer.pl will start CC'ing people
from the Fixes tag and right now Lowry Li is not CC'd so that's
unfortunate.

regards,
dan carpenter

