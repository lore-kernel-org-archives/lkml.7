Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEC3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362FC21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XFNu2t5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbfISAkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:40:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39472 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfISAkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:40:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8J0dX9T024573;
        Thu, 19 Sep 2019 00:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=IiS8L7N9j19Ktt7jiprEMiAHt8Lso8e0fWbUgEUG5V8=;
 b=XFNu2t5BvRu7qGRCCJQS1sWozs+CA4hh3L0XGMClLM2Cm3YnguEM8kkMdZ/FeoJTBnPR
 fjqurUlG/LDbpdST7E+qHopb8FFOZaYmlfDwkIDM8NZBWAMqDJTyIfh0nZuPlBk2WW83
 /tnT5kacddQ8RpYRr2XsY/gkGZs0j4nTPYqyiaE5/C1hd+24H4Rg/Ue7NREL9OvhxUr3
 csEkHfR5rt8rWtXOVYxuiByruFiOSDyMp8m6FMWLoNSOFpebRy5QhlE2xspTRU6bZbp2
 SXI6b5cGophHGNpOZtJU6ZfoqMRUKV9Hnj7+GxpIBk0iijootjmPzXcD859YbGSSRpB1 hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2v3vb50jge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 00:40:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8J0cKii096214;
        Thu, 19 Sep 2019 00:40:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2v3vb926j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 00:40:11 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8J0e80I029874;
        Thu, 19 Sep 2019 00:40:08 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 17:40:07 -0700
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        "sagi\@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme\@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Rakowski\, Michal" <michal.rakowski@intel.com>,
        "axboe\@fb.com" <axboe@fb.com>,
        "Baldyga\, Robert" <robert.baldyga@intel.com>
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190913111610.9958-1-robert.baldyga@intel.com>
        <20190913143709.GA8525@lst.de>
        <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
        <20190916073455.GA25515@lst.de>
        <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com>
        <20190917163909.GB34045@C02WT3WMHTD6.wdl.wdc.com>
        <20190918132611.GA16232@lst.de> <20190918170807.GA50966@C02WT3WMHTD6>
        <20190918170956.GA19639@lst.de>
Date:   Wed, 18 Sep 2019 20:40:05 -0400
In-Reply-To: <20190918170956.GA19639@lst.de> (Christoph Hellwig's message of
        "Wed, 18 Sep 2019 19:09:56 +0200")
Message-ID: <yq1h85986fu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=721
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=797 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph,

> On Wed, Sep 18, 2019 at 11:08:07AM -0600, Keith Busch wrote:
>> And yes, that bouncing is really nasty, but it's really only needed for
>> PRP, so maybe let's just not ignore that transfer mode and support
>> extended metadata iff the controller supports SGLs. We just need a
>> special SGL setup routine to weave the data and metadata.
>
> Well, what is the point?  If people really want to use metadata they
> should just buy a drive supporting the separate metadata pointer.  In
> fact I haven't had to deal with a drive that only supports interleaved
> metadata so far given how awkward that is to deal with.

Yep. There's a reason we did DIX...

-- 
Martin K. Petersen	Oracle Linux Engineering
