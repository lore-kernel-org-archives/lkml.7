Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A54CC00306
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDEF206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aDRahiCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390450AbfIEP1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:27:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47084 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390422AbfIEP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:27:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85FNOQv073636;
        Thu, 5 Sep 2019 15:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=sgNDv8ws4VWpzaMwQ1tDsDkAPKMAleLKL1RufSC32vA=;
 b=aDRahiCbYhfGK4NSkRXrKpz6BK83fGPLcVY4TqL/U9pju1fPBn5L/OlCULYUdBfm6OVT
 IaXHZK/tMi9NQ8AxoeKkS1p0kpdGPL9oxyby/YiN6nc4OjDab1fkm6jUX3tJMcSRbpdD
 gRslRflIak8nsYORa6yzhubv1czQ76z8MXsVugXO2f9PNrU/vtJhdRg6Q7YygQzIKOVS
 fFSO7f18q1L++U/FzW8iBqpurXiQ04Dp3GEfzlaGparfu5r2OosSPL3oBuzBrvgASDek
 cY1gEwGw3jJpzxykwo0TogCIKx68zWkPEkaXxz60PV42BSeqvStRhdEFmCzvZuWLqgI4 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2uu4sb83nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 15:27:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85FCDRK127837;
        Thu, 5 Sep 2019 15:27:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2uu1b8rfs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 15:27:15 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x85FRCKb014039;
        Thu, 5 Sep 2019 15:27:12 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Sep 2019 08:27:11 -0700
Date:   Thu, 5 Sep 2019 11:27:10 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] trace-vmscan-postprocess: fix parsing and output
Message-ID: <20190905152710.4gndiwcqcgkp4zcq@ca-dmjordan1.us.oracle.com>
References: <20190903111342.17731-1-florian.schmidt@nutanix.com>
 <20190904204241.y6c335djr3bwm6xo@ca-dmjordan1.us.oracle.com>
 <CALOAHbA+82kfEDvzotJu50QtskqrWv6RzHyMBiHz2gXw1ySL=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbA+82kfEDvzotJu50QtskqrWv6RzHyMBiHz2gXw1ySL=Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:32:49PM +0800, Yafang Shao wrote:
> On Thu, Sep 5, 2019 at 4:42 AM Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> > I wonder if we shouldn't just get rid of the whole script, it's hard to
> > remember to keep in sync with vmscan changes and I can't think of a way to
> > remedy that short of having mm regression tests that run this.
> 
> There are some similar scripts under tools/perf/scripts/, i.e.
> compaction-times.py.
> What about intergrating these vmscan scripts into perf/scripts as well ?
> Something like vmscan-times.py...

Could be done, but I don't see how that makes it easier to keep in
sync...unless perf's tests are run regularly.
