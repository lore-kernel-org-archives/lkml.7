Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46A1C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8137B20700
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MkmSdRxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbfJANfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:35:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388126AbfJANfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:35:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91DXiR3058353;
        Tue, 1 Oct 2019 13:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=2S6v0Da0UQZgNufjPiiwLYA37zV4TkfepApDSqjUYWM=;
 b=MkmSdRxckjXVch/Lb4V5fl6dWFO1n6k24LEg/MHve2pTIE8NKgqipnzP+PK51UQLisPT
 nb1dJ+eBDCTaUNmlO03g7I7A3maiFvx0rDDmXF4zoohocPSZ1XRpBTGzEmmEGsMKLIa1
 ycaCAlB5+jLCHjLJvYFGVT6dme359igny3P7+xCCMRPeAjUBNCReE2Ktx3Jrg176f1Ro
 aRfAXAmXWysgJdKK9ZYH7ug+djbZRAI+SY0GOD7OWk+Dk4l0J9loTm9Y9tQ+srMpn0L5
 LzrFhOe6ycli7WaNrXqHcpk1fg8Q6UbeKE29LCyX2rngRDuJvdMybm23h+hLFVBGwHp4 Uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2va05rntuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 13:35:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91DXZLj116417;
        Tue, 1 Oct 2019 13:34:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vbsm2048s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 13:34:59 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x91DYq9J004937;
        Tue, 1 Oct 2019 13:34:53 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 06:34:52 -0700
Date:   Tue, 1 Oct 2019 16:34:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.net>,
        devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>, emamd001@umn.edu,
        Bhanusree Pola <bhanusreemahesh@gmail.com>, smccaman@umn.edu,
        Phil Reid <preid@electromag.com.au>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Staging: fbtft: fix memory leak in
 fbtft_framebuffer_alloc
Message-ID: <20191001133408.GG22609@kadam>
References: <20190930030949.28615-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930030949.28615-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 10:09:45PM -0500, Navid Emamdoost wrote:
> In fbtft_framebuffer_alloc the error handling path should take care of
> releasing frame buffer after it is allocated via framebuffer_alloc, too.
> Therefore, in two failure cases the goto destination is changed to
> address this issue.
> 
> Fixes: c296d5f9957c ("staging: fbtft: core support")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@gmail.com>

regards,
dan carpenter

