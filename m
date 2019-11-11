Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB63EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C132C214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497794;
	bh=0ea7/GZpQmlQybGgBH0aXpZWj1JodYCcr6OCBdlTRIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XPIwoMUIhQtxEQu6xLUQidvzc2HRoA2uLDbMz1iUeqZR/GOeC48/HLhA8B0nGvJsB
	 1Iq/G2ePbnvTLO+xfl82dRG+1D5DSnDdvNq81QXxaCtkX7e/oIyV/C/azGiFbcicbG
	 Drh1oKtr8hoZHHg/a3Qs+g8LaxuZ0CGJaLoqmX1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfKKSnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfKKSnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:43:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EF8E2173B;
        Mon, 11 Nov 2019 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497789;
        bh=0ea7/GZpQmlQybGgBH0aXpZWj1JodYCcr6OCBdlTRIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UmtRZs5Uw1YiZziFMX/33KlJl8ePYPKw2E4ENOSwUFBYlt541XvD85YoLoPMqZhR6
         krjK5YRKUt7sMxAVmZm/DtlkN1FcAi1EMks0TfRgrzZJ9X38aQYWp90VY6c6rHPiN/
         qtjIihgsfQbHfqbxJD9n36/obK0BCZAJ65i12Xj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 058/125] ALSA: usb-audio: Simplify parse_audio_unit()
Date:   Mon, 11 Nov 2019 19:28:17 +0100
Message-Id: <20191111181448.057656319@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 68e9fde245591d18200f8a9054cac22339437adb upstream.

Minor code refactoring by combining the UAC version and the type in
the switch-case flow, so that we reduce the indentation and
redundancy.  One good bonus is that the duplicated definition of the
same type value (e.g. UAC2_EFFECT_UNIT) can be handled more cleanly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |   95 ++++++++++++++++++++++--------------------------------
 1 file changed, 39 insertions(+), 56 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2801,62 +2801,45 @@ static int parse_audio_unit(struct mixer
 		return 0; /* skip invalid unit */
 	}
 
-	if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
-		switch (p1[2]) {
-		case UAC_INPUT_TERMINAL:
-			return parse_audio_input_terminal(state, unitid, p1);
-		case UAC_MIXER_UNIT:
-			return parse_audio_mixer_unit(state, unitid, p1);
-		case UAC2_CLOCK_SOURCE:
-			return parse_clock_source_unit(state, unitid, p1);
-		case UAC_SELECTOR_UNIT:
-		case UAC2_CLOCK_SELECTOR:
-			return parse_audio_selector_unit(state, unitid, p1);
-		case UAC_FEATURE_UNIT:
-			return parse_audio_feature_unit(state, unitid, p1);
-		case UAC1_PROCESSING_UNIT:
-		/*   UAC2_EFFECT_UNIT has the same value */
-			if (protocol == UAC_VERSION_1)
-				return parse_audio_processing_unit(state, unitid, p1);
-			else
-				return 0; /* FIXME - effect units not implemented yet */
-		case UAC1_EXTENSION_UNIT:
-		/*   UAC2_PROCESSING_UNIT_V2 has the same value */
-			if (protocol == UAC_VERSION_1)
-				return parse_audio_extension_unit(state, unitid, p1);
-			else /* UAC_VERSION_2 */
-				return parse_audio_processing_unit(state, unitid, p1);
-		case UAC2_EXTENSION_UNIT_V2:
-			return parse_audio_extension_unit(state, unitid, p1);
-		default:
-			usb_audio_err(state->chip,
-				"unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
-			return -EINVAL;
-		}
-	} else { /* UAC_VERSION_3 */
-		switch (p1[2]) {
-		case UAC_INPUT_TERMINAL:
-			return parse_audio_input_terminal(state, unitid, p1);
-		case UAC3_MIXER_UNIT:
-			return parse_audio_mixer_unit(state, unitid, p1);
-		case UAC3_CLOCK_SOURCE:
-			return parse_clock_source_unit(state, unitid, p1);
-		case UAC3_SELECTOR_UNIT:
-		case UAC3_CLOCK_SELECTOR:
-			return parse_audio_selector_unit(state, unitid, p1);
-		case UAC3_FEATURE_UNIT:
-			return parse_audio_feature_unit(state, unitid, p1);
-		case UAC3_EFFECT_UNIT:
-			return 0; /* FIXME - effect units not implemented yet */
-		case UAC3_PROCESSING_UNIT:
-			return parse_audio_processing_unit(state, unitid, p1);
-		case UAC3_EXTENSION_UNIT:
-			return parse_audio_extension_unit(state, unitid, p1);
-		default:
-			usb_audio_err(state->chip,
-				"unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
-			return -EINVAL;
-		}
+#define PTYPE(a, b)	((a) << 8 | (b))
+	switch (PTYPE(protocol, p1[2])) {
+	case PTYPE(UAC_VERSION_1, UAC_INPUT_TERMINAL):
+	case PTYPE(UAC_VERSION_2, UAC_INPUT_TERMINAL):
+	case PTYPE(UAC_VERSION_3, UAC_INPUT_TERMINAL):
+		return parse_audio_input_terminal(state, unitid, p1);
+	case PTYPE(UAC_VERSION_1, UAC_MIXER_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC_MIXER_UNIT):
+	case PTYPE(UAC_VERSION_3, UAC3_MIXER_UNIT):
+		return parse_audio_mixer_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_2, UAC2_CLOCK_SOURCE):
+	case PTYPE(UAC_VERSION_3, UAC3_CLOCK_SOURCE):
+		return parse_clock_source_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_1, UAC_SELECTOR_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC_SELECTOR_UNIT):
+	case PTYPE(UAC_VERSION_3, UAC3_SELECTOR_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC2_CLOCK_SELECTOR):
+	case PTYPE(UAC_VERSION_3, UAC3_CLOCK_SELECTOR):
+		return parse_audio_selector_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_1, UAC_FEATURE_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC_FEATURE_UNIT):
+	case PTYPE(UAC_VERSION_3, UAC3_FEATURE_UNIT):
+		return parse_audio_feature_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_1, UAC1_PROCESSING_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC2_PROCESSING_UNIT_V2):
+	case PTYPE(UAC_VERSION_3, UAC3_PROCESSING_UNIT):
+		return parse_audio_processing_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_1, UAC1_EXTENSION_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC2_EXTENSION_UNIT_V2):
+	case PTYPE(UAC_VERSION_3, UAC3_EXTENSION_UNIT):
+		return parse_audio_extension_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_2, UAC2_EFFECT_UNIT):
+	case PTYPE(UAC_VERSION_3, UAC3_EFFECT_UNIT):
+		return 0; /* FIXME - effect units not implemented yet */
+	default:
+		usb_audio_err(state->chip,
+			      "unit %u: unexpected type 0x%02x\n",
+			      unitid, p1[2]);
+		return -EINVAL;
 	}
 }
 


