Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ED7C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3432120726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Zdk2oEwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfLILlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:41:46 -0500
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:42370 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfLILlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575891704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GzReoROje3tBp7FjKlB0oXgw2hTB34h1ddpP8D5LvGo=;
  b=Zdk2oEwbmtG2pORJZMNVVdL5jrqB/fFnIxSvN9TpuEW0jPb4e9PObegy
   KuYVqoJAle43Kf2UgmLsGv5Thk/hsndS7eiWOdl9G4B82I5/ImDTYlZtR
   aW9oUFcc9HUs/o3QyExQAegAGyimFfCFVseespD3OB6xiJ7QgzSNBtK1O
   o=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: Hm12VYnR78F0yIU6Vs5dDAXWyjZEnEngE4KcbEt+L9rMgOvnWLd9+lZvEAq3ooDyIwvLi/XKa8
 NHYIajNI8lrLjnqqYpJGPOxKzg3kuRIYuYET1hXD3y71VNmvjd91/7lVtTXI9o15/AlYCWtohG
 wOO7Paq80UomTbrY2MnK10YJ+scaydS4VYK/J0gmBDWgY7Tez/L/2+qlOmRdeWbNXDbnbazIb3
 LfsY0WlYE10LS3VoFXp7DLNL6rnJ0OC3MfKzR15mrHrqsQ0Y8/UIbNt1wZ7IxgApfXacaYd1oI
 S+k=
X-SBRS: 2.7
X-MesageID: 9942940
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,294,1571716800"; 
   d="scan'208";a="9942940"
Date:   Mon, 9 Dec 2019 12:41:37 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     Paul Durrant <pdurrant@amazon.com>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH 3/4] xen/interface: don't discard pending
 work in FRONT/BACK_RING_ATTACH
Message-ID: <20191209114137.GT980@Air-de-Roger>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-4-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191205140123.3817-4-pdurrant@amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 02:01:22PM +0000, Paul Durrant wrote:
> Currently these macros will skip over any requests/responses that are
> added to the shared ring whilst it is detached. This, in general, is not
> a desirable semantic since most frontend implementations will eventually
> block waiting for a response which would either never appear or never be
> processed.
> 
> NOTE: These macros are currently unused. BACK_RING_ATTACH(), however, will
>       be used in a subsequent patch.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Those headers come from Xen, and should be modified in Xen first and
then imported into Linux IMO.

Thanks, Roger.
