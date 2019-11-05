Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F75CA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CAB2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJhg3CGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbfKEGuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:50:07 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42533 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387569AbfKEGuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:50:06 -0500
Received: by mail-pl1-f201.google.com with SMTP id t20so4330140ply.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qCeFlbyrnMcrHFlLhSN5HMeHG/nyd0rgMghVUK8SWyU=;
        b=UJhg3CGsXy9j7IX8NqYpVm8PNHaSjz/ZMQPeInT5SEktKxWvQEwmQSszw76cjMxmoV
         hMOOMOuKHzHXtdXIxkls89wQDZB5DHhAHUa8h1u8CJSm0HRCtnwBZNpfRiCYYxGaXo95
         4mQwJDLV/eYHfQ76+I/eZe/sA3nmlrEPFO67sNNXvwZzo54AVfyrVXHjDQsAUXZ+4TS0
         AHA3yyOwd6kt07jpC2FJx5z4F3VNzixvWvHCE3w8qZuccTcWyY8xA17TPmXzhijBoJET
         g10+DGsRL8WIxNKsPL96sXufdweT7IEIPWP6VqHCfV6KFETD8U4eRCD7mzH4PGsjO6eY
         +sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qCeFlbyrnMcrHFlLhSN5HMeHG/nyd0rgMghVUK8SWyU=;
        b=dAD4hQcIHc6Y8Emsxdwk2s+GFl7xd7nypPo+/pyL1tw35mvoKisf85lCKoyCRYZoOP
         0f/MxM9VOZMd/qtsBn7vrAwNx5e3laJdQ2nhrjcNVsTaJAAnesZ21ynypTe9wngiIH31
         LWMK4TvuZmQi/EAjNOrHoiL31LoT1t7b3wFtpWpsmUnco4GXiBsWS7caEcsuypqW4GSX
         Ob839Z+mGVvXDuKM9eqN1RFF74VrWPQdBW3yLlaJ9DF/4l2YzwlhSZ0+0Wjkad/5okXT
         99GGtmL3MXEwolXPac4TMFQTvszZ9uaAFYr87bbcp638IXH53zUNFKQnSqczKMpMPfWj
         fq7w==
X-Gm-Message-State: APjAAAVFPtKum/iJ7tcRuCDzztssCSA78Z+Ae0N30hEL+JcET6O86yk7
        2GU61Q7Zf/kxoIo3RmePzL/EHcPidh2nurc=
X-Google-Smtp-Source: APXvYqwS3KW98+ZsDBeSpwefkBvIfvM3bWJHpUb+plHz9bbxaybX1WGLtfMKqGsnhh/dwL9nmnj6Byf7q1GU52M=
X-Received: by 2002:a63:fc19:: with SMTP id j25mr20855776pgi.204.1572936604345;
 Mon, 04 Nov 2019 22:50:04 -0800 (PST)
Date:   Mon,  4 Nov 2019 22:49:57 -0800
Message-Id: <20191105065000.50407-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v1 0/3] of_devlink: Minor fixes and new properties
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending again since the cover letter missed everyone/mailing lists.

First two patches are just code clean up and logging with no functional
difference. The 3rd patch adds support for the following DT properties:
iommus, mboxes and io-channels.

These patches are on top of driver-core-next since that's where the rest
of the of_devlink patches are.

Greg and Rob,
On a side note, I was wondering if I should rename the of_devlink kernel
command line to fw_devlink and move it out of drivers/of/property.c and
into drivers/base/core.c. This feature isn't really limited to
devicetree, so I don't see a need to have devicetree specific kernel
command line option.  Please let me know if that sounds okay to you.

Thanks,
Saravana

Saravana Kannan (3):
  of: property: Minor style clean up of of_link_to_phandle()
  of: property: Make it easy to add device links from DT properties
  of: property: Add device link support for iommus, mboxes and
    io-channels

 drivers/of/property.c | 78 +++++++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 17 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

