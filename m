Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9016C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9316D208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560794890;
	bh=CQKZ469SuhKLKTXsY8T2mbWZqM9BW/hWbhc6NHH26Pc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rZbfXKvIkW9l3XO8iZfBAg2ruWaibtasFvFq2Q+CXqdsdtr6ayjZ1IQVuN6bDwtl0
	 mIs/80lmWV/aWyfABHUMDnyNdvXJMXFuVPpZuj1BOpO4O6dmryfE8C2okrjwXH8zK/
	 4IWmVH4QYcOe9Y5pF3BheR3AMpqNNyyUlMQfdvNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfFQSIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFQSIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:08:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED92B208C0;
        Mon, 17 Jun 2019 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560794888;
        bh=CQKZ469SuhKLKTXsY8T2mbWZqM9BW/hWbhc6NHH26Pc=;
        h=Date:From:To:Cc:Subject:From;
        b=gfVb8FCY86+Ccdc6dlmjg2NUMCCEvcRBFVQqafcjgIxAxW+N8L1HEV7dQoA1nESzU
         mKmWYLCP0cdeq2kyv03Gcz4c1P3CwDRLgBp2AWEeIme5yGnUFsn0G1otFOZwb+4Bga
         NtfTLJ4fIM1D/olKIfkr3AtdzDxh9b4/U5rRsjcg=
Date:   Mon, 17 Jun 2019 20:08:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.182
Message-ID: <20190617180805.GA16577@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.4.182 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/networking/ip-sysctl.txt |    8 ++++++++
 Makefile                               |    2 +-
 include/linux/tcp.h                    |    3 +++
 include/net/netns/ipv4.h               |    1 +
 include/net/tcp.h                      |    2 ++
 include/uapi/linux/snmp.h              |    1 +
 net/ipv4/proc.c                        |    1 +
 net/ipv4/sysctl_net_ipv4.c             |   11 +++++++++++
 net/ipv4/tcp.c                         |    1 +
 net/ipv4/tcp_input.c                   |   28 ++++++++++++++++++++++------
 net/ipv4/tcp_ipv4.c                    |    1 +
 net/ipv4/tcp_output.c                  |    8 ++++++--
 net/ipv4/tcp_timer.c                   |    1 +
 13 files changed, 59 insertions(+), 9 deletions(-)

Eric Dumazet (4):
      tcp: limit payload size of sacked skbs
      tcp: tcp_fragment() should apply sane memory limits
      tcp: add tcp_min_snd_mss sysctl
      tcp: enforce tcp_min_snd_mss in tcp_mtu_probing()

Greg Kroah-Hartman (1):
      Linux 4.4.182

