Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EC020880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355295;
	bh=lnRg+hlZ37Jwr4Qodrd+Dznb8yELeU0TfsDc0lDQVLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G6+ClpwoG2bmK1hzyFUGQGKK36R37TFaWAvnQCb5FekB0UUQjHLEdliC5J7hnvpIg
	 LoB1WEPm9X03+7cC2COXSS2FtH5hlSAZ5/LMnn1frJq0pDpgsBzBYFshKdfNAk2ndt
	 X96XJ5RSU3waMvYgGTfuCW6+ha/aWaErV5OH3wPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfDOTIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbfDOTIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:08:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7722C20880;
        Mon, 15 Apr 2019 19:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355292;
        bh=lnRg+hlZ37Jwr4Qodrd+Dznb8yELeU0TfsDc0lDQVLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+HFiwBYcqK1xIgUr+HJBPjwW9iUJ2LgpVk2iMikRODzRlkJkWYF3d3MCr+qEtXpO
         ZEQeAU256jFSPGX9P461smU11xhVTllLSyY4EoL2MNpxxh/f3YvB7yr148Hilo0Y37
         gfH4OKN8zBpvTU7MEkmNKBi7YExbynhMjrz2UreU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 053/101] ALSA: hda - Add two more machines to the power_save_blacklist
Date:   Mon, 15 Apr 2019 20:58:51 +0200
Message-Id: <20190415183743.351980837@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit cae30527901d9590db0e12ace994c1d58bea87fd upstream.

Recently we set CONFIG_SND_HDA_POWER_SAVE_DEFAULT to 1 when
configuring the kernel, then two machines were reported to have noise
after installing the new kernel. Put them in the blacklist, the
noise disappears.

https://bugs.launchpad.net/bugs/1821663
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2272,6 +2272,8 @@ static struct snd_pci_quirk power_save_b
 	SND_PCI_QUIRK(0x8086, 0x2040, "Intel DZ77BH-55K", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=199607 */
 	SND_PCI_QUIRK(0x8086, 0x2057, "Intel NUC5i7RYB", 0),
+	/* https://bugs.launchpad.net/bugs/1821663 */
+	SND_PCI_QUIRK(0x8086, 0x2064, "Intel SDP 8086:2064", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1520902 */
 	SND_PCI_QUIRK(0x8086, 0x2068, "Intel NUC7i3BNB", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
@@ -2280,6 +2282,8 @@ static struct snd_pci_quirk power_save_b
 	SND_PCI_QUIRK(0x17aa, 0x367b, "Lenovo IdeaCentre B550", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
+	/* https://bugs.launchpad.net/bugs/1821663 */
+	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
 	{}
 };
 #endif /* CONFIG_PM */


