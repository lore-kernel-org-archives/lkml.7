Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB73214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210256;
	bh=sjSbHMglMWwQHPy2SanwiF45nyDTZay1EIIhEhqfDXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MbVK5L8lQ6ViLD+8dyE7AOsa4kBEjh4CgAFoZ5nMVtIEUiXwW0Pq61FryBOZpICVF
	 KKvkZaVvYFgqohNUCY/GxxwwgBIV+Rw0M4MeHvcpQgp6T8T9kTtKL35vJKvDmEMDLZ
	 7zzMH+wVoC2a4PYq72D8Ugy3VTOy2fEk6EqJbGFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfJ0VEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbfJ0VEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:04:12 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ABDA208C0;
        Sun, 27 Oct 2019 21:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210252;
        bh=sjSbHMglMWwQHPy2SanwiF45nyDTZay1EIIhEhqfDXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyOJx48jhf4+Vu3Qm93+8DzQB5WVq9NsSfjKPeLDXnmDlfz4PSl/mtdw5CmMbh6gR
         pWGVk2BYFGtsybP3q/WQYNuwplCGMoOqrNbjQpwvAevFA1C+NtqFIDouLo1P6VuqOy
         6ofnK5/ZP2PZGi/+z6JHJpOTi9sanUM/aDlchiFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 4.4 29/41] drm/edid: Add 6 bpc quirk for SDC panel in Lenovo G50
Date:   Sun, 27 Oct 2019 22:01:07 +0100
Message-Id: <20191027203123.899876027@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 11bcf5f78905b90baae8fb01e16650664ed0cb00 upstream.

Another panel that needs 6BPC quirk.

BugLink: https://bugs.launchpad.net/bugs/1819968
Cc: <stable@vger.kernel.org> # v4.8+
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190402033037.21877-1-kai.heng.feng@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_edid.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -150,6 +150,9 @@ static struct edid_quirk {
 	/* Medion MD 30217 PG */
 	{ "MED", 0x7b8, EDID_QUIRK_PREFER_LARGE_75 },
 
+	/* Lenovo G50 */
+	{ "SDC", 18514, EDID_QUIRK_FORCE_6BPC },
+
 	/* Panel in Samsung NP700G7A-S01PL notebook reports 6bpc */
 	{ "SEC", 0xd033, EDID_QUIRK_FORCE_8BPC },
 


