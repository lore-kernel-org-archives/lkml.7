Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249EBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AED2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582180;
	bh=OwFBnBZIbqH6wTrqlyKAmbOfZs6eJM6n/SbpiKDUKf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tDcbSUDc/RM5zQlTqyA2UVoHSxZ1hNy1CQ1wgXVpHIyRJpBU5EuIpDIKPDUSDqhO7
	 5G2ma3F4mvE/iq97xRM+kXnPlR/jxq329TBINsZwq9MXJ+gjlyo6dyWCC7I6WwCfv4
	 JsA+2WnmaWe3MwZbURlJZEaA+DNor76leUcOFFUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbfCZGgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731786AbfCZGgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:36:16 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 816ED20863;
        Tue, 26 Mar 2019 06:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582176;
        bh=OwFBnBZIbqH6wTrqlyKAmbOfZs6eJM6n/SbpiKDUKf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzXGRu4DrehKPCc0y455sldEcHF+2si9GbaCVc1zpAPXvMczYCNz8LJfqz0pzL9o9
         tvCLWchqoR7uhMSMEC3tjQJBxXEmMebIx5Ab+l3mCsF0hHkit3Nns9cZgqcf5Sm+De
         kD5Xnb8iB6ZpYi2bmALSJapSJN3PsJbvP5r8Q1/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 24/45] ALSA: hda/ca0132 - make pci_iounmap() call conditional
Date:   Tue, 26 Mar 2019 15:30:07 +0900
Message-Id: <20190326042703.954186355@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1e73359a24fad529b0794515b46cbfff99e5fbe6 upstream.

When building without CONFIG_PCI, we can (depending on the architecture)
get a link failure:

ERROR: "pci_iounmap" [sound/pci/hda/snd-hda-codec-ca0132.ko] undefined!

Adding a compile-time check for PCI gets it to work correctly on
32-bit ARM.

Fixes: d99501b8575d ("ALSA: hda/ca0132 - Call pci_iounmap() instead of iounmap()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7394,7 +7394,7 @@ static void ca0132_free(struct hda_codec
 	ca0132_exit_chip(codec);
 
 	snd_hda_power_down(codec);
-	if (spec->mem_base)
+	if (IS_ENABLED(CONFIG_PCI) && spec->mem_base)
 		pci_iounmap(codec->bus->pci, spec->mem_base);
 	kfree(spec->spec_init_verbs);
 	kfree(codec->spec);


