Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC33BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B9920865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122397;
	bh=WXzNGseD5jr5zANbkRHH1Q37v3XRHzN4zPvYLkcjA6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fXncUNU4l57wJvxya7rSwXxyRTcufgF20c8I0LStgN3izgZALXhqyU4oWv66SR/GV
	 3KCZT16w7LY3ki+sAcIkgVmlOHSLaEO80tsy/wo94PSKhVn4KgHRkxwI5AkkCbMD6R
	 9STQzYYRrgB+8dLrtE6ylPqL6Ur/7ML7u5lV+Zqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392296AbfJCQh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392264AbfJCQhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:37:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A5042133F;
        Thu,  3 Oct 2019 16:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120672;
        bh=WXzNGseD5jr5zANbkRHH1Q37v3XRHzN4zPvYLkcjA6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+V+EZzmwlwZXzhqc+H/tXVg0LZqJ0/D2SyOSTrgTRu9FnedjOVUi+Z8h0pWP+s/L
         5HyBn1JBpeCPFRrbz9o6mjziBn1Yk2prYyssMTgL6f0H+KnHaSzYZeUEDKjaUeXwgW
         uGXwmheFp6t8ZfjefHLQoK3iotDDJaQ8qL4DHTcY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.2 309/313] drm/amd/display: Restore backlight brightness after system resume
Date:   Thu,  3 Oct 2019 17:54:47 +0200
Message-Id: <20191003154603.632876506@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit bb264220d9316f6bd7c1fd84b8da398c93912931 upstream.

Laptops with AMD APU doesn't restore display backlight brightness after
system resume.

This issue started when DC was introduced.

Let's use BL_CORE_SUSPENDRESUME so the backlight core calls
update_status callback after system resume to restore the backlight
level.

Tested on Dell Inspiron 3180 (Stoney Ridge) and Dell Latitude 5495
(Raven Ridge).

Cc: <stable@vger.kernel.org>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1958,6 +1958,7 @@ static int amdgpu_dm_backlight_get_brigh
 }
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
 	.get_brightness = amdgpu_dm_backlight_get_brightness,
 	.update_status	= amdgpu_dm_backlight_update_status,
 };


