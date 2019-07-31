Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AFCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49041206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pC9hx7AH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbfGaPAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:00:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45538 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387639AbfGaPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:00:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so5004868otq.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=Ps9PpaSBIXq7Ne9E/d4KaHrc8XM/iSj4meBqG2KoY1I=;
        b=pC9hx7AHwKxWSDeiwxkq4gwqFcrs1NirWZa0eTpXuOngP+6AhmJ+xX6tzgJ2ujDo40
         8RU6/zZA/xhpEE6KJ8PuKci/KlfYs4yQrK8Mf3ycmM4mHP17fT67y6jCFDYUC31iXTwD
         YbkP2Fa0i9YY379Ot5ZUPwR7iMJReIQ+eK/HQ7X0HjMWV5WSqRFP2YiIo37WfM6vTbU6
         h95msVloAP3Nt/VYZHASJsVIMpd5SBtvq3NTTqaKwuf5kVFlTfYrANyDUjEvFRxocZeO
         1N4uWec5q8nODJTwNuoHnzIhy1QcM70UZM9kauci6W0hYXq4U3sfzsCoo1w28mIUIfB6
         f9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=Ps9PpaSBIXq7Ne9E/d4KaHrc8XM/iSj4meBqG2KoY1I=;
        b=hFRe4TmURGD/ZdidoK/KGFAuGHgXTbD89GMC+id+xXKlJ7NI8LlmP3kdRSnx0IFXRx
         4mN1/GNGVo4Os3cVrDFFBbWEPBTnWkkqeohx7en5FfO8Z1FBkzjMeVt+5tcUumDF3IgX
         UwKq9enJGpQdaoN50IHv2lZBd38hP0cediZqIttTrpvZwDr4cMn0WQkSvJvZZDLN4wFc
         ayfIW5psaJ4kTZygFF1Pc2VxU2XuOlJ2NP4+bhTqj1/7DUNlZxU9/e6Uz8tsawBEgxlM
         0YUB+SAZv+B9/F2piwpnKi1z5fm0hQlONkjZRSEDur05RM9kQEGCGCsOyKA/WCqFF7/v
         y2CA==
X-Gm-Message-State: APjAAAXNpAQUs/1ImZS/IRmZZrYKatMdihgysvd8FBR3U9XK4bbhUPLH
        IjTr9tuCJn4r3ZRFRsMH5RLswQg=
X-Google-Smtp-Source: APXvYqw/Jh5IF7kfPSNLapJLn1m2Wst4sJnrhOAENuq/iPtlYO3+8t9V35oUUVXbIRFrJM4Khtyl5w==
X-Received: by 2002:a9d:618a:: with SMTP id g10mr21452912otk.217.1564585248491;
        Wed, 31 Jul 2019 08:00:48 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id b2sm23363929otf.48.2019.07.31.08.00.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 08:00:47 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:e83a:d1d4:543d:69b])
        by serve.minyard.net (Postfix) with ESMTPSA id 67711180039;
        Wed, 31 Jul 2019 15:00:47 +0000 (UTC)
Date:   Wed, 31 Jul 2019 10:00:46 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] More IPMI bug fixes for 5.3
Message-ID: <20190731150046.GB5001@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep Geert from nagging me :-)

The following changes since commit fec88ab0af9706b2201e5daf377c5031c62d11f7:

  Merge tag 'for-linus-hmm' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-07-14 19:42:11 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.3-2

for you to fetch changes up to 71be7b0e7d4069822c89146daed800686db8f147:

  Fix uninitialized variable in ipmb_dev_int.c (2019-07-24 15:53:21 -0500)

----------------------------------------------------------------
One necessary fix for an uninitialized variable in the new IPMB driver.
Nothing else has come in besides things that need to wait until later.

----------------------------------------------------------------
Asmaa Mnebhi (1):
      Fix uninitialized variable in ipmb_dev_int.c

 drivers/char/ipmi/ipmb_dev_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

