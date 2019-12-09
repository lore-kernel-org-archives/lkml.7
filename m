Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ED3C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB412080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="bRnE6rOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfLIPNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:13:47 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:6470 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575904425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=h5zgliSru0idHO50SIIs4Q0IqVaNzvYxE3bmRce49zk=;
  b=bRnE6rOO6Ema8IT+umVTKfReqZjMMStjh/jv2hFm6ToaBaxRRiHApW7D
   AWajmbXWzpfKLa9/kwoz68YwFpAtfVJzMln7uZjkooNHBPnM6fwK1M9PD
   7rRxej5ED2zqxnnVaZA9/8Ql5f58XrmUMvJcr1NCC/rLzAf3KtLej23rW
   I=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: QQ5BlvlKLebwgbeywEffOMBwx2KsmQhqmW7pDXTUDyhXxCwz5nlQ9Dx0Nt5napQu9jdXdECELm
 +1Oa5tLymCCgqqXta+0wTOBupDnV8E2i2MehBlMHSrPb+2viP0w2nThtx2MSJB5zJbqr4+A0y6
 l1PDuQqu+n4DlUsg5z+blkB5gARs+5KFiGCzpwBPO2ZrCj9wDCMkPhzxdP1jDvP74QHJNyE+Bd
 ypv+fmYehErebXklo6Yx4p2ZKiKDEIzGIj5qw2bqROot8Ju/8+8tGLEU7Xxk9gDdE045a/IJAy
 wwE=
X-SBRS: 2.7
X-MesageID: 9812590
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,296,1571716800"; 
   d="scan'208";a="9812590"
Date:   Mon, 9 Dec 2019 16:13:39 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     "Durrant, Paul" <pdurrant@amazon.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Message-ID: <20191209151339.GZ980@Air-de-Roger>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
 <19b5c2fa36b842e58bbdddd602c4e672@EX13D32EUC003.ant.amazon.com>
 <20191209122537.GV980@Air-de-Roger>
 <54e3cd3a42d8418d9a36388315deab13@EX13D32EUC003.ant.amazon.com>
 <20191209142852.GW980@Air-de-Roger>
 <e026926b9aea4ffe868d41828c1f4721@EX13D32EUC003.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e026926b9aea4ffe868d41828c1f4721@EX13D32EUC003.ant.amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 02:41:40PM +0000, Durrant, Paul wrote:
