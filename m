Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505E2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B4321920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DcqaoHnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbfJJJBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:01:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46433 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387914AbfJJJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:01:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so4856950qkd.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=RnfWy7RbwLMyjkDN3hZ9aqaLFEi/aaIZD+6GHufi3cY=;
        b=DcqaoHnVvnghNBODhEqsdmUoQjKa8VPa3Qk7cPM9tD9KorPgfDoHPtihpS0KYXfNgI
         GYlvF+v2eWobPCQNz3c+ayng6V6uCEFDOpEp3Ae/fyDp9bOe99SQsziiyfpOm4ZShjaS
         /4OqIuRWSKcbmiXggwGhG5Hs+2je4aI68jeLfKVngKcajG+1PQCBP+lmdfuzFprTHM+U
         Fm6J+z3NIKMhTHxMKU1qRQFdQ9Xy6OXzoG1wRhzgBzCjJFivL2kMLPa6WecPPxFK+z35
         Xo95gaeGAZBZ10kd1ZR0xyTyHEXJ51Qn4yf20VitQTzjb/3UHEnq3rwq8uqoOgV1vmpU
         4uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=RnfWy7RbwLMyjkDN3hZ9aqaLFEi/aaIZD+6GHufi3cY=;
        b=V7EYBEnXlOUu8n60Fjw9Zg+hzBm6+3AhyQhFJxJK6hMINqiABGDTFnSTa8+KAX2KuJ
         +U0q/HPkV978E1vUtbBMo8D+BTfMGWeVZ+loLs5o9J2wWkAA4qrg8gnBqo9eyVzdrnz8
         +291rFgkZiADycYZyfWbTPAcq2QHDyfkER4e2J2DurZnyoewJ9w88oV/gTugOXVjAiBf
         9E3a4Es7Sqq8T7Tic5tOtasXFVi2hGN7YHoL+2J/MOPliotBDOLRdwa9AKCmh6xrwjEk
         Ji3qUYKBXZgip6zEFxDnNNAhwgzR3ia/m9rS22aACQp6XALT6uhL1i2NTNVgT2fhnPlN
         2iWA==
X-Gm-Message-State: APjAAAWmfEE1RX9vvhBOPVhg8PCbrxCvDqY7PAgc/X64eOfGEFLzmelb
        euQDfOxK23tfnC7b8fLen4XXRA==
X-Google-Smtp-Source: APXvYqxdc4HzzOMRhsrDi7bP8kpwPoy0x09tptP+hjsvrkIBzvcyF4TjtfzGTcueITYAEkMKJKP1gA==
X-Received: by 2002:a37:e407:: with SMTP id y7mr8300320qkf.77.1570698105860;
        Thu, 10 Oct 2019 02:01:45 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m91sm2238816qte.8.2019.10.10.02.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 02:01:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Date:   Thu, 10 Oct 2019 05:01:44 -0400
Message-Id: <6AAB77B5-092B-43E3-9F4B-0385DE1890D9@lca.pw>
References: <20191009162339.GI6681@dhcp22.suse.cz>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191009162339.GI6681@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 9, 2019, at 12:23 PM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> If this was only about the memory offline code then I would agree. But
> we are talking about any printk from the zone->lock context and that is
> a bigger deal. Besides that it is quite natural that the printk code
> should be more universal and allow to be also called from the MM
> contexts as much as possible. If there is any really strong reason this
> is not possible then it should be documented at least.

Where is the best place to document this? I am thinking about under the =E2=80=
=9Cstruct zone=E2=80=9D definition=E2=80=99s lock field in mmzone.h.

Does workaround this potential deadlock and fix a few lockdep false positive=
s for free count as a really strong reason?=
