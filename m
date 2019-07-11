Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD08C31E41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6F921537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAL7Q7Ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfGKRRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:17:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33270 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfGKRRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:17:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so3265480pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=I7F5ueyWK2Ezku9M6HsI1DBCxJYJq+OM6Yte6G2+Y0Y=;
        b=TAL7Q7IghRKqWf1ClkAFoTirqeATuA5/2vD/5XkWofRSyEBmfKz24+fm72ANO4jF6o
         OMaq2IsWIliPwiA8T+EmRadZkT/4tDCWl1UGrBPD/4LsCkZe+72GWpXIOtktnXJ0DucT
         X4WUsEUDyuzEclPN9P1L3mbtZlAtbGKAmsnSzXHbHOoB64pISnUwsy1z1Bky7f+dsBzM
         QZU8xmkT55b8L2Zp+2JwfHz25G+Nt1x6eKmQecpTJtVflkZYAdpi8RbtHwlNaKATMqKQ
         qJgaXWevrGsBiHpCR0QgfzGrRQv20ukwV3dqUmfec6AFcsF3dolksLRGNFKXF4TcCxXx
         OY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I7F5ueyWK2Ezku9M6HsI1DBCxJYJq+OM6Yte6G2+Y0Y=;
        b=mHviGPyNEjX2Lfj9Cb9WT5dFbms7l5gIRCoHY+dbmVJKphKyni6t/KkKECccjjhshh
         HxZymzVqkWPuYJS5yn8IS+GwUT4xevw9nrGL5ClNKVIe7JHgfFBrFm1i7N7u39MgpCsY
         1+I3kebtFllGE6nTBapDQN9VO+aU4Bxw08nw54JwDA0X4vutqHHjptuVvYYiF827vImi
         oSH5IpTlwO2tKLhf4F2p4hXHZT1mC3g3AjlFAfevvBxR4JqD+WA50MhUBqSQHnzN2slM
         lS3m0zU8tGa3m0cubkOlFoYJVesztdbZMxyShPz14ROizXMuZMkx0t3aGCzvW6KIsEwv
         wAaw==
X-Gm-Message-State: APjAAAXS+HuU+mbjk/nekrXcTorbVNuL/uVqULLcGJlEkv6PbecKizdT
        N/DAaQli+nrD0TJVgeIktLc=
X-Google-Smtp-Source: APXvYqzsMTXazZXdWR9xdpQFjX2CHap4g9IL5mR47dq8Wx9KYQKgRoKeDopm65v0KzKTv1Z58+h+PQ==
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr5551602pgq.130.1562865452460;
        Thu, 11 Jul 2019 10:17:32 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id m31sm6508468pjb.6.2019.07.11.10.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:17:32 -0700 (PDT)
Date:   Thu, 11 Jul 2019 22:47:26 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: pci: emu10k1: Remove unneeded variable "change"
Message-ID: <20190711171726.GA4356@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issue reported by coccicheck
sound/pci/emu10k1/emu10k1x.c:1077:5-11: Unneeded variable: "change".
Return "0" on line 1092

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/pci/emu10k1/emu10k1x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 67d6473..9cf8183 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1074,7 +1074,6 @@ static int snd_emu10k1x_shared_spdif_put(struct snd_kcontrol *kcontrol,
 {
 	struct emu10k1x *emu = snd_kcontrol_chip(kcontrol);
 	unsigned int val;
-	int change = 0;
 
 	val = ucontrol->value.integer.value[0] ;
 
@@ -1089,7 +1088,7 @@ static int snd_emu10k1x_shared_spdif_put(struct snd_kcontrol *kcontrol,
 		snd_emu10k1x_ptr_write(emu, ROUTING, 0, 0x1003F);
 		snd_emu10k1x_gpio_write(emu, 0x1080);
 	}
-	return change;
+	return 0;
 }
 
 static const struct snd_kcontrol_new snd_emu10k1x_shared_spdif =
-- 
2.7.4