> > -----Original Message-----
> > From: Roger Pau Monné <roger.pau@citrix.com>
> > Sent: 09 December 2019 14:29
> > To: Durrant, Paul <pdurrant@amazon.com>
> > Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org; Juergen
> > Gross <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>;
> > Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
> > closed
> > 
> > On Mon, Dec 09, 2019 at 12:40:47PM +0000, Durrant, Paul wrote:
> > > > -----Original Message-----
> > > > From: Roger Pau Monné <roger.pau@citrix.com>
> > > > Sent: 09 December 2019 12:26
> > > > To: Durrant, Paul <pdurrant@amazon.com>
> > > > Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org;
> > Juergen
> > > > Gross <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>;
> > > > Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > > Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is
> > forced to
> > > > closed
> > > >
> > > > On Mon, Dec 09, 2019 at 12:01:38PM +0000, Durrant, Paul wrote:
> > > > > > -----Original Message-----
> > > > > > From: Roger Pau Monné <roger.pau@citrix.com>
> > > > > > Sent: 09 December 2019 11:39
> > > > > > To: Durrant, Paul <pdurrant@amazon.com>
> > > > > > Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org;
> > > > Juergen
> > > > > > Gross <jgross@suse.com>; Stefano Stabellini
> > <sstabellini@kernel.org>;
> > > > > > Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > > > > Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is
> > > > forced to
> > > > > > closed
> > > > > >
> > > > > > On Thu, Dec 05, 2019 at 02:01:21PM +0000, Paul Durrant wrote:
> > > > > > > Only force state to closed in the case when the toolstack may
> > need
> > > > to
> > > > > > > clean up. This can be detected by checking whether the state in
> > > > xenstore
> > > > > > > has been set to closing prior to device removal.
> > > > > >
> > > > > > I'm not sure I see the point of this, I would expect that a
> > failure to
> > > > > > probe or the removal of the device would leave the xenbus state as
> > > > > > closed, which is consistent with the actual driver state.
> > > > > >
> > > > > > Can you explain what's the benefit of leaving a device without a
> > > > > > driver in such unknown state?
> > > > > >
> > > > >
> > > > > If probe fails then I think it should leave the state alone. If the
> > > > > state is moved to closed then basically you just killed that
> > > > > connection to the guest (as the frontend will normally close down
> > > > > when it sees this change) so, if the probe failure was due to a bug
> > > > > in blkback or, e.g., a transient resource issue then it's game over
> > > > > as far as that guest goes.
> > > >
> > > > But the connection can be restarted by switching the backend to the
> > > > init state again.
> > >
> > > Too late. The frontend saw closed and you already lost.
> > >
> > > >
> > > > > The ultimate goal here is PV backend re-load that is completely
> > > > transparent to the guest. Modifying anything in xenstore compromises
> > that
> > > > so we need to be careful.
> > > >
> > > > That's a fine goal, but not switching to closed state in
> > > > xenbus_dev_remove seems wrong, as you have actually left the frontend
> > > > without a matching backend and with the state not set to closed.
> > > >
> > >
> > > Why is this a problem? With this series fully applied a (block) backend
> > can come and go without needing to change the state. Relying on guests to
> > DTRT is not a sustainable option for a cloud deployment.
> > >
> > > > Ie: that would be fine if you explicitly state this is some kind of
> > > > internal blkback reload, but not for the general case where blkback
> > > > has been unbound. I think we need someway to difference a blkback
> > > > reload vs a unbound.
> > > >
> > >
> > > Why do we need that though? Why is it advantageous for a backend to go
> > to closed. No PV backends cope with an unbind as-is, and a toolstack
> > initiated unplug will always set state to 5 anyway. So TBH any state
> > transition done directly in the xenbus code looks wrong to me anyway (but
> > appears to be a necessary evil to keep the toolstack working in the event
> > it spawns a backend where there is actually to driver present, or it
> > doesn't come online).
> > 
> > IMO the normal flow for unbind would be to attempt to close open
> > connections and then remove the driver: leaving frontends connected
> > without any attached backends is not correct, and will just block the
> > guest frontend until requests start timing out.
> > 
> > I can see the reasoning for doing that for the purpose of updating a
> > blkback module without guests noticing, but I would prefer that
> > leaving connections open was an option that could be given when
> > unbinding (or maybe a driver option in sysfs?), so that the default
> > behaviour would be to try to close everything when unbinding if
> > possible.
> 
> Well unbind is pretty useless now IMO since bind doesn't work, and a transition straight to closed is just plain wrong anyway.

Why do you claim that a straight transition into the closed state is
wrong?

I don't see any such mention in blkif.h, which also doesn't contain
any guidelines regarding closing state transitions, so unless
otherwise stated somewhere else transitions into closed can happen
from any state IMO.

> But, we could have a flag that the backend driver sets to say that it supports transparent re-bind that gates this code. Would that make you feel more comfortable?

Having an option to leave state untouched when unbinding would be fine
for me, otherwise state should be set to closed when unbinding. I
don't think there's anything else that needs to be done in this
regard, the cleanup should be exactly the same the only difference
being the setting of all the active backends to closed state.

> If you want unbind to actually do a proper unplug then that's extra work and not really something I want to tackle (and re-bind would still need to be toolstack initiated as something would have to re-create the xenstore area).

Why do you say the xenstore area would need to be recreated?

Setting state to closed shouldn't cause any cleanup of the xenstore
area, as that should already happen for example when using pvgrub
since in that case grub itself disconnects and already causes a
transition to closed and a re-attachment afterwards by the guest
kernel.

Thanks, Roger.
