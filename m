Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47179C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B301218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553906276;
	bh=w0MXSHIIOp/sEWTJm3sZvxdCtSk0IAXpancafSMGv2k=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=f3/lkG4Ug/EOzBNNWTP0WZJARI3WnZO5O/EgTVvztaSeQJ00/owrA9+5d+ZiegP2F
	 Bj4cvNUfV0BR8CcRhdhy6zFZ1Epc0N6JmR1zLyuqvZs5fBWDUKrpD2JSyTnOxWeDyq
	 ZMrnY36TWOqeTuaDe7uYoMWxtkcBhXrsM1bX2Bcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfC3Ahz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:37:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43908 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfC3Ahy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:37:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id t81so3063710oig.10;
        Fri, 29 Mar 2019 17:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=98LOeh/8Wrr5Qg9++1m/ARqgTfFYVOYsO3yJwClgxK4=;
        b=uZL4vpRWvA2Gwbi4TBSq8FMxet9nO1F6e8+Zt1WlVmX7lnaS+0/51hHpqQqG4SBXAr
         RDf0bPlJpGO3h7sMCGtF7RK1yW4SYWpYniX0w04EVD+0lGM7pZY4JrpOeax95CM4y83y
         uUIgBWA9HXSEqtbJ/MFjTJfz7g7Hr3FUklN4KwadrPtjk9H9a0PfdW3VtgOdCoSQHh7S
         CDC6+woB93G4jDxGOv1K3hvQIqXLDsE6GwzI5Ns9CtWDniF8lIFD68ktgwlypOZh6bcP
         CRdydQUFA360XNEu70EJmoKkGor80Y/+92GoK2PEBJsoluBG5Sn7ZECcthS7fT2AhTOJ
         /IVg==
X-Gm-Message-State: APjAAAXvWwPnWHlIz2M/qH0zUAb4J/UhhVszIJSKgT5zfK6y0cViX1/X
        ztb+9+azxKene7Qwy6V5k0lsNELVvSI9tx2oLK3A4l8B
X-Google-Smtp-Source: APXvYqwBLOg1c1/MSaSW5rqzLhUtHq7A1kXXdpx2F1t044eZEDa88bl0bHOEesnFhLlS3OnzkzHqMMYOnKiwVQmkyUM=
X-Received: by 2002:aca:355:: with SMTP id 82mr5731637oid.30.1553906273854;
 Fri, 29 Mar 2019 17:37:53 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 30 Mar 2019 01:37:43 +0100
Message-ID: <CAJZ5v0jUqQz3hY6JONcWfuLG8Bnn9vtZQcWWPnyE=PYOpVXRJQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.1-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.1-rc3

with top-most commit 31d4c528cea4023cf36f6148c03bb960cedefeef

 cpufreq: scpi: Fix use after free

on top of commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00

 Linux 5.1-rc2

to receive power management fixes for 5.1-rc3.

These fix CPU base frequency reporting in the intel_pstate
driver and a use-after-free in the scpi-cpufreq driver.

Specifics:

 - Fix the ACPI CPPC library to actually follow the specification
   when decoding the guaranteed performance register information and
   make the intel_pstate driver fall back to the nominal frequency
   when reporting the base frequency if the guaranteed performance
   register information is not there (Srinivas Pandruvada).

 - Fix use-after-free in the exit callback of scpi-cpufreq left after
   an update during the 5.0 development cycle (Vincent Stehlé).

Thanks!


---------------

Srinivas Pandruvada (2):
      ACPI / CPPC: Fix guaranteed performance handling
      cpufreq: intel_pstate: Also use CPPC nominal_perf for base_frequency

Vincent Stehlé (1):
      cpufreq: scpi: Fix use after free

---------------

 drivers/acpi/cppc_acpi.c       | 9 +++++++--
 drivers/cpufreq/intel_pstate.c | 5 ++++-
 drivers/cpufreq/scpi-cpufreq.c | 2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)
