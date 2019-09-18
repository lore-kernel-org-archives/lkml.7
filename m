Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6725CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A61421BE5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568837083;
	bh=58Vbl32jZ4eSQW/1RRLOdlT0n13czx5Srl1EcQRyO/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gB70FYePIiSpdp2Rm6kiAKyHu1AtWZgVsgFdpOzX1InTxBXEaF03AvLkilfo4Kdex
	 jbSrJZCMAXcidd6GW0IGxnPGQ4j9RYwmiFxLsVQ7QQ8aSVG6JGqMwhzOYZx4X2URw0
	 8EPMPkQkH8BwB2In2qNA9I5X5ygk24gLIKmElw9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389956AbfIRUEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:04:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38076 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389938AbfIRUEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:04:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so590228lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01Y6x1zvemzBJQWLxE4DBoZbhxORfd/lyc86dODNTds=;
        b=TgS0uVH24w0R1Fkx0c26UZGHv0NIDmFwVNEVRMK1sKN+11sFoguy/eWP2GRt5ktatK
         UA1N2CCdZVRk0AzXAIkyAiGcU+CQMl7qwnLRwXX/dvh+2CuQv3QJ6XM8shRLCQNTFIMt
         V4BgdJc75+s4V8iriJV0BM7ZT7q18LRacAIfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01Y6x1zvemzBJQWLxE4DBoZbhxORfd/lyc86dODNTds=;
        b=TrO2kb2t4KHGlnrGFtuQcdm3tsCuo2gEjTJeLFrtJJurDT4lT0muL4BmkFhDepJuiR
         FD26WfWVeI7jbWvvnAkDQeJAnrX233XXsPRwhN7VCG8OB0dG8RskudTEQZHmQy08OLSY
         2pz/kuB/pKyKPFbPSz7ScfBBnG3MrpXx+kUDeRme1IezDicob7iQwc8c+be/VyXuorPM
         dXQZOitcodTP7UmduUy/ecZhov3F4+DF6hjASC6pJmw6zNerrtvcNLwQF4EQZONvkJfR
         7mnCRSwwp/hGnIsfeQBm/ql7E49n3vWfqpSKLmAwFmme7dL85UhCWMmLW97/mXgvsIq7
         /2Fw==
X-Gm-Message-State: APjAAAVkUz03EIrVGj+lx2mAojoJJZV0oBQw/hAAxbvCP5h2kqKqk+1R
        m/mftct3jI2VFVmEdN9AkJYuCzuWU50=
X-Google-Smtp-Source: APXvYqzVnPE1CNTIL7ElI4wzvrlV7kCFzomqH38kLXJiLArMwMLaXj46Fi23+8qb9+HXHlE6yOjb/g==
X-Received: by 2002:ac2:558e:: with SMTP id v14mr2934741lfg.161.1568837078907;
        Wed, 18 Sep 2019 13:04:38 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id i17sm1194745ljd.2.2019.09.18.13.04.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 13:04:37 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 7so1186674ljw.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:04:37 -0700 (PDT)
X-Received: by 2002:a2e:8943:: with SMTP id b3mr3228332ljk.165.1568837077303;
 Wed, 18 Sep 2019 13:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190917013548.GD1131@ZenIV.linux.org.uk>
In-Reply-To: <20190917013548.GD1131@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 13:04:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKEdDnCBE40D-S=ZdekJjhU_WJAjnXq3LCGZLgE5SU_w@mail.gmail.com>
Message-ID: <CAHk-=wgKEdDnCBE40D-S=ZdekJjhU_WJAjnXq3LCGZLgE5SU_w@mail.gmail.com>
Subject: Re: [git pull] vfs.git #work.namei
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 6:35 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         pathwalk-related stuff

That could have done with a few more words of explanation.

I added "Audit-related cleanups, misc simplifications, and easier to
follow nd->root refcounts"

            Linus
