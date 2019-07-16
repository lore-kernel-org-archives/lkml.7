Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EB0C76191
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFAC20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563247587;
	bh=Ow3ZgG8IXtbwtYJNy7neRr3Px1N1xh+UII1VPR6kWwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Dt5OIJ27HEjiOJLhJjQ2kC0d5rNQU7mybf0Qb8Xlqh62HYVLrbnQbbqgBzHxk6xBm
	 aQ5ZVADf+pGU+zmVJe64UJGYk0tfeMpOxaEl4sNEbpUiCyS39zRi01jwo25fak05fg
	 Y6rvqlYkafU2psh0tLrfRodZmEKUM9q0Hzkw/vek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfGPD00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 23:26:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37573 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfGPD0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:26:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so18430101ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 20:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x80Alcq+QWuLA12EET8W+QOr+ifK8yYftwPVmUXZyEw=;
        b=If6JTvulUIfgG0o9lo8LdCq86Obd5Tc6qQ3JZQyrL0sbGexsSMgRgXtYnJCoahiTLH
         VME81xwsA3kye1hahtF+bUNVh8vXPfLtM33Knh401XFpoyd2z8h4pm8bWQS9XXtdG1KD
         CmGRRXzKYcbI7+Ko1K9kF/IY4QFJ4tZpDQekc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x80Alcq+QWuLA12EET8W+QOr+ifK8yYftwPVmUXZyEw=;
        b=M788kVXTxWC7ZE15DJPUBPNQ7M9CVfUHXrT6as2wGERGd2b8iwQBk3PQeTyCl+t5v5
         98ONeiv/11O/PDa+5iLNt6TUFHpq/QPRcLjo0DrVy0vcttlS/cRBduSxHYpzDlZ9ImyG
         ZeTmHhDFmJDzaQw4ms+Aui8rVhTVLgOOUl3TGf5bt70a6wu7WcXnUwbk5ScTsT+MXbHk
         hVSs7GaSFklFFtqCV7GmK0YteOPsZ+Egrd2+bHujGITyWYzk/RiZgv+XZTar2bTvuQ2L
         /5SVlKxLnkNfPLqaeGosWvfJHuqfYlrVFUj3XyRMt8oehmJwqCJH//xyeGwC4RwEuTVR
         2DfQ==
X-Gm-Message-State: APjAAAWN90zD7MAmRp1Tt6FddgsLaR1JqV5zOPYtYCtZ/zwZTFirwcrf
        rHJnxFEyGyPPa4uebb2wSnMQw76dPUQ=
X-Google-Smtp-Source: APXvYqwPf9DWbX7ETFUWaXEN2LeZBV95y/3FE2CPYzShkNZ7zmMkURVjDQK1DnUmbPC0MgBQLkS/IA==
X-Received: by 2002:a2e:9ac6:: with SMTP id p6mr16471584ljj.100.1563247583385;
        Mon, 15 Jul 2019 20:26:23 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 11sm3446567ljc.66.2019.07.15.20.26.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 20:26:22 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c19so12524231lfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 20:26:22 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr13293723lft.79.1563247581800;
 Mon, 15 Jul 2019 20:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190715080009.GD4401@dell>
In-Reply-To: <20190715080009.GD4401@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jul 2019 20:26:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhEUNpOoT-M-J-8vEdj9X3a=vGn-sZk9OwLoi_9k7-ZA@mail.gmail.com>
Message-ID: <CAHk-=whhEUNpOoT-M-J-8vEdj9X3a=vGn-sZk9OwLoi_9k7-ZA@mail.gmail.com>
Subject: Re: [GIT PULL] Backlight for v5.3
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 1:00 AM Lee Jones <lee.jones@linaro.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.3

Hmm. No such ref exists.

I can see the "backlight-next" branch which has the right commit SHA1,
but you normally do a signed tag, and I'd much rather merge a signed
tag than a bare branch for linux-next.

Did you perhaps forget to push it out?

              Linus
