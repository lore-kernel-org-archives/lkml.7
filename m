Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D39C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE1D218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2k0c56Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfC3HS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:18:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58048 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfC3HS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 03:18:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2U79Cbr152247;
        Sat, 30 Mar 2019 07:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=TqIhANlSAZ7he7/qwtLeJ2FOnRFKEvESXCWeBVZuEIs=;
 b=W2k0c56QYZFimZJn/Vs+00pJFNLJKqI9D1xzqc1t9V/rNjuYkqB84d4+XJrh9mRkpGYH
 vrYcgI3NSnyDNkfp6POJ7e1almuB0HlTd3eAmMOveFKogWaIdp88UKKGh2RsuQXjP4ch
 KhiytBQ/kRfZGt8RVuuL59Mgc5huW85a+y3Wkp8JB4iEzdZO3pbje7KH8yRsbBQQniDO
 vZ/O2v5Uq9xTwEm67Ftw0/VqnhBhlarQ2kJ0sXw5toSOSsD3/KQ5DmjILUhvImLxQL/8
 A+GFs7xFUEJnFXtx5Ve07rfSEroL91bIfp8tBXsKoYGPv6UIpGAdCWUksuD3R1RPDQXm KQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2rj13pracb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Mar 2019 07:18:13 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2U7IAr9003894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Mar 2019 07:18:12 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2U7I739024017;
        Sat, 30 Mar 2019 07:18:08 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 30 Mar 2019 00:18:07 -0700
Date:   Sat, 30 Mar 2019 10:17:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     kbuild-all@01.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: Re: [PATCH] net/bluetooth: Fix bound check in event handling
Message-ID: <20190330071757.GU32613@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228195939.30685-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9211 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903300051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ This is an old warning.  Sorry for missing it earlier.  I would have
  caught it when the code was merged as well so there was no real risk
  but it's just awkward.  ]

Hi Tomas,

url:    https://github.com/0day-ci/linux/commits/Tomas-Bortoli/net-bluetooth-Fix-bound-check-in-event-handling/20190301-213647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master

smatch warnings:
net/bluetooth/hci_event.c:3986 hci_inquiry_result_with_rssi_evt() warn: potential pointer math issue ('info' is a 120 bit pointer)

# https://github.com/0day-ci/linux/commit/00305742c021794f147b348d45eb10ea26e5a514
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 00305742c021794f147b348d45eb10ea26e5a514
vim +3986 net/bluetooth/hci_event.c

6039aa73 Gustavo Padovan 2012-05-23  3963  static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
807deac2 Gustavo Padovan 2012-05-17  3964  					     struct sk_buff *skb)
a9de9248 Marcel Holtmann 2007-10-20  3965  {
a9de9248 Marcel Holtmann 2007-10-20  3966  	struct inquiry_data data;
a9de9248 Marcel Holtmann 2007-10-20  3967  	int num_rsp = *((__u8 *) skb->data);
a9de9248 Marcel Holtmann 2007-10-20  3968  
a9de9248 Marcel Holtmann 2007-10-20  3969  	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
a9de9248 Marcel Holtmann 2007-10-20  3970  
a9de9248 Marcel Holtmann 2007-10-20  3971  	if (!num_rsp)
a9de9248 Marcel Holtmann 2007-10-20  3972  		return;
a9de9248 Marcel Holtmann 2007-10-20  3973  
d7a5a11d Marcel Holtmann 2015-03-13  3974  	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
1519cc17 Andre Guedes    2012-03-21  3975  		return;
1519cc17 Andre Guedes    2012-03-21  3976  
a9de9248 Marcel Holtmann 2007-10-20  3977  	hci_dev_lock(hdev);
a9de9248 Marcel Holtmann 2007-10-20  3978  
a9de9248 Marcel Holtmann 2007-10-20  3979  	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
138d22ef Szymon Janc     2011-02-17  3980  		struct inquiry_info_with_rssi_and_pscan_mode *info;
138d22ef Szymon Janc     2011-02-17  3981  		info = (void *) (skb->data + 1);
a9de9248 Marcel Holtmann 2007-10-20  3982  
e17acd40 Johan Hedberg   2011-03-30  3983  		for (; num_rsp; num_rsp--, info++) {
af58925c Marcel Holtmann 2014-07-01  3984  			u32 flags;
af58925c Marcel Holtmann 2014-07-01  3985  
00305742 Tomas Bortoli   2019-02-28 @3986  			if ((void *)(info + sizeof(info)) >
                                                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This should be (void *)info + sizeof(info).  The code you have will
break for valid uses because the pointer math error.  I notice that
this isn't merged into linux-next, but it does seem required.  I am
writing a similar fix for a different function.

Another way to write this would be:

		if ((u8 *)(info + 1) > &skb->data[skb->len]) {


00305742 Tomas Bortoli   2019-02-28  3987  			   (void *)(skb->data + skb->len))
00305742 Tomas Bortoli   2019-02-28  3988  				break;
00305742 Tomas Bortoli   2019-02-28  3989  
a9de9248 Marcel Holtmann 2007-10-20  3990  			bacpy(&data.bdaddr, &info->bdaddr);
a9de9248 Marcel Holtmann 2007-10-20  3991  			data.pscan_rep_mode	= info->pscan_rep_mode;
a9de9248 Marcel Holtmann 2007-10-20  3992  			data.pscan_period_mode	= info->pscan_period_mode;
a9de9248 Marcel Holtmann 2007-10-20  3993  			data.pscan_mode		= info->pscan_mode;
a9de9248 Marcel Holtmann 2007-10-20  3994  			memcpy(data.dev_class, info->dev_class, 3);
a9de9248 Marcel Holtmann 2007-10-20  3995  			data.clock_offset	= info->clock_offset;
a9de9248 Marcel Holtmann 2007-10-20  3996  			data.rssi		= info->rssi;
41a96212 Marcel Holtmann 2008-07-14  3997  			data.ssp_mode		= 0x00;
3175405b Johan Hedberg   2012-01-04  3998  
af58925c Marcel Holtmann 2014-07-01  3999  			flags = hci_inquiry_cache_update(hdev, &data, false);
af58925c Marcel Holtmann 2014-07-01  4000  
48264f06 Johan Hedberg   2011-11-09  4001  			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
e17acd40 Johan Hedberg   2011-03-30  4002  					  info->dev_class, info->rssi,
af58925c Marcel Holtmann 2014-07-01  4003  					  flags, NULL, 0, NULL, 0);
a9de9248 Marcel Holtmann 2007-10-20  4004  		}
a9de9248 Marcel Holtmann 2007-10-20  4005  	} else {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
