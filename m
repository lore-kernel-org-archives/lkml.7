Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A517EC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B674206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+w1B0DS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfFTJWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:22:18 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:38789 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTJWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:22:17 -0400
Received: by mail-wr1-f51.google.com with SMTP id d18so2245860wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7roUMD7abk4YKBQkXRtR04+JSuUPQBY+olY+0yGdQfM=;
        b=L+w1B0DSg8tEvoCtv9utdSTW0L9QYany7rLOnj7rafijltiq+0ha//4DL7la8BYQXK
         oJ3sDaudCdhjbyWDGfq/tU6x5RZk45ZfW/TOw361hHCvQPxXQ5QambVVzlpwyqK6csSK
         12Gzbn01MsAQ99tDs4nPOBABXd4QC6HU3b0Fi1Qj6NhBYrTcZ9LDv1BklMOePrktRC1Y
         eh78ix4Eu0AW83eWrUUDiJdhVnf/wsqGNjWYrOPNfNlIIlXjeAeCau5uzl6ctX21nn4C
         Fu2dzmcCAQRvI3luIMmAnlKlI63Mjmc6fFb5+lfQPouNMR3sc7XxM7Gxd3qe6toE4woq
         sK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7roUMD7abk4YKBQkXRtR04+JSuUPQBY+olY+0yGdQfM=;
        b=LLMmIrsznZFz01bFNPiLBJyqOkyMWwxpej4nVeCW0q/yCySVwUG4K/zSn19XhF/iCI
         eWTjtEuDvURcPLCxMYQMJ8I3ss5D0h405WIZhNbncB7y7VA+MCAQXHVnwadVg5kFsk9r
         e7gXC4snhMrWyCuMS35IYYS3t1aEUacVGOtB5UhPJ3pfQ33ESuXIUf7fX3YGM2xpqBCs
         rdwgaM+gUd5FhQ+u+3/eRh0E2X5IpVPWqkTIQuqX4KWuCe9ONx2sa8zVBFcSzymt6e/u
         +o7AF94thqdVS7z8C7AdgP8LyKhB4ZdqPwqDpQEUHOnA0rUx6vxMsQniPd6kv6fEuamB
         QY1A==
X-Gm-Message-State: APjAAAXtC4fkn6GNmp4JfHKU/Ocw6arJS6hrX+Hzgk60KajkHsXIn8fQ
        KwMSQ3DzLqJ733BHl1bU3AWjABBwLp0=
X-Google-Smtp-Source: APXvYqwqGrx1QvQ0o3UUT0psU8zxz3cj/OF2EuHOyUaZ8ifQF3OMa8Qspz2dOZe1yl1nUGmUmc3/Rw==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr26985123wrt.84.1561022535680;
        Thu, 20 Jun 2019 02:22:15 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id p3sm19984657wrd.47.2019.06.20.02.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 02:22:15 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:22:13 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.2-rc6
Message-ID: <20190620092213.GA16781@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is a pull request containing fixes to be merged to 5.2-rc6.

It contains a single minor bug fix. See the tag comment for more details.

Thanks,
Oded

The following changes since commit 6ad805b82dc5fc0ffd2de1d1f0de47214a050278:

  doc: fix documentation about UIO_MEM_LOGICAL using (2019-06-19 19:31:21 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-06-20

for you to fetch changes up to f99bc332c713b7672bad5236060b02f0c41c7242:

  habanalabs: use u64_to_user_ptr() for reading user pointers (2019-06-20 12:13:19 +0300)

----------------------------------------------------------------
This tag contains the following fix:

- Casting warning of a 64-bit integer in 32-bit architecture. Use the
  macro that was defined for this purpose.

----------------------------------------------------------------
Arnd Bergmann (1):
      habanalabs: use u64_to_user_ptr() for reading user pointers

 drivers/misc/habanalabs/habanalabs_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
