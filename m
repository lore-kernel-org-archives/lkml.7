Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CE6C606D4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F432173C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Rs7URDoz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="exMTT7cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfGIGPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:15:39 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56555 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbfGIGPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:15:39 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E80D721B84;
        Tue,  9 Jul 2019 02:15:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 09 Jul 2019 02:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=BTV6iO8RThZ5fsKAHSAGBt0Wwad
        7LKhI0GOblcqZsC0=; b=Rs7URDoz0SqmXkO3VTWnl3quxKnXPxPyEUJF/aA4cDS
        3MVUQ//kipgRcKHIStVal/bjLDo3urtYIduls3of5j3Bz/w8jtfyYHD08BbUeE9r
        VvIDM7YnJyZsCBT2PiQ+DDHdvOhvzXKFAkMWCCuejeBEG1FheRxEIhtrBG09OOA+
        3otI7oxs2Ah32XDm+RDMhE06RJ0LTGZNRdL7cC+NP6NXu2AERjDEZSfv85NHDKY/
        V2u/3MQPTrYBIeudgCPttrNI1lAW/bxS2x+xa2bbXsQv34Kh1I29towKb/YipLgG
        g6iJOHm+hj57Uv4vTEAvUUTfMeQtiFpDCsud03WOGCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=BTV6iO
        8RThZ5fsKAHSAGBt0Wwad7LKhI0GOblcqZsC0=; b=exMTT7cZOd6PfrTuAirnj3
        qzYoeaaHbRoFh59aMikbDMyrx07xAvglUZvltwpXGeLkmlNXhcTsJvcxPGyk35oG
        6/PkFShhNkydzRcKn6y7NorbrJrEFsaRE8NPIs0v1LEmnCh8x3vjU5y5MtHHiLGL
        ca3CcCkqXs3AW9d4XpcnpKxJs40I1F4JLeq3w1Lf4WGZz8xBbJa39V/VB7V1xKGt
        JsMKdjHRPQubBdJKOpJFBA7FUYNkRp2XbFQ0P7xj5G5pJeAntVZ/Ab04KH3TFA3q
        IBRiricID6y9jiCWa9JhVa+2RfQJg7jT9iwIxLViyhJ85JnCQL9TjQHA56frOeBw
        ==
X-ME-Sender: <xms:CTEkXZKHkZrn4SEv2jz26TDuY8VSY3jJO_NH7on1bqGZ0nOBFKz-jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgedugddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:CTEkXYYMB1O_wTCO_FCY8-BY0CuXFVeyxrfZRmaxLQSNr3C_L93BTw>
    <xmx:CTEkXVwlWHirIAvjo7KmJYL9al2XHjmwC0LmNhrKXBFFn6o1XbPLIw>
    <xmx:CTEkXUbLc3CvTMFq_u6Y0u_n51kfe0HQdKzv-w9rOklhxCQ-JNqrtA>
    <xmx:CTEkXWN1v6SrQnH_t3QYy_mzlu7ARUsofUFLXgWycz7xLaMuWY2y-Q>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7C878005C;
        Tue,  9 Jul 2019 02:15:36 -0400 (EDT)
Date:   Tue, 9 Jul 2019 08:15:34 +0200
From:   Greg KH <greg@kroah.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190709061534.GA9285@kroah.com>
References: <20190613155344.64fce8b9@canb.auug.org.au>
 <20190709092003.6087a9c4@canb.auug.org.au>
 <A3330909-6201-4FB6-B20B-89D8C1CE7A0C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3330909-6201-4FB6-B20B-89D8C1CE7A0C@vmware.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 11:25:12PM +0000, Nadav Amit wrote:
> > On Jul 8, 2019, at 4:20 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > Hi all,
> > 
> > On Thu, 13 Jun 2019 15:53:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >> Today's linux-next merge of the char-misc tree got a conflict in:
> >> 
> >>  drivers/misc/vmw_balloon.c
> >> 
> >> between commit:
> >> 
> >>  225afca60b8a ("vmw_balloon: no need to check return value of debugfs_create functions")
> >> 
> >> from the driver-core tree and commits:
> >> 
> >>  83a8afa72e9c ("vmw_balloon: Compaction support")
> >>  5d1a86ecf328 ("vmw_balloon: Add memory shrinker")
> >> 
> >> from the char-misc tree.
> >> 
> >> I fixed it up (see below) and can carry the fix as necessary. This
> >> is now fixed as far as linux-next is concerned, but any non trivial
> >> conflicts should be mentioned to your upstream maintainer when your tree
> >> is submitted for merging.  You may also want to consider cooperating
> >> with the maintainer of the conflicting tree to minimise any particularly
> >> complex conflicts.
> >> 
> >> -- 
> >> Cheers,
> >> Stephen Rothwell
> >> 
> >> diff --cc drivers/misc/vmw_balloon.c
> >> index fdf5ad757226,043eed845246..000000000000
> >> --- a/drivers/misc/vmw_balloon.c
> >> +++ b/drivers/misc/vmw_balloon.c
> >> @@@ -1553,15 -1942,26 +1932,24 @@@ static int __init vmballoon_init(void
> >>  	if (x86_hyper_type != X86_HYPER_VMWARE)
> >>  		return -ENODEV;
> >> 
> >> - 	for (page_size = VMW_BALLOON_4K_PAGE;
> >> - 	     page_size <= VMW_BALLOON_LAST_SIZE; page_size++)
> >> - 		INIT_LIST_HEAD(&balloon.page_sizes[page_size].pages);
> >> - 
> >> - 
> >>  	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
> >> 
> >> + 	error = vmballoon_register_shrinker(&balloon);
> >> + 	if (error)
> >> + 		goto fail;
> >> + 
> >> -	error = vmballoon_debugfs_init(&balloon);
> >> -	if (error)
> >> -		goto fail;
> >> +	vmballoon_debugfs_init(&balloon);
> >> 
> >> + 	/*
> >> + 	 * Initialization of compaction must be done after the call to
> >> + 	 * balloon_devinfo_init() .
> >> + 	 */
> >> + 	balloon_devinfo_init(&balloon.b_dev_info);
> >> + 	error = vmballoon_compaction_init(&balloon);
> >> + 	if (error)
> >> + 		goto fail;
> >> + 
> >> + 	INIT_LIST_HEAD(&balloon.huge_pages);
> >>  	spin_lock_init(&balloon.comm_lock);
> >>  	init_rwsem(&balloon.conf_sem);
> >>  	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
> > 
> > I am still getting this conflict (the commit ids may have changed).
> > Just a reminder in case you think Linus may need to know.
> 
> Greg,
> 
> Can you please take care of it, as you are the maintainer of char-misc
> and the committer of the patch?

It's hard to "take care" as this is in two different trees.  I'll worry
about it when they start to get merged together in Linus's tree...

thanks,

greg k-h
