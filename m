Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E024C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC1420652
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A0JR+F9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfCDPEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:04:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56874 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDPEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:04:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x24ExCLC074058;
        Mon, 4 Mar 2019 15:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=Jmb7OR6WedKa0aRencvDZGsGP5c8FJeKpFMOBkWkpIA=;
 b=A0JR+F9AU71iWr3jfNhIYVGEzT1kqd6msWMtzLgc5oe2CLhH+ULsLJ9xw1G8l9iaShZP
 rht2MtO7X7+MblekV6dxkr9QA4ULXaqB571FeywifugCuROvK45r0nbrPDh/U9pHJYfa
 WnfBdfuWxYUM5kxyMG3kANf6XQkZ1QxNMRNEKV8wOq/00wvP3B+yVpWTCahRoDbW6bdU
 UkkjKlHVs3RCAXYO4/QtbbJuu8pNpnQWRmSVnQuGnMiBSSXk/TqgAL0F3c/Iulg0mqbw
 i6bFilk4S2/WjEfjPjnnkPxA+6jUR+5rIIOZ20Gx200mgeHvdcy3xmkMWHadpfD1K9Tn CA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qyjfr777x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Mar 2019 15:04:33 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x24F4UoG028789
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 15:04:32 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x24F4S3Z027394;
        Mon, 4 Mar 2019 15:04:28 GMT
Received: from kadam (/197.157.34.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Mar 2019 07:04:27 -0800
Date:   Mon, 4 Mar 2019 18:04:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     kbuild-all@01.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: Re: [PATCH] net/bluetooth: Fix bound check in event handling
Message-ID: <20190304150419.GC13452@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228195939.30685-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9184 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903040110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

a9de9248 Marcel Holtmann 2007-10-20  3979  	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
138d22ef Szymon Janc     2011-02-17  3980  		struct inquiry_info_with_rssi_and_pscan_mode *info;
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

138d22ef Szymon Janc     2011-02-17  3981  		info = (void *) (skb->data + 1);
a9de9248 Marcel Holtmann 2007-10-20  3982  
e17acd40 Johan Hedberg   2011-03-30  3983  		for (; num_rsp; num_rsp--, info++) {
af58925c Marcel Holtmann 2014-07-01  3984  			u32 flags;
af58925c Marcel Holtmann 2014-07-01  3985  
00305742 Tomas Bortoli   2019-02-28 @3986  			if ((void *)(info + sizeof(info)) >
                                                                             ^^^^^^^^^^^^^^^^^^^
This is a pointer math bug.  The options to fix it are:

		if ((void *)info + sizeof(info) >

Or:
		if ((void *)(info + 1) >


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

regards,
dan carpenter

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
