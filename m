Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524ADC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BCB2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560200893;
	bh=LM4DhDahgDAdAIFCtYW8OBEeB5PeHsxWNvc/AFAGCfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mkg5bxehXtZvGMF5x0TobeHLdYLHWFJeqlAIWNzFXnTmUxmtf/KpV588JtzuezQae
	 p1PtPLv5CLXUd+Jk+3oQb7npQUrjHxQSIKEfz9yAIuArJ5oPlRZ/qVAk+tXHdHSyRS
	 /Xu3xNrnzTiBLeoYSu72pT1g8LkKrO+zDmxzfEio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbfFJVIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388642AbfFJVIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:08:12 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E2F22146E;
        Mon, 10 Jun 2019 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560200891;
        bh=LM4DhDahgDAdAIFCtYW8OBEeB5PeHsxWNvc/AFAGCfs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d/rNQR6pc7zQZH7+kgZM44zJLfnwtuBP1iONB9bdfZmnqqX4J6XF2Ss7nayt+Y/8P
         2W8pkvQ6kan8YpRUYt3ppUluY7kjN5ya/enUvx5adykYpjBiFmNdx/T7ChtGg+BT13
         xC1nudL8AEwyCLs57Bz1EeYXtoTKn/IFTVVYg9fM=
Received: by mail-qt1-f169.google.com with SMTP id p15so4628609qtl.3;
        Mon, 10 Jun 2019 14:08:11 -0700 (PDT)
X-Gm-Message-State: APjAAAU1rfCstL+6o0d6Snp20I9L+DPQ6Ic6IsocDJh3ImNAF9H7dIWJ
        ZNksyzaIQRWX3uJQiX6Nz4puihKO2BgCvNH4ZA==
X-Google-Smtp-Source: APXvYqwz/L1AgE45vjVGdFYDHPRFSfJzFEJO+IgYWTlh/1Y7CMKQaGOwIO8zOyf+9q46atFDDdRncexYa0hsFQNqGrE=
X-Received: by 2002:a0c:acef:: with SMTP id n44mr1253179qvc.39.1560200890657;
 Mon, 10 Jun 2019 14:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190604003218.241354-1-saravanak@google.com> <20190604003218.241354-2-saravanak@google.com>
 <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com> <CAGETcx_Kb3+fFYHhBUdVbCSNTk4v5j1Ket=Et2ZQY0SHUgLLMw@mail.gmail.com>
In-Reply-To: <CAGETcx_Kb3+fFYHhBUdVbCSNTk4v5j1Ket=Et2ZQY0SHUgLLMw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Jun 2019 15:07:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKDa7Nin8bU_LV-hqjJe2RNQwKA_zsKoug8=eHmX78QZQ@mail.gmail.com>
Message-ID: <CAL_JsqKDa7Nin8bU_LV-hqjJe2RNQwKA_zsKoug8=eHmX78QZQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/5] of/platform: Speed up of_find_device_by_node()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 1:15 PM Saravana Kannan <saravanak@google.com> wrote:
>
> I did. And I didn't get a response. Folks suggested this might be one of the preferred ways instead of sending "bump" emails.

It's summer time and people go on vacation.

Rob
