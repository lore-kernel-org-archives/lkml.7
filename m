Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1DEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808452064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494956;
	bh=rWMI78uObu5Jq7fpXek1iMxgJ/1Q82HDvXacm5NBlAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q2vkO9j36Tv5lZoM4ZKy1WJ1XrX1mN9G3xGqs0sxhExCMcW6jAXg3Hcm/O/tHr0or
	 X+XNkzaJHFhzH2H5DMlE1toaD1gdUhp1F/YPIe7mmUGGGez/a9JtQd/nEDJRz+Ax1N
	 9of1bIAVP8qmQ5WBLxWxg49avlTHx+AkMbLcgjzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390889AbfHVR0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404408AbfHVRZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:26 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1E1123427;
        Thu, 22 Aug 2019 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494725;
        bh=rWMI78uObu5Jq7fpXek1iMxgJ/1Q82HDvXacm5NBlAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHFC8cwm3W9eW3ukiBoEn2sLzdgOL+wF+pjj9sQB4FUPfis2zJEOLidPRsyp+kAtc
         gT22xxypOR2vVPCDTD0roaTLTjMfGHXXMzbRyqqw4aQHTlB10gXrLZK8cEpPOR3YOR
         M8QpoHcYvMY7s8aEHBe5i8wDAaoe2YD5Ea3yvHpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 15/85] ALSA: hda - Fix a memory leak bug
Date:   Thu, 22 Aug 2019 10:18:48 -0700
Message-Id: <20190822171731.773409513@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

commit cfef67f016e4c00a2f423256fc678a6967a9fc09 upstream.

In snd_hda_parse_generic_codec(), 'spec' is allocated through kzalloc().
Then, the pin widgets in 'codec' are parsed. However, if the parsing
process fails, 'spec' is not deallocated, leading to a memory leak.

To fix the above issue, free 'spec' before returning the error.

Fixes: 352f7f914ebb ("ALSA: hda - Merge Realtek parser code to generic parser")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -6082,7 +6082,7 @@ static int snd_hda_parse_generic_codec(s
 
 	err = snd_hda_parse_pin_defcfg(codec, &spec->autocfg, NULL, 0);
 	if (err < 0)
-		return err;
+		goto error;
 
 	err = snd_hda_gen_parse_auto_config(codec, &spec->autocfg);
 	if (err < 0)


