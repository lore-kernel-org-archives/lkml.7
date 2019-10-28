Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2BDCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A889B218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572276820;
	bh=HCH5SG07gy1Bkd7WHbuVHtl1aDQOVbZEaYbZQJM3fso=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TWXrnzUD+eDUT3b3Jec/PkJTdj8UgHnzmfY7KnG9Vf/u/0tB6lbUkYi9XJXtF1xDt
	 YMkugtpEetUT5qM8r4ueEIV7uI+gAnMjUbkrrrrqSKOAxEPcUEx6Jcq9wozuP3NPX7
	 e6d3WasggAU6AFyXk2V3sHp7D6y+Cd0huqZipwec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfJ1Pdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfJ1Pdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:33:39 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DD1208C0;
        Mon, 28 Oct 2019 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572276818;
        bh=HCH5SG07gy1Bkd7WHbuVHtl1aDQOVbZEaYbZQJM3fso=;
        h=Date:From:To:Cc:Subject:From;
        b=ab5hJ64oHd3rQ4K+MauhZAa3qusPIRI7wObXCkb77LCy9zt5Wq/VgLpSBZrR9Vc+q
         G+T6JnWdZoGM5QJb2fBrpfkHxaBJFFFAbn4Niyp8gM6i8fDH3ANNnRWjktrGomaEfT
         vyqKZesV+gb4/g15cXYAlA9pkyKmiMQ3H92lG/qE=
Date:   Mon, 28 Oct 2019 16:33:34 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org
Subject: `make nsdeps` prints "Building modules, stage 2" twice
Message-ID: <20191028153334.GA25863@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When running `make nsdeps`, I've noticed that "Building modules, stage
2" gets printed twice. Not a big deal, but a bit strange to see,
especially since the second print is actually from the nsdeps target
calling modpost again.

$ make nsdeps O=/dev/shm/linux
make[1]: Entering directory '/dev/shm/linux'
  GEN     Makefile
  DESCEND  objtool
  CALL    /tmp/ppyu/linux/scripts/atomic/check-atomics.sh
  CALL    /tmp/ppyu/linux/scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  Building modules, stage 2.
  MODPOST 3316 modules
  Building modules, stage 2.
  MODPOST 3316 modules
Adding namespace USB_STORAGE to module uas (if needed).
Adding namespace USB_STORAGE to module ums-alauda (if needed).
Adding namespace USB_STORAGE to module ums-cypress (if needed).
Adding namespace USB_STORAGE to module ums-datafab (if needed).
....etc...

It's due to calling the __modpost target twice, once for modules and
once for nsdeps. I guess we could have the nsdeps target just call
cmd_modpost, but then we still have the MODPOST XXXX modules line
printing twice. Is there a nicer way to fix this? Again, it's not
harmful, but probably confusing for people to see.

Thanks,

Jessica
