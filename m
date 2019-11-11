Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E959C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9B5214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498416;
	bh=5b8/2op+ItCBvm/1g6xyyc4i0Q7+o/zfLH0FOPa8fHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sViHpQp1LroK5ft98WGVIQ5l4S4jue6n35r4+U8StSVU/xMsdb7JRe+DZzYk7QUJX
	 ydDHCXrdf/yzmW78+bmIcSgw8bR9WENvZGSc13l82jhL6MDZy3ho8x/7x9qOPSPy7n
	 30WZLYx78CfDUqwq4iJV2xlCg8LvqmaPwp6Fb8GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfKKSxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730389AbfKKSxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:53:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C067520818;
        Mon, 11 Nov 2019 18:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498409;
        bh=5b8/2op+ItCBvm/1g6xyyc4i0Q7+o/zfLH0FOPa8fHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=15kwTQ0EGxeXsCO060QdvyRzbZ/gNQ+TNu0FSgJ/pHCgioR8k/vpTBqlNvNXBypUN
         J2vDpb4u7vk+kUspvzhzUPP1qmAK9pUdjiYjsa44pBQb6a9GeOonRQ4IU81t+aafaU
         aZoqRHdU8fswqA1+lOJNwGE3WoNWgrTB4YEssnVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.3 071/193] SMB3: Fix persistent handles reconnect
Date:   Mon, 11 Nov 2019 19:27:33 +0100
Message-Id: <20191111181506.350324816@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <pshilov@microsoft.com>

commit d243af7ab9feb49f11f2c0050d2077e2d9556f9b upstream.

When the client hits a network reconnect, it re-opens every open
file with a create context to reconnect a persistent handle. All
create context types should be 8-bytes aligned but the padding
was missed for that one. As a result, some servers don't allow
us to reconnect handles and return an error. The problem occurs
when the problematic context is not at the end of the create
request packet. Fix this by adding a proper padding at the end
of the reconnect persistent handle context.

Cc: Stable <stable@vger.kernel.org> # 4.19.x
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.h |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -836,6 +836,7 @@ struct create_durable_handle_reconnect_v
 	struct create_context ccontext;
 	__u8   Name[8];
 	struct durable_reconnect_context_v2 dcontext;
+	__u8   Pad[4];
 } __packed;
 
 /* See MS-SMB2 2.2.13.2.5 */


