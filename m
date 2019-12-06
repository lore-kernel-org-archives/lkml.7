Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCC9C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E4421835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGU0ooDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfLFOr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:47:26 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:45482 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:47:25 -0500
Received: by mail-io1-f50.google.com with SMTP id i11so7531398ioi.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 06:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8dmGDjY8zlKrh0dUHiG+EMC25Wcsnu9umFnGNvxqvE=;
        b=OGU0ooDH33ZqSOL8qOxATV6dbBakoiYEvltcT6Ke9E86QTK7SQPSuWULTQaCg9gskw
         T/LMfN7e4mNcoF3CbSy8TiCDmhRQKJIKER6ZQqB/sYWgTPrbEUoi71oaPnF62TYdCvVu
         sFnmyr/rj/E2MBKrElj6VUJU5y+3jtflqZqxpouZkl5AbPPVEXoxE6qzTViZoaUvJbwn
         Ii76WHj8rPuj8IiO62VfGFm8GkckFmWcpt4fklnNlhoQryYb+9uPdNo88Eob9mttTaTo
         Xh/EYFlpe2rOoVm+aYeLqLUB8R+fB+09QAH/dMaQxxcJSdukpeo8RsXhedT7MLK6gm2E
         FzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8dmGDjY8zlKrh0dUHiG+EMC25Wcsnu9umFnGNvxqvE=;
        b=EaSVhnC+wKbV0o7ycdQEewNDDH80V4bSXtLezeneL6BWDqz6bKnV8Bj+dIXxrHX44h
         Wfk9B5pA7zJb1Ix7r5/jbEujuGiiepQjDmqzVv9anflfDJkHf7CvSA+4k6K3FMLKf78C
         s0CiAHkkouzwpjkreqd8nVMjCPOpwv1PP9CzFWkH64YX/k/CBz2Gzt9ILEg0LlNr59h+
         v1zc7NgwUlHA2w2LHfRT3ceVGFXrgBfccoBVB1tSAmPTYPeCRSKxfJcKSPXKrVIW8Tc9
         ugTx1rkewxkLeT+M6bwp9J4N+NJIpj+v7juBuDdluKFjpQIqtoaFl9JdOicbp9OlXsMr
         mEpw==
X-Gm-Message-State: APjAAAVmi/g/Km9Rm2cQoKpyvRwEPb8Awi0um1xyz+MvowlxijRHiswD
        q1zaBT6VXnZr2S3r1cwAuwne+OWz7tCGPKHEm24=
X-Google-Smtp-Source: APXvYqyfVYH/arYTNfc6hTbPuF/b5zVeGAvOyPuem9xXdd/rjCfnjSKepyBZPyWsQQrfJcOfIOBkPXMBXRHA/qOMpmY=
X-Received: by 2002:a02:8587:: with SMTP id d7mr13858101jai.39.1575643644859;
 Fri, 06 Dec 2019 06:47:24 -0800 (PST)
MIME-Version: 1.0
References: <8eeee0695c664305ba6a56bce42a995f@AcuMS.aculab.com>
In-Reply-To: <8eeee0695c664305ba6a56bce42a995f@AcuMS.aculab.com>
From:   Alexey Klimov <klimov.linux@gmail.com>
Date:   Fri, 6 Dec 2019 14:47:13 +0000
Message-ID: <CALW4P++GCR9Vha8Ef25rAmPZWNDxXxqebH+Vw1WXyLm9NZ+3pQ@mail.gmail.com>
Subject: Re: Running an Ivy Bridge cpu at fixed frequency
To:     David Laight <David.Laight@aculab.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 5:32 PM David Laight <David.Laight@aculab.com> wrote:
>
> Is there any way to persuade the intel_pstate driver to make an Ivy bridge (i7-3770)
> cpu run at a fixed frequency?
> It is really difficult to compare code execution times when the cpu clock speed
> keeps changing.
> I thought I'd managed by setting the 'scaling_max_freq' to 1.7GHz, but even that
> doesn't seem to be working now.
> It would also be nice to run a little faster than that - but without it 'randomly'
> going to 'turbo' frequencies (which it is doing even after I've set no_turbo to 1).
>
> An alternative would be a variable frequency TSC - might give more consistent values.

Have you tried intel_pstate=passive parameter in cmdline?
You'll be able to fix the frequency using governors or sysfs.
Not sure that this is what you're looking for. I personally also don't
know that 'passive' mode will work on Ivy Bridge.

Best regards,
Alexey
