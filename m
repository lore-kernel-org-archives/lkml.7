Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1925C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25A52184B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="ozdscDFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfDLIEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:04:52 -0400
Received: from canardo.mork.no ([148.122.252.1]:56899 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfDLIEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:04:51 -0400
Received: from miraculix.mork.no ([IPv6:2a02:2121:34e:7a0c:4cff:dff:fef6:bcb])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x3C84Ebf014007
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Apr 2019 10:04:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1555056256; bh=TEkdjUFncQpPGr5cjnaKDc1jJA03Oku+3cZNXWXIdlQ=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=ozdscDFPm0M7yNoNVmhDnMc9RQ5Am6yBi10OnL6WJNVDgnBX39PGx2zDwRYhXUnS+
         8XPRgRphsnOfRPZ8KjgNEYrgOUYYb3Q2IfDo7AsH30bblIlkU5zrmq4EF8IQm/qBak
         cb8sXnzkLR5+fc45UWtlrq5YluWkB5IQSejuqtQo=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1hErAP-000557-Jz; Fri, 12 Apr 2019 10:04:09 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Young Xiao <92siuyang@gmail.com>
Cc:     kbuild-all@01.org, linux-usb@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg@kroah.com, mchehab@kernel.org, keescook@chromium.org,
        hans.verkuil@cisco.com, Young Xiao <YangX92@hotmail.com>
Subject: Re: [PATCH] USB: s2255 & stkwebcam: fix oops with malicious USB descriptors
Organization: m
References: <1555036767-31170-1-git-send-email-92siuyang@gmail.com>
Date:   Fri, 12 Apr 2019 10:04:09 +0200
In-Reply-To: <1555036767-31170-1-git-send-email-92siuyang@gmail.com> (Young
        Xiao's message of "Fri, 12 Apr 2019 10:39:27 +0800")
Message-ID: <878swf645i.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.3 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please mark updated patches with a version number or some other
indication that it replaces a previous patch.  Including a summary of
changes is also normal.

And speaking of normal:  We do build test our patches, don't we?


Young Xiao <92siuyang@gmail.com> writes:

> From: Young Xiao <YangX92@hotmail.com>
>
> The driver expects at least one valid endpoint. If given
> malicious descriptors that specify 0 for the number of endpoints,
> it will crash in the probe function.

No, it won't.  Did you test this?  Can you provide the oops?

This is perfectly fine as it is:

	dev =3D kzalloc(sizeof(struct s2255_dev), GFP_KERNEL);
..
	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
		endpoint =3D &iface_desc->endpoint[i].desc;
		if (!dev->read_endpoint && usb_endpoint_is_bulk_in(endpoint)) {
			/* we found the bulk in endpoint */
			dev->read_endpoint =3D endpoint->bEndpointAddress;
		}
	}

	if (!dev->read_endpoint) {
		dev_err(&interface->dev, "Could not find bulk-in endpoint\n");
		goto errorEP;
	}

>  drivers/media/usb/stkwebcam/stk-webcam.c | 6 ++++++

I didn't bother looking at this driver to see if your patch there makes
more sense.  That is your home work now.  Please explain why you believe
it is.  An actual oops would be good.

<rant>
Yes, and I do have some objections to this whole "protect against
malicious devices".  How do you intend to protect against a USB device
disguising itself as a keyboard or ethernet adapater or whatever?
Allowing potentionally malicious devices is crazy enough for USB, and it
gets completely wacko when people start talking about it in the context
of firewire or PCIe

Fixing bugs in drivers is fine. But it won't make any difference wrt
security if you connect malicious devices to your system.  Don't do that
if you want a secure system.

Allocating CVE numbers to arbitrary driver bugs is just adding
noise. This noise makes it harder for sysadmins and others to to notice
the really important problems.  No one will care anymore if every kernel
release fixes thousands of CVEs.  Which is pretty close to the truth if
you start allocating CVE numbers to any bug with a security impact.
</rant>




Bj=C3=B8rn
