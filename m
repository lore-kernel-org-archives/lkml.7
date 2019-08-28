Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3005C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9502E214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfH1Aq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfH1Aq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 20:46:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59982308A9E2;
        Wed, 28 Aug 2019 00:46:26 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-118-116.phx2.redhat.com [10.3.118.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECAF660923;
        Wed, 28 Aug 2019 00:46:25 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 0/2 v2] tpm: add update_durations class op to allow override of chip supplied values
Date:   Tue, 27 Aug 2019 17:46:19 -0700
Message-Id: <20190828004621.29050-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 28 Aug 2019 00:46:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've run into a case where a customer has an STM TPM 1.2 chip
(version 1.2.8.28) that is getting into an inconsistent state and
they end up getting tpm transmit errors.  In really old tpm code this
wasn't seen because the code that grabbed the duration values from the
chip could fail silently, and would proceed to just use default values
and move forward. More recent code though successfully gets the
duration values from the chip, and using those values this particular
chip version gets into the state seen by the customer.

The idea with this patchset is to provide a facility like the
update_timeouts operation to allow the override of chip supplied
values.

I went back and looked at the original submission thread, and updated
Alexey's patches based on Jarkko's suggestions for v2.


