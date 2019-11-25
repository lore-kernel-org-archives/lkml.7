Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B86DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B02D2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOECNUjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfKYQ7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:59:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36119 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbfKYQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:59:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id f10so13243680oto.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 08:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=7wb5i6/FZxQaE8n+z8M7xj50uZOfM6qEKwZxz5PmeaU=;
        b=iOECNUjZXp49nZ2MCe9bj60ze2SZ2L6VMgYGHDzN3UqmIv35jp4a/RrIMDAzDIlpey
         DQthatl4TaoPijcV7sPnm/Y0sX87B4U75hyhgDmAk8LvUhDqnqqAexhwjzNtATxJNRek
         Yr4yM/Ow9vsZi6VnlX844VYln/UamgXuoZjLoiGWUxPcHM+b3welYTaKTGvg4DNiRRWn
         vbL1aaKT7YRPqBT9RLv6Lkp+RyvwJFJrQfPKpYzkIVCoQsYR6iQHW8en+9rnDxc0riEj
         8SMGAL3Mtng9qYisg7egnTlugqyO7ccaH8AjpzpXBWanf1Y8uyUSOiptZWyMWirIFMQX
         3W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=7wb5i6/FZxQaE8n+z8M7xj50uZOfM6qEKwZxz5PmeaU=;
        b=kxSy5SAuWbmJ8pInsOekvmTbMB01uM571l15+nEEhzv0XqfVo3KU7ibaDljci7WTt0
         4eVCRspc1aYfDNZL04HB4n127lohrvOYD7dzD8pM7i+78y9TlOlXFH9bWOy0HmRim/8+
         TtEaKhOAo297eeYh1/C+WeGee1GJLk7R6GwT49KH/WO9+ckC8cWeQ+x75VKedFwAlXCY
         ONCV60ooHjj8tvrs7oKPeVLfaESyGvEz+ZjegOnhS4G/95rq5lutChGESETf+sI6DqbC
         /yf1ZAYjWcXnoTnPQAAsPyBKG+C0szje/lYFI63bQYXwvAhKIPlU8tZJdEYkf2Yp/LVm
         1TlA==
X-Gm-Message-State: APjAAAVYepmEnmTuR/QRxUMNpBPavZejZe+7NcJ0zLlFM8xcryZVAQ8D
        KnP17tpAhS0k39jP92D6Jw==
X-Google-Smtp-Source: APXvYqw+Aw8aP1poCHyxvIoa6KKGxP3DMLdI3yVaA0nRtNvja4Z0HzUm5BwKby8xArguyaJ988TmuA==
X-Received: by 2002:a9d:77c5:: with SMTP id w5mr19822955otl.351.1574701187460;
        Mon, 25 Nov 2019 08:59:47 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id f93sm2574226otb.64.2019.11.25.08.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 08:59:46 -0800 (PST)
Received: from minyard.net (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id 32AFA180046;
        Mon, 25 Nov 2019 16:59:46 +0000 (UTC)
Date:   Mon, 25 Nov 2019 10:59:45 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.5
Message-ID: <20191125165945.GC3527@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3b7c59a1950c75f2c0152e5a9cd77675b09233d6:

  Merge tag 'pinctrl-v5.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2019-10-22 06:40:07 -0400)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.5-1

for you to fetch changes up to 8e6a5c833333e14a5023a5dcabb64b7d9e046bc6:

  ipmi: fix ipmb_poll()'s return type (2019-11-22 13:54:55 -0600)

----------------------------------------------------------------
Some small fixes accumulated for IPMI, nothing major.

----------------------------------------------------------------
Andy Shevchenko (1):
      ipmi: use %*ph to print small buffer

Arnd Bergmann (1):
      ipmi: kill off 'timespec' usage again

Corey Minyard (1):
      ipmi: Don't allow device module unload when in use

Luc Van Oostenryck (1):
      ipmi: fix ipmb_poll()'s return type

Navid Emamdoost (1):
      ipmi: Fix memory leak in __ipmi_bmc_register

Vijay Khemka (1):
      drivers: ipmi: Support for both IPMB Req and Resp

YueHaibing (1):
      ipmi: bt-bmc: use devm_platform_ioremap_resource() to simplify code

 drivers/char/ipmi/bt-bmc.c          |  4 +--
 drivers/char/ipmi/ipmb_dev_int.c    | 37 ++++++++-----------------
 drivers/char/ipmi/ipmi_msghandler.c | 55 ++++++++++++++++---------------------
 drivers/char/ipmi/ipmi_si_intf.c    | 40 +++++++++------------------
 include/linux/ipmi_smi.h            | 12 +++++---
 5 files changed, 58 insertions(+), 90 deletions(-)

