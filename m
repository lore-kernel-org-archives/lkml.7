Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDA0CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB93E20717
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211920;
	bh=7RgI3ynIYe9b4cD6bVr4e7slu4fJWH7ZqY2R7nOUDSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=plY/+0o8I0n6rB0l0Nbr8lhHj1DgsCC5BeAquOKxeh4q9IgyNQIvqQPLiw55XzAbm
	 UIkUGdOc7C3LpKJW4+xbABOUz55EOmktM9Mu09rLdKa89juoHJTvCV1ECL9DTgTkgS
	 mudqrW9r5fvX2eGhb304OTdKnoRe4XS6E6BJwY1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbfJ0Vb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbfJ0VP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:15:58 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BF62070B;
        Sun, 27 Oct 2019 21:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210958;
        bh=7RgI3ynIYe9b4cD6bVr4e7slu4fJWH7ZqY2R7nOUDSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCfa5nLl27wQlXiI4njgXTgrXnWWa4MnkLfLFDhkFFYCVNdLKUU9qlhW+hCvl8tqL
         s/Lt5+lcwGGgIDA/Veie5PpnwOhAE/iMhTqJH+TyUlQrxtRGkIyxxGep8GGFP8HnHq
         KFlcVl2z1lVRPrRhwZ6m56i4BiVtef2ZvBoAh3m8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Roberto Bergantinos Corpas <rbergant@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 74/93] CIFS: avoid using MID 0xFFFF
Date:   Sun, 27 Oct 2019 22:01:26 +0100
Message-Id: <20191027203310.528256363@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Bergantinos Corpas <rbergant@redhat.com>

commit 03d9a9fe3f3aec508e485dd3dcfa1e99933b4bdb upstream.

According to MS-CIFS specification MID 0xFFFF should not be used by the
CIFS client, but we actually do. Besides, this has proven to cause races
leading to oops between SendReceive2/cifs_demultiplex_thread. On SMB1,
MID is a 2 byte value easy to reach in CurrentMid which may conflict with
an oplock break notification request coming from server

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb1ops.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -183,6 +183,9 @@ cifs_get_next_mid(struct TCP_Server_Info
 	/* we do not want to loop forever */
 	last_mid = cur_mid;
 	cur_mid++;
+	/* avoid 0xFFFF MID */
+	if (cur_mid == 0xffff)
+		cur_mid++;
 
 	/*
 	 * This nested loop looks more expensive than it is.


