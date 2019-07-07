Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B8DC48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FFD20656
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562523484;
	bh=HjSAhflXRX6JZgaHJCzpgk15as9iX7HtiQHPV/B7bo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ylXXTK34K/EXftxofbjEA39peCeomHlvb3RAKANqU+JIGT3Gi0oxZmfdkJspYghwK
	 22ro8mu24ZeRS6fOVQj3Se6Ph5BURAnDgAf7C0jCTaLyBWMA1Fqo0xItgdLdGVjMET
	 OkI58dao00MQ/R3kzHe5xTTBACz6WITarTYnuOGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfGGSR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 14:17:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33094 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfGGSR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 14:17:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so3431927lfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+9xPEL4RcxWbS8pngACDkwDo5/o0bCMWSPJIM1PpL0=;
        b=Mji9nC1YQ4CkdxJ68Sku65DwPBgz614OGcbe4AQER95eB2Z7+MbkdAY6AdoyOqPJn2
         lTKTEmiq7RFz1r76n20LVot49Cr4THf3WwVULOqWZBiL/Epg3kjU8UHR98Fdtf6AOPXQ
         3k5CdpKaifYv9EtHB+G4RWjzor3GISTPwyS3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+9xPEL4RcxWbS8pngACDkwDo5/o0bCMWSPJIM1PpL0=;
        b=fwhggheqFCXxAUEh1hL4NyHl6i4tFpQP+7hRkUly4utTsov8oNjr22/0ZjFMUZLTf3
         Wq1qiWRfauBZIY/6zTqU5sy3OuM7UD0BpuGo1DyLQApiuB9+tDAeve85kI6vR+E/aqDS
         uC1Zpg3n+q7pr6tnfXti43yFMfBOpKy+UUUehzgT7c5pQ9rC6sRO7JPoWR4yTa8bq0V0
         MVky2SpYjAAIFSP04iUgsY+dACqsyHXubIX+SEYHWD4HK9Io0rcoXVqFAIwsp3EW45Ck
         UDJizoRy8Yz5QFSsdIXcFcXKjpYc2OakNeTFaWmoUW8imLDnfWifAYOdMB3Jwqs0gHvh
         /2vQ==
X-Gm-Message-State: APjAAAUhQY2YkzqbcSKJ0mO6bkwtAF258WLQIykqJLWpovcVx993oVeS
        bSws2sBeBNpIIE5NDC3RTh40GvkOcC0=
X-Google-Smtp-Source: APXvYqwFGnfemKTqIw0O/0zPLt6CugHJ6r4lit9zyXUvElGlt6R30sJKEJ1PaJpp/fzWf1Xo6vatEw==
X-Received: by 2002:ac2:5b09:: with SMTP id v9mr6589822lfn.22.1562523446874;
        Sun, 07 Jul 2019 11:17:26 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id u13sm2330157lfi.4.2019.07.07.11.17.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 11:17:25 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 16so13632802ljv.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 11:17:25 -0700 (PDT)
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr8008295ljm.180.1562523445204;
 Sun, 07 Jul 2019 11:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.534802824@infradead.org>
 <CALCETrXvTvFBaQB-kEe4cRTCXUyTbWLbcveWsH-kX4j915c_=w@mail.gmail.com> <CALCETrUzP4Wb=WNhGvc7k4oX7QQz1JXZ3-O8PQhs39kmZid0nw@mail.gmail.com>
In-Reply-To: <CALCETrUzP4Wb=WNhGvc7k4oX7QQz1JXZ3-O8PQhs39kmZid0nw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Jul 2019 11:17:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+J7ts6OrzzscMj5FONd3TRAwAKPZ=BQmEb2E8_-RXTA@mail.gmail.com>
Message-ID: <CAHk-=wh+J7ts6OrzzscMj5FONd3TRAwAKPZ=BQmEb2E8_-RXTA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 7, 2019 at 8:11 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> FWIW, I'm leaning toward suggesting that we apply the trivial tracing
> fix and backport *that*.  Then, in -tip, we could revert it and apply
> this patch instead.

You don't have to have the same fix in stable as in -tip.

It's fine to send something to stable that says "Fixed differently by
commit XYZ upstream". The main thing is to make sure that stable
doesn't have fixes that then get lost upstream (which we used to have
long long ago).

                  Linus
