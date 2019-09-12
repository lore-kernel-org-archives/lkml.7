Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E11AC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 01:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5002D2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 01:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4v95DuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfILBhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 21:37:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41507 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfILBhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 21:37:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so14830735pfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 18:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jy5SRy6ysNBo94VTweaZaJHfTY+VCYVdnfQshAKb0WM=;
        b=k4v95DuE7lWKvBVdtvsH9CRWmXvIB21882kOWRmrwlL/ePhEwfw9Umgw9vULw7E2pr
         NVdU9bQsOdCZ9OqGvvbpdJAhmfr/HLZM1qhPAMCz+vCZUV+CnNEz68izuCfyinsvaDB1
         2sFQgGdUAZz3MfMrzrAq1YQtmc5BG1DEqUsr+phrNgMVMYVdwBlM/YyBtDAMQDCShSG5
         nGvMZc8g6Sf2aEq2+Jtzzehmv8dHIuBfwjfj9fMTvOJCgni7U2tZUEB57QMy6ZTh8n4x
         ZS/EHtXKa8u2NVYMphQ0nK4dDJLbr9fFcW5/A5wfMK0uDo894TT2vJRFC0UkkWfZyT2N
         KYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jy5SRy6ysNBo94VTweaZaJHfTY+VCYVdnfQshAKb0WM=;
        b=k98IFi7PX1zR8XYaA5cjhe1lTkkiUEpeVSKNdGKlvd1K5E9ISZ8575wD/bac1FR4Sl
         mrp20LRFhIEEidXfzo0k4lGd+B7rbeAAIpZXmK0+mE9P69GrZtVVIOtIOFBPkYLIFeQa
         va2wHADW8T7/pZP+n+kVaknX48+AddFeryNHiBZcDMwJCVLdXTEYRqnzVq+oCl/dHOZl
         f2UFzBteCder0a5NiFRfPZgrP7NVnLqw3XqbHkLpFjAdfICgkOQLX5HeJelFvKsU+2hk
         mAj+BV4zqIS/8M1NAFjZsCgD8rdEhGUMP0z2i5eHOoPGUCKWOKkdtKLAKXz6Irlw+qLV
         qkRA==
X-Gm-Message-State: APjAAAUYlOwNt7kaGgsww7RyikLcnEOPBVpqpGv+3CyD2nRIeNYd+ZUz
        HxWUfXkveNfgRktTHOgWdhc=
X-Google-Smtp-Source: APXvYqyt8MVFo3gbMGKTnWOJvKI7dY5EL+0DtCMd2EJSVzgh2no+WFBAS33R4p5z/B7AnHZZ/JevTA==
X-Received: by 2002:aa7:9194:: with SMTP id x20mr21524493pfa.126.1568252267613;
        Wed, 11 Sep 2019 18:37:47 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id f22sm8682967pgb.4.2019.09.11.18.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:37:46 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] tc358767 test mode
Date:   Wed, 11 Sep 2019 18:37:38 -0700
Message-Id: <20190912013740.5638-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series is a couple of patches exposing TestCtl register of
tc358767, which can be pretty handy when troubleshooting link problems.

Changes since [v1]:

    - Debugfs moved into a standalone directory and is now created as
      a part of probe()

    - Added tstctl_lock to ensure mutual exclusion of tstctl code and
      bridge's enable/disable methods

    - tc_tstctl_set() changed to function only if bridge was previosly
      enabled

    - Added comment explaining data format expected by "tstctl"

    - Debugfs permission changed to reflect write-only nature of this
      feature

    - Original commit split into two

    - Minor formatting changes

Thanks,
Andrey Smirnov

[v1] lore.kernel.org/r/20190826182524.5064-1-andrew.smirnov@gmail.com

Andrey Smirnov (2):
  drm/bridge: tc358767: Introduce __tc_bridge_enable/disable()
  drm/bridge: tc358767: Expose test mode functionality via debugfs

 drivers/gpu/drm/bridge/tc358767.c | 184 ++++++++++++++++++++++++------
 1 file changed, 148 insertions(+), 36 deletions(-)

-- 
2.21.0

