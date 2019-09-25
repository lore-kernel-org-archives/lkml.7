Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE2DC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDADA2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M4Qrq9xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411488AbfIYDRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 23:17:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38236 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404504AbfIYDRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 23:17:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8P3F1k7116968;
        Wed, 25 Sep 2019 03:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=coZrLpMgXUFGFAXWvAwnzzWzCZYr2NPK5zunnSsQEgo=;
 b=M4Qrq9xhI0JTnO2o3MDiZ3CS6BWIb+yAJS8RGlKlYfe66iJL6Pt8Wzx0TJoZRVLuDYiN
 oOrJl2JGFOtM9qFHoqQ6nF39LLQ4fGUmD4XfYeBEGPJTISrJd3i4CZi5JxNbAgDUuoXP
 SPuTArwa9W+nqng56KU6pFLBmHY/bKVmHow0RI74eZDFbcQsXC1CNbuGHLfrrorPIpfH
 zVl2yC5NJBRcfPdqmEkrhX+bqCBMRi4/bf/KAXGhzV0kp0OknmP2vPNvw8GwikDTSS86
 PQfIqHHtO3TdCxVootG3a5Fre9XgbkssJ1JajM0PeQ+Vt0IUTfMBMNqTxznIvETk7HxA 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v5cgr1ru6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 03:17:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8P3E0ZI124482;
        Wed, 25 Sep 2019 03:17:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2v7vnx2cpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 03:17:38 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8P3HZfp022449;
        Wed, 25 Sep 2019 03:17:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Sep 2019 20:17:35 -0700
Date:   Tue, 24 Sep 2019 20:17:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     guaneryu@gmail.com, amir73il@gmail.com,
        david.oberhollenzer@sigma-star.at, ebiggers@google.com,
        yi.zhang@huawei.com, fstests@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH xfstests v2] overlay: Enable character device to be the
 base fs partition
Message-ID: <20190925031733.GB9913@magnolia>
References: <1569376448-53998-1-git-send-email-chengzhihao1@huawei.com>
 <20190925030550.GA9913@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925030550.GA9913@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909250029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909250030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 08:05:50PM -0700, Darrick J. Wong wrote:
> On Wed, Sep 25, 2019 at 09:54:08AM +0800, Zhihao Cheng wrote:
> > There is a message in _supported_fs():
> >     _notrun "not suitable for this filesystem type: $FSTYP"
> > for when overlay usecases are executed on a chararcter device based base
> 
> You can do that?
> 
> What does that even look like?

OH, ubifs.  Ok.

/me wonders if there are more places in xfstests with test -b that needs
fixing...

--D

> --D
> 
> > fs. _overay_config_override() detects that the current base fs partition
> > is not a block device, and FSTYP won't be overwritten as 'overlay' before
> > executing usecases which results in all overlay usecases become 'notrun'.
> > In addition, all generic usecases are based on base fs rather than overlay.
> > 
> > We want to rewrite FSTYP to 'overlay' before running the usecases. To do
> > this, we need to add additional character device judgments for TEST_DEV
> > and SCRATCH_DEV in _overay_config_override().
> > 
> > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > ---
> >  common/config | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/common/config b/common/config
> > index 4c86a49..a22acdb 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -550,7 +550,7 @@ _overlay_config_override()
> >  	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
> >  	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
> >  	#    overlayfs base and mount dirs inside base fs mount.
> > -	[ -b "$TEST_DEV" ] || return 0
> > +	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
> >  
> >  	# Config file may specify base fs type, but we obay -overlay flag
> >  	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> > @@ -570,7 +570,7 @@ _overlay_config_override()
> >  	export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
> >  	export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
> >  
> > -	[ -b "$SCRATCH_DEV" ] || return 0
> > +	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
> >  
> >  	# Store original base fs vars
> >  	export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
> > -- 
> > 2.7.4
> > 
