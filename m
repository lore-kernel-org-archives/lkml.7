Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80780C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410BF206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RLesCpt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfFFPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:42:32 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:34788 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfFFPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:42:32 -0400
Received: by mail-pg1-f177.google.com with SMTP id h2so1590896pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZawA+iZOSJAZNtAUyoJ3pGc/N5S/i87IWFfgocy0e+s=;
        b=RLesCpt3QeyWEIityCf0prUXi0LRvr0YMT/HyZcUK86bCo5bvZOmir/9zeekSwtEJ3
         tMmnodU5jetOGs7/jE1WKnIWyyl6exkggpGq0cZctOt0K3MLrBn+ueiy43oGPG5d/I7r
         dJO3VE82qQWYGkL+2V3ss/I8DaSATaouxHEvStXqE+lG1eP/P4e9OLNLPRDrnuLL0hGs
         9jzbUZgkSKsFRuT5kHjdsAMnE7Qw7GKrRB9X+BFaQ37BYGsytof+PGsJFaKzQE0RAckY
         uc4MH7D5JdTzuGmeyu9Kn5uwJj3711Og+VZ5JDhQjLTC3DHiZ7JoqLncIwa6YdyOddoI
         fRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZawA+iZOSJAZNtAUyoJ3pGc/N5S/i87IWFfgocy0e+s=;
        b=EIo8HNF2ZLBzo/ZNr5vIoA94lDupMf51c2m50kj+G1pLU/DX0HyFtjVy9F/Q6ZZxvm
         9nTTkz85vxpc7pIpq55NG/poeT2Noc5yq2kdSdAjJ0kTsctS7oTsR5uuDwwTmOIa8xWb
         Pga/Yhrjaxd9Agm+/u7PcyO/fkvRtLm/0PMDx4CRpS4Swvb09l4++noOZNlJABVpWeyx
         J6CdE478OBm+X0/wylr8JMc/ZOardAEJeWtxoQxPCpCt6ugztZbUOAoWFqgdCcveyTVh
         AdIWR1n2UsWFxWt4SmOxqRkwrVo8WeWgt8k5egYwPeA7iVk9LjTU3fAw6f9sEO0O1veh
         eaHQ==
X-Gm-Message-State: APjAAAWVH0MdiGe7rCZZWU2IoYpfjSD3BvkcHT3y6bpd2sMaoN0hDcqd
        x6XzMofKa7m0/HhzdB1tzxso8m6GQfOy/Q==
X-Google-Smtp-Source: APXvYqx4kogHKk/c2Boqg6sX1qyQ7RBmEFL2JMtOpkKE1hecf4opydsz9GCyAfdl1db+YN88h61G2Q==
X-Received: by 2002:a17:90a:a415:: with SMTP id y21mr501016pjp.75.1559835751297;
        Thu, 06 Jun 2019 08:42:31 -0700 (PDT)
Received: from brauner.io ([172.56.30.175])
        by smtp.gmail.com with ESMTPSA id 85sm2373269pgb.52.2019.06.06.08.42.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 08:42:30 -0700 (PDT)
Date:   Thu, 6 Jun 2019 17:42:25 +0200
From:   Christian Brauner <christian@brauner.io>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC]: Convention for naming syscall revisions
Message-ID: <20190606154224.7lln4zp6v3ey4icq@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

I hope this is not going to start a trash fire.

While working on a new clone version I tried to find out what the
current naming conventions for syscall revisions is. I was told and
seemed to be able to confirm through the syscall list that revisions of
syscalls are for the most part (for examples see [1]) named after the
number of arguments and not for the number of revisions. But some also
seem to escape that logic (e.g. clone2).

In any case, I would like to document *a* convention for syscall
revisions on https://www.kernel.org/doc/ . So what shall it be:
- number of args
- number of revision
?

Christian

[1]: - accept4(/* 4 args */)
     - dup2(/* 2 args */)
     - dup3(/* 3 args */)
     - eventfd2(/* 2 args */)
     - pipe2(/* 2 args */)
     - pselect6(/* 6 args, including structs */)
     - signalfd4(/* 4 args, one of them a struct */)
     - umount2(/* 2 args */)
     - wait3(/* 3 args, one of them a struct */)
     - wait4(/* 4 args, one of them a struct */)
