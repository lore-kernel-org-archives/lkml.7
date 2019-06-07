Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C32C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2154208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559928859;
	bh=H+J+4QKtvTW2yxpURTJzZQGN+tufUIEodhnmV9G2MLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0oKpAvdgyXkS78+SEKXlsAcVcJ/s5p2GMqCKntRxFDOJq8LxMfD2xxoYR3yTOaCVj
	 yjRJjhVYKZ2t4Axs0kk/NOaBGvHe16Bv+P8h2P9zuF4ydMi8DurbjoRoCQS770ysln
	 E7BV7Il7khiWo4BTuTpKYGR6irBdNeEfPmqy64/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbfFGReT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:34:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38589 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfFGReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:34:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id o13so2440390lji.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDszd2CFI3OW/1e1bvXFnO4n3bUDxYw0Z5lveo5bFtM=;
        b=A18JU42XtAV15dZGRojU8O2rYFIJv9SNvmchw52q1y3HbSGV6S2OCobW0ZbPxewBff
         5w3ssEbmBtKUdvoxEzM43CYTt5ZvxwPVbAnRJ5mDObfA4RBG20IkHotLhiSZTMsT/xdt
         RdQy+wLqnEDpU62WKTgcgeQKdi/d1qKVVZkEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDszd2CFI3OW/1e1bvXFnO4n3bUDxYw0Z5lveo5bFtM=;
        b=nqwrUfs1SykW6sy5j4gIH6upf+5SSnubwaiq0Hhdv9Rf8A0OPNxWOeZhsxZVmI7XB2
         Y/hK6uznHpNIEjWqlzdosVw1eDfchRGypki5D8x6VUs7yANqCTVp82Oc5zeew1d+59jL
         dkzNmOF6KLjRZ2ZXGJOUJSoSswXpHYnrIXH2QIfHuqUbBtQTxzwNyV/yzFXW9B/uT42B
         OScG9tyQqtzVk25Pele5A7QC/mULrJ1oS+zoTWfx3gIEb+t0wmTiXWuAywJp2t5DolRM
         BCr0Fe977YJNUv0RQ6CwCOW0JtO6ZL3iWZRi+Aon6VnZUrmbuB0BM7JtNBYuAA1jHMFf
         jCyA==
X-Gm-Message-State: APjAAAWoAO2MSRhRaCDngKhbm7UDAJVLK90Njp0GKlugbdZYH5jrjIq3
        2kNXgG8bi4TjlrPY3Z15OtrVKVvokVY=
X-Google-Smtp-Source: APXvYqydWiTbvECqmdsZlmtRT6SXhsuEGqRGKhIOooK3wQKlQrwDW0Cpob639Mkvh8v+m2p3wKzYgw==
X-Received: by 2002:a2e:8591:: with SMTP id b17mr17729859lji.71.1559928855164;
        Fri, 07 Jun 2019 10:34:15 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r11sm545253ljh.90.2019.06.07.10.34.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 10:34:14 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 16so2425078ljv.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:34:13 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr29337392ljj.147.1559928853596;
 Fri, 07 Jun 2019 10:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190607103122.GA22167@redhat.com> <20190607103154.GA22159@redhat.com>
In-Reply-To: <20190607103154.GA22159@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 10:33:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzU4MmVomodhTVSWnKUxKOBpvhdXgf1_riBtSwZuwMSg@mail.gmail.com>
Message-ID: <CAHk-=wjzU4MmVomodhTVSWnKUxKOBpvhdXgf1_riBtSwZuwMSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] aio: simplify the usage of restore_saved_sigmask_unless()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@aculab.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Wong <e@80x24.org>, linux-aio@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 3:32 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> The only complication is that non-restartable io_getevents() and
> io_getevents_time32() have to translate ERESTARTNOHAND into EINTR.

Are they actually nonrestartable? I think the current EINTR is just a mistake.

               Linus
