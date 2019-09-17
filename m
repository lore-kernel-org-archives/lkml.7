Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2641CC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80DE20678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568682380;
	bh=+W2xNDy0Vbt8Lksh920WgCCAU4Gd2hGQK1PfRhxFWPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1DGNcZjcg2yyU+uXJxS1wAZS5KJeRDt/kxGJzyEkxckExvC9fo1e4ukcanSusi49K
	 zrHTu1l5sUiP7gHrUwfG1EDd4qpLEX9tZrvIfDn0sJD1zkCmZSfQsUA5IQbmq/LRJT
	 RsGE6gpIkt3pu75eMchv7yic3KR4vnAnojU3qKQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390853AbfIQBGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 21:06:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45028 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390818AbfIQBGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:06:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so1662023ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 18:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lT8XkUtBx2w2E6v7+dJIyb5eDtdCj9FGQxpWjTooN2w=;
        b=X3PnxylOAF4xYIhV73JftJsYPExC+6nWRgaCoIehOZ0lRHM8e0vtC4kIiCZ0RfabNQ
         8bMWtZXCNM/jwB6Es3t2aKnvKb1glk5Zq0J4hLHBdUeNxhEvZaoOd3eWC3odXZrrnc7k
         FwH8vqjVTIT59p8Zc+gKYzRmiJqlQqh9ZX6P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lT8XkUtBx2w2E6v7+dJIyb5eDtdCj9FGQxpWjTooN2w=;
        b=Fr6tpR9ayseFojLdomB3lsaLy6X11GvVdoD9l1wNIPck7SbQJOMbhaHKbYh3yjQ9mi
         KZSJCj/+MaBfoOyIhOb1JP4LYh1cdqgME7qDV8Gj+apQAHiy7qF3JccooucNPQpWWa/Q
         TrfTI+0Wv3/AzyRWVcE8ve5wG+kjd3ulq1z/3P6qnw+eHEC4iZ0poidIl+kBgeqcB2hX
         CT7eyoXtfK5sMGVKz068pneb7fvfHhHhxzG+6tT7TVRyaj1zQ/0A128271VX9ejjRSGB
         pAhJDbs+0ki2eqZdLiLxwatX+1CCSX5miQ4LDA0Nx6gqSAm9wOQk7ZUFI5ucmv7ja+ye
         hMxw==
X-Gm-Message-State: APjAAAVJ71xCJkYvAQVlJW5APdj0GT3AVmV77Z3Ulj6qppsyJ93s2pm4
        SVEA5LmUGcc6jNEsTJvWcwyexPxWU1w=
X-Google-Smtp-Source: APXvYqyZenC+bNNOfVR8pY3Qv7WcM+1Ch4Lg2QRN/JQppk9c0X2qht3MBM3364HHAXt8yFf2esaQbA==
X-Received: by 2002:a2e:504f:: with SMTP id v15mr344885ljd.67.1568682376390;
        Mon, 16 Sep 2019 18:06:16 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u26sm87189lfd.19.2019.09.16.18.06.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 18:06:14 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w6so1458347lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 18:06:13 -0700 (PDT)
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr535207lfm.170.1568682373612;
 Mon, 16 Sep 2019 18:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190916042952.GB23719@1wt.eu> <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu> <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu> <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org> <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
 <20190916231103.bic65ab4ifv7vhio@srcf.ucam.org> <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com>
 <20190916232922.GA7880@darwi-home-pc>
In-Reply-To: <20190916232922.GA7880@darwi-home-pc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 18:05:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2PuYtuUVt523j20cTceN+ps8UNJY=uRWQuRaDeDyLQw@mail.gmail.com>
Message-ID: <CAHk-=wh2PuYtuUVt523j20cTceN+ps8UNJY=uRWQuRaDeDyLQw@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 4:29 PM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> Linus, in all honesty, the other case is _not_ a hypothetical .

Oh yes it is.

You're confusing "use" with "breakage".

The _use_ of getrandom(0) for key generation isn't hypothetical.

But the _breakage_ from the suggested patch that makes it time out is.

See the difference?

The thing is, to break, you have to

 (a) do that key generation at boot time

 (b) do it on an idle machine that doesn't have entropy

in order to basically reproduce the current boot-time hang situation
with the broken gdm, except with an actual "generate key".

Then you have to ignore the big warning too.

              Linus
