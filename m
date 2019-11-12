Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9347AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FB321872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfKLPTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:19:13 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:42673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfKLPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:19:00 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MtfRp-1hc9qA0Y5H-00v4Hm; Tue, 12 Nov 2019 16:16:57 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 3/8] ALSA: Avoid using timespec for struct snd_ctl_elem_value
Date:   Tue, 12 Nov 2019 16:16:37 +0100
Message-Id: <20191112151642.680072-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191112151642.680072-1-arnd@arndb.de>
References: <20191112151642.680072-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lAmj6kwQ3S1uoAqMviQM0k/X4NCJC4z7wsHW/iJ6hmK73azYUPt
 LeTeoMm+SHmEwAZSSGex8hmlIuQz1YByD4R8gEFDR4S+8G55DbnRcj0W0ApNMll1LTV74a0
 eMmTSt5CgtWlHtvPZzJeGmfuKGcw5DNGmAbCUAJLXaT7Q1+DC17XLuD9xk4rBfumKtKNjGg
 81fE5bja9OklrzP2MBUJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NBo0lQzLa3c=:TO19rw24nS3btXFzrd006z
 LH86aIw7gIdJ1DH9EzgtWisBKUxfHshRNwfm6je6GgCiQh1JWB17Ilq3e7N13lsbNAt5f3d41
 YjJUYkVoQdvx9Z1iat/l5h/N9b2TjHp8v6NAm2LWn5cOqWHy1OeWIC2fGXA6PwwIdvdQd0392
 oAZk2ix/wgG+bdCQKbQsrAmEw0VnpjUWOm+/Ia5YTRmIYvPgRUmS1fSIy50OvVWtuOS/xnIfe
 PVvEXxGKggyvU7VHTDWY3RfXIZ3lnAawDoi6eptSKIC+dF88FATHjsXCVF3+ZLVuDLmf4Oc7m
 wgl1j/bNO/22zESP/fxR0i8Xu6z7n80I6WL9+9x3UK3KpkTxAttrVOzPUe1WFD53MF9SqC2Pz
 Rf8dw6lAi0LzG/BkdXaHO9sumnOCpb5hDVUqj6sk3q/VS9WmS46RYghR3TJ8G05de7aiUa9wk
 AVlTOYNOAeUBVkwzrC9WM5cahcmMVXlNKV1vnakMfDZkGvCBwez09eOnVLKMA578el4yvpeFj
 CfIY3lrRaJ+z0bpEAoPEiHcCxBjV2ukhd9+Sqq7dbj/X+JVErMseRlb50e7cSNVPjjsUmGKvN
 i8rqbtgmSsPJP7HX/uvY8b6IzAuCxafnWmhT8xHDT2Wh5uTZN8xbyxjPRQXtNi/ZLzNY2o8Xc
 RxbvsLDLwyLlP/Ke/+3XeAep6/hUUMyCNPi4nDjauabkZGig4aOMT0We4ZkAwlO4KLfr9bncX
 d7W5sXZ1dnuh8dZi4yt3oHeDnZr5C52ECiVRTMOG+i8bA0Fv3s1t1/jDnsR6rUJY/mqQkEFUj
 jvpyaraqnBYUW/zQgOgJsxvhyv71jJ9P4IJJDAmkxZ4OKsoqYKPtYXEGJ2JUL7Sg7GoybdGh7
 Ql4RYV1KciH+TmKXFnjg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

The struct snd_ctl_elem_value will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Since there are no drivers will implemented the tstamp member of the
struct snd_ctl_elem_value, and also the stucture size will not be changed
if we change timespec to s64 for tstamp member of struct snd_ctl_elem_value.

From Takashi's comments, "In the library, applications are not expected
to access to this structure directly. The applications get opaque pointer
to the structure and must use any control APIs to operate it. Actually the
library produce no API to handle 'struct snd_ctl_elem_value.tstamp'. This
means that we can drop this member from alsa-lib without decline of
functionality." Thus we can simply remove the tstamp member to avoid using
the type which is not year 2038 safe on 32bits system.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/sound/asound.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 930854f67fd3..40a23d8418fe 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -957,8 +957,7 @@ struct snd_ctl_elem_value {
 		} bytes;
 		struct snd_aes_iec958 iec958;
 	} value;		/* RO */
-	struct timespec tstamp;
-	unsigned char reserved[128-sizeof(struct timespec)];
+	unsigned char reserved[128];
 };
 
 struct snd_ctl_tlv {
-- 
2.20.0

