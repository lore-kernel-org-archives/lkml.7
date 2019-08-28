Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A4FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF76020679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfH1R5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:57:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfH1R5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:57:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 580EE3082E24;
        Wed, 28 Aug 2019 17:57:44 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CED2E5D9E2;
        Wed, 28 Aug 2019 17:57:43 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] libnvdimm/security: Enumerate the frozen state and other cleanups
References: <156686728950.184120.5188743631586996901.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 28 Aug 2019 13:57:43 -0400
In-Reply-To: <156686728950.184120.5188743631586996901.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Mon, 26 Aug 2019 17:54:49 -0700")
Message-ID: <x4936hl8960.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 28 Aug 2019 17:57:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Changes since v1 [1]:
> - Cleanup patch1, simplify flags return in the overwrite case and
>   consolidate frozen-state cases (Jeff)
> - Clarify the motivation for patch2 (Jeff)
> - Collect Dave's Reviewed-by

The series tests out fine for me.

Thanks, Dan!

-Jeff


>
> [1]: https://lists.01.org/pipermail/linux-nvdimm/2019-August/023133.html
>
> ---
>
> Jeff reported a scenario where ndctl was failing to unlock DIMMs [2].
> Through the course of debug it was discovered that the security
> interface on the DIMMs was in the 'frozen' state disallowing unlock, or
> any security operation.  Unfortunately the kernel only showed that the
> DIMMs were 'locked', not 'locked' and 'frozen'.
>
> Introduce a new sysfs 'frozen' attribute so that ndctl can reflect the
> "security-operations-allowed" state independently of the lock status.
> Then, followup with cleanups related to replacing a security-state-enum
> with a set of flags.
>  
> [2]: https://lists.01.org/pipermail/linux-nvdimm/2019-August/022856.html
>
> ---
>
> Dan Williams (3):
>       libnvdimm/security: Introduce a 'frozen' attribute
>       libnvdimm/security: Tighten scope of nvdimm->busy vs security operations
>       libnvdimm/security: Consolidate 'security' operations
>
>
>  drivers/acpi/nfit/intel.c        |   59 ++++++-----
>  drivers/nvdimm/bus.c             |    2 
>  drivers/nvdimm/dimm_devs.c       |  134 ++++++--------------------
>  drivers/nvdimm/nd-core.h         |   51 ++++------
>  drivers/nvdimm/security.c        |  199 +++++++++++++++++++++++++-------------
>  include/linux/libnvdimm.h        |    9 +-
>  tools/testing/nvdimm/dimm_devs.c |   19 +---
>  7 files changed, 226 insertions(+), 247 deletions(-)
