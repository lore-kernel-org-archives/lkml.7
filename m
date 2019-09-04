Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53123C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261DB20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567637195;
	bh=QXa9FOQlcR93VFXaVslVmY1z8aHwwfqAQ50pNLg6CsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=n/FNWwU2l6FlQuhBD4QW2oyc1Efz0AS+ChpA/yN7oJbRPJNFJyLhNnhNIMNrDHx9H
	 qfNU0zp9KjQky1QFIIlG5UEJJ0ZiVGGzOwGpGZEQz+LpFXmAWUYFjmSqFl/8Bdyx1e
	 FezOXXPLBOtH76wzC+sHP3sXeI/WJNRGya6Fgsgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfIDWqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:46:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41412 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIDWqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 18:46:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id a4so338134ljk.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFDhCyHzhyiLnyceYcteUHqOXGgh38Kg6TIOg9RDlV8=;
        b=GnnwuO2FC8JvRpMBdQIyMOw63KWp0i8RWU7BAf9vhwmdfauk+kGPRrhGsnlnlPAmBt
         Cx6hzCIVK4L+kzxznEGXiVTPGueSaoLKTwELcbVCO2oVI6bZuWttjzsqT9tZPNkgY/TA
         7QyH0CjS5KTQcx4hIjs9o8ztIuxjlBT486QSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFDhCyHzhyiLnyceYcteUHqOXGgh38Kg6TIOg9RDlV8=;
        b=EeoK4rw/UsBxpj3q50vh7kmH8jkHabTEIW/jK1liPEmo1Vl19qBR1rmZWFxg+pD7Wi
         FQZUZHuFdDPicsINGV0+qGvra+UdpopMS+RVr2N7TC+Fz4JVP3XOzir+AZYseVAs9gvk
         w/l6ep/x0Jf5O+UGJvXNt03z9vIZUHaPpX1HMQ/PBEy89vAsO4/s0ySOp3f8tKZFfgWX
         djV2pGtvBn8ndmQrXRMY96htnMp3D5Knu9ypUQ1T0jSTKP+Vn3uNUsCmkQKe2cYW3t2i
         FDNZlKeGRexaB58TFS0Mp/UqySWEkbsFO/6FlbcpXvHDRH3BMu4i5rKdfuoNX+pQbTfB
         gC4w==
X-Gm-Message-State: APjAAAUZg9LcOLqsNvd4968rGKdGbhB2sFguh44amyTbzbphcfDuPoWS
        Y88zj5kKW8VLnWwVYsUTNALLD6LK9Qs=
X-Google-Smtp-Source: APXvYqyrCxx0DFMDkIzNQH+/2HhBiaLSuyaL7wZsogJXJTkxFk/vIsJjLVWLl7UPp55ThiWMLSkkEg==
X-Received: by 2002:a2e:2953:: with SMTP id u80mr10998lje.233.1567637191650;
        Wed, 04 Sep 2019 15:46:31 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b205sm48517lfg.72.2019.09.04.15.46.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 15:46:31 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id x18so377772ljh.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 15:46:31 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr24885ljg.72.1567636715921;
 Wed, 04 Sep 2019 15:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-11-cyphar@cyphar.com>
 <CAHk-=wiod1rQMU+6Zew=cLE8uX4tUdf42bM5eKngMnNVS2My7g@mail.gmail.com>
 <20190904214856.vnvom7h5xontvngq@yavin.dot.cyphar.com> <CAHk-=wgcJq21Hydh7Tx5-o8empoPp7ULDBw0Am-du_Pa+fcftQ@mail.gmail.com>
 <20592.1567636276@warthog.procyon.org.uk>
In-Reply-To: <20592.1567636276@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Sep 2019 15:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7Wq1kj8kZ+SSpfU_o991woW60NWca9yBA2ccs2eNx8Q@mail.gmail.com>
Message-ID: <CAHk-=wg7Wq1kj8kZ+SSpfU_o991woW60NWca9yBA2ccs2eNx8Q@mail.gmail.com>
Subject: Re: [PATCH v12 10/12] namei: aggressively check for nd->root escape
 on ".." resolution
To:     David Howells <dhowells@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 3:31 PM David Howells <dhowells@redhat.com> wrote:
>
> It ought to be reasonably easy to make them per-sb at least, I think.  We
> don't allow cross-super rename, right?

Right now the sequence count handling very much depends on it being a
global entity on the reader side, at least.

And while the rename sequence count could (and probably should) be
per-sb, the same is very much not true of the mount one.

So the rename seqcount is likely easier to fix than the mount one, but
neither of them are entirely trivial, afaik.

               Linus
