Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6E2CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8595120856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfJaBcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:32:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49440 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfJaBcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:32:47 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 35C5114EBC34B;
        Wed, 30 Oct 2019 18:32:46 -0700 (PDT)
Date:   Wed, 30 Oct 2019 18:32:45 -0700 (PDT)
Message-Id: <20191030.183245.140124535901906874.davem@davemloft.net>
To:     sheetal.tigadoli@broadcom.com
Cc:     zajec5@gmail.com, gregkh@linuxfoundation.org,
        michal.simek@xilinx.com, rajan.vaja@xilinx.com,
        scott.branden@broadcom.com, ray.jui@broadcom.com,
        vikram.prakash@broadcom.com, jens.wiklander@linaro.org,
        michael.chan@broadcom.com, vikas.gupta@broadcom.com,
        vasundhara-v.volam@broadcom.com, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next V4 0/3] Add OP-TEE based bnxt f/w manager
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1572450864-16761-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1572450864-16761-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 30 Oct 2019 18:32:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Date: Wed, 30 Oct 2019 21:24:21 +0530

> This patch series adds support for TEE based BNXT firmware
> management module and the driver changes to invoke OP-TEE
> APIs to fastboot firmware and to collect crash dump.
 ...

Please start build testing properly:

ld: drivers/firmware/broadcom/tee_bnxt_fw.o: in function `tee_bnxt_fw_load':
(.text+0x1ca): undefined reference to `tee_client_invoke_func'
ld: drivers/firmware/broadcom/tee_bnxt_fw.o: in function `tee_bnxt_copy_coredump':
(.text+0x376): undefined reference to `tee_client_invoke_func'
ld: (.text+0x3c0): undefined reference to `tee_shm_get_va'
ld: drivers/firmware/broadcom/tee_bnxt_fw.o: in function `tee_bnxt_fw_remove':
tee_bnxt_fw.c:(.text+0x482): undefined reference to `tee_shm_free'
ld: tee_bnxt_fw.c:(.text+0x494): undefined reference to `tee_client_close_session'
ld: tee_bnxt_fw.c:(.text+0x4a0): undefined reference to `tee_client_close_context'
ld: drivers/firmware/broadcom/tee_bnxt_fw.o: in function `tee_bnxt_fw_probe':
tee_bnxt_fw.c:(.text+0x548): undefined reference to `tee_client_open_context'
ld: tee_bnxt_fw.c:(.text+0x5b2): undefined reference to `tee_client_open_session'
ld: tee_bnxt_fw.c:(.text+0x610): undefined reference to `tee_shm_alloc'
ld: tee_bnxt_fw.c:(.text+0x695): undefined reference to `tee_client_close_context'
ld: tee_bnxt_fw.c:(.text+0x6ba): undefined reference to `tee_client_close_session'
ld: tee_bnxt_fw.c:(.text+0x6cb): undefined reference to `tee_client_close_context'
ld: drivers/firmware/broadcom/tee_bnxt_fw.o:(.data+0x10): undefined reference to `tee_bus_type'
make: *** [Makefile:1074: vmlinux] Error 1
