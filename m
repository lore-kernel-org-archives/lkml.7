Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBBFC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F44A23BC4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HM+aD2WH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfE2Psq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:48:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39205 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfE2Psq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:48:46 -0400
Received: by mail-it1-f194.google.com with SMTP id 9so4340115itf.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDz3GbUaoai6r6zW2MM2kvL6r+fuZogzUR81Y2LegRo=;
        b=HM+aD2WHWHXPATtRijrlE6pgyLNsdvu63KgjTL49oFkMJudqlZoYZ8f09bSgUZ00cM
         UBIFA2ig49PRFgbWTBqlRg0bT4x6o99kGSMBxaueQLiX9/in0ivbgL6eobEw5dh+VFne
         V8Y49LUYOrhunDFrh+PrlG1sdaO5FkdZgju4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDz3GbUaoai6r6zW2MM2kvL6r+fuZogzUR81Y2LegRo=;
        b=XxTn75kM+0Pk2FhxBfKavQ87VxNZAoSEqTVRZhzoyN+gsI8+KXqnajMR5GS+gAnG1i
         PDzbsFqCrJhLFAlq4VBTG6uvlt02tIuEpM/gMR7bWALEBGMf7zz5mudCKVbufdwm+kH4
         NRKcNLaHx82PAuV9/6Rqwk1tJj1kkKdNxX58WE2ixr7qS3lrBETp6VmAn8IjkTDdggf1
         FWXHd9h9tbhyl9OaOIZD389hz9vf3DaptBP6vhjF2f+/vHEIBLdaNAz6EsfHs1my/kir
         GMcv6+/Po3TBkowEKD3NhZDcVXUk5xMNJgPjV3gx6StijS2bnhgw7JXZEal/WyZKmeHR
         WKqg==
X-Gm-Message-State: APjAAAU4p+lQxM5ZLH1P2QdOihyKo1qs/PzyXse98I4UyPJneEY8nbLU
        XRDZGeRT1R6FBbWG5s7sRnNbsOzJfws=
X-Google-Smtp-Source: APXvYqyhVVua8TxP97FfKv/W5QxTw90Gb29PNWJqzz213Jf3qpyDLwCHmEzeww3CC/50rv8+hac57A==
X-Received: by 2002:a24:59c4:: with SMTP id p187mr7631250itb.123.1559144924676;
        Wed, 29 May 2019 08:48:44 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id u5sm5906523iob.7.2019.05.29.08.48.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 08:48:43 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id r185so2250225iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:48:43 -0700 (PDT)
X-Received: by 2002:a5d:9d90:: with SMTP id 16mr6500257ion.132.1559144923364;
 Wed, 29 May 2019 08:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190520231948.49693-1-thgarnie@chromium.org> <20190520231948.49693-12-thgarnie@chromium.org>
 <1b53b8eb-5dd3-fb57-d8db-06eedd0ce49f@suse.com>
In-Reply-To: <1b53b8eb-5dd3-fb57-d8db-06eedd0ce49f@suse.com>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Wed, 29 May 2019 08:48:32 -0700
X-Gmail-Original-Message-ID: <CAJcbSZF1xcMpLDrOLkh493+ciVUqrku9WkWdb5xxAqWuXMjGZw@mail.gmail.com>
Message-ID: <CAJcbSZF1xcMpLDrOLkh493+ciVUqrku9WkWdb5xxAqWuXMjGZw@mail.gmail.com>
Subject: Re: [PATCH v7 11/12] x86/paravirt: Adapt assembly for PIE support
To:     Juergen Gross <jgross@suse.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 10:47 PM Juergen Gross <jgross@suse.com> wrote:
>
> On 21/05/2019 01:19, Thomas Garnier wrote:
> > From: Thomas Garnier <thgarnie@google.com>
> >
> > if PIE is enabled, switch the paravirt assembly constraints to be
> > compatible. The %c/i constrains generate smaller code so is kept by
> > default.
> >
> > Position Independent Executable (PIE) support will allow to extend the
> > KASLR randomization range below 0xffffffff80000000.
> >
> > Signed-off-by: Thomas Garnier <thgarnie@google.com>
>
> Acked-by: Juergen Gross <jgross@suse.com>

Thanks Juergen.

>
>
> Juergen
