Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFBBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B46E2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qSFeLr4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfCVNo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:44:26 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36132 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfCVNo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:44:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2MDiJnr003865;
        Fri, 22 Mar 2019 08:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553262259;
        bh=d2AbZkkUEwmDBcMa/tLS+tZS7RUiVjk9V4ll2o41QOk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qSFeLr4WzcBPB1xisdqduz3hU/JSClLtTqwe+ZwnOKM/0Wa+N4LZdJsgzRdhS8kx0
         LGynZJPyXVXZrjFVMrT7M1Q/kEfZyt5XbLGq5YZyuRY9CktFCyEbDIKIlGUGQrCq4+
         PQWyyOQhxH7a+G5SkZdohXZAVlcQaQTfe7XWKIos=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2MDiJXJ059022
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Mar 2019 08:44:19 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 08:44:18 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 08:44:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2MDiIWo001963;
        Fri, 22 Mar 2019 08:44:18 -0500
Date:   Fri, 22 Mar 2019 08:44:18 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
CC:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Message-ID: <20190322134418.GF25852@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
References: <1522324644.1746.19.camel@bootlin.com>
 <20180420142524.GB29011@uda0271908>
 <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
 <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
 <20190321130133.zllt5pqbrhiecoch@flea>
 <20190321164138.GB11121@kroah.com>
 <20190322124622.GB25852@uda0271908>
 <20190322130953.kb4llrtz2nriyfbu@flea>
 <20190322132846.GD25852@uda0271908>
 <bf2e01b54009e074140aedd0159503f14fdeb450.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf2e01b54009e074140aedd0159503f14fdeb450.camel@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 02:34:41PM +0100, Paul Kocialkowski wrote:
> Le vendredi 22 mars 2019 à 08:28 -0500, Bin Liu a écrit :
> > Again, think about an embedded product, if dr_mode is 'otg' which
> > indicates the peripheral mode will be used at some point, when and how
> > to load the gadget driver if it is not loaded automatically when Linux
> > boots up? the end user doesn't have access to the console.
> 
> Why should we think of an embedded product where the end user doesn't
> have access to the console? Unless I'm mistaken, the Linux kernel
> doesn't target commercial products where users are powerless in
> particular, and leaves out all other use cases (which may or may not be
> commercial).

Okay, this will lead to an endless argument as well, so I will only
explain why I mentioned embedded - AFAIK musb is only used in embedded
processors. then we can stop arguing on this point...

> I don't think this assumption makes any sense in Linux as a project (or
> that it's sane in any context of software development for that matter,
> but that's beside the point).
> 
> > > Because no other controller requires it and therefore it's not
> > > standard and violates the principle of least surprise?
> > 
> > I know no other controller does this, but this doesn't mean it is not
> > standard.
> > 
> > > And even without taking this into account, there's also the fact that
> > > while the *hardware* can do dual role, the software might decide
> > > otherwise. If I don't want to have support for any gadget (at all) in
> > > the end system, then why should I be forced to compile and load
> > > something I don't even want to use in the first place?
> > 
> > then dr_mode should be set to 'host' instead, you don't have to load a
> > gadget if peripheral mode will never be used.
> 
> I disagree: dr_mode describes the hardware capabilities, not what the
> software does with it.

I have different understanding, dr_mode describles the use case, not the
hardware capabilities. And software operates the hardware accordingly
based on dr_mode.

Regards,
-Bin.
