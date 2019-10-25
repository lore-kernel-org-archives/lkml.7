Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F57CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8B221D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c0AEcHuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502520AbfJYL67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:58:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41972 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393497AbfJYL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:58:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9PBhi8N080218;
        Fri, 25 Oct 2019 11:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=OVCm2Qs1zv8zur/SF5/gMRMvq8CDHixNh16CKJ09A4M=;
 b=c0AEcHuEeFS56V1Dwq3qmcf4y8ksHyi5aTw1xw3LyGzpVWhkUPCsV7j731WYVjMoutBB
 L54TFh2yfbz3d4SWv8/xVtK4Hx60r3jlRsxJYaxg6cFoyMP0qx0LTL47Pzg8/9jmdxIp
 c6ADv73cLEBsgk1OcxBGZaKPrRuiG1uovRTqBDC/52SmB7FyQVKihCxfqTWHaL1T9TY4
 Z7wnfX6w1wRGXVatp+QPMyF3tcGYCWEEzcgHqFo1MTyN7kKKViHrDGnxuaasWyJmECXa
 Znxv1vrvtjGC316xcHDeN9gb5ymvt/OcdKO9/aN9W2FiYChGIlWM2dN2un2rlM4/CwDg Eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vqswu2ndw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 11:58:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9PBgdp3161155;
        Fri, 25 Oct 2019 11:58:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vuun11sx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 11:58:30 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9PBwRqZ015711;
        Fri, 25 Oct 2019 11:58:27 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Oct 2019 04:58:26 -0700
Date:   Fri, 25 Oct 2019 14:58:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Iago Toral Quiroga <itoral@igalia.com>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/v3d: fix double free of bin
Message-ID: <20191025115819.GA7244@kadam>
References: <20191024104801.3122-1-colin.king@canonical.com>
 <20191024123853.GH11828@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024123853.GH11828@phenom.ffwll.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:38:53PM +0200, Daniel Vetter wrote:
> On Thu, Oct 24, 2019 at 11:48:01AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Two different fixes have addressed the same memory leak of bin and
> > this now causes a double free of bin.  While the individual memory
> > leak fixes are fine, both fixes together are problematic.
> > 
> > Addresses-Coverity: ("Double free")
> > Fixes: 29cd13cfd762 ("drm/v3d: Fix memory leak in v3d_submit_cl_ioctl")
> > Fixes: 0d352a3a8a1f (" rm/v3d: don't leak bin job if v3d_job_init fails.")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> That sounds like wrong merge resolution somewhere, and we don't have those
> patches merged together in any final tree yet anywhere. What's this based
> on?
> -Daniel

linux-next.

I sent this fix to you and Stephen Rothwell yesterday so this one is
sorted already.  Stephen will apply my patch until you guys merge your
drm trees.

regards,
dan carpenter


