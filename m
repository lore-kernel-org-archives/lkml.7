Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98570C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717AB20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FennXwzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfKYQ16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:27:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40694 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfKYQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:27:58 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPG94Ds116096;
        Mon, 25 Nov 2019 16:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Ozj67Jx8rsVBGI2LZIF1JcPq6UpIs76jAtotIqJKFIQ=;
 b=FennXwzGvPbvbeKjFDo1f177eq1Ef+oXqgdzTHt5bi2LQjVLu/ChuCJY3n/obDYZZnfO
 evuM0GtrR+kWCpwT8r/ab02Ye+ZHc1aQQwzyabu+3T2/hX8WVGUcK8veoOamhmR8FLmS
 ATqtsFLSkoYNdgFzAi9oZuLOiGPdWDuBsvOaIrtty+8RP4FdKlqnS8TKylqt02plhp0b
 Q95AoL2M0osq2dnhscs3QH8n1mDfU5+vuPGRtyVuzKzRqOEfJY6fYkdFDatmH+GjGYNl
 uZThZEsp4uAULTPNiOfjb98GcI2z6Id1S9Fi3bA2pFQUFDziDqFwmfMJ5bserMVz3BgA Kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wevqq0scx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 16:27:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPG8I2N055296;
        Mon, 25 Nov 2019 16:27:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wfewaqgnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 16:27:46 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAPGRh4G008991;
        Mon, 25 Nov 2019 16:27:43 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 08:27:43 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 2164A6A0133; Mon, 25 Nov 2019 11:31:11 -0500 (EST)
Date:   Mon, 25 Nov 2019 11:31:11 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Jayshri Dajiram Pawar <jpawar@cadence.com>
Cc:     Roger Quadros <rogerq@ti.com>, Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC PATCH] usb: gadget: f_tcm: Added DMA32 flag while
 allocation of command buffer
Message-ID: <20191125163111.GB21800@char.us.oracle.com>
References: <1573640672-10344-1-git-send-email-jpawar@cadence.com>
 <20191114025301.GD30608@b29397-desktop>
 <5b567d57-6206-24cf-5886-20e8b5a92a45@ti.com>
 <MN2PR07MB6288D92B4AB6CF1B622A797CC1700@MN2PR07MB6288.namprd07.prod.outlook.com>
 <cefc03a1-b70a-bb40-289e-fbf4f9c79faf@ti.com>
 <20191115180215.GC23860@char.us.oracle.com>
 <MN2PR07MB6288E654268FBEB6DFC36F6FC1490@MN2PR07MB6288.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR07MB6288E654268FBEB6DFC36F6FC1490@MN2PR07MB6288.namprd07.prod.outlook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=977
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

. massive snip..
> > > Why is swiotlb buffer getting full? How much is it on your system?
> 
> On our system swiotlb max mapping size is 256KB.
> UASP receive data state tries to queue and map buffer of length 524288 (512KB), which is greater than 256KB that's why swiotlb buffer is getting full.

What is the reason for the UASP not being able to break the buffer in say two
256KB sg entries?

> 
> > > Are you sure that dma_unmap is happening on requests that complete?
> > else we'll just keep hogging the swiotlb buffer.
> 
> Yes, dma_unmap is happening on requests that complete.
> 
> I could map buffer of length 512KB with  IO_TLB_SEGSIZE changed to 256.
> With this max mapping size is increased to  256*2048 = 512KB.

If we go this route (which I rather dislike as this is a workaround, because
what if the next time there is 1MB buffer? Do we keep on increasing this?) - then
this should be dynamic and an option on the 'swiotlb' command line.
