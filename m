Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC2C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A56207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqc1l/3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbfFJH04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:26:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37201 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387541AbfFJH04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:26:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id 20so4557362pgr.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 00:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=daFxAMryc0skAl9XtVIwXmNQD/X9Q30Ey2kxgBive84=;
        b=Dqc1l/3r07Dlb2xjooJOtEAGLplKK23A8/eyDg4VAEqZgsP+01f5Cr4w+9z9eEe7qt
         2biIKGF3iAf24r5XEXkdEaygP/wEARYoEvHp1P7ukQ9LZV64gt6iO28UpjH+Rg4EBjs1
         xAyItWOi/v9DQVk1xalnJ8wUicxrdx4bERuxtP3fAlHpDa51qugN3CZdFcDWuNbD7xMG
         dljZtJU8cwvVz07FDENnJKauePx/fKCw80YBYFzteThhIVwyD9hM38iI2H0vYMEBFDeO
         zVvpY4SPpR+zuPcp6XeCQKnecgzVEG/YcoUDJebTRDYUu9QvbFg75MBf4xaew/A/bXFc
         MtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=daFxAMryc0skAl9XtVIwXmNQD/X9Q30Ey2kxgBive84=;
        b=AZFIGZSw7DgS9H9+6jupGGEbVvUeN6zM4FciFBQHCzA8tHpWW/KIq0MFxPJTYotwki
         fkFPOArNys9SpG4dVtG7GAGVDreY479XRJiwjuxuOKSUyvpo42TOc5qtnh9WctSlehma
         ef9iZJ9BZF5Y/5821F2k6lEG5Tf6wfgq/1YwPYukv52rAUOC7ReoTl/KxLJXLlZiNlRa
         6PleSc7yUkYDGh7BEAQ+VYrRYUiboL05+iqEbDKlDdtxUBAZkvjsT3Pqntc+uI+5xfo6
         mbMfmh2hGp4MbAZqMztKhLuyCw8TjBXrEVtlqeZS+amu1sSp1ZlBlUOJWDo7MjpIdfi6
         wjZg==
X-Gm-Message-State: APjAAAUjaJTGpv/weyLtI+zHHQV8JejnsVYtnl2hubIsbP3hfh2Bpkwo
        x3s8bGQvKLk3/DVCKHkgLVKUizoh
X-Google-Smtp-Source: APXvYqzKarQ+sze16KTV8Mm4YgzPTsOOLpx7rbSHrAC0nBsm5iePvKRCIcZuLzUi7v85R8KxXuaQLQ==
X-Received: by 2002:a65:4b88:: with SMTP id t8mr14950808pgq.374.1560151615468;
        Mon, 10 Jun 2019 00:26:55 -0700 (PDT)
Received: from localhost (60-241-56-246.tpgi.com.au. [60.241.56.246])
        by smtp.gmail.com with ESMTPSA id a12sm11252494pgq.0.2019.06.10.00.26.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 00:26:54 -0700 (PDT)
Date:   Mon, 10 Jun 2019 17:24:32 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kernel/isolation: Asset that a housekeeping CPU comes up
 at boot time
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190601113919.2678-1-npiggin@gmail.com>
In-Reply-To: <20190601113919.2678-1-npiggin@gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1560151344.y4aukciain.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Piggin's on June 1, 2019 9:39 pm:
> With the change to allow the boot CPU0 to be isolated, it is possible
> to specify command line options that result in no housekeeping CPU
> online at boot.
>=20
> An 8 CPU system booted with "nohz_full=3D0-6 maxcpus=3D4", for example.
>=20
> It is not easily possible at housekeeping init time to know all the
> various SMP options that will result in an invalid configuration, so
> this patch adds a sanity check after SMP init, to ensure that a
> housekeeping CPU has been onlined.
>=20
> The panic is undesirable, but it's better than the alternative of an
> obscure non deterministic failure. The panic will reliably happen
> when advanced parameters are used incorrectly.

Ping on this one? This should resolve Frederic's remaining objection
to the series (at least until he solves it more generally).

As the series has already been merged, should we get this upstream
before release?

Thanks,
Nick
=
