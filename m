Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0725C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C5120830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123623;
	bh=sm0saESBAq5saeJwx5FZW4iF1wl19q26WDg2QPZUf2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWX2S29Lj6cw7bZlHk1af8qwNW/YGRceAFIjWq4zukpnGWLB0mxirp3Ooc1enWUSG
	 bkGAdxdGXFDDUhPThws4fZuDaaeVDF/P4AUfKDvzq9+sVyPrwBej3bhJggBlmXIn0H
	 yq8ROFfAMiACGt72TNOZ4q7vlTFKWb26/+9THw5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbfJCR1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388215AbfJCQPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:15:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9433720700;
        Thu,  3 Oct 2019 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119317;
        bh=sm0saESBAq5saeJwx5FZW4iF1wl19q26WDg2QPZUf2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3qfSjH1mr2Giz6lkMqYaejDjLr8/1OOQQXx2H3qYkJAH2aznayknusQ2T/k1MPVK
         ie+ntP7lIi3o8858B1ITaZ8dV/nIe35mT0cNHQJ7EMlFUxF3as7RaBlWumF4drtQzG
         JxwMq5FidmgEG/bah5YX6QGHfiFaA7RU7bKFc0vs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ori Nimron <orinimron123@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 020/211] ax25: enforce CAP_NET_RAW for raw sockets
Date:   Thu,  3 Oct 2019 17:51:26 +0200
Message-Id: <20191003154451.617529381@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ori Nimron <orinimron123@gmail.com>

[ Upstream commit 0614e2b73768b502fc32a75349823356d98aae2c ]

When creating a raw AF_AX25 socket, CAP_NET_RAW needs to be checked
first.

Signed-off-by: Ori Nimron <orinimron123@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ax25/af_ax25.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -858,6 +858,8 @@ static int ax25_create(struct net *net,
 		break;
 
 	case SOCK_RAW:
+		if (!capable(CAP_NET_RAW))
+			return -EPERM;
 		break;
 	default:
 		return -ESOCKTNOSUPPORT;


