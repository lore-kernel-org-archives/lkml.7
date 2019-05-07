Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCECC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0C221479
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557217694;
	bh=3bYekOg5chMAE9u92AGpHNwO30W4q703j1p2RVq9G04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XpTxoMrpSilgugHcsPZ+TozkGbMdFJVVZCQeF2JO6tLTArsTGOt2daWn+h5xQJqqe
	 QQtbSQsf9+xfqal+CyAKaCcV8u7k/CO8sMo+EXdhAAZXe3SYbR9kTiJLYNlpKfKbUy
	 RbvzGmDXbIMgilv2pPkKz8iY23l6VV9i6llStwUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfEGI2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:28:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53911 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfEGI2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:28:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so1397437wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I9/t0l8esd3uIHHniKsPDoKMHi99dvvKOn/depEA9Ww=;
        b=c4OTbmYaxzuUH/XWCIErjasNeZRc0g3+mpMItTTezim4HBjklHevkqyM/j2/sdjSfs
         iecV47xXgCguoneQaSYLTU1GQLgg3ZY/+CGxg55c/o6jyUgJjV3Cu9f7eyyE2XYa1hLU
         Gzt2Fc78fhJqj/V/ZcNVlqbZIwXGWT5yL6yxLmFqRFyOqoBp692i+gL1zaLMpCQbzyQh
         572QYMRF6OsGgVQM78ZvDRZRsG0O8JQo4CsfC+uydqPiN6YhLFakGRA1WBJXt8W36Bbw
         ORvh8bE0jH+lMYRsNIXMaPAZxaWPw8wZ++Epo/SWtMX3fvJz1A5z40NA8f16U8sAR2l1
         IBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I9/t0l8esd3uIHHniKsPDoKMHi99dvvKOn/depEA9Ww=;
        b=DqoPN4e3AxyLfYm6sjOtZxN0JBH+quoN86efJ8s+ixEP6Gp1tqCyXifOHVgk5NoGCK
         ZTet+/z3uVxxgNPGzRVjUFHdOxg3DTB6vcDRzZwQXi8BL9LQa8vn+Ppk4njncmIjZeUh
         dWz1kVSqVtDFZ3lG7KSyw1mtSCyP6Yzyveo+Im6rvNbNNEgE6ya19OAxaWJP5AVAuJgV
         yfvXez5rWmU2oOlbnmse54nLvOpRPAOKvs91K3E+cgt5IfnOE6/prGaxANoUoKzQiVrN
         Gq4DcZGKLeN0gB+mqdqaRQFzCHixBzFPRCv42Rx1bQ477HpPOaOjtdpSpysN9dw6nUh1
         NYLQ==
X-Gm-Message-State: APjAAAVoxBtDWqWNnkBKHJYtREy7bxerojnOL8SqWX8n+dWNTYtej3Zf
        iBnnM43VyLZaDp8VXHHH4gM=
X-Google-Smtp-Source: APXvYqy3SGSmi8lBio88aqgpwuD4kF4r1j/oihsGcjKqU7lNMpy7GZk83SDcRJ2H+zzXZtXGH7KVew==
X-Received: by 2002:a1c:f119:: with SMTP id p25mr19613663wmh.4.1557217691590;
        Tue, 07 May 2019 01:28:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i9sm10536330wmb.4.2019.05.07.01.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 01:28:10 -0700 (PDT)
Date:   Tue, 7 May 2019 10:28:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot: move early_serial_base to .data section
Message-ID: <20190507082808.GB125993@gmail.com>
References: <1557208860-12846-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557208860-12846-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Pingfan Liu <kernelfans@gmail.com> wrote:

> arch/x86/boot/compressed/head_64.S clears BSS after relocated. If early
> serial is set up before clearing BSS, the early_serial_base will be reset
> to 0.
> 
> Initializing early_serial_base as -1 to push it to .data section.

I'm wondering whether it's wise to clear the BSS after relocation to 
begin with. It already gets cleared once, and an implicit zeroing of all 
fields on kernel relocation sounds dubious to me.

Is there a strong reason for that? I.e. is there some uninitialized or 
otherwise important-to-clear data there?

Thanks,

	Ingo
