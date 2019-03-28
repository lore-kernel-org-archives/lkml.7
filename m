Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84A9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A45C2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi/dyzju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfC1XXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:23:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37146 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfC1XXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:23:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id c16so461576otn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 16:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ounNmDBvL3676Tvkm21rKmCiX7MuQ4zpO5otzkNxiYE=;
        b=Gi/dyzju2O93IeptXKQwTeciJ8QFQUXCaKb6uEOu9+ql0AnmxcaqhuFDHuWShYpmHD
         Bk9uRUSWWFv46VtUmR/7vxovL5BReMYUXS7wN0obZNDdXSAnvJShAti21w4LZ5k4klIZ
         GqmFu+rszsL1PQHg9GkbeUGf3gGrgK/06M5QDxmAIJqCrYX86Gwakno83Ba0id+jkybO
         ao7B8+SORV3INphLIapSgXUJDL3BEs8DdbhG7o5SxxNlDwV0CGp6g9rdn6CBk+G5QcsU
         8wi9TknfZl4iySRhVrtMBpiXe1p06k2w1eNLrs+kAomEcsaGvO6jOw7H/lnN52LaoliX
         Smdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ounNmDBvL3676Tvkm21rKmCiX7MuQ4zpO5otzkNxiYE=;
        b=ZHKtXikKlniZ6UT5hQzOAG406+wyVHTrFZIzWjqF3a6zlTCZ/utDbsUnC1fc4CiKD8
         9zSki3sACg14MoRmXN0LFP2N4sJqpYmsq+YrSwHMvKp8Dp31QAb3WvsimhouP1Tm5bze
         GQHza+917XkdodnJNzTtpbYHDplQiUfsAAZCEP8epg1TttKu7/iNCATGB2se0WeZPB68
         Tby6sXkHXBiGx9ghDAX27m8wv3H3NZorCh1EPZKMqd1jbyCK3O/XvVAUI6QF5l4RyQQX
         d/93I1UtAedSPzCLN9N90W+GuPRh29AAjNWotD4ezsYf41rkx6FqVOtZWnf2ovD14xvs
         CJiw==
X-Gm-Message-State: APjAAAU+fwxb1jKG/ZkFITBSYkNQNsno58lDbqYS+S3gk8vnvml+sEfU
        jmcCa/8nGod9l2Z+J4mLH+b5wyqGQEDk3zhg4ouoZw==
X-Google-Smtp-Source: APXvYqz6w2dCvJ4Nnzk9ChAlzqTWrxrDNq70eUOvOqPH3yshvPy0BDry7fnrWC3H9z/CZpJxNQcjqeGa1EMml7xYOpk=
X-Received: by 2002:a9d:6b97:: with SMTP id b23mr12735088otq.113.1553815429906;
 Thu, 28 Mar 2019 16:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190328231317.330699-1-tmaimon77@gmail.com> <20190328231317.330699-2-tmaimon77@gmail.com>
In-Reply-To: <20190328231317.330699-2-tmaimon77@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 Mar 2019 16:23:39 -0700
Message-ID: <CAFd5g45V=iKmZoxzCT1i=yP2tizahm=+459wgdFcYv2u6RZFgA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] MAINTAINERS: Add maintainer and replacing reviewer
 ARM/NUVOTON NPCM
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 4:13 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Adding Tali Perry as Nuvoton NPCM maintainer
> Replacing Brendan Higgins Nuvoton NPCM reviewer with
> Benjamin Fair.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
