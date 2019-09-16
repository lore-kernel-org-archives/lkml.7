Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6650C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BFE214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9PeIcDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391767AbfIPVPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:15:48 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:34316 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfIPVPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:15:48 -0400
Received: by mail-lj1-f169.google.com with SMTP id h2so1368030ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q8AINeoP2DyNF3z+g9XyoW9QGGm+mIahUxPHcgAxYLw=;
        b=s9PeIcDDdtU/XiKoQwyE/khSqsOZtXuta7cQBKYbbBtABJjpIUYNJlhTin9EnX3rEQ
         W5iYnipjykkFCUC5KMSga/UunnojSYagErWrM0dTrOXvM+eNPDH8rBb0HXucZO4Jj2Xn
         ay54+KXwK1XT735UtCMLsOPsZevkX2qyPTZv1n1fccBHP7KFP979ewEm01kp8/k4unOm
         mNxNcNF6XXk2p5Q6M2zfqiVynSuf7L1OCfkUy+r21hDL78x93jsHyd09xkHUrzLqJfWM
         aw/Qgq+6229pa1gwGYasfa5MsEOggPtM6Bgo1dfhH0tFxrSvSOlFlnjRUCT9bPB9d4H3
         g7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q8AINeoP2DyNF3z+g9XyoW9QGGm+mIahUxPHcgAxYLw=;
        b=l7TOwguSQgsdbOVlViwkfKqw/BNtoEm12BzNg6U24LipHNoQafX03yydzBF0HvNi36
         8NExmRFAIHxrniZnclwIAXW3+tZxkkDnisYO+dWd0yOT20C2xVwsECUy0mRPDrDkfTEn
         Zs7f0NyipboZcR9mvTEQRtUKR+LVc8Kgk1NfO17yGG1aom+2nvLOFuw1LGqojQyinDFm
         7jEBviGQgYl4veseF6P8zMDgsMLZg3861yHaTzDMj8fwf0rgSk3damv/NVwqEvTUGypS
         ID7xbkWrBi2b7ZPSjX18zPZEcpg6dj1ENXyNPbeiUfkKJ3ELEbWx8/dozLhHtrh83Yqo
         CIcw==
X-Gm-Message-State: APjAAAWG2HgVMpDoqVUG7LF/wazRM6N9ct06ajy8zMrRkbrSOZtu6A26
        7CcWC61mB/qIe45VXFeS7RgR67v7
X-Google-Smtp-Source: APXvYqykurs08mF1WpZz8IS43zMXg0iE0FcyxcqZ7CM8IShhKBYCHeCLRnkwwQdrhqs2G0Bx1Vhxdw==
X-Received: by 2002:a2e:8997:: with SMTP id c23mr868109lji.208.1568668545639;
        Mon, 16 Sep 2019 14:15:45 -0700 (PDT)
Received: from localhost.localdomain ([46.216.138.44])
        by smtp.gmail.com with ESMTPSA id p27sm9169891lfo.95.2019.09.16.14.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:15:44 -0700 (PDT)
Received: from jek by localhost.localdomain with local (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1i9yLY-0007jk-2B; Tue, 17 Sep 2019 00:15:44 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: extcon-intel-cht-wc: Don't reset USB data connection at probe
Date:   Tue, 17 Sep 2019 00:15:35 +0300
Message-Id: <20190916211536.29646-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to prevent resetting USB connection if OTG device is connected
during of driver initialization.

v2:
Change (id == INTEL_USB_ID_FLOAT) check to (id != INTEL_USB_ID_GND) as
Hans de Goede advised.


