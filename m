Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64BFC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82048205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551373132;
	bh=PPl6vdDStIepNI5IixKVHxB01Icnudc44FnmIMYrbZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RRFjG1ffNKdxfmjiNaQA6SkjmBKWi0kFUoiRizEMIavqL4cHjGdAOm7iu5YtG/K3u
	 t54AslI9syzIwQFmQxlSTq5fTfeecD5LDhu+2nOvi0oXukUYw4a3WFcX0oU1Lh9BzV
	 pnq8WPnPEnaByAZzCBKiI5uP/PDzO58QevXuGZ+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbfB1Q6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:58:51 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46793 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfB1Q6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:58:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id g12so15761571lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yof9XX0sAtU3hMlzcNc6P0eK5prbTGR6CKOsjwe9+ps=;
        b=KXm75Ywsw00Q7bdgS76QUYR2Q1ydIcu+mPJ5Foe88eSPocyTtm7QvfWhpEzwja89bI
         ZAhT7iqOo00VU0eGQFntQ8Yq36dvw+y6otvFIlaHEo/C+Y2Z5iEleQbp4Q2AjXmUu3gn
         kCnB4kWwV8E3ZiDq1NuGaMUAXC2dyuD8lcbO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yof9XX0sAtU3hMlzcNc6P0eK5prbTGR6CKOsjwe9+ps=;
        b=hhRy7lfHw0KgluQy8eUs7Ie51qcDdOkbl96+7x2BsnH3NY1hcTlUFgWp+lj0VzMSs1
         wCvYUHmmSk2BnDUFpLJPV71Kgz4t3RseyocfCunjh8DCcNv+a6mb8hJDPAmKIiQZUIIJ
         xwwjXNtWugLAEJCzYXEDV4lGhA9wfAJNFOk0I4O3N7HNiSC9udc/8z7pFNX/gDz8iqGU
         E/O6zUtjkVzDxpOSmy80cLzO1mjg5QnxRn8yMuMLQW+V4FiNM7gyMOPN7Gi2aw3BON5s
         9ujoLFyT5T/duAP3D/hlk3A7Zx1JHt029Y+z3RRJ8/JsOCcQN/Avmg2LqMr214F1q9dJ
         P7ow==
X-Gm-Message-State: APjAAAWw3NYOXUlBP+/zW0t/pdQgByKrp4DdigxTXL/0PVsVaQ8B9GQ+
        IXKWqJV1tiCUkDdlH9FaZyaBC+GVN4I=
X-Google-Smtp-Source: APXvYqz/DecpurtUhC8k3+bJ1+O4CfEW7zJufgQAcNdaJqqoZoiTHD9pN4l61FuRVj6NehlW8m6jOQ==
X-Received: by 2002:a19:d602:: with SMTP id n2mr248869lfg.165.1551373127787;
        Thu, 28 Feb 2019 08:58:47 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v7sm4153076ljk.7.2019.02.28.08.58.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 08:58:46 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id z20so17761851ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:58:46 -0800 (PST)
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr5420481ljc.22.1551373125983;
 Thu, 28 Feb 2019 08:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20190228153437.GI8481@kroah.com>
In-Reply-To: <20190228153437.GI8481@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Feb 2019 08:58:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgs59YJY+OPEPoORU-osNDyOsPo1bbJ8=14=ZTNHn11OA@mail.gmail.com>
Message-ID: <CAHk-=wgs59YJY+OPEPoORU-osNDyOsPo1bbJ8=14=ZTNHn11OA@mail.gmail.com>
Subject: Re: [PATCH] kvm: properly check debugfs dentry before using it
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        syzbot <syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 7:34 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Linus, this should go in before 5.0-final is out, as it resolves a
> problem found by syzbot.  Paolo has given his ack for me to send this
> directly to you.  If you want this in [GIT PULL] format, I can do that
> as well.

Applied, thanks,

           Linus
