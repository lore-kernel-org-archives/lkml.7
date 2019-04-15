Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF91C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BBC218FF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355499;
	bh=E2iC6yA9zYmFQwbiiiB8xuLXmAxmuCUMCHfMaY3b69w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BPFCYxOvegxt7FrQnM6HOP7w0q0ONqzWSwlAZQlN+CIXMIfP9KTc16ClRh91TEOaO
	 l9QklpMAb8aov6Sas2HYDfjl03EzV5EA1IYdVi5ZwVcdeLNG8dZJoUwd4cOGHYMDe5
	 Mvty0CgUjAGFahziQ5nqwn8Jy25u8eMfOYr9leNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfDOTLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731244AbfDOTLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D5A20880;
        Mon, 15 Apr 2019 19:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355493;
        bh=E2iC6yA9zYmFQwbiiiB8xuLXmAxmuCUMCHfMaY3b69w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgonYyJ1KAwfYgqF+kBV59CzcZEfsDH9xvn2Lfu27u9ddVwzH+aCXJACp57bmsBw1
         D14NGhIFLFAa0S/H3EfqsEEXddxSGdd9d7V2RjIEzFlLl7vm3JZyFxh53BrN14SG7z
         HvO+CvQ3c5Z/Pe5OTwcmP75vrGINFXupDOKGy7F0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 056/117] ALSA: xen-front: Do not use stream buffer size before it is set
Date:   Mon, 15 Apr 2019 21:00:26 +0200
Message-Id: <20190415183747.781946658@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

commit 8b030a57e35a0efc1a8aa18bb10555bc5066ac40 upstream.

This fixes the regression introduced while moving to Xen shared
buffer implementation.

Fixes: 58f9d806d16a ("ALSA: xen-front: Use Xen common shared buffer implementation")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: <stable@vger.kernel.org> # v5.0+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/xen/xen_snd_front_alsa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -441,7 +441,7 @@ static int shbuf_setup_backstore(struct
 {
 	int i;
 
-	stream->buffer = alloc_pages_exact(stream->buffer_sz, GFP_KERNEL);
+	stream->buffer = alloc_pages_exact(buffer_sz, GFP_KERNEL);
 	if (!stream->buffer)
 		return -ENOMEM;
 


