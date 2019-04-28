Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BF7C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 22:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC1720656
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 22:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="mH9E85Li";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zpbNGjTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfD1Wql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 18:46:41 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:32889 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbfD1Wql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 18:46:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D96CD278C0;
        Sun, 28 Apr 2019 18:46:39 -0400 (EDT)
Received: from imap37 ([10.202.2.87])
  by compute5.internal (MEProxy); Sun, 28 Apr 2019 18:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=jZvoa2zLLEWsbED5dtwYLVLnjZOOrNP
        58oC6tro8DQo=; b=mH9E85LiD9viB1S5DcGp+vGyOVnI6UAZMYA/x5WKOTHMBFE
        4HHccvi45dgH7aO0mVmqOLnVQQMuDL0EbVgEX5pcWrrjVNyVJRG86Cx0eL8+dZeW
        +FCMJT3rhLlxL3mRoND4XK44cz4DmMGW3dw4rd6NrJs5q8VS/sYaUU3JMYntQcBW
        2rGVVMF8O3knnfDVmSNv1kUpMDuVrj2L2xkOYZ435RL47jvNEQOX82b7NiyINvWL
        9oB9/C8/OMF0xxyG2NvSdyUkgN9LJXbFAxbkncGj8CPSvN53r7s1snDZ9iTziFcb
        gUMWKrsvkwh+I+dfdKA+3YbDoJB+z8D5O+md3fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jZvoa2
        zLLEWsbED5dtwYLVLnjZOOrNP58oC6tro8DQo=; b=zpbNGjTUkexEUaWMubC9rw
        +4e74+l/RW2XA/9a0C+840QFjADHgeqixqF2xrZUKCOc97Ky8DXqr65tSBznHUdA
        qksko6YzQlV4GIxLFg4JBTfzjgPQRqqi+LWGNbqRmZT8FJxOMJlaQ+Vfv8pgidya
        lEBXSUN2Vapnxe5+kspxICqbJNQppAml75Fn0hNpLSdM4mG1MVC91Ul3GRrUbrDW
        7W3CLPXeedpnZyu3WuXxbB1MlgDqrkN8rVgTTbgpyFy8JF67ownDneNjAWIFbd7N
        +kFffCfffpHG+YlAbLqaBTu1YGjgDptIUvNxwHENextKjDhB0dt7SYV+77IGUtRA
        ==
X-ME-Sender: <xms:Ty3GXFVaCirF1QrEvI54Tb627OsapZPJvf-M0w3s4X8i1sQ_BoX1Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddriedugddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepofgfggfkjghffffhvffutgesthdtredtreer
    tdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsih
    hnrdgttgeqnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Ty3GXDGEvF-veaLNYWKm9QUtfwjI99n4GjER5xG_L-RODqruHBOWxA>
    <xmx:Ty3GXNdkqYf_EWN2ouI6gtojofWMOO42CNKVOd2GPIEjcqm9cZPtQQ>
    <xmx:Ty3GXFkBXvoNcPMIK7ng7Px1-TBNTm4eRGXyPtjrLT-eJuqMPy7DDA>
    <xmx:Ty3GXNTt0436hMMMxA3blBMCWPkmddcBPHeVQrMHWUSxZq3UlOCWKA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D0CCFDEBE0; Sun, 28 Apr 2019 18:46:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-444-g755619f-fmstable-20190423v1
Mime-Version: 1.0
Message-Id: <c4caa4e2-fca4-455f-8f2d-308281762acd@www.fastmail.com>
In-Reply-To: <20190428161458.GB13309@kroah.com>
References: <20190427081330.GA26788@eros.localdomain>
 <20190427192809.GA8454@kroah.com> <20190428011957.GA18843@eros.localdomain>
 <20190428161458.GB13309@kroah.com>
Date:   Sun, 28 Apr 2019 18:46:38 -0400
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Christopher Lameter" <cl@linux.com>,
        "Tycho Andersen" <tycho@tycho.ws>, willy@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: memleak around kobject_init_and_add()
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019, at 02:15, Greg Kroah-Hartman wrote:
> On Sun, Apr 28, 2019 at 11:19:57AM +1000, Tobin C. Harding wrote:
> > On Sat, Apr 27, 2019 at 09:28:09PM +0200, Greg Kroah-Hartman wrote:
> > > On Sat, Apr 27, 2019 at 06:13:30PM +1000, Tobin C. Harding wrote:
> > > > (Note at bottom on reasons for 'To' list 'Cc' list)
> > > > 
> > > > Hi,
> > > > 
> > > > kobject_init_and_add() seems to be routinely misused.  A failed call to this
> > > > function requires a call to kobject_put() otherwise we leak memory.
> > > > 
> > > > Examples memleaks can be seen in:
> > > > 
> > > > 	mm/slub.c
> > > > 	fs/btrfs/sysfs.c
> > > > 	fs/xfs/xfs_sysfs.h: xfs_sysfs_init()
> > > > 
> > > >  Question: Do we fix the misuse or fix the API?
> > > 
> > > Fix the misuse.
> > 
> > Following on from this.  It seems we often also forget to call
> > kobject_uevent() after calls to kobject_init_and_add().
> 
> Are you sure?  Usually if you don't call it right away, it happens much
> later when you have everything "ready to go" to tell userspace that it
> then can access that kobject successfully.
> 
> Any specific places you feel is not correct?
> 
> > Before I make a goose of myself patching the whole tree is there ever
> > any reason why we would _not_ want to call kobject_uevent() after
> > successfully calling kobject_add() (or kobject_init_and_add())?
> 
> You should always do so, but again, sometimes it can be much "later"
> after everything is properly set up.
> 
> Ok, at quick glance I see some places that do not properly call this.
> But, those places should not even be using a "raw" kobject in the first
> place, they should be using 'struct device'.  If code using a kobject,
> that should be very "rare", and not normal behavior in the first place.

Cool, thanks.
