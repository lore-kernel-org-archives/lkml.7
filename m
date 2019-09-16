Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7F2C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5235420650
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BhGOqd7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfIPH7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 03:59:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35202 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfIPH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:59:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8G7x5K3053148;
        Mon, 16 Sep 2019 07:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=n+dxcsH/SFNpvn+bulzJejG04vvg5UuaVG7+iOlzwns=;
 b=BhGOqd7v7+mtlsn4m26/f9i2Vd+7cKHTqjNTw9RK66IpaMxVuozrhCVbU6yZKRGHXvwU
 OVBQTgA7z5wEb55CyBFId5UDDn62U74mb8EmeT9NwQjolq8QeFVAbV8wJ29bsIyNk6Qa
 r69tgaKAVljfY6sYuJdwJQ7MxmrD8ByBPJQpWc6SqQLcG0dpbkGqmwpEFa6VvXrl8m0L
 n2bYud7vSdWAKgYkZfprkphHhJxuDbmZPoR9nKUnsGtfQgL6QtAwTO/upzXpkEHk33dp
 tYueoV/URjT2LQfwOenRFg3SRYYmyx0bBe3C4YRw07wXp7nVKDc81xP0+1tW62qLbWjD qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v0r5p5rhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 07:59:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8G7xAMn141309;
        Mon, 16 Sep 2019 07:59:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2v0nb456y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 07:59:22 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8G7xK4U014786;
        Mon, 16 Sep 2019 07:59:20 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 00:59:19 -0700
Date:   Mon, 16 Sep 2019 10:59:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     kbuild@01.org, kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Subject: Re: drivers/gpu/drm/i915/display/intel_display.c:3934
 skl_plane_stride() error: testing array offset 'color_plane' after use.
Message-ID: <20190916075913.GZ20699@kadam>
References: <20190914040858.GT20699@kadam>
 <87lfuou27c.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfuou27c.fsf@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9381 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=965
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9381 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:31:35AM +0300, Jani Nikula wrote:
> On Sat, 14 Sep 2019, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   a7f89616b7376495424f682b6086e0c391a89a1d
> > commit: df0566a641f959108c152be748a0a58794280e0e drm/i915: move modesetting core code under display/
> > date:   3 months ago
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > New smatch warnings:
> > drivers/gpu/drm/i915/display/intel_display.c:3934 skl_plane_stride() error: testing array offset 'color_plane' after use.
> > drivers/gpu/drm/i915/display/intel_display.c:16328 intel_sanitize_encoder() error: we previously assumed 'crtc' could be null (see line 16318)
> 
> Odd, what changed to provoke the warnings now? Or is the smatch test
> new?
> 

It looks like the cross function DB is out of data slightly.  Maybe
because the file moved?  On my system Smatch knows that color_plane is
0-1 and plane_state->color_plane[] is a two element array so it doesn't
print the warning.

This is just a sanity check which is never triggered.  Should the sanity
check be move?  What was originally intended?  It's hard to say.

regards,
dan carpenter

