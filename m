Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264D1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D3420692
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143879;
	bh=XwJSt6JD7kwz1vYS9ZbuPs7cWyskHir9TP0vz4hqv78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kwM2beLuigSVwahTUyTQv7lrnfIMocac+S6LtHlLRFNz0/BQ/05tV7SfU/kIfNYMz
	 BJ279TgYSKqpcrhtvFzR8dKQIJOYYSU72YiYKsvTHDTMLWncwn2EKIrwG5xHYRwGeS
	 f8u6ESXVdrx2yAWOi0Lavg4io7T7qDBhwkQojZ/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfKSFYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:24:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbfKSFYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:24:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 563F121783;
        Tue, 19 Nov 2019 05:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141080;
        bh=XwJSt6JD7kwz1vYS9ZbuPs7cWyskHir9TP0vz4hqv78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNlMkOsIxKlpmzN4qSbgab2udq6xL7R7qnOjMrDnDCJnBht5Hb922gbztHoXLtTcr
         Ft3d8L69kxttyXnAvUqZNhjW5vplTmRCEYqEZUoML6FIwyPqH5rtD7hD6xrBIRZKkd
         bGX+GB66UqVGPgbqr0saAANiN7HAG5UeSpWBXiSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henry Lin <henryl@nvidia.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 011/422] ALSA: usb-audio: not submit urb for stopped endpoint
Date:   Tue, 19 Nov 2019 06:13:28 +0100
Message-Id: <20191119051400.910437992@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Lin <henryl@nvidia.com>

commit 528699317dd6dc722dccc11b68800cf945109390 upstream.

While output urb's snd_complete_urb() is executing, calling
prepare_outbound_urb() may cause endpoint stopped before
prepare_outbound_urb() returns and result in next urb submitted
to stopped endpoint. usb-audio driver cannot re-use it afterwards as
the urb is still hold by usb stack.

This change checks EP_FLAG_RUNNING flag after prepare_outbound_urb() again
to let snd_complete_urb() know the endpoint already stopped and does not
submit next urb. Below kind of error will be fixed:

[  213.153103] usb 1-2: timeout: still 1 active urbs on EP #1
[  213.164121] usb 1-2: cannot submit urb 0, error -16: unknown error

Signed-off-by: Henry Lin <henryl@nvidia.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191113021420.13377-1-henryl@nvidia.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/endpoint.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -401,6 +401,9 @@ static void snd_complete_urb(struct urb
 		}
 
 		prepare_outbound_urb(ep, ctx);
+		/* can be stopped during prepare callback */
+		if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep->flags)))
+			goto exit_clear;
 	} else {
 		retire_inbound_urb(ep, ctx);
 		/* can be stopped during retire callback */


