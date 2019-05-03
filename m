Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1870C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837B52081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfECPkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:40:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42417 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfECPkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:40:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id f23so5663250otl.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 08:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFYEU9GgCBN7KdQ5dA8SVxpvDRzvxb6cnqoUyye2asw=;
        b=Bj4FvsMjsIKHrttkhRGkZg81ACxgeEM1XCfA/kNWrpCtZNMvmeSvJoGJJUoPM0l/fU
         4xJTSp4a62/ZRf2RIMDQN6j2mt/4Z37CjTUL6GbuGu/603v5OCWtM3Dqdq1onCbO2hwK
         A4c2dN3aV/IfRSTSADVMbJxaE/wX8RTtk5p2n0Vu5645WR5+Rgedi8FHdnNbPBTJtI4j
         crNkOq75w2kUGl31ksIoRx6DXhNDpD9FAtpRRYcaH3dOIJLyVaQJN9Iv5nW820XaXT2S
         oOYsfZ6k9qKvjRk7d8V6KVZm461zRaTCyyOGYLAAXyHgyfSqHgmjYrSurknmYrfEuYRx
         cOxQ==
X-Gm-Message-State: APjAAAUvgaNyFAw8oDxvc3uG7j3zCUd4WKCOFnJ/HkUf5Km6W+N4eQQB
        3M2hV1okmZowwgDTCgVm2/DQ/DzNVJPmKuE78RKEmw==
X-Google-Smtp-Source: APXvYqwug75Har1bmPTcDzwSR3mUqYlYW1QvAU/CymzUAVxIora6jd/Tt6TDWV/xdpOBUWK0r1b4epSunToG1AZFWXY=
X-Received: by 2002:a05:6830:1156:: with SMTP id x22mr356724otq.241.1556898052548;
 Fri, 03 May 2019 08:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <1556824391-24060-1-git-send-email-jsavitz@redhat.com>
 <1556824391-24060-3-git-send-email-jsavitz@redhat.com> <b32818a591a74efd88dd920fba530a8b@AcuMS.aculab.com>
In-Reply-To: <b32818a591a74efd88dd920fba530a8b@AcuMS.aculab.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Fri, 3 May 2019 11:40:41 -0400
Message-ID: <CAL1p7m4UAx7ShwuDUWBvVJkvGNKX5qsR4E+TOLyy9K=sNxY94A@mail.gmail.com>
Subject: Re: [PATCH 2/2] prctl.2: Document the new PR_GET_TASK_SIZE option
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 7:20 AM David Laight <David.Laight@aculab.com> wrote:
> Shouldn't this say what the value is?
> ISTR a recent patch to change the was the 'used to be constant' TASK_SIZE is defined.
> I think it might be 'The highest userspace virtual address the current
> process can use.' But I might be wrong.

I believe you are correct David. I will add this information to the
manpage in the upcoming v3.
Best,
Joel Savitz
