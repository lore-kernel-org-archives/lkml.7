Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ABAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21336217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gc2ODOLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392100AbfITDZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 23:25:15 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56579 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389462AbfITDZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 23:25:15 -0400
Received: by mail-pg1-f201.google.com with SMTP id h5so3507317pgq.23
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 20:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ex5S+EddAB54/0CCml7QbmSM+qrl+SnL+MOYNcuwHlo=;
        b=Gc2ODOLsGsHeQow1q8Fl61gSimubTDsTR6s6NHbtSqwj/+kmxNx8h8vb7CGP/bt2mm
         h6UxJ6n1CJXn5kxebgPd2uHb53z6fBY4dOjttbqRXoi69IQ8IdSb1FA2bufrWorTp7fJ
         9NdGlE4x1RrLlSoPyd9Zwd2nBukPhAewr9atfyPDh/XHXCEKG6IpZAftoQ/StjZOmDW1
         rY02dQZfS9lA9V2iWcRfVBopg1EfFWWITnnWJLE/NGXb9pdrAqYsnZm8oaeYJz0j82qJ
         mDlzqmk6YZJhFkmahbMyFG2axdUW8mEwgRBJDQCo7pDdJNiR59Hj0lBfPxYVRgF/hpes
         uLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ex5S+EddAB54/0CCml7QbmSM+qrl+SnL+MOYNcuwHlo=;
        b=Q9LCc7kh6pw2MB8aWZpHYOy/phTFFABhUvqNC6OGicB5HcEm32PrtqWZHISqVExCj5
         6YzVU6PNUMbPMXS4hYqLcermmKQ1khoO8CEmGBNgwlXrYYpFekyZVPZ0kzwHyUqatHOU
         bQB8z2HYVb3xHCUmJdznpGJUoXC458JpLdlgNDiLZGqWb0aL4cY8MzvOcbwSrpdjXtPk
         7zVYETS+9lKj3IMog9LsssZAwadFwlYo2WhXJxjyOS3C9Gp5AdRx+v7KwwVLj4txSb4S
         0clUG3rDUcY79oC3Lf157K1DnUgVKul6fYJex3Smp5kzba8X84GXV7s+Q1iQdya9khrj
         7W1Q==
X-Gm-Message-State: APjAAAXqNCWdkqCdJO8ykzVLNhw7vdzwaR2VX3Cgw/lkv026yKgSUqFn
        r8+MPdL5OgWpGXVmN3or6Eq7yFdiXAgN
X-Google-Smtp-Source: APXvYqz++jeY2qTZJhTPpFkv9AGfU1Vj2/IzomECoofk9kzsBfHodqokRgwtOpkpDQgPgJ0sL9y8KMC9UKXz
X-Received: by 2002:a63:d46:: with SMTP id 6mr13061102pgn.364.1568949912474;
 Thu, 19 Sep 2019 20:25:12 -0700 (PDT)
Date:   Fri, 20 Sep 2019 11:24:35 +0800
Message-Id: <20190920032437.242187-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v3 0/2] tcpm: AMS and Collision Avoidance
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, hdegoede@redhat.com,
        Adam.Thomson.Opensource@diasemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Kyle Tso (2):
  usb: typec: tcpm: AMS and Collision Avoidance
  usb: typec: tcpm: AMS for PD2.0

 drivers/usb/typec/tcpm/tcpm.c | 523 ++++++++++++++++++++++++++++++----
 include/linux/usb/pd.h        |   1 +
 include/linux/usb/tcpm.h      |   4 +
 3 files changed, 468 insertions(+), 60 deletions(-)

-- 
2.23.0.351.gc4317032e6-goog

