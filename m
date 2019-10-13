Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5E3C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD1B207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfJMLmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 07:42:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728960AbfJMLmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 07:42:05 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24F9485363
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 11:42:04 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id q80so14020928qke.22
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 04:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WhM42HnkXorw8ZktlIqV/yS0IRHKb5HISbW//fiFIIA=;
        b=GWczzz723MUBiLXgU1YxLALE65ka3yogPjxQN9MdWyNpJBTMhtzxFpSUxv8KIcPG1i
         91PnT1ZYLNyLx0xF+V9/MTkdlm8wsbVnv226ZjM5a2hHQsUA7hYed591AX55a0+zMPzt
         xSWp8cKGq0++D1M0rs+sprcOX/bTmly/ctfhTr2UC+KS7WiF1/pNBFYxVLnNw43yiAPs
         bvUhuaR4sXpK/tx6cjrbFXkgrzeDnrrgwIOjdJiJYqD30t3jMm3tZH19oa7WC45RZW4S
         e73dEeZBI0d6HzjSOP8VdgWVSBcXYLIc0q5k7+cMdaj2RXECZzdUKKIfFdUbVPKLUfyH
         AP3Q==
X-Gm-Message-State: APjAAAUkZluz5iNtbe6fCLbuyy4Rof6zX6CYVmMj0ZOfMJMpcTy+7rEU
        lhB5cVDF0fCI7k9T2n/j36rNddFdFgbuaDQ6on8noTTFksOGt0VFqV4EiekvyfhEoXcfUgv7CVV
        Gsg+d2np467j67ZVclV9l73Sl
X-Received: by 2002:a37:a14d:: with SMTP id k74mr25294019qke.308.1570966922927;
        Sun, 13 Oct 2019 04:42:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJbPZHmjjRtZPdn0OIP4+7Md8xReA9OfG4qhSoToCuN8Mn6p7CW5fNAnas5HTHE7lcLL2Caw==
X-Received: by 2002:a37:a14d:: with SMTP id k74mr25293998qke.308.1570966922588;
        Sun, 13 Oct 2019 04:42:02 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id d25sm1763837qtj.84.2019.10.13.04.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 04:42:01 -0700 (PDT)
Date:   Sun, 13 Oct 2019 07:41:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC v4 0/5] vhost: ring format independence
Message-ID: <20191013113940.2863-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds infrastructure required for supporting
multiple ring formats.

The idea is as follows: we convert descriptors to an
independent format first, and process that converting to
iov later.

The point is that we have a tight loop that fetches
descriptors, which is good for cache utilization.
This will also allow all kind of batching tricks -
e.g. it seems possible to keep SMAP disabled while
we are fetching multiple descriptors.

This seems to perform exactly the same as the original
code already based on a microbenchmark.
Lightly tested.
More testing would be very much appreciated.

To use new code:
	echo 1 > /sys/module/vhost_test/parameters/newcode
or
	echo 1 > /sys/module/vhost_net/parameters/newcode

changes from v3:
        - fixed error handling in case of indirect descriptors
        - add BUG_ON to detect buffer overflow in case of bugs
                in response to comment by Jason Wang
        - minor code tweaks

Changes from v2:
	- fixed indirect descriptor batching
                reported by Jason Wang

Changes from v1:
	- typo fixes


Michael S. Tsirkin (5):
  vhost: option to fetch descriptors through an independent struct
  vhost/test: add an option to test new code
  vhost: batching fetches
  vhost/net: add an option to test new code
  vhost: last descriptor must have NEXT clear

 drivers/vhost/net.c   |  32 ++++-
 drivers/vhost/test.c  |  19 ++-
 drivers/vhost/vhost.c | 328 +++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  20 ++-
 4 files changed, 385 insertions(+), 14 deletions(-)

-- 
MST

