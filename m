Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0E2C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37ED20828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2Hpmgaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLZWCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:02:12 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52026 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZWCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:02:12 -0500
Received: by mail-pf1-f201.google.com with SMTP id z19so15633749pfn.18
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 14:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AL5Sd5AW8DECMBdg0nm+i6ZiH1NGT9qPjcoM62Uo1/w=;
        b=e2HpmgawpyOKzHRyN+Mv+hoZq4boiOyKN4TXLvVb7pKD8WyzNq+JdI231mYiYoS/rK
         VVRT5FT3tYbr0u8l9Mtx2iZWLb4SL6dxWqWJWhZA2c0TBEazOuSyJQET3F3VtbCGZ+gb
         5IOmtVVUnI7Qay0rWBxjs+A4Hq+tLImXeXxuPAR+uLNcHlguMfw8FrOVrIpP9mX1Pi3k
         TFdEObZhWqTrXPrx9cq7hfaVZKDXnnK5iuEd/AfNzvKNrR3sQZ5ADFzV8P2D7VY4z3Wc
         9CsfHk9PYm1qNTvc9dvz3vvVuuotTDs9Q9yNFkw0+5h/qYVDe0kp0wgbSHgTMoQQJWKD
         aUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AL5Sd5AW8DECMBdg0nm+i6ZiH1NGT9qPjcoM62Uo1/w=;
        b=HREZvoLCCU0JLmD/24+e964YA485eEis168ap4fKLDgoqNgEYD3nPizMwPhJBBeabN
         bMrAm4UFTiNhlmhYPeUMVI7grT4Itayl8INoJ4MMIf/0ImZ0dhtL3v0uVX2ud4Cn9L/e
         MQFHmofNWSMZENR4dedmv/cpyNwYbovjz7+580YS9qR9BGU7i/ts3uiFTDbq5y10+VwV
         57PqVkLsZy+icPLlqpqZ8xKCXDOk9cxbadj7IV5KaNjiRgjOEkPly/iSjebCXWGQWDGx
         kV9NtpLV6uBNPWOsmOK6l5yAJ7WfWTjmeoB8lttCiJE97BGEolwSTBKZfF47DMXurLjI
         /fgw==
X-Gm-Message-State: APjAAAUgQoH6JdJMdj94HDKDo9X54va5INMO5gN+DcsmJxeESvrcf3gI
        svWZRvm66fg8aMz6u2Y6yDWuvnNLdhMcSuU=
X-Google-Smtp-Source: APXvYqw6rsnA5a3UmJLmTPe/prHDoGfUyxlvQphcBx3yqOsZPIAJE5chDt7Gq03Yq8+HDdl2j+O5F2AS8IjvMQ0=
X-Received: by 2002:a65:680f:: with SMTP id l15mr52620049pgt.307.1577397730398;
 Thu, 26 Dec 2019 14:02:10 -0800 (PST)
Date:   Thu, 26 Dec 2019 14:02:03 -0800
Message-Id: <20191226220205.128664-1-semenzato@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH 0/2] clarify limitations of hibernation
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, akpm@linux-foundation.org, gpike@google.com,
        Luigi Semenzato <semenzato@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches aim to make it clearer under which circumstances
hibernation will function as expected.  They include one documentation
change, and one change which logs more information on failure to
enter hibernation.

Luigi Semenzato (2):
  Documentation: clarify limitations of hibernation
  pm: add more logging on hibernation failure

 Documentation/admin-guide/pm/sleep-states.rst | 18 +++++++++++++++++-
 kernel/power/snapshot.c                       | 18 ++++++++++++------
 2 files changed, 29 insertions(+), 7 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

