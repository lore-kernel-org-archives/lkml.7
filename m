Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449BBC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1303E21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jrdCSWCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgABUBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:01:08 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:40746 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgABUBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:01:07 -0500
Received: by mail-pg1-f201.google.com with SMTP id 4so5696497pgn.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ARkancjaecOwC52/MajrESx5s7dn0KQR9/fZNXj0j2I=;
        b=jrdCSWCAWMNVE2OQRwzwzBb1NiikjCcGyKsZU4lGK8svAU5cjJtAnQm3RXt8DwKFA+
         nZjBozmagfuOFOd8DsEZblCmgYF/slGhlRx1y5enDV/Aj+OrY6EnpfE5TLV3FGG06OFu
         SEV4OaQ5/7qf7WY9DM54QE2UmsROV20rR8RkMB0baMbTTASt4RwkLLYUROZLDcp8btNz
         6jE9zXUHkCMDIVevDesxEAQpynYI0gPQJiO11noUpmkgTxMZWVGoa4jg21m+LLLnhp3o
         QonYYmEdmtnP0kWU5u4HLmXw3JdRkABeARDXTkw2pgddhljcHtkw8UVTswcNQBRCbUIg
         9cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ARkancjaecOwC52/MajrESx5s7dn0KQR9/fZNXj0j2I=;
        b=NhMokTzt5NmeiaqMXsoHmTDtplcUuUwtPrxjwWkqfIOLhnZKPeVUJH+E3EK0VBgywJ
         qxh2EnQ4+gLoO/dDZw2/F7rhmVgkpV1p9atasLTPGnatgQnoY9Vi/4SpGMrhtGDNCBck
         flJxZ15z97FtY9PB2XETe/7T87bMGt9CZa7oMNnsON8W86KpETDsmcPZcC/nUrmvWX6o
         icAfRSkgFCkl6FhiC2E5pTnpx3RqXm1z9YHuifnF5UgE9vu7hBfwubCZ9qUHkLSFERes
         3riXGIHNQrbdw9/uLwFDg716SxFzMztyjFUsgKHkM0ryV6hBCnMowSyrQe0QJpPQcwut
         +3Kg==
X-Gm-Message-State: APjAAAUWXNC3cxXh/hvsrFBYOMaRbwE83QMhDfZk8BE9ydmSd5olj6OU
        c5R5vUCOQ33URfydODHZf7MwQWSa/G4+4+w=
X-Google-Smtp-Source: APXvYqyIxOm6ba5eyO4OWWh7SR/elLe8fAPwip68Y6Gqul2zz00OiLehK8VMD0eVg5mjR5fHaBBJL46CoXBT64w=
X-Received: by 2002:a63:6507:: with SMTP id z7mr93919801pgb.322.1577995265520;
 Thu, 02 Jan 2020 12:01:05 -0800 (PST)
Date:   Thu,  2 Jan 2020 12:00:50 -0800
Message-Id: <20200102200052.51182-1-semenzato@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 0/2] clarify limitations of hibernation
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rafael@kernel.org, gpike@google.com,
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

 Documentation/admin-guide/pm/sleep-states.rst | 12 +++++++++++-
 kernel/power/snapshot.c                       | 18 ++++++++++++------
 2 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

