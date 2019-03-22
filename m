Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E586FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A822183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254446;
	bh=ktzVs0uuS1F4XmR/LV4yFTPe1RZShxaOAzX9cEVtTCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yhEyzWOgux6DDJBFoxTQiaSdguNd5qlgRVTGRDgLUCOKsQwdBhd50ZsD9Oh/Z/MWp
	 AK5J/UHq6qa0JZGQtdXcdI9aszfL9NKCQT3g2SbwSPhFcRWQXS/j7irMpXWzk4tBOi
	 AR065czLUDqWqzOBPbz3Kg2sXn3At+rxJtRfSKIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfCVLeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730162AbfCVLeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA49B2183E;
        Fri, 22 Mar 2019 11:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254441;
        bh=ktzVs0uuS1F4XmR/LV4yFTPe1RZShxaOAzX9cEVtTCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xyjxFLfkAFWd42nuu50rKYPMTp2sqaeAEzMAsB1bohHOErM1bkZ3+3I9eB3oRtpLn
         aZ51PyOHq5knq/dftl/YtlmlC5v7mo+HfPw0TCBGfIvnkOU9ViAZrstNRZoncW9dLh
         bPvPKBpzlr1Rd0hiuzQ5CSR/5PFmmIvwupOlD6Ho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ken-ichirou MATSUZAWA <chamas@h4.dion.ne.jp>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.4 121/230] netfilter: nfnetlink_log: just returns error for unknown command
Date:   Fri, 22 Mar 2019 12:14:19 +0100
Message-Id: <20190322111245.164462023@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ken-ichirou MATSUZAWA <chamaken@gmail.com>

commit eb075954e9fde114f57adc39a9ea6d379c13f81e upstream.

This patch stops processing options for unknown command.

Signed-off-by: Ken-ichirou MATSUZAWA <chamas@h4.dion.ne.jp>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nfnetlink_log.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -895,7 +895,7 @@ nfulnl_recv_config(struct sock *ctnl, st
 			goto out_put;
 		default:
 			ret = -ENOTSUPP;
-			break;
+			goto out_put;
 		}
 	} else if (!inst) {
 		ret = -ENODEV;


