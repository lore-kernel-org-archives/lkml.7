Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A392EC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A0C22314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003326;
	bh=7XcAk6WwlPZiHwrNeSvnm56FOXEsLlHpDvmdPRl2cqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LheqwHK0lq43gU+mX+0Fp06fz3u+NPivcBjnzy2HTVtOzmKYGXpt32MKSamZRPI65
	 zy5xWA7SIVYAWGxd4wdosKlemLnES5jxFgGjjWlr85nKhBl4EgaOktjOgtMPqLZXX1
	 J67PDEUjPeanklQ0+B33nJkMFKRRfMSMcT1255KU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgABWPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgABWPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:15:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0ABF227BF;
        Thu,  2 Jan 2020 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003318;
        bh=7XcAk6WwlPZiHwrNeSvnm56FOXEsLlHpDvmdPRl2cqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUVTtNJPk/Iy3ZQAfl20yvepQSdT2c8CeuSIG+XyNWpYXXe9JbjmTHs6CLEmU+qB/
         6oxPa553Y3nfJRmy3l4+gt33kA0uLwZmavAwjI/aLrBMUP/ZVRKq6Mp7qEwhB+a9Xy
         /5WWPo8gii2E7e/TmwsFktoCxDNJQWEfTK+NI73U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 110/191] um: virtio: Keep reading on -EAGAIN
Date:   Thu,  2 Jan 2020 23:06:32 +0100
Message-Id: <20200102215841.663236426@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 7e60746005573a06149cdee7acedf428906f3a59 ]

When we get an interrupt from the socket getting readable,
and start reading, there's a possibility for a race. This
depends on the implementation of the device, but e.g. with
qemu's libvhost-user, we can see:

 device                 virtio_uml
---------------------------------------
  write header
                         get interrupt
                         read header
                         read body -> returns -EAGAIN
  write body

The -EAGAIN return is because the socket is non-blocking,
and then this leads us to abandon this message.

In fact, we've already read the header, so when the get
another signal/interrupt for the body, we again read it
as though it's a new message header, and also abandon it
for the same reason (wrong size etc.)

This essentially breaks things, and if that message was
one that required a response, it leads to a deadlock as
the device is waiting for the response but we'll never
reply.

Fix this by spinning on -EAGAIN as well when we read the
message body. We need to handle -EAGAIN as "no message"
while reading the header, since we share an interrupt.

Note that this situation is highly unlikely to occur in
normal usage, since there will be very few messages and
only in the startup phase. With the inband call feature
this does tend to happen (eventually) though.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/virtio_uml.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index fc8c52cff5aa..c5643a59a8c7 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -83,7 +83,7 @@ static int full_sendmsg_fds(int fd, const void *buf, unsigned int len,
 	return 0;
 }
 
-static int full_read(int fd, void *buf, int len)
+static int full_read(int fd, void *buf, int len, bool abortable)
 {
 	int rc;
 
@@ -93,7 +93,7 @@ static int full_read(int fd, void *buf, int len)
 			buf += rc;
 			len -= rc;
 		}
-	} while (len && (rc > 0 || rc == -EINTR));
+	} while (len && (rc > 0 || rc == -EINTR || (!abortable && rc == -EAGAIN)));
 
 	if (rc < 0)
 		return rc;
@@ -104,7 +104,7 @@ static int full_read(int fd, void *buf, int len)
 
 static int vhost_user_recv_header(int fd, struct vhost_user_msg *msg)
 {
-	return full_read(fd, msg, sizeof(msg->header));
+	return full_read(fd, msg, sizeof(msg->header), true);
 }
 
 static int vhost_user_recv(int fd, struct vhost_user_msg *msg,
@@ -118,7 +118,7 @@ static int vhost_user_recv(int fd, struct vhost_user_msg *msg,
 	size = msg->header.size;
 	if (size > max_payload_size)
 		return -EPROTO;
-	return full_read(fd, &msg->payload, size);
+	return full_read(fd, &msg->payload, size, false);
 }
 
 static int vhost_user_recv_resp(struct virtio_uml_device *vu_dev,
-- 
2.20.1



