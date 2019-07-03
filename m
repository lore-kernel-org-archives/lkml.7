Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64493C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327B320645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="eadm2XPw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mglezGLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfGCBJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:09:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53577 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfGCBJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:09:27 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id BA6F521B8C;
        Tue,  2 Jul 2019 21:09:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 02 Jul 2019 21:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        doV0xy0tNESSOTKAC+LK7gi4dIVGAsu1QowdkoeI6XU=; b=eadm2XPwK8puO/hB
        6ySpV0WYTvQIi6Pl43R6Kl0Ugg1zLHVxhtQsHKHunVJa3P2Tdnz/jCPQsC3bGRo3
        i43P3kivXKTZz3kSvE5PFscOJTqRpeERySt2EKSJNcrQLZOGawyxbgIQYUcMnjvt
        l2uFbGyQKfkfPhuSoBpQ29BN2QFMa/O+1Y0MXjPmNX/oq0lcLw/k+qSt+F/HB8xU
        lYgK3e8P9Aq55piXAA05EjSXwqKAAcdRTlFm0cyqYJtKWfi0xnQpMOTAPjnxeu4b
        kmJ6YbUrnyIQGp2RJxPyGVI23DueFd5jiOboXUuFHmkQMGyC1Xarm1KADJ9wpSrW
        S7kn9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=doV0xy0tNESSOTKAC+LK7gi4dIVGAsu1QowdkoeI6
        XU=; b=mglezGLu6bZbHSpROwjEcdIZu+VDNkvRF4zK6G1uHI7BXK0ZLeUWhh8hz
        cC9QCitcInqiwvILQiu9KlQlYD8zAkadNCsgYK4ExcdAYel4/SCNtF2KKbxHx+bB
        0NXwYiOzBI/YjRilEdaAa1S9AxY2NZum3hWvHgwy3klt5GdNn4sOTswLw46caIJ7
        BDZXmEF55d1wTUZYNHCkVT2D2RJI5Bq8ezjgo6b3zRf9VKwSdWyboNSyEiQFZb/1
        497OOJ8C3GKhGom+GWFUqTC0LjQn80l2SeyKUqHdvg2TiM8Xtt4csSqOvFEp4OPF
        OWw5BQuu6DbDfvCBkm341y0SBFfug==
X-ME-Sender: <xms:QwAcXT-pKjMQ16tRE9pr-ky8o6UjgX9pIkZrrIwuFffNs_-5m7EVow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrvdelgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    dujeegrdeiudenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgif
    rdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:QwAcXdSFkLBUsn00kQa16mufvazoGkjeUmBzuzvBjQJgzGQSN01GTA>
    <xmx:QwAcXXfh5Muut3hVZfG9KocG-WPbD-JZBttpSt2aV8VVgd9ALHOPmg>
    <xmx:QwAcXRC-bcZyHcJ0ygTCS1unpuRL4if2VS7EINEiQ8O8AftqfndHoA>
    <xmx:QwAcXcvrvKPmLJ6gc37kPO0IsFEMRx-kdas5BOBnp2hcvENQt5519Q>
Received: from pluto.themaw.net (unknown [118.208.174.61])
        by mail.messagingengine.com (Postfix) with ESMTPA id 91C7E380084;
        Tue,  2 Jul 2019 21:09:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 1AC291C014E;
        Wed,  3 Jul 2019 09:09:19 +0800 (AWST)
Message-ID: <8c70abf248d5ac07f334730af70d64235185b109.camel@themaw.net>
Subject: Re: [PATCH 4/6] vfs: Allow mount information to be queried by
 fsinfo() [ver #15]
From:   Ian Kent <raven@themaw.net>
To:     christian@brauner.io, David Howells <dhowells@redhat.com>,
        viro@zeniv.linux.org.uk
Cc:     mszeredi@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Jul 2019 09:09:19 +0800
In-Reply-To: <156173685496.14728.9606180227161368035.stgit@warthog.procyon.org.uk>
References: <156173681842.14728.9331700785061885270.stgit@warthog.procyon.org.uk>
         <156173685496.14728.9606180227161368035.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

About the propagation attributes you mentioned ...

On Fri, 2019-06-28 at 16:47 +0100, David Howells wrote:

snip ...

> +
> +#ifdef CONFIG_FSINFO
> +int fsinfo_generic_mount_info(struct path *path, struct fsinfo_kparams
> *params)
> +{
> +	struct fsinfo_mount_info *p = params->buffer;
> +	struct super_block *sb;
> +	struct mount *m;
> +	struct path root;
> +	unsigned int flags;
> +
> +	if (!path->mnt)
> +		return -ENODATA;
> +
> +	m = real_mount(path->mnt);
> +	sb = m->mnt.mnt_sb;
> +
> +	p->f_sb_id		= sb->s_unique_id;
> +	p->mnt_id		= m->mnt_id;
> +	p->parent_id		= m->mnt_parent->mnt_id;
> +	p->change_counter	= atomic_read(&m->mnt_change_counter);
> +
> +	get_fs_root(current->fs, &root);
> +	if (path->mnt == root.mnt) {
> +		p->parent_id = p->mnt_id;
> +	} else {
> +		rcu_read_lock();
> +		if (!are_paths_connected(&root, path))
> +			p->parent_id = p->mnt_id;
> +		rcu_read_unlock();
> +	}
> +	if (IS_MNT_SHARED(m))
> +		p->group_id = m->mnt_group_id;
> +	if (IS_MNT_SLAVE(m)) {
> +		int master = m->mnt_master->mnt_group_id;
> +		int dom = get_dominating_id(m, &root);
> +		p->master_id = master;
> +		if (dom && dom != master)
> +			p->from_id = dom;

This provides information about mount propagation (well mostly).

My understanding of this was that:
"If a mount is propagation private (or slave) the group_id will
be zero otherwise it's propagation shared and it's group id will
be non-zero.

If a mount is propagation slave and propagation peers exist then
the mount field mnt_master will be non-NULL. Then mnt_master
(slave's master) can be used to set master_id. If the group id
of the propagation source is not that of the master then set
the from_id group as well."

This parallels the way in which these values are reported in
the proc pseudo file system.

Perhaps adding flags as well as setting the fields would be
useful too, since interpreting the meaning of the structure
fields isn't obvious, ;)

David, Al, thoughts?

Ian

