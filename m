Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBE9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ABC20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553635789;
	bh=jds8zU+2y9+Vh1zpFGiGbmLNrmavtskm3dCBzmVBpN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FBE+nLyTZhEAd8pz00q9cizkwvprieoREW/cTKLZ9btzRSTznrQCyinseNvTvwaSZ
	 Tx1ohie00n4JueWwI+2ICwaSLyyqhA1fweZn9zru1Bg+O+MoZeoqW3qmUeZ7D7XwO1
	 5wE1f805LTW5lbCsSvnpdRTFPNPfo1mFj+gV5Yaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbfCZV3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:29:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41627 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbfCZV3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:29:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id 10so9797279lfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 14:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TN0Y8jEKvtCNmMXT0mMHeUX7BqKdYgXKkn2KTVoStxw=;
        b=FDQnaQIcre9LEGkYh0XNGdDFzDSnTr6vbY4qFUs4W23EMVDqhJfAB85Nd1q1DYAeEV
         7v+lRpRHQ0AodxDV1OjndQbntRwh+hdQUtiqi6ssH0FaIMznS6wfZbt3PLeroVAsQpLC
         q9SgNJd+D9s3ZwkxS97U/udhZ3U+TGCnozpy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TN0Y8jEKvtCNmMXT0mMHeUX7BqKdYgXKkn2KTVoStxw=;
        b=Vw7c4ixwaqv5oyZxcZLU6B7yDiF4+wEX8zWeOWwqHNpc6GyETCYYqCfYQcnHxKEIpN
         XXYU8C1lUfRdcR82mZzT83twsCVrVYQgCm/SZ+OUCXweHyGNKtjmrfgD8i0riJlaCKWZ
         MBDJg0fBVjnJcipiU6U4sE43tgLsDHfv/AZntNCR5otK5VMd14F56hvwEEM+xNX11PXq
         GJloaSgPZpcpxOtf10pUwK9oxWoVVnqgGlgfzXaVaxcLdKkWHvDmB1NN7ss2uWK5u9yF
         b3x79+ySEhi18uxy+H2jxOAO0ep7j6qS3/3u74YgE5TrUSeISMdzPff3bbhacom4tTzK
         QDDQ==
X-Gm-Message-State: APjAAAWm0kSqjo0ercXuhxct+KdCrlvV8oV6jnToA793C40fn1JBSsh+
        QeVqjKfQa4aVR4jMrlifDR9nq48Z02U=
X-Google-Smtp-Source: APXvYqyz3coC669/i0Cm0ZckFRsi9MOXjanevvNezQU6HSby5lRua690a4YjJLt+64/ejFFMcYR5kQ==
X-Received: by 2002:ac2:519c:: with SMTP id u28mr16282434lfi.20.1553635784965;
        Tue, 26 Mar 2019 14:29:44 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id u2sm4203468lje.74.2019.03.26.14.29.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 14:29:44 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id p14so11518604ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 14:29:43 -0700 (PDT)
X-Received: by 2002:a2e:960b:: with SMTP id v11mr7784196ljh.135.1553635783519;
 Tue, 26 Mar 2019 14:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190326124143.521905652@goodmis.org> <CAHk-=wiw+vH-LwFRv910FhojCHUDjwUJ4pNWVJkAiP=deyyG3Q@mail.gmail.com>
 <20190326144825.7b359641@gandalf.local.home>
In-Reply-To: <20190326144825.7b359641@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Mar 2019 14:29:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5_Hu4W5tz05vmC3eBH3_h7_uJKEMwLM+MvsJ=znWtbw@mail.gmail.com>
Message-ID: <CAHk-=wg5_Hu4W5tz05vmC3eBH3_h7_uJKEMwLM+MvsJ=znWtbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] [GIT PULL] tracing: Minor fixes for 5.1-rc2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:48 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Should I work on changing this?

I don't personally much care, but the pr-tracker-bot clearly does.

If you don't care about the automated "it's been pulled" message, that
doesn't matter, of course.

That said, I'd almost prefer to get just the regular pull request
without the patches. If the complete patch is small, it's often nice
to see that _in_ the pull request (at the bottom), but I don't
generally need or want the individual patches themselves as separate
emails (unless there's some particular reason you want me to comment
on something, or apply them directly as patches).

                   Linus
