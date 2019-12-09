Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC62C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0872073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="eRebafFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfLIMZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:25:49 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:24406 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfLIMZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575894349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7SWmu5ZUZZfuIJMpbgQUd3j93DLQjxI0xM82paabgDk=;
  b=eRebafFEFsRRRrR8XJfBrHndFPfSN0qTVDopenYDqhEGNf/rgp4I5Qv7
   Vvh7zp1v1rKpJV7kh1cZsul0jWv9j4XN+v+xV5PU5jjU8Akl1dl+1T7KI
   6bON/bePuJRPOGMdb2prOqmxrCrE5//kXuQYhrf+mgo/DgQt+kaTCKMVz
   U=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: umSJYKkJ0Pr3c1V4tfcnZoKOyFredea2y4NAVpAVo5U3ceELPl8EBHyhdyuU2Pp4o9eG4a9eeT
 gZUjV1CEj6fUFNl6xrITY5xltx884qRowFUWLDF9KhuxaTl3rLbosPM6Y2x/MLHF68nUC7mWgz
 Kw5MmGHcsmpb3mzLdtGtg5/XmlFCkbSBQU94pmv0XQXGJRCxWwjboItOQKanVTl5hDgfZvl8xA
 mer4yGTg/nVc/oZoexnVvUzKoli1w7qbqdtpcqvROIx0dJf3x+SBtt2wm88PuYm4V95+UBuG8t
 dxk=
X-SBRS: 2.7
X-MesageID: 9391106
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,294,1571716800"; 
   d="scan'208";a="9391106"
Date:   Mon, 9 Dec 2019 13:25:37 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     "Durrant, Paul" <pdurrant@amazon.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Message-ID: <20191209122537.GV980@Air-de-Roger>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
 <19b5c2fa36b842e58bbdddd602c4e672@EX13D32EUC003.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19b5c2fa36b842e58bbdddd602c4e672@EX13D32EUC003.ant.amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 12:01:38PM +0000, Durrant, Paul wrote:
> > -----Original Message-----
> > From: Roger Pau Monné <roger.pau@citrix.com>
> > Sent: 09 December 2019 11:39
> > To: Durrant, Paul <pdurrant@amazon.com>
> > Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org; Juergen
> > Gross <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>;
> > Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
> > closed
> > 
> > On Thu, Dec 05, 2019 at 02:01:21PM +0000, Paul Durrant wrote:
> > > Only force state to closed in the case when the toolstack may need to
> > > clean up. This can be detected by checking whether the state in xenstore
> > > has been set to closing prior to device removal.
> > 
> > I'm not sure I see the point of this, I would expect that a failure to
> > probe or the removal of the device would leave the xenbus state as
> > closed, which is consistent with the actual driver state.
> > 
> > Can you explain what's the benefit of leaving a device without a
> > driver in such unknown state?
> > 
> 
> If probe fails then I think it should leave the state alone. If the
> state is moved to closed then basically you just killed that
> connection to the guest (as the frontend will normally close down
> when it sees this change) so, if the probe failure was due to a bug
> in blkback or, e.g., a transient resource issue then it's game over
> as far as that guest goes.

But the connection can be restarted by switching the backend to the
init state again.

> The ultimate goal here is PV backend re-load that is completely transparent to the guest. Modifying anything in xenstore compromises that so we need to be careful.

That's a fine goal, but not switching to closed state in
xenbus_dev_remove seems wrong, as you have actually left the frontend
without a matching backend and with the state not set to closed.

Ie: that would be fine if you explicitly state this is some kind of
internal blkback reload, but not for the general case where blkback
has been unbound. I think we need someway to difference a blkback
reload vs a unbound.

Thanks, Roger.
