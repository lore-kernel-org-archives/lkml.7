Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABECC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC0D20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582127;
	bh=ywvq/maW9K7QLpX1hjiYZ+Qm0nBnRf6z7VWScG59Vdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wrlKWPbrcZumqGjJaxHz55N3WM1waYE5BPY2MfTcCJeS4Tj47z8nN0yjrqar/DMjZ
	 7ku0rBfu7SF6XV3KQy7XvqFru7KTH0de+9w7CYHFqw/IA9SfFgZqRXl958gmUNikz/
	 qmSUDhDxcRkDyZ8ICqQd/LjXHfN1koswl/8yga3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfCZGf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731092AbfCZGfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:35:23 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B6D920856;
        Tue, 26 Mar 2019 06:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582122;
        bh=ywvq/maW9K7QLpX1hjiYZ+Qm0nBnRf6z7VWScG59Vdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xJUfgLuMN2sfZY+Vw4i7lViyljBc1vY01sLjxcKGnDdta58XYa8IIuQOn5+2eYemc
         5YcnUqB0z0e1Z8Mp05mpvPhB6RairZCoHqNGPD0LlazJI7jSn105liMzb0N0/5LJhA
         Be2OejdF5NraZzPnp/73cRwQPJ/LzqL10BKsq2vo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, hs.guimaraes@outlook.com,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 01/45] ALSA: hda - add Lenovo IdeaCentre B550 to the power_save_blacklist
Date:   Tue, 26 Mar 2019 15:29:44 +0900
Message-Id: <20190326042702.722020013@linuxfoundation.org>
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

From: Jaroslav Kysela <perex@perex.cz>

commit 721f1e6c1fd137e7e2053d8e103b666faaa2d50c upstream.

Another machine which does not like the power saving (noise):
  https://bugzilla.redhat.com/show_bug.cgi?id=1689623

Also, reorder the Lenovo C50 entry to keep the table sorted.

Reported-by: hs.guimaraes@outlook.com
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2274,10 +2274,12 @@ static struct snd_pci_quirk power_save_b
 	SND_PCI_QUIRK(0x8086, 0x2057, "Intel NUC5i7RYB", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1520902 */
 	SND_PCI_QUIRK(0x8086, 0x2068, "Intel NUC7i3BNB", 0),
-	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
-	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1689623 */
+	SND_PCI_QUIRK(0x17aa, 0x367b, "Lenovo IdeaCentre B550", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
+	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	{}
 };
 #endif /* CONFIG_PM */


