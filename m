Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61837C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C102073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="XKsiYV/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfLKKG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:06:57 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:40029 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfLKKG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576058816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5u5G6DvrHHYulwWxXP6RstYPZT7qaXjQ0DriMESzSyA=;
  b=XKsiYV/EY89O7D0ldTwTbgnqW+fOWyYlkUtjBTmZlisWFeGi34qOJGts
   Ooa+j7xWDaDAxZwex4GwFsDq81OPcf9Dcb/w9Sc7kLSmVAghntOAlSuBH
   7qs2hvhQZ0SAGqDB4nYKU6fWGsmO1SqfcXsKihxYsAkb7Ib4QuMgdGZXc
   c=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: h/++TCBi6C1mtA3r2r4COIFU7QXU1SxGYa0kvs/AAIA/HzuKOgPkJTwyZ2lmqLf9XKazfUwH7c
 xINyLWFzaAoDqJ593kmfWd85AhzpISMMLYjKcm8czhMmqnA50DPrKQjrZXl8VN5Hm+mR3gEdMK
 5CcgFiAZwpk8sYzqoJ38tPrchGtds4tWqkNkJpJ8sdb3UZWXIffyt+i4nmndyyvr7IwhjjiTCe
 H0gSssg35mwqkGBizjBWCehbnDyILPqGmgzL61k3AnZgBT6XMMYO4DkShwJKPdc3Zx/px8l0eM
 5Ps=
X-SBRS: 2.7
X-MesageID: 9642862
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,301,1571716800"; 
   d="scan'208";a="9642862"
Date:   Wed, 11 Dec 2019 11:06:27 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     Paul Durrant <pdurrant@amazon.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        "Juergen Gross" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH v2 2/4] xenbus: limit when state is forced to
 closed
Message-ID: <20191211100627.GI980@Air-de-Roger>
References: <20191210113347.3404-1-pdurrant@amazon.com>
 <20191210113347.3404-3-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191210113347.3404-3-pdurrant@amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:33:45AM +0000, Paul Durrant wrote:
> If a driver probe() fails then leave the xenstore state alone. There is no
> reason to modify it as the failure may be due to transient resource
> allocation issues and hence a subsequent probe() may succeed.
> 
> If the driver supports re-binding then only force state to closed during
> remove() only in the case when the toolstack may need to clean up. This can
> be detected by checking whether the state in xenstore has been set to
> closing prior to device removal.
> 
> NOTE: Re-bind support is indicated by new boolean in struct xenbus_driver,
>       which defaults to false. Subsequent patches will add support to
>       some backend drivers.

My intention was to specify whether you want to close the
backends on unbind in sysfs, so that an user can decide at runtime,
rather than having a hardcoded value in the driver.

Anyway, I'm less sure whether such runtime tunable is useful at all,
so let's leave it out and can always be added afterwards. At the end
of day a user wrongly doing a rmmod blkback can always recover
gracefully by loading blkback again with your proposed approach to
leave connections open on module removal.

Sorry for the extra work.

Thanks, Roger.
