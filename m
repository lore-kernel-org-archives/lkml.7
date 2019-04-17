Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4385EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2F020663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Een8CXcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbfDQSyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:54:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47046 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbfDQSyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:54:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so12429228pll.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GY3HlNvtM9lGsCqXpRXgx6RtNSQFhrxpP8TS5Du06OY=;
        b=Een8CXcLLqBSQ5wCyra0EDiBio5PYsYVkdAXLyfUxA8a6LVtGKc6ookDqvZ8VFpc4I
         t+XWXY9lX3ZQaok1avjE44pgfaMLKwRLtBdBhg9zw+f6s5mOMu55+kK6xdKTljUBOZNB
         A4cByzl5/4v11vBW9/mkJqudcYThsi5sl/5DOpYQE8594WK3ETrcwG+g4iZnxzI8WK0n
         NRWRa7Ku6kTUDds6pah55W9Nfn8vJZWa5ZTTyT1A0nzg7OEJnidGZ/3qldKcIcSSeKRR
         KfoeGmMXgaka+lqmTHP3xl9UWMslIb/KH2woH/7NkE5diOilFgaYCbepMPO1JcC354uK
         wUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GY3HlNvtM9lGsCqXpRXgx6RtNSQFhrxpP8TS5Du06OY=;
        b=dJUWFkk+nPZwPzXflrCDI/T4cLOXJzwVUEhqwMOgvLOJtaSjoEiM62Nqorh+dHKnou
         o4J2cBPceypzxzUwxbQ+WcBJt6Qczc+J9VXJBi2yF7OzJq2D0u/uAClNJbfDGqRQH2gG
         xOX7XyuT91j77FnLbjfmrqDXiwN8eYqSx8lN5gGTPFj5UjBQ8SQYGL3qU3HSdmD8PfyR
         No4uQswtjEWq9xFs1XnIsuMWLN3Y9dVbYsvlEkQm1vi70cECbJsyAn5Ds4iV8pnX9r+L
         eNwc9iXCDBGtiJd5U3eACdrhlpKKp+lPrY9K9V6K8bc1jXfkDrpFGq0Ku8puZeMwmjZ+
         mHmw==
X-Gm-Message-State: APjAAAUrhxSGtbJsYfvY0zSlmmPCcXVQNT6Azd+NDdIfrugHPMyK0Jek
        pzVtRQ+DjMq7VS7O7Tk4Bpw=
X-Google-Smtp-Source: APXvYqyPE56jFC/6AQxC/L/B7mdn6aiFPTZT7l4Akf2U4rXsCWoA6Nb38iDOziQyJr3AqVH0TJ1Ctg==
X-Received: by 2002:a17:902:e709:: with SMTP id co9mr91888430plb.86.1555527246733;
        Wed, 17 Apr 2019 11:54:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j5sm59266946pfe.15.2019.04.17.11.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:54:05 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <code@mmayer.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] memory: brcmstb: dpfe: report firmware loading error
Date:   Wed, 17 Apr 2019 11:53:54 -0700
Message-Id: <20190417185354.999-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402230103.25491-3-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net> <20190402230103.25491-3-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Apr 2019 16:00:59 -0700, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Print an error message if the DCPU firmware couldn't be downloaded.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/next, thanks!
--
Florian
