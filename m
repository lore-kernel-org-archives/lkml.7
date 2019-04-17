Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3B5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D053820656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePJUnrF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbfDQPq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:46:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39951 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732760AbfDQPq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:46:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id f196so9684107oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=GkD8TGMSDO771JilbQAsbY1/4frPE8JDPDfFUA9SvuM=;
        b=ePJUnrF6LXWF9X3I+3JERi7R+lXu04WHUPfO9w3ViZT+8Do9xHrErLRZj8b0gIKkmi
         RTzlq3AiDPBHdSc5qjp+HI03wccfotYyOHsAONKOL4pUUD+ubv3zI+AnAXSRMtYRB2Lo
         6h+pMybrv7mLzdivwLKEtPQPWuPjBHWB2SoJFGyqIkJQquzF1ZCyZeoIMhf58btlOdnd
         xsNxrB60E53FKGWQe63XPE/Z1iuX6x2IwMNp2BYXJv92E+N8FpL/bnjBYbyqsUhBywHy
         A3nDEtIGVoMfAOA158NuPFGC/ozYu/Wxm3uwX68yz28chsll14HrHT2bmJ7iR2/fH4K6
         66iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=GkD8TGMSDO771JilbQAsbY1/4frPE8JDPDfFUA9SvuM=;
        b=Jrh9+rs21oNhGVEeaT7oLIQT9nYLh3Tv/SMvU2JkqqR+clSWpL+KuM1ZK9fV9qUqfO
         YnA3TiRvj08WZDxJGoW30u8HeEWUUmNfhUTDnq+Q5WUd4PWDw/mhDnHqmUVkjES5RsW8
         4uUkUC+mJUUOEPby8ngi58Cz9r70xYoX7u3wtlD+q+E4yBxgmSRSbiO/JObTUknz9aIO
         cCJy7d/wiCiw2O6Bs0nRdCQ78fh9OxreXzwaevnf+DzDlFJDoN6DShYMxMVwi56eOY4p
         lPa1UDl04FvwycA5SRxXjy7jCbUaU3KEWq/Od45VFaZX29tq7+rsi/De3sJFbFfY/RG5
         DThg==
X-Gm-Message-State: APjAAAX15GEqyQr6fekpY8CvSGa9t6YFc2OwAg/oEd7jVct8JRYyf0Ju
        pdbKwVKsTWxgIY8etkMzgu0t+bk=
X-Google-Smtp-Source: APXvYqwqlcV0Tl/XYrVIePDPiUd0k6vKvNuhf8JsecPXSI56Mgc/HwBqKu9TorS7BKFzGECtn+H5GA==
X-Received: by 2002:aca:564e:: with SMTP id k75mr28405892oib.54.1555516017040;
        Wed, 17 Apr 2019 08:46:57 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id k25sm22802556otj.72.2019.04.17.08.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 08:46:56 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id E926018003A;
        Wed, 17 Apr 2019 15:46:55 +0000 (UTC)
Date:   Wed, 17 Apr 2019 10:46:54 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI serious bugfixes for 5.1
Message-ID: <20190417154654.GL4121@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 444fe991353987c1c9bc5ab1f903d01f1b4ad415:

  Merge tag 'riscv-for-linus-5.1-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux (2019-04-16 10:46:37 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.1-2

for you to fetch changes up to 3b9a907223d7f6b9d1dadea29436842ae9bcd76d:

  ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier (2019-04-17 10:29:27 -0500)

----------------------------------------------------------------
Fixes for some bugs cause by recent changes.  One crash if you
feed bad data to the module parameters, one BUG that sometimes
occurs when a user closes the connection, and one bug that
cause the driver to not work if the configuration information
only comes in from SMBIOS.

----------------------------------------------------------------
Corey Minyard (2):
      ipmi: Fix failure on SMBIOS specified devices
      ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier

Tony Camuso (1):
      ipmi: ipmi_si_hardcode.c: init si_type array to fix a crash

 drivers/char/ipmi/ipmi_dmi.c         |  1 -
 drivers/char/ipmi/ipmi_msghandler.c  | 19 +++++++++++++++++--
 drivers/char/ipmi/ipmi_si_hardcode.c |  2 ++
 3 files changed, 19 insertions(+), 3 deletions(-)

