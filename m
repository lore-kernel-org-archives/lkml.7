Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7940FC43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EEF2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="f6D/SUiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfFSUHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 16:07:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43802 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfFSUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 16:07:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id m14so359703qka.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 13:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ToDnmQBmZ4+9b5046BMcxAyM7qLTYX9a1Cmvascd/VM=;
        b=f6D/SUiEhFZ/CGHggke1C6VEBYVhHM0ciu2hgZIQza9yxI928myS+XybhmIhGzSC2I
         1DrO2abbn6Iw/j1UXy+p94jVXBVD0wlSEcugORlqNbT9tG0ZQ7jHM/68LGCGaqCpNZ6V
         5EPUN9yLfawforNWkb2+zyW6VhBF9agPIm32M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ToDnmQBmZ4+9b5046BMcxAyM7qLTYX9a1Cmvascd/VM=;
        b=JEggNlAvXNR1wNB3iKcLoRiWmM1eHAaEBRgEEc/oq1HEIOFIq2m3OTF/xVm0mf5/ch
         uL0V+scB4RTgLH0Se3NADvie7/6GWLGLmB40ZqUtNFNVPuAvRdduXieBxXLe1y28IRXV
         pvJvP2FMrAKb8RIIkYZMDr0sHR3uGr0gsQME+LQSLimT/nH6QeGGwQ/pkuv/qxqFdjMr
         Y2Lxr/mcjXSqjjIRo201635vpAQB1F2QP7lKmLE4u1cGOJwExvY5A4T/wJCxDSkU88TU
         goI6ur/Fu1pg+TCsdTEfbe63lJLQw8GJ7emhJVdlvZK6ZT5xSADC9P6nXdnFiwMA/rCc
         xjKg==
X-Gm-Message-State: APjAAAWLfvNUCVAlVLKX6LTt5plqLISVoCNO4dCrYhaXvqo+Cf4yq6zR
        dngJZWhhbMErKjccYI7awVqYtA==
X-Google-Smtp-Source: APXvYqxm8yO7KGmlbCfITLVrTnlA7dbDtCmUeQYV5O/70rdy0450hDW+g/ANkIo4sezA8Fu1uULvQQ==
X-Received: by 2002:a37:795:: with SMTP id 143mr102816441qkh.140.1560974826485;
        Wed, 19 Jun 2019 13:07:06 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id i48sm11143418qte.93.2019.06.19.13.07.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 13:07:05 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 19 Jun 2019 16:07:01 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     syzbot <syzbot+10189b9b0f8c4664badd@syzkaller.appspotmail.com>
cc:     acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de,
        eranian@google.com, hpa@zytor.com, jolsa@kernel.org,
        jolsa@redhat.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        vincent.weaver@maine.edu, x86@kernel.org
Subject: Re: WARNING in perf_reg_value
In-Reply-To: <000000000000734545058bb27ebb@google.com>
Message-ID: <alpine.DEB.2.21.1906191605380.10498@macbook-air>
References: <000000000000734545058bb27ebb@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019, syzbot wrote:

> syzbot found the following crash on:
> 
> HEAD commit:    0011572c Merge branch 'for-5.2-fixes' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12c38d66a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
> dashboard link: https://syzkaller.appspot.com/bug?extid=10189b9b0f8c4664badd
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1434b876a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e6c876a00000

the perf_fuzzer found this issue about a month ago, and patches were 
posted that fixed the issue (I've been unable to reproduce when running 
with a patched kernel).

Any reason they haven't been applied?

Vince
