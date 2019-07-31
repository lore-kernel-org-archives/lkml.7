Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C360BC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935582067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfGaFEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 01:04:42 -0400
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:52574 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728822AbfGaFEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 01:04:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2C7AB18010BC8;
        Wed, 31 Jul 2019 05:04:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: straw28_45b1536d17222
X-Filterd-Recvd-Size: 2733
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Jul 2019 05:04:38 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: sctp: Rename fallthrough label to unhandled
Date:   Tue, 30 Jul 2019 22:04:37 -0700
Message-Id: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fallthrough may become a pseudo reserved keyword so this only use of
fallthrough is better renamed to allow it.

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/sctp/sm_make_chunk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 36bd8a6e82df..3fdcaa2fbf12 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2152,7 +2152,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
 	case SCTP_PARAM_SET_PRIMARY:
 		if (net->sctp.addip_enable)
 			break;
-		goto fallthrough;
+		goto unhandled;
 
 	case SCTP_PARAM_HOST_NAME_ADDRESS:
 		/* Tell the peer, we won't support this param.  */
@@ -2163,11 +2163,11 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
 	case SCTP_PARAM_FWD_TSN_SUPPORT:
 		if (ep->prsctp_enable)
 			break;
-		goto fallthrough;
+		goto unhandled;
 
 	case SCTP_PARAM_RANDOM:
 		if (!ep->auth_enable)
-			goto fallthrough;
+			goto unhandled;
 
 		/* SCTP-AUTH: Secion 6.1
 		 * If the random number is not 32 byte long the association
@@ -2184,7 +2184,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
 
 	case SCTP_PARAM_CHUNKS:
 		if (!ep->auth_enable)
-			goto fallthrough;
+			goto unhandled;
 
 		/* SCTP-AUTH: Section 3.2
 		 * The CHUNKS parameter MUST be included once in the INIT or
@@ -2200,7 +2200,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
 
 	case SCTP_PARAM_HMAC_ALGO:
 		if (!ep->auth_enable)
-			goto fallthrough;
+			goto unhandled;
 
 		hmacs = (struct sctp_hmac_algo_param *)param.p;
 		n_elt = (ntohs(param.p->length) -
@@ -2223,7 +2223,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
 			retval = SCTP_IERROR_ABORT;
 		}
 		break;
-fallthrough:
+unhandled:
 	default:
 		pr_debug("%s: unrecognized param:%d for chunk:%d\n",
 			 __func__, ntohs(param.p->type), cid);
-- 
2.15.0

