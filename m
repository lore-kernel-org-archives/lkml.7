Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610F6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31857208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EPNAMO1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfIDUm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:42:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37452 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfIDUmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:42:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84KTD4g119045;
        Wed, 4 Sep 2019 20:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=YfUnnnukundqVWrsSoidbyt5s7i0paUP66hvP8DLVF4=;
 b=EPNAMO1WMRlBc0rAzIdbStwfyIM4z36/PQ1vUYL/sYPIEGqh2Cp7jiM7ZyH0KM5y8AYn
 f5fCflVucD9hfItpBzwRK934lg/CYfFgDDylXT7Dmbsa6GgIt4kXFNWMh2DdSvALMJRa
 96eETO25c08U37qoM8zoYCI8ZV0Qmaq74rpdFEMIMWdWKWr3UsNegYFk8XVseJdehmBh
 92e78MASI/2JTIyrJLYun+Fl6VJ1F6cTzgo1gPP+IK4UK/cyGD2y52/RfJ4p/gpT1gdZ
 n80wbht6mrFl/4r1QZghCuNLDloUiOcCAon/q64AnMioZoILAFFL4p4HvaIAT+U8l40L xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2utm8sr30n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 20:42:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84KXCRu047799;
        Wed, 4 Sep 2019 20:42:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2usu529ue5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 20:42:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x84Kgkjd005697;
        Wed, 4 Sep 2019 20:42:46 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Sep 2019 13:42:45 -0700
Date:   Wed, 4 Sep 2019 16:42:41 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Florian Schmidt <florian.schmidt@nutanix.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 0/2] trace-vmscan-postprocess: fix parsing and output
Message-ID: <20190904204241.y6c335djr3bwm6xo@ca-dmjordan1.us.oracle.com>
References: <20190903111342.17731-1-florian.schmidt@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903111342.17731-1-florian.schmidt@nutanix.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040204
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 11:14:07AM +0000, Florian Schmidt wrote:
> This patch series updates trace-vmscan-postprocess.pl to work without
> throwing warnings and errors which stem from updates to several trace
> points.

Cc Yafang, who made (most of?) these updates.

> 3481c37ffa1d ("mm/vmscan: drop may_writepage and classzone_idx from
> direct reclaim begin template") removed "may_writepage" from
> mm_vmscan_direct_reclaim_begin, and 3b775998eca7
> ("include/trace/events/vmscan.h: drop zone id from kswapd tracepoints")
> removed "zid" from mm_vmscan_wakeup_kswapd. The output of
> mm_vmscan_lru_isolate and mm_vmscan_lru_shrink_active seems to never
> have matched the format of the trace point output since they were
> created, or at least for as long as I can tell. Patch 1 aligns the
> format parsing of the perl script with the current output of the trace
> points.

Thanks, patch 1 fixes the script for me for all tracepoints you touched.

> In addition, the tables that are printed by the script were not properly
> aligned any more, so patch 2 fixes the spacing.

Nit, not for Pages Scanned.  With your series I get

Kswapd          Kswapd      Order      Pages     Pages    Pages    Pages
Instance       Wakeups  Re-wakeup    Scanned    Rclmed  Sync-IO ASync-IO
kswapd0-175          1          0    253694     253691        3   129896               wake-0=1

> A side remark: parsing the trace output for mm_vmscan_lru_shrink_active
> has been in the script ever since it was created in 2010, but at no
> point the parsed output was ever used for anything. I updated the
> parsing code now, but I wonder if we could just get rid of that part...

I wonder if we shouldn't just get rid of the whole script, it's hard to
remember to keep in sync with vmscan changes and I can't think of a way to
remedy that short of having mm regression tests that run this.  But your
patches are an improvement for now.
