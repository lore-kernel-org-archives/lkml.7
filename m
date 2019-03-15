Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69213C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3738C218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FE36kIKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfCOQH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:07:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55126 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfCOQH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:07:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2FG6A8O193757;
        Fri, 15 Mar 2019 16:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=2FkcjCV52mdsp3KbWo1Wl7u7jfnZU9k6UUaKBtDC67s=;
 b=FE36kIKLlnQufTuYr3dHxxBQFk7PXi7KbyHbh8MhT5Jm68B8DQ7iVIa6pJNyVffzlwgy
 6OI8CszC8dxS7Pi45CLTE8jYymt8LiCLfWJnRFpYF+DnRAJH4takF2ug29q2zFYgW4Zi
 pKwxkU5cKGjGXnEZa03fJBpfcArhnEM6Ecp3v/AEEmkUbZVJbnjA40ljqDRN1FSgHuhz
 x42WU2r0yNmFKNy+aNWpVVeLjI/8UU7hviJuKF7lebhKEQzpGm2+ydTEmJS5maqmBJY7
 sYdym8t0Er87zrHoyMaD0uYFqRQZIXnh6C7f528/V44RLBbSA0rvTfMAXqtp/48vvNMN xw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r464ryjge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 16:07:19 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2FG7DUJ002019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 16:07:13 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2FG7CTt017638;
        Fri, 15 Mar 2019 16:07:12 GMT
Received: from localhost (/10.159.140.139)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 16:07:11 +0000
Date:   Fri, 15 Mar 2019 09:07:06 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: minor cleanups for 5.1-rc1
Message-ID: <20190315160706.GI4929@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9196 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a few more cleanups that trickled in for the merge window.  It's
all fixes for static checker complaints and slowly unwinding typedef
usage.  The four patches here have gone through a few days worth of
fstest runs with no new problems observed; and they merge cleanly with
master as of a few minutes ago.  Please let me know if you encounter any
problems merging them.

--D

The following changes since commit 1b9598c8fb9965fff901c4caa21fed9644c34df3:

  xfs: fix reporting supported extra file attributes for statx() (2019-03-01 08:57:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.1-merge-5

for you to fetch changes up to 6ef50fe9afae63d11220f3f66b5f4c75d09c8bf0:

  xfs: clean up xfs_dir2_leaf_addname (2019-03-12 09:19:38 -0700)

----------------------------------------------------------------
Changes since last update:
- Fix some clang/smatch/sparse warnings about uninitialized variables.
- Clean up some typedef usage.

----------------------------------------------------------------
Darrick J. Wong (3):
      xfs: clean up xfs_dir2_leafn_add
      xfs: zero initialize highstale and lowstale in xfs_dir2_leaf_addname
      xfs: clean up xfs_dir2_leaf_addname

Nathan Chancellor (1):
      xfs: Zero initialize highstale and lowstale in xfs_dir2_leafn_add

 fs/xfs/libxfs/xfs_dir2_leaf.c | 37 +++++++++++++++++--------------------
 fs/xfs/libxfs/xfs_dir2_node.c | 18 ++++++++----------
 2 files changed, 25 insertions(+), 30 deletions(-)
