Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0BCC74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B0821019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIh85Idm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfGKJz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 05:55:59 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:35645 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfGKJz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 05:55:59 -0400
Received: by mail-pg1-f171.google.com with SMTP id s27so2697446pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 02:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=q4aTVXnmJvx0+ZI6UEfBVpgkZHcZDIxsB4G/ZiMf9pM=;
        b=SIh85Idmmnmu84Er31UhNLbVafgqi0UkV82OpvVm7rtrxdNqU0AhgtRNEDYXqq1Rnd
         ugoF2aZF4eWlgQOGXYnlVOibsauiHFEV10Ne5Io7r7KiKdqT4/Zbq/e97dKABlp2y/JK
         rim13rddkbLQIxqq6Ue2WPkqomeZg+m1Umlth521X+2g4GgLgREy/079n7cdVwiRR8kE
         CP+XnaBtURhybFsdjMQjhtImN2cnppq3JBkuHelKJSc0HRvYBnYEg6DBuEMzbtug3iS0
         SCZ8IVEyQcU3kuZdSkRE9cPSfELrqMZY3JoiNNYaRHuJ0Sil5qisb5/bBUcP7Bwi6jBD
         FNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=q4aTVXnmJvx0+ZI6UEfBVpgkZHcZDIxsB4G/ZiMf9pM=;
        b=GdrMxCERQK8dg/9pC5EaE8EA5fwTMXnZQQGkpOVw9T8yxu8DYViTV53EgkemWGMHTV
         x1dHu6yO1kc9Q9dPSm9iJohun7l5PZiX2P0CNx/mxRAEe7hx+7HB/irJCgYsOBl6H6QR
         1MAivXmZ8/K4edHrvsf9usnOWA3HIqOgQiJENPjb19dwIe/xHbgpVJihp6aET0X5MFqw
         3BpEAQrI/mefs4rDGcrFFPDmeqt53LG5o3N+deCIoM62ChYA4sU9DbvJWzLH+wwkKsqQ
         TmHVJgy8X8cx+kZ9HJcyo48MDGrrqBIZwofl16VrPA8XFg2sgzNDkQnLpCjYydsHGmJ6
         bYEg==
X-Gm-Message-State: APjAAAVLrT89uSIpuMeQImf4x6K3bOKnUN84KBm2638NZA4k63xHSZE6
        eUGosbqTPs5iV9nxltGaMZ4Ud3/j
X-Google-Smtp-Source: APXvYqwvy8CZPo/ZKAxkPcg+J1VB346XgSM3stuTnmFgdJfcOxtjIO4tApyo1mgLo+tzQKgwBPC0UA==
X-Received: by 2002:a63:181:: with SMTP id 123mr3550274pgb.63.1562838958158;
        Thu, 11 Jul 2019 02:55:58 -0700 (PDT)
Received: from localhost (193-116-118-149.tpgi.com.au. [193.116.118.149])
        by smtp.gmail.com with ESMTPSA id f3sm6828140pfg.165.2019.07.11.02.55.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 02:55:57 -0700 (PDT)
Date:   Thu, 11 Jul 2019 19:52:59 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v5 5/6] powerpc/mce: Handle UE event for memcpy_mcsafe
To:     linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Santosh Sivaraj <santosh@fossix.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20190709121524.18762-1-santosh@fossix.org>
        <20190709121524.18762-6-santosh@fossix.org>
In-Reply-To: <20190709121524.18762-6-santosh@fossix.org>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1562838616.xzrha67fy6.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Santosh Sivaraj's on July 9, 2019 10:15 pm:
> If we take a UE on one of the instructions with a fixup entry, set nip
> to continue execution at the fixup entry. Stop processing the event
> further or print it.

So... what happens if we take a machine check while we happen to be
executing some other kernel operation with a fixup entry?

Or the other way around, what happens if memcpy_mcsafe takes a page
fault for some reason (e.g., kernel bug it tries to access unmapped
memory).

Thanks,
Nick

=
