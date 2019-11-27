Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BF1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1833F2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888128;
	bh=lDXkVWJ9S5dgNw9Hr18od3skLLTtbWiy3U51b8sjXh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h05LZjfVL3WeHmDXIi4woQVx9sRceqAbPj4GkvXx2OkGk82Ps2FFO+JjKkBRVgGrr
	 x/nMvQZcNaXmD5JYb+n7xhMbEH2JnjPCwnmcdRB9Z2JphGBDovuSKu41TUnTPmRS56
	 KQm7m/l85JrMlgr68Z1u6xvEdlObJMIsUHIWTWBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfK0Uz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:55:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730146AbfK0UzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:55:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F29A2070B;
        Wed, 27 Nov 2019 20:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888124;
        bh=lDXkVWJ9S5dgNw9Hr18od3skLLTtbWiy3U51b8sjXh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlVFcHnb/9tTsRJ0Ouk+/yuOxdHOvaSqFDqvv6FsQMpHyFVdfxF1SWpGhy8kLvO4w
         3Ekg0CeYM1gpMXOEzeOP+qnW0litkyuYxc2jg+4U0J/zthMwrxYmQo/n4WQSMSaDqh
         gZaOeKIGAysi0ghTOmUe39BznecX9TTKLFJyyjr8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 006/306] net: sched: ensure opts_len <= IP_TUNNEL_OPTS_MAX in act_tunnel_key
Date:   Wed, 27 Nov 2019 21:27:36 +0100
Message-Id: <20191127203115.209535927@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 4f0e97d070984d487df027f163e52bb72d1713d8 ]

info->options_len is 'u8' type, and when opts_len with a value >
IP_TUNNEL_OPTS_MAX, 'info->options_len = opts_len' will cast int
to u8 and set a wrong value to info->options_len.

Kernel crashed in my test when doing:

  # opts="0102:80:00800022"
  # for i in {1..99}; do opts="$opts,0102:80:00800022"; done
  # ip link add name geneve0 type geneve dstport 0 external
  # tc qdisc add dev eth0 ingress
  # tc filter add dev eth0 protocol ip parent ffff: \
       flower indev eth0 ip_proto udp action tunnel_key \
       set src_ip 10.0.99.192 dst_ip 10.0.99.193 \
       dst_port 6081 id 11 geneve_opts $opts \
       action mirred egress redirect dev geneve0

So we should do the similar check as cls_flower does, return error
when opts_len > IP_TUNNEL_OPTS_MAX in tunnel_key_copy_opts().

Fixes: 0ed5269f9e41 ("net/sched: add tunnel option support to act_tunnel_key")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_tunnel_key.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -137,6 +137,10 @@ static int tunnel_key_copy_opts(const st
 			if (opt_len < 0)
 				return opt_len;
 			opts_len += opt_len;
+			if (opts_len > IP_TUNNEL_OPTS_MAX) {
+				NL_SET_ERR_MSG(extack, "Tunnel options exceeds max size");
+				return -EINVAL;
+			}
 			if (dst) {
 				dst_len -= opt_len;
 				dst += opt_len;


