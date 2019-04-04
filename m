Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CCAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51C320663
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I939hF22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfDDSOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:14:31 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36170 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:14:30 -0400
Received: by mail-it1-f195.google.com with SMTP id y10so5275355itc.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrzaH3AFrCMxGy3AoMYn/DdcKy7hCJb7BxYU/pUyAR8=;
        b=I939hF22vqsqSPahI4Zbs92jQYaEOpqfbNeWkt1+WIFLPKtFz0cweepxvEPrk87nRE
         y8+5vnGD6MX10rotI1pssfwer9dJbGuJ+p7ujg/SRiwXYfjjHJyF/nPGjmi84OZvxrmK
         JRhmbNa2TWMTSYnK2kP64EDnRe0SDiOK9R5keppfJlk3tKMRgH0wFIFLyl2oTljyJckC
         JsJ8yLNvfGO6bVeaDPEliMwuD7S6FmmewgbHSeZKxa+68QJAKSwEdy+woFbZE2ozjh6g
         I3pZlWXotsW8kfAgqIbiE9NQpnLcavduSlelGqC+jecqrUO3wwzbEgbas3/0pxgucfVV
         3jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrzaH3AFrCMxGy3AoMYn/DdcKy7hCJb7BxYU/pUyAR8=;
        b=iXqvpRhnQqKZk0ZVPyFQKfzuik6IcXcU2LFcUxYqoxAfYHLMy9d5jsNQpfyx4PuzZw
         OGFvJPg7EcNopz8QU5X0JLJxskkV685IrEGFSYxbebKh4Z9e/cvHH4XTd0VzD//t00F4
         T1znvHNYDKIu0Cw9bPKig2D0pDZ4NrnyTQEyK+obtQJI+IICalM6y1xhkL+V96UIeI3H
         vRXB6H/EMLjKSOgFZfda7dvR4DEoc7qbDLjNgFBnKE+elBHkjVEht49D472Dtm9EFjmY
         0TYkqDIjlyX2ZsgrrnsFLjVXubWIm+x+u9kuWqvdkBrTc5fi4nnRfN872MkOZ91rRRrG
         T/Og==
X-Gm-Message-State: APjAAAWnHiL4VYoWcJa0pJzv/ZmI4oYJHK8qB5a0ydBOmupPNKaKeoP3
        NQk1FtzgeMfpxOm7Sl7S8248GTGZCQNMWfRmxkHaFyTQftx6bA==
X-Google-Smtp-Source: APXvYqy0YuDveiavcAbz4tkDOFHrewYQ/Os5kCZ8MnrM5csLsOrK7l5xyNI3Xkqrlw8B/2brNt+ed5NdAv0Pg5rqAuU=
X-Received: by 2002:a02:938f:: with SMTP id z15mr5827329jah.108.1554401669729;
 Thu, 04 Apr 2019 11:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <264283F7338E734E863366C752FEABBC417FE18A@CNMAILEX01.lenovo.com>
In-Reply-To: <264283F7338E734E863366C752FEABBC417FE18A@CNMAILEX01.lenovo.com>
From:   Benjamin Fair <benjaminfair@google.com>
Date:   Thu, 4 Apr 2019 11:13:53 -0700
Message-ID: <CADKL2t7yjnSj85uiC=7hv8skG4b3=3AGzBrDQHJ4NCgDoY1Wsg@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: aspeed: Add lenovo hr630 BMC machine
To:     Andrew MS1 Peng <pengms1@lenovo.com>
Cc:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "llinux-aspeed@lists.ozlabs.org" <llinux-aspeed@lists.ozlabs.org>,
        Lisa YJ19 Liu <liuyj19@lenovo.com>,
        Duke KH Du <dukh@lenovo.com>,
        Yonghui YH21 Liu <liuyh21@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 1:05 AM Andrew MS1 Peng <pengms1@lenovo.com> wrote:
>
> The Hr630 platform use ASPEED ast2500 based BMC, add the device tree for this initial commit.

Hi Andrew,

Thanks for sending this patch!

Unfortunately, this format makes it difficult to review, so please resend it in
plaintext rather than as an attachment. I recommend using 'git send-email' to
do that.

There are explanations of the Linux development process in
Documentation/process within the Linux source tree, including a guide for
submitting patches and hints for configuring your email client.

Benjamin
