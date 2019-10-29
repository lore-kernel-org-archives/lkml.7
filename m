Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A65ECA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBBC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc6iR0wL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbfJ2Ozb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:55:31 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:40040 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2Ozb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:55:31 -0400
Received: by mail-qt1-f177.google.com with SMTP id o49so20602284qta.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vP/tPXtiesV5kB5mEzKaZW6NBZ7crh1MzX1nomOw+s=;
        b=dc6iR0wLBze6KXkgj/ttZaCRQWairyeIVKneMK0++6eThqhImkw6LTWltEeYiWefmM
         PRUg2vohcd21Dcn/nP35r/GWn3Pkwp0o4sj2lsqt4UWiyBrm+NsaBqy+oj2MYfiTcNxS
         FhEqZcJpLHks2cWHRZ5DrjDSP4WzVLfC9FJeU133fKH8/7htnhHe4N0Rxey++O9fFwjb
         tinQxNnUA+kjUD1lvh9XvFkcI1ZQV74GUVjE3YTyZTTrYHiZZi/jTz37VODUVxpO+zP0
         nZ1e/z2+hkjdjVAeFRU0VPrefIGuLJEBE9EvilcSfegq42CwIWgSl6lyuaX1kpl51cLW
         5D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vP/tPXtiesV5kB5mEzKaZW6NBZ7crh1MzX1nomOw+s=;
        b=JoRZ5YIau1G+dESSha3R2ebLve3s08orPuHwHRZ1doG2YiK0n4CLkxmHoLiAdysWS6
         tH+f3O14osz8HVa0adRK9JuZhZp7xfKwRw2mV+NCi4FOsegxIwIojUAlFoQuC0dU9WPK
         uRZAS/W8+55JECIGKl3xow2h4r1TMZrZ0uccJhf6oRb1MQLmT1atmyZ5Yvw5bg6MBxzq
         Sjliw7e7R7985ZX7onzfw/wn0wozO3PiYXECCrDxFz5ac2yEWOvwHwiWNtYgj+J+OMuA
         j8iTijlFrgRW2bcE9+zyMPLd2mFmf2Dd/sljjmntFe4xDTbSuQSlzMiVVyXwcDoeRZpp
         k1yw==
X-Gm-Message-State: APjAAAVbhzoZFHObap+i0FMuPim012WFaopWp3phtRk9kCe3uiWV/hUH
        TAO07RRSl3gubeCzAEfQfkU=
X-Google-Smtp-Source: APXvYqwctWUt8xYvZl6De/kwpDHvZ0zUEyzj05DBuI+K1Z93X9QlatHxKTVgEroCOq6d5kRXKm4V1A==
X-Received: by 2002:a05:6214:70f:: with SMTP id b15mr22976629qvz.97.1572360928363;
        Tue, 29 Oct 2019 07:55:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:483:ade:87ad:69fb:5b32:cf88])
        by smtp.gmail.com with ESMTPSA id g17sm5978069qte.89.2019.10.29.07.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:55:27 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v2 0/3] staging: rts5208: Eliminate the use of Camel Case
Date:   Tue, 29 Oct 2019 11:55:14 -0300
Message-Id: <20191029145517.630-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in tree rts5208

Gabriela Bittencourt (3):
  staging: rts5208: Eliminate the use of Camel Case in files ms
  staging: rts5208: Eliminate the use of Camel Case in files xd
  staging: rts5208: Eliminate the use of Camel Case in file sd.h

 drivers/staging/rts5208/ms.c | 86 ++++++++++++++++++------------------
 drivers/staging/rts5208/ms.h | 70 ++++++++++++++---------------
 drivers/staging/rts5208/sd.h |  2 +-
 drivers/staging/rts5208/xd.c |  8 ++--
 drivers/staging/rts5208/xd.h |  6 +--
 5 files changed, 86 insertions(+), 86 deletions(-)

-- 
2.20.1

