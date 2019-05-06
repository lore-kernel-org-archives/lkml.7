Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAEAC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDCD2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153746;
	bh=tVvR0QL7GT+PXhjn9vQ43FfBUr3wxctL7AKnJQs2I6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r/S0QZIjFAwcnKu6swEpNMoQEK1He6LEc4I6NCInGuDspzWTlPEz9++I+fCpMHtgz
	 HGMHi+WG3686BmlRaYu5AvE8MQgIWZ4GLUPwxbv7UUXo6jExRrYlWswtQWV29GSKef
	 7FOZoLs0AnbCBzk1PbNYgPKLLl05ykIZAMoDg8ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfEFOmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbfEFOmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:42:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE75A2053B;
        Mon,  6 May 2019 14:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153742;
        bh=tVvR0QL7GT+PXhjn9vQ43FfBUr3wxctL7AKnJQs2I6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNpI6vYM9Wbbe2jOgOFDCM2YyQVl8mm92xIHPX/+V+/CPXmXpgCz8VylDonuBMYUS
         vRkIDFBeOcROlcr4127JYmeBgvLGLe1ti2XjbypLgWk8uua9NhEQHdhDr7V61IVh1k
         KppnS38xrHPEQluehpKhFktYA+3J5OFHVL4c8IDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 79/99] ASoC: wm_adsp: Correct handling of compressed streams that restart
Date:   Mon,  6 May 2019 16:32:52 +0200
Message-Id: <20190506143101.240836871@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

commit 639e5eb3c7d67e407f2a71fccd95323751398f6f upstream.

Previously support was added to allow streams to be stopped and
started again without the DSP being power cycled and this was done
by clearing the buffer state in trigger start. Another supported
use-case is using the DSP for a trigger event then opening the
compressed stream later to receive the audio, unfortunately clearing
the buffer state in trigger start destroys the data received
from such a trigger. Correct this issue by moving the call to
wm_adsp_buffer_clear to be in trigger stop instead.

Fixes: 61fc060c40e6 ("ASoC: wm_adsp: Support streams which can start/stop with DSP active")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/wm_adsp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3441,8 +3441,6 @@ int wm_adsp_compr_trigger(struct snd_com
 			}
 		}
 
-		wm_adsp_buffer_clear(compr->buf);
-
 		/* Trigger the IRQ at one fragment of data */
 		ret = wm_adsp_buffer_write(compr->buf,
 					   HOST_BUFFER_FIELD(high_water_mark),
@@ -3454,6 +3452,7 @@ int wm_adsp_compr_trigger(struct snd_com
 		}
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
+		wm_adsp_buffer_clear(compr->buf);
 		break;
 	default:
 		ret = -EINVAL;


