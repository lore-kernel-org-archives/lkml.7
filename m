Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D6C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D6420874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="N4ZkxriL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jG6F4Rdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfHZIBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:01:13 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57303 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726875AbfHZIBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:01:13 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A805C37B;
        Mon, 26 Aug 2019 04:01:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 26 Aug 2019 04:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=6R15M5gpXp6+t5ucxX5BenurBan
        iwk5iWP/DzbBg5DU=; b=N4ZkxriL+KWtGKhMDq4zY7SZOQMCRHKmbWr7QXeS4ZC
        7ccTC8mfuqMp0a/reeq66Rw5E30sFntXklfEIWeh+qIh6L4QJcYxiCQ6TAw0bS2e
        PEuCtAL+QRa9//uKlzL+83G57ZmH26poWUZ6LC/VxVIqThR02SV5dBeEXjf3KLtK
        iPhYegS2W290c1vwJdCh+I2Oe17lMURl3dM2LB6JW8OQNhGJEGHSKH60VTzjQiaN
        SRP5UB77MI4Ru/XB4Hb0EkkvwQviHXkltmkawsbl4IBcEQWBFIJkevpFfiLZk/M9
        X7ZK9bBKibKv3eQSI/cYSI5+sedM7IVCelFhfB7biyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6R15M5
        gpXp6+t5ucxX5BenurBaniwk5iWP/DzbBg5DU=; b=jG6F4Rdh+XZIGvPnoktgO8
        fFRYrtJsdap6E8xiPtwLLuyQy+0vgpJ/7BdSIRSNkh2wLjCnXrzAbaOyNMkaJv4k
        8WFxWthRG+nuMiDE6Kbdnf1CjenFwAsFMB38I7DA5R+QGUShtJwMopJAXfV5X7UB
        psioXqXoEFLP1CuRIMgZZnhqwzVGWibVlbo3eLWLMppu+pK843fW+UqJpd3lJikz
        Nmt5JCfmMmPDQkUaRcWmtkAGEuerMZTRRXohI8YrXMO909vAtcgIJ/OI0gPWVJCy
        nIuAjGnWgB3IRLD4RToOJ3PE6z7vLL5/Xdlz1pFCf55myFFo+Tr7fc28kv9MFOgw
        ==
X-ME-Sender: <xms:xpFjXc4ZFbe6uLo-OA2gTsNCnPaZZqKk_QuozqFWkQd2Ecu06PRnJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehfedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecukfhppeekledrvddthedruddvkedrvdegieenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:xpFjXVhhblGQG1rhTevfJPff4HgH6zC_ocl8Vu6XbARUqhe3DVlIYA>
    <xmx:xpFjXS2R7zQZgnIQOrdPPlDuslkxlSOhEJ2ThSUb93BsMytomEf46w>
    <xmx:xpFjXborEjL1SENQrhNcCt_XcxnYEghJ_uexRgKLCQqZxWZgNpp0iA>
    <xmx:x5FjXbrKkO73fUaGrV-LxbI-1VebKEomHXdVOnNBEyPUn2q0lfODtg>
Received: from localhost (unknown [89.205.128.246])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2D32C8005C;
        Mon, 26 Aug 2019 04:01:09 -0400 (EDT)
Date:   Mon, 26 Aug 2019 10:01:07 +0200
From:   Greg KH <greg@kroah.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, akpm@linux-foundation.org, jslaby@suse.cz,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Linux 5.2.10
Message-ID: <20190826080107.GB30396@kroah.com>
References: <20190825144703.6518-1-sashal@kernel.org>
 <20190826063834.GD31983@Gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826063834.GD31983@Gentoo>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 12:08:38PM +0530, Bhaskar Chowdhury wrote:

<snip>

Due, learn to properly trim emails...

> For some unknown reason kernel.org still showing me 5.2.9 ..Please refer
> to the attached screenshot.

What mirror are you hitting here?  There is a way somehow to see that on
your end, I thought it was at the bottom of the page.

You are not seeing any of the releases that happened yesterday, which is
really odd, it's not just a 5.2.10 issue.

thanks,

greg k-h
