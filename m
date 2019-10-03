Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E0FC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D121420830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123985;
	bh=ma1CarYG2lqqBfk2dF+ebJNDWLLYYaQ94NCINGFyuyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zl/gj4MT0K1nxt9wkjfjfhgtFhuA7r6kEbXsT0q4egXgPZyNmG8OZAyb18KozSpBc
	 QJuCO5dfAv7wYjzwuppIs+82WNTFy+D+SEkSbUQn5Tse8uq14Dx3YHqGY9Aw+8HtAL
	 8c38dXUxbShaufR+eJ6EkX8HcE4XwrGk4JglQa2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbfJCRdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731668AbfJCQIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:08:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED4AF20865;
        Thu,  3 Oct 2019 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118895;
        bh=ma1CarYG2lqqBfk2dF+ebJNDWLLYYaQ94NCINGFyuyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPhClj8OI3wX/iV8RYtO6/geSoqrze2sj6Ayi6x6MxYWq44Sc/ZPDG9boH0/Hsz2w
         HXyGRlllxU+mmyZYgSFgcFdDQdVHyVJbjIycIyf5BPYJwcdHtnU2tQQZv9MAbOXokp
         xBkVimPoa5hD3vrMM2+ROwAan+X1K7V/pwnvApMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ori Nimron <orinimron123@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 050/185] ax25: enforce CAP_NET_RAW for raw sockets
Date:   Thu,  3 Oct 2019 17:52:08 +0200
Message-Id: <20191003154449.113701954@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
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
@@ -859,6 +859,8 @@ static int ax25_create(struct net *net,
 		break;
 
 	case SOCK_RAW:
+		if (!capable(CAP_NET_RAW))
+			return -EPERM;
 		break;
 	default:
 		return -ESOCKTNOSUPPORT;


