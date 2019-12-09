Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431FCC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1413D207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="hWj2Es/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLIRSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:18:05 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:1068 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfLIRSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575911884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rkXopByrwPp2sBcRHNchnOCKQcjWZBRVSMRnG3CKxxA=;
  b=hWj2Es/EnaIz+WKozJcCLfhY0axG1VSn+G/PzTqOBMfKNc4hDaXAEwiV
   XdRzUkF36/UPemDe4oWmdmENVjD91Z3RDbuYAoqfPs0ls4FApnJnyG2u6
   kncNwE715PsONOk8yAjvE4L6vqrRVuVb58PwrLViYNB4/Y0oGwIE4zgxB
   8=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: efnx41IuK1BLRB1YOurKYBC7JSe4UINc6kZ+B6IPVi21FZ7VsBIv5Q6cE+Wy0wcGrL//OeIUrf
 gpJOuVyYbBevHPxeESHEL0VfDKk7oED4f1EZVjKZ+Cj4TDZx3GHic4MiuN5kQfXGgLR8Mo5Hkz
 yTPp8TBbd8Rf5NY4UgBGWMnaMy/zHff5YF1+OE50DVUzxfQ7g4wgIwExOI3XHoABJK8S5jxz3Q
 eFizofgeZYJ5QKZQt8RBSag3pjuqHIO3fWd8sOLVmePph/oZKu7p2BtWn+ROYek98hu+4e9RS+
 gVQ=
X-SBRS: 2.7
X-MesageID: 9407797
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,296,1571716800"; 
   d="scan'208";a="9407797"
Date:   Mon, 9 Dec 2019 18:17:57 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     "Durrant, Paul" <pdurrant@amazon.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Message-ID: <20191209171757.GC980@Air-de-Roger>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
 <19b5c2fa36b842e58bbdddd602c4e672@EX13D32EUC003.ant.amazon.com>
 <20191209122537.GV980@Air-de-Roger>
 <54e3cd3a42d8418d9a36388315deab13@EX13D32EUC003.ant.amazon.com>
 <20191209142852.GW980@Air-de-Roger>
 <e026926b9aea4ffe868d41828c1f4721@EX13D32EUC003.ant.amazon.com>
 <20191209151339.GZ980@Air-de-Roger>
 <b9271df6222a4fba86ec54c81b09eace@EX13D32EUC003.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b9271df6222a4fba86ec54c81b09eace@EX13D32EUC003.ant.amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 04:26:15PM +0000, Durrant, Paul wrote:
> > > If you want unbind to actually do a proper unplug then that's extra work
> > and not really something I want to tackle (and re-bind would still need to
> > be toolstack initiated as something would have to re-create the xenstore
> > area).
> > 
> > Why do you say the xenstore area would need to be recreated?
> > 
> > Setting state to closed shouldn't cause any cleanup of the xenstore
> > area, as that should already happen for example when using pvgrub
> > since in that case grub itself disconnects and already causes a
> > transition to closed and a re-attachment afterwards by the guest
> > kernel.
> > 
> 
> For some reason, when I originally tested, the xenstore area disappeared. I checked again and it did not this time. I just ended up with a frontend stuck in state 5 (because it is the system disk and won't go offline) trying to talk to a non-existent backend. Upon re-bind the backend goes into state 5 (because it sees the 5 in the frontend) and leaves the guest wedged.

Likely blkfront should go back to init state, but anyway, that's not
something that needs fixing as part of this series.

Thanks, Roger.
