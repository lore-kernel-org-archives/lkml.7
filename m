Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33F9C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6EA21670
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfIBO1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:27:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731482AbfIBO1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:27:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D111985546;
        Mon,  2 Sep 2019 14:27:48 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-156.phx2.redhat.com [10.3.116.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51B0760C05;
        Mon,  2 Sep 2019 14:27:48 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v4 0/4] tpm: add update_durations class op to allow override of chip supplied values
Date:   Mon,  2 Sep 2019 07:27:32 -0700
Message-Id: <20190902142735.6280-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 02 Sep 2019 14:27:48 +0000 (UTC)
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

changes from v3:
    * Assign value to version when tpm1_getcap is successful for TPM 1.1 device
      not when it fails.

changes from v2:
    * Added patch 1/3
    * Rework tpm_tis_update_durations to make use of new version structs
      and pull tpm1_getcap calls out of loop.

changes from v1:
    * Remove unneeded newline
    * Formatting cleanups
    * Change tpm_tis_update_durations to be a void function, and
      use chip->duration_adjusted to track whether adjustment was
      made.

Jarkko Sakkinen (1):
      tpm: Remove duplicate code from caps_show() in tpm-sysfs.c

Jerry Snitselaar (2):
      tpm: provide a way to override the chip returned durations
      tpm_tis: override durations for STM tpm with firmware 1.2.8.28


