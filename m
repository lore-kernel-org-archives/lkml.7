Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A201C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5620D218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH/TRfN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfJJEtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 00:49:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35583 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfJJEtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 00:49:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id p30so2856090pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 21:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EW2+5LFnHdMStT1dkkpA3jxVK45XROxzbrFNtkIJRsk=;
        b=FH/TRfN2aF35YrrTZyPN8RZZb7vzilxg7Zd3Jh83FAqN0WRCTvQrfY+HWd7wDUY1kk
         urVszhsRNOMkI6oOsBw/X3KGgW29MSONMet5cp/MVnP4XDuhS9WbQ2QAtOztoLqKKGJr
         opwJ8XeVqfCzE3kcneWuHLtFFW2UUqvwFFuZhGUOLjzhIXGp3zmlLouR+GH+lybtYX7O
         CRoKRRk+R13nKYRuLpgEsbsizt4r86FjnE6zuYhvlQCudx/pqnm8klejnEDD1Ejwhl1z
         6tuZZ5wuHtkIeHnoIp1W8Y1MNa6wJ4qqjymHYyRvFJPcUb3HtAqDczZ/0ospqZvkyF23
         bfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EW2+5LFnHdMStT1dkkpA3jxVK45XROxzbrFNtkIJRsk=;
        b=JyNorZioRFSIdJBTiNVORho20TvhELETFqCGquibq3sAlHFmRTjhXc5VxFC/JhA4dL
         fCNiHqafH96VfaUzCIlD9qRaC3I1rce+iHbx4OflDQlkvgj5N6Xbozqwuad/hDBJxWy8
         qHfeFTBXasmTFi4UO+UM7muAl2YncOezJQul0NoeXqutOAYZC5qarc9yaOl1s6Zs9Q2f
         i9bJ5klUarviqJePCaK41569mKz3AX3QS8EQJrYTM2TVW7eLOcULFlTuJ1IE/saJOx0P
         138+s0FlV214bo5jYKvnxtMJ94IglLeI4gTGwuySJ/DC8of8j+/o7/nc6cQPmJAvNS0n
         c9ZQ==
X-Gm-Message-State: APjAAAVARYOHlwkRue7wglFq2+i4DMEMSCVeCgLkrr1jrH4X6RMmtkqK
        za8WyG6vv3Iy2QfTb8TZDh0=
X-Google-Smtp-Source: APXvYqyXQjItBrD3LII9zBw/+oYW9eULSETZmjKnm81v6Zam2PKl1ndnuxp31Ue8Q+aLcxisq4VF+Q==
X-Received: by 2002:aa7:9907:: with SMTP id z7mr8102923pff.133.1570682970937;
        Wed, 09 Oct 2019 21:49:30 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id q20sm4520090pfl.79.2019.10.09.21.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:49:30 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v2 0/4] staging: rtl8723bs: Style clean-up in rtw_mlme.c
Date:   Thu, 10 Oct 2019 07:49:04 +0300
Message-Id: <cover.1570682635.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset addresses multiple style and formatting issues reported by
checkpatch.pl in drivers/staging/rtl8723bs/core/rtw_mlme.c

PATCH v2 of the series corrects the "patchest" mispelling in the
original cover letter and provides a clearer subject line.

Wambui Karuga (4):
  staging: rtl8723bs: Remove comparisons to NULL in conditionals
  staging: rtl8723bs: Remove unnecessary braces for single statements
  staging: rtl8723bs: Remove comparisons to booleans in conditionals.
  staging: rtl8723bs: Remove unnecessary blank lines

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 157 +++++++---------------
 1 file changed, 48 insertions(+), 109 deletions(-)

-- 
2.23.0

