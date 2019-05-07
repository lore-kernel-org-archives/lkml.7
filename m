Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1864C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5427205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557241744;
	bh=EIFN8ckD0b8JYpucWkGQfx1sKmO8N4bpSldapMe3L3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ix8+QDfCp04PYe2M72KxazXWudAn1KpgrX6hS4F6rxe5Oo2LWPIWE4mfxXA1FlGne
	 dGCtQamUkBBIQOSs6fk/XMK/PJTlMASBB1KKDN+A1Kmq8I5dUPVxoqkjfQYZl23uyg
	 yaOi6hQza436I5WJrDtzMJN7Gj/YZtOxR0643fIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfEGPJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:09:03 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35614 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfEGPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:09:02 -0400
Received: by mail-it1-f194.google.com with SMTP id l140so26297658itb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMKxSMzwu+s2/SzB62Nh+x3vxif2iOJIy/DFOJy1IA0=;
        b=JttxCubqoLk3AhCSATJ1dG2YMRqkDdBeMD1EsHQl6xUaQs1B71zOLKZ5cMzviHJKwW
         TC/VBGHn1zLbnhTXdleyXucuXKeSTCELa5Q075xnaoCzKzXwWJR0FGxa4EWQs/NBOs/P
         8bgs9hxAdu1KMzEdD0Vh1GrRaWkc/Ekt5c7E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMKxSMzwu+s2/SzB62Nh+x3vxif2iOJIy/DFOJy1IA0=;
        b=E/S8/EZF/Z8R73R8fUQosbO4mAT+NG8MgOR2kczieshe2vBewSzm+lspDJIObWPZbY
         6Of2etDnsfUPyam21LNgqd2zEwbdGNo+kzusi1FmLOuTvla5bkgCcadrG3ns5fWmyN2z
         bJi/A6LPEcKWU/Eu2emLdEOP3FxIUB09HUjwiTOAcrS6fkFPnq36ZbMl0ShCD+f6UxsL
         es5N/S96+HzVhw7v7Oo/JJJSBx4pmW22/PqRmU8fceedYXGgc5YZ7EGjQamuCPiCWlV/
         7+TQJhupFghg64ZZycwNAH3Jm4ScukK4Ly+4DfV6YR3SByJZcRfcX6m0s4iL5FN8Swuw
         ujlw==
X-Gm-Message-State: APjAAAVpIpt+Y2TEGrTfVJlOUiPDloX09piEL8cY22ZeZaN5w9kfUlLN
        BcGCPwbpk+pEj6M0RPuoRT1SnX0DrS4Wl79KxOz9kQ==
X-Google-Smtp-Source: APXvYqxzxPAnUM9yMUPw0bSHqeGRGlrlpk4UlIXm0lTx42L8iYNvI597rZp60jpeX4QnxGdyIAI5VtNkTfFYR51QJ3A=
X-Received: by 2002:a24:9183:: with SMTP id i125mr21968894ite.105.1557241741389;
 Tue, 07 May 2019 08:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143301.GU14916@sirena.org.uk>
In-Reply-To: <20190506143301.GU14916@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 08:08:50 -0700
Message-ID: <CAADWXX_k_D7=SPd=bi-=3EtBjeG6fe0EaTb4U4ZZgoOoRSub-Q@mail.gmail.com>
Subject: Re: [GIT PULL] spi updates for v5.2
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 7:33 AM Mark Brown <broonie@kernel.org> wrote:
>
> spi: Updates for v5.2

Hmm. Please be more careful. Commit 1dfbf334f123 ("spi: ep93xx:
Convert to use CS GPIO descriptors") caused a new warning because it
removed a "for ()" loop, but left the now unused variable 'i' around.

I fixed it up in the merge, because I hate warnings that may hide real
problems. But I also expect maintainers to check their warnings,
exactly because the normal build is supposed to have none. So a new
warning does stand out.

                    Linus
