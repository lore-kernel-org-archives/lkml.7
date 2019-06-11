Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA9DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591222173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EdBRRNzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391737AbfFKSe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:34:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53158 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388207AbfFKSe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:34:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BIT9GW109277;
        Tue, 11 Jun 2019 18:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=GCULdRc5X1PmYQ//RcEOPA5JPCIN5lCqVpVroF1nJ6M=;
 b=EdBRRNzOAku4uf7ui0GYlaOC8OwJiFony30fzOsnbyde57sMsR7uK4rMGDAExmmETZxc
 3fx6Yc4G1zSYQQVtTNJPbSVB536gJbxzMKJ72pmQkEl73mPEcl9iiUOTR/ERRrN0gIfo
 XLSZ9jms5WduXGFlCUGFLucic/Ow8cDcedXHklQh9IdOgBa89Dn/CpoYyHyFBLmqQZW3
 lD/TXV+B16F9Y5PIHk3MQ9Ez8cpwBKnQP4iCuiRsvcPDm9H14nrJWitpraxM45jNp/E6
 PPrr2wKFQSWpZoVgam8OyDKKy0BMJD5LHcxd2FWH18nk2zAJc/jmXk1AImgGon0X6t0O BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2t02heq5su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 18:34:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BIYpuh062494;
        Tue, 11 Jun 2019 18:34:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2t1jphkpn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 18:34:52 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5BIYptj010470;
        Tue, 11 Jun 2019 18:34:51 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 11:34:51 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id C11FD6A0116; Tue, 11 Jun 2019 14:36:09 -0400 (EDT)
Date:   Tue, 11 Jun 2019 14:36:09 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] (swiotlb) stable/for-linus-5.2
Message-ID: <20190611183609.GA12859@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=994
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Linus,

Please git pull the following tiny fix:

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.2

which has one tiny fix for ARM64 where we could allocate the SWIOTLB
twice.


 drivers/xen/swiotlb-xen.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Stefano Stabellini (1):
      xen/swiotlb: don't initialize swiotlb twice on arm64

