Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFB7C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA0F207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="eJNWy0Ar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfLILje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:39:34 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:55788 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfLILje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575891573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=39CqSIEMZVfOawQ2ymQJQJHkso0RnGhhEsi61vao+jE=;
  b=eJNWy0Arpp85BmQEBNkRUdlRTZLU5+B1Hita6WtJtgYH5y4etAEnW1qy
   /6FG9EqtwjPf9ezrncoDS700FyslRVuMDcaBORgk7MA8pXvK4yscITlPx
   ybvEFKM07CjXZthtK5VCco53h3TczbgqeAR0N2DGzARVWDGKVX+X+xYLx
   Q=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: QOjjavhu2Xb8XBPsXZWMvhL5aoSyi6XLHS1Pqi7msf0HO36Hi78MF0A3Lo/07gHXRZrdZFJZuu
 MK2J1WMOzg1z6ysUyG8Mc457o9N5/1uYaS6hGJvzzo6zc7uw3KZ22l3SI8rShKtI72dSwHXKeK
 Wqj1EQiO7h9CC8mTUo7SgIQEWKkQaDxRa97qlR0ogD8ngfQ2ISZIqf1DvkVNye1gDF9YPbfAj6
 JSexr7+ea3QfZ6XujNzi0AwHtAz3quhtWWfwmfGMRa9zXoh/c20GzhpoUs0YA1G+u10QZJKxsF
 0g8=
X-SBRS: 2.7
X-MesageID: 9741861
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,294,1571716800"; 
   d="scan'208";a="9741861"
Date:   Mon, 9 Dec 2019 12:39:26 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     Paul Durrant <pdurrant@amazon.com>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Message-ID: <20191209113926.GS980@Air-de-Roger>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191205140123.3817-3-pdurrant@amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 02:01:21PM +0000, Paul Durrant wrote:
> Only force state to closed in the case when the toolstack may need to
> clean up. This can be detected by checking whether the state in xenstore
> has been set to closing prior to device removal.

I'm not sure I see the point of this, I would expect that a failure to
probe or the removal of the device would leave the xenbus state as
closed, which is consistent with the actual driver state.

Can you explain what's the benefit of leaving a device without a
driver in such unknown state?

Thanks, Roger.
