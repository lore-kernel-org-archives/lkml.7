Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07872C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B9C2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="EH2gqenm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLIO27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:28:59 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:55955 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLIO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575901739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X1P5ZS66O+SyV3Z0pG3ySBc5zDyuUajrOIBHrzr8Pms=;
  b=EH2gqenm9Iv6+PdaymFKCdHBdr1KRQJR+nXxnqIcKj1IYX3mM6G4Oa0t
   xgtALdDRhsCihQOgIfncGZJbNgprWRQ22QcEZAjNQ6EZrZ/+HdTvR9lwM
   lfTsGh5Zh/MpvoocaoJr1BcePvnig8xmgsnlmUmlnt5DoA2Dc+FblYeFG
   w=;
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
IronPort-SDR: a1ru/4XWSvrJrh5euaNnkOw8Vn3o3G46oijEi/FPyzJJ5TLvObjfsKXIaMgNz5CM0IqGTp3qc5
 NKJSNxeQQkbuDEB0EqCCu+3gryAHE1mLeXG3H7Dmucqllf79phmdJt0RvpKjbrz1TcKdPaV+Qa
 a/DvXG50rPXGHbnFS0pDCNSVnVX/hoAYQmmbAvyKX9TVwCttsWCQlnqmmrnFPoBKrSC0nQ50zH
 2CANj0bjodv3B6IMfPEnJIN8sKz9KkOB1CxplML9TB/kUiwIowKQRH/nwzVmjkWuM+spastILk
 S4g=
X-SBRS: 2.7
X-MesageID: 9395324
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,296,1571716800"; 
   d="scan'208";a="9395324"
Date:   Mon, 9 Dec 2019 15:28:52 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     "Durrant, Paul" <pdurrant@amazon.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Message-ID: <20191209142852.GW980@Air-de-Roger>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
 <19b5c2fa36b842e58bbdddd602c4e672@EX13D32EUC003.ant.amazon.com>
 <20191209122537.GV980@Air-de-Roger>
 <54e3cd3a42d8418d9a36388315deab13@EX13D32EUC003.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54e3cd3a42d8418d9a36388315deab13@EX13D32EUC003.ant.amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 12:40:47PM +0000, Durrant, Paul wrote:
> > -----Original Message-----
> > From: Roger Pau Monné <roger.pau@citrix.com>
> > Sent: 09 December 2019 12:26
> > To: Durrant, Paul <pdurrant@amazon.com>
> > Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org; Juergen
> > Gross <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>;
> > Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
> > closed
> > 
> > On Mon, Dec 09, 2019 at 12:01:38PM +0000, Durrant, Paul wrote:
> > > > -----Original Message-----
> > > > From: Roger Pau Monné <roger.pau@citrix.com>
> > > > Sent: 09 December 2019 11:39
> > > > To: Durrant, Paul <pdurrant@amazon.com>
> > > > Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org;
> > Juergen
> > > > Gross <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>;
> > > > Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > > Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is
> > forced to
> > > > closed
> > > >
> > > > On Thu, Dec 05, 2019 at 02:01:21PM +0000, Paul Durrant wrote:
> > > > > Only force state to closed in the case when the toolstack may need
> > to
> > > > > clean up. This can be detected by checking whether the state in
> > xenstore
> > > > > has been set to closing prior to device removal.
> > > >
> > > > I'm not sure I see the point of this, I would expect that a failure to
> > > > probe or the removal of the device would leave the xenbus state as
> > > > closed, which is consistent with the actual driver state.
> > > >
> > > > Can you explain what's the benefit of leaving a device without a
> > > > driver in such unknown state?
> > > >
> > >
> > > If probe fails then I think it should leave the state alone. If the
> > > state is moved to closed then basically you just killed that
> > > connection to the guest (as the frontend will normally close down
> > > when it sees this change) so, if the probe failure was due to a bug
> > > in blkback or, e.g., a transient resource issue then it's game over
> > > as far as that guest goes.
> > 
> > But the connection can be restarted by switching the backend to the
> > init state again.
> 
> Too late. The frontend saw closed and you already lost.
> 
> > 
> > > The ultimate goal here is PV backend re-load that is completely
> > transparent to the guest. Modifying anything in xenstore compromises that
> > so we need to be careful.
> > 
> > That's a fine goal, but not switching to closed state in
> > xenbus_dev_remove seems wrong, as you have actually left the frontend
> > without a matching backend and with the state not set to closed.
> > 
> 
> Why is this a problem? With this series fully applied a (block) backend can come and go without needing to change the state. Relying on guests to DTRT is not a sustainable option for a cloud deployment.
> 
> > Ie: that would be fine if you explicitly state this is some kind of
> > internal blkback reload, but not for the general case where blkback
> > has been unbound. I think we need someway to difference a blkback
> > reload vs a unbound.
> > 
> 
> Why do we need that though? Why is it advantageous for a backend to go to closed. No PV backends cope with an unbind as-is, and a toolstack initiated unplug will always set state to 5 anyway. So TBH any state transition done directly in the xenbus code looks wrong to me anyway (but appears to be a necessary evil to keep the toolstack working in the event it spawns a backend where there is actually to driver present, or it doesn't come online).

IMO the normal flow for unbind would be to attempt to close open
connections and then remove the driver: leaving frontends connected
without any attached backends is not correct, and will just block the
guest frontend until requests start timing out.

I can see the reasoning for doing that for the purpose of updating a
blkback module without guests noticing, but I would prefer that
leaving connections open was an option that could be given when
unbinding (or maybe a driver option in sysfs?), so that the default
behaviour would be to try to close everything when unbinding if
possible.

Thanks, Roger.
