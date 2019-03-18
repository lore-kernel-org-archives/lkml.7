Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43619C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1186D20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="UW/rFXoO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="11OkRF/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfCRDe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:34:57 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47025 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbfCRDe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:34:56 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AD74E21F0A;
        Sun, 17 Mar 2019 23:34:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 17 Mar 2019 23:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=hI9nacIh4+ikVwoTJa91cBLhdkZ
        GR9SIE248o1LFToU=; b=UW/rFXoOd/5BbBJVU6zfxQaFsTXkpvA+MpxSScA8qP3
        Eih+c4eE7vnBhsb2dqZ13WsD1rth1NSXJzXEifrHf8lwVy5R4cf0awgGTUszOQo4
        zh/xtsc5rNI+13f/avbw8GaoxuCY6RDjuK2b3uXX7QNagO1mUaZ6FBcn00m3uIIp
        lBaX6/0/AnwRSRy1Kw3p+BTyG+hmIsS1fijXJfoQLS0N550w70THcUJEh9xxdhWR
        OoJBJq20M/p330ciq++MpITTdmAehsSYvHFRsWYfLZOVqGMas2vvH32YH/d/QEyA
        Bfe6GmjYeMM/r91MkghEdEN5scvZrNXN+ixf//sfW8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hI9nac
        Ih4+ikVwoTJa91cBLhdkZGR9SIE248o1LFToU=; b=11OkRF/D0zKvFE7vRvMuiB
        0ai/MJo/MseB6XlYPeCUJDTp4Ho6wPb3UquHbggEVC/se4trdaH4wtmPgIqfG6K6
        zamvQy0pA0xQCjQ17ALdvea8GwWdAh3Ew+hNnZZHldwhs4VOQC435STj5/BIcHbF
        2NNuJgXTGK349GanVHA+IrQ/Cb5tZdNcpIdfmfl1IaQGHZyQNdbabMsbMW61/+gb
        3D/CjHl+01F62IxD7BW/0SxcXV65BmpHgqxsNdQrNoW3jsutxNOBTTiwkEbuwaU9
        eAwEs3my3hblSV6H57eW8pTb9+NwqwGF3Of8dEzTElXoEEWkstTY3OVB04s5HK1w
        ==
X-ME-Sender: <xms:3xGPXOUkm_nsCcb2snkmtvgBInzrsJIc_ZJFdMtSpFvFx1kFysmUkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedtgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddukedrvdduuddrudelledruddvieenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:3xGPXJBwExd4evTDKdd26kghov25SnbCQcIX4bvNXxbtwYiaIWB4Dw>
    <xmx:3xGPXFLY3QuS1Uy_yQ9m7jnMs0nlrWuHZ_xaBqjmlBifaweMTpZfdQ>
    <xmx:3xGPXKKM3Tx0C-AZg5CGlNmJurvmugpczxCSZwsGbuaCqDp18sC8iQ>
    <xmx:3xGPXN05NLa63RAk1jopcRE0pdHkhj888akSWiluGA5_kt_-rSsWjA>
Received: from localhost (ppp118-211-199-126.bras1.syd2.internode.on.net [118.211.199.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 94173100E5;
        Sun, 17 Mar 2019 23:34:54 -0400 (EDT)
Date:   Mon, 18 Mar 2019 14:34:30 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] Convert vfs.txt to vfs.rst
Message-ID: <20190318033430.GA27728@eros.localdomain>
References: <20190313040919.6937-1-tobin@kernel.org>
 <821449c9-e1f7-caa1-ff18-0cc1cc625596@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <821449c9-e1f7-caa1-ff18-0cc1cc625596@infradead.org>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 06:46:40PM -0700, Randy Dunlap wrote:
> On 3/12/19 9:09 PM, Tobin C. Harding wrote:
> > Hi,
> > 
> > This set converts the VFS overview documentation to RST format.  I think
> > I'm slowly getting better at structuring these conversions to ease
> > review, if you disagree or you notice any way to further improve please
> > say so.
> 
> Hi Tobin,
> 
> What does this patch set apply to?  Maybe Jon's git tree?

I did this on top of Jon's tree before rc-1 came out (so during the
merge window last week).  I can rebase and fire off another version if
its easier for you Jon.

> I applied it to 5.1-rc1 with some forceful (minor) editing and ran
> 'make htmldocs' successfully, so
> 
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks Randy.

> although there is at least one new field in struct file_operations: iopoll.

I purposely kept the conversion separate from the update.  Most of this
file explicitly states the kernel version each struct documented is for
(and at least two of them are 2.6.22).

One reason for the separation is that this set should be reviewable by
'docs' folk without having to be too closely looked at by anyone from
filesystems but the update will most likely benefit from at least a
cursory look over by someone from filesystems.

I have started the update to v5.20 but its slow going because I don't
know the VFS.  I'm learning as I go, I should have something together
soon.

thanks,
Tobin.
