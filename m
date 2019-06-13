Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41138C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1081620679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442265;
	bh=GXSsHoONhYs3v9VvIDnNur0FcJCX48oYI69FzwVuKns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G6PgF6PrwqfS4/8z+12aLUTP9ogZfXJczealLA1FVqZZDiZMHKmmAKERz7zJjarRN
	 VdJaRHKSQ0NeNGpRjfaMWFAUb1n3D+hUb2BiqPbtQcBjDqAUPOKfmyQlJWn8upnz7Z
	 gB8aDwynMHUzT/vdwJuEpGvYw5E7PPADWqcjjVz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391140AbfFMQLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731244AbfFMInj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:43:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A07A21744;
        Thu, 13 Jun 2019 08:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415418;
        bh=GXSsHoONhYs3v9VvIDnNur0FcJCX48oYI69FzwVuKns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HoUEyvLYLpZZx2Hwo83WtNdmH+nCH+t0cZxLoomLadsbTPzWvOWdirDD3sP17t/Wy
         3FqrKC9RVRpzwVfTHLflJ/2Mfn9840t963jC3JxZfHWOnab+6yo42ZCUYTs9w0HlIU
         F+gFnp55uKHFRXTuj0dTBLDH3eufWJAqcs3ZmO1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH 4.19 118/118] drm/vc4: fix fb references in async update
Date:   Thu, 13 Jun 2019 10:34:16 +0200
Message-Id: <20190613075651.218844366@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

commit c16b85559dcfb5a348cc085a7b4c75ed49b05e2c upstream.

Async update callbacks are expected to set the old_fb in the new_state
so prepare/cleanup framebuffers are balanced.

Calling drm_atomic_set_fb_for_plane() (which gets a reference of the new
fb and put the old fb) is not required, as it's taken care by
drm_mode_cursor_universal() when calling drm_atomic_helper_update_plane().

Cc: <stable@vger.kernel.org> # v4.19+
Fixes: 539c320bfa97 ("drm/vc4: update cursors asynchronously through atomic")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190603165610.24614-5-helen.koike@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_plane.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -818,6 +818,7 @@ static void vc4_plane_atomic_async_updat
 		drm_atomic_set_fb_for_plane(plane->state, state->fb);
 	}
 
+	swap(plane->state->fb, state->fb);
 	/* Set the cursor's position on the screen.  This is the
 	 * expected change from the drm_mode_cursor_universal()
 	 * helper.


