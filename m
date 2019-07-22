Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D107C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3452D21BE6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EM1IgF0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfGVWdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:33:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43077 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfGVWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:33:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so18054977pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OiNiLucFHzcy62Q/uV7Rl20nKJBchzgLzRjk8lPRvTI=;
        b=EM1IgF0DVayCa3ZHqu5MQDHFJSfM22gDk5jlUi2ZxHVKw4BV+5cVEkxIY1MV8UfbfF
         3rOaf+MSnOe8YwY66/Uptf55irntWYTmMTcnr0/ZptEkCnX6Gesp19VgY45q++QW2LbI
         6yDY21e3Pb8fFwKbQEVg44xtGV5fQyPv6X3Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OiNiLucFHzcy62Q/uV7Rl20nKJBchzgLzRjk8lPRvTI=;
        b=NEC4F4kC7GnymlMIxUFn5pLN6UZHCaLjFwHFBY9VeOic0IVPdubweirhO5kYxmTHID
         HVn+DKM//BS3+TShT2hH4g4rp1URy2XYbmHjEyVGtjjWg3czobZoJV45+MotCzqD76F/
         oUTHpoSsdvW00U41ZoMiE51gcJVvcKzj5vX0/7YmzsrHUBzt7+fgkrPhzY20o+hwdwqh
         TLykUxsfkVxxEc3sbaa6c5AY3LJToIcxj20J9Cx+IWm1ouLyxC5j+nWXL0wVGreOKpiQ
         kYtZCEYKOM29m+bZZbl13vWFmvpzYKk9CROLi+LZ5c0amdxAlGKuwQBe0QqPfZLdymDS
         drEA==
X-Gm-Message-State: APjAAAWiVlAGEKdLUhLb8V05LI1o3SgfJv8xYXox6cjhHFdPfLNQmKJD
        y9RohUnaMCA5FiYpprNPm8tJYg==
X-Google-Smtp-Source: APXvYqyVI6/r2/2vccLiPS9z4xcidbOTHjITUeNO/JzPjKOnDzA7LRMstmsIGWAscqES/rL2AkAPiQ==
X-Received: by 2002:a17:90a:cb8e:: with SMTP id a14mr30424267pju.124.1563834820452;
        Mon, 22 Jul 2019 15:33:40 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id k186sm20614285pga.68.2019.07.22.15.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 15:33:39 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        ravisadineni@chromium.org, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: [PATCH 0/2] power: Refactor device level sysfs.
Date:   Mon, 22 Jul 2019 15:33:35 -0700
Message-Id: <20190722223337.36199-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722182451.GB24412@kroah.com>
References: <20190722182451.GB24412@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wakeup_abort_count and wakeup_count attributes print the
same (wakeup_count) variable. Thus this patchset removes the
duplicate wakeup_abort_count sysfs attribute. This patchset also
exposes event_count as a sysfs attribute.

Ravi Chandra Sadineni (2):
  power: sysfs: Remove wakeup_abort_count attribute.
  power:sysfs: Expose device wakeup_event_count.

 Documentation/ABI/testing/sysfs-devices-power | 36 +++++++++----------
 drivers/base/power/sysfs.c                    | 27 +++++++-------
 2 files changed, 33 insertions(+), 30 deletions(-)

-- 
2.20.1

