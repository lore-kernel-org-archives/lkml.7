Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251E3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF75C23404
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfH2UuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:50:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfH2UuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:50:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00D9430872CA;
        Thu, 29 Aug 2019 20:50:17 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-163.phx2.redhat.com [10.3.116.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5B8060BF7;
        Thu, 29 Aug 2019 20:50:16 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 0/3 v3] tpm: add update_durations class op to allow override of chip supplied values
Date:   Thu, 29 Aug 2019 13:49:44 -0700
Message-Id: <20190829204947.2591-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 29 Aug 2019 20:50:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've run into a case where a customer has an STM TPM 1.2 chip
(version 1.2.8.28), that is getting into an inconsistent state and
they end up getting tpm transmit errors.  In really old tpm code this
wasn't seen because the code that grabbed the duration values from the
chip could fail silently, and would proceed to just use default values
and move forward. More recent code though successfully gets the
duration values from the chip, and using those values this particular
chip version gets into the state seen by the customer.

The idea with this patchset is to provide a facility like the
update_timeouts operation to allow the override of chip supplied
values.

v3: Rework update_durations to make use of new version structs
    and pull tpm1_getcap calls out of loop.
v2: Update Alexey's v1 submission with suggestions made by Jarkko



