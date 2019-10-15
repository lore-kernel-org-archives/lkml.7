Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEABAECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9086D2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571178071;
	bh=rkQXlFDsFSyesOcjvZcFxgz+cNH1rBDwoJ21bgZxyKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x5+cKaRsDsrzpqyE7bFfol3Ah0g18QczZHxJq1ShumOzXr/MLaPw8yfz3XXrqEAI4
	 ZQiycP5jb+WF9KVUtGFA8iyavid3okTO0w63ohFQByJiDtaJoVM9woR5sWMl+lNQaI
	 2LUB9zN45Rth/fORJkK1U7EUfC3D72cRqVK+/W8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389304AbfJOWVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:21:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41427 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731275AbfJOWVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:21:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id f5so21891503ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igJfeABa6M5mmcDSZ9XAWyfxDlpeT34TBKS5Vu4WYQ8=;
        b=LIYdbK/WEFGMNdD+uIGw2BasCdPDikOSk/1C31c/6KJAoWeweWvBbkEnJF4PHN8TkH
         BgZdUCf/ZYXj115hlOqd/koyMkdZG6Il9yGalmukOiV4kTIOYCVZSlLQpLqR2NWtyVYg
         nGZ/n1OZmV0DBw+aQ4pzCSwYlzFEdDM+SUZEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igJfeABa6M5mmcDSZ9XAWyfxDlpeT34TBKS5Vu4WYQ8=;
        b=CeT2bHSszxNJED9uxFPE1JjgKycdhcAdzH0qncRq/a0tTAc/O05rrKTJzf7etZujUn
         AC/JAt58LtjEm+CrnN2qgUVZAUizBF+6M4ijJVbfhV2dDKx4JLAPj+5YLZfzvAOtGKNK
         12cKqVyXGB3hA3+Zk46H8Y6pOtA5i7fp6msckQFvHxhsA5ez5GRoAtX8rhFz+bUClmiD
         3goe1y2Ys1a8bClS9BBd26dv1iDczK20H31I1m4hQYEXasVCvTu8nEHIflEicZhp6TXy
         cpIFaH52iDDc2kUBV2vk+LXxmtulvx4mpjZfdsfobv08ERIsqu+IVVJXJpsTeAi5e8Rs
         HIWA==
X-Gm-Message-State: APjAAAWTDccluyVd3dgvzR6+leSCN2KmB0MFyD/WCTUQH0rJp6JXupeS
        EaYHNGKM+BdUJGocvYqwiNXct+O9EpE=
X-Google-Smtp-Source: APXvYqwaHNTwmIXUKA+wbNC3wUW7YCm+2D3kcO6UmRa/CilgoMaw1js8Ilde79K/9Q9Z2j3V9pcawg==
X-Received: by 2002:a2e:91c3:: with SMTP id u3mr23005194ljg.177.1571178065100;
        Tue, 15 Oct 2019 15:21:05 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id v7sm5381896lfd.55.2019.10.15.15.21.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id q12so15700882lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
X-Received: by 2002:ac2:43a8:: with SMTP id t8mr22573654lfl.134.1571178063150;
 Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
 <157117614109.15019.15677943675625422728.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117614109.15019.15677943675625422728.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:20:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivjB8Va7K_eK_fx+Z1vpbJ82DW=eVfyP33ZDusaK44EA@mail.gmail.com>
Message-ID: <CAHk-=wivjB8Va7K_eK_fx+Z1vpbJ82DW=eVfyP33ZDusaK44EA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] pipe: Check for ring full inside of the
 spinlock in pipe_write()
To:     David Howells <dhowells@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 2:49 PM David Howells <dhowells@redhat.com> wrote:
>
> +                       if (head - pipe->tail == buffers) {

Can we just have helper inline functions for these things?

You describe them in the commit message of 03/21 (good), but it would
be even better if the code was just self-describing..

           Linus
