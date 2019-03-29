Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA5DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A665217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="07C0KlvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfC2NdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:33:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52638 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfC2NdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:33:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TDSsh7157834;
        Fri, 29 Mar 2019 13:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=sR8mQpUZaz1+m3eNC1JjQIsU/05s3hzQ2Df/4Dqrd6Y=;
 b=07C0KlvAQH0Uu/dkS/6885TokVb4oyrTiYU7zibzdtBQEjTL+qxhFGy5MOjtzM78tuDZ
 g7YZN7zptZW8wtE0qfSUKzxtDXxy2BJvnoi261BMpL72QPG+DhU/d3MPioYPSgKS8l4a
 jGHGL2zXv0KPL84/jxzyM9lYIo82UXjbGEuyT8/4ur0GrbdvGyQKpVCk0dY5lEhxnnwf
 QFJ17dazBAXJNqfiaRMotm82+fHHkceJkb5h1Y+WsQhpyvHewvEjd42YCfgf3A63qdO/
 d+dAu4zBuH1LhXXRfVI6E6CmpoU0MqeIJvLLnkhWl617dpBAW/lzQkHbortb+dGQFpLG /g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2re6g1cdpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 13:33:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TDXEEC015332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 13:33:14 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TDXDfn005763;
        Fri, 29 Mar 2019 13:33:13 GMT
Received: from localhost (/67.161.8.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 06:33:13 -0700
Date:   Fri, 29 Mar 2019 06:33:11 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: bug fixes for 5.1-rc3
Message-ID: <20190329133311.GD18833@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a few fixes for some corruption bugs and uninitialized variable
problems.  The few patches here have gone through a few days worth of
fstest runs with no new problems observed; and they merge cleanly with
master as of a few hours ago.  Please let me know if you encounter any
problems merging them.

--D

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.1-fixes-1

for you to fetch changes up to 2032a8a27b5cc0f578d37fa16fa2494b80a0d00a:

  xfs: serialize unaligned dio writes against all other dio writes (2019-03-26 08:37:55 -0700)

----------------------------------------------------------------
Changes since last update:
- Fix a bunch of static checker complaints about uninitialized variables
  and insufficient range checks.
- Avoid a crash when incore extent map data are corrupt.
- Disallow FITRIM when we haven't recovered the log and know the
  metadata are stale.
- Fix a data corruption when doing unaligned overlapping dio writes.

----------------------------------------------------------------
Brian Foster (2):
      xfs: don't trip over uninitialized buffer on extent read of corrupted inode
      xfs: serialize unaligned dio writes against all other dio writes

Darrick J. Wong (4):
      xfs: dabtree scrub needs to range-check level
      xfs: fix btree scrub checking with regards to root-in-inode
      xfs: always init bma in xfs_bmapi_write
      xfs: prohibit fstrim in norecovery mode

 fs/xfs/libxfs/xfs_bmap.c | 15 +++++++++------
 fs/xfs/scrub/btree.c     | 11 ++++++++++-
 fs/xfs/scrub/dabtree.c   |  5 +++++
 fs/xfs/xfs_discard.c     |  8 ++++++++
 fs/xfs/xfs_file.c        | 27 +++++++++++++++++----------
 5 files changed, 49 insertions(+), 17 deletions(-)
