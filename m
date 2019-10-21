Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BD7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CC320659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izNS4AyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfJUOVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:21:14 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:52730 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUOVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:21:13 -0400
Received: by mail-ua1-f74.google.com with SMTP id w5so1694909uan.19
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RSPzO7VGyWVFZTDHTLbd7vQlQ7kvJGvHy26uTtoxePU=;
        b=izNS4AyOIEJSHE4NorVSgTeYmiLlikycWS0QlQ80XEAbgPCVg3V3G3NyygtgwH1e6x
         eOjr8Qqg6CNFTHRQWkOeKiNwcxWVQxGdP0GlkJRy+MwBlLtYa+qdKo+6T1LjXdLyFPns
         mzHqRVRUczACtoHFQtHYMmUFG9a1uOtQt3ETeqAoQEk/WElFjhnsuv9oE/w+l8puWI9p
         ejOO9cRPqUou/THadN/z/kJ6AFyVqA/QppiwQ1Z53HQJsY1eji2jQJl1QIfFMheqgcTS
         7JyDE2X+liFLwzSmMGPptPnABQ4rDsGDgHdSVRSD1lTXfvJ87Z93X1PkGwT5CPcqIuxp
         D7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RSPzO7VGyWVFZTDHTLbd7vQlQ7kvJGvHy26uTtoxePU=;
        b=TFKdisR6ccb9Bhb37xHbFfuP+SXbP6U2d7Dmg7PCDrvnyYXAa4m3i8qwZoe+J9v8d/
         7llrbe/OmgT1WxsIn5/psCQQBxW9Wa+2bg2i3nHvkKfCQMf4c93jkU6LcKlYGPaN+XKR
         KAO3pt7muy0FFKiFNuLwxmTwI8B+06/R4Htk0K5mLYlNoZQ2zMD7fG3MYsvBVgIK/+U7
         8CbZhLfe9Lz3/urULuINsVxYh1nHtceD6MrxYKdcMnrCHJSAVZTV+R7MnsJvi2aHc5RQ
         ffGVSDvZLqAjb9uDymnDhaZVp1/slNEcd7LGkewizwJLfH5fCjbcyXhXcjQ533zD1BDN
         ft1Q==
X-Gm-Message-State: APjAAAWYyv0V4oIgbmzz0M/+tKAkf8AlGNhCKXxofiN2JT81m0Z6CvMp
        7riioiZa78dXnkTYEL00rMQnqcq3JMeMHPPC
X-Google-Smtp-Source: APXvYqxjnFzSC7W/dFXdHUgixxaKnlTaYyJauPRN10M9bBo/RXxlP/49gc4zLIh2cMZyMj76MvP3vxhqrZg2gDU+
X-Received: by 2002:a9f:3d82:: with SMTP id c2mr13083240uai.1.1571667670792;
 Mon, 21 Oct 2019 07:21:10 -0700 (PDT)
Date:   Mon, 21 Oct 2019 16:20:57 +0200
Message-Id: <cover.1571667489.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 0/2] USB: dummy-hcd: some updates
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Jacky . Cao @ sony . com" <Jacky.Cao@sony.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- Added missing Signed-off-by.
- Added better explanation as to why we need more Dummy devices.

Andrey Konovalov (2):
  USB: dummy-hcd: increase max number of devices to 32
  USB: dummy-hcd: use usb_urb_dir_in instead of usb_pipein

 drivers/usb/gadget/udc/dummy_hcd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.23.0.866.gb869b98d4c-goog

