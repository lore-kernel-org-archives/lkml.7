Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B76C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B5120700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="O2LUMjFd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Md6cbsoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfJCPeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:34:08 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57357 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729806AbfJCPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:34:08 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E32D721D75;
        Thu,  3 Oct 2019 11:34:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 03 Oct 2019 11:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=+GQLF0P5EcGP8zut14EDy1MRDuX
        YKGktSmfY5LtxpLM=; b=O2LUMjFdQbnVULtxKEiMkWKmIYy2hGr61AHHaD6KNGT
        uEQsWPSMjoBoLL48fUWzeZG/a/PGeBlxdMph7x2D2XAQtsTkeHuizWE+0vAQR0Qg
        iTJTPXjijSN0ww9SDBd8/FLUEkkFKAFQls3OjzFNNbTE1elBLekxYzOgtX9SDzj/
        e5VnmAB9bDHRytgtmergSmsHLpQ1wWt/KuoJAldJ57aVa4gwn3wpBXJNfDqvlfKR
        lbHnuIbJtjxkTwHCeKTEbSAmlu2VLvSZEpqtcIiGs5Kw9XoIL56tBOVgg1cmVY+F
        ONBkjiqpCdf8bSLI7VC4a/QDp8jPC0vn/X0K8zEsB3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+GQLF0
        P5EcGP8zut14EDy1MRDuXYKGktSmfY5LtxpLM=; b=Md6cbsoGmKQ1NxPw44iTb6
        G8rFjKIprD12ksSJ51/+nWv/d6M4WXsmpk9phvZT5pIeZoP6q6EoDSeBrgquFjZc
        SpfOeYMNcSWViv74ZEE4VkLf2pzdZ3H/vMqHuFIAn/zh+S2QQt5oj8x1OIMJff5X
        DItVzV2CgJShuH4eN4QYtzL857OJSZBXEfP5maRA6E/l97sK5P7XXS/CmfOrKcKv
        wt5r/Sj8meEqN3F3JM0q+2anMcPTSZTAK69el5Sv/W5kKZo0btIQ1DNqAtexWBOP
        5xXQaEDYIPpNTWDVs5jtxdB6CGum/bxZdIjHNHyC0jTSiMv20+Of5NSP4SgUMybQ
        ==
X-ME-Sender: <xms:7hSWXQzcH_AJ0XTQ0LbHhuYBLUssYVMVUv0LYh2SU3A2LvC3G0BYmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhfrhho
    mhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:7hSWXc_GwpJ2_T8qug04NcGJxcqCufic9o0YCFYiOAvuPjlTbYzoZw>
    <xmx:7hSWXSQ15jfC3WXzbOIn6XhvvOnOIyypEJJI55wCtEupQ0L5iJxcdw>
    <xmx:7hSWXbDwVKO5cJO4DiwV4GEpUT1z85-yKX9_qBFSu3M7WBdvJ8Uaxw>
    <xmx:7hSWXd1OBBUJuh1A29Ob98TIwRGQC3wCy_BdlXLcOPw4yu1G0SHAjA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5C6FED6005A;
        Thu,  3 Oct 2019 11:34:06 -0400 (EDT)
Date:   Thu, 3 Oct 2019 17:34:04 +0200
From:   Greg KH <greg@kroah.com>
To:     "Lubashev, Igor" <ilubashe@akamai.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
Subject: Re: Patch "perf ftrace: Use CAP_SYS_ADMIN instead of euid==0" has
 been added to the 5.3-stable tree
Message-ID: <20191003153404.GA3236662@kroah.com>
References: <20191001171555.9CBC6205C9@mail.kernel.org>
 <20191003075006.GA1830608@kroah.com>
 <795ba9fa06cf40048aecc60fff35e21c@usma1ex-dag1mb6.msg.corp.akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795ba9fa06cf40048aecc60fff35e21c@usma1ex-dag1mb6.msg.corp.akamai.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 03:10:02PM +0000, Lubashev, Igor wrote:
> > On Thu, Oct 3, 2019 at 3:50 AM Greg KH <greg@kroah.com> wrote:
> > Sent: Thursday, October 3, 2019 3:50 AM
> > 
> > On Tue, Oct 01, 2019 at 01:15:54PM -0400, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     perf ftrace: Use CAP_SYS_ADMIN instead of euid==0
> > >
> > > to the 5.3-stable tree which can be found at:
> > >
> > > http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;
> > > a=summary
> > >
> > > The filename of the patch is:
> > >      perf-ftrace-use-cap_sys_admin-instead-of-euid-0.patch
> > > and it can be found in the queue-5.3 subdirectory.
> > >
> > > If you, or anyone else, feels it should not be added to the stable
> > > tree, please let <stable@vger.kernel.org> know about it.
> > >
> > >
> > >
> > > commit 54a277c389061fc501624f51a13426d7b797f5f7
> > > Author: Igor Lubashev <ilubashe@akamai.com>
> > > Date:   Wed Aug 7 10:44:17 2019 -0400
> > >
> > >     perf ftrace: Use CAP_SYS_ADMIN instead of euid==0
> > >
> > >     [ Upstream commit c766f3df635de14295e410c6dd5410bc416c24a0 ]
> > 
> > 
> > Sasha, this patch is breaking the build of perf in the stable branches.
> > Can you fix it up, or drop it?
> 
> This patch is fixing what's been broken forever in perf, so it is improving perf tool.  But it is not fixing a vuln in the kernel itself.
> 
> In any case, this patch is a part of a series.  You would need the following to make that patch compile:
> 97993bd6eb89 perf tools: Add NO_LIBCAP=1 to the minimal build test
> c22e150e3afa perf tools: Add helpers to use capabilities if present
> 
> Also, if you believe this update to perf tool warrants inclusion in a stable update, I'd rather point you at the entire series:
> 
> d06e5fad8c46 perf tools: Warn that perf_event_paranoid can restrict kernel symbols
> 8859aedefefe perf symbols: Use CAP_SYSLOG with kptr_restrict checks
> aa97293ff129 perf evsel: Kernel profiling is disallowed only when perf_event_paranoid > 1
> dda1bf8ea78a perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
> e9a6882f267a perf event: Check ref_reloc_sym before using it
> 73e5de70dca0 perf ftrace: Improve error message about capability to use ftrace
> c766f3df635d perf ftrace: Use CAP_SYS_ADMIN instead of euid==0
> 083c1359b0e0 perf tools: Add CAP_SYSLOG define for older systems
> 97993bd6eb89 perf tools: Add NO_LIBCAP=1 to the minimal build test
> c22e150e3afa perf tools: Add helpers to use capabilities if present
> 74d5f3d06f70 tools build: Add capability-related feature detection

Thanks for the info.  I've dropped the original patch here from the
stable queues, as it doesn't look like it really matters at the moment.

thanks,

greg k-h
