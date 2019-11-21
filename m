Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC969C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D1820855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qIGvJTxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKUIPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:15:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40215 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKUIPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:15:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id q15so3185567wrw.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 00:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1C1QmRBY5rUzr8610O1JPTW5yINhKV4J9GK9i0/L/pM=;
        b=qIGvJTxTXDmbwIyDtlqIYYAUXIaYtGdTJGR7lqgnG+xb8D3OIIyXfIcKdYl74G6n1V
         6AIH/lJeNSVwczClPC49lgFaJqVZ0/r65Z7PNX1A3vOtgmoUBYb1zaecNbeEWdUfW0xx
         dH5a3QAg/Nq1/hqOvmMlLWj3Jt0oUX3+yMRr6O/ApH7azB2wkbGOdeDT5tk8xisFc37d
         OHPVDlHHnFFapo/g4fkgHh8hnkBeMXY44RksbqPzFmAWk0GNHtrN3LEHqk3oyL1TIxXo
         aSwoLS+o0Ltg8uyiqc3iFKIcrqF0VubpE5vU8fQao1QuzOpmVekeae0wxhhSLQV5npoQ
         EtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1C1QmRBY5rUzr8610O1JPTW5yINhKV4J9GK9i0/L/pM=;
        b=W3k8wWJFzlRJxgFfI56aGiPZZZ1+WfNhvpyuar3VikM9Xy4EXgErozI6Qv1fYKW3/m
         pwPWUR/n8FRicr3Lrfq7uF8CSUjuHT46Vpwrzgq5m3vQ3lY+unPeKzoHxSg+vffIbO7B
         UnvAlzVUay8hDCkrHLWbUAsb8+ptdo+8hzlm3aD3yygiE+89K7et68WlP/XidSPZ4RX0
         O5I4fF0/30ZVxog97l2DWVBQNDBcLQk9V++2hS06GuC88tSmMYCKRfMWrb5K/IMCIEDZ
         jdXyIvck4aV/1bnr0j1OWuUm5qPLh3+Y+ogh0pQjK2YI0YsOrp5cOadWlJDm/GNY6lu0
         lP7A==
X-Gm-Message-State: APjAAAUWWIJSlFSmr9HzkRmeNmkK9Wg/6NhXIxXjqqVt6Ii5RTqX8R7k
        qq3gRdjsyM4d9ffEA6fT5yyrxQ==
X-Google-Smtp-Source: APXvYqztb8qVXOxAbIRwJqdhDfpu1ArT0UyVuERd3YmJJq8AVG/TvHC6mWHqdly95ZzHd3gTlu9/lA==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr8741914wrv.164.1574324103362;
        Thu, 21 Nov 2019 00:15:03 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id w13sm2315075wrm.8.2019.11.21.00.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Nov 2019 00:15:02 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     airlied@redhat.com, airlied@linux.ie, arnd@arndb.de,
        fenghua.yu@intel.com, gregkh@linuxfoundation.org,
        tony.luck@intel.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/5] agp: minor fixes
Date:   Thu, 21 Nov 2019 08:14:40 +0000
Message-Id: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patch serie fixes some minor problem found in the agp subsystem
There are no change since v1 (posted two years ago)
This is simply a repost for trying to get an answer (gentle ping 6 month
ago got no answer also).

Regards

Corentin Labbe (5):
  agp: remove unused variable size in agp_generic_create_gatt_table
  agp: move AGPGART_MINOR to include/linux/miscdevice.h
  agp: remove unused variable num_segments
  agp: Add bridge parameter documentation
  ia64: agp: Replace empty define with do while

 arch/ia64/include/asm/agp.h |  4 ++--
 drivers/char/agp/frontend.c |  3 +--
 drivers/char/agp/generic.c  | 12 +++++-------
 include/linux/agpgart.h     |  2 --
 include/linux/miscdevice.h  |  1 +
 5 files changed, 9 insertions(+), 13 deletions(-)

-- 
2.23.0

