Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F57C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1D52089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919565;
	bh=cEn349Xsxel2wfBlimOLS4U8SJc/7A97xjsUvky5aHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HhB6X1Mt1+8KjQfR8moyymU2b/PaDTF/lTRy4a6VhpRjoB5C85XLqqeAxw1hyUSXg
	 MmNIQSTz64H78WO2teNTow/tsA6Opmy6iN/LNmub0jiPyHmAze8B12QU0HkBZIIo8/
	 uAaHr00RzfJzWMYAvWUKzJAsShffYt65Sh8wWA0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbfEOL0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732090AbfEOL0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:26:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A51920818;
        Wed, 15 May 2019 11:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919559;
        bh=cEn349Xsxel2wfBlimOLS4U8SJc/7A97xjsUvky5aHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/9kxMfib06aY2/wWeA7VpNgD9DCg+1DvVFHkJC/ykb0QEI+5VRr7hBb8D4NrA/7c
         9LI4OAQzLXrDARQ+OS9J7hhnqP3IYxs0jgh3um3hjy318oy9P75D34uCn5tLUmEKFv
         QQLhE16LWitDFkbsnWG2QUZllOjot1GeQrfRmKQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ritesh Raj Sarraf <rrs@researchut.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.19 086/113] um: Dont hardcode path as it is architecture dependent
Date:   Wed, 15 May 2019 12:56:17 +0200
Message-Id: <20190515090700.188199892@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ritesh Raj Sarraf <rrs@debian.org>

commit 9ca19a3a3e2482916c475b90f3d7fa2a03d8e5ed upstream.

The current code fails to run on amd64 because of hardcoded reference to
i386

Signed-off-by: Ritesh Raj Sarraf <rrs@researchut.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/um/drivers/port_user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -168,7 +168,7 @@ int port_connection(int fd, int *socket,
 {
 	int new, err;
 	char *argv[] = { "/usr/sbin/in.telnetd", "-L",
-			 "/usr/lib/uml/port-helper", NULL };
+			 OS_LIB_PATH "/uml/port-helper", NULL };
 	struct port_pre_exec_data data;
 
 	new = accept(fd, NULL, 0);


