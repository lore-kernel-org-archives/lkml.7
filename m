Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF31C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C210216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371739;
	bh=xyJEaPk2HfCS8hpn/PaP8yA5GZREaLpcCzt+2lcENIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K8+1gOlrylED8fURYeDkVOKJ8XmtkLouvtA/ZlP2fQ/L3gyeqTsFLOh06k7uaxb1N
	 zUWnhwpn98/PgvU2gucFxobTHfOxUsTtGt23528aKAIadsYjtZH/XzuEnZr4QZu83O
	 zvK6rwN2vTsKiF3OdrLkW/oO/6PWNSaGp3VO1cKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfFXKWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731074AbfFXKWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:22:09 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5001420645;
        Mon, 24 Jun 2019 10:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371728;
        bh=xyJEaPk2HfCS8hpn/PaP8yA5GZREaLpcCzt+2lcENIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJDeu10mmKCzehf/OBBPnw6CCwKrtVwkQmC+fsthMo2jpENMUnlBRz3LqJYu/xeGh
         4jeI3ro2w8NLcP7abqcN8BuGNBt2j1hfQjCzDz/oL8rb1jpQhy25dAOnGa7uWYaO+W
         JNAqVD09zF8vzopknoarpyPUhSs5fCpCCgipysbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 5.1 112/121] SMB3: retry on STATUS_INSUFFICIENT_RESOURCES instead of failing write
Date:   Mon, 24 Jun 2019 17:57:24 +0800
Message-Id: <20190624092326.393367304@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit 8d526d62db907e786fd88948c75d1833d82bd80e upstream.

Some servers such as Windows 10 will return STATUS_INSUFFICIENT_RESOURCES
as the number of simultaneous SMB3 requests grows (even though the client
has sufficient credits).  Return EAGAIN on STATUS_INSUFFICIENT_RESOURCES
so that we can retry writes which fail with this status code.

This (for example) fixes large file copies to Windows 10 on fast networks.

Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2maperror.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2maperror.c
+++ b/fs/cifs/smb2maperror.c
@@ -457,7 +457,7 @@ static const struct status_to_posix_erro
 	{STATUS_FILE_INVALID, -EIO, "STATUS_FILE_INVALID"},
 	{STATUS_ALLOTTED_SPACE_EXCEEDED, -EIO,
 	"STATUS_ALLOTTED_SPACE_EXCEEDED"},
-	{STATUS_INSUFFICIENT_RESOURCES, -EREMOTEIO,
+	{STATUS_INSUFFICIENT_RESOURCES, -EAGAIN,
 				"STATUS_INSUFFICIENT_RESOURCES"},
 	{STATUS_DFS_EXIT_PATH_FOUND, -EIO, "STATUS_DFS_EXIT_PATH_FOUND"},
 	{STATUS_DEVICE_DATA_ERROR, -EIO, "STATUS_DEVICE_DATA_ERROR"},


