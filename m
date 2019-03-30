Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FC0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 08:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973B7218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 08:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x4DlHdlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfC3IXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 04:23:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47458 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfC3IXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 04:23:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2U8NUpo004021;
        Sat, 30 Mar 2019 08:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=JwYHH3ic4/NTdaL1iGDZRhwCd6PYwuMQZN5M0MjgR3A=;
 b=x4DlHdlHMWC4o9KZ7WiAJAuZ592b2hJV3zXYDhhSX1X1yUqRNTlC32a4Pcv24TIS3o/a
 fbTz/DNgDK8wAH8Wma4aNSU6QO7W+hAkzw93aCrzk4/2kizgOHMAF6JINEC58aENo1ma
 i7jazS27xmToFfuNGiN03osc7WzLlGAE4M8NKzfhiAbYjbVbHgO+RM/JGNE7Qe8ht3qN
 Hu8B0wOIp3hEg6uZtkdwq/ZnBGyR9kGLK0ocvu7B91/X8q0qt9t1/KmncR54lZN1VwpI
 kuAX8vUOFRiwl/Y9aDKufsDe1NQzdw1hQyJd2txufQeUfp5lpsVySETZ+2AkjJ4RuzKN QA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2rhyvsrk3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Mar 2019 08:23:29 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2U8NTUL011454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Mar 2019 08:23:29 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2U8NOSL012415;
        Sat, 30 Mar 2019 08:23:24 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 30 Mar 2019 01:23:23 -0700
Date:   Sat, 30 Mar 2019 11:23:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     johan.hedberg@gmail.com, netdev@vger.kernel.org,
        marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, syzkaller@googlegroups.com,
        kbuild-all@01.org, davem@davemloft.net
Subject: Re: [kbuild] [PATCH] net/bluetooth: Fix bound check in event handling
Message-ID: <20190330082310.GV32613@kadam>
References: <20190228195939.30685-1-tomasbortoli@gmail.com>
 <20190330071757.GU32613@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330071757.GU32613@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9211 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903300061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 10:17:57AM +0300, Dan Carpenter wrote:
> [ This is an old warning.  Sorry for missing it earlier.  I would have
>   caught it when the code was merged as well so there was no real risk
>   but it's just awkward.  ]
> 
> Hi Tomas,
> 
> url:    https://github.com/0day-ci/linux/commits/Tomas-Bortoli/net-bluetooth-Fix-bound-check-in-event-handling/20190301-213647
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
> 
> smatch warnings:
> net/bluetooth/hci_event.c:3986 hci_inquiry_result_with_rssi_evt() warn: potential pointer math issue ('info' is a 120 bit pointer)
> 
> # https://github.com/0day-ci/linux/commit/00305742c021794f147b348d45eb10ea26e5a514
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 00305742c021794f147b348d45eb10ea26e5a514
> vim +3986 net/bluetooth/hci_event.c
> 
> 6039aa73 Gustavo Padovan 2012-05-23  3963  static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
> 807deac2 Gustavo Padovan 2012-05-17  3964  					     struct sk_buff *skb)
> a9de9248 Marcel Holtmann 2007-10-20  3965  {
> a9de9248 Marcel Holtmann 2007-10-20  3966  	struct inquiry_data data;
> a9de9248 Marcel Holtmann 2007-10-20  3967  	int num_rsp = *((__u8 *) skb->data);
> a9de9248 Marcel Holtmann 2007-10-20  3968  
> a9de9248 Marcel Holtmann 2007-10-20  3969  	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
> a9de9248 Marcel Holtmann 2007-10-20  3970  
> a9de9248 Marcel Holtmann 2007-10-20  3971  	if (!num_rsp)
> a9de9248 Marcel Holtmann 2007-10-20  3972  		return;
> a9de9248 Marcel Holtmann 2007-10-20  3973  
> d7a5a11d Marcel Holtmann 2015-03-13  3974  	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
> 1519cc17 Andre Guedes    2012-03-21  3975  		return;
> 1519cc17 Andre Guedes    2012-03-21  3976  
> a9de9248 Marcel Holtmann 2007-10-20  3977  	hci_dev_lock(hdev);
> a9de9248 Marcel Holtmann 2007-10-20  3978  
> a9de9248 Marcel Holtmann 2007-10-20  3979  	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
> 138d22ef Szymon Janc     2011-02-17  3980  		struct inquiry_info_with_rssi_and_pscan_mode *info;
> 138d22ef Szymon Janc     2011-02-17  3981  		info = (void *) (skb->data + 1);
> a9de9248 Marcel Holtmann 2007-10-20  3982  
> e17acd40 Johan Hedberg   2011-03-30  3983  		for (; num_rsp; num_rsp--, info++) {
> af58925c Marcel Holtmann 2014-07-01  3984  			u32 flags;
> af58925c Marcel Holtmann 2014-07-01  3985  
> 00305742 Tomas Bortoli   2019-02-28 @3986  			if ((void *)(info + sizeof(info)) >
>                                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This should be (void *)info + sizeof(info).  The code you have will
                                ^^^^^^^^^^^^
				sizeof(*info)
Sorry...

regards,
dan carpenter

