Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D10C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A9722ADC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998268;
	bh=T/js2yY3PjgZPEfi3OtpxtXr6ZCEeDIG5lhr3PLXbMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i1N0vfk3wZj8JF9S7MhDoHNceXvBiNZ+j/3ErMx0+cBq4hMoUxlFxG5hBChvNvMAI
	 AdeMFDiNyR1viVx8X4LqQysoItVyBZUHa1imz97yDRFClzOWCXtNR7qXDmHuEoA+Ip
	 //Y/h3CnDGNB7vqb1RhdH1HEEQe/7zxatIcJ0FhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392094AbfGXT5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392054AbfGXT5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:57:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F058206BA;
        Wed, 24 Jul 2019 19:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998261;
        bh=T/js2yY3PjgZPEfi3OtpxtXr6ZCEeDIG5lhr3PLXbMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otyzXOTAPI8Xoq5IuOGZCtJDMR7F8YViI3bTqXmPIwBJBp/GT46XqX5wX178Faest
         39GG8apVtFku/zqB8DVjihpaEB2HHky1S8AR6cMiRqYlOXYtlQYYRv47pdclPxi8Cu
         8IsRgFwFso+uGpC0DVHZnuEfBpWE7V5lFwnqSfVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.1 251/371] cifs: always add credits back for unsolicited PDUs
Date:   Wed, 24 Jul 2019 21:20:03 +0200
Message-Id: <20190724191743.564738540@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit 3e2725796cbdfe4efc7eb7b27cacaeac2ddad1a5 upstream.

not just if CONFIG_CIFS_DEBUG2 is enabled.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/connect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1221,11 +1221,11 @@ next_pdu:
 					 atomic_read(&midCount));
 				cifs_dump_mem("Received Data is: ", bufs[i],
 					      HEADER_SIZE(server));
+				smb2_add_credits_from_hdr(bufs[i], server);
 #ifdef CONFIG_CIFS_DEBUG2
 				if (server->ops->dump_detail)
 					server->ops->dump_detail(bufs[i],
 								 server);
-				smb2_add_credits_from_hdr(bufs[i], server);
 				cifs_dump_mids(server);
 #endif /* CIFS_DEBUG2 */
 			}


