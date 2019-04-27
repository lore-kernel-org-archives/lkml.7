Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854CAC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512E1206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="iiMt8+/g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jqpND4b1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfD0IOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:14:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50599 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbfD0IOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:14:08 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 61CB821BBE;
        Sat, 27 Apr 2019 04:14:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 27 Apr 2019 04:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm3;
         bh=LxMt71c++2xcmnnhpZGwaZOxC7Qlo62UTcL06iM95BE=; b=iiMt8+/ggvZA
        +zvWLwlvdg70urd64ndoobn2Ih0Q4nS6qKRXvoy8X8fpCjA/NSd8Ey1T1Q+p/+i3
        z0096p7xO+yVOAjANCs1+ZHlpWelHwtb8fJbFjrVK0xvAg3uqQTU9iGpPxSdhuHc
        yzcEiT19vjGCw0tG/xdHMT+PieS+XmYZojwpqxddYnlPhKninLNpTNGZEk7+JWlT
        UGkfgao3hvlDOOuh6wrnU/tH7jge41BUzW4hcUtYykSy4+yY7i6bwYNadr2Y+Vw9
        kjOTTOZPjtL98aVK813Ug47fPHW18yN1TU+AGm2NATzBo5wEIn9ZOnNJuocRE/PJ
        SuHmxnKwPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=LxMt71c++2xcmnnhpZGwaZOxC7Qlo
        62UTcL06iM95BE=; b=jqpND4b1YKYANPOCrz99th6zU31otpLqju0lSyHrVifQG
        VwD1MrK9L632eFiU517sZ7ZFhpFH1hBt7h02M41P2hUuoTclzSFbjgp8f46xz5lS
        gwwHjppBXvszrZrauGYMp/FMcIhgb+ELgmGJxsVGPN91A3YcoDh5wKHb8uyxChpV
        +zfjNliewe3+mEXDp04otD5ILRTTi2s2QdHuNCSnHaN4JlVcmKOqNEzcoSVmNhbh
        pND4EcnZCBm7ApnWLTNg7Np/s/qIWWqM6fARZp5Baco0c5z3yKOStGH1BHzmHvtv
        MKVNVPprNDRETucQXlOJ8PzJl7qDTqtYJeRFiCTSA==
X-ME-Sender: <xms:Tg_EXAddp9cy6XS-zittwfS_ztzm-3654XpfNLWInpJ1nS-wsKijwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheekgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfggtgguofgfsehttdertdforedv
    necuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosghinh
    drtggtqeenucfkphepuddvgedrudeiledrudehledrvddutdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Tg_EXHF1vbdz0EVY5ALa8acnOcw2PSA8gtfYyx94egdA1e1XvUWang>
    <xmx:Tg_EXHYdBDVX7MxkLT4T6B54KCE4BjkNUYgE3un_EIAV_lV6hBa5bQ>
    <xmx:Tg_EXIZVnYW3rdalDLy8P18_vICvQaBK93B9UtZagBulqiOaUz8iAg>
    <xmx:Tw_EXIx1_uM6AUnPYguo4MIYngHW0d7PniUgKxTpOtIxgNR6QTKf6g>
Received: from localhost (124-169-159-210.dyn.iinet.net.au [124.169.159.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC609E432B;
        Sat, 27 Apr 2019 04:14:05 -0400 (EDT)
Date:   Sat, 27 Apr 2019 18:13:30 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     cl@linux.com, tycho@tycho.ws, willy@infradead.org,
        linux-kernel@vger.kernel.org
Subject: memleak around kobject_init_and_add()
Message-ID: <20190427081330.GA26788@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Note at bottom on reasons for 'To' list 'Cc' list)

Hi,

kobject_init_and_add() seems to be routinely misused.  A failed call to this
function requires a call to kobject_put() otherwise we leak memory.

Examples memleaks can be seen in:

	mm/slub.c
	fs/btrfs/sysfs.c
	fs/xfs/xfs_sysfs.h: xfs_sysfs_init()

 Question: Do we fix the misuse or fix the API?

$ git grep kobject_init_and_add | wc -l
117

Either way, we will have to go through all 117 call sites and check them.  I
don't mind fixing them all but I don't want to do it twice because I chose the
wrong option.  Reaching out to those more experienced for a suggestion please.

Fix the API
-----------

Typically init functions do not require cleanup if they fail, this argument
leads to this patch

diff --git a/lib/kobject.c b/lib/kobject.c
index aa89edcd2b63..62328054bbd0 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -453,6 +453,9 @@ int kobject_init_and_add(struct kobject *kobj, struct kobj_type *ktype,
 	retval = kobject_add_varg(kobj, parent, fmt, args);
 	va_end(args);
 
+	if (retval)
+		kobject_put(kobj);
+
 	return retval;
 }
 EXPORT_SYMBOL_GPL(kobject_init_and_add);


Fix all the call sites
----------------------

Go through all 117 call sites and add kobj_put() in the error path.

This example from mm/slub.c

diff --git a/mm/slub.c b/mm/slub.c
index d30ede89f4a6..84a9d6c06c27 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5756,8 +5756,10 @@ static int sysfs_slab_add(struct kmem_cache *s)
 
 	s->kobj.kset = kset;
 	err = kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s", name);
-	if (err)
+	if (err) {
+		kobject_put(&s->kobj);
 		goto out;
+	}
 
 	err = sysfs_create_group(&s->kobj, &slab_attr_group);
 	if (err)


thanks,
Tobin.


This is a Saturday afternoon 'drinking some wine, hacking on the kernel'
email.  Sending it to the lib/kobject.c maintainers for obvious
reasons.  CC'd a few extra people who I thought might be interested to
take the weight of Greg and Rafael :)
